/*
CREATE DATABASE CodeSensor2;
USE CodeSensor2;

CREATE TABLE Empresa (
idEmpresa INT AUTO_INCREMENT,
nome_fantasia VARCHAR(45) UNIQUE,
CNPJ CHAR(18) UNIQUE,
CEP CHAR(9),
Telefone VARCHAR(20) UNIQUE,
Email VARCHAR(345)UNIQUE,
fkEmpresa INT, -- Essa FK é para sabermos qual filial é de qual empresa
			   -- Fazendo o AUTO-RELACIONAMENTO da tabela Empresa...

PRIMARY KEY PK_idEmpresa (idEmpresa),
FOREIGN KEY ForeignKey_fkEmpresa (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Funcionario (
idFuncionario INT AUTO_INCREMENT,
Nome VARCHAR(50), 
Email VARCHAR(345) UNIQUE,
chaveAcesso CHAR(10) UNIQUE,
CPF VARCHAR(14) UNIQUE,
fkEmpresa INT,

PRIMARY KEY PK_idFuncionario (idFuncionario),
FOREIGN KEY ForeignKey_fkEmpresa (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Veiculo (
idVeiculo INT AUTO_INCREMENT,
cargaMaxima FLOAT,
Placa VARCHAR(10) UNIQUE, -- são 10 caracteres na Alemanha...
fkEmpresa INT,

PRIMARY KEY PK_idVeiculo (idVeiculo),
FOREIGN KEY ForeignKey_idEmpresa (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Lote (
idLote INT AUTO_INCREMENT,
tipoCarne 
	VARCHAR(12),
	CHECK (tipoCarne IN ('Bovina', 'Suína', 'Carne de ave')),
quantidadeCarne INT, -- qtdCarne nos referimos as peças de carne, e não quantas carnes por KG.
fkVeiculo INT,

PRIMARY KEY PK_idLote (idLote),
FOREIGN KEY ForeignKey_idVeiculo (fkVeiculo) REFERENCES Veiculo (idVeiculo)
);

CREATE TABLE Sensor (
idSensor INT AUTO_INCREMENT,
Modelo 
	VARCHAR(5),
	CHECK (Modelo IN ('LM35', 'DHT11')),
Tipo
	VARCHAR(12),
	CHECK (Tipo IN ('Temperatura', 'Umidade')),
dtInstalacao DATETIME,
fkVeiculo INT,

PRIMARY KEY PK_idSensor (idSensor),
FOREIGN KEY ForeignKey_idVeiculo (fkVeiculo) REFERENCES Veiculo (idVeiculo)
);

CREATE TABLE Leitura (
idLeitura INT AUTO_INCREMENT,
dtLeitura DATETIME,
temperatura DECIMAL(5, 2) DEFAULT NULL,
umidade DECIMAL(5, 2) DEFAULT NULL,
fkSensor INT,

PRIMARY KEY PK_idLeitura (idLeitura),
FOREIGN KEY ForeignKey_idSensor (fkSensor) REFERENCES Sensor (idSensor)
);

-- Inserindo dados na tabela Empresa
INSERT INTO Empresa (nome_fantasia, CNPJ, CEP, Telefone, Email, fkEmpresa)
VALUES 
('Empresa A', '12345678901234', '12345-678', '(11) 1234-5678', 'empresaA@example.com', NULL),
('Empresa B', '56789012345678', '98765-432', '(22) 9876-5432', 'empresaB@example.com', NULL),
('Empresa C', '90123456789012', '54321-098', '(33) 5432-1098', 'empresaC@example.com', NULL),
('Empresa D', '34567890123456', '13579-246', '(44) 1357-9246', 'empresaD@example.com', NULL),
('Empresa E', '78901234567890', '98765-432', '(55) 9876-5432', 'empresaE@example.com', NULL),
('Empresa F', '23456789012345', '43210-987', '(66) 4321-0987', 'empresaF@example.com', NULL);

-- Inserindo na mesma tabela (por causa do auto-relacionamento), as filiais
-- e de que empresas elas são. LEMBRANDO: Teremos então 
-- 6 (de cima) + 4 (abaixo) = 10 Linhas de dados da tabela Empresa
INSERT INTO Empresa (nome_fantasia, CNPJ, CEP, Telefone, Email, fkEmpresa)
VALUES
('Filial G Empresa C', '23456999034345', '43210-007', '(77) 1321-0387', 'filialG@example.com', 3),
('Filial H Empresa A', '23456829034345', '43210-747', '(88) 1321-0387', 'filialH@example.com', 1),
('Filial I Empresa D', '23456289034345', '43210-127', '(99) 1321-0387', 'filialI@example.com', 4),
('Filial J Empresa F', '23456719034345', '43210-547', '(00) 1321-0387', 'filialJ@example.com', 6);

-- Inserts para a tabela Funcionario
INSERT INTO Funcionario (Nome, Email, chaveAcesso, CPF, fkEmpresa) 
VALUES 
('Funcionario 1', 'funcionario1@example.com', 'chave123', '123.456.789-01', 1),
('Funcionario 2', 'funcionario2@example.com', 'chave456', '987.654.321-09', 1),
('Funcionario 3', 'funcionario3@example.com', 'chave789', '456.123.789-12', 2),
('Funcionario 4', 'funcionario4@example.com', 'chave987', '654.321.987-98', 3),
('Funcionario 5', 'funcionario5@example.com', 'chave654', '789.456.123-45', 5),
('Funcionario 6', 'funcionario6@example.com', 'chave321', '321.654.987-32', 6);

-- Inserts para a tabela Veiculo
INSERT INTO Veiculo (cargaMaxima, Placa, fkEmpresa) 
VALUES 
(1000.50, 'ABC1234', 1),
(750.25, 'DEF5678', 1),
(500.75, 'GHI9012', 2),
(1200.30, 'JKL3456', 3),
(900.80, 'MNO7890', 4),
(600.60, 'PQR1234', 6);

-- Inserts para a tabela Lote
INSERT INTO Lote (tipoCarne, quantidadeCarne, fkVeiculo) 
VALUES 
('Bovina', 100, 1),
('Suína', 150, 2),
('Carne de ave', 200, 3),
('Bovina', 120, 4),
('Suína', 180, 5),
('Carne de ave', 220, 6);

-- Inserts para a tabela Sensor
INSERT INTO Sensor (Modelo, Tipo, dtInstalacao, fkVeiculo) 
VALUES 
('LM35', 'Temperatura', '2024-04-01 10:00:00', 1),
('LM35', 'Temperatura', '2024-04-01 10:00:00', 2),
('DHT11', 'Umidade', '2024-04-01 10:00:00', 3),
('DHT11', 'Umidade', '2024-04-01 10:00:00', 4),
('LM35', 'Temperatura', '2024-04-01 10:00:00', 5),
('DHT11', 'Umidade', '2024-04-01 10:00:00', 6);

-- Inserts para a tabela Leitura
INSERT INTO Leitura (dtLeitura, temperatura, umidade, fkSensor) 
VALUES 
('2024-04-05 10:00:00', 25.5, DEFAULT, 1),
('2024-04-05 10:00:00', 4.2, DEFAULT, 2),
('2024-04-05 10:00:00', DEFAULT, 58.9, 3),
('2024-04-05 10:00:00', DEFAULT, 62.4, 4),
('2024-04-05 10:00:00', 25.8, DEFAULT, 5),
('2024-04-05 10:00:00', DEFAULT, 64.2, 6);

-- ===========================================
-- Select com INNER JOIN das tabelas Sensor e Leitura:

SELECT *
FROM Sensor AS S
INNER JOIN Leitura AS Leit
ON S.idSensor = Leit.fkSensor;
-- ===========================================
-- SELECT com INNER JOIN de auto relacionamento da tabela Empresa:

SELECT Matriz.*, Filial.*
FROM Empresa AS Matriz
INNER JOIN Empresa AS Filial
ON Matriz.fkEmpresa = Filial.idEmpresa;
*/

