/* const { pegarUmidadeMaisRecente, mostrarDadosUmidade, mostrarDadosUmidadeGrafico } = require("../controllers/empresaController"); */
var database = require("../database/config");

function ultimaEmpresaCadastrada() {
  var instrucaoSql = `SELECT max(idEmpresa) as ultima_empresa_cadastrada 
                      FROM empresa limit 1`;

  return database.executar(instrucaoSql);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(nome, email, cnpj, telefone, cep, idEmpresa) {
  console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email);

  // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
  //  e na ordem de inserção dos dados.
  var instrucaoSql = `
      INSERT INTO empresa (nome_fantasia, email, cnpj, telefone, cep, fkMatriz) VALUES ('${nome}', '${email}', '${cnpj}', '${telefone}','${cep}', '${idEmpresa}');`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function ultimaEmpresaCadastrada() {
  var instrucaoSql = `SELECT max(id) as ultima_empresa_cadastrada 
                      FROM empresa limit 1`;

  return database.executar(instrucaoSql);
}

function listarKpiTemperatura(fkEmpresa) {
  console.log('Estou no empresaModel.js: FUNCTION listarKpiTemperatura()');
  var instrucaoSql = `
    SELECT 
      COUNT(DISTINCT veic.placa) AS instaveisGerais_temperatura
    FROM leitura AS leit
    JOIN sensor AS s 
    ON leit.fkSensor = s.idSensor
    JOIN veiculo veic
    ON s.fkPlaca = veic.placa
    JOIN empresa AS emp
    ON veic.fkEmpresa = emp.idEmpresa
    WHERE (emp.idEmpresa = ${fkEmpresa} OR emp.fkMatriz = ${fkEmpresa})
      AND leit.temperatura IS NOT NULL 
      AND (leit.temperatura < 0 OR leit.temperatura > 4);
  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);

}

function listarKpiUmidade(fkEmpresa) {
  console.log('Estou no empresaModel.js: FUNCTION listarKpiUmidade()');

  var instrucaoSql = `
  SELECT 
    COUNT(DISTINCT veic.placa) AS instaveisGerais_umidade
  FROM leitura AS leit
  JOIN sensor AS s 
  ON leit.fkSensor = s.idSensor
  JOIN veiculo veic
  ON s.fkPlaca = veic.placa
  JOIN empresa AS emp
  ON veic.fkEmpresa = emp.idEmpresa
  WHERE (emp.idEmpresa = ${fkEmpresa} OR emp.fkMatriz = ${fkEmpresa})
		AND leit.umidade IS NOT NULL 
		AND (leit.umidade < 85 OR leit.umidade > 95);
  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);
}

function pegarPorcentagemInstaveis(fkEmpresa) {
  console.log('Estou no empresaModel.js: FUNCTION pegarPorcentagemInstaveis()');

  var instrucaoSql = `
  SELECT 
    ROUND((instaveis.caminhoes_instaveis / total.total_caminhoes) * 100, 0) AS porcentagem_instaveis
  FROM (SELECT COUNT(DISTINCT v.placa) AS caminhoes_instaveis
		FROM veiculo v 
        JOIN empresa e ON v.fkEmpresa = e.idEmpresa
        JOIN sensor s ON v.placa = s.fkPlaca
        JOIN leitura l ON s.idSensor = l.fkSensor
        WHERE 	(e.idEmpresa = ${fkEmpresa} OR e.fkMatriz = ${fkEmpresa})
				AND 
                (
                (l.temperatura IS NOT NULL AND (l.temperatura < 0 OR l.temperatura > 4)) OR 
                (l.umidade IS NOT NULL AND (l.umidade < 85 OR l.umidade > 95))
                )
    ) AS instaveis,
    
    (SELECT COUNT(DISTINCT v.placa) AS total_caminhoes
    FROM veiculo v 
    JOIN empresa e ON v.fkEmpresa = e.idEmpresa
    WHERE (e.idEmpresa = ${fkEmpresa} OR e.fkMatriz = ${fkEmpresa})
    ) AS total;
  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);
}

function listarFiliais(fkEmpresa) {
  console.log('Estou no empresaModel.js: FUNCTION listarFiliais()');

  var instrucaoSql = `
  select 
	  filial.nome_fantasia as nome_filial,
    filial.idempresa as idFilial
  from empresa as filial
  inner join empresa as matriz
  on filial.fkMatriz = matriz.idEmpresa
  where filial.fkMatriz is not null and filial.fkMatriz = ${fkEmpresa};
  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);
}

function pegarInstaveisPorFilial(id_filial) {
  console.log('Estou no empresaModel.js: FUNCTION pegarInstaveisPorFilial()');

  var instrucaoSql = `
  SELECT COUNT(DISTINCT v.placa) AS caminhoes_instaveis
		FROM veiculo v 
        JOIN empresa e ON v.fkEmpresa = e.idEmpresa
        JOIN sensor s ON v.placa = s.fkPlaca
        JOIN leitura l ON s.idSensor = l.fkSensor
        WHERE 	(e.idEmpresa = ${id_filial})
				AND 
                (
                (l.temperatura IS NOT NULL AND (l.temperatura < 0 OR l.temperatura > 4)) OR 
                (l.umidade IS NOT NULL AND (l.umidade < 85 OR l.umidade > 95))
                );
  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);
}

function pegarInstaveisGeral(id_filial) {
  console.log('Estou no empresaModel.js: FUNCTION pegarInstaveisGeral()');

  var instrucaoSql = `
  SELECT 
    COUNT(DISTINCT v.placa) AS caminhoes_instaveis_gerais
	FROM veiculo v 
  JOIN empresa e ON v.fkEmpresa = e.idEmpresa
  JOIN sensor s ON v.placa = s.fkPlaca
  JOIN leitura l ON s.idSensor = l.fkSensor
  WHERE (e.idEmpresa = ${id_filial});
  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);
}

