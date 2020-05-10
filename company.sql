CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Table contains all employee details.';

INSERT INTO employees(first_name, last_name, email) VALUES('amarnath1', 'chandana1', 'amarnath1@github.com');
INSERT INTO employees(first_name, last_name, email) VALUES('amarnath2', 'chandana2', 'amarnath2@github.com');
INSERT INTO employees(first_name, last_name, email) VALUES('amarnath3', 'chandana3', 'amarnath3@github.com');
INSERT INTO employees(first_name, last_name, email) VALUES('amarnath4', 'chandana4', 'amarnath4@github.com');
INSERT INTO employees(first_name, last_name, email) VALUES('amarnath5', 'chandana5', 'amarnath5@github.com');
