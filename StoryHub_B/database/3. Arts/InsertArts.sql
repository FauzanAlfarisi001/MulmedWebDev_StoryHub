-- USE storyhub_db_art;

USE storyhub;

/* ARTS */

-- Insert Canvas Novel (pemula)

-- INSERT INTO arts (title, authorDev_id, nametag, cover_img, banner_img, authorOrDev, status, category, tagline, synopsis) VALUES

-- Insert Novel

INSERT INTO arts (title, nametag, cover_img, banner_img, authorOrDev, status, category, jumlah_chapter, tagline, synopsis, published_at) VALUES

(
    'Re:Zero', 
    'rezero', 
    'coverArt/novel/rezero_c.jpg', 
    'coverArt/novel/rezero_b.jpg', 
    'Tappei Nagatsuki', 
    'Ongoing',
    'Novel',
    690,
    'Dia kembali dari kematian.', 
    'Subaru Natsuki tiba-tiba dipindahkan ke dunia fantasi. Satu-satunya kemampuan yang ia miliki adalah kembali hidup setelah mati, namun setiap kematian membawa trauma yang tak terhapus.', 
    'Jan 24, 2014'
),

(
    'Omniscient Reader''s Viewpoint', 
    'orv', 
    'coverArt/novel/orv_c.jpg', 
    'coverArt/novel/orv_b.jpg', 
    'Sing Shong', 
    'Completed',
    'Novel',
    551,
    'Hanya dia yang tahu bagaimana cerita ini berakhir.', 
    'Kim Dokja adalah satu-satunya pembaca setia novel web "Three Ways to Survive the Apocalypse" dan tiba-tiba dunia nyata berubah menjadi isi novel itu. Kini hanya ia yang tahu bagaimana cerita ini akan berakhir.', 
    'Jan 6, 2018'
),

(
    'Lord of Mysteries', 
    'lotm', 
    'coverArt/novel/lotm_c.jpg', 
    'coverArt/novel/lotm_b.png', 
    'Cuttlefish That Loves Diving', 
    'Completed',
    'Novel', 
    1432,
    'Di balik misteri, tersembunyi kebenaran yang lebih gelap.', 
    'Zhou Mingrui terbangun di tubuh orang lain di dunia steampunk penuh okultisme. Ia bergabung dengan organisasi rahasia dan menjadi "The Fool" - peran yang lebih besar dari yang ia bayangkan.', 
    'Apr 1, 2018'
),

(
    '86 Eighty-Six', 
    'eightysix', 
    'coverArt/novel/86_c.jpg', 
    'coverArt/novel/86_b.jpg', 
    'Asato Asato',
    'Completed',
    'Novel',
    104,
    'Mereka bertempur. Republik berpura-pura mereka tak ada.', 
    'Di Republik San Magnolia, perang dilancarkan oleh drone tanpa awak - begitu klaimnya. Kenyataannya, anak-anak 86 yang dianggap bukan manusia yang mengemudikannya, dan Lena adalah satu-satunya perwira yang mau mengakui kemanusiaan mereka.', 
    'Feb 10, 2017'
),

(
    'Janji', 
    'janji', 
    'coverArt/novel/janji_c.jpg', 
    'coverArt/novel/janji_b.jpg', 
    'Tere Liye',
    'Completed', 
    'Novel', 
    24,
    'Sebuah janji yang melampaui jarak dan waktu.', 
    'Novel Janji bercerita tentang tiga sahabat - Hasan, Baso, dan Kahar-yang dikenal nakal saat mondok di sekolah agama milik Buya. Setelah sebuah insiden besar, mereka diminta mencari seseorang bernama Bahar. Perjalanan mencari Bahar kemudian berubah menjadi perjalanan hidup penuh pelajaran tentang janji, persahabatan, pengorbanan, dan makna kehidupan.', 
    'Jan 1, 2021'
),

(
    'Bumi', 
    'bumi', 
    'coverArt/novel/bumi_c.jpg', 
    'coverArt/novel/bumi_b.jpg', 
    'Tere Liye',
    'Completed',
    'Novel',
    52,
    'Petualangan dimulai dari bawah permukaan bumi.', 
    'Raib, Seli, dan Ali menemukan bahwa di bawah permukaan bumi terdapat dunia-dunia tersembunyi dengan peradaban dan kekuatan yang menakjubkan. Petualangan mereka baru saja dimulai.', 
    'Oct 1, 2014'
),

(
    'Trully Monster', 
    'trully', 
    'coverArt/novel/trully_c.jpg', 
    'coverArt/novel/trully_b.jpg', 
    'Jack Choo Wee',
    'Hiatus',
    'Novel',
    10,
    'Ya ... pada akhirnya kita berdua akan berakhir menjadi t*i di wc...', 
    'Perjalanan seorang pria dalam rangka meraih mimpi masa kecilnya.', 
    'Jan 1, 2025'
),

(
    'Welcome to NHK',
    'nhk',
    'coverArt/novel/nhk_c.jpg',
    'coverArt/novel/nhk_b.jpg',
    'Tatsuhiko Takimoto',
    'Completed',
    'Novel',
    11,
    'Dunia di luar kamarmu lebih menakutkan dari yang kamu kira.', 
    'Sato yakin ada konspirasi bernama NHK yang membuatnya menjadi hikikomori. Seorang gadis misterius datang mengklaim ingin menyelamatkannya - tapi siapa sebenarnya yang membutuhkan pertolongan?', 
    'Jan 28, 2002'
),

