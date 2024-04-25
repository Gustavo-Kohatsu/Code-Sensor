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