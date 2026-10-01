const router = require('express').Router({ mergeParams: true });
const db = require('../db');
const { auth, authGetFilter, requireRole } = require('../middleware');
const { publish } = require('../publisher');

// Get daftar chapter
router.get('/arts/:artId/chapters', async (req, res) => {
    let isPublished = req.query.isPublished;
    
    let [chapter] = [];

    if (isPublished === 'Draft') {
        [chapter] = await db.query('SELECT * FROM chapters WHERE art_id=? ORDER BY chapter_number ASC', [req.params.artId]);
    
    } else {

        isPublished = 'Published';

        [chapter] = await db.query('SELECT * FROM chapters WHERE art_id=? AND isPublished=? ORDER BY chapter_number ASC', [req.params.artId, isPublished]);
    }

    res.json({data: chapter});
});

// Get 
router.get('/novel/:artId/chapter/:chapterNumber', authGetFilter, async (req, res) => {

    const [[chapter]] = await db.query('SELECT * FROM chapters WHERE chapter_number=? AND art_id=? LIMIT 1', [req.params.chapterNumber, req.params.artId]);

    if (!chapter) 
        return res.status(404).json({ message: 'Chapter tidak ditemukan.' });

    if (chapter.isPremium) {
        if (!req.user)
            return res.status(403).json({ message: 'Kamu harus berlangganan untuk membuka chapter ini.', isPremium: true });

        const [userSubscribe] = await db.query(
            'SELECT 1 FROM subscriptions WHERE user_id=? AND end_date > NOW() LIMIT 1',
            [req.user.id]
        );

        if (!userSubscribe.length)
            return res.status(403).json({ message: 'Kamu harus berlangganan untuk membuka chapter ini.', isPremium: true });
    }

    if (!req.user || !req.user.id) 
        return res.json({data: chapter});

    await db.query(`UPDATE reading_history SET started_read_at=NOW() WHERE user_id=? AND art_id=?`, [req.user.id, req.params.artId]);

    res.json({data: chapter});
});

// Get my chapter (buat data di edit chapter mywork)
router.get('/arts/:artId/chapter/:chapterNumber', auth, async (req, res) => {

    if (!req.user)
        return res.status(403).json({ message: 'Kamu harus login.' })

    const [[art]] = await db.query('SELECT * FROM arts WHERE id=? AND authoOrDev_id=?', [req.params.artId, req.user.id]);

    const [[chapter]] = await db.query('SELECT * FROM chapters WHERE chapter_number=? AND art_id=? LIMIT 1', [req.params.chapterNumber, req.params.artId]);

    if (!chapter || !art) 
        return res.status(404).json({ message: 'Chapter tidak ditemukan.' });

    res.json({data: chapter});
});


// Get gambarKomik per Halaman

router.get('/comic/:artId/chapter/:chapterNumber', authGetFilter, async (req, res) => {

    const [[chapter]] = await db.query('SELECT * FROM chapters WHERE chapter_number=? AND art_id=?', [req.params.chapterNumber, req.params.artId]);

    if (!chapter) 
        return res.status(404).json({ message: 'Chapter tidak ditemukan.' });

    const [pageNumber] = await db.query('SELECT * FROM chapterPages WHERE chapter_id=?', [chapter.id]);

    if (chapter.isPremium) {
        if (!req.user)
            return res.status(403).json({ message: 'Kamu harus berlangganan untuk membuka chapter ini.', isPremium: true });

        const [userSubscribe] = await db.query(
            'SELECT 1 FROM subscriptions WHERE user_id=? AND end_date > NOW() LIMIT 1',
            [req.user.id]
        );

        if (!userSubscribe.length)
            return res.status(403).json({ message: 'Kamu harus berlangganan untuk membuka chapter ini.', isPremium: true });
    }

    if (!req.user || !req.user.id) 
        return res.json({data: pageNumber});

    await db.query(`UPDATE reading_history SET started_read_at=NOW() WHERE user_id=? AND art_id=?`, [req.user.id, req.params.artId]);

    res.json({data: pageNumber});
});

router.get('/arts/:artId/chapters/:id/pages', async (req, res) => {
    try {
        const [[chapter]] = await db.query(
            'SELECT * FROM chapters WHERE id=? AND art_id=?',
            [req.params.id, req.params.artId]
        );

        if (!chapter)
            return res.status(404).json({ message: 'Chapter tidak ditemukan.' });

        const [pages] = await db.query(
            'SELECT * FROM chapterPages WHERE chapter_id=? ORDER BY page_number ASC',
            [req.params.id]
        );

        res.json({ data: pages });

    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Terdapat kesalahan pada server.' });
    }
});