(
    'Reverend Insanity', 
    'reverend_insanity', 
    'coverArt/novel/ri_c.jpg', 
    'coverArt/novel/ri_b.jpg', 
    'Gu Zhen Ren', 
    'Hiatus',
    'Novel',
    2334,
    'Ia bukan protagonis. Ia predator.', 
    'Fang Yuan, manusia paling amoral di dunia kultivasi, hidup kembali dengan semua memori 500 tahunnya. Ia tak ingin menjadi pahlawan - ia hanya ingin keabadian, dengan cara apapun.', 
    'Mar 5, 2012'
),

(
    'Laskar Pelangi', 
    'laskar_pelangi', 
    'coverArt/novel/laspel_c.jpg', 
    'coverArt/novel/laspel_b.jpg', 
    'Andrea Hirata', 
    'Completed',
    'Novel',
    34,
    'Mimpi tidak mengenal keterbatasan.', 
    'Kisah sepuluh anak Belitung yang berjuang mendapatkan pendidikan di sekolah hampir rubuh. Dengan semangat dan persahabatan, mereka membuktikan bahwa mimpi tidak mengenal kemiskinan.', 
    'Jan 1, 2005'
),

(
    'The Metamorphosis', 
    'metamorphosis_kafka', 
    'coverArt/novel/kafka_c.png', 
    'coverArt/novel/kafka_b.jpg', 
    'Franz Kafka', 
    'Completed', 
    'Novel',
    3,
    'Suatu pagi ia terbangun sebagai sesuatu yang lain.', 
    'Gregor Samsa terbangun dan mendapati dirinya telah berubah menjadi serangga raksasa. Novel pendek Kafka yang menjadi alegori alienasi, keluarga, dan kemanusiaan yang paling terkenal sepanjang masa.', 
    'Oct 15, 1915'
),

(
    'Violet Evergarden', 
    'violet_evergarden', 
    'coverArt/novel/violet_c.jpg', 
    'coverArt/novel/violet_b.png', 
    'Kana Akatsuki', 
    'Completed', 
    'Novel',
    25,
    'Ia belajar menulis surat - dan belajar apa itu cinta.', 
    'Violet Evergarden, mantan prajurit yang kehilangan kedua tangannya, kini bekerja sebagai Auto Memory Doll - menulis surat untuk orang lain. Lewat surat-surat itu, ia mencoba memahami kata-kata terakhir sang mayor: "Aku mencintaimu."', 
    'Dec 25, 2015'
),

(
    'Classroom of the Elite', 
    'cote', 
    'coverArt/novel/cote_c.jpg', 
    'coverArt/novel/cote_b.png', 
    'Shogo Kinugasa', 
    'Ongoing', 
    'Novel',
    310,
    'Di sekolah ini, kelasmu adalah segalanya.', 
    'Kiyotaka Ayanokoji masuk ke SMA bergengsi dan sengaja menyembunyikan kemampuan sesungguhnya. Sekolah ini mengajarkan bahwa hanya yang terkuat yang berhak naik kelas - dan dunia nyata tidak jauh berbeda.', 
    'May 25, 2015'
);



-- Insert Comic

INSERT INTO arts (title, nametag, cover_img, banner_img, authorOrDev, artist, status, category, jumlah_chapter, tagline, synopsis, published_at) VALUES

(
    'Boruto: Two Blue Vortex', 
    'boruto_tbv', 
    'coverArt/comic/boruto_tbv_c.jpg', 
    'coverArt/comic/boruto_tbv_b.jpg', 
    'Masashi Kishimoto', 
    'Mikio Ikemoto', 
    'Ongoing',
    'Manga',
    33,
    'Takdir kelam menunggunya di masa depan.', 
    'Tiga tahun setelah peristiwa Omnipotence, Boruto kembali sebagai shinobi yang jauh lebih kuat. Ia harus menghadapi ancaman baru sekaligus membersihkan namanya di desa yang telah dimanipulasi untuk membencinya.', 
    'Aug 21, 2023'
),

(
    'Boruto: Naruto Next Generations', 
    'boruto_nng', 
    'coverArt/comic/boruto_nng_c.jpg', 
    'coverArt/comic/boruto_nng_b.jpg', 
    'Masashi Kishimoto', 
    'Mikio Ikemoto', 
    'Completed', 
    'Manga',
    80,
    'Anak hokage, memilih untuk curang dalam hidupnya.', 
    'Boruto Uzumaki, putra Naruto, tumbuh di era penuh kedamaian. Naumn, ia sama sekali tidak memiliki hasrat untuk menjadi shinobi. Hal inilah yang membuatnya melakukan segala cara agar bisa mendapatkan pengakuan dari ayahnya dan orang-orang yang menganggapnya hanya sebagai anak hokage.', 
    'May 9, 2016'
),

