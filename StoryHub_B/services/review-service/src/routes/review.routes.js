const router = require('express').Router();
const db = require('../db');
const { auth } = require('../middleware');
const axios = require('axios');

// post

router.post('/:target_type/:id/reviews', auth, async (req, res) => {
    try {
        let { rating, komentar } = req.body;

        if (!rating || rating < 1 || rating > 10)
            return res.status(422).json({ message: 'Kamu perlu menentukan ratingmu (1-10).' });

        if (!komentar){
            komentar = '';
        }

        const target_type = req.params.target_type;

        let targetType = 'art'

        if (target_type === 'arts'){
            targetType = 'art';

        } else if (target_type === 'chapters'){
            targetType = 'chapter';

        } else {
            return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
        }

        const [[target]] = await db.query(`SELECT * FROM ${targetType}s WHERE id=? LIMIT 1`, [req.params.id]);
        
        if (!target)
            return res.status(404).json({ message: 'Tidak ditemukan.' });

        const [[review]] = await db.query('SELECT * FROM reviews WHERE user_id=? AND target_id=? AND target_type=? LIMIT 1', [req.user.id, req.params.id, targetType]);

        if (review)
            return res.status(403).json({ message: 'Kamu tidak bisa mereview dua kali.' });

        await db.query('INSERT INTO reviews (target_type, target_id, user_id, rating, komentar) VALUES (?,?,?,?,?)'
            , [targetType, req.params.id, req.user.id, rating, komentar]
        );

        res.status(201).json({ message: "Review berhasil ditambahkan." });

    } catch (error) {
        console.error(error);

        res.status(500).json({ 
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.put('/:target_type/:id/reviews/:reviewId', auth, async (req, res) => {
    try {
        let { rating, komentar } = req.body;

        if (!rating || rating < 1 || rating > 10)
            return res.status(422).json({ message: 'Kamu perlu menentukan ratingmu (antara 1-10).' });

        if (!komentar){
            komentar = '';
        }

        const target_type = req.params.target_type;

        let targetType = 'art'

        if (target_type === 'arts'){
            targetType = 'art';

        } else if (target_type === 'chapters'){
            targetType = 'chapter';

        } else {
            return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
        }

        const [[target]] = await db.query(`SELECT * FROM ${targetType}s WHERE id=? LIMIT 1`, [req.params.id]);
        
        if (!target)
            return res.status(404).json({ message: 'Tidak ditemukan.' });

        const [[review]] = await db.query('SELECT * FROM reviews WHERE id=? LIMIT 1', 
            [req.params.reviewId]
        );

        if (!review)
            return res.status(404).json({ message: 'Review itu tidak ada.' });

        const [[isPunyaUser]] = await db.query('SELECT * FROM reviews WHERE target_type=? AND target_id=? AND user_id=? LIMIT 1', 
            [targetType, req.params.id, req.user.id]
        );

        if (!isPunyaUser) {
            return res.status(403).json({ isPunyaUser: false, message: 'Review itu bukan punya kamu.' });
        }

        await db.query(`UPDATE reviews SET diedit='(edit)', rating=?, komentar=? WHERE id=? AND target_type=? AND target_id=? AND user_id=?`,
            [rating, komentar, req.params.reviewId, targetType, req.params.id, req.user.id]
        )

        res.status(201).json({ message: "Review berhasil diperbaharui." });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.delete('/:target_type/:id/reviews/:reviewId', auth, async (req, res) => {
    try {

        const target_type = req.params.target_type;

        let targetType = 'art'

        if (target_type === 'arts'){
            targetType = 'art';

        } else if (target_type === 'chapters'){
            targetType = 'chapter';

        } else {
            return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
        }

        const [[target]] = await db.query(`SELECT * FROM ${targetType}s WHERE id=? LIMIT 1`, [req.params.id]);
        
        if (!target)
            return res.status(404).json({ message: 'Tidak ditemukan.' });

        const [[review]] = await db.query('SELECT * FROM reviews WHERE id=? LIMIT 1', 
            [req.params.reviewId]
        );

        if (!review)
            return res.status(404).json({ message: 'Review itu tidak ada.' });

        const [[isPunyaUser]] = await db.query('SELECT * FROM reviews WHERE target_type=? AND target_id=? AND user_id=? LIMIT 1', 
            [targetType, req.params.id, req.user.id]
        );

        if (!isPunyaUser) {
            return res.status(403).json({ isPunyaUser: false, message: 'Review itu bukan punya kamu.' });
        }

        await db.query('DELETE FROM reviews WHERE id=? AND target_type=? AND target_id=? AND user_id=?', 
            [req.params.reviewId, targetType, req.params.id, req.user.id]
        );

        res.status(200).json({ message: 'Review berhasil dihapus.' });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

// Cek apakah user sudah review

router.get('/:target_type/:id/is-reviewed', auth, async (req, res) => {
    try {

        const target_type = req.params.target_type;

            let targetType = 'art'

            if (target_type === 'arts'){
                targetType = 'art';

            } else if (target_type === 'chapters'){
                targetType = 'chapter';

            } else {
                return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
            }
        
        const [[target]] = await db.query(`SELECT * FROM ${targetType}s WHERE id=? LIMIT 1`, [req.params.id]);
                
        if (!target)
            return res.status(404).json({ message: 'Tidak ditemukan.' });

        const [[review]] = await db.query('SELECT * FROM reviews WHERE target_type=? AND target_id=? AND user_id=? LIMIT 1', 
            [targetType, req.params.id, req.user.id]
        );

        return res.json({ isSudahReview: !!review });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.get('/:target_type/:id/reviews', async (req, res) => {
    try {

        const target_type = req.params.target_type;

        let targetType = 'art'

        if (target_type === 'arts'){
            targetType = 'art';

        } else if (target_type === 'chapters'){
            targetType = 'chapter';

        } else {
            return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
        }

        const [[target]] = await db.query(`SELECT * FROM ${targetType}s WHERE id=? LIMIT 1`, [req.params.id]);
                
        if (!target)
            return res.status(404).json({ message: 'Tidak ditemukan.' });

        const [reviews] = await db.query(`SELECT reviews.*, users.username, users.profile_img,
                    COALESCE(likes.total_likes, 0) AS total_likes,
                    COALESCE(balasan.total_balasan, 0) AS total_balasan
                    FROM reviews 
                    LEFT JOIN users ON users.id = reviews.user_id
                    LEFT JOIN (
                        SELECT target_id, COUNT(*) AS total_likes
                        FROM likes
                        WHERE target_type = 'review'
                        GROUP BY target_id
                    ) likes ON likes.target_id = reviews.id
                    LEFT JOIN (
                        SELECT target_id, COUNT(*) AS total_balasan
                        FROM comments 
                        WHERE target_type='review'
                        GROUP BY target_id
                    ) balasan ON balasan.target_id = reviews.id
                    WHERE reviews.target_type=? AND reviews.target_id=?
                    GROUP BY reviews.id
                    ORDER BY COALESCE(likes.total_likes, 0) DESC`, 
                    [targetType, req.params.id]
                );

        const [[total]] = await db.query('SELECT COUNT(*) AS total_reviews FROM reviews WHERE target_type=? AND target_id=?',
            [targetType, req.params.id]
        );

        if (reviews.length < 1)
            return res.status(404).json({ total_reviews: total, message: 'Belum ada yang mereview di sini. Jadilah yang pertama menilai karya ini.' });

        res.json({ data: reviews, total_reviews: total.total_reviews });
    
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});


// like review dan komentar

router.post('/:artOrChapter/:artOrChapterId/:target_type/:targetId', auth, async (req, res) => {
    try {
        // cek artOrChapter

        const art_or_chapter = req.params.artOrChapter;

        let artOrChapter = 'art'

        if (art_or_chapter === 'arts'){
            artOrChapter = 'art';

        } else if (art_or_chapter === 'chapters'){
            artOrChapter = 'chapter';

        } else {
            return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
        }

        const [[artChapter]] = await db.query(`SELECT * FROM ${artOrChapter}s WHERE id=? LIMIT 1`, [req.params.artOrChapterId]);

        if (!artChapter)
            return res.status(404).json({ message: 'Tidak ditemukan.' });


        // cek target_type

        const target_type = req.params.target_type;

        let targetType = 'review'

        if (target_type === 'reviews'){
            targetType = 'review';

        } else if (target_type === 'comments'){
            targetType = 'comment';

        } else {
            return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
        }

        const [[target]] = await db.query(`SELECT * FROM ${targetType}s WHERE id=? LIMIT 1`, [req.params.targetId]);
        
        if (!target)
            return res.status(404).json({ message: 'Tidak ditemukan.' });

        await db.query('INSERT INTO likes (target_type, target_id, user_id) VALUES (?,?,?)',
            [targetType, req.params.targetId, req.user.id]
        );

        res.status(201).json({ message: "Like berhasil ditambahkan." });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.delete('/:artOrChapter/:artOrChapterId/:target_type/:targetId', auth, async (req, res) => {
    try {
        // cek artOrChapter

        const art_or_chapter = req.params.artOrChapter;

        let artOrChapter = 'art'

        if (art_or_chapter === 'arts'){
            artOrChapter = 'art';

        } else if (art_or_chapter === 'chapters'){
            artOrChapter = 'chapter';

        } else {
            return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
        }

        const [[artChapter]] = await db.query(`SELECT * FROM ${artOrChapter}s WHERE id=? LIMIT 1`, [req.params.artOrChapterId]);

        if (!artChapter)
            return res.status(404).json({ message: 'Tidak ditemukan.' });


        // cek target_type

        const target_type = req.params.target_type;

        let targetType = 'review'

        if (target_type === 'reviews'){
            targetType = 'review';

        } else if (target_type === 'comments'){
            targetType = 'comment';

        } else {
            return res.status(422).json({ message: 'Ada kesalahan dalam input.' })
        }

        const [[target]] = await db.query(`SELECT * FROM ${targetType}s WHERE id=? LIMIT 1`, [req.params.targetId]);
        
        if (!target)
            return res.status(404).json({ message: 'Tidak ditemukan.' });

        await db.query('DELETE FROM likes WHERE target_type=? AND target_id=? AND user_id=?',
            [targetType, req.params.targetId, req.user.id]
        );

        res.status(200).json({ message: 'Berhasil unlike.' });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

// cek user udah like atau belum
router.get('/:artOrChapter/:artOrChapterId/:target_type/:targetId/is-liked', auth, async (req, res) => {
    try {
        const target_type = req.params.target_type;
        let targetType = target_type === 'reviews' ? 'review' : target_type === 'comments' ? 'comment' : null;
        if (!targetType) return res.status(422).json({ message: 'Input tidak valid.' });

        const [[like]] = await db.query(
            'SELECT id FROM likes WHERE target_type=? AND target_id=? AND user_id=? LIMIT 1',
            [targetType, req.params.targetId, req.user.id]
        );

        res.json({ isLiked: !!like });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Terdapat kesalahan pada server.' });
    }
});

module.exports = router;