/*
CREATE DATABASE CodeSensor2;
USE CodeSensor2;

CREATE TABLE Empresa (
idEmpresa INT AUTO_INCREMENT,
nome_fantasia VARCHAR(45) UNIQUE,
CNPJ CHAR(18) UNIQUE,
CEP CHAR(9),
Telefone VARCHAR(15) UNIQUE,
Email VARCHAR(345)UNIQUE,
fkMatriz INT, -- Essa FK é para sabermos qual filial é de qual empresa
			   -- Fazendo o AUTO-RELACIONAMENTO da tabela Empresa...

PRIMARY KEY PK_idEmpresa (idEmpresa),
FOREIGN KEY ForeignKey_fkEmpresa (fkMatriz) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Funcionario (
idFuncionario INT AUTO_INCREMENT,
tipo VARCHAR (11) default "funcionario",
Nome VARCHAR(50), 
Email VARCHAR(345) UNIQUE,
chaveAcesso CHAR(10) UNIQUE,
CPF CHAR(12) UNIQUE,
fkEmpresa INT,
constraint chk_tipo CHECK(tipo in("superior", "funcionario")),
PRIMARY KEY PK_idFuncionario (idFuncionario),
FOREIGN KEY ForeignKey_fkEmpresa (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Veiculo (
idVeiculo INT AUTO_INCREMENT,
carga FLOAT,
Placa VARCHAR(10) UNIQUE, -- são 10 caracteres na Alemanha...
fkEmpresa INT,

PRIMARY KEY PK_idVeiculo (idVeiculo),
FOREIGN KEY ForeignKey_idEmpresa (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Lote (
idLote INT AUTO_INCREMENT,
tipoCarne 
	VARCHAR(12),
	CHECK (tipoCarne IN ('Bovina', 'Suína', 'Carne de ave')),
quantidadeCarne INT, -- qtdCarne nos referimos as peças de carne, e não quantas carnes por KG.
dataPartida DATE,
dataChegada date,
fkVeiculo INT,

PRIMARY KEY PK_idLote (idLote),
FOREIGN KEY ForeignKey_idVeiculo (fkVeiculo) REFERENCES Veiculo (idVeiculo)
);

CREATE TABLE Sensor (
idSensor INT AUTO_INCREMENT,
Modelo 
	VARCHAR(5),
	CHECK (Modelo IN ('LM35', 'DHT11')),
	CHECK (Tipo IN ('Temperatura', 'Umidade')),
dtInstalacao DATETIME,
fkVeiculo INT,

PRIMARY KEY PK_idSensor (idSensor),
FOREIGN KEY ForeignKey_idVeiculo (fkVeiculo) REFERENCES Veiculo (idVeiculo)
);

CREATE TABLE Leitura (
idLeitura INT AUTO_INCREMENT,
dtLeitura DATETIME,
dados DECIMAL(5, 2) DEFAULT NULL,
fkSensor INT,

PRIMARY KEY PK_idLeitura (idLeitura),
FOREIGN KEY ForeignKey_idSensor (fkSensor) REFERENCES Sensor (idSensor)
);

-- Inserindo dados na tabela Empresa
INSERT INTO Empresa (nome_fantasia, CNPJ, CEP, Telefone, Email, fkMatriz)
VALUES 
('Empresa A', '12345678901234', '12345-678', '(11) 1234-5678', 'empresaA@example.com', NULL),
('Empresa B', '56789012345678', '98765-432', '(22) 9876-5432', 'empresaB@example.com', NULL),
('Empresa C', '90123456789012', '54321-098', '(33) 5432-1098', 'empresaC@example.com', NULL),
('Empresa D', '34567890123456', '13579-246', '(44) 1357-9246', 'empresaD@example.com', NULL),
('Empresa E', '78901234567890', '98765-432', '(55) 9876-5432', 'empresaE@example.com', NULL),
('Empresa F', '23456789012345', '43210-987', '(66) 4321-0987', 'empresaF@example.com', NULL);

-- Inserindo na mesma tabela (por causa do auto-relacionamento), as filiais
-- e de que empresas elas são. LEMBRANDO: Teremos então 
-- 6 (de cima) + 4 (abaixo) = 10 Linhas de dados da tabela Empresa
INSERT INTO Empresa (nome_fantasia, CNPJ, CEP, Telefone, Email, fkMatriz)
VALUES
('Filial G Empresa C', '23456999034345', '43210-007', '(77) 1321-0387', 'filialG@example.com', 3),
('Filial H Empresa A', '23456829034345', '43210-747', '(88) 1321-0387', 'filialH@example.com', 1),
('Filial I Empresa D', '23456289034345', '43210-127', '(99) 1321-0387', 'filialI@example.com', 4),
('Filial J Empresa F', '23456719034345', '43210-547', '(00) 1321-0387', 'filialJ@example.com', 6);

-- Inserts para a tabela Funcionario
INSERT INTO Funcionario (Nome, Email, chaveAcesso, CPF, fkEmpresa) 
VALUES 
('Funcionario 1', 'funcionario1@example.com', 'chave123', '123456789-01', 1),
('Funcionario 2', 'funcionario2@example.com', 'chave456', '987654321-09', 1),
('Funcionario 3', 'funcionario3@example.com', 'chave789', '456123789-12', 2),
('Funcionario 4', 'funcionario4@example.com', 'chave987', '654321987-98', 3),
('Funcionario 5', 'funcionario5@example.com', 'chave654', '789456123-45', 5),
('Funcionario 6', 'funcionario6@example.com', 'chave321', '321654987-32', 6);

-- Inserts para a tabela Veiculo
INSERT INTO Veiculo (cargaMaxima, Placa, fkEmpresa) 
VALUES 
(1000.50, 'ABC1234', 1),
(750.25, 'DEF5678', 1),
(500.75, 'GHI9012', 2),
(1200.30, 'JKL3456', 3),
(900.80, 'MNO7890', 4),
(600.60, 'PQR1234', 6);

-- Inserts para a tabela Lote
INSERT INTO Lote (tipoCarne, quantidadeCarne,dataChegada,dataPartida,fkVeiculo) 
VALUES 
('Bovina',100,'2024-10-10','2024-10-03', 1),
('Suína', 150,'2024-09-10','2024-09-05', 2),
('Carne de ave',200,'2024-09-18','2024-09-15', 3),
('Bovina',120,'2024-09-13','2024-09-12',  4),
('Suína', 180,'2024-09-26','2024-09-22', 5),
('Carne de ave', 220,'2024-09-27','2024-09-24', 6);

-- Inserts para a tabela Sensor
INSERT INTO Sensor (Modelo, Tipo, dtInstalacao, fkVeiculo) 
VALUES 
('LM35', 'Temperatura', '2024-04-01 10:00:00', 1),
('LM35', 'Temperatura', '2024-04-01 10:00:00', 2),
('DHT11', 'Umidade', '2024-04-01 10:00:00', 3),
('DHT11', 'Umidade', '2024-04-01 10:00:00', 4),
('LM35', 'Temperatura', '2024-04-01 10:00:00', 5),
('DHT11', 'Umidade', '2024-04-01 10:00:00', 6);

-- Inserts para a tabela Leitura
INSERT INTO Leitura (dtLeitura, dados,  fkSensor) 
VALUES 
('2024-04-05 10:00:00', 25.5, 1),
('2024-04-05 10:00:00', 4.2, 2),
('2024-04-05 10:00:00',  58.9, 3),
('2024-04-05 10:00:00', 62.4, 4),
('2024-04-05 10:00:00', 25.8, 5),
('2024-04-05 10:00:00', 64.2, 6);

-- ===========================================
-- SELECT com INNER JOIN de auto relacionamento da tabela Empresa:

SELECT Matriz.*, Filial.*
FROM Empresa AS Matriz
INNER JOIN Empresa AS Filial
ON Matriz.fkMatriz = Filial.idEmpresa;
-- ===========================================
-- SELECT com INNER JOIN das tabelas Empresa e Funcionario:
SELECT *
FROM Funcionario AS Func
INNER JOIN Empresa AS EMP
ON Func.fkEmpresa = EMP.idEmpresa;
-- ==============
-- TESTE:
SELECT *
FROM Funcionario AS Func
RIGHT JOIN Empresa AS EMP
ON EMP.idEmpresa = Func.fkEmpresa

RIGHT JOIN Empresa AS Filial
ON Filial.idEmpresa = EMP.fkMatriz;

SELECT
	EMP.idEmpresa AS 'ID Empresa', EMP.nome_fantasia AS 'Nome fantasia', EMP.CNPJ, EMP.CEP, EMP.Telefone, EMP.Email, EMP.fkMatriz AS 'FK Matriz',
    Filial.idEmpresa AS 'ID Empresa', Filial.nome_fantasia AS 'Nome fantasia', Filial.CNPJ, Filial.CEP, Filial.Telefone, Filial.Email, Filial.fkMatriz AS 'FK Matriz',
    Func.idFuncionario AS 'ID Funcionário', Func.Nome AS 'Nome funcionário', Func.Email, Func.chaveAcesso AS 'Chave de acesso', Func.CPF, Func.fkEmpresa AS 'FK Empresa'
FROM Empresa AS EMP
LEFT JOIN Empresa AS Filial
ON Filial.idEmpresa = EMP.fkMatriz

LEFT JOIN Funcionario AS Func
ON EMP.idEmpresa = Func.fkEmpresa;

-- ===========================================
-- SELECT com INNER JOIN das tabelas Empresa (matriz e filial) + Funcionario:

SELECT *
FROM Funcionario AS Func
LEFT JOIN Empresa AS Matriz
ON Func.fkEmpresa = Matriz.idEmpresa

LEFT JOIN Empresa AS Filial
ON Func.fkEmpresa = Filial.fkMatriz;
-- ===========================================
-- SELECT com INNER JOIN das tabelas Veiculo com Lote:

SELECT *
FROM Veiculo AS Veic
INNER JOIN Lote AS L
ON Veic.idVeiculo = L.fkVeiculo;
-- ===========================================
-- Select com INNER JOIN das tabelas Sensor e Leitura:

SELECT *
FROM Sensor AS S
INNER JOIN Leitura AS Leit
ON S.idSensor = Leit.fkSensor;
-- ==================================
*/
/*
CREATE DATABASE codesensor2;
USE codesensor2;

CREATE TABLE empresa (
idEmpresa INT AUTO_INCREMENT,
nome_fantasia VARCHAR(45) UNIQUE,
cnpj CHAR(18) UNIQUE,
cep CHAR(9),
telefone VARCHAR(15) UNIQUE,
email VARCHAR(345)UNIQUE,
fkMatriz INT, -- Essa FK é para sabermos qual filial é de qual empresa
			   -- Fazendo o AUTO-RELACIONAMENTO da tabela Empresa...

PRIMARY KEY PK_idEmpresa (idEmpresa),
FOREIGN KEY ForeignKey_fkEmpresa (fkMatriz) REFERENCES empresa (idEmpresa)
);

CREATE TABLE funcionario (
idFuncionario INT AUTO_INCREMENT,
tipo VARCHAR (11) default "funcionario",
nome VARCHAR(50), 
email VARCHAR(345) UNIQUE,
chaveAcesso CHAR(10) UNIQUE,
cpf CHAR(12) UNIQUE,
fkEmpresa INT,
constraint chk_tipo CHECK(tipo in("superior", "funcionario")),
PRIMARY KEY PK_idFuncionario (idFuncionario),
FOREIGN KEY ForeignKey_fkEmpresa (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE veiculo (
idVeiculo INT AUTO_INCREMENT,
carga FLOAT,
placa VARCHAR(10) UNIQUE, -- são 10 caracteres na Alemanha...
fkEmpresa INT,

PRIMARY KEY PK_idVeiculo (idVeiculo),
FOREIGN KEY ForeignKey_idEmpresa (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE lote (
idLote INT AUTO_INCREMENT,
tipoCarne 
	VARCHAR(12),
	CHECK (tipoCarne IN ('bovina', 'suína', 'carne de ave')),
quantidadeCarne INT, -- qtdCarne nos referimos as peças de carne, e não quantas carnes por KG.
dataPartida DATE,
dataChegada date,
fkVeiculo INT,

PRIMARY KEY PK_idLote (idLote),
FOREIGN KEY ForeignKey_idVeiculo (fkVeiculo) REFERENCES veiculo (idVeiculo)
);

CREATE TABLE sensor (
idSensor INT AUTO_INCREMENT,
modelo 
	VARCHAR(5),
	CHECK (modelo IN ('LM35', 'DHT11')),
dtInstalacao DATETIME,
fkVeiculo INT,

PRIMARY KEY PK_idSensor (idSensor),
FOREIGN KEY ForeignKey_idVeiculo (fkVeiculo) REFERENCES veiculo (idVeiculo)
);

CREATE TABLE leitura (
idLeitura INT AUTO_INCREMENT,
dtLeitura timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
temperatura DECIMAL(5, 2) DEFAULT NULL,
umidade DECIMAL(5, 2) DEFAULT NULL,
fkSensor INT,

PRIMARY KEY PK_idLeitura (idLeitura),
FOREIGN KEY ForeignKey_idSensor (fkSensor) REFERENCES sensor (idSensor)
);

-- Inserindo dados na tabela Empresa
INSERT INTO empresa (nome_fantasia, cnpj, cep, telefone, email, fkMatriz)
VALUES 
('Empresa A', '12345678901234', '12345-678', '(11) 1234-5678', 'empresaA@example.com', NULL),
('Empresa B', '56789012345678', '98765-432', '(22) 9876-5432', 'empresaB@example.com', NULL),
('Empresa C', '90123456789012', '54321-098', '(33) 5432-1098', 'empresaC@example.com', NULL),
('Empresa D', '34567890123456', '13579-246', '(44) 1357-9246', 'empresaD@example.com', NULL),
('Empresa E', '78901234567890', '98765-432', '(55) 9876-5432', 'empresaE@example.com', NULL),
('Empresa F', '23456789012345', '43210-987', '(66) 4321-0987', 'empresaF@example.com', NULL);

-- Inserindo na mesma tabela (por causa do auto-relacionamento), as filiais
-- e de que empresas elas são. LEMBRANDO: Teremos então 
-- 6 (de cima) + 4 (abaixo) = 10 Linhas de dados da tabela Empresa
INSERT INTO empresa (nome_fantasia, cnpj, cep, telefone, email, fkMatriz)
VALUES
('Filial G Empresa C', '23456999034345', '43210-007', '(77) 1321-0387', 'filialG@example.com', 3),
('Filial H Empresa A', '23456829034345', '43210-747', '(88) 1321-0387', 'filialH@example.com', 1),
('Filial I Empresa D', '23456289034345', '43210-127', '(99) 1321-0387', 'filialI@example.com', 4),
('Filial J Empresa F', '23456719034345', '43210-547', '(00) 1321-0387', 'filialJ@example.com', 6);

-- Inserts para a tabela Funcionario
INSERT INTO funcionario (nome, email, chaveAcesso, cpf, fkEmpresa) 
VALUES 
('Funcionario 1', 'funcionario1@example.com', 'chave123', '123456789-01', 1),
('Funcionario 2', 'funcionario2@example.com', 'chave456', '987654321-09', 1),
('Funcionario 3', 'funcionario3@example.com', 'chave789', '456123789-12', 2),
('Funcionario 4', 'funcionario4@example.com', 'chave987', '654321987-98', 3),
('Funcionario 5', 'funcionario5@example.com', 'chave654', '789456123-45', 5),
('Funcionario 6', 'funcionario6@example.com', 'chave321', '321654987-32', 6);

-- Inserts para a tabela Veiculo
INSERT INTO veiculo (carga, placa, fkEmpresa) 
VALUES 
(1000.50, 'ABC1234', 1),
(750.25, 'DEF5678', 1),
(500.75, 'GHI9012', 2),
(1200.30, 'JKL3456', 3),
(900.80, 'MNO7890', 4),
(600.60, 'PQR1234', 6);

-- Inserts para a tabela Lote
INSERT INTO lote (tipoCarne, quantidadeCarne, dataChegada, dataPartida, fkVeiculo) 
VALUES 
('bovina',100,'2024-10-10','2024-10-03', 1),
('suína', 150,'2024-09-10','2024-09-05', 2),
('carne de ave',200,'2024-09-18','2024-09-15', 3),
('bovina',120,'2024-09-13','2024-09-12',  4),
('suína', 180,'2024-09-26','2024-09-22', 5),
('carne de ave', 220,'2024-09-27','2024-09-24', 6);

-- Inserts para a tabela Sensor
INSERT INTO sensor (modelo, dtInstalacao, fkVeiculo) 
VALUES 
('LM35', '2024-04-01 10:00:00', 1),
('LM35', '2024-04-01 10:00:00', 2),
('DHT11', '2024-04-01 10:00:00', 3),
('DHT11', '2024-04-01 10:00:00', 4),
('LM35', '2024-04-01 10:00:00', 5),
('DHT11', '2024-04-01 10:00:00', 6);

-- Inserts para a tabela Leitura

INSERT INTO leitura (dtLeitura, umidade, temperatura, fkSensor)
VALUES 
('2024-04-05 10:00:00', 25.5, 4.2, 1),
('2024-04-05 10:00:00', 25.5, 4.2, 2),
('2024-04-05 10:00:00', 58.9, 4.2, 3),
('2024-04-05 10:00:00', 62.4, 2.5, 4),
('2024-04-05 10:00:00', 25.8, 3.2 ,5),
('2024-04-05 10:00:00', 64.2, 5.1 ,6);

-- ===========================================
-- SELECT com INNER JOIN de auto relacionamento da tabela Empresa:

SELECT Matriz.*, Filial.*
FROM Empresa AS Matriz
INNER JOIN Empresa AS Filial
ON Matriz.fkMatriz = Filial.idEmpresa;
-- ===========================================
-- SELECT com INNER JOIN das tabelas Empresa e Funcionario:
SELECT *
FROM Funcionario AS Func
INNER JOIN Empresa AS EMP
ON Func.fkEmpresa = EMP.idEmpresa;
-- ==============
-- TESTE:
SELECT *
FROM Funcionario AS Func
RIGHT JOIN Empresa AS EMP
ON EMP.idEmpresa = Func.fkEmpresa

RIGHT JOIN Empresa AS Filial
ON Filial.idEmpresa = EMP.fkMatriz;

SELECT
	EMP.idEmpresa AS 'ID Empresa', EMP.nome_fantasia AS 'Nome fantasia', EMP.CNPJ, EMP.CEP, EMP.Telefone, EMP.Email, EMP.fkMatriz AS 'FK Matriz',
    Filial.idEmpresa AS 'ID Empresa', Filial.nome_fantasia AS 'Nome fantasia', Filial.CNPJ, Filial.CEP, Filial.Telefone, Filial.Email, Filial.fkMatriz AS 'FK Matriz',
    Func.idFuncionario AS 'ID Funcionário', Func.Nome AS 'Nome funcionário', Func.Email, Func.chaveAcesso AS 'Chave de acesso', Func.CPF, Func.fkEmpresa AS 'FK Empresa'
FROM Empresa AS EMP
LEFT JOIN Empresa AS Filial
ON Filial.idEmpresa = EMP.fkMatriz

LEFT JOIN Funcionario AS Func
ON EMP.idEmpresa = Func.fkEmpresa;

-- ===========================================
-- SELECT com INNER JOIN das tabelas Empresa (matriz e filial) + Funcionario:

SELECT *
FROM Funcionario AS Func
LEFT JOIN Empresa AS Matriz
ON Func.fkEmpresa = Matriz.idEmpresa

LEFT JOIN Empresa AS Filial
ON Func.fkEmpresa = Filial.fkMatriz;
-- ===========================================
-- SELECT com INNER JOIN das tabelas Veiculo com Lote:

SELECT *
FROM Veiculo AS Veic
INNER JOIN Lote AS L
ON Veic.idVeiculo = L.fkVeiculo;
-- ===========================================
-- Select com INNER JOIN das tabelas Sensor e Leitura:

SELECT *
FROM Sensor AS S
INNER JOIN Leitura AS Leit
ON S.idSensor = Leit.fkSensor;
*/