(
    'One Piece', 
    'one_piece', 
    'coverArt/comic/one_piece_c.jpg', 
    'coverArt/comic/one_piece_b.png', 
    'Eiichiro Oda', 
    'Eiichiro Oda', 
    'Ongoing', 
    'Manga',
    1150,
    'Harta karun terbesar adalah kebebasan.', 
    'Monkey D. Luffy berlayar mengarungi Grand Line bersama kru Topi Jerami demi menemukan One Piece dan menjadi Raja Bajak Laut. Petualangan epik yang penuh persahabatan, pengorbanan, dan kebebasan.', 
    'Jul 22, 1997'
),

(
    'Naruto', 
    'naruto', 
    'coverArt/comic/naruto_c.jpg', 
    'coverArt/comic/naruto_b.png', 
    'Masashi Kishimoto', 
    'Masashi Kishimoto',
    'Completed',
    'Manga',
    244,
    'Percayai dirimu - itulah jalan ninja.', 
    'Naruto Uzumaki, bocah yang dijauhi desa karena menyimpan rubah ekor sembilan, berjuang keras untuk diakui dan meraih gelar Hokage. Kisah tentang kerja keras, persahabatan, dan memaafkan.', 
    'Sep 21, 1999'
),

(
    'Naruto Shippuden',
    'naruto_shippuden',
    'coverArt/comic/naruto_s_c.jpg', 
    'coverArt/comic/naruto_s_b.png', 
    'Masashi Kishimoto',
    'Masashi Kishimoto',
    'Completed',
    'Manga',
    456,
    'Perdamaian yang diperjuangkan dengan darah.', 
    'Dua setengah tahun setelah berlatih, Naruto kembali menghadapi ancaman Akatsuki dan rahasia gelap dunia shinobi. Pertarungan terakhir untuk menyelamatkan sahabatnya dan seluruh dunia dimulai.', 
    'Feb 15, 2007'
),

(
    'Solo Leveling', 
    'solo_leveling', 
    'coverArt/comic/solo_leveling_c.jpg', 
    'coverArt/comic/solo_leveling_b.png', 
    'Chugong', 
    'Dubu', 
    'Completed',
    'Manhwa', 
    200,
    'Dari yang terlemah menjadi yang terkuat - sendirian.', 
    'Sung Jinwoo, hunter terlemah di dunia, terjebak di dungeon mematikan dan mendapat sistem misterius yang hanya ia bisa lihat. Ia mulai naik level sendirian dalam dunia yang penuh monster dan bahaya.', 
    'Mar 4, 2018'
),

(
    'Chainsaw Man', 
    'chainsawman', 
    'coverArt/comic/chainsawman_c.jpg', 
    'coverArt/comic/chainsawman_b.png', 
    'Tatsuki Fujimoto', 
    'Tatsuki Fujimoto', 
    'Completed', 
    'Manga', 
    232,
    'Semua yang ia inginkan hanya roti dan pelukan.', 
    'Denji hidup dalam kemiskinan ekstrem bersama iblis gergaji bernama Pochita. Setelah mati dan dibangkitkan sebagai Chainsaw Man, ia bergabung dengan biro pembasmi iblis - dan dunianya tak pernah sama lagi.', 
    'Dec 3, 2018'
),

(
    'Jujutsu Kaisen', 
    'jjk', 
    'coverArt/comic/jjk_c.jpg', 
    'coverArt/comic/jjk_b.png', 
    'Gege Akutami', 
    'Gege Akutami', 
    'Completed', 
    'Manga', 
    271,
    'Menelan kutukan demi menyelamatkan yang dicintai.', 
    'Yuji Itadori menelan jari Ryomen Sukuna, raja kutukan, demi menyelamatkan temannya. Kini ia harus hidup sebagai wadah kutukan terkuat sambil berjuang melawan dunia supranatural yang brutal.', 
    'Mar 5, 2018'
),

(
    'Fullmetal Alchemist', 
    'fma', 
    'coverArt/comic/fma_c.jpg', 
    'coverArt/comic/fma_b.jpg', 
    'Hiromu Arakawa', 
    'Hiromu Arakawa', 
    'Completed', 
    'Manga',
    116,
    'Satu untuk semua, semua untuk satu - harga dari keserakahan.', 
    'Dua bersaudara Edward dan Alphonse Elric kehilangan tubuh mereka saat mencoba menghidupkan ibu mereka dengan alkimia terlarang. Mereka mencari Philosopher''s Stone untuk memulihkan segalanya - dan menemukan kebenaran yang jauh lebih besar.', 
    'Jul 12, 2001'
),

(
    'Invincible', 
    'invincible', 
    'coverArt/comic/invincible_c.jpg', 
    'coverArt/comic/invincible_b.png', 
    'Robert Kirkman', 
    'Ryan Ottley', 
    'Completed', 
    'Comic',
    144,
    'Menjadi pahlawan tidak semudah terbang.', 
    'Mark Grayson adalah putra superhero terkuat di Bumi. Saat kekuatannya muncul, ia siap mengikuti jejak ayahnya - sampai kebenaran tentang sang ayah menghancurkan segalanya.', 
    'Jan 22, 2003'
),

(
    'The Amazing Spider-Man', 
    'amazing_spiderman', 
    'coverArt/comic/spiderman_c.jpg', 
    'coverArt/comic/spiderman_b.jpg', 
    'Stan Lee', 
    'Steve Ditko', 
    'Completed', 
    'Comic',
    900,
    'Kekuatan besar, tanggung jawab besar.', 
    'Peter Parker, remaja pemalu yang digigit laba-laba radioaktif, menjadi Spider-Man. Antara kuliah, cinta, dan membasmi kejahatan New York, ia belajar bahwa menjadi pahlawan bukan tentang ketenaran.', 
    'Mar 1, 1963'
),

