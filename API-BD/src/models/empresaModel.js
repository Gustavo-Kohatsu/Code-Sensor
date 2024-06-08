var database = require("../database/config");

function ultimaEmpresaCadastrada() {
  var instrucaoSql = `SELECT max(id) as ultima_empresa_cadastrada 
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


module.exports = {
  cadastrar,
  ultimaEmpresaCadastrada
};



