// Criando variável que faz uma requisição no módulo Express
var express = require("express");


// Esta linha cria um novo objeto Router usando o método Router() fornecido pelo Express. Os roteadores são usados para definir grupos de rotas que podem ser montadas em diferentes caminhos.
var router = express.Router();



var empresasController = require("../controllers/empresasController");

router.get("/:idEmpresa", function (req, res) {
  empresasController.buscarAquariosPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  empresasController.cadastrar(req, res);
})

module.exports = router;