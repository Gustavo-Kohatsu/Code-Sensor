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

router.get("/listarKpiTemperatura/:fkEmpresa", function (req, res) {
  empresaController.listarKpiTemperatura(req, res);
});

router.get("/listarKpiUmidade/:fkEmpresa", function (req, res) {
  empresaController.listarKpiUmidade(req, res);
});

router.get("/pegarPorcentagemInstaveis/:fkEmpresa", function (req, res) {
  empresaController.pegarPorcentagemInstaveis(req, res);
})

router.get("/qtdTemperaturaInstavelFilial/:fkEmpresa", function (req, res) {
  empresaController.qtdTemperaturaInstavelFilial(req, res);
})

router.get("/qtdUmidadeInstavelFilial/:fkEmpresa", function (req, res) {
  empresaController.qtdUmidadeInstavelFilial(req, res);
})

router.get("/porcentagemInstavelFilial/:fkEmpresa", function (req, res) {
  empresaController.porcentagemInstavelFilial(req, res);
})

router.get("/listarCaminhoes/:fkEmpresa", function (req, res) {
  empresaController.listarCaminhoes(req, res);
})

router.get("/pegarTemperaturaMaisRecente/:fkEmpresa", function (req, res) {
  empresaController.pegarTemperaturaMaisRecente(req, res);
})

router.get("/mostrarDadosTemperatura/:fkEmpresa", function (req, res) {
  empresaController.mostrarDadosTemperatura(req, res);
})


module.exports = router;