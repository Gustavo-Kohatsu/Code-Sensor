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

function listarKpiTemperatura(idFilial, fkEmpresa) {
  console.log('Estou no empresaModel.js: FUNCTION listarKpiTemperatura()');
  var instrucaoSql = `
      SELECT 
      COUNT(DISTINCT veic.placa) AS instaveisGerais_temperatura
    FROM leitura AS leit
    JOIN sensor AS s 
    ON leit.fkSensor = s.idSensor
    JOIN veiculo veic
    ON s.fkPlaca = veic.placa
    JOIN empresa AS filial
    ON veic.fkEmpresa = filial.idEmpresa
    inner join empresa as matriz
    on filial.fkMatriz = matriz.idEmpresa
    WHERE (filial.idEmpresa = ${idFilial} OR matriz.fkMatriz = ${fkEmpresa} or filial.fkMatriz = ${fkEmpresa})
      AND leit.temperatura IS NOT NULL 
      AND (leit.temperatura < 0 OR leit.temperatura > 4);
  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);

}

function listarKpiUmidade(idFilial, fkEmpresa) {
  console.log('Estou no empresaModel.js: FUNCTION listarKpiUmidade()');

  var instrucaoSql = `
      SELECT 
      COUNT(DISTINCT veic.placa) AS instaveisGerais_umidade
    FROM leitura AS leit
    JOIN sensor AS s 
    ON leit.fkSensor = s.idSensor
    JOIN veiculo veic
    ON s.fkPlaca = veic.placa
    JOIN empresa AS filial
    ON veic.fkEmpresa = filial.idEmpresa
    inner join empresa as matriz
    on filial.fkMatriz = matriz.idEmpresa
    WHERE (filial.idEmpresa = ${idFilial} OR matriz.fkMatriz = ${fkEmpresa} or filial.fkMatriz = ${fkEmpresa})
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
  where filial.fkMatriz is not null and matriz.idEmpresa = ${fkEmpresa} order by 2 asc ;
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

function pegarCaminhoesCadastradosPorFilial(id_filial) {
  console.log('Estou no empresaModel.js: FUNCTION pegarCaminhoesCadastradosPorFilial()');

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

function qtdTemperaturaInstavelFilial(idFilial, fkEmpresa) {

  console.log('Estou no empresaModel: Função qtdTemperaturaInstavelFilial');

  var instrucaoSql = `
        select 
	count(*) as qtdInstaveisTemperatura
  from veiculo v
  inner join sensor s on v.placa = s.fkPlaca
  left join lote l on v.placa = l.fkPlaca
  inner join  (
      select fkSensor, max(dtLeitura) as maxDtLeitura
      from leitura
      group by fkSensor
  ) as ult_lei on s.idSensor = ult_lei.fkSensor
  inner join leitura lei on s.idSensor = lei.fkSensor and ult_lei.maxDtLeitura = lei.dtLeitura
  where (v.fkEmpresa = ${idFilial} or v.fkEmpresa = ${fkEmpresa}) and (lei.temperatura > 4 or lei.temperatura < 0)
  order by lei.dtLeitura desc;
  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);

}

function qtdUmidadeInstavelFilial(idFilial, fkEmpresa) {

  console.log('Estou no empresaModel: Função qtdUmidadeInstavelFilial');

  var instrucaoSql = `
  select 
	count(*) as qtdInstaveisUmidade
  from veiculo v
  inner join sensor s on v.placa = s.fkPlaca
  left join lote l on v.placa = l.fkPlaca
  inner join  (
      select fkSensor, max(dtLeitura) as maxDtLeitura
      from leitura
      group by fkSensor
  ) as ult_lei on s.idSensor = ult_lei.fkSensor
  inner join leitura lei on s.idSensor = lei.fkSensor and ult_lei.maxDtLeitura = lei.dtLeitura
  where (v.fkEmpresa = ${idFilial} or v.fkEmpresa = ${fkEmpresa}) and (lei.umidade > 95 or lei.umidade < 85)
  order by lei.dtLeitura desc;

  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);

}

function porcentagemInstavelFilial(idFilial, fkEmpresa) {

  console.log('Estou no empresaModel: Função porcentagemInstavelFilial');

  var instrucaoSql = `
 SELECT
    ROUND((instaveis.caminhoes_instaveis / total.total_caminhoes) * 100, 0) AS porcentagemInstavelFilial
  FROM (SELECT COUNT(DISTINCT v.placa) AS caminhoes_instaveis
                FROM veiculo v
        JOIN empresa filial ON v.fkEmpresa = filial.idEmpresa
        JOIN empresa matriz ON filial.fkMatriz = matriz.idempresa
        JOIN sensor s ON v.placa = s.fkPlaca
        JOIN leitura l ON s.idSensor = l.fkSensor
        WHERE   (filial.idempresa = ${idFilial} or matriz.fkmatriz = ${fkEmpresa})
                                AND
                (
                (l.temperatura IS NOT NULL AND (l.temperatura < 0 OR l.temperatura > 4)) OR
                (l.umidade IS NOT NULL AND (l.umidade < 85 OR l.umidade > 95))
                )
    ) AS instaveis,

    (SELECT COUNT(DISTINCT v.placa) AS total_caminhoes
    FROM veiculo v
    JOIN empresa filial ON v.fkEmpresa = filial.idEmpresa
    JOIN empresa matriz ON filial.fkMatriz = matriz.idempresa
    
    WHERE (filial.idEmpresa = ${idFilial} or matriz.fkmatriz = ${fkEmpresa})
    ) AS total;
  `;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);

}