/*
CREATE DATABASE codesensor2;
USE codesensor2;

CREATE TABLE empresa (
idEmpresa 		INT 			AUTO_INCREMENT,
nome_fantasia 	VARCHAR(45) 	not null,
cnpj 			CHAR(18) 		not null UNIQUE,
cep 			CHAR(9) 		not null UNIQUE,
telefone 		VARCHAR(15) 	not null,
email 			VARCHAR(345) 	not null UNIQUE,
fkMatriz 		INT, -- Essa FK é para sabermos qual filial é de qual empresa
			   -- Fazendo o AUTO-RELACIONAMENTO da tabela Empresa...

PRIMARY KEY PK_idEmpresa (idEmpresa), -- (dxa assim msm) Aqui deveria ter o fkMatriz junto, porém: 
									  -- "fkMatriz cannot be null", erro no insert into
FOREIGN KEY ForeignKey_fkEmpresa (fkMatriz) REFERENCES empresa (idEmpresa)
);

CREATE TABLE funcionario (
idFuncionario INT not null AUTO_INCREMENT,
nome VARCHAR(50) not null, 
email VARCHAR(345) not null UNIQUE,
cpf CHAR(12) not null UNIQUE,
tipo VARCHAR(11) not null default "funcionario",
chaveAcesso CHAR(10) not null UNIQUE,
fkEmpresa INT,

constraint chk_tipo CHECK(tipo IN ("superior", "funcionario")),
PRIMARY KEY PK_idFuncionario (idFuncionario, fkEmpresa),
FOREIGN KEY ForeignKey_fkEmpresa (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE veiculo (
placa char(7) not null,
rntrc char(8) not null UNIQUE, -- RNTRC (Registro Nacional de Transportadores Rodoviários de Cargas)
renavam char(11) not null UNIQUE,
fkEmpresa INT not null,

PRIMARY KEY PK_idVeiculo (placa),
FOREIGN KEY ForeignKey_idEmpresa (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE lote (
idLote INT not null AUTO_INCREMENT,
tipoCarne 
	VARCHAR(12) not null,
	CHECK (tipoCarne IN ('bovina', 'suína', 'carne de ave')),
carnesEmbaladas INT not null, -- carnesEmbaladas nos referimos as carnes embaladas que estão
							  -- no lote, e não quantas carnes por KG.
fkPlaca char(7) not null,

PRIMARY KEY PK_idLote (idLote),
FOREIGN KEY ForeignKey_idVeiculo (fkPlaca) REFERENCES veiculo (placa)
);

CREATE TABLE sensor (
idSensor INT not null AUTO_INCREMENT,
modelo 
	VARCHAR(5) not null,
	CHECK (modelo IN ('LM35', 'DHT11')),
dtPrimeiroUso DATETIME not null,
fkPlaca char(7) not null,

PRIMARY KEY PK_idSensor (idSensor),
FOREIGN KEY ForeignKey_idVeiculo (fkPlaca) REFERENCES veiculo (placa)
);

CREATE TABLE leitura (
idLeitura INT not null AUTO_INCREMENT,
dtLeitura timestamp not null DEFAULT CURRENT_TIMESTAMP,
temperatura DECIMAL(5, 2) DEFAULT NULL,
umidade DECIMAL(5, 2) DEFAULT NULL,
fkSensor INT not null,

PRIMARY KEY PK_idLeitura (idLeitura, fkSensor),
FOREIGN KEY ForeignKey_idSensor (fkSensor) REFERENCES sensor (idSensor)
);

-- Inserindo dados na tabela Empresa
INSERT INTO empresa (nome_fantasia, cnpj, cep, telefone, email, fkMatriz)
VALUES 
('Empresa A', '12345678901234', '12345-678', '(11) 1234-5678', 'empresaA@example.com', NULL),
('Empresa B', '56789012345678', '98765-432', '(22) 9876-5432', 'empresaB@example.com', NULL),
('Empresa C', '90123456789012', '54321-098', '(33) 5432-1098', 'empresaC@example.com', NULL),
('Empresa D', '34567890123456', '13579-246', '(44) 1357-9246', 'empresaD@example.com', NULL),
('Empresa E', '78901234567890', '92365-432', '(55) 9876-5432', 'empresaE@example.com', NULL),
('Empresa F', '23456789012345', '43210-987', '(66) 4321-0987', 'empresaF@example.com', NULL);

-- Inserindo na mesma tabela (por causa do auto-relacionamento), as filiais
-- e de que empresas elas são. LEMBRANDO: Teremos então 
-- 6 (de cima) + 4 (abaixo) = 10 Linhas de dados da tabela Empresa
INSERT INTO empresa (nome_fantasia, cnpj, cep, telefone, email, fkMatriz)
VALUES
('Filial G Empresa C', '23456999034345', '43210-007', '(77) 1321-0387', 'filialG@example.com', 3),
('Filial H Empresa A', '23456829034345', '43210-747', '(88) 1321-0387', 'filialH@example.com', 1),
('Filial I Empresa D', '23456289034345', '43210-127', '(99) 1321-0387', 'filialI@example.com', 4),
('Filial J Empresa F', '23456719034345', '43210-547', '(00) 1321-0387', 'filialJ@example.com', 6);

-- Inserts para a tabela Funcionario
INSERT INTO funcionario (nome, email, cpf, tipo, chaveAcesso, fkEmpresa) 
VALUES 
('Funcionario 1', 'funcionario1@example.com', '123456789-01', 'superior', 'chave123', 1),
('Funcionario 2', 'funcionario2@example.com', '987654321-09', 'funcionario', 'chave456', 1),
('Funcionario 3', 'funcionario3@example.com', '456123789-12', 'funcionario', 'chave789', 2),
('Funcionario 4', 'funcionario4@example.com', '654321987-98', 'superior', 'chave987', 3),
('Funcionario 5', 'funcionario5@example.com', '789456123-45', 'funcionario', 'chave654', 5),
('Funcionario 6', 'funcionario6@example.com', '321654987-32', 'funcionario', 'chave321', 6);

-- Inserts para a tabela Veiculo
INSERT INTO veiculo (placa, rntrc, renavam, fkEmpresa)
VALUES
  ('ABCD234', '12345678', '98765432101', 1),
  ('DEFD678', '87654321', '12345678901', 1),
  ('GHID012', '23456789', '23456789012', 2),
  ('JKLD456', '34567890', '34567890123', 3),
  ('MNOD890', '45678901', '45678901234', 4),
  ('PQRD345', '56789012', '56789012345', 6);

-- Inserts para a tabela Lote
INSERT INTO lote (tipoCarne, carnesEmbaladas, fkPlaca) 
VALUES 
('bovina', 100, 'ABCD234'),
('suína', 150, 'DEFD678'),
('carne de ave', 200, 'GHID012'),
('bovina', 120, 'JKLD456'),
('suína', 180, 'MNOD890'),
('carne de ave', 220, 'PQRD345');

-- Inserts para a tabela Sensor
INSERT INTO sensor (modelo, dtPrimeiroUso, fkPlaca) 
VALUES 
('LM35', '2024-04-01 10:00:00', 'ABCD234'),
('LM35', '2024-04-01 10:01:00', 'DEFD678'),
('DHT11', '2024-04-01 10:02:00', 'GHID012'),
('DHT11', '2024-04-01 10:03:00', 'JKLD456'),
('LM35', '2024-04-01 10:04:00', 'MNOD890'),
('DHT11', '2024-04-01 10:05:00', 'PQRD345');

-- Inserts para a tabela Leitura

INSERT INTO leitura (dtLeitura, temperatura, umidade, fkSensor)
VALUES 
('2024-04-05 10:00:00', 4.2, 25.5, 1),
('2024-04-05 10:00:00', 4.2, 25.5, 2),
('2024-04-05 10:00:00', 4.2, 58.9, 3),
('2024-04-05 10:00:00', 2.5, 62.4, 4),
('2024-04-05 10:00:00', 3.2, 25.8, 5),
('2024-04-05 10:00:00', 5.1, 64.2, 6);

-- ===========================================
-- SELECT com INNER JOIN de auto relacionamento da tabela Empresa:

SELECT Matriz.*, Filial.*
FROM Empresa AS Matriz
INNER JOIN Empresa AS Filial
ON Matriz.fkMatriz = Filial.idEmpresa;
-- ===========================================
-- SELECT com INNER JOIN das tabelas Empresa e Funcionario:
SELECT *
FROM Funcionario AS Func
INNER JOIN Empresa AS EMP
ON Func.fkEmpresa = EMP.idEmpresa;
-- ==============
-- TESTE:
SELECT *
FROM Funcionario AS Func
RIGHT JOIN Empresa AS EMP
ON EMP.idEmpresa = Func.fkEmpresa

RIGHT JOIN Empresa AS Filial
ON Filial.idEmpresa = EMP.fkMatriz;

SELECT
	EMP.idEmpresa AS 'ID Empresa', EMP.nome_fantasia AS 'Nome fantasia', EMP.CNPJ, EMP.CEP, EMP.Telefone, EMP.Email, EMP.fkMatriz AS 'FK Matriz',
    Filial.idEmpresa AS 'ID Empresa', Filial.nome_fantasia AS 'Nome fantasia', Filial.CNPJ, Filial.CEP, Filial.Telefone, Filial.Email, Filial.fkMatriz AS 'FK Matriz',
    Func.idFuncionario AS 'ID Funcionário', Func.Nome AS 'Nome funcionário', Func.Email, Func.chaveAcesso AS 'Chave de acesso', Func.CPF, Func.fkEmpresa AS 'FK Empresa'
FROM Empresa AS EMP
LEFT JOIN Empresa AS Filial
ON Filial.idEmpresa = EMP.fkMatriz

LEFT JOIN Funcionario AS Func
ON EMP.idEmpresa = Func.fkEmpresa;

-- ===========================================
-- SELECT com INNER JOIN das tabelas Empresa (matriz e filial) + Funcionario:

SELECT *
FROM Funcionario AS Func
LEFT JOIN Empresa AS Matriz
ON Func.fkEmpresa = Matriz.idEmpresa

LEFT JOIN Empresa AS Filial
ON Func.fkEmpresa = Filial.fkMatriz;
-- ===========================================
-- SELECT com INNER JOIN das tabelas Veiculo com Lote:

SELECT *
FROM Veiculo AS Veic
INNER JOIN Lote AS L
ON Veic.placa = L.fkPlaca;
-- ===========================================
-- Select com INNER JOIN das tabelas Sensor e Leitura:

SELECT *
FROM Sensor AS S
INNER JOIN Leitura AS Leit
ON S.idSensor = Leit.fkSensor;
*/

