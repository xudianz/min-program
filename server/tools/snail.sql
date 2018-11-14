
-- create table books(
--   id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
--   isbn VARCHAR(20) NOT NULL,
--   openid VARCHAR(50) NOT NULL,
--   title VARCHAR(100) NOT NULL,
--   image VARCHAR(100),
--   alt VARCHAR(100) NOT NULL,
--   publisher VARCHAR(100) NOT NULL,
--   summary VARCHAR(1000) NOT NULL,
--   price VARCHAR(100),
--   rate FLOAT,
--   tags VARCHAR(100),
--   author VARCHAR(100)
-- )

 CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isbn` varchar(20) NOT NULL,
  `openid` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `alt` varchar(100) NOT NULL,
  `publisher` varchar(100) NOT NULL,
  `summary` varchar(1000) NOT NULL,
  `price` varchar(100) DEFAULT NULL,
  `rate` float DEFAULT NULL,
  `tags` varchar(100) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- create table comments(
--   id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
--   openid VARCHAR(100) NOT NULL,
--   bookid VARCHAR(100) NOT NULL,
--   comment VARCHAR(200) NOT NULL,
--   phone VARCHAR(50),
--   location VARCHAR(100)
-- )
 CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(100) NOT NULL,
  `bookid` varchar(100) NOT NULL,
  `comment` varchar(200) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;