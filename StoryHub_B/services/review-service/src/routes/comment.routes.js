const router = require('express').Router();
const db = require('../db');
const { auth } = require('../middleware');

// post

router.post('/:target_type/:id/comments', auth, async (req, res) => {
    try {
        const { komentar } = req.body;

        if (!komentar){
            return res.status(422).json({ isAdaTeks: !!komentar });
        }

        const target_type = req.params.target_type;

        let targetType = 'art'

        if (target_type === 'arts'){
            targetType = 'art';

        } else if (target_type === 'chapters'){
            targetType = 'chapter';

        } else if (target_type === 'reviews'){
            targetType = 'review';
        
        } else if (target_type === 'comments'){
            targetType = 'comment';

        } else {
            return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
        }

        const [[target]] = await db.query(`SELECT * FROM ${targetType}s WHERE id=? LIMIT 1`, [req.params.id]);
        
        if (!target)
            return res.status(404).json({ message: 'Tidak ditemukan.' });

        await db.query('INSERT INTO comments (target_type, target_id, user_id, komentar) VALUES (?,?,?,?)'
            , [targetType, req.params.id, req.user.id, komentar]
        );

        res.status(201).json({ message: "Komentar berhasil ditambahkan." });

    } catch (error) {
        console.error(error);

        res.status(500).json({ 
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.put('/:target_type/:id/comments/:commentId', auth, async (req, res) => {
    try {
        const { komentar } = req.body;

        if (!komentar){
            return res.status(422).json({ isAdaTeks: !!komentar });
        }

        const target_type = req.params.target_type;

        let targetType = 'art'

        if (target_type === 'arts'){
            targetType = 'art';

        } else if (target_type === 'chapters'){
            targetType = 'chapter';

        } else if (target_type === 'reviews'){
            targetType = 'review';
        
        } else if (target_type === 'comments'){
            targetType = 'comment';

        } else {
            return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
        }

        const [[target]] = await db.query(`SELECT * FROM ${targetType}s WHERE id=? LIMIT 1`, [req.params.id]);
        
        if (!target)
            return res.status(404).json({ message: 'Tidak ditemukan.' });

        const [[comment]] = await db.query('SELECT * FROM comments WHERE id=? LIMIT 1', 
            [req.params.commentId]
        );

        if (!comment)
            return res.status(404).json({ message: 'Komentar itu tidak ada.' });

        const [[isPunyaUser]] = await db.query('SELECT * FROM comments WHERE target_type=? AND target_id=? AND user_id=? AND id=?', 
            [targetType, req.params.id, req.user.id, req.params.commentId]
        );

        if (!isPunyaUser) {
            return res.status(403).json({ isPunyaUser: false, message: 'Komentar ini bukan punya kamu.' });
        }

        await db.query(`UPDATE comments SET diedit='(edited)', komentar=? WHERE id=? AND target_type=? AND target_id=? AND user_id=?`,
            [komentar, req.params.commentId, targetType, req.params.id, req.user.id]
        )

        res.status(201).json({ message: "Komentar berhasil diedit." });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.delete('/:target_type/:id/comments/:commentId', auth, async (req, res) => {
    try {

        const target_type = req.params.target_type;

        let targetType = 'art'

        if (target_type === 'arts'){
            targetType = 'art';

        } else if (target_type === 'chapters'){
            targetType = 'chapter';

        } else if (target_type === 'reviews'){
            targetType = 'review';
        
        } else if (target_type === 'comments'){
            targetType = 'comment';

        } else {
            return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
        }

        const [[target]] = await db.query(`SELECT * FROM ${targetType}s WHERE id=? LIMIT 1`, [req.params.id]);
        
        if (!target)
            return res.status(404).json({ message: 'Tidak ditemukan.' });

        const [[comment]] = await db.query('SELECT * FROM comments WHERE id=? LIMIT 1', 
            [req.params.commentId]
        );

        if (!comment)
            return res.status(404).json({ message: 'Komentar itu tidak ada.' });

        const [[isPunyaUser]] = await db.query('SELECT * FROM comments WHERE target_type=? AND target_id=? AND user_id=? AND id=?', 
            [targetType, req.params.id, req.user.id, req.params.commentId]
        );

        if (!isPunyaUser) {
            return res.status(403).json({ isPunyaUser: false, message: 'Komentar ini bukan punya kamu.' });
        }

        await db.query('DELETE FROM comments WHERE id=? AND target_type=? AND target_id=? AND user_id=?', 
            [req.params.commentId, targetType, req.params.id, req.user.id]
        );

        res.status(200).json({ message: 'Komentar kamu sudah dihapus.' });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.get('/:target_type/:id/comments', async (req, res) => {
    try {

        const target_type = req.params.target_type;

        let targetType = 'art'

        if (target_type === 'arts'){
            targetType = 'art';

        } else if (target_type === 'chapters'){
            targetType = 'chapter';

        } else if (target_type === 'reviews'){
            targetType = 'review';
        
        } else if (target_type === 'comments'){
            targetType = 'comment';

        } else {
            return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
        }

        const [[target]] = await db.query(`SELECT * FROM ${targetType}s WHERE id=? LIMIT 1`, [req.params.id]);
        
        if (!target)
            return res.status(404).json({ message: 'Tidak ditemukan.' });

        const [comments] = await db.query(`SELECT comments.*, users.username, users.profile_img,
            COALESCE(likes.total_likes, 0) AS total_likes,
            COALESCE(balasan.total_balasan, 0) AS total_balasan
            FROM comments 
            LEFT JOIN users ON users.id = comments.user_id
            LEFT JOIN (
                SELECT target_id, COUNT(*) AS total_likes
                FROM likes
                WHERE target_type = 'comment'
                GROUP BY target_id
            ) likes ON likes.target_id = comments.id
            LEFT JOIN (
                SELECT target_id, COUNT(*) AS total_balasan
                FROM comments 
                WHERE target_type='comment'
                GROUP BY target_id
            ) balasan ON balasan.target_id = comments.id
            WHERE comments.target_type=? AND comments.target_id=?
            GROUP BY comments.id
            ORDER BY COALESCE(likes.total_likes, 0) DESC`, 
            [targetType, req.params.id]
        );

        const [[total]] = await db.query('SELECT COUNT(*) AS total_comments FROM comments WHERE target_type=? AND target_id=?',
            [targetType, req.params.id]
        );

        if (comments.length < 1)
            return res.status(404).json({ total_comments: total, message: 'Belum ada komentar di sini.' });

        res.json({ data: comments, total_comments: total });
    
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

module.exports = router;