function listarCaminhoes(idFilial, fkEmpresa) {

  console.log('Estou no empresaModel: Função - listarCaminhoes');

  var instrucaoSql = `
  select 
    v.placa,
    s.idSensor,
    ifnull(l.tipoCarne, 'NÃO TEM LOTE') as tipoCarne,
    lei.dtLeitura,
    lei.temperatura,
    lei.umidade
  from veiculo v
  inner join sensor s on v.placa = s.fkPlaca
  left join lote l on v.placa = l.fkPlaca
  inner join  (
      select fkSensor, max(dtLeitura) as maxDtLeitura
      from leitura
      group by fkSensor
  ) as ult_lei on s.idSensor = ult_lei.fkSensor
  inner join leitura lei on s.idSensor = lei.fkSensor and ult_lei.maxDtLeitura = lei.dtLeitura
  where (v.fkEmpresa = ${idFilial} or v.fkEmpresa = ${fkEmpresa}) and (lei.umidade > 95 or lei.umidade < 85 or lei.temperatura > 4 or lei.temperatura < 0)
  order by lei.dtLeitura desc;
    `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);

}

function pegarTemperaturaMaisRecente(placaCaminhao) {

  console.log('Estou no empresaModel: Função pegarTemperaturaMaisRecente');

  var instrucaoSql = `select 
    lei.temperatura as temperaturaRecente,
    lei.dtLeitura
from 
    leitura lei
join sensor se on se.idSensor = lei.fkSensor
join  veiculo  vei on vei.placa = se.fkPlaca
join empresa emp on emp.idEmpresa = vei.fkEmpresa
where vei.placa = '${placaCaminhao}'
order by 
    lei.dtLeitura desc
limit 1
;`;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);
}

function pegarUmidadeMaisRecente(placaCaminhao) {
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
where vei.placa = '${placaCaminhao}'
order by 
    lei.dtLeitura desc
  limit 1;
  `
  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql)
}

function mostrarDadosTemperatura(placaCaminhao) {

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
where vei.placa = '${placaCaminhao}'
order by 
    lei.dtLeitura desc
limit 7
;
`;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);
}

function mostrarDadosUmidade(placaCaminhao) {

  console.log('Estou no empresaModel: Função mostrarDadosUmidade');

  var instrucaoSql = `
 select 
    lei.umidade,
    substring(lei.dtLeitura, 12, 19) as dtLeitura
from 
    leitura lei
join sensor se on se.idSensor = lei.fkSensor
join  veiculo  vei on vei.placa = se.fkPlaca
join empresa emp on emp.idEmpresa = vei.fkEmpresa
where vei.placa = '${placaCaminhao}'
order by 
    lei.dtLeitura desc
limit 7
;
`;

  console.log(`Executando a instrução SQL: \n${instrucaoSql}`);
  return database.executar(instrucaoSql);
}

function listarCaminhaoPesquisado(idFilial, fkEmpresa, placa) {

  console.log('Estou no empresaModel: Função - listarCaminhoes');

  var instrucaoSql = `
        select v.placa,
	     s.idSensor,
       l.tipoCarne,
       lei.dtLeitura,
       lei.temperatura,
       lei.umidade
    from veiculo v
    inner join sensor s on v.placa = s.fkPlaca
    inner join lote l on v.placa = l.fkPlaca
    inner join leitura lei on s.idSensor = lei.fkSensor
    inner join empresa as filial on v.fkEmpresa = filial.idEmpresa
    inner join empresa as matriz on filial.fkMatriz = matriz.idEmpresa
    where (filial.idEmpresa = ${fkEmpresa} or matriz.fkMatriz = ${idFilial} or filial.idEmpresa = ${idFilial} or matriz.fkMatriz = ${fkEmpresa})
    and v.placa = '${placa}'
    order by 
    lei.dtLeitura desc
    limit 1;
    `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
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
  pegarCaminhoesCadastradosPorFilial,
  pegarInstaveisGeral,
  qtdTemperaturaInstavelFilial,
  qtdUmidadeInstavelFilial,
  porcentagemInstavelFilial,
  listarCaminhoes,
  pegarTemperaturaMaisRecente,
  pegarUmidadeMaisRecente,
  mostrarDadosTemperatura,
  mostrarDadosUmidade,
  listarCaminhaoPesquisado
};



