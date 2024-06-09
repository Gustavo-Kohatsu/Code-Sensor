var database = require("../database/config");

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
  select count(vei.placa) as instaveisGerais_temperatura
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

function listarKpiUmidade(fkEmpresa) {
  console.log('Estou no empresaModel.js: FUNCTION listarKpiUmidade()');

  var instrucaoSql = `
  select	count(vei.placa) as instaveisGerais_umidade
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

function pegarPorcentagemInstaveis(fkEmpresa) {
  console.log('Estou no empresaModel.js: FUNCTION pegarPorcentagemInstaveis()');

  var instrucaoSql = `
  SELECT
    round((instaveis.Caminhoes_instaveis / totais.Caminhoes_totais) * 100, 0) AS Porcentagem
  FROM
    (SELECT COUNT(emp.idEmpresa) AS Caminhoes_instaveis
     FROM leitura
     JOIN sensor se ON leitura.fksensor = se.idSensor
     JOIN veiculo vei ON se.fkPlaca = vei.Placa
     JOIN empresa emp ON vei.fkEmpresa = emp.idEmpresa
     WHERE emp.idEmpresa = ${fkEmpresa}
       AND (leitura.umidade > 95 OR leitura.umidade < 85 OR leitura.temperatura > 4 OR leitura.temperatura < 0)
    ) AS instaveis,
    (SELECT COUNT(emp.idEmpresa) AS Caminhoes_totais
     FROM leitura
     JOIN sensor se ON leitura.fksensor = se.idSensor
     JOIN veiculo vei ON se.fkPlaca = vei.Placa
     JOIN empresa emp ON vei.fkEmpresa = emp.idEmpresa
     WHERE emp.idEmpresa = ${fkEmpresa}
    ) AS totais;
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

module.exports = {
  cadastrar,
  ultimaEmpresaCadastrada,
  listarKpiTemperatura,
  listarKpiUmidade,
  pegarPorcentagemInstaveis,
  qtdTemperaturaInstavelFilial,
  qtdUmidadeInstavelFilial,
  porcentagemInstavelFilial,
  listarCaminhoes
};



