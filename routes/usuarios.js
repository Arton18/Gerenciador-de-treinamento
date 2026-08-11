const express = require('express');
const router = express.Router();
const pool = require('../bd');
const bcrypt = require('bcrypt');
const crypto = require('crypto');
const transporter = require('./email');
/*usuario*/
router.get('/usuarios', async (req, res) => {
  try {
    const resultado = await pool.query('SELECT * FROM usuarios');
    res.json(resultado.rows);
  } catch (erro) {
    res.status(500).json({ erro: erro.message });
  }
});

/* cadastro */
router.post('/cadastro', async (req, res) => {
  const { nome, email, senha, tipo_user } = req.body;

  try {
    //CODIFICA SENHA
    const senhaHash = await bcrypt.hash(senha, 10);
    //GERAcODIGO DE CONFIRMAÇÃO
    const tokem=crypto.randomBytes(32).toString('hex');


    const resultado = await pool.query(
      `INSERT INTO usuarios (nome, email, senha_hash, tipo_user,email_verificado,tokem_verifica)
       VALUES ($1, $2, $3, $4,FALSE,$5)
       RETURNING user_id, nome, email, tipo_user`,
      [nome, email, senhaHash, tipo_user,tokem]
    );
    //link para confirmar
    const linkConfirma=`${process.env.URL_SITE}/api/confirmar_email?tokem=${tokem}`
    //enviar email
    console.log("Tentando enviar e-mail para:", email);
    await transporter.sendMail({
      from:process.env.EMAIL_USER,
      to: email,
      subject:'Confirmação de cadastro',
      html:  `<h2>Olá, ${nome}!</h2>

                <p>
                    Seu cadastro foi realizado com sucesso.
                </p>

                <p>
                    Para ativar sua conta, clique no botão abaixo:
                </p>

                <a href="${linkConfirma}"
                   style="
                   display:inline-block;
                   padding:12px 20px;
                   background:#007bff;
                   color:white;
                   text-decoration:none;
                   border-radius:5px;">
                   
                    Confirmar meu e-mail

                </a>

                <p>
                    Se você não realizou este cadastro,
                    ignore este e-mail.
                </p>
            `
    });

    res.status(201).json({
      mensagem: 'Usuário registrado com sucesso!',
      usuario: resultado.rows[0]
    });

  } catch (erro) {
    console.error("ERRO NO CADASTRO");
    res.status(500).json({ erro: erro.message });
  }
});

router.get('/confirmar_email',async(req,res)=>{
  const{tokem}=req.query;
  try{
    const resultado=await pool.query(
      `UPDATE usuarios
      SET email_verificado=TRUE,tokem_verifica=NULL
      WHERE tokem_verifica =$1
      RETURNING nome`,[tokem]
    );
    if (resultado.rows.length===0){
      return res.status(400).send("Token invalido")
    }
    res.send(` <h1>E-mail confirmado!</h1>
            <p>Olá, ${resultado.rows[0].nome}.</p>
            <p>Sua conta foi ativada com sucesso.</p>
            <a href="/login.html">Ir para o sistema</a>
        `);
  }catch(erro){
    console.error(erro);
    res.status(500).send("E-mail não encontrado")
  }

});

/* login */
router.post('/login',async(req,res)=>{
  const{email,senha} = req.body;
  try {
    const resultado= await pool.query(
      'SELECT * FROM usuarios  WHERE email =$1',
      [email] 
    );
    if(resultado.rows.length==0){
      return res.status(401).json({erro:'Usuario não encontrado'});
    }
    const usuario=resultado.rows[0];
    if(!usuario.email_verificado){
      return res.status(403).json({
        erro:"e-mail não encontrado,verifique caixa de entrada ou o spam"
      });
    }
    const senhaCorreta=await bcrypt.compare(senha,usuario.senha_hash);
    if(!senhaCorreta){
      return res.status(401).json({erro:'Senha incorreta'});
    }
    res.json({
      mensagem:'Login confirmado',
      usuario:{
        id: usuario.user_id,
        nome:usuario.nome,
        email:usuario.email,
        tipo_user:usuario.tipo_user
      }
    });

  } catch (erro) {
    res.status(500).json({erro:erro.message});
  }

});
module.exports = router;