CREATE DATABASE IF NOT EXISTS codesensor2;
USE codesensor2;

CREATE TABLE empresa (
idEmpresa 		INT 			AUTO_INCREMENT COMMENT 'Identificador único da empresa', 
nome_fantasia 	VARCHAR(45) 	NOT NULL COMMENT 'Nome fantasia da empresa',
email 			VARCHAR(345) 	NOT NULL UNIQUE COMMENT 'Email da empresa, deve ser único',
telefone 		VARCHAR(15) 	NOT NULL COMMENT 'Telefone de contato da empresa',
cnpj 			CHAR(18) 		NOT NULL UNIQUE COMMENT 'CNPJ da empresa, deve ser único',
cep 			CHAR(9) 		NOT NULL UNIQUE COMMENT 'CEP da empresa, deve ser único',
senha			VARCHAR(16) 	NOT NULL COMMENT 'Senha da empresa, com limite de 16 caracteres',
fkMatriz 		INT COMMENT 'Chave estrangeira que referencia a empresa matriz, para auto-relacionamento',

PRIMARY KEY PK_idEmpresa (idEmpresa),
FOREIGN KEY ForeignKey_fkEmpresa (fkMatriz) REFERENCES empresa (idEmpresa)
) COMMENT 'Tabela que armazena informações de Empresas';