(
    'Superman', 
    'superman', 
    'coverArt/comic/superman_c.jpg', 
    'coverArt/comic/superman_b.png', 
    'Jerry Siegel', 
    'Joe Shuster', 
    'Completed', 
    'Comic',
    488,
    'Harapan adalah kekuatan yang sesungguhnya.', 
    'Kal-El, putra terakhir Krypton, dibesarkan di Kansas sebagai Clark Kent. Sebagai Superman, ia melindungi Bumi bukan karena kewajiban, tapi karena ia percaya pada kebaikan manusia.', 
    'Apr 18, 1938'
),

(
    'The Boys', 
    'the_boys', 
    'coverArt/comic/the_boys_c.jpg', 
    'coverArt/comic/the_boys_b.jpg', 
    'Garth Ennis', 
    'Darick Robertson',
    'Completed', 
    'Comic',
    72, 
    'Pahlawan palsu, kejahatan nyata.', 
    'Di dunia di mana superhero dikelola seperti selebriti korporat, sekelompok orang biasa bernama The Boys bertugas mengawasi - dan menghentikan - para "pahlawan" yang korup dan berbahaya.', 
    'Jul 1, 2006'
),

(
    'My Hero Academia',
    'mha',
    'coverArt/comic/mha_c.jpg',
    'coverArt/comic/mha_b.jpg',
    'Kohei Horikoshi',
    'Kohei Horikoshi',
    'Completed',
    'Manga',
    430,
    'Bahkan tanpa kekuatan, hati seorang pahlawan tetap menyala.', 
    'Di dunia di mana hampir semua orang punya kemampuan super (Quirk), Izuku Midoriya lahir tanpa satu pun. Namun tekadnya yang membara menarik perhatian pahlawan terkuat di dunia, All Might, yang mewariskan kekuatannya.', 
    'Jul 7, 2014'
),

(
    'Blue Lock', 
    'blue_lock', 
    'coverArt/comic/bl_c.png', 
    'coverArt/comic/bl_b.jpg', 
    'Muneyuki Kaneshiro', 
    'Yusuke Nomura', 
    'Ongoing',
    'Manga',
    310,
    'Hanya satu yang boleh menjadi striker terbaik dunia.', 
    '300 pemain sepak bola muda Jepang dikurung dalam fasilitas bernama Blue Lock. Tujuannya: melahirkan satu striker egois terbaik yang akan membawa Jepang merajai dunia. Isagi Yoichi harus berevolusi atau tersingkir.', 
    'Aug 1, 2018'
),

(
    'Monster', 
    'monster_urasawa', 
    'coverArt/comic/monster_c.jpg', 
    'coverArt/comic/monster_b.png', 
    'Naoki Urasawa', 
    'Naoki Urasawa', 
    'Completed', 
    'Manga',
    162,
    'Menyelamatkan satu nyawa - dan membiarkan monster lahir.', 
    'Dr. Tenma menyelamatkan seorang bocah laki-laki alih-alih walikota, dan pilihan itu menghancurkan kariernya. Bertahun-tahun kemudian, bocah itu tumbuh menjadi pembunuh berantai paling berbahaya di Eropa - dan Tenma harus menghentikannya.', 
    'Dec 5, 1994'
),

(
    '20th Century Boys', 
    '20thcb', 
    'coverArt/comic/20thcb_c.jpg', 
    'coverArt/comic/20thcb_b.png', 
    'Naoki Urasawa', 
    'Naoki Urasawa', 
    'Completed', 
    'Manga',
    249,
    'Buku ramalan masa kecil menjadi mimpi buruk nyata.', 
    'Kenji dan teman-temannya semasa kecil pernah membuat "buku ramalan" berisi skenario kiamat sebagai permainan. Kini skenario itu mulai terwujud, dan seorang tokoh misterius bernama "Friend" tampaknya ada di balik semuanya.', 
    'Sep 22, 1999'
),

(
    'Black Clover', 
    'black_clover', 
    'coverArt/comic/bc_c.jpg', 
    'coverArt/comic/bc_b.jpg', 
    'Yuki Tabata', 
    'Yuki Tabata', 
    'Completed', 
    'Manga',
    392,
    'Tanpa sihir pun, aku akan menjadi Kaisar Sihir!', 
    'Asta lahir tanpa sihir di dunia di mana sihir adalah segalanya. Dengan tekad membara dan pedang anti-sihir, ia bersaing dengan sahabatnya Yuno untuk meraih gelar Kaisar Sihir tertinggi.', 
    'Feb 16, 2015'
),

(
    'Look Back', 
    'look_back', 
    'coverArt/comic/lookback_c.jpg', 
    'coverArt/comic/lookback_b.png', 
    'Tatsuki Fujimoto', 
    'Tatsuki Fujimoto', 
    'Completed', 
    'Manga',
    1,
    'Dua gadis, satu passion - dan kenangan yang tak terhapus.', 
    'Fujino dan Kyomoto adalah dua anak berbeda yang dihubungkan oleh cinta terhadap manga. Karya satu chapter Tatsuki Fujimoto ini mengisahkan persahabatan, kreativitas, dan kehilangan dengan cara yang membekas dalam.', 
    'Jul 19, 2021'
),

