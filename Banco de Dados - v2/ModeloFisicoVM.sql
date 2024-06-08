CREATE DATABASE IF NOT EXISTS codesensor2;
USE codesensor2;

CREATE TABLE empresa (
idEmpresa 		INT 			AUTO_INCREMENT COMMENT 'Identificador único da empresa', 
nome_fantasia 	VARCHAR(45) 	NOT NULL COMMENT 'Nome fantasia da empresa',
email 			VARCHAR(345) 	NOT NULL UNIQUE COMMENT 'Email da empresa, deve ser único',
telefone 		VARCHAR(15) 	NOT NULL COMMENT 'Telefone de contato da empresa',
cnpj 			CHAR(18) 		NOT NULL UNIQUE COMMENT 'CNPJ da empresa, deve ser único',
cep 			CHAR(9) 		NOT NULL UNIQUE COMMENT 'CEP da empresa, deve ser único',
-- senha			VARCHAR(16) 	NOT NULL COMMENT 'Senha da empresa, com limite de 16 caracteres',
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
INSERT INTO empresa (nome_fantasia,
 email, telefone,
 cnpj,
 cep,
 -- senha,
 fkMatriz)
VALUES
('Empresa A', 'empresaA@example.com', '(11) 1234-5678', '012345678912343678', '12345-678',
 -- '2211203##@cC',
 NULL),
('Empresa B', 'empresaB@example.com', '(22) 9876-5432', '012345678912344672', '98765-432',
 -- '2299133##@Aa',
 NULL),
('Empresa C', 'empresaC@example.com', '(33) 5432-1098', '012345678912347671', '54321-098',
 -- '2213133##@Ba',
 NULL),
('Empresa D', 'empresaD@example.com', '(44) 1357-9246', '012345617912345670', '13579-246',
 -- '4713133##@Aa',
 NULL),
('Empresa E', 'empresaE@example.com', '(55) 9876-5432', '045345678912345674', '92365-432',
 -- '2217633##@Aa',
 NULL),
('Empresa F', 'empresaF@example.com', '(66) 4321-0987', '012385678912345676', '43210-987',
--  '2213133##@Aa',
 NULL);

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