CREATE TABLE funcionario (
idFuncionario INT 	NOT NULL AUTO_INCREMENT COMMENT 'Identificador único do funcionário',
nome VARCHAR(50) 	NOT NULL COMMENT 'Nome do funcionário', 
email VARCHAR(345) 	NOT NULL UNIQUE COMMENT 'Email do funcionário, deve ser único',
cpf CHAR(12) 		NOT NULL UNIQUE COMMENT 'CPF do funcionário, deve ser único',
tipo VARCHAR(11) 	NOT NULL DEFAULT "funcionario" COMMENT 'Tipo de funcionário (superior ou funcionario), para permissionamentos',
senha VARCHAR(16) 	NOT NULL COMMENT 'Senha do funcionário, com limite de 16 caracteres',
fkEmpresa INT COMMENT 'Chave estrangeira que referencia a empresa à qual o funcionário pertence',

CONSTRAINT chk_tipo CHECK(tipo IN ("superior", "funcionario")),
PRIMARY KEY PK_idFuncionario (idFuncionario, fkEmpresa),
FOREIGN KEY ForeignKey_fkEmpresa (fkEmpresa) REFERENCES empresa (idEmpresa)
) COMMENT 'Tabela que armazena informações de Funcionários';

CREATE TABLE veiculo (
placa CHAR(7) NOT NULL COMMENT 'Identificador único da placa do veículo',
rntrc CHAR(8) NOT NULL UNIQUE COMMENT 'Número de Registro Nacional de Transportadores Rodoviários de Cargas (RNTRC), Único para cada veículo',
renavam CHAR(11) NOT NULL UNIQUE COMMENT 'Número de Registro Nacional de Veículos Automotores (RENAVAM). Único para cada veículo',
fkEmpresa INT NOT NULL COMMENT 'Chave estrangeira para a tabela `empresa` (ID da empresa proprietária do veículo)',

PRIMARY KEY PK_idVeiculo (placa),
FOREIGN KEY ForeignKey_idEmpresa (fkEmpresa) REFERENCES empresa (idEmpresa)
) COMMENT 'Tabela que armazena informações de Veículos';