(
    'Gintama', 
    'gintama', 
    'coverArt/comic/gintama_c.jpg', 
    'coverArt/comic/gintama_b.png', 
    'Hideaki Sorachi', 
    'Hideaki Sorachi', 
    'Completed', 
    'Manga',
    704, 
    'Jangan anggap remeh orang yang menjaga rambutnya tetap perak.', 
    'Di Edo yang telah dijajah alien bernama Amanto, Gintoki Sakata - samurai malas pemakan permen - menjalankan jasa "Yorozuya" bersama dua anak ajaib. Komedi gila dengan momen serius yang menenangkan hati.', 
    'Dec 8, 2003'
),

(
    'Mob Psycho 100', 
    'mob_psycho', 
    'coverArt/comic/mob_c.jpg', 
    'coverArt/comic/mob_b.jpg', 
    'ONE', 
    'ONE', 
    'Completed', 
    'Manga',
    101, 
    '100% emosi yang tertahan - dan saat meledak, dunia bergetar.', 
    'Shigeo "Mob" Kageyama adalah anak SMP biasa yang juga merupakan esper paling kuat di dunia. Ia menekan emosinya agar kekuatannya tidak lepas kendali - tapi berapa lama ia bisa bertahan?', 
    'Apr 18, 2012'
),

(
    'Dragon Ball Super', 
    'dbz', 
    'coverArt/comic/dbs_c.jpg', 
    'coverArt/comic/dbs_b.jpg', 
    'Akira Toriyama', 
    'Akira Toriyama', 
    'Completed', 
    'Manga',
    519, 
    'Lampaui batasmu - dan lampaui lagi.', 
    'Goku, kini dewasa dan punya anak, menghadapi ancaman dari luar angkasa dan dimensi lain. Dari Saiyan hingga Cell hingga Majin Buu, ia dan para pejuang Z terus mendorong batas kekuatan manusia dan alien.', 
    'Apr 26, 1988'
),

(
    'Kagurabachi', 
    'kagurabachi', 
    'coverArt/comic/kagurabachi_c.jpg', 
    'coverArt/comic/kagurabachi_b.jpg', 
    'Takeru Hokazono', 
    'Takeru Hokazono', 
    'Ongoing', 
    'Manga',
    121, 
    'Pedang sang ayah, dendam sang putra.', 
    'Chihiro Rokuhira menyaksikan ayahnya - seorang pandai pedang legendaris - dibunuh dan pedang-pedang saktinya dicuri. Kini ia memburu para pelaku dengan satu pedang tersisa dan tekad yang tak tergoyahkan.', 
    'Sep 19, 2023'
),

(
    'Hunter x Hunter', 
    'hxh', 
    'coverArt/comic/hxh_c.jpg', 
    'coverArt/comic/hxh_b.jpg', 
    'Yoshihiro Togashi', 
    'Yoshihiro Togashi', 
    'Hiatus', 
    'Manga', 
    410, 
    'Dunia lebih luas dan lebih gelap dari yang kamu bayangkan.', 
    'Gon Freecss ingin menjadi Hunter seperti ayahnya yang tak pernah ia kenal. Perjalanannya mempertemukannya dengan Killua, Kurapika, dan Leorio - serta membawanya ke sudut-sudut dunia yang paling berbahaya.', 
    'Mar 3, 1998'
);




-- Insert Game

INSERT INTO arts (title, nametag, play_url, cover_img, banner_img, ss1_img, ss2_img, ss3_img, authorOrDev, category, tagline, synopsis, published_at) VALUES

(
    'Stardew Valley',
    'stardew_valley',
    'https://store.steampowered.com/app/413150/Stardew_Valley/',
    'coverArt/game/sv_c.jpg',
    'coverArt/game/sv_b.png',
    'screenshotsGame/sv_ss1.jpg',
    'screenshotsGame/sv_ss2.jpg',
    'screenshotsGame/sv_ss3.jpg',
    'ConcernedApe',
    'Game',
    'Tinggalkan kota dan temukan hidupmu yang sesungguhnya.', 
    'Kamu mewarisi ladang kakek di desa Pelican Town. Dari ladang yang terbengkalai, bangun kehidupan baru: bertani, berteman, jatuh cinta, dan mungkin menemukan misteri lembah yang lebih dalam dari yang terlihat.', 
    'Feb 26, 2016'
),

(
    'Hollow Knight',
    'hollow_knight',
    'https://store.steampowered.com/app/367520/Hollow_Knight/',
    'coverArt/game/hk_c.png',
    'coverArt/game/hk_b.png',
    'screenshotsGame/hk_ss1.png', 
    'screenshotsGame/hk_ss2.png', 
    'screenshotsGame/hk_ss3.png', 
    'Team Cherry', 
    'Story Game', 
    'Di bawah tanah, kerajaan yang terlupakan menunggumu.', 
    'Seorang ksatria kecil menjelajahi Hallownest, kerajaan serangga bawah tanah yang runtuh akibat wabah kuno. Platformer-metroidvania dengan dunia yang dalam, lore tersembunyi, dan boss yang menantang.', 
    'Feb 24, 2017'
),

