const router = require('express').Router();
const db = require('../db');
const { auth, authGetFilter, requireRole } = require('../middleware');
const { publish } = require('../publisher');
const multer = require('multer');
const path = require('path');
const fs = require('fs');

function jadiNameTag(text) {
    return text.toLowerCase().trim().replace(/\s+/g, '-').replace(/[^\w\-]+/g, '');
}

router.get('/arts/myarts', auth, async (req, res) => {
    
    try {
        const is_published = req.query.ispublished;
        const usernameUserLain = req.query.usernameUserLain;

        let arts = [];

        let userId = req.user.id;

        if (usernameUserLain) {
            const [[userLain]] = await db.query('SELECT id FROM users WHERE username=? LIMIT 1', [usernameUserLain]);

            userId = userLain.id;
        }


        if (is_published === 'published') {
            [arts] = await db.query(`SELECT * FROM arts WHERE authorOrDev_id=? AND isPublished='Published'`, 
                [userId]
            );

        } else if (is_published === 'draft') {
            [arts] = await db.query(`SELECT * FROM arts WHERE authorOrDev_id=? AND isPublished='Draft'`, 
                [userId]
            );

        } else {
            [arts] = await db.query(`SELECT * FROM arts WHERE authorOrDev_id=?`, 
                [userId]
            );
        }

        res.json({ data: arts });
        
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

// continue reading
router.get('/arts/continue_reading', auth, async (req, res) => {
    try {
        const usernameUserLain = req.query.usernameUserLain;

        let userId = req.user.id;

        if (usernameUserLain) {
            const [[userLain]] = await db.query('SELECT id FROM users WHERE username=? LIMIT 1', [usernameUserLain]);

            userId = userLain.id;
        }

        const [arts] = await db.query(`SELECT arts.*, arts.id AS art_id, reading_history.latest_chapter_id, reading_history.art_id AS rh_art_id, ROUND((user_chapter.chapter_order / total_chapter.total_chapter) * 100, 0) AS progress_percent, genres.genre_id, genres.genre
            FROM reading_history
            INNER JOIN arts 
            ON arts.id = reading_history.art_id
            LEFT JOIN (
                SELECT chapters.id, chapters.art_id, chapters.chapter_number,

                    ROW_NUMBER() OVER (
                        PARTITION BY chapters.art_id
                        ORDER BY chapters.chapter_number ASC, chapters.id ASC
                    ) AS chapter_order

                FROM chapters
            ) user_chapter
            ON user_chapter.id = reading_history.latest_chapter_id
            LEFT JOIN (
                SELECT 
                    art_id, 
                    COUNT(*) AS total_chapter
                FROM chapters
                GROUP BY art_id
            ) total_chapter
            ON total_chapter.art_id = arts.id
            LEFT JOIN (
                SELECT art_genres.art_id, MIN(genres.id) AS genre_id, MIN(genres.genre) AS genre
                FROM art_genres
                LEFT JOIN genres ON genres.id = art_genres.genre_id
                GROUP BY art_genres.art_id
            ) genres
            ON genres.art_id = arts.id

            WHERE reading_history.user_id=?

            ORDER BY reading_history.updated DESC
        `, 
        [userId]);

        res.json({ data: arts  });

    } catch (error) {

        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
})

router.get('/arts/:id', async (req, res) => {
    
    try {
        const [[arts]] = await db.query(`
            SELECT arts.*,
                COALESCE(MAX(ar.rata2_rating), 0) AS rata2_rating,
                COALESCE(MAX(ar.total_reviews), 0) AS total_reviews,
                COALESCE(MAX(cr.rata2_rating), 0) AS rata2_rating_ch,
                COALESCE(MAX(cr.total_reviews), 0) AS total_reviews_ch
            FROM arts
            LEFT JOIN (
                SELECT target_id, AVG(rating) AS rata2_rating, COUNT(*) AS total_reviews
                FROM reviews WHERE target_type = 'art' GROUP BY target_id
            ) ar ON ar.target_id = arts.id
            LEFT JOIN (
                SELECT chapters.art_id, ROUND(AVG(reviews.rating),2) AS rata2_rating, COUNT(*) AS total_reviews
                FROM reviews
                LEFT JOIN chapters ON reviews.target_id = chapters.id
                WHERE reviews.target_type = 'chapter'
                GROUP BY chapters.art_id
            ) cr ON cr.art_id = arts.id
            WHERE arts.id = ?
            GROUP BY arts.id
        `, [req.params.id]);

        if (!arts) {
            return res.status(404).json({ data: null, message: "Art tidak ada" })
        }
        
        res.json({ data: arts });
        
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.get('/arts/:id/genres', async (req, res) => {
    try {
        const [genres] = await db.query(
            `SELECT genres.genre FROM genres 
            JOIN art_genres ON art_genres.genre_id = genres.id 
            WHERE art_genres.art_id = ?`, 
            [req.params.id]
        );
        res.json({ data: genres });
        
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.get('/arts/:id/tags', async (req, res) => {
    try {
        const [tags] = await db.query(
            `SELECT tags.tag FROM tags 
            JOIN art_tags ON art_tags.tag_id = tags.id 
            WHERE art_tags.art_id = ?`, 
            [req.params.id]
        );
        res.json({ data: tags });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.get('/arts/:id/moods', async (req, res) => {
    try {
        const [moods] = await db.query(
            `SELECT moods.mood FROM moods 
            JOIN art_moods ON art_moods.mood_id = moods.id 
            WHERE art_moods.art_id = ?`, 
            [req.params.id]
        );
        res.json({ data: moods });
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.get('/arts/users/:username/canvas', authGetFilter, async (req, res) => {
    
    try {
        const [user] = await db.query('SELECT id FROM users WHERE username=? LIMIT 1', [req.params.username]);

        let arts = [];

        if (user.length > 0) {
            [arts] = await db.query(`SELECT * FROM arts WHERE authorOrDev_id=? AND isPublished='Published'`, [user[0].id]);
        
        } else {
            return res.status(404).json({ message: 'User itu tidak ada.' });
        }

        res.json({ data: arts });
        
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

// Get
router.get('/arts', authGetFilter, async (req, res) => {
    try {

        // pagination (10 data per hal/setting sendiri = ?page=1&limit=5 + filter genre = ?genre=Drama, gabung ?page=1&limit=5&genre=Romance)
        let page = Math.max(1, parseInt(req.query.page) || 1);  // min = 1
        const limit = Math.max(1, Math.min(30, parseInt(req.query.limit) || 10));  // maks = 30, min = 3
        const isLogin = !!req.user;

        const categories = req.query.category ? req.query.category.split(',') : [];
        const genres = req.query.genre ? req.query.genre.split(',') : [];
        const tags = req.query.tag ? req.query.tag.split(',') : [];
        const moods = req.query.mood ? req.query.mood.split(',') : [];
        const year = req.query.year;
        const sudahDiReview = req.query.sudahDiReview;  // id_art
        const isCanvas = req.query.isCanvas;
        const nyari = req.query.nyari;
        const usernameUserLain = req.query.usernameUserLain;

        const urutan = req.query.urutan || 'title';

        let  order =  req.query.order === 'ASC' ? 'ASC' : 'DESC';

        if (urutan === 'title') {
            order =  req.query.order === 'DESC' ? 'DESC' : 'ASC';
        }

        let userLain = null;

        if (usernameUserLain) {
            [[userLain]] = await db.query('SELECT id FROM users WHERE username=? LIMIT 1', [usernameUserLain]);
        }

        let sql = '';

        if (isLogin) {
            sql = `SELECT arts.*, 

                        COALESCE(MAX(art_reviews.rata2_rating), 0) AS rata2_rating,
                        COALESCE(MAX(art_reviews.total_reviews), 0) AS total_reviews,

                        COALESCE(MAX(art_user_reviews.rata2_rating), 0) AS rata2_rating_user,
                        COALESCE(MAX(art_user_reviews.total_reviews), 0) AS total_reviews_user,

                        COALESCE(MAX(chapter_user_reviews.rata2_rating), 0) AS rata2_rating_user_ch,
                        COALESCE(MAX(chapter_user_reviews.total_reviews), 0) AS total_reviews_user_ch,

                        COALESCE(MAX(chapter_reviews.rata2_rating), 0) AS rata2_rating_ch,
                        COALESCE(MAX(chapter_reviews.total_reviews), 0) AS total_reviews_ch,

                        MAX(chapter_reviews.chapter_number) AS top_chapter_number,
                        MAX(chapter_user_reviews.chapter_number) AS top_chapter_number_byuser
                    
                    FROM arts

                    LEFT JOIN (
                        SELECT target_id, AVG(rating) AS rata2_rating, COUNT(*) AS total_reviews
                        FROM reviews
                        WHERE target_type = 'art' AND user_id = ?
                        GROUP BY target_id
                    ) art_user_reviews
                    ON art_user_reviews.target_id = arts.id

                    LEFT JOIN (
                        SELECT *
                        FROM (
                            SELECT 
                                t.*,
                                ROW_NUMBER() OVER (
                                    PARTITION BY t.art_id
                                    ORDER BY t.rata2_rating DESC
                                ) AS rn
                            FROM (
                                SELECT 
                                    chapters.art_id,
                                    chapters.id AS chapter_id,
                                    chapters.chapter_number,
                                    ROUND(AVG(reviews.rating), 2) AS rata2_rating,
                                    COUNT(*) AS total_reviews
                                FROM reviews
                                LEFT JOIN chapters 
                                    ON reviews.target_id = chapters.id
                                WHERE reviews.target_type = 'chapter'
                                GROUP BY chapters.art_id, chapters.id, chapters.chapter_number
                            ) t
                        ) ranked
                        WHERE rn = 1
                    ) chapter_reviews
                    ON chapter_reviews.art_id = arts.id

                    LEFT JOIN (
                        SELECT * FROM (
                            SELECT 
                                chapters.art_id,
                                chapters.id AS chapter_id,
                                chapters.chapter_number,
                                ROUND(AVG(reviews.rating), 2) AS rata2_rating,
                                COUNT(*) AS total_reviews,

                                ROW_NUMBER() OVER (
                                    PARTITION BY chapters.art_id
                                    ORDER BY ROUND(AVG(reviews.rating), 2) DESC
                                ) AS rn

                            FROM reviews
                            LEFT JOIN chapters 
                                ON reviews.target_id = chapters.id

                            WHERE reviews.target_type = 'chapter'
                                AND reviews.user_id = ?

                            GROUP BY 
                                chapters.art_id,
                                chapters.id,
                                chapters.chapter_number
                        ) ranked
                        WHERE rn = 1
                    ) chapter_user_reviews
                    ON chapter_user_reviews.art_id = arts.id

                    LEFT JOIN (
                        SELECT target_id, AVG(rating) AS rata2_rating, COUNT(*) AS total_reviews
                        FROM reviews
                        WHERE target_type = 'art'
                        GROUP BY target_id
                    ) art_reviews
                    ON art_reviews.target_id = arts.id
                `;
        } else {
                sql = `SELECT arts.*, 

                        COALESCE(MAX(art_reviews.rata2_rating), 0) AS rata2_rating,
                        COALESCE(MAX(art_reviews.total_reviews), 0) AS total_reviews,

                        COALESCE(MAX(chapter_reviews.rata2_rating), 0) AS rata2_rating_ch,
                        COALESCE(MAX(chapter_reviews.total_reviews), 0) AS total_reviews_ch,

                        MAX(chapter_reviews.chapter_number) AS chapter_number
                    
                    FROM arts

                    LEFT JOIN (
                        SELECT *
                        FROM (
                            SELECT 
                                t.*,
                                ROW_NUMBER() OVER (
                                    PARTITION BY t.art_id
                                    ORDER BY t.rata2_rating DESC
                                ) AS rn
                            FROM (
                                SELECT 
                                    chapters.art_id,
                                    chapters.id AS chapter_id,
                                    chapters.chapter_number,
                                    ROUND(AVG(reviews.rating), 2) AS rata2_rating,
                                    COUNT(*) AS total_reviews
                                FROM reviews
                                LEFT JOIN chapters 
                                    ON reviews.target_id = chapters.id
                                WHERE reviews.target_type = 'chapter'
                                GROUP BY chapters.art_id, chapters.id, chapters.chapter_number
                            ) t
                        ) ranked
                        WHERE rn = 1
                    ) chapter_reviews
                    ON chapter_reviews.art_id = arts.id

                    LEFT JOIN (
                        SELECT target_id, AVG(rating) AS rata2_rating, COUNT(*) AS total_reviews
                        FROM reviews
                        WHERE target_type = 'art'
                        GROUP BY target_id
                    ) art_reviews
                    ON art_reviews.target_id = arts.id
                `;
        }
        
        const where = [];
        const params = [];
        const countParams = [];

        if (isLogin && !usernameUserLain) {
            params.push(req.user.id, req.user.id);
        } else if (usernameUserLain) {
            params.push(userLain.id, userLain.id)
        }

        if (nyari) {
            where.push('arts.title LIKE ?');
            params.push(`%${nyari}%`);
            countParams.push(`%${nyari}%`);
        }

        if (categories.length > 0) {
            where.push(`arts.category IN (${categories.map(() => '?').join(',')})`);

            params.push(...categories);
            countParams.push(...categories);
        }

        if (genres.length > 0) {
            where.push(`
                arts.id IN (
                    SELECT art_genres.art_id
                    FROM art_genres
                    JOIN genres
                        ON genres.id = art_genres.genre_id
                    WHERE genres.genre IN (${genres.map(() => '?').join(',')})
                    GROUP BY art_genres.art_id
                    HAVING COUNT(DISTINCT genres.genre) = ?
                )
            `);

            params.push(...genres, genres.length);
            countParams.push(...genres, genres.length);
        }

        if (tags.length > 0) {
            where.push(`
                arts.id IN (
                    SELECT art_tags.art_id
                    FROM art_tags
                    JOIN tags
                        ON tags.id = art_tags.tag_id
                    WHERE tags.tag IN (${tags.map(() => '?').join(',')})
                    GROUP BY art_tags.art_id
                    HAVING COUNT(DISTINCT tags.tag) = ?
                )
            `);

            params.push(...tags, tags.length);
            countParams.push(...tags, tags.length);
        }

        if (moods.length > 0) {
            where.push(`
                arts.id IN (
                    SELECT art_moods.art_id
                    FROM art_moods
                    JOIN moods
                        ON moods.id = art_moods.mood_id
                    WHERE moods.mood IN (${moods.map(() => '?').join(',')})
                    GROUP BY art_moods.art_id
                    HAVING COUNT(DISTINCT moods.mood) = ?
                )
            `);

            params.push(...moods, moods.length);
            countParams.push(...moods, moods.length);
        }

        if (year) {
            where.push(`YEAR(STR_TO_DATE(arts.published_at, '%b %d, %Y')) = ?`);

            params.push(year);
            countParams.push(year);
        }

        if (sudahDiReview === 'true' && isLogin  && !usernameUserLain) {
            where.push(`
                arts.id IN (
                    SELECT target_id
                    FROM reviews
                    WHERE target_type = 'art'
                    AND user_id = ?
                )
            `);

            params.push(req.user.id);
            countParams.push(req.user.id);
        } else if (sudahDiReview === 'false' && isLogin  && !usernameUserLain) {
            where.push(`
                arts.id NOT IN (
                    SELECT target_id FROM reviews
                    WHERE target_type = 'art' AND user_id = ?
                )
            `);
            params.push(req.user.id);
            countParams.push(req.user.id);

        } else if (sudahDiReview === 'true' && usernameUserLain) {
            where.push(`
                arts.id IN (
                    SELECT target_id
                    FROM reviews
                    WHERE target_type = 'art'
                    AND user_id = ?
                )
            `);

            params.push(userLain.id);
            countParams.push(userLain.id);
        }

        
        if (isCanvas === "Canvas") {
            where.push('arts.is_canvas IS NOT NULL');

        } else if (isCanvas === "Pro") {
            where.push('arts.is_canvas IS NULL');
        }

        where.push(`arts.isPublished = 'Published'`);

        if (where.length > 0) {
            sql += `WHERE ${where.join(' AND ')}`;
        }

        sql += ` GROUP BY arts.id`;


        // sort

        let orderBy = 'arts.title';

        switch (urutan) {
            case 'ratingArt':
                orderBy = 'art_reviews.rata2_rating';
                break;
            case 'ratingArtUser':
                orderBy = isLogin ? 'art_user_reviews.rata2_rating' : 'art_reviews.rata2_rating';
                break;
            case 'ratingChapter':
                orderBy = 'chapter_reviews.rata2_rating';
                break;
            case 'ratingChapterUser':
                orderBy = isLogin ? 'chapter_user_reviews.rata2_rating' : 'chapter_reviews.rata2_rating';
                break;
            case 'reviewersArt':
                orderBy = 'art_reviews.total_reviews';
                break;
            case 'reviewersArtUser':
                orderBy =  isLogin ? 'art_user_reviews.total_reviews' : 'art_reviews.total_reviews';
                break;
            case 'reviewersChapter':
                orderBy = 'chapter_reviews.total_reviews';
                break;
            case 'reviewersChapterUser':
                orderBy = isLogin ? 'chapter_user_reviews.total_reviews' : 'chapter_reviews.total_reviews';
                break;
            case 'chapters':
                orderBy = 'arts.jumlah_chapter';
                break;
            case 'published':
                orderBy = `STR_TO_DATE(arts.published_at, '%b %d, %Y')`;
                break;
            case 'title':
                orderBy = 'arts.title';
                break;
        }

        sql += ` ORDER BY ${orderBy} ${order}, arts.title ASC`;


        // total/jumlah hasil query

        let countSql = ` SELECT COUNT(DISTINCT arts.id) AS total 
        
                        FROM arts
                        
                        LEFT JOIN art_genres ON arts.id = art_genres.art_id
                        LEFT JOIN genres ON genres.id = art_genres.genre_id

                        LEFT JOIN art_tags ON arts.id = art_tags.art_id
                        LEFT JOIN tags ON tags.id = art_tags.tag_id

                        LEFT JOIN art_moods ON arts.id = art_moods.art_id
                        LEFT JOIN moods ON moods.id = art_moods.mood_id
                    `;
        
        if (where.length > 0) {

            countSql += ` WHERE ${where.join(' AND ')}`;
        }

        const [countRows] = await db.query(countSql, countParams); 
        
        const total = countRows[0].total;
        
        const totalPages = Math.max(1, Math.ceil(total / limit));
        
        page = Math.min(page, Math.max(totalPages, 1));  // maks page = totalPages, maks totalPages = 1
        
        const offset = (page - 1) * limit;
        
                
        // page
        
        sql += ' LIMIT ? OFFSET ?';
        
        const paramss = [...params, limit, offset];


        // eksekusi query

        const [arts] = await db.query(sql, paramss);

        res.json({
            data: arts,

            meta: {
                page,
                limit,
                total,
                total_pages: totalPages
            }
        });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Error pada servis/database art (novel.routes)'
        });
    }
});


// buat post & put cover dan banner img art novel canvas

const artImageStorage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, path.join(__dirname, `../../../../image/coverArt`));
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname);
    }
});

const uploadArt = multer({ storage: artImageStorage });


// Post
router.post('/arts', auth, uploadArt.fields([{ name: 'cover_img', maxCount: 1 }, { name: 'banner_img', maxCount: 1 }]), async (req, res) => {
    try {
        const {isPublished, title, status, category, synopsis, tagline, genres = [], tags = [], moods = []} = req.body;

        const coverImgPath = req.files?.cover_img?.[0]
            ? `coverArt/${req.files.cover_img[0].filename}`
            : req.body.cover_img || '';

        const bannerImgPath = req.files?.banner_img?.[0]
            ? `coverArt/${req.files.banner_img[0].filename}`
            : req.body.banner_img || '';

        if (!isPublished || !title || !coverImgPath || !bannerImgPath || !status || !category || !synopsis || !tagline) 
            return res.status(422).json({message: 'Semua input harus diisi.'});

        const nametag = jadiNameTag(title); // judul jadi slug ("Solo Leveling" -> "solo_leveling")

        const author = req.user.username;

        const [insert] = await db.query(`INSERT INTO arts (authorOrDev_id, is_canvas, isPublished, title, nametag, cover_img, banner_img, authorOrDev, status, category, tagline, synopsis, published_at) 
                                        
                                        VALUES (?,1,?,?,?,?,?,?,?,?,?,?, DATE_FORMAT(NOW(), '%b %d, %Y'))`, 

                                    [req.user.id, isPublished, title, nametag, coverImgPath, bannerImgPath, author, status, category, tagline, synopsis]);
        
        const artId = insert.insertId;

        let finalCoverPath = '';
        let finalBannerPath = '';

        if (req.files?.cover_img?.[0]) {
            const coverName = `cover_${req.user.id}_${artId}.jpg`;

            fs.renameSync(
                req.files.cover_img[0].path,
                path.join(
                    __dirname,
                    '../../../../image/coverArt',
                    coverName
                )
            );

            finalCoverPath = `coverArt/${coverName}`;
        }

        if (req.files?.banner_img?.[0]) {
            const bannerName = `banner_${req.user.id}_${artId}.jpg`;

            fs.renameSync(
                req.files.banner_img[0].path,
                path.join(
                    __dirname,
                    '../../../../image/coverArt',
                    bannerName
                )
            );

            finalBannerPath = `coverArt/${bannerName}`;
        }

        await db.query(`UPDATE arts SET cover_img=?, banner_img=? WHERE id=?`, [
            finalCoverPath, finalBannerPath, artId]
        );
        
        // genre, tag, dan mood

        for (const genre of genres) {
            const [genresId] = await db.query('SELECT id from genres WHERE genre=?', [genre]);

            if (genresId.length > 0) {
                await db.query('INSERT INTO art_genres (art_id, genre_id) VALUES (?, ?)', [artId, genresId[0].id]);
            }
        }

        for (const tag of tags) {
            const [tagsId] = await db.query('SELECT id from tags WHERE tag=?', [tag]);

            if (tagsId.length > 0) {
                await db.query('INSERT INTO art_tags (art_id, tag_id) VALUES (?, ?)', [artId, tagsId[0].id]);
            }
        }

        for (const mood of moods) {
            const [moodsId] = await db.query('SELECT id from moods WHERE mood=?', [mood]);

            if (moodsId.length > 0) {
                await db.query('INSERT INTO art_moods (art_id, mood_id) VALUES (?, ?)', [artId, moodsId[0].id]);
            }
        }

        res.status(201).json({ message: `${category} ${title} berhasil dibuat.`, art_id: artId });

    } catch (error) {
        console.error(error);

        res.status(500).json({ message: 'Post art error (novel service, novel.routes)'});
    }
});

// Put
router.put('/arts/:id', uploadArt.fields([{ name: 'cover_img', maxCount: 1 }, { name: 'banner_img', maxCount: 1 }]), auth, async (req, res) => {

    try {
        const {isPublished, title, status, category, synopsis, tagline, genres = [], tags = [], moods = []} = req.body;

        const [[art]] = await db.query('SELECT * FROM arts WHERE id=? AND is_canvas = 1', [req.params.id]);

        if (!art)
            return res.status(404).json({ message: `${category} tidak ada atau bukan punya kamu.` });

        if (art.authorOrDev_id !== req.user.id)
            return res.status(403).json({ message: `Itu bukan ${category} kamu.` });

        let coverImgPath = art.cover_img;
        let bannerImgPath = art.banner_img;

        if (req.files?.cover_img?.[0]) {
            const coverName = `cover_${req.user.id}_${req.params.id}.jpg`;

            fs.renameSync(
                req.files.cover_img[0].path,
                path.join(__dirname, '../../../../image/coverArt', coverName)
            );

            coverImgPath = `coverArt/${coverName}`;
        }

        if (req.files?.banner_img?.[0]) {
            const bannerName = `banner_${req.user.id}_${req.params.id}.jpg`;

            fs.renameSync(
                req.files.banner_img[0].path,
                path.join(__dirname, '../../../../image/coverArt', bannerName)
            );

            bannerImgPath = `coverArt/${bannerName}`;
        }

        const nametag = jadiNameTag(title); 

        db.query(`UPDATE arts SET isPublished=?, title=?, nametag=?, cover_img=?, banner_img=?, status=?, category=?, tagline=?, synopsis=? WHERE id=?`, 

                                    [isPublished, title, nametag, coverImgPath, bannerImgPath, status, category, tagline, synopsis, req.params.id]);
        
        
        // hapus genre, tag, dan mood yang lama dulu

        if (genres.length > 0) {
            await db.query('DELETE FROM art_genres WHERE art_id = ?', [req.params.id]);
        }

        if (tags.length > 0) {
            await db.query('DELETE FROM art_tags WHERE art_id = ?', [req.params.id]);
        }

        if (moods.length > 0) {
            await db.query('DELETE FROM art_moods WHERE art_id = ?', [req.params.id]);
        }

        // insert genre, tag, dan mood baru

        for (const genre of genres) {
            const [genresId] = await db.query('SELECT id from genres WHERE genre=?', [genre]);

            if (genresId.length > 0) {
                await db.query('INSERT INTO art_genres (art_id, genre_id) VALUES (?, ?)', [req.params.id, genresId[0].id]);
            }
        }

        for (const tag of tags) {
            const [tagsId] = await db.query('SELECT id from tags WHERE tag=?', [tag]);

            if (tagsId.length > 0) {
                await db.query('INSERT INTO art_tags (art_id, tag_id) VALUES (?, ?)', [req.params.id, tagsId[0].id]);
            }
        }

        for (const mood of moods) {
            const [moodsId] = await db.query('SELECT id from moods WHERE mood=?', [mood]);

            if (moodsId.length > 0) {
                await db.query('INSERT INTO art_moods (art_id, mood_id) VALUES (?, ?)', [req.params.id, moodsId[0].id]);
            }
        }

        res.status(201).json({ message: `${category} ${title} berhasil diupdate.`, art_id: req.params.id });

    } catch (error) {
        console.error(error);

        res.status(500).json({ message: 'Put art error (novel service, novel.routes)'});
    }

});

// Delete
router.delete('/arts/:id', auth, async (req, res) => {
    try {
        const [[art]] = await db.query('SELECT * FROM arts WHERE id=?', [req.params.id]);

        if (!art) 
            return res.status(404).json({message: `Art tidak ada.`});

        if (art.authorOrDev_id !== req.user.id)
            return res.status(403).json({message: `Itu bukan ${art.category} kamu.`});

        await db.query('DELETE FROM arts WHERE id=?', [req.params.id]);
        
        res.status(200).json({ message: `${art.category} ${art.title} berhasil dihapus.`});
    } catch (error) {
        console.error(error);

        res.status(500).json({ message: 'Delete art error (novel service, novel.routes)'});
    }
});

router.get('/genre', async (req, res) => {
    const [genre] = await db.query('SELECT * FROM genres ORDER BY genre ASC;');

    res.json({ data: genre });
});

router.get('/tag', async (req, res) => {
    const [tag] = await db.query('SELECT * FROM tags ORDER BY tag ASC;');

    res.json({ data: tag });
});

router.get('/mood', async (req, res) => {
    const [mood] = await db.query('SELECT * FROM moods ORDER BY mood ASC;');

    res.json({ data: mood });
});

router.get('/bookmark', auth, async (req, res) => {
    try {
        const category = req.query.category;

        let sql = '';
        let params = [req.user.id];

        if (category === 'chapter') {
            sql = `SELECT chapters.* FROM chapters
                        LEFT JOIN bookmark ON chapters.id = bookmark.target_id
                        WHERE bookmark.user_id = ?
                        AND bookmark.target_type = 'Chapter'`;

        } else if (category === 'novel') {
            sql = `SELECT arts.* FROM arts
                        LEFT JOIN bookmark ON arts.id = bookmark.target_id
                        WHERE bookmark.user_id = ?
                        AND bookmark.target_type = 'Novel'`;

        } else if (category === 'manga') {
            sql = `SELECT arts.* FROM arts
                        LEFT JOIN bookmark ON arts.id = bookmark.target_id
                        WHERE bookmark.user_id = ?
                        AND bookmark.target_type = 'Manga'`;

        } else if (category === 'manhwa') {
            sql = `SELECT arts.* FROM arts
                        LEFT JOIN bookmark ON arts.id = bookmark.target_id
                        WHERE bookmark.user_id = ?
                        AND bookmark.target_type = 'Manhwa'`;

        } else if (category === 'comic') {
            sql = `SELECT arts.* FROM arts
                        LEFT JOIN bookmark ON arts.id = bookmark.target_id
                        WHERE bookmark.user_id = ?
                        AND bookmark.target_type IN ('Manga', 'Manhwa', 'Comic')`;

        } else if (category === 'game') {
            sql = `SELECT arts.* FROM arts
                        LEFT JOIN bookmark ON arts.id = bookmark.target_id
                        WHERE bookmark.user_id = ?
                        AND bookmark.target_type IN ('Game', 'Visual Novel', 'Story Game')`;

        } else {
            sql = `SELECT arts.* FROM arts
                        LEFT JOIN bookmark ON arts.id = bookmark.target_id
                        WHERE bookmark.user_id = ?`;
        }

        const [bookmark] = await db.query(sql, params);
        res.json({ data: bookmark });

    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Terdapat kesalahan pada server.' });
    }
});

router.post('/arts/:id/bookmark', auth, async (req, res) => {
    try {
        const [art] = await db.query('SELECT category FROM arts WHERE id=?', [req.params.id]);

        await db.query(`INSERT INTO bookmark (user_id, target_id, target_type)
                        VALUE (?,?,?)`, [req.user.id, req.params.id, art[0].category]);
        
        res.json({ message: 'Berhasil ditambah ke bookmark!'});
                        
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.post('/chapters/:id/bookmark', auth, async (req, res) => {
    try {
        await db.query(`INSERT INTO bookmark (user_id, target_id, target_type)
                        VALUE (?,?,'Chapter')`, [req.user.id, req.params.id]);
    
        res.json({ message: 'Berhasil ditambah ke bookmark!'});

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.delete('/arts/:id/bookmark', auth, async (req, res) => {
    try {
        const [art] = await db.query('SELECT category FROM arts WHERE id=?', [req.params.id]);

        await db.query(`DELETE FROM bookmark WHERE user_id=? AND target_id=? AND target_type=?`, [req.user.id, req.params.id, art[0].category]);
        
        res.json({ message: 'Berhasil dihapus dari bookmark!'});
                        
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.delete('/chapters/:id/bookmark', auth, async (req, res) => {
    try {
        await db.query(`DELETE FROM bookmark WHERE user_id=? AND target_id=? AND target_type='Chapter'`, [req.user.id, req.params.id]);
        
        res.json({ message: 'Berhasil dihapus dari bookmark!'});
                        
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

module.exports = router;