CREATE TABLE lote (
idLote INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único do lote',
tipoCarne 
	VARCHAR(12) NOT NULL COMMENT 'Tipo de carne do lote',
	CHECK (tipoCarne IN ('bovina', 'suína', 'carne de ave')),
pesoKg FLOAT NOT NULL COMMENT 'Peso total do lote em quilogramas', 
fkPlaca CHAR(7) NOT NULL COMMENT 'Chave estrangeira que referencia a placa do veículo associado ao lote',

PRIMARY KEY PK_idLote (idLote),
FOREIGN KEY ForeignKey_idVeiculo (fkPlaca) REFERENCES veiculo (placa)
) COMMENT 'Tabela que armazena informações de Lotes';

CREATE TABLE sensor (
idSensor INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único do sensor',
modelo
	VARCHAR(5) NOT NULL COMMENT 'Modelo do sensor',
	CHECK (modelo IN ('LM35', 'DHT11')),
dtPrimeiroUso DATETIME NOT NULL COMMENT 'Data e hora do primeiro uso do sensor',
fkPlaca CHAR(7) NOT NULL COMMENT 'Chave estrangeira que referencia a placa do veículo associada ao sensor',

PRIMARY KEY PK_idSensor (idSensor),
FOREIGN KEY ForeignKey_idVeiculo (fkPlaca) REFERENCES veiculo (placa)
) COMMENT 'Tabela que armazena informações de Sensores';