(
    'Undertale', 
    'undertale', 
    'https://store.steampowered.com/app/391540/Undertale/', 
    'coverArt/game/undertale_c.png',
    'coverArt/game/undertale_b.jpg', 
    'screenshotsGame/undertale_ss1.jpg', 
    'screenshotsGame/undertale_ss2.jpg', 
    'screenshotsGame/undertale_ss3.jpg', 
    'Toby Fox', 
    'Story Game', 
    'RPG di mana kamu tidak harus membunuh siapapun.', 
    'Seorang anak jatuh ke dunia bawah tanah yang dipenuhi monster. Pilihan ada di tanganmu: bertarung atau berdamai. Setiap keputusan punya konsekuensi - dan game ini tidak melupakannya.', 
    'Sep 15, 2015'
),

(
    'A Space for the Unbound', 
    'space_unbound', 
    'https://store.steampowered.com/app/1201270/A_Space_for_the_Unbound/',
    'coverArt/game/space_c.png', 
    'coverArt/game/space_b.png', 
    'screenshotsGame/space_ss1.jpg', 
    'screenshotsGame/space_ss2.jpg', 
    'screenshotsGame/space_ss3.png', 
    'Mojiken Studio', 
    'Story Game', 
    'Di balik kenangan indah, tersimpan luka yang mendalam.', 
    'Di Indonesia akhir 90-an, Atma dan Raya adalah dua remaja yang ingin menghabiskan hari-hari terakhir SMA dengan tenang. Namun kekuatan supernatural mulai muncul dan realitas perlahan runtuh di sekeliling mereka.', 
    'Jan 19, 2023'
),

(
    'Pikabuu: Unhuman', 
    'pikabuu_unhuman',
    'https://joykeratif.itch.io/pikabuu-unhuman',
    'coverArt/game/pu_c.jpg', 
    'coverArt/game/pu_b.png',
    'screenshotsGame/pu_ss1.jpg', 
    'screenshotsGame/pu_ss2.png', 
    'screenshotsGame/pu_ss3.png', 
    'Joykeratif', 
    'Story Game', 
    'Di balik api, kebenaran menanti.', 
    'Pemain mengawali cerita saat sebuah rumah dilalap api besar, memicu kedatangan petugas pemadam kebakaran. Di balik kobaran api dan reruntuhan, tersimpan misteri gelap yang harus dipecahkan.', 
    'Feb 1, 2026'
),

(
    'Pikabuu: STOP!', 
    'pikabuu_stop', 
    'https://store.steampowered.com/app/3837390/Pikabuu_STOP/',
    'coverArt/game/ps_c.jpg', 
    'coverArt/game/ps_b.png', 
    'screenshotsGame/ps_ss1.png', 
    'screenshotsGame/ps_ss2.jpg', 
    'screenshotsGame/ps_ss3.png', 
    'Joykeratif', 
    'Story Game', 
    'Satu tindakan kecil merusak segalanya.', 
    'Mengisahkan seorang kepala keluarga penyayang yang hidup sederhana bersama istri dan anaknya. Akibat tekanan ekonomi, Benny terjerumus ke dalam pusaran judi online (judol) dan pinjaman online (pinjol).', 
    'Jul 26, 2025'
),

(
    'Spark in the Dark', 
    'spark_dark', 
    'https://fasep001.itch.io/stid',
    'coverArt/game/spark_c.png', 
    'coverArt/game/spark_b.png', 
    'screenshotsGame/spark_ss1.png', 
    'screenshotsGame/spark_ss2.png', 
    'screenshotsGame/spark_ss3.png', 
    'Spaf', 
    'Story Game', 
    'Bahkan percikan kecil bisa menerangi kegelapan.', 
    'Game pendek yang penuh kehangatan tentang menemukan cahaya di tengah kegelapan. Temukan kebenarannya? Kembali ke rumah? Atau selamatkan orang yang menyiksamu?', 
    'Oct 20, 2025'
),

(
    'Celeste', 
    'celeste', 
    'https://store.steampowered.com/app/504230/Celeste/',
    'coverArt/game/celeste_c.png', 
    'coverArt/game/celeste_b.png', 
    'screenshotsGame/celeste_ss1.jpg', 
    'screenshotsGame/celeste_ss2.jpg', 
    'screenshotsGame/celeste_ss3.png', 
    'Maddy Thorson & Noel Berry', 
    'Game', 
    'Mendaki gunung untuk menghadapi dirimu sendiri.', 
    'Madeline mendaki Gunung Celeste untuk membuktikan sesuatu pada dirinya sendiri. Namun musuh terberatnya bukan di luar - melainkan bagian dari dirinya sendiri. Platformer yang indah tentang kesehatan mental dan menerima diri.', 
    'Jan 25, 2018'
),

(
    'Hades', 
    'hades', 
    'https://store.steampowered.com/app/1145360/Hades/',
    'coverArt/game/hades_c.jpg', 
    'coverArt/game/hades_b.jpg', 
    'screenshotsGame/hades_ss1.jpg', 
    'screenshotsGame/hades_ss2.jpg', 
    'screenshotsGame/hades_ss3.jpg', 
    'Supergiant Games', 
    'Story Game', 
    'Mati adalah permulaan, bukan akhir.', 
    'Zagreus, putra Hades, terus-menerus berusaha melarikan diri dari dunia bawah. Setiap kematian membawanya kembali ke awal - namun juga lebih kuat, dan lebih dekat dengan kebenaran keluarganya.', 
    'Sep 17, 2020'
),