function qtdTemperaturaInstavelFilial(fkEmpresa) {

  console.log('Estou no empresaModel: Função qtdTemperaturaInstavelFilial');

  var instrucaoSql = `
  select count(vei.placa) as qtdInstaveisTemperatura
  from leitura
  join sensor se
  on leitura.fksensor = se.idSensor
  join veiculo vei
  on se.fkPlaca = vei.Placa
  join empresa emp
  on vei.fkEmpresa = emp.idEmpresa
  where emp.idEmpresa = ${fkEmpresa} and leitura.temperatura > 4 or leitura.temperatura < 0;
  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);

}

function qtdUmidadeInstavelFilial(fkEmpresa) {

  console.log('Estou no empresaModel: Função qtdUmidadeInstavelFilial');

  var instrucaoSql = `
  select	count(vei.placa) as qtdInstaveisUmidade
  from leitura
  join sensor se
  on leitura.fksensor = se.idSensor
  join veiculo vei
  on se.fkPlaca = vei.Placa
  join empresa emp
  on vei.fkEmpresa = emp.idEmpresa
  where emp.idEmpresa = ${fkEmpresa} and (leitura.umidade > 95 or leitura.umidade < 85);
  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);

}

function porcentagemInstavelFilial(fkEmpresa) {

  console.log('Estou no empresaModel: Função porcentagemInstavelFilial');

  var instrucaoSql = `
  SELECT
    round((instaveis.Caminhoes_instaveis / totais.Caminhoes_totais) * 100, 0) AS porcentagemInstavelFilial
  FROM
    (SELECT COUNT(emp.idEmpresa) AS Caminhoes_instaveis
     FROM leitura
     JOIN sensor se ON leitura.fksensor = se.idSensor
     JOIN veiculo vei ON se.fkPlaca = vei.Placa
     JOIN empresa emp ON vei.fkEmpresa = emp.idEmpresa
     WHERE emp.idEmpresa = 1
       AND (leitura.umidade > 95 OR leitura.umidade < 85 OR leitura.temperatura > 4 OR leitura.temperatura < 0)
    ) AS instaveis,
    (SELECT COUNT(emp.idEmpresa) AS Caminhoes_totais
     FROM leitura
     JOIN sensor se ON leitura.fksensor = se.idSensor
     JOIN veiculo vei ON se.fkPlaca = vei.Placa
     JOIN empresa emp ON vei.fkEmpresa = emp.idEmpresa
     WHERE emp.idEmpresa = 1
    ) AS totais;
  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);

}

function listarCaminhoes(fkEmpresa) {

  console.log('Estou no empresaModel: Função - listarCaminhoes');

  var instrucaoSql = `
    select v.placa,
	     s.idSensor,
       l.tipoCarne,
       lei.temperatura,
       lei.umidade
    from veiculo v
    inner join sensor s on v.placa = s.fkPlaca
    inner join lote l on v.placa = l.fkPlaca
    inner join leitura lei on s.idSensor = lei.fkSensor
    where v.fkEmpresa = ${fkEmpresa} and (lei.umidade > 95 or lei.umidade < 85 or lei.temperatura > 4 or lei.temperatura < 0);
    `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);

}

function pegarTemperaturaMaisRecente(fkEmpresa) {

  console.log('Estou no empresaModel: Função pegarTemperaturaMaisRecente');

  var instrucaoSql = `select 
    lei.temperatura as temperaturaRecente,
    lei.dtLeitura
from 
    leitura lei
join sensor se on se.idSensor = lei.fkSensor
join  veiculo  vei on vei.placa = se.fkPlaca
join empresa emp on emp.idEmpresa = vei.fkEmpresa
where idEmpresa = ${fkEmpresa}
order by 
    lei.dtLeitura desc
limit 1
;`;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);
}

function pegarUmidadeMaisRecente(fkEmpresa) {
  console.log("Estou no empresaModel: Função pegarUmidadeMaisRecente");

  var instrucaoSql = `
  select 
    lei.umidade as umidadeRecente,
    lei.dtLeitura
from 
    leitura lei
join sensor se on se.idSensor = lei.fkSensor
join  veiculo  vei on vei.placa = se.fkPlaca
join empresa emp on emp.idEmpresa = vei.fkEmpresa
where idEmpresa = ${fkEmpresa}
order by 
    lei.dtLeitura desc
  limit 1;
  `
  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql)
}

function mostrarDadosTemperatura(fkEmpresa) {

  console.log('Estou no empresaModel: Função mostrarDadosTemperatura');

  var instrucaoSql = `
 select 
    lei.temperatura,
    substring(lei.dtLeitura, 12, 19) as dtLeitura
from 
    leitura lei
join sensor se on se.idSensor = lei.fkSensor
join  veiculo  vei on vei.placa = se.fkPlaca
join empresa emp on emp.idEmpresa = vei.fkEmpresa
where idEmpresa = ${fkEmpresa}
order by 
    lei.dtLeitura desc
limit 7
;
`;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);
}


module.exports = {
  cadastrar,
  ultimaEmpresaCadastrada,
  listarKpiTemperatura,
  listarKpiUmidade,
  pegarPorcentagemInstaveis,
  listarFiliais,
  pegarInstaveisPorFilial,
  pegarInstaveisGeral,
  qtdTemperaturaInstavelFilial,
  qtdUmidadeInstavelFilial,
  porcentagemInstavelFilial,
  listarCaminhoes,
  pegarTemperaturaMaisRecente,
  pegarUmidadeMaisRecente,
  mostrarDadosTemperatura,

};



