var express = require("express");
var router = express.Router();

var caminhaoController = require("../controllers/caminhaoController");



router.get("/listarLotes/:fkEmpresa", function (req, res) {
  caminhaoController.listarLotes(req, res);
});


module.exports = router;