(
    'Touhou 6: The Embodiment of Scarlet Devil', 
    'touhou6', 
    'https://oldgamesdownload.com/touhou-6-embodiment-of-scarlet-devil/',
    'coverArt/game/th6_c.png', 
    'coverArt/game/th6_b.png', 
    'screenshotsGame/th6_ss1.jpg', 
    'screenshotsGame/th6_ss2.jpg', 
    'screenshotsGame/th6_ss3.jpg', 
    'ZUN (Team Shanghai Alice)', 
    'Game', 
    'Sebuah kabut merah menyelimuti Gensokyo - siapakah pelakunya?', 
    'Reimu Hakurei dan Marisa Kirisame menyelidiki kabut merah misterius yang menyelimuti Gensokyo. Bullet hell legendaris yang melahirkan seluruh franchise Touhou Project.', 
    'Aug 11, 2002'
),

(
    'Hello Charlotte', 
    'hello_charlotte', 
    'https://etherane.itch.io/hello-charlotte-ep1',
    'coverArt/game/charlotte_c.png',
    'coverArt/game/charlotte_b.jpg',
    'screenshotsGame/charlotte_ss1.jpg',
    'screenshotsGame/charlotte_ss2.jpg',
    'screenshotsGame/charlotte_ss3.jpg',
    'etherane', 
    'Story Game', 
    'Dunia ini adalah panggung, dan kamu adalah sutradaranya.', 
    'Charlotte hidup di dunia yang rapuh dan aneh. Game RPG maker dengan estetika gelap yang mengeksplorasi eksistensi, kekosongan, dan arti dari "nyata" dengan cara yang unik dan menggugah.', 
    'Dec 5, 2014'
),

(
    'The Dearest Person', 
    'dearest_person', 
    'https://store.steampowered.com/app/2881870/Samyj_dorogoj_chelovek/',
    'coverArt/game/dearest_c.jpg', 
    'coverArt/game/dearest_b.jpg', 
    'screenshotsGame/dearest_ss1.jpg', 
    'screenshotsGame/dearest_ss2.jpg', 
    'screenshotsGame/dearest_ss3.jpg', 
    'House Opposite', 
    'Story Game', 
    'Siapa orang yang paling berarti bagimu?', 
    'Game naratif pendek yang mengajak pemain merenungkan hubungan mereka dengan sebuah AI tanpa perasaan melalui percakapan sederhana namun penuh makna.', 
    'Jun 26, 2024'
),

(
    'OMORI', 
    'omori', 
    'https://store.steampowered.com/app/1150690/OMORI/', 
    'coverArt/game/omori_c.jpg', 
    'coverArt/game/omori_b.png', 
    'screenshotsGame/omori_ss1.png', 
    'screenshotsGame/omori_ss2.png', 
    'screenshotsGame/omori_ss3.png', 
    'OMOCAT', 
    'Story Game', 
    'Apa yang kamu sembunyikan di balik senyummu?', 
    'Omori adalah anak pendiam yang hidup di dunia imajinasi bersama teman-temannya. Namun dunia nyata terus mengetuk pintu - dan kenangan yang ia kubur dalam-dalam mulai bangkit. RPG psikologis yang berat tentang trauma, rasa bersalah, dan penyembuhan.', 
    'Dec 25, 2020'
),

(
    'LISA: The Painful', 
    'lisa_painful', 
    'https://store.steampowered.com/app/335670/LISA_The_Painful/',
    'coverArt/game/lisa_c.jpg', 
    'coverArt/game/lisa_b.jpg', 
    'screenshotsGame/lisa_ss1.jpg', 
    'screenshotsGame/lisa_ss2.jpg', 
    'screenshotsGame/lisa_ss3.jpg', 
    'Dingaling Productions', 
    'Story Game', 
    'Di dunia yang hancur, cinta pun terasa menyakitkan.', 
    'Di dunia pasca-apokalips di mana semua wanita telah lenyap, Brad Armstrong menemukan seorang bayi perempuan. Ia membesarkannya dalam sembunyi - sampai ia diculik. Brad akan mengorbankan segalanya untuk menyelamatkannya.', 
    'Dec 15, 2014'
),

(
    'Danganronpa', 
    'danganronpa', 
    'https://store.steampowered.com/app/413410/Danganronpa_Trigger_Happy_Havoc/', 
    'coverArt/game/danganronpa_c.jpg', 
    'coverArt/game/danganronpa_b.jpg', 
    'screenshotsGame/danganronpa_ss1.jpg', 
    'screenshotsGame/danganronpa_ss2.jpg', 
    'screenshotsGame/danganronpa_ss3.jpg', 
    'Spike Chunsoft', 
    'Visual Novel', 
    'Satu-satunya cara keluar adalah membunuh - dan tidak tetangkap.', 
    '15 siswa terkurung di Hope''s Peak Academy oleh beruang mekanik bernama Monokuma. Aturannya: bunuh temanmu tanpa ketahuan, dan kamu bebas. Tapi jika pelaku teridentifikasi, semua selamat - kecuali si pelaku.', 
    'Nov 25, 2010'
),