CREATE TABLE leitura (
idLeitura INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único da leitura',
dtLeitura TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data e hora da leitura',
temperatura DECIMAL(5, 2) DEFAULT NULL COMMENT 'Temperatura registrada na leitura',
umidade DECIMAL(5, 2) DEFAULT NULL COMMENT 'Umidade registrada na leitura',
fkSensor INT COMMENT 'Chave estrangeira que referencia o sensor associado à leitura',

PRIMARY KEY PK_idLeitura (idLeitura),
FOREIGN KEY ForeignKey_idSensor (fkSensor) REFERENCES sensor (idSensor)
) COMMENT 'Tabela que armazena informações de Leituras';

-- Inserindo dados na tabela Empresa
INSERT INTO empresa (nome_fantasia, email, telefone, cnpj, cep, senha, fkMatriz)
VALUES
('Empresa A', 'empresaA@example.com', '(11) 1234-5678', '012345678912343678', '12345-678', '2211203##@cC', NULL),
('Empresa B', 'empresaB@example.com', '(22) 9876-5432', '012345678912344672', '98765-432', '2299133##@Aa', NULL),
('Empresa C', 'empresaC@example.com', '(33) 5432-1098', '012345678912347671', '54321-098', '2213133##@Ba', NULL),
('Empresa D', 'empresaD@example.com', '(44) 1357-9246', '012345617912345670', '13579-246', '4713133##@Aa', NULL),
('Empresa E', 'empresaE@example.com', '(55) 9876-5432', '045345678912345674', '92365-432', '2217633##@Aa', NULL),
('Empresa F', 'empresaF@example.com', '(66) 4321-0987', '012385678912345676', '43210-987', '2213133##@Aa', NULL);

