var express = require("express");
var router = express.Router();

var empresaController = require("../controllers/empresaController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
  empresaController.cadastrar(req, res);
})

// router.get("/buscar", function (req, res) {
//     empresaController.buscarPorCnpj(req, res);
// });

// router.get("/buscar/:id", function (req, res) {
//   empresaController.buscarPorId(req, res);
// });

// router.get("/listar", function (req, res) {
//   empresaController.listar(req, res);
// });

router.get("/ultimaEmpresaCadastrada", function (req, res) {
  empresaController.ultimaEmpresaCadastrada(req, res);
});

router.get("/listarKpiTemperatura/:idFilial/:fkEmpresa", function (req, res) {
  empresaController.listarKpiTemperatura(req, res);
});

router.get("/listarKpiUmidade/:idFilial/:fkEmpresa", function (req, res) {
  empresaController.listarKpiUmidade(req, res);
});

router.get("/pegarPorcentagemInstaveis/:fkEmpresa", function (req, res) {
  empresaController.pegarPorcentagemInstaveis(req, res);
});

router.get("/listarFiliais/:fkEmpresa", function(req, res) {
  empresaController.listarFiliais(req, res);
})

router.get("/pegarInstaveisPorFilial/:id_filial", function(req, res) {
  empresaController.pegarInstaveisPorFilial(req, res);
})

router.get("/pegarCaminhoesCadastradosPorFilial/:id_filial", function(req, res) {
  empresaController.pegarCaminhoesCadastradosPorFilial(req, res);
})

router.get("/pegarInstaveisGeral/:id_filial", function(req, res) {
  empresaController.pegarInstaveisGeral(req, res);
})

router.get("/qtdTemperaturaInstavelFilial/:idFilial/:fkEmpresa", function (req, res) {
  empresaController.qtdTemperaturaInstavelFilial(req, res);
});

router.get("/qtdUmidadeInstavelFilial/:idFilial/:fkEmpresa", function (req, res) {
  empresaController.qtdUmidadeInstavelFilial(req, res);
});

router.get("/porcentagemInstavelFilial/:idFilial/:fkEmpresa", function (req, res) {
  empresaController.porcentagemInstavelFilial(req, res);
});

router.get("/listarCaminhoes/:idFilial/:fkEmpresa", function (req, res) {
  empresaController.listarCaminhoes(req, res);
});

router.get("/pegarTemperaturaMaisRecente/:placaCaminhao", function (req, res) {
  empresaController.pegarTemperaturaMaisRecente(req, res);
});

router.get("/pegarUmidadeMaisRecente/:placaCaminhao", function (req, res) {
  empresaController.pegarUmidadeMaisRecente(req, res);
});

router.get("/mostrarDadosTemperatura/:placaCaminhao", function (req, res) {
  empresaController.mostrarDadosTemperatura(req, res);
});

router.get("/mostrarDadosUmidade/:placaCaminhao", function (req, res) {
  empresaController.mostrarDadosUmidade(req, res);
});

router.get("/listarCaminhaoPesquisado/:idFilial/:fkEmpresa/:placa", function (req, res) {
  empresaController.listarCaminhaoPesquisado(req, res);
});


module.exports = router;