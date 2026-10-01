const router = require('express').Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const axios = require('axios');
const {v4: uuid} = require('uuid');
const db = require('./db');
const {auth, authGetFilter} = require('./middleware');
const multer = require('multer');
const path = require('path');
require('dotenv').config();

function makeTokens(user) {
    const access = jwt.sign(
        { id: user.id, email: user.email, role: user.role, username: user.username },
        process.env.JWT_SECRET,
        { expiresIn: process.env.JWT_EXPIRES }
    );

    const refresh = jwt.sign(
        { id: user.id },
        process.env.REFRESH_SECRET,
        { expiresIn: process.env.REFRESH_EXPIRES }
    );

    return {access, refresh};
}

// registrasi user
router.post('/register', async (req, res) => {
    const { name, username, email, password, role } = req.body;

    if (!name || !username || !email || !password)
        return res.status(422).json({ message: 'Nama, username, email, dan password harus diisi.' });

    if (/\s/.test(username)) {
        return res.status(422).json({ message: 'Pastikan username-mu tanpa spasi.' });
    }

    try {
        const hash = await bcrypt.hash(password, 10);
        const [r] = await db.query('INSERT INTO users (name,username,email,password,role) VALUES (?,?,?,?,?)', [name, username, email, hash, role || 'user']);

        res.status(201).json({ message: 'Registrasi berhasil.', user_id: r.insertId });
    } catch (e) {
        if (e.code === 'ER_DUP_ENTRY')
            return res.status(409).json({ message: 'Email atau username sudah dipakai.' });

        res.status(500).json({message: e.message});
    }
});

// login user
router.post('/login', async (req, res) => {
    const {email, password} = req.body;

    if (!email || !password)
        return res.status(422).json({ message: 'Email dan password harus diisi.' });

    try {
        const [[user]] = await db.query('SELECT * FROM users WHERE email=?', [email]);

        if (!user) 
            return res.status(401).json({ message: 'Email atau password salah.' });

        const ok = await bcrypt.compare(password, user.password);

        if (!ok) 
            return res.status(401).json({ message: 'Email atau password salah.' });

        const {access, refresh} = makeTokens(user);

        // 7 hari kadaluarsa
        const exp = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000);

        await db.query('INSERT INTO refresh_tokens (user_id,token,expires_at) VALUES (?,?,?)', [user.id, refresh, exp]);

        res.json({
            access_token: access,
            refresh_token: refresh,
            user: {id: user.id, username: user.username, email: user.email, role: user.role, profile_img: user.profile_img}
        });
    } catch (e) { res.status(500).json({ message: e.message }); }
});

// refresh token jwt
router.post('/refresh', async (req, res) => {
    const {refresh_token} = req.body;

    if (!refresh_token) 
        return res.status(422).json({ message: 'Refresh token harus diisi.' });

    try {
        const [[stored]] = await db.query('SELECT * FROM refresh_tokens WHERE token=? AND is_revoked=0 AND expires_at>NOW()', [refresh_token]);

        if (!stored) 
            return res.status(401).json({ message: 'Refresh token tidak sesuai atau sudah kadaluarsa.' });

        const payload = jwt.verify(refresh_token, process.env.REFRESH_SECRET);
        const [[user]] = await db.query('SELECT * FROM users WHERE id=?', [payload.id]);

        await db.query('UPDATE refresh_tokens SET is_revoked=1 WHERE token=?', [refresh_token]);

        const {access, refresh: newRefresh} = makeTokens(user);

        // expired 7 hari
        const exp = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000);

        await db.query('INSERT INTO refresh_tokens (user_id,token,expires_at) VALUES (?,?,?)', [user.id, newRefresh, exp]);

        res.json({ access_token: access, refresh_token: newRefresh });
    } catch (e) { res.status(401).json({ message: 'Refresh token tidak sesuai.' }); }
});

// logout 
router.post('/logout', auth, async (req, res) => {
    const { refresh_token } = req.body;

    // is_revoked jadi 1 (gak berlaku lagi)
    if (refresh_token)
        await db.query('UPDATE refresh_tokens SET is_revoked=1 WHERE token=?', [refresh_token]);
    
    res.json({ message: 'Logout berhasil.' });
});

// GET verify
router.get('/verify', auth, (req, res) => {
    res.json({ valid: true, user: req.user });
});

// GET profil
router.get('/users/profile', auth, async (req, res) => {
    
    const [[user]] = await db.query('SELECT id,name,username,email,bio,profile_img FROM users WHERE id=?', [req.user.id]);
    
    res.json({ user });
});


// Edit info profil user

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, path.join(__dirname, '../../../image/profile'));
    },
    filename: (req, file, cb) => {
        const ext = path.extname(file.originalname) || '.jpg';
        cb(null, `user_${req.user.id}${ext}`);
    }
});

const upload = multer({ storage });

router.put('/users/profile', auth, upload.single('profile_img'), async (req, res) => {
    try {
        const { name, username, bio } = req.body;

        if (!name || !username)
            return res.status(422).json({ message: 'Nama dan username wajib diisi.' });

        if (username.length > 20)
            return res.status(422).json({ message: 'Username tidak boleh lebih dari 20 huruf.' });
        if (name.length > 40)
            return res.status(422).json({ message: 'Nama tidak boleh lebih dari 40 huruf.' });
        if (bio && bio.length > 80)
            return res.status(422).json({ message: 'Bio tidak boleh lebih dari 80 huruf.' });

        const [isAda] = await db.query(
            'SELECT id FROM users WHERE username=? AND id != ?',
            [username, req.user.id]
        );

        if (/\s/.test(username)) {
            return res.status(422).json({ message: 'Pastikan username-mu tanpa spasi.' });
        }

        if (isAda.length > 0)
            return res.status(409).json({ message: 'Username sudah dipakai.' });

        let profileImgPath = null;
        if (req.file) {
            profileImgPath = `profile/${req.file.filename}`;
        }

        if (profileImgPath) {
            await db.query(
                'UPDATE users SET name=?, username=?, bio=?, profile_img=? WHERE id=?',
                [name, username, bio || '', profileImgPath, req.user.id]
            );
        } else {
            await db.query(
                'UPDATE users SET name=?, username=?, bio=? WHERE id=?',
                [name, username, bio || '', req.user.id]
            );
        }

        const [[user]] = await db.query('SELECT * FROM users WHERE id=?', [req.user.id]);
        res.json({ user });

    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Gagal update profil.' });
    }
});

