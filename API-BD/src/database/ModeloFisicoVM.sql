DROP DATABASE IF EXISTS codesensor2;
CREATE DATABASE IF NOT EXISTS codesensor2;
USE codesensor2;

CREATE TABLE IF NOT EXISTS empresa (
idEmpresa 		INT 			AUTO_INCREMENT COMMENT 'Identificador único da empresa', 
nome_fantasia 	VARCHAR(45) 	NOT NULL COMMENT 'Nome fantasia da empresa',
email 			VARCHAR(345) 	NOT NULL UNIQUE COMMENT 'Email da empresa, deve ser único',
telefone 		VARCHAR(15) 	NOT NULL COMMENT 'Telefone de contato da empresa',
cnpj 			CHAR(18) 		NOT NULL UNIQUE COMMENT 'CNPJ da empresa, deve ser único',
cep 			CHAR(9) 		NOT NULL COMMENT 'CEP da empresa',
fkMatriz 		INT COMMENT 'Chave estrangeira que referencia a empresa matriz, para auto-relacionamento',

PRIMARY KEY PK_idEmpresa (idEmpresa),
FOREIGN KEY ForeignKey_fkEmpresa (fkMatriz) REFERENCES empresa (idEmpresa)
) COMMENT 'Tabela que armazena informações de Empresas';

