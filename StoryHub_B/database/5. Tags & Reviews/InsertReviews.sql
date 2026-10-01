-- USE storyhub_db_review;

USE storyhub;

-- Insert Reviews

INSERT INTO reviews (target_type, target_id, user_id, rating, komentar) VALUES
('art', 1, 2, 10, 'review');

-- Insert Comments

INSERT INTO comments (target_type, target_id, user_id, komentar) VALUES
('review', 1, 2, 'komentar');

