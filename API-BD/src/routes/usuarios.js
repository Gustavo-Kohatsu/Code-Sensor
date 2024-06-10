var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
})

router.post("/cadastrarPrimeiroUsuario", function (req, res) {
    usuarioController.cadastrarPrimeiroUsuario(req, res);
})

router.post("/autenticar", function (req, res) {
    usuarioController.autenticar(req, res);
});

router.post("/cadastrarFunc/:fkEmpresa", function (req, res) {
    usuarioController.cadastrarFunc(req, res);
});

router.post("/cadastrarLote/:fkEmpresa", function (req, res) {
    usuarioController.cadastrarLote(req, res);
});

module.exports = router;