-- credits definition

CREATE TABLE `credits` (
  `movie_id` int DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `cast` json DEFAULT NULL,
  `crew` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;