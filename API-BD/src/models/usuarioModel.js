var database = require("../database/config")

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT idFuncionario, nome, email,tipo, senha, fkEmpresa FROM funcionario WHERE email = '${email}' AND senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}



// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrarPrimeiroUsuario(nome, email, cpf, tipo, senha, idUltimaEmpresa) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha);

    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO funcionario (nome, email, cpf, tipo, senha, fkEmpresa) VALUES ('${nome}', '${email}', '${cpf}', '${tipo}', '${senha}', ${idUltimaEmpresa});`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrarFunc(nome, email, cpf, tipo, senha, fkEmpresa) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrarFunc():", nome, email, cpf, tipo, senha, fkEmpresa);

    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO funcionario (nome, email, cpf, tipo, senha,fkEmpresa) VALUES ('${nome}', '${email}', '${cpf}','${tipo}','${senha}','${fkEmpresa}');`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrarLote(carne, carneEmbalada, placa, fkEmpresa) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrarLote():", carne, carneEmbalada, placa, fkEmpresa);

    var instrucaoSql = `
        INSERT INTO lote (tipoCarne, carnesEmbaladas, fkPlaca)
        SELECT '${carne}', '${carneEmbalada}', '${placa}'
        FROM DUAL
        WHERE EXISTS (
        SELECT *
        FROM veiculo
        WHERE placa = '${placa}' AND fkEmpresa = ${fkEmpresa}
);        
        `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrarPrimeiroUsuario,
    cadastrarFunc,
    cadastrarLote
};