INSERT INTO empresa (nome_fantasia, email, telefone, cnpj, cep, senha, fkMatriz)
VALUES
('Filial G Empresa C', 'filialG@example.com', '(77) 1321-0387', '012345678912345678', '12045-678', '221120G##@cC', 3),
('Filial H Empresa A', 'filialH@example.com', '(88) 1321-0387', '012345678922345677', '98065-432', '229913H##@Aa', 1),
('Filial I Empresa D', 'filialI@example.com', '(99) 1321-0387', '012345678932345676', '54221-098', '221313I##@Dd', 4),
('Filial J Empresa F', 'filialJ@example.com', '(00) 1321-0387', '012345678942345675', '13679-246', '471313J##@Ff', 6);

-- Inserts para a tabela Funcionario
INSERT INTO funcionario (nome, email, cpf, tipo, senha, fkEmpresa) 
VALUES 
('Funcionario 1', 'funcionario1@example.com', '123456789-01', 'superior', 'senha123', 1),
('Funcionario 2', 'funcionario2@example.com', '987654321-09', 'funcionario', 'senha456', 1),
('Funcionario 3', 'funcionario3@example.com', '456123789-12', 'funcionario', 'senha789', 2),
('Funcionario 4', 'funcionario4@example.com', '654321987-98', 'superior', 'senha987', 3),
('Funcionario 5', 'funcionario5@example.com', '789456123-45', 'funcionario', 'senha654', 5),
('Funcionario 6', 'funcionario6@example.com', '321654987-32', 'funcionario', 'senha321', 6);

-- Inserts para a tabela Veiculo
INSERT INTO veiculo (placa, rntrc, renavam, fkEmpresa)
VALUES
  ('ABCD234', '12345678', '98765432101', 1),
  ('DEFD678', '87654321', '12345678901', 1),
  ('GHID012', '23456789', '23456789012', 2),
  ('JKLD456', '34567890', '34567890123', 3),
  ('MNOD890', '45678901', '45678901234', 4),
  ('PQRD345', '56789012', '56789012345', 6);

-- Inserts para a tabela Lote
INSERT INTO lote (tipoCarne, pesoKg, fkPlaca) 
VALUES 
('bovina', 100, 'ABCD234'),
('suína', 150, 'DEFD678'),
('carne de ave', 200, 'GHID012'),
('bovina', 120, 'JKLD456'),
('suína', 180, 'MNOD890'),
('carne de ave', 220, 'PQRD345');

-- Inserts para a tabela Sensor
INSERT INTO sensor (modelo, dtPrimeiroUso, fkPlaca) 
VALUES 
('LM35', '2024-04-01 10:00:00', 'ABCD234'),
('LM35', '2024-04-01 10:01:00', 'DEFD678'),
('DHT11', '2024-04-01 10:02:00', 'GHID012'),
('DHT11', '2024-04-01 10:03:00', 'JKLD456'),
('LM35', '2024-04-01 10:04:00', 'MNOD890'),
('DHT11', '2024-04-01 10:05:00', 'PQRD345');

-- Inserts para a tabela Leitura

INSERT INTO leitura (dtLeitura, temperatura, umidade, fkSensor)
VALUES 
('2024-04-05 10:00:00', 4.2, 25.5, 1),
('2024-04-05 10:00:00', 4.2, 25.5, 2),
('2024-04-05 10:00:00', 4.2, 58.9, 3),
('2024-04-05 10:00:00', 2.5, 62.4, 4),
('2024-04-05 10:00:00', 3.2, 25.8, 5),
('2024-04-05 10:00:00', 5.1, 64.2, 6);

-- ===========================================
-- SELECT com INNER JOIN de auto relacionamento da tabela Empresa:

SELECT Matriz.*, Filial.*
FROM Empresa AS Matriz
INNER JOIN Empresa AS Filial
ON Matriz.fkMatriz = Filial.idEmpresa;
-- ===========================================
-- SELECT com INNER JOIN das tabelas Empresa e Funcionario:
SELECT *
FROM Funcionario AS Func
INNER JOIN Empresa AS EMP
ON Func.fkEmpresa = EMP.idEmpresa;
-- ==============

SELECT
	EMP.idEmpresa AS 'ID Empresa', EMP.nome_fantasia AS 'Nome fantasia', EMP.CNPJ, EMP.CEP, EMP.Telefone, EMP.Email, EMP.fkMatriz AS 'FK Matriz',
    Filial.idEmpresa AS 'ID Empresa', Filial.nome_fantasia AS 'Nome fantasia', Filial.CNPJ, Filial.CEP, Filial.Telefone, Filial.Email, Filial.fkMatriz AS 'FK Matriz',
    Func.idFuncionario AS 'ID Funcionário', Func.Nome AS 'Nome funcionário', Func.Email, Func.senha AS 'Senha', Func.CPF, Func.fkEmpresa AS 'FK Empresa'
FROM Empresa AS EMP
LEFT JOIN Empresa AS Filial
ON Filial.idEmpresa = EMP.fkMatriz

LEFT JOIN Funcionario AS Func
ON EMP.idEmpresa = Func.fkEmpresa;

-- ===========================================
-- SELECT com INNER JOIN das tabelas Empresa (matriz e filial) + Funcionario:

SELECT *
FROM Funcionario AS Func
LEFT JOIN Empresa AS Matriz
ON Func.fkEmpresa = Matriz.idEmpresa

LEFT JOIN Empresa AS Filial
ON Func.fkEmpresa = Filial.fkMatriz;
-- ===========================================
-- SELECT com INNER JOIN das tabelas Veiculo com Lote:

SELECT *
FROM Veiculo AS Veic
INNER JOIN Lote AS L
ON Veic.placa = L.fkPlaca;
-- ===========================================
-- Select com INNER JOIN das tabelas Sensor e Leitura:

SELECT *
FROM Sensor AS S
INNER JOIN Leitura AS Leit
ON S.idSensor = Leit.fkSensor;


select tabela.table_name, table_comment
from information_schema.tables as tabela
where tabela.table_schema = 'codesensor2';

select column_name, column_comment
from information_schema.columns 
where table_schema = 'codesensor2' and column_comment != '';

select tabela.table_name, table_comment, column_name, column_comment
from information_schema.tables as tabela
inner join information_schema.columns as coluna
on tabela.table_name = coluna.table_name
where tabela.table_schema = 'codesensor2' and column_comment != '';