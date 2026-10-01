-- USE storyhub_db_auth;

USE storyhub;

-- Insert users

INSERT INTO users (name, username, email, password, role) VALUES
('Jack', 'jkw', 'jack@gmail.com', 'password', 'admin'),
('Fasp', 'fasp', 'fasp@gmail.com', 'password', 'user');
