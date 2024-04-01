CREATE DATABASE CodeSensor2;
USE CodeSensor2;

CREATE TABLE Empresa (
idEmpresa INT AUTO_INCREMENT,
nome_fantasia VARCHAR(45) UNIQUE,
CNPJ CHAR(16) UNIQUE,
CEP CHAR(9),
Telefone VARCHAR(20) UNIQUE,
Email VARCHAR(50)UNIQUE,
inscricaoEstadual CHAR(15) UNIQUE,

PRIMARY KEY PK_idEmpresa (idEmpresa)
);

CREATE TABLE Filial (
idFilial INT AUTO_INCREMENT,
CNPJ CHAR(16) UNIQUE,
CEP CHAR(9),
Telefone VARCHAR(20) UNIQUE,
Email VARCHAR(50) UNIQUE,
Responsavel VARCHAR(50),
statusFilial 
	VARCHAR(20), 
	CHECK (statusFilial IN ('Ativo', 'Inativo')),
FK_idEmpresa INT,

PRIMARY KEY PK_idFilial (idFilial),
FOREIGN KEY ForeignKey_idEmpresa (FK_idEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Funcionario (
idFuncionario INT AUTO_INCREMENT,
Nome VARCHAR(50), 
Email VARCHAR(80) UNIQUE,
chaveAcesso VARCHAR(45) UNIQUE,
CPF VARCHAR(11) UNIQUE,
FK_idEmpresa INT,
FK_idFilial INT,

PRIMARY KEY PK_idFuncionario (idFuncionario),
FOREIGN KEY ForeignKey_idEmpresa (FK_idEmpresa) REFERENCES Empresa (idEmpresa),
FOREIGN KEY ForeignKey_idFilial (FK_idFilial) REFERENCES Filial (idFilial)
);

CREATE TABLE Veiculo (
idVeiculo INT AUTO_INCREMENT,
cargaMaxima INT,
Placa CHAR(7) UNIQUE, -- 4 letras + 3 numeros
FK_idEmpresa INT,

PRIMARY KEY PK_idVeiculo (idVeiculo),
FOREIGN KEY ForeignKey_idEmpresa (FK_idEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Lote (
idLote INT AUTO_INCREMENT,
tipoCarne 
	VARCHAR(45),
	CHECK (tipoCarne IN ('Bovina', 'Suína', 'Carne de ave')),
quantidadeCarne INT,
FK_idVeiculo INT,

PRIMARY KEY PK_idLote (idLote),
FOREIGN KEY ForeignKey_idVeiculo (FK_idVeiculo) REFERENCES Veiculo (idVeiculo)
);

CREATE TABLE Sensor (
idSensor INT AUTO_INCREMENT,
Modelo 
	VARCHAR(45),
	CHECK (Modelo IN ('LM35', 'DHT11')),
Tipo
	VARCHAR(45),
	CHECK (Tipo IN ('Temperatura', 'Umidade')),
dtInstalacao DATE,
FK_idVeiculo INT,

PRIMARY KEY PK_idSensor (idSensor),
FOREIGN KEY ForeignKey_idVeiculo(FK_idVeiculo) REFERENCES Veiculo (idVeiculo)
);

CREATE TABLE Leitura (
idLeitura INT AUTO_INCREMENT,
dtLeitura DATETIME,
temperatura FLOAT,
umidade FLOAT,
FK_idSensor INT,

PRIMARY KEY PK_idLeitura (idLeitura),
FOREIGN KEY ForeignKey_idSensor (FK_idSensor) REFERENCES Sensor (idSensor)
);

-- Inserindo dados na tabela Empresa
INSERT INTO Empresa (nome_fantasia, CNPJ, CEP, Telefone, Email, inscricaoEstadual)
VALUES 
('Empresa A', '12345678901234', '12345-678', '(11) 1234-5678', 'empresaA@example.com', '123456789012345'),
('Empresa B', '56789012345678', '98765-432', '(22) 9876-5432', 'empresaB@example.com', '567890123456789'),
('Empresa C', '90123456789012', '54321-098', '(33) 5432-1098', 'empresaC@example.com', '901234567890123'),
('Empresa D', '34567890123456', '13579-246', '(44) 1357-9246', 'empresaD@example.com', '345678901234567'),
('Empresa E', '78901234567890', '98765-432', '(55) 9876-5432', 'empresaE@example.com', '789012345678901'),
('Empresa F', '23456789012345', '43210-987', '(66) 4321-0987', 'empresaF@example.com', '234567890123456');

-- Inserindo dados na tabela Filial
INSERT INTO Filial (CNPJ, CEP, Telefone, Email, Responsavel, statusFilial, FK_idEmpresa)
VALUES 
('12345678901234', '54321-098', '(22) 9876-5432', 'filial1@example.com', 'Responsável 1', 'Ativo', 1),
('90123456789012', '87654-321', '(33) 2109-8765', 'filial2@example.com', 'Responsável 2', 'Inativo', 3),
('56789012345678', '21098-765', '(44) 7654-0987', 'filial3@example.com', 'Responsável 3', 'Ativo', 2),
('34567890123456', '67890-123', '(77) 6789-0123', 'filial4@example.com', 'Responsável 4', 'Inativo', 4),
('54321098765432', '78901-234', '(88) 7890-1234', 'filial5@example.com', 'Responsável 5', 'Ativo', 1),
('78901234567890', '89012-345', '(99) 8901-2345', 'filial6@example.com', 'Responsável 6', 'Ativo', 5);

-- Inserindo dados na tabela Funcionario
INSERT INTO Funcionario (Nome, Email, chaveAcesso, CPF, FK_idEmpresa, FK_idFilial)
VALUES 
('João Silva', 'joao@example.com', 'chave123', '12345678901', 6, 5),
('Maria Souza', 'maria@example.com', 'chave456', '23456789012', 5, 1),
('Carlos Santos', 'carlos@example.com', 'chave789', '34567890123', 4, 4),
('Ana Oliveira', 'ana@example.com', 'chave101', '45678901234', 3, 2),
('Pedro Rodrigues', 'pedro@example.com', 'chave202', '56789012345', 2, 3),
('Mariana Silva', 'mariana@example.com', 'chave303', '67890123456', 1, 1);

-- Inserindo dados na tabela Veiculo
INSERT INTO Veiculo (cargaMaxima, Placa, FK_idEmpresa)
VALUES 
(1000, 'ABC1234', 1),
(1500, 'DEF5678', 2),
(2000, 'GHI9012', 3),
(1200, 'JKL5678', 2),
(1800, 'MNO9012', 3),
(2200, 'PQR3456', 1);

-- Inserindo dados na tabela Lote
INSERT INTO Lote (tipoCarne, quantidadeCarne, FK_idVeiculo)
VALUES 
('Bovina', 300, 1),
('Suína', 200, 2),
('Carne de ave', 300 , 3),
('Carne de ave', 500, 4),
('Suína', 150, 5),
('Bovina', 700, 6);

-- Inserindo dados na tabela Sensor
INSERT INTO Sensor (Modelo, Tipo, dtInstalacao, FK_idVeiculo)
VALUES 
('DHT11', 'Umidade', '2024-03-30', 1),
('LM35', 'Temperatura', '2024-03-30', 2),
('DHT11', 'Umidade', '2024-03-30', 3),
('LM35', 'Temperatura', '2024-03-30', 4),
('LM35', 'Temperatura', '2024-03-30', 5),
('DHT11', 'Umidade', '2024-03-30', 6);

-- Inserindo dados na tabela Leitura
INSERT INTO Leitura (dtLeitura, temperatura, umidade, FK_idSensor)
VALUES 
('2024-03-30 08:00:00', 5.0, 70.0, 1),
('2024-03-30 09:00:00', 3.0, 65.0, 2),
('2024-03-30 10:00:00', 2.5, 68.0, 3),
('2024-03-30 11:00:00', 2.0, 60.0, 4),
('2024-03-30 12:00:00', 4.0, 68.0, 5),
('2024-03-30 13:00:00', 3.5, 70.0, 6);

-- ===========================================
-- SELECT de todas as tabelas INDIVIDUALMENTE:
SELECT * FROM Empresa;
SELECT * FROM Filial;
SELECT * FROM Funcionario;
SELECT * FROM Veiculo;
SELECT * FROM Lote;
SELECT * FROM Sensor;
SELECT * FROM Leitura;

-- ===========================================
-- SELECT JOIN das tabelas Filial + Empresa:
SELECT Fil.*, '---' AS Separador, EMP.*
FROM Empresa AS EMP
INNER JOIN Filial AS Fil
ON EMP.idEmpresa = Fil.FK_idEmpresa;

-- ===========================================
-- SELECT JOIN das tabelas Funcionário + Filial + Empresa:
SELECT 
    Func.idFuncionario,
    Func.Nome,
    Fil.idFilial,
    Fil.Responsavel,
    EMP.idEmpresa,
    EMP.nome_fantasia
FROM Funcionario AS Func
INNER JOIN Filial AS Fil 
ON Func.FK_idFilial = Fil.idFilial

INNER JOIN Empresa AS EMP 
ON Func.FK_idEmpresa = EMP.idEmpresa;

-- ===========================================
-- SELECT JOIN das tabelas Veiculo + Empresa:
SELECT 
	Veic.idVeiculo,
    EMP.nome_fantasia
FROM Veiculo AS Veic
INNER JOIN Empresa AS EMP
ON Veic.FK_idEmpresa = EMP.idEmpresa;

-- ===========================================
-- SELECT JOIN das tabelas Veiculo + Empresa + Lote:
SELECT
	Veic.idVeiculo,
    Veic.Placa,
    Veic.FK_idEmpresa,
    EMP.idEmpresa,
    EMP.nome_fantasia,
    Lote.idLote,
    Lote.tipoCarne,
    Lote.quantidadeCarne,
    Lote.FK_idVeiculo
FROM Veiculo AS Veic
INNER JOIN Empresa AS EMP
ON EMP.idEmpresa = Veic.FK_idEmpresa

INNER JOIN Lote
ON Veic.idVeiculo = Lote.FK_idVeiculo
WHERE EMP.idEmpresa = 1;

-- ===========================================
-- SELECT JOIN das tabelas Veiculo + Sensor:
SELECT 
	Veic.idVeiculo,
    Veic.Placa,
    Sensor.idSensor,
    Sensor.Modelo,
    Sensor.Tipo,
    Sensor.FK_idVeiculo
FROM Veiculo AS Veic
INNER JOIN Sensor
ON Veic.idVeiculo = Sensor.FK_idVeiculo;
-- ===========================================
-- SELECT JOIN de todas as tabelas:

SELECT
-- Colunas da tabela Funcionário:
	Func.idFuncionario, Func.Nome, Func.Email, Func.chaveAcesso, Func.CPF,
    Func.FK_idEmpresa,
-- Colunas da tabela Empresa:
	EMP.idEmpresa, EMP.nome_fantasia AS 'Nome Fantasia',
    EMP.CNPJ, EMP.CEP, EMP.Email, EMP.inscricaoEstadual AS 'Inscrição Estadual',
-- Coluna FK_idFilial da tabela Funcionário:
	Func.FK_idFilial,
-- Colunas da tabela Filial:
	Fil.idFilial, Fil.CNPJ, Fil.CEP, Fil.Email, Fil.Responsavel, Fil.statusFilial,
    Fil.FK_idEmpresa,
-- Colunas da tabela Veiculo:
	Veic.idVeiculo, Veic.Placa, Veic.FK_idEmpresa,
-- Colunas da tabela Lote:
	Lote.idLote, Lote.tipoCarne, Lote.quantidadeCarne,
-- Colunas da tabela Leitura:
	Leit.idLeitura, Leit.dtLeitura, Leit.temperatura, Leit.umidade, 
    Leit.FK_idSensor,
-- Colunas da tabela Sensor:
	Sensor.idSensor, Sensor.Modelo, Sensor.Tipo, Sensor.dtInstalacao,
    Sensor.FK_idVeiculo
FROM Empresa AS EMP
INNER JOIN Funcionario AS Func
ON EMP.idEmpresa = Func.FK_idEmpresa

INNER JOIN Filial AS Fil
ON Fil.idFilial = Func.FK_idFilial

INNER JOIN Veiculo AS Veic
ON EMP.idEmpresa = Veic.FK_idEmpresa

INNER JOIN Lote
ON Veic.idVeiculo = Lote.FK_idVeiculo

INNER JOIN Sensor
ON Veic.idVeiculo = Sensor.FK_idVeiculo

INNER JOIN Leitura AS Leit
ON Sensor.idSensor = Leit.FK_idSensor;

 