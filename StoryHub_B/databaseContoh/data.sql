CREATE DATABASE IF NOT EXISTS 2410511097_db_login;
CREATE DATABASE IF NOT EXISTS 2410511097_db_novel;
CREATE DATABASE IF NOT EXISTS 2410511097_db_ratingKomen;

USE 2410511097_db_login;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100),
    role ENUM('reader','author','admin') DEFAULT 'reader',
    avatar_url VARCHAR(500),
    oauth_provider VARCHAR(50),
    oauth_id VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE refresh_tokens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    token TEXT NOT NULL,
    expires_at DATETIME NOT NULL,
    is_revoked TINYINT(1) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO users (username, email, password, role) VALUES
('admin', 'admin@gmail.com', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin'),
('penulis1','penulis1@gmail.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'author'),
('penulis2','penulis2@gmail.com','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'author'),
('reader1', 'reader1@gmail.com', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'reader'),
('reader2', 'reader2@gmail.com', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'reader');

USE 2410511097_db_novel;

CREATE TABLE novels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    author_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    synopsis TEXT,
    genre VARCHAR(30),
    cover_url VARCHAR(200),
    status ENUM('ongoing','completed','hiatus') DEFAULT 'ongoing',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE chapters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    novel_id INT NOT NULL,
    chapter_number INT NOT NULL,
    title VARCHAR(100),
    content LONGTEXT NOT NULL,
    is_published TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (novel_id) REFERENCES novels(id) ON DELETE CASCADE
);

INSERT INTO novels (author_id, title, synopsis, genre, status) VALUES
(2, 'Lucunya Prabowo', 'Kisah hangat dan menggetarkan perut tentang seorang pria gemoy yang bercita-cita menjadi pemimpin', 'Slice of Life', 'ongoing'),
(2, 'Ajudan Bapak', 'Kisah romansa terlarang anatara komandan dan ajudannya', 'Romance', 'completed'),
(3, 'Koboy dari Timur', 'Kisah inspirasional datang dari sosok yang berasal dari pulau terpencil hingga sukses menjadi menteri', 'Motivational', 'ongoing'),
(3, 'Jack, Si Tukang Kayu', 'Kisah menyayat hati dari seorang tukang kayu lulusan SMA yang kini menjadi pemimpin tertinggi suatu negara','Drama', 'hiatus');

INSERT INTO chapters (novel_id, chapter_number, title, content) VALUES
(1, 1, 'Lucunya', 'isi chapter 1 lp'),
(1, 2, 'Prabowo', 'isi chapter 2 lp'),
(2, 1, 'Antara Saya dan Bapak', 'isi chapter 1 ajudan bapak'),
(3, 1, 'Koboy','isi chapter 1 koboy dari timur'),
(4, 1, 'Si Tukang Kayu', 'isi chapter 1 jack si tukang kayu');

USE 2410511097_db_ratingKomen;

CREATE TABLE ratings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    novel_id INT NOT NULL,
    user_id INT NOT NULL,
    score TINYINT NOT NULL CHECK (score BETWEEN 1 AND 5),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_rating (novel_id, user_id)
);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    novel_id INT NOT NULL,
    chapter_id INT,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    type VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    is_read TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO ratings (novel_id, user_id, score) VALUES (1, 4, 5),(1, 5, 4),(2, 4, 5),(3, 5, 4),(4, 4, 3);

INSERT INTO comments (novel_id, chapter_id, user_id, content) VALUES
(1, 1, 4, 'Ceritanya lucu dan gemoy.'),
(1, 2, 5, 'Chapter 2 nya mulai ada drama antara pak presiden dengan ajudannya, nggak nyangka ajudannya memendam perasaannya selama ini.'),
(2, 3, 4, 'Nggak sabar nunggu si ajudan ngungkapin perasaannya'),
(3, 4, 5, 'Buku yang sangat memotivasi saya, terutama yang berasal dari daerah terpencil untuk bisa sukses juga seperti pak bahlil.');

INSERT INTO notifications (user_id, type, message) VALUES
(2, 'new_comment', 'Ada komentar baru di novel "Ajudan Bapak"'),
(3, 'new_rating', 'Novel "Jack, si Tukang Kayu" mendapat rating baru: 5/5');