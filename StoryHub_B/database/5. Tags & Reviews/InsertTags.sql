-- USE storyhub_db_art;

USE storyhub;


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
('Regression'), -- 24g
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
('Transmigration'), -- 41g
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
('Surrealism'), -- 96t
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
('Time Skip'); -- 140t

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
