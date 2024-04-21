CREATE TABLE leitura (
  id int NOT NULL AUTO_INCREMENT,
  dht11_umidade decimal(5,2) DEFAULT NULL,
  lm35_temperatura decimal(5,2) DEFAULT NULL,
  DtLeitura timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select * from leitura;