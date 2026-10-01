CREATE DATABASE IF NOT EXISTS storyhub_db_auth;
CREATE DATABASE IF NOT EXISTS storyhub_db_art;
CREATE DATABASE IF NOT EXISTS storyhub_db_review;

USE storyhub_db_auth;

-- Users

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100),
    role ENUM('user','admin') DEFAULT 'user',
    avatar_url VARCHAR(300) DEFAULT '/image/profile/default.jpg',
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
    user_id INT NOT NULL,
    plan ENUM('monthly', 'yearly') NOT NULL,
    start_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    end_date DATETIME NOT NULL,
    cancelled_at DATETIME NULL,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_user (user_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

----------------------------------------------------------------------------------------------------------------------------------------------------

USE storyhub_db_art;


-- Arts (Novels, Comics, Games)

CREATE TABLE IF NOT EXISTS arts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    authorDev_id INT,  -- khusus buat user upload novel sendiri (canvas)
    title VARCHAR(200) NOT NULL,
    nametag VARCHAR(50) UNIQUE,
    cover_img VARCHAR(300) NOT NULL,
    banner_img VARCHAR(300) NOT NULL,
    ss1_img VARCHAR(300), -- khusus komik
    ss2_img VARCHAR(300), -- khusus komik
    ss3_img VARCHAR(300), -- khusus komik
    authorOrDev VARCHAR(100) NOT NULL,
    artist VARCHAR(100),
    status ENUM('ongoing','completed','hiatus'),
    category ENUM('book', 'novel', 'manhwa', 'manga', 'comic', 'game', 'visual novel', 'story game') NOT NULL,
    tagline VARCHAR(200) NOT NULL,   -- kalimat pendek untuk menarik perhatian pembaca
    synopsis TEXT NOT NULL,  -- deskripsi cerita
    published_at VARCHAR(100), -- tanggal rilis asli novel ini, misal: "Mar 14, 2018"
    created DATETIME DEFAULT CURRENT_TIMESTAMP,  
    updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- FOREIGN KEY (authorDev_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS chapters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    art_id INT NOT NULL,
    chapter_number INT NOT NULL, 
    title VARCHAR(200) NOT NULL,
    isi_chapter_novel TEXT, -- khusus novel
    publised_at VARCHAR(100),
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


----------------------------------------------------------------------------------------------------------------------------------------------------

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


----------------------------------------------------------------------------------------------------------------------------------------------------

-- Tabel penghubung antara tag, genre, mood ke art 

CREATE TABLE IF NOT EXISTS art_tags (
    art_id INT,
    tag_id INT,
    PRIMARY KEY(art_id, tag_id),
    FOREIGN KEY (art_id) REFERENCES arts(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS art_genres (
    art_id INT,
    genre_id INT,
    PRIMARY KEY(art_id, genre_id),
    FOREIGN KEY (art_id) REFERENCES arts(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS art_moods (
    art_id INT,
    mood_id INT,
    PRIMARY KEY(art_id, mood_id),
    FOREIGN KEY (art_id) REFERENCES arts(id) ON DELETE CASCADE,
    FOREIGN KEY (mood_id) REFERENCES moods(id) ON DELETE CASCADE
);


----------------------------------------------------------------------------------------------------------------------------------------------------

USE storyhub_db_review;

-- Ratings & Comments

CREATE TABLE IF NOT EXISTS reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    target_type ENUM('art', 'chapter') NOT NULL,
    target_id INT NOT NULL,
    user_id INT NOT NULL,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 10),
    komentar TEXT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_target (target_type, target_id),
    INDEX idx_user (user_id),
    UNIQUE KEY unique_review (target_id, target_type, user_id),
    
    -- FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    target_type ENUM('art', 'chapter', 'review') NOT NULL,
    target_id INT NOT NULL,
    user_id INT NOT NULL, 
    komentar TEXT NOT NULL,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_target (target_type, target_id),
    INDEX idx_user (user_id),
    
    -- FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE target_likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    target_type ENUM('review', 'comment') NOT NULL,
    target_id INT NOT NULL,
    user_id INT NOT NULL,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_like (target_id, user_id),
    INDEX idx_target (target_id),
    INDEX idx_user (user_id),
    
    -- FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);



/*

1. Database.sql

2. InsertUsers.sql

3. InsertArts.sql

4. InsertChaptersNovel.sql

5. InserChapterComic.sql

6. InsertChapterGame.sql

7. InsertTgm.sql

8. InsertReviews.sql

*/


----------------------------------------------------------------------------------------------------------------------------------------------------

-- Insert users

INSERT INTO users (name, username, email, password, role, avatar_url) VALUES
('Jack Chou Wee', 'jkw', 'jack@gmail.com', 'password', 'admin')




----------------------------------------------------------------------------------------------------------------------------------------------------


/* ARTS */


-- Insert Canvas Novel (pemula)

INSERT INTO arts (title, authorDev_id, nametag, cover_img, banner_img, authorOrDev, category, tagline, synopsis) VALUES


-- Insert Novel

INSERT INTO arts (title, nametag, cover_img, banner_img, authorOrDev, category, tagline, synopsis, published_at) VALUES

('Re:Zero - Starting Life in Another World', 'rezero', 'project/image/coverArt/rezero_c.png', 'project/image/bannerArt/rezero_b.png', 'Tappei Nagatsuki', 'novel', 'Mati bukan akhir — itu kutukan.', 'Subaru Natsuki tiba-tiba dipindahkan ke dunia fantasi. Satu-satunya kemampuan yang ia miliki adalah kembali hidup setelah mati — namun setiap kematian membawa trauma yang tak terhapus.', 'Jan 24, 2012'),

('Omniscient Reader\'s Viewpoint', 'orv', 'project/image/coverArt/orv_c.png', 'project/image/bannerArt/orv_b.png', 'Sing Shong', 'novel', 'Hanya dia yang tahu bagaimana cerita ini berakhir.', 'Kim Dokja adalah satu-satunya pembaca setia novel web "Three Ways to Survive the Apocalypse" — dan tiba-tiba dunia nyata berubah menjadi isi novel itu. Kini hanya ia yang tahu bagaimana cerita ini akan berakhir.', 'Jan 14, 2018'),

('Lord of Mysteries', 'lom', 'project/image/coverArt/lom_c.png', 'project/image/bannerArt/lom_b.png', 'Cuttlefish That Loves Diving', 'novel', 'Di balik misteri, tersembunyi kebenaran yang lebih gelap.', 'Zhou Mingrui terbangun di tubuh orang lain di dunia steampunk penuh okultisme. Ia bergabung dengan organisasi rahasia dan menjadi "The Fool" — peran yang lebih besar dari yang ia bayangkan.', 'Mar 2, 2018'),

('86 Eighty-Six', 'eightysix', 'project/image/coverArt/eightysix_c.png', 'project/image/bannerArt/eightysix_b.png', 'Asato Asato', 'novel', 'Mereka bertempur. Republik berpura-pura mereka tak ada.', 'Di Republik San Magnolia, perang dilancarkan oleh drone tanpa awak — begitu klaimnya. Kenyataannya, anak-anak 86 yang dianggap bukan manusia yang mengemudikannya, dan Lena adalah satu-satunya perwira yang mau mengakui kemanusiaan mereka.', 'Feb 10, 2017'),

('Janji', 'janji', 'project/image/coverArt/janji_c.png', 'project/image/bannerArt/janji_b.png', 'Fiersa Besari', 'novel', 'Sebuah janji yang melampaui jarak dan waktu.', 'Novel karya Fiersa Besari yang mengisahkan perjalanan cinta, kehilangan, dan janji yang terus dipegang meski dunia berubah.', 'Jan 1, 2019'),

('Bumi', 'bumi', 'project/image/coverArt/bumi_c.png', 'project/image/bannerArt/bumi_b.png', 'Tere Liye', 'novel', 'Petualangan dimulai dari bawah permukaan bumi.', 'Raib, Seli, dan Ali menemukan bahwa di bawah permukaan bumi terdapat dunia-dunia tersembunyi dengan peradaban dan kekuatan yang menakjubkan. Petualangan mereka baru saja dimulai.', 'Oct 1, 2014'),

('Welcome to NHK', 'nhk', 'project/image/coverArt/nhk_c.png', 'project/image/bannerArt/nhk_b.png', 'Tatsuhiko Takimoto', 'novel', 'Dunia di luar kamarmu lebih menakutkan dari yang kamu kira.', 'Sato yakin ada konspirasi bernama NHK yang membuatnya menjadi hikikomori. Seorang gadis misterius datang mengklaim ingin menyelamatkannya — tapi siapa sebenarnya yang membutuhkan pertolongan?', 'Sep 1, 2002'),

('Reverend Insanity', 'reverend_insanity', 'project/image/coverArt/reverend_insanity_c.png', 'project/image/bannerArt/reverend_insanity_b.png', 'Gu Zhen Ren', 'novel', 'Ia bukan protagonis. Ia predator.', 'Fang Yuan, manusia paling amoral di dunia kultivasi, hidup kembali dengan semua memori 500 tahunnya. Ia tak ingin menjadi pahlawan — ia hanya ingin keabadian, dengan cara apapun.', 'Mar 5, 2012'),

('Laskar Pelangi', 'laskar_pelangi', 'project/image/coverArt/laskar_pelangi_c.png', 'project/image/bannerArt/laskar_pelangi_b.png', 'Andrea Hirata', 'novel', 'Mimpi tidak mengenal keterbatasan.', 'Kisah sepuluh anak Belitung yang berjuang mendapatkan pendidikan di sekolah hampir rubuh. Dengan semangat dan persahabatan, mereka membuktikan bahwa mimpi tidak mengenal kemiskinan.', 'Jan 1, 2005'),

('Metamorphosis', 'metamorphosis_kafka', 'project/image/coverArt/metamorphosis_c.png', 'project/image/bannerArt/metamorphosis_b.png', 'Franz Kafka', 'novel', 'Suatu pagi ia terbangun sebagai sesuatu yang lain.', 'Gregor Samsa terbangun dan mendapati dirinya telah berubah menjadi serangga raksasa. Novel pendek Kafka yang menjadi alegori alienasi, keluarga, dan kemanusiaan yang paling terkenal sepanjang masa.', 'Oct 15, 1915'),

('Violet Evergarden', 'violet_evergarden', 'project/image/coverArt/violet_evergarden_c.png', 'project/image/bannerArt/violet_evergarden_b.png', 'Kana Akatsuki', 'novel', 'Ia belajar menulis surat — dan belajar apa itu cinta.', 'Violet Evergarden, mantan prajurit yang kehilangan kedua tangannya, kini bekerja sebagai Auto Memory Doll — menulis surat untuk orang lain. Lewat surat-surat itu, ia mencoba memahami kata-kata terakhir sang mayor: "Aku mencintaimu."', 'Dec 25, 2015'),

('Classroom of the Elite', 'cote', 'project/image/coverArt/cote_c.png', 'project/image/bannerArt/cote_b.png', 'Syougo Kinugasa', 'novel', 'Di sekolah ini, kelasmu adalah segalanya.', 'Kiyotaka Ayanokoji masuk ke SMA bergengsi dan sengaja menyembunyikan kemampuan sesungguhnya. Sekolah ini mengajarkan bahwa hanya yang terkuat yang berhak naik kelas — dan dunia nyata tidak jauh berbeda.', 'May 25, 2015');



-- Insert Comic

INSERT INTO arts (title, nametag, cover_img, banner_img, authorOrDev, artist, category, tagline, synopsis, published_at) VALUES

('Boruto: Two Blue Vortex', 'boruto_tbv', 'project/image/coverArt/boruto_tbv_c.png', 'project/image/bannerArt/boruto_tbv_b.png', 'Masashi Kishimoto', 'Mikio Ikemoto', 'manga', 'Dua biru berputar — babak baru dimulai.', 'Tiga tahun setelah peristiwa Omnipotence, Boruto kembali sebagai shinobi yang jauh lebih kuat. Ia harus menghadapi ancaman baru sekaligus membersihkan namanya di desa yang telah dimanipulasi untuk membencinya.', 'Aug 21, 2023'),

('Boruto: Naruto Next Generations', 'boruto_nng', 'project/image/coverArt/boruto_nng_c.png', 'project/image/bannerArt/boruto_nng_b.png', 'Masashi Kishimoto', 'Mikio Ikemoto', 'manga', 'Generasi baru, ancaman yang lebih besar.', 'Boruto Uzumaki, putra Naruto, tumbuh di era damai namun penuh ketegangan. Sebuah ancaman kuno bernama Otsutsuki mengintai, dan Boruto harus menemukan jalannya sendiri sebagai shinobi.', 'May 9, 2016'),

('One Piece', 'one_piece', 'project/image/coverArt/one_piece_c.png', 'project/image/bannerArt/one_piece_b.png', 'Eiichiro Oda', 'Eiichiro Oda', 'manga', 'Harta karun terbesar adalah kebebasan.', 'Monkey D. Luffy berlayar mengarungi Grand Line bersama kru Topi Jerami demi menemukan One Piece dan menjadi Raja Bajak Laut. Petualangan epik yang penuh persahabatan, pengorbanan, dan kebebasan.', 'Jul 22, 1997'),

('Naruto', 'naruto', 'project/image/coverArt/naruto_c.png', 'project/image/bannerArt/naruto_b.png', 'Masashi Kishimoto', 'Masashi Kishimoto', 'manga', 'Percayai dirimu — itulah jalan ninja.', 'Naruto Uzumaki, bocah yang dijauhi desa karena menyimpan rubah ekor sembilan, berjuang keras untuk diakui dan meraih gelar Hokage. Kisah tentang kerja keras, persahabatan, dan memaafkan.', 'Sep 21, 1999'),

('Naruto Shippuden', 'naruto_shippuden', 'project/image/coverArt/naruto_shippuden_c.png', 'project/image/bannerArt/naruto_shippuden_b.png', 'Masashi Kishimoto', 'Masashi Kishimoto', 'manga', 'Perdamaian yang diperjuangkan dengan darah.', 'Dua setengah tahun setelah berlatih, Naruto kembali menghadapi ancaman Akatsuki dan rahasia gelap dunia shinobi. Pertarungan terakhir untuk menyelamatkan sahabatnya dan seluruh dunia dimulai.', 'Feb 15, 2007'),

('Solo Leveling', 'solo_leveling', 'project/image/coverArt/solo_leveling_c.png', 'project/image/bannerArt/solo_leveling_b.png', 'Chugong', 'Dubu (REDICE Studio)', 'manhwa', 'Dari yang terlemah menjadi yang terkuat — sendirian.', 'Sung Jinwoo, hunter terlemah di dunia, terjebak di dungeon mematikan dan mendapat sistem misterius yang hanya ia bisa lihat. Ia mulai naik level sendirian dalam dunia yang penuh monster dan bahaya.', 'Mar 4, 2018'),

('Chainsaw Man', 'chainsawman', 'project/image/coverArt/chainsawman_c.png', 'project/image/bannerArt/chainsawman_b.png', 'Tatsuki Fujimoto', 'Tatsuki Fujimoto', 'manga', 'Semua yang ia inginkan hanya roti dan pelukan.', 'Denji hidup dalam kemiskinan ekstrem bersama iblis gergaji bernama Pochita. Setelah mati dan dibangkitkan sebagai Chainsaw Man, ia bergabung dengan biro pembasmi iblis — dan dunianya tak pernah sama lagi.', 'Dec 3, 2018'),

('Jujutsu Kaisen', 'jjk', 'project/image/coverArt/jjk_c.png', 'project/image/bannerArt/jjk_b.png', 'Gege Akutami', 'Gege Akutami', 'manga', 'Menelan kutukan demi menyelamatkan yang dicintai.', 'Yuji Itadori menelan jari Ryomen Sukuna, raja kutukan, demi menyelamatkan temannya. Kini ia harus hidup sebagai wadah kutukan terkuat sambil berjuang melawan dunia supranatural yang brutal.', 'Mar 5, 2018'),

('Fullmetal Alchemist', 'fma', 'project/image/coverArt/fma_c.png', 'project/image/bannerArt/fma_b.png', 'Hiromu Arakawa', 'Hiromu Arakawa', 'manga', 'Satu untuk semua, semua untuk satu — harga dari keserakahan.', 'Dua bersaudara Edward dan Alphonse Elric kehilangan tubuh mereka saat mencoba menghidupkan ibu mereka dengan alkimia terlarang. Mereka mencari Philosopher\'s Stone untuk memulihkan segalanya — dan menemukan kebenaran yang jauh lebih besar.', 'Jul 12, 2001'),

('Invincible', 'invincible', 'project/image/coverArt/invincible_c.png', 'project/image/bannerArt/invincible_b.png', 'Robert Kirkman', 'Ryan Ottley', 'comic', 'Menjadi pahlawan tidak semudah terbang.', 'Mark Grayson adalah putra superhero terkuat di Bumi. Saat kekuatannya muncul, ia siap mengikuti jejak ayahnya — sampai kebenaran tentang sang ayah menghancurkan segalanya.', 'Jan 22, 2003'),

('The Amazing Spider-Man', 'amazing_spiderman', 'project/image/coverArt/amazing_spiderman_c.png', 'project/image/bannerArt/amazing_spiderman_b.png', 'Stan Lee', 'Steve Ditko', 'comic', 'Kekuatan besar, tanggung jawab besar.', 'Peter Parker, remaja pemalu yang digigit laba-laba radioaktif, menjadi Spider-Man. Antara kuliah, cinta, dan membasmi kejahatan New York, ia belajar bahwa menjadi pahlawan bukan tentang ketenaran.', 'Mar 1, 1963'),

('Superman', 'superman', 'project/image/coverArt/superman_c.png', 'project/image/bannerArt/superman_b.png', 'Jerry Siegel', 'Joe Shuster', 'comic', 'Harapan adalah kekuatan yang sesungguhnya.', 'Kal-El, putra terakhir Krypton, dibesarkan di Kansas sebagai Clark Kent. Sebagai Superman, ia melindungi Bumi bukan karena kewajiban, tapi karena ia percaya pada kebaikan manusia.', 'Apr 18, 1938'),

('The Boys', 'the_boys', 'project/image/coverArt/the_boys_c.png', 'project/image/bannerArt/the_boys_b.png', 'Garth Ennis', 'Darick Robertson', 'comic', 'Pahlawan palsu, kejahatan nyata.', 'Di dunia di mana superhero dikelola seperti selebriti korporat, sekelompok orang biasa bernama The Boys bertugas mengawasi — dan menghentikan — para "pahlawan" yang korup dan berbahaya.', 'Jul 1, 2006'),

('My Hero Academia', 'mha', 'project/image/coverArt/mha_c.png', 'project/image/bannerArt/mha_b.png', 'Kohei Horikoshi', 'Kohei Horikoshi', 'manga', 'Bahkan tanpa kekuatan, hati seorang pahlawan tetap menyala.', 'Di dunia di mana hampir semua orang punya kemampuan super (Quirk), Izuku Midoriya lahir tanpa satu pun. Namun tekadnya yang membara menarik perhatian pahlawan terkuat di dunia, All Might, yang mewariskan kekuatannya.', 'Jul 7, 2014'),

('Blue Lock', 'blue_lock', 'project/image/coverArt/blue_lock_c.png', 'project/image/bannerArt/blue_lock_b.png', 'Muneyuki Kaneshiro', 'Yusuke Nomura', 'manga', 'Hanya satu yang boleh menjadi striker terbaik dunia.', '300 pemain sepak bola muda Jepang dikurung dalam fasilitas bernama Blue Lock. Tujuannya: melahirkan satu striker egois terbaik yang akan membawa Jepang merajai dunia. Isagi Yoichi harus berevolusi atau tersingkir.', 'Aug 1, 2018'),

('Monster', 'monster_urasawa', 'project/image/coverArt/monster_c.png', 'project/image/bannerArt/monster_b.png', 'Naoki Urasawa', 'Naoki Urasawa', 'manga', 'Menyelamatkan satu nyawa — dan membiarkan monster lahir.', 'Dr. Tenma menyelamatkan seorang bocah laki-laki alih-alih walikota, dan pilihan itu menghancurkan kariernya. Bertahun-tahun kemudian, bocah itu tumbuh menjadi pembunuh berantai paling berbahaya di Eropa — dan Tenma harus menghentikannya.', 'Dec 5, 1994'),

('20th Century Boys', '20cb', 'project/image/coverArt/20cb_c.png', 'project/image/bannerArt/20cb_b.png', 'Naoki Urasawa', 'Naoki Urasawa', 'manga', 'Buku ramalan masa kecil menjadi mimpi buruk nyata.', 'Kenji dan teman-temannya semasa kecil pernah membuat "buku ramalan" berisi skenario kiamat sebagai permainan. Kini skenario itu mulai terwujud, dan seorang tokoh misterius bernama "Friend" tampaknya ada di balik semuanya.', 'Sep 22, 1999'),

('Black Clover', 'black_clover', 'project/image/coverArt/black_clover_c.png', 'project/image/bannerArt/black_clover_b.png', 'Yuki Tabata', 'Yuki Tabata', 'manga', 'Tanpa sihir pun, aku akan menjadi Kaisar Sihir!', 'Asta lahir tanpa sihir di dunia di mana sihir adalah segalanya. Dengan tekad membara dan pedang anti-sihir, ia bersaing dengan sahabatnya Yuno untuk meraih gelar Kaisar Sihir tertinggi.', 'Feb 16, 2015'),

('Look Back', 'look_back', 'project/image/coverArt/look_back_c.png', 'project/image/bannerArt/look_back_b.png', 'Tatsuki Fujimoto', 'Tatsuki Fujimoto', 'manga', 'Dua gadis, satu passion — dan kenangan yang tak terhapus.', 'Fujino dan Kyomoto adalah dua anak berbeda yang dihubungkan oleh cinta terhadap manga. Karya satu chapter Tatsuki Fujimoto ini mengisahkan persahabatan, kreativitas, dan kehilangan dengan cara yang membekas dalam.', 'Jul 19, 2021'),

('Gintama', 'gintama', 'project/image/coverArt/gintama_c.png', 'project/image/bannerArt/gintama_b.png', 'Hideaki Sorachi', 'Hideaki Sorachi', 'manga', 'Jangan anggap remeh orang yang menjaga rambutnya tetap perak.', 'Di Edo yang telah dijajah alien bernama Amanto, Gintoki Sakata — samurai malas pemakan permen — menjalankan jasa "Yorozuya" bersama dua anak ajaib. Komedi gila dengan momen serius yang menghancurkan hati.', 'Dec 8, 2003'),

('Mob Psycho 100', 'mob_psycho', 'project/image/coverArt/mob_psycho_c.png', 'project/image/bannerArt/mob_psycho_b.png', 'ONE', 'ONE', 'manga', '100% emosi yang tertahan — dan saat meledak, dunia bergetar.', 'Shigeo "Mob" Kageyama adalah anak SMP biasa yang juga merupakan esper paling kuat di dunia. Ia menekan emosinya agar kekuatannya tidak lepas kendali — tapi berapa lama ia bisa bertahan?', 'Apr 18, 2012'),

('Dragon Ball Z', 'dbz', 'project/image/coverArt/dbz_c.png', 'project/image/bannerArt/dbz_b.png', 'Akira Toriyama', 'Akira Toriyama', 'manga', 'Lampaui batasmu — dan lampaui lagi.', 'Goku, kini dewasa dan punya anak, menghadapi ancaman dari luar angkasa dan dimensi lain. Dari Saiyan hingga Cell hingga Majin Buu, ia dan para pejuang Z terus mendorong batas kekuatan manusia dan alien.', 'Apr 26, 1988'),

('Kagurabachi', 'kagurabachi', 'project/image/coverArt/kagurabachi_c.png', 'project/image/bannerArt/kagurabachi_b.png', 'Takeru Hokazono', 'Takeru Hokazono', 'manga', 'Pedang sang ayah, dendam sang putra.', 'Chihiro Rokuhira menyaksikan ayahnya — seorang pandai pedang legendaris — dibunuh dan pedang-pedang saktinya dicuri. Kini ia memburu para pelaku dengan satu pedang tersisa dan tekad yang tak tergoyahkan.', 'Aug 28, 2023'),

('Hunter x Hunter', 'hxh', 'project/image/coverArt/hxh_c.png', 'project/image/bannerArt/hxh_b.png', 'Yoshihiro Togashi', 'Yoshihiro Togashi', 'manga', 'Dunia lebih luas dan lebih gelap dari yang kamu bayangkan.', 'Gon Freecss ingin menjadi Hunter seperti ayahnya yang tak pernah ia kenal. Perjalanannya mempertemukannya dengan Killua, Kurapika, dan Leorio — serta membawanya ke sudut-sudut dunia yang paling berbahaya.', 'Mar 3, 1998');




-- Insert Game

INSERT INTO arts (title, nametag, cover_img, banner_img, ss1_img, ss2_img, ss3_img, authorOrDev, category, tagline, synopsis, published_at) VALUES

('Stardew Valley', 'stardew_valley', 'project/image/coverArt/stardew_valley_c.png', 'project/image/bannerArt/stardew_valley_b.png', 'project/image/screenshotsGame/stardew_ss1.png', 'project/image/screenshotsGame/stardew_ss2.png', 'project/image/screenshotsGame/stardew_ss3.png', 'ConcernedApe', 'game', 'Tinggalkan kota — temukan hidupmu yang sesungguhnya.', 'Kamu mewarisi ladang kakek di desa Pelican Town. Dari ladang yang terbengkalai, bangun kehidupan baru: bertani, berteman, jatuh cinta, dan mungkin menemukan misteri lembah yang lebih dalam dari yang terlihat.', 'Feb 26, 2016'),

('Hollow Knight', 'hollow_knight', 'project/image/coverArt/hollow_knight_c.png', 'project/image/bannerArt/hollow_knight_b.png', 'project/image/screenshotsGame/hollow_knight_ss1.png', 'project/image/screenshotsGame/hollow_knight_ss2.png', 'project/image/screenshotsGame/hollow_knight_ss3.png', 'Team Cherry', 'game', 'Di bawah tanah, kerajaan yang terlupakan menunggumu.', 'Seorang ksatria kecil menjelajahi Hallownest, kerajaan serangga bawah tanah yang runtuh akibat wabah kuno. Platformer-metroidvania dengan dunia yang dalam, lore tersembunyi, dan boss yang menantang.', 'Feb 24, 2017'),

('Undertale', 'undertale', 'project/image/coverArt/undertale_c.png', 'project/image/bannerArt/undertale_b.png', 'project/image/screenshotsGame/undertale_ss1.png', 'project/image/screenshotsGame/undertale_ss2.png', 'project/image/screenshotsGame/undertale_ss3.png', 'Toby Fox', 'game', 'RPG di mana kamu tidak harus membunuh siapapun.', 'Seorang anak jatuh ke dunia bawah tanah yang dipenuhi monster. Pilihan ada di tanganmu: bertarung atau berdamai. Setiap keputusan punya konsekuensi — dan game ini tidak melupakannya.', 'Sep 15, 2015'),

('A Space for the Unbound', 'space_unbound', 'project/image/coverArt/space_unbound_c.png', 'project/image/bannerArt/space_unbound_b.png', 'project/image/screenshotsGame/space_unbound_ss1.png', 'project/image/screenshotsGame/space_unbound_ss2.png', 'project/image/screenshotsGame/space_unbound_ss3.png', 'Mojiken Studio', 'game', 'Di balik kenangan indah, tersimpan luka yang mendalam.', 'Di Indonesia akhir 90-an, Atma dan Raya adalah dua remaja yang ingin menghabiskan hari-hari terakhir SMA dengan tenang. Namun kekuatan supernatural mulai muncul dan realitas perlahan runtuh di sekeliling mereka.', 'Jan 19, 2023'),

('Pikabuu: Unhuman', 'pikabuu_unhuman', 'project/image/coverArt/pikabuu_unhuman_c.png', 'project/image/bannerArt/pikabuu_unhuman_b.png', 'project/image/screenshotsGame/pikabuu_unhuman_ss1.png', 'project/image/screenshotsGame/pikabuu_unhuman_ss2.png', 'project/image/screenshotsGame/pikabuu_unhuman_ss3.png', 'Mojiken Studio', 'game', 'Apa artinya menjadi manusia?', 'Pikabuu adalah makhluk kecil yang belajar tentang dunia manusia dengan cara yang lucu sekaligus menyentuh. Game kasual dengan narasi yang menghangatkan hati tentang identitas dan penerimaan.', '2020'),

('Pikabuu: STOP!', 'pikabuu_stop', 'project/image/coverArt/pikabuu_stop_c.png', 'project/image/bannerArt/pikabuu_stop_b.png', 'project/image/screenshotsGame/pikabuu_stop_ss1.png', 'project/image/screenshotsGame/pikabuu_stop_ss2.png', 'project/image/screenshotsGame/pikabuu_stop_ss3.png', 'Mojiken Studio', 'game', 'Tolong, berhenti sebentar.', 'Sekuel dari Pikabuu: Unhuman yang mengeksplorasi tema kecemasan dan kebutuhan untuk berhenti sejenak di tengah dunia yang tidak pernah berhenti bergerak.', '2021'),

('Spark in the Dark', 'spark_dark', 'project/image/coverArt/spark_dark_c.png', 'project/image/bannerArt/spark_dark_b.png', 'project/image/screenshotsGame/spark_dark_ss1.png', 'project/image/screenshotsGame/spark_dark_ss2.png', 'project/image/screenshotsGame/spark_dark_ss3.png', 'Mojiken Studio', 'game', 'Bahkan percikan kecil bisa menerangi kegelapan.', 'Game pendek yang penuh kehangatan tentang menemukan cahaya di tengah kegelapan. Eksplorasi narasi dengan visual minimalis dan pesan yang dalam tentang harapan.', '2025'),

('Celeste', 'celeste', 'project/image/coverArt/celeste_c.png', 'project/image/bannerArt/celeste_b.png', 'project/image/screenshotsGame/celeste_ss1.png', 'project/image/screenshotsGame/celeste_ss2.png', 'project/image/screenshotsGame/celeste_ss3.png', 'Maddy Thorson & Noel Berry', 'game', 'Mendaki gunung untuk menghadapi dirimu sendiri.', 'Madeline mendaki Gunung Celeste untuk membuktikan sesuatu pada dirinya sendiri. Namun musuh terberatnya bukan di luar — melainkan bagian dari dirinya sendiri. Platformer yang indah tentang kesehatan mental dan menerima diri.', 'Jan 25, 2018'),

('Hades', 'hades', 'project/image/coverArt/hades_c.png', 'project/image/bannerArt/hades_b.png', 'project/image/screenshotsGame/hades_ss1.png', 'project/image/screenshotsGame/hades_ss2.png', 'project/image/screenshotsGame/hades_ss3.png', 'Supergiant Games', 'game', 'Mati adalah permulaan, bukan akhir.', 'Zagreus, putra Hades, terus-menerus berusaha melarikan diri dari dunia bawah. Setiap kematian membawanya kembali ke awal — namun juga lebih kuat, dan lebih dekat dengan kebenaran keluarganya.', 'Sep 17, 2020'),

('Touhou 6: The Embodiment of Scarlet Devil', 'touhou6', 'project/image/coverArt/touhou6_c.png', 'project/image/bannerArt/touhou6_b.png', 'project/image/screenshotsGame/touhou6_ss1.png', 'project/image/screenshotsGame/touhou6_ss2.png', 'project/image/screenshotsGame/touhou6_ss3.png', 'ZUN (Team Shanghai Alice)', 'game', 'Sebuah kabut merah menyelimuti Gensokyo — siapakah pelakunya?', 'Reimu Hakurei dan Marisa Kirisame menyelidiki kabut merah misterius yang menyelimuti Gensokyo. Bullet hell legendaris yang melahirkan seluruh franchise Touhou Project.', 'Aug 11, 2002'),

('Hello Charlotte', 'hello_charlotte', 'project/image/coverArt/hello_charlotte_c.png', 'project/image/bannerArt/hello_charlotte_b.png', 'project/image/screenshotsGame/hello_charlotte_ss1.png', 'project/image/screenshotsGame/hello_charlotte_ss2.png', 'project/image/screenshotsGame/hello_charlotte_ss3.png', 'etherane', 'story game', 'Dunia ini adalah panggung, dan kamu adalah sutradaranya.', 'Charlotte hidup di dunia yang rapuh dan aneh. Game RPG maker dengan estetika gelap yang mengeksplorasi eksistensi, kekosongan, dan arti dari "nyata" dengan cara yang unik dan menggugah.', 'Dec 5, 2014'),

('The Dearest Person', 'dearest_person', 'project/image/coverArt/dearest_person_c.png', 'project/image/bannerArt/dearest_person_b.png', 'project/image/screenshotsGame/dearest_person_ss1.png', 'project/image/screenshotsGame/dearest_person_ss2.png', 'project/image/screenshotsGame/dearest_person_ss3.png', 'Mojiken Studio', 'story game', 'Siapa orang yang paling berarti bagimu?', 'Game naratif pendek yang mengajak pemain merenungkan hubungan mereka dengan orang-orang terdekat melalui percakapan sederhana namun penuh makna.', '2018'),

('OMORI', 'omori', 'project/image/coverArt/omori_c.png', 'project/image/bannerArt/omori_b.png', 'project/image/screenshotsGame/omori_ss1.png', 'project/image/screenshotsGame/omori_ss2.png', 'project/image/screenshotsGame/omori_ss3.png', 'OMOCAT', 'game', 'Apa yang kamu sembunyikan di balik senyummu?', 'Omori adalah anak pendiam yang hidup di dunia imajinasi bersama teman-temannya. Namun dunia nyata terus mengetuk pintu — dan kenangan yang ia kubur dalam-dalam mulai bangkit. RPG psikologis yang berat tentang trauma, rasa bersalah, dan penyembuhan.', 'Dec 25, 2020'),

('LISA: The Painful', 'lisa_painful', 'project/image/coverArt/lisa_painful_c.png', 'project/image/bannerArt/lisa_painful_b.png', 'project/image/screenshotsGame/lisa_painful_ss1.png', 'project/image/screenshotsGame/lisa_painful_ss2.png', 'project/image/screenshotsGame/lisa_painful_ss3.png', 'Dingaling Productions', 'game', 'Di dunia yang hancur, cinta pun terasa menyakitkan.', 'Di dunia pasca-apokalips di mana semua wanita telah lenyap, Brad Armstrong menemukan seorang bayi perempuan. Ia membesarkannya dalam sembunyi — sampai ia diculik. Brad akan mengorbankan segalanya untuk menyelamatkannya.', 'May 1, 2014'),

('Danganronpa: Trigger Happy Havoc', 'danganronpa', 'project/image/coverArt/danganronpa_c.png', 'project/image/bannerArt/danganronpa_b.png', 'project/image/screenshotsGame/danganronpa_ss1.png', 'project/image/screenshotsGame/danganronpa_ss2.png', 'project/image/screenshotsGame/danganronpa_ss3.png', 'Spike Chunsoft', 'visual novel', 'Satu-satunya cara keluar adalah membunuh — dan tidak ketahuan.', '15 siswa terkurung di Hope\'s Peak Academy oleh beruang mekanik bernama Monokuma. Aturannya: bunuh temanmu tanpa ketahuan, dan kamu bebas. Tapi jika pelaku teridentifikasi, semua selamat — kecuali si pelaku.', 'Nov 25, 2010'),

('Higurashi When They Cry', 'higurashi', 'project/image/coverArt/higurashi_c.png', 'project/image/bannerArt/higurashi_b.png', 'project/image/screenshotsGame/higurashi_ss1.png', 'project/image/screenshotsGame/higurashi_ss2.png', 'project/image/screenshotsGame/higurashi_ss3.png', '07th Expansion', 'visual novel', 'Desa yang tenang menyimpan siklus kematian yang tak berujung.', 'Keiichi Maebara pindah ke desa kecil Hinamizawa yang tampak damai. Namun setiap tahun, saat festival Watanagashi, seseorang mati dan seseorang menghilang — dan sejarah terus berulang dengan cara yang berbeda.', 'Aug 10, 2002'),

('Umineko When They Cry', 'umineko', 'project/image/coverArt/umineko_c.png', 'project/image/bannerArt/umineko_b.png', 'project/image/screenshotsGame/umineko_ss1.png', 'project/image/screenshotsGame/umineko_ss2.png', 'project/image/screenshotsGame/umineko_ss3.png', '07th Expansion', 'visual novel', 'Siapa pelakunya — manusia atau penyihir?', 'Keluarga Ushiromiya berkumpul di pulau terpencil Rokkenjima. Saat badai memutus akses, pembunuhan berantai terjadi dengan pola yang mustahil — seolah kutukan penyihir emas Beatrice menjadi kenyataan.', 'Aug 17, 2007'),

('Subarashiki Hibi', 'subarashiki_hibi', 'project/image/coverArt/subarashiki_hibi_c.png', 'project/image/bannerArt/subarashiki_hibi_b.png', 'project/image/screenshotsGame/subarashiki_hibi_ss1.png', 'project/image/screenshotsGame/subarashiki_hibi_ss2.png', 'project/image/screenshotsGame/subarashiki_hibi_ss3.png', 'KeroQ', 'visual novel', 'Dunia akan berakhir dalam tujuh hari — atau sudah berakhir dari dulu?', 'Berbagai sudut pandang karakter menjelang dan sesudah "akhir dunia" yang diramalkan. Visual novel filosofis berat yang mempertanyakan realitas, persepsi, dan makna keberadaan.', 'Jun 26, 2010'),

('Steins;Gate', 'steins_gate', 'project/image/coverArt/steins_gate_c.png', 'project/image/bannerArt/steins_gate_b.png', 'project/image/screenshotsGame/steins_gate_ss1.png', 'project/image/screenshotsGame/steins_gate_ss2.png', 'project/image/screenshotsGame/steins_gate_ss3.png', '5pb. & Nitroplus', 'visual novel', 'El Psy Kongroo — sekali kamu mengubah masa lalu, segalanya bisa runtuh.', 'Rintaro Okabe, ilmuwan gila otodidak, secara tidak sengaja menemukan cara mengirim pesan ke masa lalu. Apa yang dimulai sebagai kesenangan berubah menjadi mimpi buruk ketika organisasi gelap mulai mengancam — dan orang-orang yang ia cintai mulai menghilang.', 'Oct 23, 2009'),

('The House in Fata Morgana', 'fata_morgana', 'project/image/coverArt/fata_morgana_c.png', 'project/image/bannerArt/fata_morgana_b.png', 'project/image/screenshotsGame/fata_morgana_ss1.png', 'project/image/screenshotsGame/fata_morgana_ss2.png', 'project/image/screenshotsGame/fata_morgana_ss3.png', 'Novectacle', 'visual novel', 'Sebuah rumah, ratusan tahun luka, dan satu jiwa yang mencari kebenaran.', 'Kamu terbangun di rumah misterius tanpa ingatan. Seorang maid membawamu menelusuri pintu-pintu yang membuka era berbeda — masing-masing menyimpan tragedi, cinta, dan kegelapan yang saling terjalin lintas waktu.', 'Apr 25, 2012'),

('Clannad', 'clannad', 'project/image/coverArt/clannad_c.png', 'project/image/bannerArt/clannad_b.png', 'project/image/screenshotsGame/clannad_ss1.png', 'project/image/screenshotsGame/clannad_ss2.png', 'project/image/screenshotsGame/clannad_ss3.png', 'Key (Visual Art\'s)', 'visual novel', 'Keluarga bukan hanya soal darah — tapi soal memilih untuk ada.', 'Tomoya Okazaki, remaja sinis yang membenci kotanya sendiri, bertemu Nagisa Furukawa di hari musim dingin yang biasa. Dari sana, ia mulai terhubung dengan orang-orang di sekitarnya dan menemukan kembali arti dari keluarga dan rumah.', 'Apr 28, 2004');




----------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------

/* CHAPTERS */

-- Canvas Novel chapter

INSERT INTO chapters (art_id, chapter_number, title, isi_chapter_novel) VALUES


-- Novel chapter

INSERT INTO chapters (art_id, chapter_number, title, isi_chapter_novel, publised_at) VALUES

-- Re:Zero (art_id = 1)

-- chapter 1
(1, 1, 'Kehidupan di Dunia Lain', 
'', 
'Apr 5, 2012'),

-- chapter 2
(1, 2, 'Kemampuan yang Tak Diinginkan', 
'', 
'Apr 12, 2012'),

-- chapter 3
(1, 3, 'Kematian Pertama', 
'', 
'Apr 19, 2012'),


---------------------------------------------------------------------------------------------------------------------------------------------------

-- ORV (art_id = 2)

-- chapter 1
(2, 1, 'Pembaca', 
'', 
'Jan 14, 2018'),

-- chapter 2
(2, 2, 'Tiga Cara Bertahan dari Kiamat', 
'', 
'Jan 21, 2018'),

-- chapter 3
(2, 3, 'Protagonis Sejati', 
'', 
'Jan 28, 2018'),



---------------------------------------------------------------------------------------------------------------------------------------------------


-- Lord of Mysteries (art_id = 3)

-- chapter 1
(3, 1, 'Transmigrator', 
'', 
'Mar 2, 2018'),

-- chapter 2
(3, 2, 'Foolʼs Legacy', 
'', 
'Mar 9, 2018'),

-- chapter 3
(3, 3, 'Rahasia Beyonder', 
'', 
'Mar 16, 2018'),


---------------------------------------------------------------------------------------------------------------------------------------------------


-- 86 (art_id = 4)

-- chapter 1
(4, 1, 'Republik yang Berbohong', 
'', 
'Feb 10, 2017'),

-- chapter 2
(4, 2, 'Handler dan Spearhead', 
'', 
'Feb 17, 2017'),

-- chapter 3
(4, 3, 'Nama yang Sesungguhnya', 
'', 
'Feb 24, 2017'),


---------------------------------------------------------------------------------------------------------------------------------------------------


-- Janji (art_id = 5)

-- chapter 1
(5, 1, 'Permulaan Sebuah Janji', 
'', 
'Jan 1, 2019'),

-- chapter 2
(5, 2, 'Jarak dan Waktu', 
'', 
'Jan 8, 2019'),

-- chapter 3
(5, 3, 'Menepati atau Melepaskan', 
'', 
'Jan 15, 2019'),


---------------------------------------------------------------------------------------------------------------------------------------------------



-- Bumi (art_id = 6)

-- chapter 1
(6, 1, 'Dunia di Bawah Kaki Kita', 
'', 
'Oct 1, 2014'),

-- chapter 2
(6, 2, 'Klan Bulan', 
'', 
'Oct 8, 2014'),

-- chapter 3
(6, 3, 'Kekuatan Raib', 
'', 
'Oct 15, 2014'),


---------------------------------------------------------------------------------------------------------------------------------------------------


-- Welcome to NHK (art_id = 7)

-- chapter 1
(7, 1, 'Konspirasi NHK', 
'', 
'Sep 1, 2002'),

-- chapter 2
(7, 2, 'Gadis dan Proyek', 
'', 
'Sep 8, 2002'),

-- chapter 3
(7, 3, 'Hikikomori', 
'', 
'Sep 15, 2002'),


---------------------------------------------------------------------------------------------------------------------------------------------------


-- Reverend Insanity (art_id = 8)

-- chapter 1
(8, 1, 'Reinkarnasi Fang Yuan', 
'', 
'Mar 5, 2012'),

-- chapter 2
(8, 2, 'Gu Musim Semi dan Musim Gugur', 
'', 
'Mar 12, 2012'),

-- chapter 3
(8, 3, 'Jalan Keabadian', 
'', 
'Mar 19, 2012'),



---------------------------------------------------------------------------------------------------------------------------------------------------


-- Laskar Pelangi (art_id = 9)

-- chapter 1
(9, 1, 'SD Muhammadiyah', 
'', 
'Jan 1, 2005'),

-- chapter 2
(9, 2, 'Sepuluh Laskar', 
'', 
'Jan 8, 2005'),

-- chapter 3
(9, 3, 'Mimpi Ikal', 
'', 
'Jan 15, 2005'),



---------------------------------------------------------------------------------------------------------------------------------------------------


-- Metamorphosis (art_id = 10)

-- chapter 1
(10, 1, 'Kebangkitan Gregor', 
'', 
'Oct 15, 1915'),

-- chapter 2
(10, 2, 'Beban Keluarga', 
'', 
'Oct 22, 1915'),

-- chapter 3
(10, 3, 'Pembebasan', 
'', 
'Oct 29, 1915'),




---------------------------------------------------------------------------------------------------------------------------------------------------


-- Violet Evergarden (art_id = 11)

-- chapter 1
(11, 1, 'Auto Memory Doll', 
'', 
'Dec 25, 2015'),

-- chapter 2
(11, 2, 'Surat Pertama', 
'', 
'Jan 1, 2016'),

-- chapter 3
(11, 3, 'Makna Cinta', 
'', 
'Jan 8, 2016'),



---------------------------------------------------------------------------------------------------------------------------------------------------



-- Classroom of Elite (art_id = 12)

-- chapter 1
(12, 1, 'Kelas D', 
'', 
'May 25, 2015'),

-- chapter 2
(12, 2, 'Sistem Poin', 
'', 
'Jun 1, 2015'),

-- chapter 3
(12, 3, 'Strategi Ayanokoji', 
'', 
'Jun 8, 2015');



----------------------------------------------------------------------------------------------------------------------------------------------------


-- Comic chapter

INSERT INTO chapters (art_id, chapter_number, title, publised_at) VALUES
(13, 1, 'Vanished Memories', 'May 21, 2016'),
(14, 1, 'Boruto Uzumaki!!', 'May 9, 2016'),
(15, 1, 'Romance Dawn', 'Jul 22, 1997'),
(16, 1, 'Uzumaki Naruto!', 'Sep 21, 1999'),
(17, 1, 'Homecoming', 'Feb 15, 2007'),
(18, 1, 'I’m Used to It', 'Mar 4, 2018'),
(19, 1, 'Dog & Chainsaw', 'Dec 3, 2018'),
(20, 1, 'Ryomen Sukuna', 'Mar 5, 2018'),
(21, 1, 'To Challenge the Sun', 'Jul 12, 2001'),
(22, 1, 'It’s About Time', 'Jan 22, 2003'),
(23, 1, 'Spider-Man!', 'Mar 1, 1963'),
(24, 1, 'The Coming of Superman', 'Jun 1, 1938'),
(25, 1, 'The Name of the Game', 'Oct 6, 2006'),
(26, 1, 'Izuku Midoriya: Origin', 'Jul 7, 2014'),
(27, 1, 'Dream', 'Aug 1, 2018'),
(28, 1, 'Herr Doktor Tenma', 'Dec 5, 1994'),
(29, 1, 'End of the Century', 'Sep 27, 1999'),
(30, 1, 'Asta and Yuno', 'Feb 16, 2015'),
(31, 1, 'Look Back', 'Jul 19, 2021'),
(32, 1, 'You Guys!! Do You Even Have a Gintama?', 'Dec 8, 2003'),
(33, 1, 'Self-Proclaimed Psychic: Reigen Arataka ~And Mob~', 'Apr 18, 2012'),
(34, 1, 'The Mysterious Warrior From Space', 'Nov 20, 1989'),
(35, 1, 'Mission', 'Sep 19, 2023'),
(36, 1, 'Departure × And × Friends', 'Mar 3, 1998');


-- Per Halaman Chapter

INSERT INTO chapterPages (chapter_id, page_number, img_chapter_comic) VALUES

-- chapter_id 13 = Boruto: Two Blue Vortex
(13, 1,  'project/image/comic/boruto_tbv/chapter1/hal1.png'),
(13, 2,  'project/image/comic/boruto_tbv/chapter1/hal2.png'),
(13, 3,  'project/image/comic/boruto_tbv/chapter1/hal3.png'),
(13, 4,  'project/image/comic/boruto_tbv/chapter1/hal4.png'),
(13, 5,  'project/image/comic/boruto_tbv/chapter1/hal5.png'),
(13, 6,  'project/image/comic/boruto_tbv/chapter1/hal6.png'),
(13, 7,  'project/image/comic/boruto_tbv/chapter1/hal7.png'),
(13, 8,  'project/image/comic/boruto_tbv/chapter1/hal8.png'),
(13, 9,  'project/image/comic/boruto_tbv/chapter1/hal9.png'),
(13, 10, 'project/image/comic/boruto_tbv/chapter1/hal10.png'),
(13, 11, 'project/image/comic/boruto_tbv/chapter1/hal11.png'),
(13, 12, 'project/image/comic/boruto_tbv/chapter1/hal12.png'),
(13, 13, 'project/image/comic/boruto_tbv/chapter1/hal13.png'),
(13, 14, 'project/image/comic/boruto_tbv/chapter1/hal14.png'),
(13, 15, 'project/image/comic/boruto_tbv/chapter1/hal15.png'),
(13, 16, 'project/image/comic/boruto_tbv/chapter1/hal16.png'),
(13, 17, 'project/image/comic/boruto_tbv/chapter1/hal17.png'),
(13, 18, 'project/image/comic/boruto_tbv/chapter1/hal18.png'),
(13, 19, 'project/image/comic/boruto_tbv/chapter1/hal19.png'),
(13, 20, 'project/image/comic/boruto_tbv/chapter1/hal20.png'),

-- chapter_id 14 = Boruto: Naruto Next Generation
(14, 1,  'project/image/comic/boruto_nng/chapter1/hal1.png'),
(14, 2,  'project/image/comic/boruto_nng/chapter1/hal2.png'),
(14, 3,  'project/image/comic/boruto_nng/chapter1/hal3.png'),
(14, 4,  'project/image/comic/boruto_nng/chapter1/hal4.png'),
(14, 5,  'project/image/comic/boruto_nng/chapter1/hal5.png'),
(14, 6,  'project/image/comic/boruto_nng/chapter1/hal6.png'),
(14, 7,  'project/image/comic/boruto_nng/chapter1/hal7.png'),
(14, 8,  'project/image/comic/boruto_nng/chapter1/hal8.png'),
(14, 9,  'project/image/comic/boruto_nng/chapter1/hal9.png'),
(14, 10, 'project/image/comic/boruto_nng/chapter1/hal10.png'),
(14, 11, 'project/image/comic/boruto_nng/chapter1/hal11.png'),
(14, 12, 'project/image/comic/boruto_nng/chapter1/hal12.png'),
(14, 13, 'project/image/comic/boruto_nng/chapter1/hal13.png'),
(14, 14, 'project/image/comic/boruto_nng/chapter1/hal14.png'),
(14, 15, 'project/image/comic/boruto_nng/chapter1/hal15.png'),
(14, 16, 'project/image/comic/boruto_nng/chapter1/hal16.png'),
(14, 17, 'project/image/comic/boruto_nng/chapter1/hal17.png'),
(14, 18, 'project/image/comic/boruto_nng/chapter1/hal18.png'),
(14, 19, 'project/image/comic/boruto_nng/chapter1/hal19.png'),
(14, 20, 'project/image/comic/boruto_nng/chapter1/hal20.png'),

-- chapter_id 15 = One Piece
(15, 1,  'project/image/comic/one_piece/chapter1/hal1.png'),
(15, 2,  'project/image/comic/one_piece/chapter1/hal2.png'),
(15, 3,  'project/image/comic/one_piece/chapter1/hal3.png'),
(15, 4,  'project/image/comic/one_piece/chapter1/hal4.png'),
(15, 5,  'project/image/comic/one_piece/chapter1/hal5.png'),
(15, 6,  'project/image/comic/one_piece/chapter1/hal6.png'),
(15, 7,  'project/image/comic/one_piece/chapter1/hal7.png'),
(15, 8,  'project/image/comic/one_piece/chapter1/hal8.png'),
(15, 9,  'project/image/comic/one_piece/chapter1/hal9.png'),
(15, 10, 'project/image/comic/one_piece/chapter1/hal10.png'),
(15, 11, 'project/image/comic/one_piece/chapter1/hal11.png'),
(15, 12, 'project/image/comic/one_piece/chapter1/hal12.png'),
(15, 13, 'project/image/comic/one_piece/chapter1/hal13.png'),
(15, 14, 'project/image/comic/one_piece/chapter1/hal14.png'),
(15, 15, 'project/image/comic/one_piece/chapter1/hal15.png'),
(15, 16, 'project/image/comic/one_piece/chapter1/hal16.png'),
(15, 17, 'project/image/comic/one_piece/chapter1/hal17.png'),
(15, 18, 'project/image/comic/one_piece/chapter1/hal18.png'),
(15, 19, 'project/image/comic/one_piece/chapter1/hal19.png'),
(15, 20, 'project/image/comic/one_piece/chapter1/hal20.png'),

-- chapter_id 16 = Naruto
(16, 1,  'project/image/comic/naruto/chapter1/hal1.png'),
(16, 2,  'project/image/comic/naruto/chapter1/hal2.png'),
(16, 3,  'project/image/comic/naruto/chapter1/hal3.png'),
(16, 4,  'project/image/comic/naruto/chapter1/hal4.png'),
(16, 5,  'project/image/comic/naruto/chapter1/hal5.png'),
(16, 6,  'project/image/comic/naruto/chapter1/hal6.png'),
(16, 7,  'project/image/comic/naruto/chapter1/hal7.png'),
(16, 8,  'project/image/comic/naruto/chapter1/hal8.png'),
(16, 9,  'project/image/comic/naruto/chapter1/hal9.png'),
(16, 10, 'project/image/comic/naruto/chapter1/hal10.png'),
(16, 11, 'project/image/comic/naruto/chapter1/hal11.png'),
(16, 12, 'project/image/comic/naruto/chapter1/hal12.png'),
(16, 13, 'project/image/comic/naruto/chapter1/hal13.png'),
(16, 14, 'project/image/comic/naruto/chapter1/hal14.png'),
(16, 15, 'project/image/comic/naruto/chapter1/hal15.png'),
(16, 16, 'project/image/comic/naruto/chapter1/hal16.png'),
(16, 17, 'project/image/comic/naruto/chapter1/hal17.png'),
(16, 18, 'project/image/comic/naruto/chapter1/hal18.png'),
(16, 19, 'project/image/comic/naruto/chapter1/hal19.png'),
(16, 20, 'project/image/comic/naruto/chapter1/hal20.png'),

-- chapter_id 17 = Naruto Shippuden
(17, 1,  'project/image/comic/naruto_shippuden/chapter1/hal1.png'),
(17, 2,  'project/image/comic/naruto_shippuden/chapter1/hal2.png'),
(17, 3,  'project/image/comic/naruto_shippuden/chapter1/hal3.png'),
(17, 4,  'project/image/comic/naruto_shippuden/chapter1/hal4.png'),
(17, 5,  'project/image/comic/naruto_shippuden/chapter1/hal5.png'),
(17, 6,  'project/image/comic/naruto_shippuden/chapter1/hal6.png'),
(17, 7,  'project/image/comic/naruto_shippuden/chapter1/hal7.png'),
(17, 8,  'project/image/comic/naruto_shippuden/chapter1/hal8.png'),
(17, 9,  'project/image/comic/naruto_shippuden/chapter1/hal9.png'),
(17, 10, 'project/image/comic/naruto_shippuden/chapter1/hal10.png'),
(17, 11, 'project/image/comic/naruto_shippuden/chapter1/hal11.png'),
(17, 12, 'project/image/comic/naruto_shippuden/chapter1/hal12.png'),
(17, 13, 'project/image/comic/naruto_shippuden/chapter1/hal13.png'),
(17, 14, 'project/image/comic/naruto_shippuden/chapter1/hal14.png'),
(17, 15, 'project/image/comic/naruto_shippuden/chapter1/hal15.png'),
(17, 16, 'project/image/comic/naruto_shippuden/chapter1/hal16.png'),
(17, 17, 'project/image/comic/naruto_shippuden/chapter1/hal17.png'),
(17, 18, 'project/image/comic/naruto_shippuden/chapter1/hal18.png'),
(17, 19, 'project/image/comic/naruto_shippuden/chapter1/hal19.png'),
(17, 20, 'project/image/comic/naruto_shippuden/chapter1/hal20.png'),

-- chapter_id 18 = Solo Leveling
(18, 1,  'project/image/comic/solo_leveling/chapter1/hal1.png'),
(18, 2,  'project/image/comic/solo_leveling/chapter1/hal2.png'),
(18, 3,  'project/image/comic/solo_leveling/chapter1/hal3.png'),
(18, 4,  'project/image/comic/solo_leveling/chapter1/hal4.png'),
(18, 5,  'project/image/comic/solo_leveling/chapter1/hal5.png'),
(18, 6,  'project/image/comic/solo_leveling/chapter1/hal6.png'),
(18, 7,  'project/image/comic/solo_leveling/chapter1/hal7.png'),
(18, 8,  'project/image/comic/solo_leveling/chapter1/hal8.png'),
(18, 9,  'project/image/comic/solo_leveling/chapter1/hal9.png'),
(18, 10, 'project/image/comic/solo_leveling/chapter1/hal10.png'),
(18, 11, 'project/image/comic/solo_leveling/chapter1/hal11.png'),
(18, 12, 'project/image/comic/solo_leveling/chapter1/hal12.png'),
(18, 13, 'project/image/comic/solo_leveling/chapter1/hal13.png'),
(18, 14, 'project/image/comic/solo_leveling/chapter1/hal14.png'),
(18, 15, 'project/image/comic/solo_leveling/chapter1/hal15.png'),
(18, 16, 'project/image/comic/solo_leveling/chapter1/hal16.png'),
(18, 17, 'project/image/comic/solo_leveling/chapter1/hal17.png'),
(18, 18, 'project/image/comic/solo_leveling/chapter1/hal18.png'),
(18, 19, 'project/image/comic/solo_leveling/chapter1/hal19.png'),
(18, 20, 'project/image/comic/solo_leveling/chapter1/hal20.png'),

-- chapter_id 19 = Chainsaw Man
(19, 1,  'project/image/comic/chainsawman/chapter1/hal1.png'),
(19, 2,  'project/image/comic/chainsawman/chapter1/hal2.png'),
(19, 3,  'project/image/comic/chainsawman/chapter1/hal3.png'),
(19, 4,  'project/image/comic/chainsawman/chapter1/hal4.png'),
(19, 5,  'project/image/comic/chainsawman/chapter1/hal5.png'),
(19, 6,  'project/image/comic/chainsawman/chapter1/hal6.png'),
(19, 7,  'project/image/comic/chainsawman/chapter1/hal7.png'),
(19, 8,  'project/image/comic/chainsawman/chapter1/hal8.png'),
(19, 9,  'project/image/comic/chainsawman/chapter1/hal9.png'),
(19, 10, 'project/image/comic/chainsawman/chapter1/hal10.png'),
(19, 11, 'project/image/comic/chainsawman/chapter1/hal11.png'),
(19, 12, 'project/image/comic/chainsawman/chapter1/hal12.png'),
(19, 13, 'project/image/comic/chainsawman/chapter1/hal13.png'),
(19, 14, 'project/image/comic/chainsawman/chapter1/hal14.png'),
(19, 15, 'project/image/comic/chainsawman/chapter1/hal15.png'),
(19, 16, 'project/image/comic/chainsawman/chapter1/hal16.png'),
(19, 17, 'project/image/comic/chainsawman/chapter1/hal17.png'),
(19, 18, 'project/image/comic/chainsawman/chapter1/hal18.png'),
(19, 19, 'project/image/comic/chainsawman/chapter1/hal19.png'),
(19, 20, 'project/image/comic/chainsawman/chapter1/hal20.png'),

-- chapter_id 20 = Jujutsu Kaisen
(20, 1,  'project/image/comic/jujutsu_kaisen/chapter1/hal1.png'),
(20, 2,  'project/image/comic/jujutsu_kaisen/chapter1/hal2.png'),
(20, 3,  'project/image/comic/jujutsu_kaisen/chapter1/hal3.png'),
(20, 4,  'project/image/comic/jujutsu_kaisen/chapter1/hal4.png'),
(20, 5,  'project/image/comic/jujutsu_kaisen/chapter1/hal5.png'),
(20, 6,  'project/image/comic/jujutsu_kaisen/chapter1/hal6.png'),
(20, 7,  'project/image/comic/jujutsu_kaisen/chapter1/hal7.png'),
(20, 8,  'project/image/comic/jujutsu_kaisen/chapter1/hal8.png'),
(20, 9,  'project/image/comic/jujutsu_kaisen/chapter1/hal9.png'),
(20, 10, 'project/image/comic/jujutsu_kaisen/chapter1/hal10.png'),
(20, 11, 'project/image/comic/jujutsu_kaisen/chapter1/hal11.png'),
(20, 12, 'project/image/comic/jujutsu_kaisen/chapter1/hal12.png'),
(20, 13, 'project/image/comic/jujutsu_kaisen/chapter1/hal13.png'),
(20, 14, 'project/image/comic/jujutsu_kaisen/chapter1/hal14.png'),
(20, 15, 'project/image/comic/jujutsu_kaisen/chapter1/hal15.png'),
(20, 16, 'project/image/comic/jujutsu_kaisen/chapter1/hal16.png'),
(20, 17, 'project/image/comic/jujutsu_kaisen/chapter1/hal17.png'),
(20, 18, 'project/image/comic/jujutsu_kaisen/chapter1/hal18.png'),
(20, 19, 'project/image/comic/jujutsu_kaisen/chapter1/hal19.png'),
(20, 20, 'project/image/comic/jujutsu_kaisen/chapter1/hal20.png'),

-- chapter_id 21 = Fullmetal Alchemist
(21, 1,  'project/image/comic/fullmetal_alchemist/chapter1/hal1.png'),
(21, 2,  'project/image/comic/fullmetal_alchemist/chapter1/hal2.png'),
(21, 3,  'project/image/comic/fullmetal_alchemist/chapter1/hal3.png'),
(21, 4,  'project/image/comic/fullmetal_alchemist/chapter1/hal4.png'),
(21, 5,  'project/image/comic/fullmetal_alchemist/chapter1/hal5.png'),
(21, 6,  'project/image/comic/fullmetal_alchemist/chapter1/hal6.png'),
(21, 7,  'project/image/comic/fullmetal_alchemist/chapter1/hal7.png'),
(21, 8,  'project/image/comic/fullmetal_alchemist/chapter1/hal8.png'),
(21, 9,  'project/image/comic/fullmetal_alchemist/chapter1/hal9.png'),
(21, 10, 'project/image/comic/fullmetal_alchemist/chapter1/hal10.png'),
(21, 11, 'project/image/comic/fullmetal_alchemist/chapter1/hal11.png'),
(21, 12, 'project/image/comic/fullmetal_alchemist/chapter1/hal12.png'),
(21, 13, 'project/image/comic/fullmetal_alchemist/chapter1/hal13.png'),
(21, 14, 'project/image/comic/fullmetal_alchemist/chapter1/hal14.png'),
(21, 15, 'project/image/comic/fullmetal_alchemist/chapter1/hal15.png'),
(21, 16, 'project/image/comic/fullmetal_alchemist/chapter1/hal16.png'),
(21, 17, 'project/image/comic/fullmetal_alchemist/chapter1/hal17.png'),
(21, 18, 'project/image/comic/fullmetal_alchemist/chapter1/hal18.png'),
(21, 19, 'project/image/comic/fullmetal_alchemist/chapter1/hal19.png'),
(21, 20, 'project/image/comic/fullmetal_alchemist/chapter1/hal20.png'),

-- chapter_id 22 = Invincible
(22, 1,  'project/image/comic/invincible/chapter1/hal1.png'),
(22, 2,  'project/image/comic/invincible/chapter1/hal2.png'),
(22, 3,  'project/image/comic/invincible/chapter1/hal3.png'),
(22, 4,  'project/image/comic/invincible/chapter1/hal4.png'),
(22, 5,  'project/image/comic/invincible/chapter1/hal5.png'),
(22, 6,  'project/image/comic/invincible/chapter1/hal6.png'),
(22, 7,  'project/image/comic/invincible/chapter1/hal7.png'),
(22, 8,  'project/image/comic/invincible/chapter1/hal8.png'),
(22, 9,  'project/image/comic/invincible/chapter1/hal9.png'),
(22, 10, 'project/image/comic/invincible/chapter1/hal10.png'),
(22, 11, 'project/image/comic/invincible/chapter1/hal11.png'),
(22, 12, 'project/image/comic/invincible/chapter1/hal12.png'),
(22, 13, 'project/image/comic/invincible/chapter1/hal13.png'),
(22, 14, 'project/image/comic/invincible/chapter1/hal14.png'),
(22, 15, 'project/image/comic/invincible/chapter1/hal15.png'),
(22, 16, 'project/image/comic/invincible/chapter1/hal16.png'),
(22, 17, 'project/image/comic/invincible/chapter1/hal17.png'),
(22, 18, 'project/image/comic/invincible/chapter1/hal18.png'),
(22, 19, 'project/image/comic/invincible/chapter1/hal19.png'),
(22, 20, 'project/image/comic/invincible/chapter1/hal20.png'),

-- chapter_id 23 = Amazing Spider-Man
(23, 1,  'project/image/comic/amazing_spiderman/chapter1/hal1.png'),
(23, 2,  'project/image/comic/amazing_spiderman/chapter1/hal2.png'),
(23, 3,  'project/image/comic/amazing_spiderman/chapter1/hal3.png'),
(23, 4,  'project/image/comic/amazing_spiderman/chapter1/hal4.png'),
(23, 5,  'project/image/comic/amazing_spiderman/chapter1/hal5.png'),
(23, 6,  'project/image/comic/amazing_spiderman/chapter1/hal6.png'),
(23, 7,  'project/image/comic/amazing_spiderman/chapter1/hal7.png'),
(23, 8,  'project/image/comic/amazing_spiderman/chapter1/hal8.png'),
(23, 9,  'project/image/comic/amazing_spiderman/chapter1/hal9.png'),
(23, 10, 'project/image/comic/amazing_spiderman/chapter1/hal10.png'),
(23, 11, 'project/image/comic/amazing_spiderman/chapter1/hal11.png'),
(23, 12, 'project/image/comic/amazing_spiderman/chapter1/hal12.png'),
(23, 13, 'project/image/comic/amazing_spiderman/chapter1/hal13.png'),
(23, 14, 'project/image/comic/amazing_spiderman/chapter1/hal14.png'),
(23, 15, 'project/image/comic/amazing_spiderman/chapter1/hal15.png'),
(23, 16, 'project/image/comic/amazing_spiderman/chapter1/hal16.png'),
(23, 17, 'project/image/comic/amazing_spiderman/chapter1/hal17.png'),
(23, 18, 'project/image/comic/amazing_spiderman/chapter1/hal18.png'),
(23, 19, 'project/image/comic/amazing_spiderman/chapter1/hal19.png'),
(23, 20, 'project/image/comic/amazing_spiderman/chapter1/hal20.png'),

-- chapter_id 24 = Superman
(24, 1,  'project/image/comic/superman/chapter1/hal1.png'),
(24, 2,  'project/image/comic/superman/chapter1/hal2.png'),
(24, 3,  'project/image/comic/superman/chapter1/hal3.png'),
(24, 4,  'project/image/comic/superman/chapter1/hal4.png'),
(24, 5,  'project/image/comic/superman/chapter1/hal5.png'),
(24, 6,  'project/image/comic/superman/chapter1/hal6.png'),
(24, 7,  'project/image/comic/superman/chapter1/hal7.png'),
(24, 8,  'project/image/comic/superman/chapter1/hal8.png'),
(24, 9,  'project/image/comic/superman/chapter1/hal9.png'),
(24, 10, 'project/image/comic/superman/chapter1/hal10.png'),
(24, 11, 'project/image/comic/superman/chapter1/hal11.png'),
(24, 12, 'project/image/comic/superman/chapter1/hal12.png'),
(24, 13, 'project/image/comic/superman/chapter1/hal13.png'),
(24, 14, 'project/image/comic/superman/chapter1/hal14.png'),
(24, 15, 'project/image/comic/superman/chapter1/hal15.png'),
(24, 16, 'project/image/comic/superman/chapter1/hal16.png'),
(24, 17, 'project/image/comic/superman/chapter1/hal17.png'),
(24, 18, 'project/image/comic/superman/chapter1/hal18.png'),
(24, 19, 'project/image/comic/superman/chapter1/hal19.png'),
(24, 20, 'project/image/comic/superman/chapter1/hal20.png'),

-- chapter_id 25 = The Boys
(25, 1,  'project/image/comic/the_boys/chapter1/hal1.png'),
(25, 2,  'project/image/comic/the_boys/chapter1/hal2.png'),
(25, 3,  'project/image/comic/the_boys/chapter1/hal3.png'),
(25, 4,  'project/image/comic/the_boys/chapter1/hal4.png'),
(25, 5,  'project/image/comic/the_boys/chapter1/hal5.png'),
(25, 6,  'project/image/comic/the_boys/chapter1/hal6.png'),
(25, 7,  'project/image/comic/the_boys/chapter1/hal7.png'),
(25, 8,  'project/image/comic/the_boys/chapter1/hal8.png'),
(25, 9,  'project/image/comic/the_boys/chapter1/hal9.png'),
(25, 10, 'project/image/comic/the_boys/chapter1/hal10.png'),
(25, 11, 'project/image/comic/the_boys/chapter1/hal11.png'),
(25, 12, 'project/image/comic/the_boys/chapter1/hal12.png'),
(25, 13, 'project/image/comic/the_boys/chapter1/hal13.png'),
(25, 14, 'project/image/comic/the_boys/chapter1/hal14.png'),
(25, 15, 'project/image/comic/the_boys/chapter1/hal15.png'),
(25, 16, 'project/image/comic/the_boys/chapter1/hal16.png'),
(25, 17, 'project/image/comic/the_boys/chapter1/hal17.png'),
(25, 18, 'project/image/comic/the_boys/chapter1/hal18.png'),
(25, 19, 'project/image/comic/the_boys/chapter1/hal19.png'),
(25, 20, 'project/image/comic/the_boys/chapter1/hal20.png'),

-- chapter_id 26 = My Hero Academia
(26, 1,  'project/image/comic/my_hero_academia/chapter1/hal1.png'),
(26, 2,  'project/image/comic/my_hero_academia/chapter1/hal2.png'),
(26, 3,  'project/image/comic/my_hero_academia/chapter1/hal3.png'),
(26, 4,  'project/image/comic/my_hero_academia/chapter1/hal4.png'),
(26, 5,  'project/image/comic/my_hero_academia/chapter1/hal5.png'),
(26, 6,  'project/image/comic/my_hero_academia/chapter1/hal6.png'),
(26, 7,  'project/image/comic/my_hero_academia/chapter1/hal7.png'),
(26, 8,  'project/image/comic/my_hero_academia/chapter1/hal8.png'),
(26, 9,  'project/image/comic/my_hero_academia/chapter1/hal9.png'),
(26, 10, 'project/image/comic/my_hero_academia/chapter1/hal10.png'),
(26, 11, 'project/image/comic/my_hero_academia/chapter1/hal11.png'),
(26, 12, 'project/image/comic/my_hero_academia/chapter1/hal12.png'),
(26, 13, 'project/image/comic/my_hero_academia/chapter1/hal13.png'),
(26, 14, 'project/image/comic/my_hero_academia/chapter1/hal14.png'),
(26, 15, 'project/image/comic/my_hero_academia/chapter1/hal15.png'),
(26, 16, 'project/image/comic/my_hero_academia/chapter1/hal16.png'),
(26, 17, 'project/image/comic/my_hero_academia/chapter1/hal17.png'),
(26, 18, 'project/image/comic/my_hero_academia/chapter1/hal18.png'),
(26, 19, 'project/image/comic/my_hero_academia/chapter1/hal19.png'),
(26, 20, 'project/image/comic/my_hero_academia/chapter1/hal20.png'),

-- chapter_id 27 = Blue Lock
(27, 1,  'project/image/comic/blue_lock/chapter1/hal1.png'),
(27, 2,  'project/image/comic/blue_lock/chapter1/hal2.png'),
(27, 3,  'project/image/comic/blue_lock/chapter1/hal3.png'),
(27, 4,  'project/image/comic/blue_lock/chapter1/hal4.png'),
(27, 5,  'project/image/comic/blue_lock/chapter1/hal5.png'),
(27, 6,  'project/image/comic/blue_lock/chapter1/hal6.png'),
(27, 7,  'project/image/comic/blue_lock/chapter1/hal7.png'),
(27, 8,  'project/image/comic/blue_lock/chapter1/hal8.png'),
(27, 9,  'project/image/comic/blue_lock/chapter1/hal9.png'),
(27, 10, 'project/image/comic/blue_lock/chapter1/hal10.png'),
(27, 11, 'project/image/comic/blue_lock/chapter1/hal11.png'),
(27, 12, 'project/image/comic/blue_lock/chapter1/hal12.png'),
(27, 13, 'project/image/comic/blue_lock/chapter1/hal13.png'),
(27, 14, 'project/image/comic/blue_lock/chapter1/hal14.png'),
(27, 15, 'project/image/comic/blue_lock/chapter1/hal15.png'),
(27, 16, 'project/image/comic/blue_lock/chapter1/hal16.png'),
(27, 17, 'project/image/comic/blue_lock/chapter1/hal17.png'),
(27, 18, 'project/image/comic/blue_lock/chapter1/hal18.png'),
(27, 19, 'project/image/comic/blue_lock/chapter1/hal19.png'),
(27, 20, 'project/image/comic/blue_lock/chapter1/hal20.png'),

-- chapter_id 28 = Monster
(28, 1,  'project/image/comic/monster/chapter1/hal1.png'),
(28, 2,  'project/image/comic/monster/chapter1/hal2.png'),
(28, 3,  'project/image/comic/monster/chapter1/hal3.png'),
(28, 4,  'project/image/comic/monster/chapter1/hal4.png'),
(28, 5,  'project/image/comic/monster/chapter1/hal5.png'),
(28, 6,  'project/image/comic/monster/chapter1/hal6.png'),
(28, 7,  'project/image/comic/monster/chapter1/hal7.png'),
(28, 8,  'project/image/comic/monster/chapter1/hal8.png'),
(28, 9,  'project/image/comic/monster/chapter1/hal9.png'),
(28, 10, 'project/image/comic/monster/chapter1/hal10.png'),
(28, 11, 'project/image/comic/monster/chapter1/hal11.png'),
(28, 12, 'project/image/comic/monster/chapter1/hal12.png'),
(28, 13, 'project/image/comic/monster/chapter1/hal13.png'),
(28, 14, 'project/image/comic/monster/chapter1/hal14.png'),
(28, 15, 'project/image/comic/monster/chapter1/hal15.png'),
(28, 16, 'project/image/comic/monster/chapter1/hal16.png'),
(28, 17, 'project/image/comic/monster/chapter1/hal17.png'),
(28, 18, 'project/image/comic/monster/chapter1/hal18.png'),
(28, 19, 'project/image/comic/monster/chapter1/hal19.png'),
(28, 20, 'project/image/comic/monster/chapter1/hal20.png'),

-- chapter_id 29 = 20th Century Boys
(29, 1,  'project/image/comic/20th_century_boys/chapter1/hal1.png'),
(29, 2,  'project/image/comic/20th_century_boys/chapter1/hal2.png'),
(29, 3,  'project/image/comic/20th_century_boys/chapter1/hal3.png'),
(29, 4,  'project/image/comic/20th_century_boys/chapter1/hal4.png'),
(29, 5,  'project/image/comic/20th_century_boys/chapter1/hal5.png'),
(29, 6,  'project/image/comic/20th_century_boys/chapter1/hal6.png'),
(29, 7,  'project/image/comic/20th_century_boys/chapter1/hal7.png'),
(29, 8,  'project/image/comic/20th_century_boys/chapter1/hal8.png'),
(29, 9,  'project/image/comic/20th_century_boys/chapter1/hal9.png'),
(29, 10, 'project/image/comic/20th_century_boys/chapter1/hal10.png'),
(29, 11, 'project/image/comic/20th_century_boys/chapter1/hal11.png'),
(29, 12, 'project/image/comic/20th_century_boys/chapter1/hal12.png'),
(29, 13, 'project/image/comic/20th_century_boys/chapter1/hal13.png'),
(29, 14, 'project/image/comic/20th_century_boys/chapter1/hal14.png'),
(29, 15, 'project/image/comic/20th_century_boys/chapter1/hal15.png'),
(29, 16, 'project/image/comic/20th_century_boys/chapter1/hal16.png'),
(29, 17, 'project/image/comic/20th_century_boys/chapter1/hal17.png'),
(29, 18, 'project/image/comic/20th_century_boys/chapter1/hal18.png'),
(29, 19, 'project/image/comic/20th_century_boys/chapter1/hal19.png'),
(29, 20, 'project/image/comic/20th_century_boys/chapter1/hal20.png'),

-- chapter_id 30 = Black Clover
(30, 1,  'project/image/comic/black_clover/chapter1/hal1.png'),
(30, 2,  'project/image/comic/black_clover/chapter1/hal2.png'),
(30, 3,  'project/image/comic/black_clover/chapter1/hal3.png'),
(30, 4,  'project/image/comic/black_clover/chapter1/hal4.png'),
(30, 5,  'project/image/comic/black_clover/chapter1/hal5.png'),
(30, 6,  'project/image/comic/black_clover/chapter1/hal6.png'),
(30, 7,  'project/image/comic/black_clover/chapter1/hal7.png'),
(30, 8,  'project/image/comic/black_clover/chapter1/hal8.png'),
(30, 9,  'project/image/comic/black_clover/chapter1/hal9.png'),
(30, 10, 'project/image/comic/black_clover/chapter1/hal10.png'),
(30, 11, 'project/image/comic/black_clover/chapter1/hal11.png'),
(30, 12, 'project/image/comic/black_clover/chapter1/hal12.png'),
(30, 13, 'project/image/comic/black_clover/chapter1/hal13.png'),
(30, 14, 'project/image/comic/black_clover/chapter1/hal14.png'),
(30, 15, 'project/image/comic/black_clover/chapter1/hal15.png'),
(30, 16, 'project/image/comic/black_clover/chapter1/hal16.png'),
(30, 17, 'project/image/comic/black_clover/chapter1/hal17.png'),
(30, 18, 'project/image/comic/black_clover/chapter1/hal18.png'),
(30, 19, 'project/image/comic/black_clover/chapter1/hal19.png'),
(30, 20, 'project/image/comic/black_clover/chapter1/hal20.png'),

-- chapter_id 31 = Look Back
(31, 1,  'project/image/comic/look_back/chapter1/hal1.png'),
(31, 2,  'project/image/comic/look_back/chapter1/hal2.png'),
(31, 3,  'project/image/comic/look_back/chapter1/hal3.png'),
(31, 4,  'project/image/comic/look_back/chapter1/hal4.png'),
(31, 5,  'project/image/comic/look_back/chapter1/hal5.png'),
(31, 6,  'project/image/comic/look_back/chapter1/hal6.png'),
(31, 7,  'project/image/comic/look_back/chapter1/hal7.png'),
(31, 8,  'project/image/comic/look_back/chapter1/hal8.png'),
(31, 9,  'project/image/comic/look_back/chapter1/hal9.png'),
(31, 10, 'project/image/comic/look_back/chapter1/hal10.png'),
(31, 11, 'project/image/comic/look_back/chapter1/hal11.png'),
(31, 12, 'project/image/comic/look_back/chapter1/hal12.png'),
(31, 13, 'project/image/comic/look_back/chapter1/hal13.png'),
(31, 14, 'project/image/comic/look_back/chapter1/hal14.png'),
(31, 15, 'project/image/comic/look_back/chapter1/hal15.png'),
(31, 16, 'project/image/comic/look_back/chapter1/hal16.png'),
(31, 17, 'project/image/comic/look_back/chapter1/hal17.png'),
(31, 18, 'project/image/comic/look_back/chapter1/hal18.png'),
(31, 19, 'project/image/comic/look_back/chapter1/hal19.png'),
(31, 20, 'project/image/comic/look_back/chapter1/hal20.png'),

-- chapter_id 32 = Gintama
(32, 1,  'project/image/comic/gintama/chapter1/hal1.png'),
(32, 2,  'project/image/comic/gintama/chapter1/hal2.png'),
(32, 3,  'project/image/comic/gintama/chapter1/hal3.png'),
(32, 4,  'project/image/comic/gintama/chapter1/hal4.png'),
(32, 5,  'project/image/comic/gintama/chapter1/hal5.png'),
(32, 6,  'project/image/comic/gintama/chapter1/hal6.png'),
(32, 7,  'project/image/comic/gintama/chapter1/hal7.png'),
(32, 8,  'project/image/comic/gintama/chapter1/hal8.png'),
(32, 9,  'project/image/comic/gintama/chapter1/hal9.png'),
(32, 10, 'project/image/comic/gintama/chapter1/hal10.png'),
(32, 11, 'project/image/comic/gintama/chapter1/hal11.png'),
(32, 12, 'project/image/comic/gintama/chapter1/hal12.png'),
(32, 13, 'project/image/comic/gintama/chapter1/hal13.png'),
(32, 14, 'project/image/comic/gintama/chapter1/hal14.png'),
(32, 15, 'project/image/comic/gintama/chapter1/hal15.png'),
(32, 16, 'project/image/comic/gintama/chapter1/hal16.png'),
(32, 17, 'project/image/comic/gintama/chapter1/hal17.png'),
(32, 18, 'project/image/comic/gintama/chapter1/hal18.png'),
(32, 19, 'project/image/comic/gintama/chapter1/hal19.png'),
(32, 20, 'project/image/comic/gintama/chapter1/hal20.png'),

-- chapter_id 33 = Mob Psycho 100
(33, 1,  'project/image/comic/mob_psycho_100/chapter1/hal1.png'),
(33, 2,  'project/image/comic/mob_psycho_100/chapter1/hal2.png'),
(33, 3,  'project/image/comic/mob_psycho_100/chapter1/hal3.png'),
(33, 4,  'project/image/comic/mob_psycho_100/chapter1/hal4.png'),
(33, 5,  'project/image/comic/mob_psycho_100/chapter1/hal5.png'),
(33, 6,  'project/image/comic/mob_psycho_100/chapter1/hal6.png'),
(33, 7,  'project/image/comic/mob_psycho_100/chapter1/hal7.png'),
(33, 8,  'project/image/comic/mob_psycho_100/chapter1/hal8.png'),
(33, 9,  'project/image/comic/mob_psycho_100/chapter1/hal9.png'),
(33, 10, 'project/image/comic/mob_psycho_100/chapter1/hal10.png'),
(33, 11, 'project/image/comic/mob_psycho_100/chapter1/hal11.png'),
(33, 12, 'project/image/comic/mob_psycho_100/chapter1/hal12.png'),
(33, 13, 'project/image/comic/mob_psycho_100/chapter1/hal13.png'),
(33, 14, 'project/image/comic/mob_psycho_100/chapter1/hal14.png'),
(33, 15, 'project/image/comic/mob_psycho_100/chapter1/hal15.png'),
(33, 16, 'project/image/comic/mob_psycho_100/chapter1/hal16.png'),
(33, 17, 'project/image/comic/mob_psycho_100/chapter1/hal17.png'),
(33, 18, 'project/image/comic/mob_psycho_100/chapter1/hal18.png'),
(33, 19, 'project/image/comic/mob_psycho_100/chapter1/hal19.png'),
(33, 20, 'project/image/comic/mob_psycho_100/chapter1/hal20.png'),

-- chapter_id 34 = Dragon Ball Z
(34, 1,  'project/image/comic/dragon_ball_z/chapter1/hal1.png'),
(34, 2,  'project/image/comic/dragon_ball_z/chapter1/hal2.png'),
(34, 3,  'project/image/comic/dragon_ball_z/chapter1/hal3.png'),
(34, 4,  'project/image/comic/dragon_ball_z/chapter1/hal4.png'),
(34, 5,  'project/image/comic/dragon_ball_z/chapter1/hal5.png'),
(34, 6,  'project/image/comic/dragon_ball_z/chapter1/hal6.png'),
(34, 7,  'project/image/comic/dragon_ball_z/chapter1/hal7.png'),
(34, 8,  'project/image/comic/dragon_ball_z/chapter1/hal8.png'),
(34, 9,  'project/image/comic/dragon_ball_z/chapter1/hal9.png'),
(34, 10, 'project/image/comic/dragon_ball_z/chapter1/hal10.png'),
(34, 11, 'project/image/comic/dragon_ball_z/chapter1/hal11.png'),
(34, 12, 'project/image/comic/dragon_ball_z/chapter1/hal12.png'),
(34, 13, 'project/image/comic/dragon_ball_z/chapter1/hal13.png'),
(34, 14, 'project/image/comic/dragon_ball_z/chapter1/hal14.png'),
(34, 15, 'project/image/comic/dragon_ball_z/chapter1/hal15.png'),
(34, 16, 'project/image/comic/dragon_ball_z/chapter1/hal16.png'),
(34, 17, 'project/image/comic/dragon_ball_z/chapter1/hal17.png'),
(34, 18, 'project/image/comic/dragon_ball_z/chapter1/hal18.png'),
(34, 19, 'project/image/comic/dragon_ball_z/chapter1/hal19.png'),
(34, 20, 'project/image/comic/dragon_ball_z/chapter1/hal20.png'),

-- chapter_id 35 = Kagurabachi
(35, 1,  'project/image/comic/kagurabachi/chapter1/hal1.png'),
(35, 2,  'project/image/comic/kagurabachi/chapter1/hal2.png'),
(35, 3,  'project/image/comic/kagurabachi/chapter1/hal3.png'),
(35, 4,  'project/image/comic/kagurabachi/chapter1/hal4.png'),
(35, 5,  'project/image/comic/kagurabachi/chapter1/hal5.png'),
(35, 6,  'project/image/comic/kagurabachi/chapter1/hal6.png'),
(35, 7,  'project/image/comic/kagurabachi/chapter1/hal7.png'),
(35, 8,  'project/image/comic/kagurabachi/chapter1/hal8.png'),
(35, 9,  'project/image/comic/kagurabachi/chapter1/hal9.png'),
(35, 10, 'project/image/comic/kagurabachi/chapter1/hal10.png'),
(35, 11, 'project/image/comic/kagurabachi/chapter1/hal11.png'),
(35, 12, 'project/image/comic/kagurabachi/chapter1/hal12.png'),
(35, 13, 'project/image/comic/kagurabachi/chapter1/hal13.png'),
(35, 14, 'project/image/comic/kagurabachi/chapter1/hal14.png'),
(35, 15, 'project/image/comic/kagurabachi/chapter1/hal15.png'),
(35, 16, 'project/image/comic/kagurabachi/chapter1/hal16.png'),
(35, 17, 'project/image/comic/kagurabachi/chapter1/hal17.png'),
(35, 18, 'project/image/comic/kagurabachi/chapter1/hal18.png'),
(35, 19, 'project/image/comic/kagurabachi/chapter1/hal19.png'),
(35, 20, 'project/image/comic/kagurabachi/chapter1/hal20.png'),

-- chapter_id 36 = Hunter x Hunter
(36, 1,  'project/image/comic/hunter_x_hunter/chapter1/hal1.png'),
(36, 2,  'project/image/comic/hunter_x_hunter/chapter1/hal2.png'),
(36, 3,  'project/image/comic/hunter_x_hunter/chapter1/hal3.png'),
(36, 4,  'project/image/comic/hunter_x_hunter/chapter1/hal4.png'),
(36, 5,  'project/image/comic/hunter_x_hunter/chapter1/hal5.png'),
(36, 6,  'project/image/comic/hunter_x_hunter/chapter1/hal6.png'),
(36, 7,  'project/image/comic/hunter_x_hunter/chapter1/hal7.png'),
(36, 8,  'project/image/comic/hunter_x_hunter/chapter1/hal8.png'),
(36, 9,  'project/image/comic/hunter_x_hunter/chapter1/hal9.png'),
(36, 10, 'project/image/comic/hunter_x_hunter/chapter1/hal10.png'),
(36, 11, 'project/image/comic/hunter_x_hunter/chapter1/hal11.png'),
(36, 12, 'project/image/comic/hunter_x_hunter/chapter1/hal12.png'),
(36, 13, 'project/image/comic/hunter_x_hunter/chapter1/hal13.png'),
(36, 14, 'project/image/comic/hunter_x_hunter/chapter1/hal14.png'),
(36, 15, 'project/image/comic/hunter_x_hunter/chapter1/hal15.png'),
(36, 16, 'project/image/comic/hunter_x_hunter/chapter1/hal16.png'),
(36, 17, 'project/image/comic/hunter_x_hunter/chapter1/hal17.png'),
(36, 18, 'project/image/comic/hunter_x_hunter/chapter1/hal18.png'),
(36, 19, 'project/image/comic/hunter_x_hunter/chapter1/hal19.png'),
(36, 20, 'project/image/comic/hunter_x_hunter/chapter1/hal20.png');



----------------------------------------------------------------------------------------------------------------------------------------------------


/* TAG, GENRE, MOOD */

INSERT INTO genres (genre) VALUES
('Action'), -- 1g
('Adventure'), -- 2g
('Apocalyptic'), -- 3g
('Bullet Hell'), -- 4g
('Comedy'), -- 5g
('Coming of Age'), -- 6g
('Dark Fantasy'), -- 7g
('Dark Superhero'), -- 8g
('Drama'), -- 9g
('Fantasy'), -- 10g
('Farming'), -- 11g
('Gothic Horror'), -- 12g
('Horror'), -- 13g
('Indie'), -- 14g
('Isekai'), -- 15g
('Martial Arts'), -- 16g
('Metafiction'), -- 17g
('Metroidvania'), -- 18g
('Military'), -- 19g
('Mystery'), -- 20g
('Ninja'), -- 21g
('Platformer'), -- 22g
('Psychological'), -- 23g
('Regression') -- 24g
('RPG'), -- 25g
('Roguelike'), -- 26g
('Romance'), -- 27g
('Satire'), -- 28g
('School'), -- 29g
('Sci-Fi'), -- 30g
('Shonen'), -- 31g
('Simulation'), -- 32g
('Slice of Life'), -- 33g
('Sports'), -- 34g
('Steampunk'), -- 35g
('Strategy'), -- 36g
('Superhero'), -- 37g
('Supernatural'), -- 38g
('Thriller'), -- 39g
('Time Travel'), -- 40g
('Transmigration') -- 41g
('Visual Novel'), -- 42g
('Young Adult'); -- 43g

INSERT INTO tags (tag) VALUES
('Absurd Humor'), -- 1t
('Alchemy'), -- 2t
('Aliens'), -- 3t
('Antihero'), -- 4t
('Apocalypse'), -- 5t
('Art'), -- 6t
('Anxiety'), -- 7t
('Battles'), -- 8t
('Betrayal'), -- 9t
('Brotherhood'), -- 10t
('Butterfly Effect'), -- 11t
('Challenge'), -- 12t
('Chaos'), -- 13t
('Character Developments'), -- 14t
('Chase'), -- 15t
('Childhood'), -- 16t
('Choices Matter'), -- 17t
('Choice Driven Story'), -- 18t
('Climbing'), -- 19t
('Combat'), -- 20t
('Competition'), -- 21t
('Conspiracy'), -- 22t
('Corruption'), -- 23t
('Crafting'), -- 24t
('Creativity'), -- 25t
('Cultivation'), -- 26t
('Cults'), -- 27t
('Curses'), -- 28t
('Death Loop'), -- 29t
('Death Reset'), -- 30t
('Demons'), -- 31t
('Depression'), -- 32t
('Destiny'), -- 33t
('Devils'), -- 34t
('Distortion'), -- 35t
('Dodging'), -- 36t
('Dream World'), -- 37t
('Education'), -- 38t
('Ego'), -- 39t
('Emotional Bonds'), -- 40t
('Emotional Conflict'), -- 41t
('Emotional Healing'), -- 42t
('Exploration'), -- 43t
('Fairies'), -- 44t
('Family'), -- 45t
('Fear'), -- 46t
('Fear Mechanics'), -- 47t
('Fighting'), -- 48t
('Football'), -- 49t
('Freedom'), -- 50t
('Friendship'), -- 51t
('Game System'), -- 52t
('Gods'), -- 53t
('Government Control'), -- 54t
('Growth'), -- 55t
('Hero School'), -- 56t
('Hero Symbol'), -- 57t
('Heroism'), -- 58t
('Hidden Power'), -- 59t
('Hope'), -- 60t
('Hunters'), -- 61t
('Humanity'), -- 62t
('Identity'), -- 63t
('Identity Loss'), -- 64t
('Intelligence Games'), -- 65t
('Investigation'), -- 66t
('Justice'), -- 67t
('Killing Game'), -- 68t
('Kingdoms'), -- 69t
('Lab Group'), -- 70t
('Legacy'), -- 71t
('Letters'), -- 72t
('Leveling System'), -- 73t
('Logic Battles'), -- 74t
('Loss'), -- 75t
('Magic'), -- 76t
('Manipulation'), -- 77t
('Mecha'), -- 78t
('Mental Health'), -- 79t
('Monsters'), -- 80t
('Moral Choices'), -- 81t
('Moral Dilemma'), -- 82t
('Murder'), -- 83t
('Multiple Endings'), -- 84t
('Mythology'), -- 85t
('Next Generation'), -- 86t
('NEET'), -- 87t
('Nostalgia'), -- 88t
('Obsession'), -- 89t
('Overpowered MC'), -- 90t
('Pacifism'), -- 91t
('Paranoia'), -- 92t
('Parody'), -- 93t
('Philosophy'), -- 94t
('Poverty'), -- 95t
('Surrealism'); -- 96t
('Power Scaling'), -- 97t
('Power System'), -- 98t
('Promise'), -- 99t
('Protagonist Knowledge'), -- 100t
('Psychic Powers'), -- 101t
('Quirks'), -- 102t
('Racism'), -- 103t
('Reality Breakdown'), -- 104t
('Redemption'), -- 105t
('Reincarnation'), -- 106t
('Relationships'), -- 107t
('Relaxation'), -- 108t
('Responsibility'), -- 109t
('Revenge'), -- 110t
('Rivalry'), -- 111t
('Rituals'), -- 112t
('Rural Horror'), -- 113t
('Sacrifice'), -- 114t
('Samurai'), -- 115t
('School Life'), -- 116t
('Serial Killer'), -- 117t
('Social Withdrawal'), -- 118t
('Sorcery'), -- 119t
('Souls'), -- 120t
('Spell Cards'), -- 121t
('Survival'), -- 122t
('Swordsman'), -- 123t
('Teen Life'), -- 124t
('Time Loop'), -- 125t
('Time Machine'), -- 126t
('Tragedy'), -- 127t
('Transformation'), -- 128t
('Treasure Hunt'), -- 129t
('Trials'), -- 130t
('Underdog'), -- 131t
('Urban Crime'), -- 132t
('Violence'), -- 133t
('Villain Protagonist'), -- 134t
('Victorian Era'), -- 135t
('War'), -- 136t
('War Aftermath'), -- 137t
('War Arc'), -- 138t
('Witch'), -- 139t
('Time Skip'), -- 140t

INSERT INTO moods (mood) VALUES
('Abstract'), -- 1m
('Adventurous'), -- 2m
('Aggressive'), -- 3m
('Atmospheric'), -- 4m
('Beautiful'), -- 5m
('Bittersweet'), -- 6m
('Brutal'), -- 7m
('Chaotic'), -- 8m
('Challenging'), -- 9m
('Cold'), -- 10m
('Comedic'), -- 11m
('Complex'), -- 12m
('Cynical'), -- 13m
('Dark'), -- 14m
('Depressing'), -- 15m
('Disturbing'), -- 16m
('Dramatic'), -- 17m
('Dreamlike'), -- 18m
('Emotional'), -- 19m
('Energetic'), -- 20m
('Heartwarming'), -- 21m
('Heroic'), -- 22m
('Hopeful'), -- 23m
('Hopeless'), -- 24m
('Inspirational'), -- 25m
('Intense'), -- 26m
('Lonely'), -- 27m
('Melancholic'), -- 28m
('Mind bending'), -- 29m
('Mysterious'), -- 30m
('Nostalgic'), -- 31m
('Paranoid'), -- 32m
('Peaceful'), -- 33m
('Philosophical'), -- 34m
('Realistic'), -- 35m
('Rhythmic'), -- 36m
('Serious'), -- 37m
('Smart'), -- 38m
('Strategic'), -- 39m
('Suspenseful'), -- 40m
('Tragic'), -- 41m
('Twisted'), -- 42m
('Unpredictable'), -- 43m
('Cool'), -- 44m
('Reflective'), -- 45m
('Competitive'); -- 46m


-- Pivot

INSERT INTO art_genres (art_id, genre_id) VALUES

/* ReZero Genre */
(1, 7),  -- Dark Fantasy (7g)
(1, 15), -- Isekai (15g)
(1, 23), -- Psychological (23g)
(1, 39), -- Thriller (39g)

/* ORV Genre */
(2, 10), -- Fantasy (10g)
(2, 1),  -- Action (1g)
(2, 3),  -- Apocalyptic (3g)
(2, 17), -- Metafiction (17g)

/* Lord of the Mysteries Genre */
(3, 7),  -- Dark Fantasy (7g)
(3, 35), -- Steampunk (35g)
(3, 20), -- Mystery (20g)
(3, 13), -- Horror (13g)
(3, 36), -- Strategy (36g)
(3, 15), -- Isekai (15g)
(3, 41), -- Transmigration (41g)

/* 86 Eighty-Six Genre */
(4, 19), -- Military (19g)
(4, 30), -- Sci-Fi (30g)
(4, 9),  -- Drama (9g)
(4, 23), -- Psychological (23g)

/* Janji Genre */
(5, 9),  -- Drama (9g)
(5, 27), -- Romance (27g)

/* Bumi Genre */
(6, 10), -- Fantasy (10g)
(6, 2),  -- Adventure (2g)
(6, 43), -- Young Adult (43g)

/* Trully Monster Genre */
(7, 33), -- Slice of Life (33g)
(7, 5),  -- Comedy (5g)
(7, 9),  -- Drama (9g)
(7, 41), -- Transmigration (41g)

/* Welcome to the NHK Genre */
(8, 23), -- Psychological (23g)
(8, 9),  -- Drama (9g)
(8, 33), -- Slice of Life (33g)

/* Reverend Insanity Genre */
(9, 7),  -- Dark Fantasy (7g)
(9, 23), -- Psychological (23g)
(9, 24), -- Regression (24g)
(9, 15), -- Isekai (15g)

/* Laskar Pelangi Genre */
(10, 6),  -- Coming of Age (6g)
(10, 9),  -- Drama (9g)

/* Metamorphosis Genre */
(11, 23), -- Psychological (23g)
(11, 9),  -- Drama (9g)

/* Violet Evergarden Genre */
(12, 9),  -- Drama (9g)
(12, 33), -- Slice of Life (33g)

/* Classroom of the Elite Genre */
(13, 23), -- Psychological (23g)
(13, 29), -- School (29g)
(13, 9),  -- Drama (9g)
(13, 36), -- Strategy (36g)

/* Boruto: Two Blue Vortex Genre */
(14, 1),  -- Action (1g)
(14, 31), -- Shonen (31g)
(14, 21), -- Ninja (21g)
(14, 16), -- Martial Arts (16g)
(14, 10), -- Fantasy (10g)

/* Boruto: Naruto Next Generations Genre */
(15, 1),  -- Action (1g)
(15, 31), -- Shonen (31g)
(15, 21), -- Ninja (21g)
(15, 16), -- Martial Arts (16g)
(15, 10), -- Fantasy (10g)
(15, 5),  -- Comedy (5g)

/* One Piece Genre */
(16, 2),  -- Adventure (2g)
(16, 10), -- Fantasy (10g)
(16, 31), -- Shonen (31g)

/* Naruto Genre */
(17, 1),  -- Action (1g)
(17, 31), -- Shonen (31g)
(17, 21), -- Ninja (21g)
(17, 5),  -- Comedy (5g)
(17, 16), -- Martial Arts (16g)
(17, 10), -- Fantasy (10g)

/* Naruto Shippuden Genre */
(18, 1),  -- Action (1g)
(18, 31), -- Shonen (31g)
(18, 21), -- Ninja (21g)
(18, 5),  -- Comedy (5g)
(18, 16), -- Martial Arts (16g)
(18, 10), -- Fantasy (10g)

/* Solo Leveling Genre */
(19, 1),  -- Action (1g)
(19, 10), -- Fantasy (10g)

/* Chainsaw Man Genre */
(20, 7),  -- Dark Fantasy (7g)
(20, 1),  -- Action (1g)
(20, 13), -- Horror (13g)
(20, 39), -- Thriller (39g)

/* Jujutsu Kaisen Genre */
(21, 7),  -- Dark Fantasy (7g)
(21, 38), -- Supernatural (38g)
(21, 1),  -- Action (1g)
(21, 39), -- Thriller (39g)
(21, 13), -- Horror (13g)

/* Fullmetal Alchemist Genre */
(22, 2),  -- Adventure (2g)
(22, 10), -- Fantasy (10g)
(22, 9),  -- Drama (9g)
(22, 35), -- Steampunk (35g)

/* Invincible Genre */
(23, 37), -- Superhero (37g)
(23, 1),  -- Action (1g)
(23, 9),  -- Drama (9g)
(23, 39), -- Thriller (39g)
(23, 6),  -- Coming of Age (6g)

/* The Amazing Spider-Man Genre */
(24, 37), -- Superhero (37g)
(24, 1),  -- Action (1g)

/* Superman Genre */
(25, 37), -- Superhero (37g)
(25, 30), -- Sci-Fi (30g)

/* The Boys Genre */
(26, 8),  -- Dark Superhero (8g)
(26, 28), -- Satire (28g)
(26, 39), -- Thriller (39g)

/* My Hero Academia Genre */
(27, 37), -- Superhero (37g)
(27, 31), -- Shonen (31g)

/* Blue Lock Genre */
(28, 34), -- Sports (34g)
(28, 23), -- Psychological (23g)

/* Monster Genre */
(29, 23), -- Psychological (23g)
(29, 39), -- Thriller (39g)
(29, 20), -- Mystery (20g)

/* 20th Century Boys Genre */
(30, 20), -- Mystery (20g)
(30, 30), -- Sci-Fi (30g)
(30, 39), -- Thriller (39g)

/* Black Clover Genre */
(31, 10), -- Fantasy (10g)
(31, 1),  -- Action (1g)
(31, 31), -- Shonen (31g)

/* Look Back Genre */
(32, 9),  -- Drama (9g)
(32, 33), -- Slice of Life (33g)

/* Gintama Genre */
(33, 5),  -- Comedy (5g)
(33, 1),  -- Action (1g)
(33, 30), -- Sci-Fi (30g)
(33, 31), -- Shonen (31g)

/* Mob Psycho 100 Genre */
(34, 38), -- Supernatural (38g)
(34, 5),  -- Comedy (5g)
(34, 9),  -- Drama (9g)

/* Dragon Ball Z Genre */
(35, 1),  -- Action (1g)
(35, 16), -- Martial Arts (16g)
(35, 31), -- Shonen (31g)

/* Kagurabachi Genre */
(36, 1),  -- Action (1g)
(36, 7),  -- Dark Fantasy (7g)

/* Hunter x Hunter Genre */
(37, 2),  -- Adventure (2g)
(37, 1),  -- Action (1g)
(37, 10), -- Fantasy (10g)
(37, 31), -- Shonen (31g)
(37, 39), -- Thriller (39g)

/* Stardew Valley Genre */
(38, 32), -- Simulation (32g)
(38, 11), -- Farming (11g)
(38, 25), -- RPG (25g)

/* Hollow Knight Genre */
(39, 18), -- Metroidvania (18g)
(39, 1),  -- Action (1g)
(39, 2),  -- Adventure (2g)

/* Undertale Genre */
(40, 25), -- RPG (25g)
(40, 14), -- Indie (14g)
(40, 17), -- Metafiction (17g)

/* A Space for the Unbound Genre */
(41, 2),  -- Adventure (2g)
(41, 33), -- Slice of Life (33g)
(41, 9),  -- Drama (9g)
(41, 38), -- Supernatural (38g)

/* Pikabuu: Unhuman Genre */
(42, 13), -- Horror (13g)
(42, 23), -- Psychological (23g)
(42, 20), -- Mystery (20g)

/* Pikabuu: STOP! Genre */
(43, 13), -- Horror (13g)
(43, 23), -- Psychological (23g)

/* Spark in the Dark Genre */
(44, 9),  -- Drama (9g)
(44, 22), -- Platformer (22g)
(44, 23), -- Psychological (23g)
(44, 39), -- Thriller (39g)

/* Celeste Genre */
(45, 22), -- Platformer (22g)
(45, 2),  -- Adventure (2g)

/* Hades Genre */
(46, 26), -- Roguelike (26g)
(46, 1),  -- Action (1g)

/* Touhou 6 Genre */
(47, 4),  -- Bullet Hell (4g)

/* Hello Charlotte Genre */
(48, 23), -- Psychological (23g)
(48, 13), -- Horror (13g)
(48, 2),  -- Adventure (2g)
(48, 25), -- RPG (25g)

/* The Dearest Person Genre */
(49, 42), -- Visual Novel (42g)
(49, 9),  -- Drama (9g)

/* OMORI Genre */
(50, 23), -- Psychological (23g)
(50, 13), -- Horror (13g)
(50, 25), -- RPG (25g)

/* LISA: The Painful Genre */
(51, 25), -- RPG (25g)
(51, 5),  -- Comedy (5g)
(51, 9),  -- Drama (9g)

/* Danganronpa Genre */
(52, 20), -- Mystery (20g)
(52, 42), -- Visual Novel (42g)
(52, 39), -- Thriller (39g)

/* Higurashi When They Cry Genre */
(53, 13), -- Horror (13g)
(53, 20), -- Mystery (20g)
(53, 23), -- Psychological (23g)
(53, 42), -- Visual Novel (42g)

/* Umineko When They Cry Genre */
(54, 20), -- Mystery (20g)
(54, 23), -- Psychological (23g)
(54, 10), -- Fantasy (10g)
(54, 17), -- Metafiction (17g)

/* Subarashiki Hibi Genre */
(55, 23), -- Psychological (23g)
(55, 9),  -- Drama (9g)

/* Steins;Gate Genre */
(56, 30), -- Sci-Fi (30g)
(56, 40), -- Time Travel (40g)
(56, 39), -- Thriller (39g)
(56, 9),  -- Drama (9g)

/* The House in Fata Morgana Genre */
(57, 12), -- Gothic Horror (12g)
(57, 9),  -- Drama (9g)
(57, 20), -- Mystery (20g)

/* Clannad Genre */
(58, 27), -- Romance (27g)
(58, 9),  -- Drama (9g)
(58, 33); -- Slice of Life (33g)




INSERT INTO art_tags (art_id, tag_id) VALUES

/* ReZero Tag */
(1, 125), -- Time Loop (125t)
(1, 30),  -- Death Reset (30t)
(1, 76),  -- Magic (76t)
(1, 122), -- Survival (122t)
(1, 127), -- Tragedy (127t)
(1, 31),  -- Demons (31t)
(1, 14),  -- Character Developments (14t)

/* ORV Tag */
(2, 5),   -- Apocalypse (5t)
(2, 52),  -- Game System (52t)
(2, 100), -- Protagonist Knowledge (100t)
(2, 122), -- Survival (122t)

/* Lord of the Mysteries Tag */
(3, 27),  -- Cults (27t)
(3, 112), -- Rituals (112t)
(3, 85),  -- Mythology (85t)
(3, 53),  -- Gods (53t)
(3, 66),  -- Investigation (66t)
(3, 98),  -- Power System (98t)
(3, 22),  -- Conspiracy (22t)
(3, 135), -- Victorian Era (135t)

/* 86 Eighty-Six Tag */
(4, 136), -- War (136t)
(4, 78),  -- Mecha (78t)
(4, 103), -- Racism (103t)
(4, 122), -- Survival (122t)
(4, 127), -- Tragedy (127t)
(4, 40),  -- Emotional Bonds (40t)

/* Janji Tag */
(5, 99),  -- Promise (99t)
(5, 107), -- Relationships (107t)
(5, 14),  -- Character Developments (14t)

/* Bumi Tag */
(6, 76),  -- Magic (76t) 
(6, 51),  -- Friendship (51t)
(6, 45),  -- Family (45t)
(6, 59),  -- Hidden Power (59t)

/* Trully Monster Tag */
(7, 37),  -- Dream World (37t)
(7, 60),  -- Hope (60t)
(7, 96), -- Surrealism (96t)
(7, 109), -- Responsibility (109t)
(7, 14),  -- Character Developments (14t)
(7, 40),  -- Emotional Bonds (40t)

/* Welcome to the NHK Tag */
(8, 87),  -- NEET (87t)
(8, 118), -- Social Withdrawal (118t)
(8, 22),  -- Conspiracy (22t)
(8, 7),   -- Anxiety (7t)
(8, 14),  -- Character Developments (14t)
(8, 92),  -- Paranoia (92t)
(8, 42),  -- Emotional Healing (42t)
(8, 41),  -- Emotional Conflict (41t)

/* Reverend Insanity Tag */
(9, 106), -- Reincarnation (106t)
(9, 134), -- Villain Protagonist (134t)
(9, 77),  -- Manipulation (77t)
(9, 26),  -- Cultivation (26t)

/* Laskar Pelangi Tag */
(10, 38), -- Education (38t)
(10, 95), -- Poverty (95t)
(10, 51), -- Friendship (51t)
(10, 60), -- Hope (60t)

/* Metamorphosis Tag */
(11, 89), -- Obsession (89t)
(11, 64), -- Identity Loss (64t)
(11, 128),-- Transformation (128t)
(11, 127),-- Tragedy (127t)
(11, 41), -- Emotional Conflict (41t)

/* Violet Evergarden Tag */
(12, 42), -- Emotional Healing (42t)
(12, 137),-- War Aftermath (137t)
(12, 72), -- Letters (72t)
(12, 62), -- Humanity (62t)
(12, 14), -- Character Developments (14t)

/* Classroom of the Elite Tag */
(13, 77), -- Manipulation (77t)
(13, 21), -- Competition (21t)
(13, 65), -- Intelligence Games (65t)

/* Boruto: Two Blue Vortex Tag */
(14, 140),-- Time Skip (140t)
(14, 123),-- Swordsman (123t)
(14, 71), -- Legacy (71t)
(14, 55), -- Growth (55t)
(14, 4),  -- Antihero (4t)
(14, 14), -- Character Developments (14t)
(14, 127),-- Tragedy (127t)
(14, 41), -- Emotional Conflict (41t)

/* Boruto: Naruto Next Generations Tag */
(15, 71), -- Legacy (71t)
(15, 86), -- Next Generation (86t)
(15, 14), -- Character Developments (14t)
(15, 39), -- Ego (39t)

/* One Piece Tag */
(16, 129),-- Treasure Hunt (129t)
(16, 51), -- Friendship (51t)
(16, 50), -- Freedom (50t)
(16, 138),-- War Arc (138t)
(16, 40), -- Emotional Bonds (40t)
(16, 48), -- Fighting (48t)

/* Naruto Tag */
(17, 51), -- Friendship (51t)
(17, 55), -- Growth (55t)
(17, 111),-- Rivalry (111t)
(17, 98), -- Power System (98t)
(17, 131),-- Underdog (131t)
(17, 48), -- Fighting (48t)

/* Naruto Shippuden Tag */
(18, 138),-- War Arc (138t)
(18, 140),-- Time Skip (140t)
(18, 105),-- Redemption (105t)
(18, 33), -- Destiny (33t)
(18, 98), -- Power System (98t)
(18, 111),-- Rivalry (111t)
(18, 131),-- Underdog (131t)
(18, 48), -- Fighting (48t)

/* Solo Leveling Tag */
(19, 73), -- Leveling System (73t)
(19, 90), -- Overpowered MC (90t)
(19, 61), -- Hunters (61t)
(19, 80), -- Monsters (80t)
(19, 48), -- Fighting (48t)

/* Chainsaw Man Tag */
(20, 34), -- Devils (34t)
(20, 133),-- Violence (133t)
(20, 13), -- Chaos (13t)
(20, 4),  -- Antihero (4t)
(20, 128),-- Transformation (128t)
(20, 127),-- Tragedy (127t)
(20, 40), -- Emotional Bonds (40t)
(20, 48), -- Fighting (48t)

/* Jujutsu Kaisen Tag */
(21, 119),-- Sorcery (119t)
(21, 8),  -- Battles (8t)
(21, 82), -- Moral Dilemma (82t)
(21, 114),-- Sacrifice (114t)
(21, 127),-- Tragedy (127t)
(21, 48), -- Fighting (48t)

/* Fullmetal Alchemist Tag */
(22, 2),  -- Alchemy (2t)
(22, 10), -- Brotherhood (10t)
(22, 136),-- War (136t)
(22, 82), -- Moral Dilemma (82t)
(22, 109),-- Responsibility (109t)
(22, 127),-- Tragedy (127t)
(22, 94), -- Philosophy (94t)

/* Invincible Tag */
(23, 63), -- Identity (63t)
(23, 133),-- Violence (133t)
(23, 41), -- Emotional Conflict (41t)

/* The Amazing Spider-Man Tag */
(24, 109),-- Responsibility (109t)
(24, 58), -- Heroism (58t)
(24, 132),-- Urban Crime (132t)

/* Superman Tag */
(25, 3),  -- Aliens (3t)
(25, 67), -- Justice (67t)
(25, 60), -- Hope (60t)
(25, 57), -- Hero Symbol (57t)

/* The Boys Tag */
(26, 23), -- Corruption (23t)
(26, 4),  -- Antihero (4t)
(26, 54), -- Government Control (54t)
(26, 133),-- Violence (133t)

/* My Hero Academia Tag */
(27, 102),-- Quirks (102t)
(27, 56), -- Hero School (56t)
(27, 55), -- Growth (55t)
(27, 111),-- Rivalry (111t)
(27, 109),-- Responsibility (109t)
(27, 116),-- School Life (116t)
(27, 131),-- Underdog (131t)
(27, 40), -- Emotional Bonds (40t)
(27, 48), -- Fighting (48t)

/* Blue Lock Tag */
(28, 49), -- Football (49t)
(28, 39), -- Ego (39t)
(28, 21), -- Competition (21t)

/* Monster Tag */
(29, 117),-- Serial Killer (117t)
(29, 82), -- Moral Dilemma (82t)
(29, 66), -- Investigation (66t)
(29, 109),-- Responsibility (109t)
(29, 94), -- Philosophy (94t)

/* 20th Century Boys Tag */
(30, 27), -- Cults (27t)
(30, 16), -- Childhood (16t)
(30, 5),  -- Apocalypse (5t)
(30, 22), -- Conspiracy (22t)

/* Black Clover Tag */
(31, 76), -- Magic (76t)
(31, 123),-- Swordsman (123t)
(31, 111),-- Rivalry (111t)
(31, 131),-- Underdog (131t)
(31, 69), -- Kingdoms (69t)
(31, 48), -- Fighting (48t)

/* Look Back Tag */
(32, 6),  -- Art (6t)
(32, 51), -- Friendship (51t)
(32, 75), -- Loss (75t)
(32, 25), -- Creativity (25t)
(32, 127),-- Tragedy (127t)

/* Gintama Tag */
(33, 93), -- Parody (93t)
(33, 123),-- Swordsman (123t)
(33, 115),-- Samurai (115t)
(33, 3),  -- Aliens (3t)
(33, 1),  -- Absurd Humor (1t)
(33, 109),-- Responsibility (109t)
(33, 40), -- Emotional Bonds (40t)

/* Mob Psycho 100 Tag */
(34, 101),-- Psychic Powers (101t)
(34, 55), -- Growth (55t)
(34, 41), -- Emotional Conflict (41t)
(34, 63), -- Identity (63t)
(34, 14), -- Character Developments (14t)

/* Dragon Ball Z Tag */
(35, 97), -- Power Scaling (97t)
(35, 3),  -- Aliens (3t)
(35, 48), -- Fighting (48t)
(35, 128),-- Transformation (128t)

/* Kagurabachi Tag */
(36, 123),-- Swordsman (123t)
(36, 110),-- Revenge (110t)
(36, 76), -- Magic (76t)
(36, 48), -- Fighting (48t)

/* Hunter x Hunter Tag */
(37, 98), -- Power System (98t)
(37, 122),-- Survival (122t)
(37, 51), -- Friendship (51t)
(37, 82), -- Moral Dilemma (82t)
(37, 48), -- Fighting (48t)

/* Stardew Valley Tag */
(38, 108),-- Relaxation (108t)
(38, 24), -- Crafting (24t)
(38, 107),-- Relationships (107t)

/* Hollow Knight Tag */
(39, 43), -- Exploration (43t)
(39, 120),-- Souls (120t)
(39, 84), -- Multiple Endings (84t)
(39, 48), -- Fighting (48t)

/* Undertale Tag */
(40, 17), -- Choices Matter (17t)
(40, 91), -- Pacifism (91t)
(40, 84), -- Multiple Endings (84t)
(40, 18), -- Choice Driven Story (18t)

/* A Space for the Unbound Tag */
(41, 79), -- Mental Health (79t)
(41, 88), -- Nostalgia (88t)
(41, 124),-- Teen Life (124t)
(41, 42), -- Emotional Healing (42t)

/* Pikabuu: Unhuman Tag */
(42, 35), -- Distortion (35t)
(42, 46), -- Fear (46t)
(42, 122),-- Survival (122t)

/* Pikabuu: STOP! Tag */
(43, 92), -- Paranoia (92t)
(43, 15), -- Chase (15t)
(43, 47), -- Fear Mechanics (47t)

/* Spark in the Dark Tag */
(44, 3),  -- Aliens (3t)
(44, 43), -- Exploration (43t)
(44, 122),-- Survival (122t)
(44, 92), -- Paranoia (92t)
(44, 127),-- Tragedy (127t)

/* Celeste Tag */
(45, 19), -- Climbing (19t)
(45, 32), -- Depression (32t)
(45, 55), -- Growth (55t) 
(45, 12), -- Challenge (12t)

/* Hades Tag */
(46, 85), -- Mythology (85t)
(46, 29), -- Death Loop (29t)
(46, 20), -- Combat (20t)
(46, 53), -- Gods (53t)

/* Touhou 6 Tag */
(47, 44), -- Fairies (44t)
(47, 121),-- Spell Cards (121t)
(47, 36), -- Dodging (36t)

/* Hello Charlotte Tag */
(48, 96),-- Surrealism (96t)
(48, 63), -- Identity (63t)
(48, 84), -- Multiple Endings (84t)
(48, 18), -- Choice Driven Story (18t)
(48, 92), -- Paranoia (92t)

/* The Dearest Person Tag */
(49, 107),-- Relationships (107t)
(49, 40), -- Emotional Bonds (40t)
(49, 42), -- Emotional Healing (42t)

/* OMORI Tag */
(50, 92), -- Paranoia (92t)
(50, 37), -- Dream World (37t)
(50, 96),-- Surrealism (96t)
(50, 51), -- Friendship (51t)
(50, 79), -- Mental Health (79t)
(50, 42), -- Emotional Healing (42t)
(50, 41), -- Emotional Conflict (41t)
(50, 84), -- Multiple Endings (84t)
(50, 18), -- Choice Driven Story (18t)

/* LISA: The Painful Tag */
(51, 122),-- Survival (122t)
(51, 114),-- Sacrifice (114t)
(51, 81), -- Moral Choices (81t)
(51, 133),-- Violence (133t)
(51, 127),-- Tragedy (127t)
(51, 40), -- Emotional Bonds (40t)
(51, 84), -- Multiple Endings (84t)
(51, 18), -- Choice Driven Story (18t)

/* Danganronpa Tag */
(52, 68), -- Killing Game (68t)
(52, 66), -- Investigation (66t)
(52, 130),-- Trials (130t)
(52, 9),  -- Betrayal (9t)
(52, 18), -- Choice Driven Story (18t)

/* Higurashi When They Cry Tag */
(53, 125),-- Time Loop (125t)
(53, 83), -- Murder (83t)
(53, 113),-- Rural Horror (113t)
(53, 127),-- Tragedy (127t)
(53, 84), -- Multiple Endings (84t)
(53, 18), -- Choice Driven Story (18t)

/* Umineko When They Cry Tag */
(54, 139),-- Witch (139t)
(54, 130),-- Trials (130t)
(54, 74), -- Logic Battles (74t)
(54, 45), -- Family (45t) -- (Family Drama)
(54, 127),-- Tragedy (127t)

/* Subarashiki Hibi Tag */
(55, 94), -- Philosophy (94t)
(55, 104),-- Reality Breakdown (104t)
(55, 63), -- Identity (63t)
(55, 37), -- Dream World (37t)
(55, 92), -- Paranoia (92t)
(55, 127),-- Tragedy (127t)
(55, 41), -- Emotional Conflict (41t)
(55, 84), -- Multiple Endings (84t)
(55, 18), -- Choice Driven Story (18t)

/* Steins;Gate Tag */
(56, 126),-- Time Machine (126t)
(56, 11), -- Butterfly Effect (11t)
(56, 70), -- Lab Group (70t)
(56, 94), -- Philosophy (94t)
(56, 84), -- Multiple Endings (84t)
(56, 18), -- Choice Driven Story (18t)

/* The House in Fata Morgana Tag */
(57, 28), -- Curses (28t)
(57, 106),-- Reincarnation (106t)

/* Clannad Tag */
(58, 45), -- Family (45t)
(58, 116),-- School Life (116t)
(58, 42), -- Emotional Healing (42t)
(58, 75), -- Loss (75t)
(58, 84), -- Multiple Endings (84t)
(58, 18); -- Choice Driven Story (18t)



INSERT INTO art_moods (art_id, mood_id) VALUES

/* ReZero Mood */
(1, 12), -- Complex (12m)
(1, 14), -- Dark (14m)
(1, 26), -- Intense (26m)
(1, 19), -- Emotional (19m)
(1, 15), -- Depressing (15m)
(1, 40), -- Suspenseful (40m)
(1, 21), -- Heartwarming (21m)
(1, 30), -- Mysterious (30m)
(1, 41), -- Tragic (41m)

/* ORV Mood */
(2, 40), -- Suspenseful (40m)
(2, 23), -- Hopeful (23m)
(2, 39), -- Strategic (39m)
(2, 45), -- Reflective (45m)

/* Lord of the Mysteries Mood */
(3, 12), -- Complex (12m)
(3, 30), -- Mysterious (30m)
(3, 40), -- Suspenseful (40m)
(3, 14), -- Dark (14m)
(3, 39), -- Strategic (39m)
(3, 10), -- Cold (10m)

/* 86 Eighty-Six Mood */
(4, 14), -- Dark (14m)
(4, 19), -- Emotional (19m)
(4, 45), -- Reflective (45m)
(4, 6),  -- Bittersweet (6m)
(4, 21), -- Heartwarming (21m)
(4, 41), -- Tragic (41m)

/* Janji Mood */
(5, 19), -- Emotional (19m)
(5, 45), -- Reflective (45m)
(5, 23), -- Hopeful (23m)
(5, 35), -- Realistic (35m)
(5, 21), -- Heartwarming (21m)

/* Bumi Mood */
(6, 2),  -- Adventurous (2m)
(6, 23), -- Hopeful (23m)
(6, 19), -- Emotional (19m)

/* Trully Monster Mood */
(7, 23), -- Hopeful (23m)
(7, 35), -- Realistic (35m)
(7, 19), -- Emotional (19m)
(7, 45), -- Reflective (45m)
(7, 33), -- Peaceful (33m)
(7, 1),  -- Abstract (1m)
(7, 21), -- Heartwarming (21m)

/* Welcome to the NHK Mood */
(8, 11), -- Comedic (11m)
(8, 19), -- Emotional (19m)
(8, 15), -- Depressing (15m)
(8, 35), -- Realistic (35m)
(8, 13), -- Cynical (13m)
(8, 21), -- Heartwarming (21m)
(8, 27), -- Lonely (27m)
(8, 32), -- Paranoid (32m)
(8, 45), -- Reflective (45m)
(8, 41), -- Tragic (41m)

/* Reverend Insanity Mood */
(9, 10), -- Cold (10m)
(9, 39), -- Strategic (39m)
(9, 14), -- Dark (14m)
(9, 26), -- Intense (26m)
(9, 40), -- Suspenseful (40m)

/* Laskar Pelangi Mood */
(10, 23), -- Hopeful (23m)
(10, 19), -- Emotional (19m)
(10, 45), -- Reflective (45m)
(10, 33), -- Peaceful (33m)
(10, 35), -- Realistic (35m)
(10, 21), -- Heartwarming (21m)

/* Metamorphosis Mood */
(11, 16), -- Disturbing (16m)
(11, 41), -- Tragic (41m)
(11, 14), -- Dark (14m)
(11, 19), -- Emotional (19m)
(11, 40), -- Suspenseful (40m)
(11, 35), -- Realistic (35m)
(11, 27), -- Lonely (27m)

/* Violet Evergarden Mood */
(12, 6),  -- Bittersweet (6m)
(12, 19), -- Emotional (19m)
(12, 45), -- Reflective (45m)
(12, 23), -- Hopeful (23m)
(12, 21), -- Heartwarming (21m)
(12, 33), -- Peaceful (33m)
(12, 35), -- Realistic (35m)
(12, 5),  -- Beautiful (5m)
(12, 28), -- Melancholic (28m)

/* Classroom of the Elite Mood */
(13, 10), -- Cold (10m)
(13, 40), -- Suspenseful (40m)
(13, 39), -- Strategic (39m)
(13, 26), -- Intense (26m)
(13, 38), -- Smart (38m)

/* Boruto: Two Blue Vortex Mood */
(14, 37), -- Serious (37m)
(14, 34), -- Philosophical (34m)
(14, 22), -- Heroic (22m)
(14, 41), -- Tragic (41m)

/* Boruto: Naruto Next Generations Mood */
(15, 19), -- Emotional (19m)
(15, 21), -- Heartwarming (21m)
(15, 45), -- Reflective (45m)

/* One Piece Mood */
(16, 12), -- Complex (12m)
(16, 23), -- Hopeful (23m)
(16, 19), -- Emotional (19m)
(16, 11), -- Comedic (11m)
(16, 2),  -- Adventurous (2m)
(16, 21), -- Heartwarming (21m)
(16, 30), -- Mysterious (30m)

/* Naruto Mood */
(17, 25), -- Inspirational (25m)
(17, 19), -- Emotional (19m)
(17, 11), -- Comedic (11m)
(17, 23), -- Hopeful (23m)
(17, 20), -- Energetic (20m)
(17, 21), -- Heartwarming (21m)
(17, 45), -- Reflective (45m)

/* Naruto Shippuden Mood */
(18, 25), -- Inspirational (25m)
(18, 19), -- Emotional (19m)
(18, 11), -- Comedic (11m)
(18, 23), -- Hopeful (23m)
(18, 21), -- Heartwarming (21m)
(18, 22), -- Heroic (22m)
(18, 45), -- Reflective (45m)

/* Solo Leveling Mood */
(19, 44), -- Cool (44m)
(19, 26), -- Intense (26m)

/* Chainsaw Man Mood */
(20, 8),  -- Chaotic (8m)
(20, 7),  -- Brutal (7m)
(20, 43), -- Unpredictable (43m)
(20, 14), -- Dark (14m)
(20, 26), -- Intense (26m)
(20, 20), -- Energetic (20m)
(20, 45), -- Reflective (45m)
(20, 41), -- Tragic (41m)

/* Jujutsu Kaisen Mood */
(21, 14), -- Dark (14m)
(21, 26), -- Intense (26m)
(21, 40), -- Suspenseful (40m)
(21, 23), -- Hopeful (23m)
(21, 34), -- Philosophical (34m)
(21, 21), -- Heartwarming (21m)
(21, 45), -- Reflective (45m)
(21, 41), -- Tragic (41m)

/* Fullmetal Alchemist Mood */
(22, 12), -- Complex (12m)
(22, 19), -- Emotional (19m)
(22, 26), -- Intense (26m)
(22, 34), -- Philosophical (34m)
(22, 45), -- Reflective (45m)
(22, 21), -- Heartwarming (21m)
(22, 42), -- Twisted (42m)

/* Invincible Mood */
(23, 7),  -- Brutal (7m)
(23, 19), -- Emotional (19m)
(23, 14), -- Dark (14m)
(23, 3),  -- Aggressive (3m)
(23, 26), -- Intense (26m)
(23, 45), -- Reflective (45m)

/* The Amazing Spider-Man Mood */
(24, 23), -- Hopeful (23m)
(24, 22), -- Heroic (22m)
(24, 19), -- Emotional (19m)
(24, 21), -- Heartwarming (21m)
(24, 25), -- Inspirational (25m)
(24, 45), -- Reflective (45m)

/* Superman Mood */
(25, 25), -- Inspirational (25m)
(25, 22), -- Heroic (22m)
(25, 23), -- Hopeful (23m)
(25, 19), -- Emotional (19m)

/* The Boys Mood */
(26, 13), -- Cynical (13m)
(26, 14), -- Dark (14m)
(26, 8),  -- Chaotic (8m)
(26, 40), -- Suspenseful (40m)
(26, 7),  -- Brutal (7m)
(26, 26), -- Intense (26m)

/* My Hero Academia Mood */
(27, 20), -- Energetic (20m)
(27, 23), -- Hopeful (23m)
(27, 25), -- Inspirational (25m)
(27, 19), -- Emotional (19m)
(27, 21), -- Heartwarming (21m)
(27, 26), -- Intense (26m)
(27, 22), -- Heroic (22m)
(27, 33), -- Peaceful (33m)
(27, 45), -- Reflective (45m)

/* Blue Lock Mood */
(28, 26), -- Intense (26m)
(28, 46), -- Competitive (46m)
(28, 3),  -- Aggressive (3m)
(28, 8),  -- Chaotic (8m)

/* Monster Mood */
(29, 12), -- Complex (12m)
(29, 14), -- Dark (14m)
(29, 40), -- Suspenseful (40m)
(29, 29), -- Mind Bending (29m)
(29, 16), -- Disturbing (16m)
(29, 19), -- Emotional (19m)
(29, 45), -- Reflective (45m)
(29, 35), -- Realistic (35m)
(29, 34), -- Philosophical (34m)
(29, 30), -- Mysterious (30m)
(29, 42), -- Twisted (42m)

/* 20th Century Boys Mood */
(30, 12), -- Complex (12m)
(30, 40), -- Suspenseful (40m)
(30, 31), -- Nostalgic (31m)
(30, 45), -- Reflective (45m)
(30, 35), -- Realistic (35m)
(30, 30), -- Mysterious (30m)
(30, 42), -- Twisted (42m)

/* Black Clover Mood */
(31, 20), -- Energetic (20m)
(31, 22), -- Heroic (22m)
(31, 25), -- Inspirational (25m)

/* Look Back Mood */
(32, 19), -- Emotional (19m)
(32, 45), -- Reflective (45m)
(32, 6),  -- Bittersweet (6m)
(32, 21), -- Heartwarming (21m)
(32, 35), -- Realistic (35m)
(32, 5),  -- Beautiful (5m)

/* Gintama Mood */
(33, 11), -- Comedic (11m)
(33, 19), -- Emotional (19m)
(33, 8),  -- Chaotic (8m)
(33, 21), -- Heartwarming (21m)
(33, 6),  -- Bittersweet (6m)
(33, 33), -- Peaceful (33m)
(33, 35), -- Realistic (35m)
(33, 34), -- Philosophical (34m)
(33, 45), -- Reflective (45m)

/* Mob Psycho 100 Mood */
(34, 11), -- Comedic (11m)
(34, 19), -- Emotional (19m)
(34, 23), -- Hopeful (23m)
(34, 17), -- Dramatic (17m)
(34, 45), -- Reflective (45m)

/* Dragon Ball Z Mood */
(35, 20), -- Energetic (20m)
(35, 31), -- Nostalgic (31m)
(35, 23), -- Hopeful (23m)
(35, 22), -- Heroic (22m)

/* Kagurabachi Mood */
(36, 37), -- Serious (37m)
(36, 26), -- Intense (26m)
(36, 14), -- Dark (14m)

/* Hunter x Hunter Mood */
(37, 12), -- Complex (12m)
(37, 39), -- Strategic (39m)
(37, 14), -- Dark (14m)
(37, 43), -- Unpredictable (43m)
(37, 19), -- Emotional (19m)
(37, 2),  -- Adventurous (2m)

/* Stardew Valley Mood */
(38, 23), -- Hopeful (23m)
(38, 45), -- Reflective (45m)
(38, 33), -- Peaceful (33m)

/* Hollow Knight Mood */
(39, 4),  -- Atmospheric (4m)
(39, 14), -- Dark (14m)
(39, 40), -- Suspenseful (40m)
(39, 30), -- Mysterious (30m)
(39, 2),  -- Adventurous (2m)

/* Undertale Mood */
(40, 11), -- Comedic (11m)
(40, 19), -- Emotional (19m)
(40, 45), -- Reflective (45m)
(40, 23), -- Hopeful (23m)
(40, 33), -- Peaceful (33m)
(40, 15), -- Depressing (15m)
(40, 34), -- Philosophical (34m)
(40, 9),  -- Challenging (9m)

/* A Space for the Unbound Mood */
(41, 19), -- Emotional (19m)
(41, 18), -- Dreamlike (18m)
(41, 45), -- Reflective (45m)
(41, 28), -- Melancholic (28m)
(41, 31), -- Nostalgic (31m)
(41, 6),  -- Bittersweet (6m)
(41, 21), -- Heartwarming (21m)
(41, 33), -- Peaceful (33m)
(41, 35), -- Realistic (35m)
(41, 42), -- Twisted (42m)

/* Pikabuu: Unhuman Mood */
(42, 7),  -- Brutal (7m)
(42, 8),  -- Chaotic (8m)
(42, 15), -- Depressing (15m)
(42, 17), -- Dramatic (17m)
(42, 30), -- Mysterious (30m)
(42, 40), -- Suspenseful (40m)
(42, 41), -- Tragic (41m)

/* Pikabuu: STOP! Mood */
(43, 15), -- Depressing (15m)
(43, 8),  -- Chaotic (8m)
(43, 17), -- Dramatic (17m)
(43, 45), -- Reflective (45m)
(43, 26), -- Intense (26m)
(43, 41), -- Tragic (41m)

/* Spark in the Dark Mood */
(44, 19), -- Emotional (19m)
(44, 4),  -- Atmospheric (4m)
(44, 32), -- Paranoid (32m)
(44, 40), -- Suspenseful (40m)
(44, 9),  -- Challenging (9m)
(44, 41), -- Tragic (41m)
(44, 42), -- Twisted (42m)

/* Celeste Mood */
(45, 19), -- Emotional (19m)
(45, 23), -- Hopeful (23m)
(45, 9),  -- Challenging (9m)
(45, 45), -- Reflective (45m)

/* Hades Mood */
(46, 26), -- Intense (26m)
(46, 8),  -- Chaotic (8m)
(46, 20), -- Energetic (20m)

/* Touhou 6 Mood */
(47, 8),  -- Chaotic (8m)
(47, 26), -- Intense (26m)
(47, 3),  -- Aggressive (3m)
(47, 36), -- Rhythmic (36m)
(47, 9),  -- Challenging (9m)

/* Hello Charlotte Mood */
(48, 16), -- Disturbing (16m)
(48, 1),  -- Abstract (1m)
(48, 32), -- Paranoid (32m)
(48, 18), -- Dreamlike (18m)
(48, 19), -- Emotional (19m)
(48, 26), -- Intense (26m)
(48, 14), -- Dark (14m)
(48, 24), -- Hopeless (24m)
(48, 4),  -- Atmospheric (4m)
(48, 7),  -- Brutal (7m)
(48, 15), -- Depressing (15m)
(48, 28), -- Melancholic (28m)
(48, 30), -- Mysterious (30m)
(48, 45), -- Reflective (45m)
(48, 40), -- Suspenseful (40m)
(48, 42), -- Twisted (42m)

/* The Dearest Person Mood */
(49, 6),  -- Bittersweet (6m)
(49, 19), -- Emotional (19m)
(49, 21), -- Heartwarming (21m)
(49, 35), -- Realistic (35m)
(49, 28), -- Melancholic (28m)
(49, 27), -- Lonely (27m)
(49, 45), -- Reflective (45m)

/* OMORI Mood */
(50, 14), -- Dark (14m)
(50, 19), -- Emotional (19m)
(50, 28), -- Melancholic (28m)
(50, 32), -- Paranoid (32m)
(50, 18), -- Dreamlike (18m)
(50, 16), -- Disturbing (16m)
(50, 1),  -- Abstract (1m)
(50, 15), -- Depressing (15m)
(50, 4),  -- Atmospheric (4m)
(50, 30), -- Mysterious (30m)
(50, 45), -- Reflective (45m)
(50, 42), -- Twisted (42m)

/* LISA: The Painful Mood */
(51, 8),  -- Chaotic (8m)
(51, 14), -- Dark (14m)
(51, 19), -- Emotional (19m)
(51, 21), -- Heartwarming (21m)
(51, 15), -- Depressing (15m)
(51, 35), -- Realistic (35m)
(51, 45), -- Reflective (45m)
(51, 40), -- Suspenseful (40m)
(51, 41), -- Tragic (41m)
(51, 42), -- Twisted (42m)

/* Danganronpa Mood */
(52, 40), -- Suspenseful (40m)
(52, 17), -- Dramatic (17m)
(52, 26), -- Intense (26m)
(52, 30), -- Mysterious (30m)
(52, 42), -- Twisted (42m)

/* Higurashi When They Cry Mood */
(53, 16), -- Disturbing (16m)
(53, 40), -- Suspenseful (40m)
(53, 26), -- Intense (26m)
(53, 14), -- Dark (14m)
(53, 15), -- Depressing (15m)
(53, 30), -- Mysterious (30m)
(53, 41), -- Tragic (41m)

/* Umineko When They Cry Mood */
(54, 12), -- Complex (12m)
(54, 29), -- Mind Bending (29m)
(54, 40), -- Suspenseful (40m)
(54, 26), -- Intense (26m)
(54, 14), -- Dark (14m)
(54, 15), -- Depressing (15m)
(54, 30), -- Mysterious (30m)
(54, 41), -- Tragic (41m)
(54, 42), -- Twisted (42m)

/* Subarashiki Hibi Mood */
(55, 12), -- Complex (12m)
(55, 34), -- Philosophical (34m)
(55, 29), -- Mind Bending (29m)
(55, 14), -- Dark (14m)
(55, 5),  -- Beautiful (5m)
(55, 15), -- Depressing (15m)
(55, 30), -- Mysterious (30m)
(55, 32), -- Paranoid (32m)
(55, 42), -- Twisted (42m)

/* Steins;Gate Mood */
(56, 12), -- Complex (12m)
(56, 19), -- Emotional (19m)
(56, 38), -- Smart (38m)
(56, 26), -- Intense (26m)
(56, 34), -- Philosophical (34m)
(56, 30), -- Mysterious (30m)
(56, 45), -- Reflective (45m)

/* The House in Fata Morgana Mood */
(57, 41), -- Tragic (41m)
(57, 5),  -- Beautiful (5m)
(57, 19), -- Emotional (19m)
(57, 21), -- Heartwarming (21m)
(57, 28), -- Melancholic (28m)
(57, 30), -- Mysterious (30m)
(57, 42), -- Twisted (42m)

/* Clannad Mood */
(58, 21), -- Heartwarming (21m)
(58, 19), -- Emotional (19m)
(58, 6),  -- Bittersweet (6m)
(58, 35), -- Realistic (35m)
(58, 5),  -- Beautiful (5m)
(58, 28), -- Melancholic (28m)
(58, 32), -- Paranoid (32m)
(58, 45); -- Reflective (45m)


----------------------------------------------------------------------------------------------------------------------------------------------------

/* Reviews & Comments Insert */

-- Insert Reviews

INSERT INTO reviews (target_type, target_id, user_id, rating, komentar) VALUES
('art', 1, 2, 5, 'review');

-- Insert Comments

INSERT INTO comments (target_type, target_id, user_id, rating, komentar) VALUES
('review', 1, 2, 5, 'komentar');