router.get('/users/search', authGetFilter, async (req, res) => {
    const q = req.query.q || '';
    let [users] = await db.query(
        'SELECT id, name, username, profile_img FROM users WHERE username LIKE ? OR name LIKE ?',
        [`%${q}%`, `%${q}%`]
    );

    if (users.length === 0 && req.user?.id) {
        [users] = await db.query(`
            SELECT DISTINCT u.id, u.name, u.username, u.profile_img
            FROM users u
            LEFT JOIN user_follows fol1 
                ON fol1.following_id = u.id AND fol1.follower_id = ?
            LEFT JOIN user_follows fol2 
                ON fol2.follower_id = u.id AND fol2.following_id = ?
            WHERE fol1.id IS NOT NULL OR fol2.id IS NOT NULL
        `, [req.user.id, req.user.id]);
    }

    if (users.lenght === 0) {
        [users] = await db.query(`
                SELECT users.id, users.name, users.username, users.profile_img
                FROM users
                LEFT JOIN user_follows ON user_follows.following_id = users.id
                GROUP BY users.id
                ORDER BY COUNT(user_follows.id) DESC
            `);
    }

    res.json({ data: users });
});

router.get('/users/:username', async (req, res) => {
    
    const [[user]] = await db.query('SELECT id,name,username,email,bio,profile_img FROM users WHERE username=?', [req.params.username]);
    
    res.json({ user });
});

// Follows User

// Get

router.get('/users/:id/followers', async (req, res) => {
    
    const [follower] = await db.query('SELECT users.id, users.username, users.profile_img FROM user_follows JOIN users ON users.id = user_follows.follower_id WHERE user_follows.following_id = ?', [req.params.id]);
    
    res.json({ data: follower });
});

router.get('/users/:id/following', async (req, res) => {
    
    const [following] = await db.query('SELECT users.id, users.username, users.profile_img FROM user_follows JOIN users ON users.id = user_follows.following_id WHERE user_follows.follower_id = ?', [req.params.id]);
    
    res.json({ data: following });
});

// Follow, Unfollow

router.post('/users/:id/follow', auth, async (req, res) => {
    
    await db.query('INSERT INTO user_follows (follower_id, following_id) VALUES (?, ?)', [req.user.id, req.params.id]);
    
    res.json({ message: "Berhasil follow user" });
});

router.delete('/users/:id/follow', auth, async (req, res) => {
    
    await db.query('DELETE FROM user_follows WHERE follower_id = ? AND following_id = ?', [req.user.id, req.params.id]);
    
    res.json({ message: "Berhasil unfollow user" });
});

// Jumlah follow

router.get('/users/:id/followers/count', async (req, res) => {
    
    const [[user]] = await db.query('SELECT COUNT(*) AS total_follower FROM user_follows WHERE following_id = ?', [req.params.id]);
    
    res.json({ total_follower: user.total_follower });
});

router.get('/users/:id/following/count', async (req, res) => {
    
    const [[user]] = await db.query('SELECT COUNT(*) AS total_following FROM user_follows WHERE follower_id = ?', [req.params.id]);
    
    res.json({ total_following: user.total_following });
});

// Cek apakah user follow suatu user lain (button follow & tampilkan artList user itu)

router.get('/users/:id/isfollow', auth, async (req, res) => {
    
    const [following] = await db.query('SELECT * FROM user_follows WHERE follower_id = ? AND following_id = ?', [req.user.id, req.params.id]);

    const [follower] = await db.query('SELECT * FROM user_follows WHERE following_id = ? AND follower_id = ?', [req.user.id, req.params.id]);
    
    res.json({ isFollowing: !!following[0], isFollower: !!follower[0] });

    // !!follow = kalau ada data berarti true, kalau null berarti false
});


// Subscriptions

router.get('/users/:id/issubscribe', async (req, res) => {
    
    const [subscribe] = await db.query('SELECT * FROM subscriptions WHERE user_id = ? AND end_date > NOW() LIMIT 1', [req.params.id]);
    
    res.json({ isSubscribe: !!subscribe[0] });
});

router.post('/users/subscribe', auth, async (req, res) => {
    
    const {plan} = req.body;

    let endDate;

    const [activeSubscribe] = await db.query('SELECT * FROM subscriptions WHERE user_id=? AND end_date > NOW() LIMIT 1', [req.user.id])

    endDate = new Date();

    if(activeSubscribe[0]) {
        endDate = new Date(activeSubscribe[0].end_date);
    }

    if (plan === 'monthly') {

        endDate.setMonth(endDate.getMonth() + 1);
        
    } else if (plan === 'yearly') {

        endDate.setFullYear(endDate.getFullYear() + 1);
        
    } else {
        return res.status(400).json({
            message: 'Plan yang diisi tidak benar'
        })
    }
    
    await db.query('INSERT INTO subscriptions (user_id, plan, end_date) VALUES (?, ?, ?)', [req.user.id, plan, endDate]);
    
    res.json({ message: "Berhasil langganan" });
});


module.exports = router;