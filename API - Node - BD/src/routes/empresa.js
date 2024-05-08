// Criando variável que faz uma requisição no módulo Express
var express = require("express");


// Esta linha cria um novo objeto Router usando o método Router() fornecido pelo Express. Os roteadores são usados para definir grupos de rotas que podem ser montadas em diferentes caminhos.
var router = express.Router();



var empresaController = require("../controllers/empresaController");

router.get("/:idEmpresa", function (req, res) {
  empresasController.buscarEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  empresasController.cadastrar(req, res);
});

router.get("/buscar", function (req, res) {
    empresaController.buscarPorCnpj(req, res);
});

router.get("/buscar/:id", function (req, res) {
  empresaController.buscarPorId(req, res);
});

router.get("/listar", function (req, res) {
  empresaController.listar(req, res);
});

module.exports = router;

module.exports = router;