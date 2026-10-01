-- USE storyhub_db_art;

USE storyhub;

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
(5, 33), -- Slice of Life (33g)

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