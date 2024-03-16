-- movies definition

CREATE TABLE `movies` (
  `budget` int DEFAULT NULL,
  `genres` varchar(256) DEFAULT NULL,
  `homepage` varchar(128) DEFAULT NULL,
  `id` int DEFAULT NULL,
  `keywords` varchar(2048) DEFAULT NULL,
  `original_language` varchar(50) DEFAULT NULL,
  `original_title` varchar(64) DEFAULT NULL,
  `overview` varchar(1024) DEFAULT NULL,
  `popularity` double DEFAULT NULL,
  `production_companies` varchar(512) DEFAULT NULL,
  `production_countries` varchar(256) DEFAULT NULL,
  `release_date` varchar(50) DEFAULT NULL,
  `revenue` int DEFAULT NULL,
  `runtime` int DEFAULT NULL,
  `spoken_languages` varchar(512) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `tagline` varchar(128) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `vote_average` double DEFAULT NULL,
  `vote_count` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;