(
    'Higurashi When They Cry', 
    'higurashi', 
    'https://store.steampowered.com/app/310360/Higurashi_When_They_Cry_Hou__Ch1_Onikakushi/', 
    'coverArt/game/higurashi_c.png', 
    'coverArt/game/higurashi_b.png', 
    'screenshotsGame/higurashi_ss1.jpg', 
    'screenshotsGame/higurashi_ss2.jpg', 
    'screenshotsGame/higurashi_ss3.jpg', 
    '07th Expansion', 
    'Visual Novel', 
    'Desa yang tenang menyimpan siklus kematian yang tak berujung.', 
    'Keiichi Maebara pindah ke desa kecil Hinamizawa yang tampak damai. Namun setiap tahun, saat festival Watanagashi, seseorang mati dan seseorang menghilang - dan sejarah terus berulang dengan cara yang berbeda.', 
    'Aug 10, 2002'
),

(
    'Umineko When They Cry', 
    'umineko', 
    'https://store.steampowered.com/app/406550/Umineko_When_They_Cry__Question_Arcs/', 
    'coverArt/game/umineko_c.png', 
    'coverArt/game/umineko_b.png', 
    'screenshotsGame/umineko_ss1.jpg', 
    'screenshotsGame/umineko_ss2.jpg', 
    'screenshotsGame/umineko_ss3.png', 
    '07th Expansion', 
    'Visual Novel', 
    'Siapa pelakunya - manusia atau penyihir?', 
    'Keluarga Ushiromiya berkumpul di pulau terpencil Rokkenjima. Saat badai memutus akses, pembunuhan berantai terjadi dengan pola yang mustahil - seolah kutukan penyihir emas Beatrice menjadi kenyataan.', 
    'Aug 17, 2007'
),

(
    'Wonderful Everyday',
    'subahibi',
    'https://store.steampowered.com/app/658620/Wonderful_Everyday_Down_the_RabbitHole/',
    'coverArt/game/subahibi_c.jpg',
    'coverArt/game/subahibi_b.png',
    'screenshotsGame/subahibi_ss1.jpg', 
    'screenshotsGame/subahibi_ss2.jpg', 
    'screenshotsGame/subahibi_ss3.jpg', 
    'KeroQ', 
    'Visual Novel', 
    'Dunia akan berakhir dalam tujuh hari - atau sudah berakhir dari dulu?', 
    'Berbagai sudut pandang karakter menjelang dan sesudah "akhir dunia" yang diramalkan. Visual novel filosofis berat yang mempertanyakan realitas, persepsi, dan makna keberadaan.', 
    'Mar 26, 2010'
),

(
    'Steins;Gate',
    'steins_gate',
    'https://store.steampowered.com/app/412830/STEINSGATE/',
    'coverArt/game/steins_gate_c.jpg',
    'coverArt/game/steins_gate_b.jpg',
    'screenshotsGame/steins_gate_ss1.jpg',
    'screenshotsGame/steins_gate_ss2.jpg',
    'screenshotsGame/steins_gate_ss3.jpg',
    '5pb. & Nitroplus', 
    'Visual Novel', 
    'Sekali kita mengubah masa lalu, segalanya bisa hancur.', 
    'Rintaro Okabe, ilmuwan gila otodidak, secara tidak sengaja menemukan cara mengirim pesan ke masa lalu. Apa yang dimulai sebagai kesenangan berubah menjadi mimpi buruk ketika organisasi gelap mulai mengancam - dan orang-orang yang ia cintai mulai menghilang.', 
    'Oct 15, 2009'
),

(
    'The House in Fata Morgana', 
    'fatamorgana', 
    'https://store.steampowered.com/app/303310/The_House_in_Fata_Morgana/', 
    'coverArt/game/fatamorgana_c.jpg', 
    'coverArt/game/fatamorgana_b.png', 
    'screenshotsGame/fatamorgana_ss1.jpg', 
    'screenshotsGame/fatamorgana_ss2.jpg', 
    'screenshotsGame/fatamorgana_ss3.jpg', 
    'Novectacle', 
    'Visual Novel', 
    'Sebuah rumah, ratusan tahun luka, dan satu jiwa yang mencari kebenaran.', 
    'Kamu terbangun di rumah misterius tanpa ingatan. Seorang maid membawamu menelusuri pintu-pintu yang membuka era berbeda - masing-masing menyimpan tragedi, cinta, dan kegelapan yang saling terjalin lintas waktu.', 
    'Dec 31, 2012'
),

(
    'Clannad',
    'clannad',
    'https://store.steampowered.com/app/324160/CLANNAD/',
    'coverArt/game/clannad_c.jpg',
    'coverArt/game/clannad_b.jpg',
    'screenshotsGame/clannad_ss1.jpg',
    'screenshotsGame/clannad_ss2.jpg',
    'screenshotsGame/clannad_ss3.jpg',
    'Key',
    'Visual Novel',
    'Di jalan menanjak yang dipenuhi cahaya.',
    'Tomoya Okazaki, remaja sinis yang membenci kotanya sendiri, bertemu Nagisa Furukawa di hari musim dingin yang biasa. Dari sana, ia mulai terhubung dengan orang-orang di sekitarnya dan menemukan kembali arti dari keluarga dan rumah.',
    'Apr 28, 2004'
);