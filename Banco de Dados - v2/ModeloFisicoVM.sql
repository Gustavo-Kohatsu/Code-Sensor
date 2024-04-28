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