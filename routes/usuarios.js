const express = require('express');
const router = express.Router();
const pool = require('../bd');
const bcrypt = require('bcrypt');
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
    const senhaHash = await bcrypt.hash(senha, 10);

    const resultado = await pool.query(
      `INSERT INTO usuarios (nome, email, senha_hash, tipo_user)
       VALUES ($1, $2, $3, $4)
       RETURNING user_id, nome, email, tipo_user`,
      [nome, email, senhaHash, tipo_user]
    );

    res.status(201).json({
      mensagem: 'Usuário registrado com sucesso!',
      usuario: resultado.rows[0]
    });

  } catch (erro) {
    res.status(500).json({ erro: erro.message });
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
      return res.status(400).json({erro:'Usuario não encontrado'});
    }
    const usuario=resultado.rows[0];
    const senhaCorreta=await bcrypt.compare(senha,usuario.senha_hash);
    if(!senhaCorreta){
      return res.status(400).json({erro:'Senha incorreta'});
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