// Get
router.get('/chapters', authGetFilter, async (req, res) => {
    try {

        // pagination (10 data per hal/setting sendiri = ?page=1&limit=10 + filter genre = ?genre=Drama, gabung ?page=1&limit=5&genre=Romance)
        let page = Math.max(1, parseInt(req.query.page) || 1);  // min = 1
        const limit = Math.max(1, Math.min(30, parseInt(req.query.limit) || 10));  // maks = 30, min = 1
        const isLogin = !!req.user;

        const categories = req.query.category ? req.query.category.split(',') : [];
        const genres = req.query.genre ? req.query.genre.split(',') : [];
        const tags = req.query.tag ? req.query.tag.split(',') : [];
        const moods = req.query.mood ? req.query.mood.split(',') : [];
        const year = req.query.year;
        const sudahDiReview = req.query.sudahDiReview;  // id_art
        const isCanvas = req.query.isCanvas;
        const nyari = req.query.nyari;

        const urutan = req.query.urutan || 'title';

        let order =  req.query.order === 'ASC' ? 'ASC' : 'DESC';

        if (urutan === 'title') {
            order =  req.query.order === 'DESC' ? 'DESC' : 'ASC';
        }

        let sql = '';

        if (isLogin) {
            sql = `SELECT chapters.id, chapters.title AS chapter_title, chapters.chapter_number, arts.id AS art_id, arts.title AS art_title, arts.cover_img,

                        COALESCE(chapter_user_reviews.rata2_rating, 0) AS rata2_rating_user_ch,
                        COALESCE(chapter_user_reviews.total_reviews, 0) AS total_reviews_user_ch,

                        COALESCE(chapter_reviews.rata2_rating, 0) AS rata2_rating_ch,
                        COALESCE(chapter_reviews.total_reviews, 0) AS total_reviews_ch
                    
                    FROM chapters

                    LEFT JOIN arts ON arts.id = chapters.art_id

                    LEFT JOIN (
                        SELECT target_id AS chapter_id, ROUND(AVG(rating), 2) AS rata2_rating, COUNT(*) AS total_reviews
                        FROM reviews
                        WHERE target_type = 'chapter'
                        GROUP BY target_id
                    ) chapter_reviews
                    ON chapter_reviews.chapter_id = chapters.id

                    LEFT JOIN (
                        SELECT target_id AS chapter_id, ROUND(AVG(rating), 2) AS rata2_rating, COUNT(*) AS total_reviews
                        FROM reviews
                        WHERE target_type = 'chapter' AND user_id=?
                        GROUP BY target_id
                    ) chapter_user_reviews
                    ON chapter_user_reviews.chapter_id = chapters.id
                `;
        } else {
                sql = `SELECT chapters.id, chapters.title AS chapter_title, chapters.chapter_number, arts.id AS art_id, arts.title AS art_title, arts.cover_img,

                        COALESCE(chapter_reviews.rata2_rating, 0) AS rata2_rating_ch,
                        COALESCE(chapter_reviews.total_reviews, 0) AS total_reviews_ch
                    
                    FROM chapters

                    LEFT JOIN arts ON arts.id = chapters.art_id

                    LEFT JOIN (
                        SELECT target_id AS chapter_id, ROUND(AVG(rating), 2) AS rata2_rating, COUNT(*) AS total_reviews
                        FROM reviews
                        WHERE target_type = 'chapter'
                        GROUP BY target_id
                    ) chapter_reviews
                    ON chapter_reviews.chapter_id = chapters.id
                `;
        }
        
        const where = [];
        const params = [];

        if (isLogin) {
            params.push(req.user.id);
        }

        if (nyari) {
            where.push('chapters.title LIKE ?');
            params.push(`%${nyari}%`);
        }

        if (categories.length > 0) {
            where.push(`arts.category IN (${categories.map(() => '?').join(',')})`);

            params.push(...categories);
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
        }

        if (year) {
            where.push(`YEAR(STR_TO_DATE(arts.published_at, '%b %d, %Y')) = ?`);

            params.push(year);
        }

        if (sudahDiReview === 'true' && isLogin) {
            where.push(`
                chapters.id IN (
                    SELECT target_id
                    FROM reviews
                    WHERE target_type = 'chapter'
                    AND user_id = ?
                )
            `);

            params.push(req.user.id);
        }

        
        if (isCanvas === "Canvas") {
            where.push('arts.is_canvas IS NOT NULL');

        } else if (isCanvas === "Pro") {
            where.push('arts.is_canvas IS NULL');
        }

        where.push(`chapters.isPublished = 'Published'`);

        if (where.length > 0) {
            sql += `WHERE ${where.join(' AND ')}`;
        }

        sql += ` GROUP BY chapters.id `;


        // sort

        let orderBy = 'chapters.title';

        switch (urutan) {
            case 'ratingChapter':
                orderBy = 'chapter_reviews.rata2_rating';
                break;
            case 'ratingChapterUser':
                orderBy = isLogin ? 'chapter_user_reviews.rata2_rating' : 'chapter_reviews.rata2_rating';
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
                orderBy = `STR_TO_DATE(chapters.published_at, '%b %d, %Y')`;
                break;
            case 'title':
                orderBy = 'chapters.title';
                break;
        }

        sql += ` ORDER BY ${orderBy} ${order}, arts.title ASC, chapters.chapter_number ASC`;


        // total/jumlah hasil query

        let countSql = ` SELECT COUNT(DISTINCT chapters.id) AS total 
        
                        FROM chapters

                        LEFT JOIN arts ON arts.id = chapters.art_id
                        
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

        const [countRows] = await db.query(countSql, params); 

        const total = countRows[0].total;

        const totalPages = Math.max(1, Math.ceil(total / limit));

        page = Math.min(page, Math.max(totalPages, 1));  // maks page = totalPages, maks totalPages = 1

        const offset = (page - 1) * limit;

        
        // page

        sql += ' LIMIT ? OFFSET ?';

        const paramss = [...params, limit, offset];


        // eksekusi query

        const [chapters] = await db.query(sql, paramss);

        res.json({
            data: chapters,

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

// Post
router.post('/arts/:artId/chapters', auth, async (req, res) => {
    const { title, isi_chapter, isPublished } = req.body;

    if (!isi_chapter) 
        return res.status(422).json({ message: 'Isi chapter ini harus diisi.' });

    if (!title) 
        return res.status(422).json({ message: 'Judul harus diisi.' });

    const [[art]] = await db.query('SELECT * FROM arts WHERE id=?', [req.params.artId]);

    if (!art) 
        return res.status(404).json({ message: 'Art tidak ada.' });

    if (art.authorOrDev_id !== req.user.id)
        return res.status(403).json({ message: `Itu bukan ${art.category} kamu.` });

    const [[chapterTerakhir]] = await db.query(`SELECT MAX(chapter_number) AS last_number FROM chapters WHERE art_id=?`, [req.params.artId]);

    const chapter_number = (chapterTerakhir.last_number || 0) + 1;

    let published = "Published";

    if (isPublished === "Draft") {
        published = "Draft"
    }

    const [insert] = await db.query(`INSERT INTO chapters (art_id, is_canvas, isPublished, chapter_number, title, isi_chapter_novel, published_at) VALUES (?,1,?,?,?,?,DATE_FORMAT(NOW(), '%b %d, %Y'))`, 
        [req.params.artId, published, chapter_number, title, isi_chapter]);
    
    if (published === "Published") {
        await db.query('UPDATE arts SET jumlah_chapter=? WHERE id=?', [chapter_number, req.params.artId]);
    }

    res.status(201).json({message: 'Chapter berhasil ditambahkan.', chapter_id: insert.insertId});
});

router.put('/arts/:artId/chapters/:id', auth, async(req, res) => {

    try {
        const {title, isi_chapter, isPublished} = req.body;

        const [[art]] = await db.query('SELECT * FROM arts WHERE id=?', [req.params.artId]);

        if (!art) 
            return res.status(404).json({ message: 'Art tidak ada.' });

        if (art.authorOrDev_id !== req.user.id)
            return res.status(403).json({ message: `Itu bukan ${art.category} kamu.` });

        let published = "Published";

        if (isPublished === "Draft") {
            published = "Draft"
        }

        await db.query('UPDATE chapters SET title=?, isPublished=?, isi_chapter_novel=? WHERE art_id=? AND id=?', [title, published, isi_chapter, req.params.artId, req.params.id]);

        res.status(201).json({message: 'Chapter berhasil diperbaharui.' });

    } catch (error) {

        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

// Delete
router.delete('/arts/:artId/chapters/:id', auth, async (req, res) => {
    try {
        const [[art]] = await db.query('SELECT * FROM arts WHERE id=?', [req.params.artId]);

        if (!art) 
            return res.status(404).json({ message: 'Art tidak ada.' });

        if (art.authorOrDev_id !== req.user.id)
            return res.status(403).json({ message: `Itu bukan ${art.category} kamu.` });

        const [[chapter]] = await db.query('SELECT * FROM chapters WHERE id=? AND art_id=?', [req.params.id, req.params.artId]);

        if (!chapter)
            return res.status(404).json({ message: 'Chapter itu tidak ada' });

        const chapterNumberYgDihapus = chapter.chapter_number;

        await db.query('DELETE FROM chapters WHERE id=? AND art_id=?', [req.params.id, req.params.artId]);

        await db.query(`UPDATE chapters SET chapter_number = chapter_number - 1 WHERE art_id=? AND chapter_number > ?`, [req.params.artId, chapterNumberYgDihapus]);

        const [[chapterTerakhir]] = await db.query(`SELECT MAX(chapter_number) AS last_number FROM chapters WHERE art_id=?`, [req.params.artId]);

        const chapter_number = chapterTerakhir.last_number || 0;

        if (chapter_number === 0) {
            await db.query(`UPDATE arts SET isPublished='Draft' WHERE id=?`, [req.params.artId]);
        }

        await db.query('UPDATE arts SET jumlah_chapter=? WHERE id=?', [chapter_number, req.params.artId]);

        res.status(200).json({ message: "Chapter berhasil dihapus." });

    } catch (error) {

        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

// Cek kategori art

router.get('/arts/:artId/chapters/:id/categories', auth, async (req, res) => {
    
    const [novel] = await db.query('SELECT * FROM arts WHERE id = ? AND arts.category= "Novel"', [req.params.artId]);
    
    res.json({ isNovel: !!novel[0] });

    // !!novel = kalau ada data berarti true, kalau null berarti false
});

router.post('/arts/:artId/chapters/:id/reading_history', auth, async (req, res) => {

    try {
        const {page_number, scroll_position} = req.body;

        await db.query(`INSERT INTO reading_history (user_id, art_id, chapter_id, latest_chapter_id, page_number, scroll_position) 
                        
                        VALUES (?,?,?,?,?,?)
                        
                        ON DUPLICATE KEY UPDATE
                        chapter_id = VALUES(chapter_id),
                        latest_chapter_id = VALUES(latest_chapter_id),
                        page_number = VALUES(page_number),
                        scroll_position = VALUES(scroll_position),
                        updated = CURRENT_TIMESTAMP
                    `, 
                        
                        [req.user.id, req.params.artId, req.params.id, req.params.id, page_number, scroll_position]);

        const [[reading_history]] = await db.query(`SELECT id, latest_chapter_id,
            TIMESTAMPDIFF(
                HOUR, started_read_at, NOW()
            ) AS duration
            FROM reading_history 
            WHERE user_id=? AND art_id=?`, 
            [req.user.id, req.params.artId]
        );

        let latestChapterId = reading_history.latest_chapter_id;

        const [[latestChapter]] = await db.query(
            'SELECT chapter_number FROM chapters WHERE id=?',
            [reading_history.latest_chapter_id]
        );

        const [[currentChapter]] = await db.query(
            'SELECT chapter_number FROM chapters WHERE id=?',
            [req.params.id]
        );

        if (currentChapter && latestChapter && currentChapter.chapter_number > latestChapter.chapter_number) {
            latestChapterId = req.params.id;
        }

        const hours = Math.max(0, Math.min(reading_history.duration, 1)); // max 1 jam sekali baca

        await db.query(`UPDATE reading_history SET hours=? WHERE id=?`, [hours, reading_history.id])

        res.json({ message: 'Berhasil update reading history.'});
    
    } catch (error) {

        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

router.get('/arts/:artId/reading_history', auth, async (req, res) => {
    try {

        const [[reading_history]] = await db.query(`SELECT * FROM reading_history WHERE art_id=? AND user_id=?`, [req.params.artId, req.user.id]);

        const [[chapter]] = await db.query(`SELECT MAX(chapter_number) AS last_number FROM chapters WHERE art_id=?`,
            [req.params.artId]
        );
        
        res.json({ data: reading_history  });

    } catch (error) {

        console.error(error);

        res.status(500).json({
            message: 'Terdapat kesalahan pada server.'
        });
    }
});

module.exports = router;