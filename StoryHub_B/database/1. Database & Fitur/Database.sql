/*
CREATE DATABASE IF NOT EXISTS storyhub_db_auth;
CREATE DATABASE IF NOT EXISTS storyhub_db_art;
CREATE DATABASE IF NOT EXISTS storyhub_db_review;
*/

CREATE DATABASE IF NOT EXISTS storyhub;

USE storyhub;

-- USE storyhub_db_auth;

-- Users

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    bio VARCHAR(200),
    role ENUM('user','admin') DEFAULT 'user',
    profile_img VARCHAR(300) DEFAULT '/image/profile/default.jpg',
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE refresh_tokens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    token TEXT NOT NULL,
    expires_at DATETIME NOT NULL,
    is_revoked TINYINT(1) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE subscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    plan ENUM('monthly', 'yearly') NOT NULL,
    start_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    end_date DATETIME NOT NULL,
    cancelled_at DATETIME NULL,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_user (user_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE user_follows (
    id INT AUTO_INCREMENT PRIMARY KEY,
    follower_id INT NOT NULL,
    following_id INT NOT NULL,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_follow (follower_id, following_id),
    INDEX idx_follower (follower_id),
    INDEX idx_following (following_id),
    FOREIGN KEY (follower_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (following_id) REFERENCES users(id) ON DELETE CASCADE
);

-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- USE storyhub_db_art;


-- Arts (Novels, Comics, Games)

CREATE TABLE IF NOT EXISTS arts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    authorOrDev_id INT,
    is_canvas TINYINT(1) DEFAULT NULL,  -- khusus buat user upload novel sendiri (canvas) 1 = canvas
    isPublished ENUM('Published', 'Draft') DEFAULT 'Published' NOT NULL,
    title VARCHAR(200) NOT NULL,
    nametag VARCHAR(50) UNIQUE,
    play_url VARCHAR(300),
    cover_img VARCHAR(300) NOT NULL,
    banner_img VARCHAR(300) NOT NULL,
    ss1_img VARCHAR(300), -- khusus game
    ss2_img VARCHAR(300), -- khusus game
    ss3_img VARCHAR(300), -- khusus game
    authorOrDev VARCHAR(100) NOT NULL,
    artist VARCHAR(100),
    status ENUM('Ongoing','Completed','Hiatus') NOT NULL,
    category ENUM('Book', 'Novel', 'Manhwa', 'Manga', 'Comic', 'Game', 'Visual Novel', 'Story Game') NOT NULL,
    jumlah_chapter INT,
    tagline VARCHAR(200) NOT NULL,   -- kalimat pendek untuk menarik perhatian pembaca
    synopsis TEXT NOT NULL,  -- deskripsi cerita
    published_at VARCHAR(100), -- tanggal rilis asli novel ini, misal: "Mar 14, 2018"
    created DATETIME DEFAULT CURRENT_TIMESTAMP,  
    updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    
    -- FOREIGN KEY (authorDev_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS chapters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    art_id INT NOT NULL,
    is_canvas TINYINT(1) DEFAULT NULL,
    isPublished ENUM('Published', 'Draft') DEFAULT 'Published' NOT NULL,
    chapter_number INT NOT NULL, 
    isPremium TINYINT(1) DEFAULT NULL,  -- kalau premium, isPremium = 1
    title VARCHAR(200) NOT NULL,
    isi_chapter_novel LONGTEXT, -- khusus novel
    published_at VARCHAR(100),
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_chapter (art_id, id),
    FOREIGN KEY (art_id) REFERENCES arts(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS chapterPages ( -- khusus komik
    id INT AUTO_INCREMENT PRIMARY KEY,
    chapter_id INT NOT NULL,
    page_number INT NOT NULL,
    img_chapter_comic VARCHAR(300),
    INDEX idx_chapter (chapter_id),
    UNIQUE KEY unique_page (chapter_id, page_number),
    FOREIGN KEY (chapter_id) REFERENCES chapters(id) ON DELETE CASCADE
);

-- game nggak ada chapternya


CREATE TABLE reading_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    art_id INT NOT NULL,
    chapter_id INT NOT NULL,
    latest_chapter_id INT NOT NULL,
    page_number INT DEFAULT 1,
    scroll_position INT DEFAULT 0,
    hours INT DEFAULT 0 NOT NULL,
    started_read_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_history (user_id, art_id),
    FOREIGN KEY (art_id) REFERENCES arts(id) ON DELETE CASCADE
);

-- bookmark

CREATE TABLE bookmark (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    target_id INT NOT NULL,
    target_type ENUM('Art', 'Chapter', 'Game', 'Novel', 'Manga', 'Manhwa', 'Comic', 'Visual Novel', 'Story Game') DEFAULT 'Art' NOT NULL
);

-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- Tag, Genre, dan Mood 

CREATE TABLE IF NOT EXISTS tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tag VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS genres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    genre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS moods (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mood VARCHAR(100) NOT NULL
);


-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- Tabel penghubung antara tag, genre, mood ke art 

CREATE TABLE IF NOT EXISTS art_tags (
    art_id INT,
    tag_id INT,
    PRIMARY KEY(art_id, tag_id),
    FOREIGN KEY (art_id) REFERENCES arts(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

CREATE INDEX idx_art_tags_tag_id ON art_tags(tag_id);


CREATE TABLE IF NOT EXISTS art_genres (
    art_id INT,
    genre_id INT,
    PRIMARY KEY(art_id, genre_id),
    FOREIGN KEY (art_id) REFERENCES arts(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

CREATE INDEX idx_art_genres_genre_id ON art_genres(genre_id);


CREATE TABLE IF NOT EXISTS art_moods (
    art_id INT,
    mood_id INT,
    PRIMARY KEY(art_id, mood_id),
    FOREIGN KEY (art_id) REFERENCES arts(id) ON DELETE CASCADE,
    FOREIGN KEY (mood_id) REFERENCES moods(id) ON DELETE CASCADE
);

CREATE INDEX idx_art_moods_mood_id ON art_moods(mood_id);


-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- USE storyhub_db_review;

-- Ratings & Comments

CREATE TABLE IF NOT EXISTS reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    target_type ENUM('art', 'chapter') NOT NULL,
    target_id INT NOT NULL,
    user_id INT NOT NULL,
    diedit TINYINT(1) DEFAULT 0 NOT NULL,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 10),
    komentar TEXT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_target (target_type, target_id),
    INDEX idx_user (user_id),
    UNIQUE KEY unique_review (target_id, target_type, user_id)
    
    -- FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    target_type ENUM('art', 'chapter', 'review', 'comment') NOT NULL,
    target_id INT NOT NULL,
    user_id INT NOT NULL, 
    diedit VARCHAR(10) DEFAULT NULL, -- '(edit)'
    komentar TEXT NOT NULL,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_target (target_type, target_id),
    INDEX idx_user (user_id)
    
    -- FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    target_type ENUM('review', 'comment') NOT NULL,
    target_id INT NOT NULL,
    user_id INT NOT NULL,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_like (target_id, user_id),
    INDEX idx_target (target_type, target_id),
    INDEX idx_user (user_id)
    
    -- FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);



/*

mysql -u root -ppassword123 < "database/1. Database & Fitur/Database.sql" && \
mysql -u root -ppassword123 < "database/3. Arts/InsertArts.sql" && \
mysql -u root -ppassword123 < "database/4. Chapters/InsertChaptersNovel.sql" && \
mysql -u root -ppassword123 < "database/4. Chapters/InserChapterComic.sql" && \
mysql -u root -ppassword123 < "database/5. Tags & Reviews/InsertTags.sql" && \
mysql -u root -ppassword123 < "database/5. Tags & Reviews/InsertPivot.sql" && \



mysql -u root -ppassword123 < "database/2. Users/InsertUsers.sql" && \
mysql -u root -ppassword123 < "database/5. Tags & Reviews/InsertReviews.sql"

1. Database.sql

2. InsertUsers.sql

3. InsertArts.sql

4. InsertChaptersNovel.sql

5. InserChapterComic.sql

6. InsertTags.sql

7. InsertPivot.sql

8. InsertReviews.sql

*/