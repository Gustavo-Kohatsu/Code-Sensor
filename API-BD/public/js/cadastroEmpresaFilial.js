function cadastrar() {


    aguardar();

    var nomeVar = input_nome.value;
    var emailVar = input_email.value;
    var telefoneVar = input_telefone.value;
    var cnpjVar = input_cnpj.value;
    var cepVar = input_cep.value;
    // var senhaVar = input_senha.value;


    if (nomeVar != '' &&
      telefoneVar != '' && emailVar != '' &&
      cepVar != '' && cnpjVar != '') {
      setInterval(sumirMensagem, 5000);
    } else {
      cardErro.style.display = "block";
      mensagem_erro.innerHTML =
        "(Mensagem de erro para todos os campos em branco)";
      alert("Mensagem de erro para todos os campos em branco")
      finalizarAguardar();
      return false;
    }

    if (cepVar.length != 8) {
      alert('CEP Inválido!')
    } else if (cnpjVar.length != 14) {
      alert('CNPJ Inválido!')
    }
    else if (emailVar.indexOf('@') == -1) {
      alert('Email inválido!')
    } else {
      aguardar();
      fetch("empresas/cadastrar", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          // crie um atributo que recebe o valor recuperado aqui
          // Agora vá para o arquivo routes/usuario.js
          nomeServer: nomeVar,
          emailServer: emailVar,
          telefoneServer: telefoneVar,
          cnpjServer: cnpjVar,
          cepServer: cepVar,
          // senhaServer: senhaVar,



        }),
      })
        .then(function (resposta) {
          console.log("resposta: ", resposta);

          if (resposta.ok) {
            cardErro.style.display = "block";

            mensagem_erro.innerHTML =
              "Cadastro realizado com sucesso! Redirecionando para tela de Login...";
            alert("Cadastro realizado com sucesso! Redirecionando para tela de Login...")

            setTimeout(() => {
              window.location = "login.html";
            }, "2000");

            limparFormulario();
            finalizarAguardar();
          } else {
            throw "Houve um erro ao tentar realizar o cadastro!";
          }
        })
        .catch(function (resposta) {
          console.log(`#ERRO: ${resposta}`);
          finalizarAguardar();
        });
    }

  }

  // function aparecerInput() {
  //   const checkbox = document.getElementById('input_filial');
  //   const colunaInputs3 = document.getElementById('colunaInputs3');
  //   if (checkbox.checked) {
  //     // colunaInputs3.style.display = 'block';
  //     colunaInputs3.style.visibility = 'visible';
  //   } else {
  //     colunaInputs3.style.visibility = 'hidden';
  //     // colunaInputs3.style.display = 'none';
  //   }
  // }

  // function validarSenha() {
  //   document.querySelector('.validacaoSenha').innerHTML = '';

  //   const senhaValidacao = input_senha.value;

  //   // VERIFICAÇÃO letras minúsculas
  //   let arrayLower = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
  //   let lowerInPasswd = false;

  //   for (let l = 0; l < arrayLower.length; l++) {
  //     if (senhaValidacao.includes(arrayLower[l])) {
  //       lowerInPasswd = true;
  //     }
  //   }

  //   // VERIFICAÇÃO letras maiúsculas
  //   let arrayUpper = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
  //   let upperInPasswd = false;

  //   for (let u = 0; u < arrayUpper.length; u++) {
  //     if (senhaValidacao.includes(arrayUpper[u])) {
  //       upperInPasswd = true;
  //     }

  //   }

  //   // VERIFICAÇÃO NUMÉRICA 
  //   let arrayNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  //   let numberInPasswd = false;

  //   for (let n = 0; n < arrayNumbers.length; n++) {
  //     if (senhaValidacao.includes(arrayNumbers[n])) {
  //       numberInPasswd = true;
  //     }
  //   }

  //   // VERIFICAÇÃO caracteres especiais
  //   let arraySpecialChar = ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_'];
  //   let specialCharInPasswd = false;

  //   for (let s = 0; s < arraySpecialChar.length; s++) {
  //     if (senhaValidacao.includes(arraySpecialChar[s])) {
  //       specialCharInPasswd = true;
  //     }
  //   }

  //   if (senhaValidacao.length >= 12 &&
  //     ((upperInPasswd) &&
  //       (lowerInPasswd) &&
  //       (numberInPasswd) &&
  //       (specialCharInPasswd))
  //   ) {
  //     document.querySelector('.validacaoSenha').innerHTML = `<span style="color: #188F05;"><strong>- - - - - Forte</strong></span>`

  //   } else if (senhaValidacao.length >= 8 &&
  //     ((upperInPasswd) ||
  //       (lowerInPasswd) ||
  //       (numberInPasswd) ||
  //       (specialCharInPasswd))
  //   ) {
  //     document.querySelector('.validacaoSenha').innerHTML = `<span style="color: #F88206;"><strong>- - - Média</strong></span>`

  //   } else if (senhaValidacao.length >= 1) {
  //     document.querySelector('.validacaoSenha').innerHTML = `<span style="color: #B2101F"><strong>- - Fraca</strong></span>`
  //   }
  // }
  function sumirMensagem() {
    cardErro.style.display = "none";
  }