CREATE TABLE IF NOT EXISTS funcionario (
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

CREATE TABLE IF NOT EXISTS veiculo (
placa CHAR(7) NOT NULL COMMENT 'Identificador único da placa do veículo',
rntrc CHAR(8) NOT NULL UNIQUE COMMENT 'Número de Registro Nacional de Transportadores Rodoviários de Cargas (RNTRC), Único para cada veículo',
renavam CHAR(11) NOT NULL UNIQUE COMMENT 'Número de Registro Nacional de Veículos Automotores (RENAVAM). Único para cada veículo',
fkEmpresa INT NOT NULL COMMENT 'Chave estrangeira para a tabela `empresa` (ID da empresa proprietária do veículo)',

PRIMARY KEY PK_idVeiculo (placa),
FOREIGN KEY ForeignKey_idEmpresa (fkEmpresa) REFERENCES empresa (idEmpresa)
) COMMENT 'Tabela que armazena informações de Veículos';

CREATE TABLE IF NOT EXISTS lote (
idLote INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único do lote',
tipoCarne 
	VARCHAR(12) NOT NULL COMMENT 'Tipo de carne do lote',
	CHECK (tipoCarne IN ('bovina', 'suína', 'carne de ave')),
pesoKg FLOAT NOT NULL COMMENT 'Peso total do lote em quilogramas', 
fkPlaca CHAR(7) NOT NULL COMMENT 'Chave estrangeira que referencia a placa do veículo associado ao lote',

PRIMARY KEY PK_idLote (idLote),
FOREIGN KEY ForeignKey_idVeiculo (fkPlaca) REFERENCES veiculo (placa)
) COMMENT 'Tabela que armazena informações de Lotes';

CREATE TABLE IF NOT EXISTS sensor (
idSensor INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único do sensor',
modelo
	VARCHAR(5) NOT NULL COMMENT 'Modelo do sensor',
	CHECK (modelo IN ('LM35', 'DHT11')),
dtPrimeiroUso DATETIME NOT NULL COMMENT 'Data e hora do primeiro uso do sensor',
fkPlaca CHAR(7) NOT NULL COMMENT 'Chave estrangeira que referencia a placa do veículo associada ao sensor',

PRIMARY KEY PK_idSensor (idSensor),
FOREIGN KEY ForeignKey_idVeiculo (fkPlaca) REFERENCES veiculo (placa)
) COMMENT 'Tabela que armazena informações de Sensores';

CREATE TABLE IF NOT EXISTS leitura (
idLeitura INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único da leitura',
dtLeitura TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data e hora da leitura',
temperatura DECIMAL(5, 2) DEFAULT NULL COMMENT 'Temperatura registrada na leitura',
umidade DECIMAL(5, 2) DEFAULT NULL COMMENT 'Umidade registrada na leitura',
fkSensor INT COMMENT 'Chave estrangeira que referencia o sensor associado à leitura',

PRIMARY KEY PK_idLeitura (idLeitura),
FOREIGN KEY ForeignKey_idSensor (fkSensor) REFERENCES sensor (idSensor)
) COMMENT 'Tabela que armazena informações de Leituras';

INSERT INTO empresa (nome_fantasia, email, telefone, cnpj, cep, fkMatriz) VALUES
-- Matrizes
('Empresa Matriz A', 'contato@matrizA.com', '(12) 3456-7890', '00.000.000/0001-91', '12345-678', NULL),
('Empresa Matriz B', 'contato@matrizB.com', '(09) 8765-4321', '00.000.000/0002-72', '23456-789', NULL),
('Empresa Matriz C', 'contato@matrizC.com', '(11) 2233-4455', '00.000.000/0003-53', '34567-890', NULL),
('Empresa Matriz D', 'contato@matrizD.com', '(44) 1357-9246', '00.000.600/0001-57', '13579-246', NULL),
('Empresa Matriz E', 'contato@matrizE.com', '(55) 9876-5432', '00.000.400/0001-04', '92365-432', NULL),
('Empresa Matriz F', 'contato@matrizF.com', '(66) 4321-0987', '00.000.200/0001-14', '43210-987', NULL),
-- Filiais
('Empresa Filial A1', 'contato@filialA1.com', '(22) 3344-5566', '00.000.000/0004-34', '45678-901', 1), -- 7
('Empresa Filial A2', 'contato@filialA2.com', '(33) 4455-6677', '00.000.000/0005-15', '56789-012', 1), -- 8
('Empresa Filial B1', 'contato@filialB1.com', '(44) 5566-7788', '00.000.000/0006-96', '67890-123', 2), -- 9
('Empresa Filial B2', 'contato@filialB2.com', '(44) 5566-7782', '00.000.000/0002-69', '62309-321', 2), -- 10
('Empresa Filial C1', 'contato@filialC1.com', '(55) 6677-8899', '00.000.000/0007-77', '78901-234', 3), -- 11
('Empresa Filial C2', 'contato@filialC2.com', '(66) 7766-9988', '00.000.000/0004-46', '75903-251', 3), -- 12
('Empresa Filial D1', 'contato@filialD1.com', '(55) 6677-8899', '00.000.000/0007-87', '78901-234', 4), -- 13
('Empresa Filial D2', 'contato@filialD2.com', '(55) 6627-1898', '00.034.000/0033-19', '78911-933', 4), -- 14
('Empresa Filial E1', 'contato@filialE1.com', '(55) 6634-8387', '00.000.000/0027-51', '78901-130', 5), -- 15
('Empresa Filial E2', 'contato@filialE2.com', '(55) 6609-8821', '00.000.000/0087-15', '78931-134', 5), -- 16
('Empresa Filial F1', 'contato@filialF1.com', '(55) 6618-8899', '00.004.000/0097-71', '78901-234', 6), -- 17
('Empresa Filial F2', 'contato@filialF2.com', '(55) 2468-8899', '00.009.000/0037-73', '78901-234', 6); -- 18

-- =====================================================================================================
INSERT INTO funcionario (nome, email, cpf, tipo, senha, fkEmpresa) VALUES
('João Silva', 'joao@matrizA.com', '11111111111', 'superior', 'senha1234', 1),
('Carlos Oliveira', 'carlos@matrizB.com', '33333333333', 'superior', 'senha1234', 2),
('Pedro Santos', 'pedro@matrizC.com', '55555555555', 'superior', 'senha1234', 3),
('Maria Souza', 'maria@filialA1.com', '22222222222', 'funcionario', 'senha1234', 7),
('José da Silva', 'josé@filialA2.com', '77777777777', 'funcionario', 'senha9187', 8),
('Ana Pereira', 'ana@filialB1.com', '44444444444', 'superior', 'senha0267', 9),
('Lucas Lima', 'lucas@filialC1.com', '66666666666', 'superior', 'senha1056', 11),
('Gustavo Pereira', 'gustavo@filialF2.com', '88888888888', 'superior', 'senha8765', 18),
('Luiz Monteiro', 'luiz@filialE2.com', '99999999999', 'funcionario', 'senha5678', 16),
('Ricardo Silva', 'ricardo@filialD2.com', '00000000000', 'funcionario', 'senha4321', 14);

-- =====================================================================================================
-- Foi inserido 5 veículos para cada filial
INSERT INTO veiculo (placa, rntrc, renavam, fkEmpresa) VALUES
-- Veículos para Empresa Filial A1 (ID 7)
('AAA1234', '12345678', '12345678901', 7),
('BBB5678', '87654321', '10987654321', 7),
('CCC9012', '11223343', '10293847561', 7),
('DDD3456', '44332211', '20938475610', 7),
('EEE7890', '98765432', '30492847561', 7),
-- Veículos para Empresa Filial A2 (ID 8)
('FFF2468', '11223344', '56789123456', 8),
('GGG1357', '99887761', '78901234568', 8),
('HHH9876', '55667781', '90123456781', 8),
('III5432', '44556677', '34567890123', 8),
('JJJ2109', '22334451', '67890123412', 8),
-- Veículos para Empresa Filial B1 (ID 9)
('KKK9753', '99887762', '90123456782', 9),
('LLL8642', '55667782', '01234567890', 9),
('MMM7531', '44556612', '12345678902', 9),
('NNN6420', '22334452', '23456789012', 9),
('OOO5319', '11263314', '34567890112', 9),
-- Veículos para Empresa Filial B2 (ID 10)
('PPP4208', '99887763', '45678901234', 10),
('QQQ3097', '55667783', '56789012345', 10),
('RRR1986', '44556672', '67890123451', 10),
('SSS0875', '22334453', '78901234561', 10),
('TTT9764', '51223374', '89012345678', 10),
-- Veículos para Empresa Filial C1 (ID 11)
('UUU8653', '99887764', '90123456783', 11),
('VVV7542', '55667784', '01234567891', 11),
('WWW6431', '44556673', '12345678903', 11),
('XXX5320', '22334454', '23456789011', 11),
('YYY4219', '11213644', '34567890111', 11),
-- Veículos para Empresa Filial C2 (ID 12)
('ZZZ3108', '99887765', '45678901231', 12),
('AAA1997', '55667785', '56789012341', 12),
('BBB0886', '44556674', '67890123452', 12),
('CCC9775', '22334455', '78901234562', 12),
('DDD8664', '61223374', '89012345671', 12),
-- Veículos para Empresa Filial D1 (ID 13)
('EEE7553', '99887766', '90123456784', 13),
('FFF6442', '55667786', '01234567892', 13),
('GGG5331', '44556675', '12345678904', 13),
('HHH4220', '22334456', '23456789013', 13),
('III3119', '11425347', '34567890113', 13),
-- Veículos para Empresa Filial D2 (ID 14)
('JJJ2008', '99887767', '45678901232', 14),
('KKK0997', '55667787', '56789012342', 14),
('LLL9886', '44556671', '67890123453', 14),
('MMM8775', '22334457', '78901234563', 14),
('NNN7664', '11223349', '89012345672', 14),
-- Veículos para Empresa Filial E1 (ID 15)
('OOO6553', '99887768', '90123456785', 15),
('PPP5442', '55667788', '01234567893', 15),
('QQQ4331', '94556612', '12345678905', 15),
('RRR3220', '22334458', '23456789014', 15),
('SSS2119', '11223340', '34567890114', 15),
-- Veículos para Empresa Filial E2 (ID 16)
('TTT1008', '99887769', '45678901233', 16),
('UUU0997', '55667789', '56789012343', 16),
('VVV0886', '44556678', '67890123454', 16),
('WWW0775', '22334459', '78901234564', 16),
('XXX0664', '11223342', '89012345673', 16),
-- Veículos para Empresa Filial F1 (ID 17)
('YYY9553', '99887760', '90123456786', 17),
('ZZZ8442', '55667780', '01234567894', 17),
('AAA7331', '44556679', '12345678907', 17),
('BBB6220', '22334450', '23456789015', 17),
('CCC5119', '68923343', '34567890115', 17),
-- Veículos para Empresa Filial F2 (ID 18)
('DDD4008', '99887712', '45678901235', 18),
('EEE3997', '55667712', '56789012344', 18),
('FFF3886', '44552671', '67890123455', 18),
('GGG3775', '22334412', '78901234565', 18),
('HHH3664', '11723346', '89012345674', 18);

-- =========================================================================================================
-- Lotes para Empresa Filial A1 (ID 7)
INSERT INTO lote (tipoCarne, pesoKg, fkPlaca) VALUES
('bovina', 1500.00, 'AAA1234'),
('suína', 1000.00, 'BBB5678'),
('carne de ave', 800.00, 'CCC9012'),
('bovina', 2000.00, 'DDD3456'),
('suína', 1200.00, 'EEE7890'),
-- Lotes para Empresa Filial A2 (ID 8)
('bovina', 1800.00, 'FFF2468'),
('suína', 1100.00, 'GGG1357'),
('carne de ave', 750.00, 'HHH9876'),
('bovina', 2200.00, 'III5432'),
('suína', 1300.00, 'JJJ2109'),
-- Lotes para Empresa Filial B1 (ID 9)
('bovina', 1600.00, 'KKK9753'),
('suína', 1050.00, 'LLL8642'),
('carne de ave', 820.00, 'MMM7531'),
('bovina', 1900.00, 'NNN6420'),
('suína', 1150.00, 'OOO5319'),
-- Lotes para Empresa Filial B2 (ID 10)
('bovina', 1700.00, 'PPP4208'),
('suína', 950.00, 'QQQ3097'),
('carne de ave', 780.00, 'RRR1986'),
('bovina', 2050.00, 'SSS0875'),
('suína', 1250.00, 'TTT9764'),
-- Lotes para Empresa Filial C1 (ID 11)
('bovina', 1550.00, 'UUU8653'),
('suína', 1020.00, 'VVV7542'),
('carne de ave', 830.00, 'WWW6431'),
('bovina', 1950.00, 'XXX5320'),
('suína', 1180.00, 'YYY4219'),
-- Lotes para Empresa Filial C2 (ID 12)
('bovina', 1650.00, 'ZZZ3108'),
('suína', 1075.00, 'AAA1997'),
('carne de ave', 790.00, 'BBB0886'),
('bovina', 2100.00, 'CCC9775'),
('suína', 1225.00, 'DDD8664'),
-- Lotes para Empresa Filial D1 (ID 13)
('bovina', 1580.00, 'EEE7553'),
('suína', 1035.00, 'FFF6442'),
('carne de ave', 810.00, 'GGG5331'),
('bovina', 1925.00, 'HHH4220'),
('suína', 1165.00, 'III3119'),
-- Lotes para Empresa Filial D2 (ID 14)
('bovina', 1680.00, 'JJJ2008'),
('suína', 975.00, 'KKK0997'),
('carne de ave', 770.00, 'LLL9886'),
('bovina', 2150.00, 'MMM8775'),
('suína', 1285.00, 'NNN7664'),
-- Lotes para Empresa Filial E1 (ID 15)
('bovina', 1610.00, 'OOO6553'),
('suína', 1045.00, 'PPP5442'),
('carne de ave', 790.00, 'QQQ4331'),
('bovina', 1980.00, 'RRR3220'),
('suína', 1205.00, 'SSS2119'),
-- Lotes para Empresa Filial E2 (ID 16)
('bovina', 1720.00, 'TTT1008'),
('suína', 985.00, 'UUU0997'),
('carne de ave', 750.00, 'VVV0886'),
('bovina', 2055.00, 'WWW0775'),
('suína', 1240.00, 'XXX0664'),
-- Lotes para Empresa Filial F1 (ID 17)
('bovina', 1540.00, 'YYY9553'),
('suína', 1015.00, 'ZZZ8442'),
('carne de ave', 840.00, 'AAA7331'),
('bovina', 1930.00, 'BBB6220'),
('suína', 1175.00, 'CCC5119'),
-- Lotes para Empresa Filial F2 (ID 18)
('bovina', 1660.00, 'DDD4008'),
('suína', 995.00, 'EEE3997'),
('carne de ave', 720.00, 'FFF3886'),
('bovina', 2080.00, 'GGG3775'),
('suína', 1265.00, 'HHH3664');

-- =========================================================================================================
-- Foi inserido 2 sensores para cada veículo
-- Sensores para veículos da Empresa Filial A1 (ID 7)
INSERT INTO sensor
(modelo, dtPrimeiroUso, fkPlaca)
VALUES
('LM35', '2024-06-09 08:00:00', 'AAA1234'),
('DHT11', '2024-06-09 08:00:00', 'AAA1234'),
('LM35', '2024-06-09 08:00:00', 'BBB5678'),
('DHT11', '2024-06-09 08:00:00', 'BBB5678'),
('LM35', '2024-06-09 08:00:00', 'CCC9012'),
('DHT11', '2024-06-09 08:00:00', 'CCC9012'),
('LM35', '2024-06-09 08:00:00', 'DDD3456'),
('DHT11', '2024-06-09 08:00:00', 'DDD3456'),
('LM35', '2024-06-09 08:00:00', 'EEE7890'),
('DHT11', '2024-06-09 08:00:00', 'EEE7890'),
-- Sensores para veículos da Empresa Filial A2 (ID 8)
('LM35', '2024-06-09 08:00:00', 'FFF2468'),
('DHT11', '2024-06-09 08:00:00', 'FFF2468'),
('LM35', '2024-06-09 08:00:00', 'GGG1357'),
('DHT11', '2024-06-09 08:00:00', 'GGG1357'),
('LM35', '2024-06-09 08:00:00', 'HHH9876'),
('DHT11', '2024-06-09 08:00:00', 'HHH9876'),
('LM35', '2024-06-09 08:00:00', 'III5432'),
('DHT11', '2024-06-09 08:00:00', 'III5432'),
('LM35', '2024-06-09 08:00:00', 'JJJ2109'),
('DHT11', '2024-06-09 08:00:00', 'JJJ2109'),
-- Sensores para veículos da Empresa Filial B1 (ID 9)
('LM35', '2024-06-09 08:00:00', 'KKK9753'),
('DHT11', '2024-06-09 08:00:00', 'KKK9753'),
('LM35', '2024-06-09 08:00:00', 'LLL8642'),
('DHT11', '2024-06-09 08:00:00', 'LLL8642'),
('LM35', '2024-06-09 08:00:00', 'MMM7531'),
('DHT11', '2024-06-09 08:00:00', 'MMM7531'),
('LM35', '2024-06-09 08:00:00', 'NNN6420'),
('DHT11', '2024-06-09 08:00:00', 'NNN6420'),
('LM35', '2024-06-09 08:00:00', 'OOO5319'),
('DHT11', '2024-06-09 08:00:00', 'OOO5319'),
-- Sensores para veículos da Empresa Filial B2 (ID 10)
('LM35', '2024-06-09 08:00:00', 'PPP4208'),
('DHT11', '2024-06-09 08:00:00', 'PPP4208'),
('LM35', '2024-06-09 08:00:00', 'QQQ3097'),
('DHT11', '2024-06-09 08:00:00', 'QQQ3097'),
('LM35', '2024-06-09 08:00:00', 'RRR1986'),
('DHT11', '2024-06-09 08:00:00', 'RRR1986'),
('LM35', '2024-06-09 08:00:00', 'SSS0875'),
('DHT11', '2024-06-09 08:00:00', 'SSS0875'),
('LM35', '2024-06-09 08:00:00', 'TTT9764'),
('DHT11', '2024-06-09 08:00:00', 'TTT9764'),
-- Sensores para veículos da Empresa Filial C1 (ID 11)
('LM35', '2024-06-09 08:00:00', 'UUU8653'),
('DHT11', '2024-06-09 08:00:00', 'UUU8653'),
('LM35', '2024-06-09 08:00:00', 'VVV7542'),
('DHT11', '2024-06-09 08:00:00', 'VVV7542'),
('LM35', '2024-06-09 08:00:00', 'WWW6431'),
('DHT11', '2024-06-09 08:00:00', 'WWW6431'),
('LM35', '2024-06-09 08:00:00', 'XXX5320'),
('DHT11', '2024-06-09 08:00:00', 'XXX5320'),
('LM35', '2024-06-09 08:00:00', 'YYY4219'),
('DHT11', '2024-06-09 08:00:00', 'YYY4219'),
-- Sensores para veículos da Empresa Filial C2 (ID 12)
('LM35', '2024-06-09 08:00:00', 'ZZZ3108'),
('DHT11', '2024-06-09 08:00:00', 'ZZZ3108'),
('LM35', '2024-06-09 08:00:00', 'AAA1997'),
('DHT11', '2024-06-09 08:00:00', 'AAA1997'),
('LM35', '2024-06-09 08:00:00', 'BBB0886'),
('DHT11', '2024-06-09 08:00:00', 'BBB0886'),
('LM35', '2024-06-09 08:00:00', 'CCC9775'),
('DHT11', '2024-06-09 08:00:00', 'CCC9775'),
('LM35', '2024-06-09 08:00:00', 'DDD8664'),
('DHT11', '2024-06-09 08:00:00', 'DDD8664'),
-- Sensores para veículos da Empresa Filial D1 (ID 13)
('LM35', '2024-06-09 08:00:00', 'EEE7553'),
('DHT11', '2024-06-09 08:00:00', 'EEE7553'),
('LM35', '2024-06-09 08:00:00', 'FFF6442'),
('DHT11', '2024-06-09 08:00:00', 'FFF6442'),
('LM35', '2024-06-09 08:00:00', 'GGG5331'),
('DHT11', '2024-06-09 08:00:00', 'GGG5331'),
('LM35', '2024-06-09 08:00:00', 'HHH4220'),
('DHT11', '2024-06-09 08:00:00', 'HHH4220'),
('LM35', '2024-06-09 08:00:00', 'III3119'),
('DHT11', '2024-06-09 08:00:00', 'III3119'),
-- Sensores para veículos da Empresa Filial D2 (ID 14)
('LM35', '2024-06-09 08:00:00', 'JJJ2008'),
('DHT11', '2024-06-09 08:00:00', 'JJJ2008'),
('LM35', '2024-06-09 08:00:00', 'KKK0997'),
('DHT11', '2024-06-09 08:00:00', 'KKK0997'),
('LM35', '2024-06-09 08:00:00', 'LLL9886'),
('DHT11', '2024-06-09 08:00:00', 'LLL9886'),
('LM35', '2024-06-09 08:00:00', 'MMM8775'),
('DHT11', '2024-06-09 08:00:00', 'MMM8775'),
('LM35', '2024-06-09 08:00:00', 'NNN7664'),
('DHT11', '2024-06-09 08:00:00', 'NNN7664'),
-- Sensores para veículos da Empresa Filial E1 (ID 15)
('LM35', '2024-06-09 08:00:00', 'OOO6553'),
('DHT11', '2024-06-09 08:00:00', 'OOO6553'),
('LM35', '2024-06-09 08:00:00', 'PPP5442'),
('DHT11', '2024-06-09 08:00:00', 'PPP5442'),
('LM35', '2024-06-09 08:00:00', 'QQQ4331'),
('DHT11', '2024-06-09 08:00:00', 'QQQ4331'),
('LM35', '2024-06-09 08:00:00', 'RRR3220'),
('DHT11', '2024-06-09 08:00:00', 'RRR3220'),
('LM35', '2024-06-09 08:00:00', 'SSS2119'),
('DHT11', '2024-06-09 08:00:00', 'SSS2119'),
-- Sensores para veículos da Empresa Filial E2 (ID 16)
('LM35', '2024-06-09 08:00:00', 'TTT1008'),
('DHT11', '2024-06-09 08:00:00', 'TTT1008'),
('LM35', '2024-06-09 08:00:00', 'UUU0997'),
('DHT11', '2024-06-09 08:00:00', 'UUU0997'),
('LM35', '2024-06-09 08:00:00', 'VVV0886'),
('DHT11', '2024-06-09 08:00:00', 'VVV0886'),
('LM35', '2024-06-09 08:00:00', 'WWW0775'),
('DHT11', '2024-06-09 08:00:00', 'WWW0775'),
('LM35', '2024-06-09 08:00:00', 'XXX0664'),
('DHT11', '2024-06-09 08:00:00', 'XXX0664'),
-- Sensores para veículos da Empresa Filial F1 (ID 17)
('LM35', '2024-06-09 08:00:00', 'YYY9553'),
('DHT11', '2024-06-09 08:00:00', 'YYY9553'),
('LM35', '2024-06-09 08:00:00', 'ZZZ8442'),
('DHT11', '2024-06-09 08:00:00', 'ZZZ8442'),
('LM35', '2024-06-09 08:00:00', 'AAA7331'),
('DHT11', '2024-06-09 08:00:00', 'AAA7331'),
('LM35', '2024-06-09 08:00:00', 'BBB6220'),
('DHT11', '2024-06-09 08:00:00', 'BBB6220'),
('LM35', '2024-06-09 08:00:00', 'CCC5119'),
('DHT11', '2024-06-09 08:00:00', 'CCC5119'),
-- Sensores para veículos da Empresa Filial F2 (ID 18)
('LM35', '2024-06-09 08:00:00', 'DDD4008'),
('DHT11', '2024-06-09 08:00:00', 'DDD4008'),
('LM35', '2024-06-09 08:00:00', 'EEE3997'),
('DHT11', '2024-06-09 08:00:00', 'EEE3997'),
('LM35', '2024-06-09 08:00:00', 'FFF3886'),
('DHT11', '2024-06-09 08:00:00', 'FFF3886'),
('LM35', '2024-06-09 08:00:00', 'GGG3775'),
('DHT11', '2024-06-09 08:00:00', 'GGG3775'),
('LM35', '2024-06-09 08:00:00', 'HHH3664'),
('DHT11', '2024-06-09 08:00:00', 'HHH3664');

-- =======================================================================================
INSERT INTO leitura (dtLeitura, temperatura, umidade, fkSensor)
VALUES 
('2024-04-05 10:00:00', 4.2, 94.5, 1),
('2024-04-05 10:00:00', 3.2, 93.5, 2),
('2024-04-05 10:00:00', 3.2, 92.9, 3),
('2024-04-05 10:00:00', 2.5, 91.4, 4),
('2024-04-05 10:00:00', 3.2, 94.8, 5),
('2024-04-05 10:00:00', 2.1, 85.2, 6),
('2024-04-05 10:00:00', 2.1, 86.2, 7),
('2024-04-05 10:00:00', 2.1, 89.2, 8),
('2024-04-05 10:00:00', 2.1, 87.2, 9),
('2024-04-05 10:00:00', 5.1, 86.2, 10),

('2024-04-05 10:00:00', 4.2, 87.5, 11),
('2024-04-05 10:00:00', 3.2, 91.5, 12),
('2024-04-05 10:00:00', 3.2, 96.9, 13),
('2024-04-05 10:00:00', 2.5, 87.4, 14),
('2024-04-05 10:00:00', 3.2, 95.8, 15),
('2024-04-05 10:00:00', 2.1, 94.5, 16),
('2024-04-05 10:00:00', 2.1, 87.8, 17),
('2024-04-05 10:00:00', 2.1, 89.1, 18),
('2024-04-05 10:00:00', 2.1, 88.7, 19),
('2024-04-05 10:00:00', 5.1, 89.3, 20),

('2024-04-05 10:00:00', 4.2, 87.5, 21),
('2024-04-05 10:00:00', 3.2, 91.5, 22),
('2024-04-05 10:00:00', 3.2, 96.9, 23),
('2024-04-05 10:00:00', 2.5, 87.4, 24),
('2024-04-05 10:00:00', 3.2, 95.8, 25),
('2024-04-05 10:00:00', 2.1, 94.5, 26),
('2024-04-05 10:00:00', 2.1, 87.8, 27),
('2024-04-05 10:00:00', 2.1, 89.1, 28),
('2024-04-05 10:00:00', 2.1, 88.7, 29),
('2024-04-05 10:00:00', 5.1, 89.3, 30),

('2024-04-05 10:00:00', 4.2, 87.5, 31),
('2024-04-05 10:00:00', 3.2, 91.5, 32),
('2024-04-05 10:00:00', 3.2, 96.9, 33),
('2024-04-05 10:00:00', 2.5, 87.4, 34),
('2024-04-05 10:00:00', 3.2, 95.8, 35),
('2024-04-05 10:00:00', 2.1, 94.5, 36),
('2024-04-05 10:00:00', 2.1, 87.8, 37),
('2024-04-05 10:00:00', 2.1, 89.1, 38),
('2024-04-05 10:00:00', 2.1, 88.7, 39),
('2024-04-05 10:00:00', 5.1, 89.3, 40),

('2024-04-05 10:00:00', 4.2, 94.5, 41),
('2024-04-05 10:00:00', 3.2, 93.5, 42),
('2024-04-05 10:00:00', 3.2, 92.9, 43),
('2024-04-05 10:00:00', 2.5, 91.4, 44),
('2024-04-05 10:00:00', 3.2, 94.8, 45),
('2024-04-05 10:00:00', 2.1, 85.2, 46),
('2024-04-05 10:00:00', 2.1, 86.2, 47),
('2024-04-05 10:00:00', 2.1, 89.2, 48),
('2024-04-05 10:00:00', 2.1, 87.2, 49),
('2024-04-05 10:00:00', 5.1, 86.2, 50),

('2024-04-05 10:00:00', 4.2, 94.5, 51),
('2024-04-05 10:00:00', 3.2, 93.5, 52),
('2024-04-05 10:00:00', 3.2, 92.9, 53),
('2024-04-05 10:00:00', 2.5, 91.4, 54),
('2024-04-05 10:00:00', 3.2, 94.8, 55),
('2024-04-05 10:00:00', 2.1, 85.2, 56),
('2024-04-05 10:00:00', 2.1, 86.2, 57),
('2024-04-05 10:00:00', 2.1, 89.2, 58),
('2024-04-05 10:00:00', 2.1, 87.2, 59),
('2024-04-05 10:00:00', 5.1, 86.2, 60),

('2024-04-05 10:00:00', 4.2, 94.5, 61),
('2024-04-05 10:00:00', 3.2, 93.5, 62),
('2024-04-05 10:00:00', 3.2, 92.9, 63),
('2024-04-05 10:00:00', 2.5, 91.4, 64),
('2024-04-05 10:00:00', 3.2, 94.8, 65),
('2024-04-05 10:00:00', 2.1, 85.2, 66),
('2024-04-05 10:00:00', 2.1, 86.2, 67),
('2024-04-05 10:00:00', 2.1, 89.2, 68),
('2024-04-05 10:00:00', 2.1, 87.2, 69),
('2024-04-05 10:00:00', 5.1, 86.2, 70),

('2024-04-05 10:00:00', 4.2, 94.5, 71),
('2024-04-05 10:00:00', 3.2, 93.5, 72),
('2024-04-05 10:00:00', 3.2, 92.9, 73),
('2024-04-05 10:00:00', 2.5, 91.4, 74),
('2024-04-05 10:00:00', 3.2, 94.8, 75),
('2024-04-05 10:00:00', 2.1, 85.2, 76),
('2024-04-05 10:00:00', 2.1, 86.2, 77),
('2024-04-05 10:00:00', 2.1, 89.2, 78),
('2024-04-05 10:00:00', 2.1, 87.2, 79),
('2024-04-05 10:00:00', 5.1, 86.2, 80),

('2024-04-05 10:00:00', 4.2, 94.5, 81),
('2024-04-05 10:00:00', 3.2, 93.5, 82),
('2024-04-05 10:00:00', 3.2, 92.9, 83),
('2024-04-05 10:00:00', 2.5, 91.4, 84),
('2024-04-05 10:00:00', 3.2, 94.8, 85),
('2024-04-05 10:00:00', 2.1, 85.2, 86),
('2024-04-05 10:00:00', 2.1, 86.2, 87),
('2024-04-05 10:00:00', 2.1, 89.2, 88),
('2024-04-05 10:00:00', 2.1, 87.2, 89),
('2024-04-05 10:00:00', 5.1, 86.2, 90),

('2024-04-05 10:00:00', 4.2, 94.5, 91),
('2024-04-05 10:00:00', 3.2, 93.5, 92),
('2024-04-05 10:00:00', 3.2, 92.9, 93),
('2024-04-05 10:00:00', 2.5, 91.4, 94),
('2024-04-05 10:00:00', 3.2, 94.8, 95),
('2024-04-05 10:00:00', 2.1, 85.2, 96),
('2024-04-05 10:00:00', 2.1, 86.2, 97),
('2024-04-05 10:00:00', 2.1, 89.2, 98),
('2024-04-05 10:00:00', 2.1, 87.2, 99),
('2024-04-05 10:00:00', 5.1, 86.2, 100),

('2024-04-05 10:00:00', 3.2, 25.5, 101),
('2024-04-05 10:00:00', 4, 25.5, 102),
('2024-04-05 10:00:00', 2.2, 58.9, 103),
('2024-04-05 10:00:00', 2.5, 92.4, 104),
('2024-04-05 10:00:00', 3.2, 85.8, 105),
('2024-04-05 10:00:00', 1.1, 94.2, 106),
('2024-04-05 10:00:00', 1.2, 92.2, 107),
('2024-04-05 10:00:00', 0.5, 89.3, 108),
('2024-04-05 10:00:00', 2.7, 88.7, 109),
('2024-04-05 10:00:00', 6.5, 85.2, 110),

('2024-04-05 10:00:00', 4.2, 85.5, 111),
('2024-04-05 10:00:00', 4.2, 85.5, 112),
('2024-04-05 10:00:00', 4.2, 98.9, 113),
('2024-04-05 10:00:00', 2.5, 82.4, 114),
('2024-04-05 10:00:00', 3.2, 95.8, 115),
('2024-04-05 10:00:00', 2.1, 86.2, 116),
('2024-04-05 10:00:00', 1.1, 92.2, 117),
('2024-04-05 10:00:00', 0.1, 89.2, 118),
('2024-04-05 10:00:00', 4.1, 92.1, 119),
('2024-04-05 10:00:00', 3.7, 89.4, 120);
