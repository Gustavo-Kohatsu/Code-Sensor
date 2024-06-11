var empresaModel = require("../models/empresaModel");

// function buscarPorCnpj(req, res) {
//   var cnpj = req.query.cnpj;

//   empresaModel.buscarPorCnpj(cnpj).then((resultado) => {
//     res.status(200).json(resultado);
//   });
// }

// function listar(req, res) {
//   empresaModel.listar().then((resultado) => {
//     res.status(200).json(resultado);
//   });
// }


function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var telefone = req.body.telefoneServer;
    var cnpj = req.body.cnpjServer;
    var cep = req.body.cepServer;
    //   var senha = req.body.senhaServer;

    var idEmpresa = req.body.idEmpresaServer

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (cnpj == undefined) {
        res.status(400).send("Seu CNPJ está undefined!");
    } else if (cep == undefined) {
        res.status(400).send("Sua cep está undefined!");
    } else if (telefone == undefined) {
        res.status(400).send("Sua telefone está undefined!");
    } else if (idEmpresa == undefined) {
        res.status(400).send("O id da sua Empresa está undefined!");
    } else {
        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        empresaModel.cadastrar(nome, email, telefone, cnpj, cep, idEmpresa)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function ultimaEmpresaCadastrada(req, res) {
    //   var id = req.params.id;

    empresaModel.ultimaEmpresaCadastrada().then((resultado) => {
        res.status(200).json(resultado);
    });
}

function listarKpiTemperatura(req, res) {
    var fkEmpresa = req.params.fkEmpresa;

    empresaModel.listarKpiTemperatura(fkEmpresa)
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send('Nenhum resultado encontrado!');
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log(`Houve um erro ao buscar o que foi solicitado! ${erro.sqlMessage}`);
            res.status(500).json(erro.sqlMessage)
        })
}

function listarKpiUmidade(req, res) {
    var fkEmpresa = req.params.fkEmpresa;

    empresaModel.listarKpiUmidade(fkEmpresa)
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send('Nenhum resultado encontrado!');
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log(`Houve um erro ao buscar o que foi solicitado! ${erro.sqlMessage}`);
            res.status(500).json(erro.sqlMessage)
        })

}

function pegarPorcentagemInstaveis(req, res) {
    var fkEmpresa = req.params.fkEmpresa;

    empresaModel.pegarPorcentagemInstaveis(fkEmpresa)
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send('Nenhum resultado encontrado!');
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log(`Houve um erro ao buscar o que foi solicitado! ${erro.sqlMessage}`);
            res.status(500).json(sqlMessage);
        })
}

function listarFiliais(req, res) {
    var fkEmpresa = req.params.fkEmpresa;

    empresaModel.listarFiliais(fkEmpresa)
    .then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send('Nenhum resultado encontrado!');
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log(`Houve um erro ao buscar o que foi solicitado! ${erro.sqlMessage}`);
        res.status(500).json(sqlMessage);
    })
}

function pegarInstaveisPorFilial(req, res) {
    var id_filial = req.params.id_filial;

    empresaModel.pegarInstaveisPorFilial(id_filial)
    .then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log(`Houve um erro ao buscar o que foi solicitado! ${erro.sqlMessage}`);
        res.status(500).json(sqlMessage);
    })
}

function pegarInstaveisGeral(req, res) {
    var id_filial = req.params.id_filial;

    empresaModel.pegarInstaveisGeral(id_filial)
    .then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log(`Houve um erro ao buscar o que foi solicitado! ${erro.sqlMessage}`);
        res.status(500).json(sqlMessage);
    })
}



function listarCaminhoes(req, res) {
    let fkEmpresa = req.params.fkEmpresa;

    empresaModel.listarCaminhoes(fkEmpresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {

        console.log(erro);
        console.log("Houve um erro ao buscar a lista de caminhões: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);

    });

}

function qtdTemperaturaInstavelFilial(req, res) {
    let fkEmpresa = req.params.fkEmpresa;

    empresaModel.qtdTemperaturaInstavelFilial(fkEmpresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {

        console.log(erro);
        console.log("Houve um erro ao buscar a quantidade de temperaturas instáveis (Filial): ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);

    });

}

function qtdUmidadeInstavelFilial(req, res) {
    let fkEmpresa = req.params.fkEmpresa;

    empresaModel.qtdUmidadeInstavelFilial(fkEmpresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {

        console.log(erro);
        console.log("Houve um erro ao buscar a quantidade de umidades instáveis (Filial): ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);

    });

}

function porcentagemInstavelFilial(req, res) {
    let fkEmpresa = req.params.fkEmpresa;

    empresaModel.porcentagemInstavelFilial(fkEmpresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {

        console.log(erro);
        console.log("Houve um erro ao buscar a porcentagem de instáveis (Filial): ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);

    });

}

function pegarTemperaturaMaisRecente(req, res) {
    let fkEmpresa = req.params.fkEmpresa;

    empresaModel.pegarTemperaturaMaisRecente(fkEmpresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {

        console.log(erro);
        console.log("Houve um erro ao buscar a última medida de temperatura ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);

    });

}

function pegarUmidadeMaisRecente(req, res) {
    let fkEmpresa = req.params.fkEmpresa;

    empresaModel.pegarUmidadeMaisRecente(fkEmpresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send('Nenhum resultado encontrado!')
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log(`Houve um erro ao buscar a última medida de umidade ${erro.sqlMessage}`);
        res.status(500).json(erro.sqlMessage);
    });
}

function mostrarDadosTemperatura(req, res) {
    let fkEmpresa = req.params.fkEmpresa;

    empresaModel.mostrarDadosTemperatura(fkEmpresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {

        console.log(erro);
        console.log("Houve um erro ao buscar a última medida de temperatura ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);

    });
}

function mostrarDadosUmidade(req, res) {
    let fkEmpresa = req.params.fkEmpresa;

    empresaModel.mostrarDadosUmidade(fkEmpresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {

        console.log(erro);
        console.log("Houve um erro ao buscar a última medida de umidade ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);

    });

}

function listarCaminhaoPesquisado(req, res) {
    
    let fkEmpresa = req.params.fkEmpresa;
    let placa = req.params.placa;

    empresaModel.listarCaminhaoPesquisado(fkEmpresa, placa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {

        console.log(erro);
        console.log("Houve um erro ao buscar os dados do caminhão pesquisado", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);

    });

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
    mostrarDadosUmidade,
    listarCaminhaoPesquisado
}