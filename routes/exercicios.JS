const express = require('express');
const router = express.Router();
const pool = require('../bd');
const bcrypt = require('bcrypt');
//criar exercicio
router.post('/exercicios',async(req,res)=>{
    try{
        const{ titulo,descricao,video_url,treino_id} = req.body;
        await pool.query(
            `INSERT INTO exercicios(titulo,descricao,video_url,treino_id)
            VALUES($1,$2,$3,$4)`,
            [titulo,descricao,video_url,treino_id]
        );
        res.json({mensagem: "Exercício criado com sucesso" });
    }catch(erro){
        console.error(erro);
        res.status(500).send('Erro ao criar exercicio');
    }
});
router.get('/exercicios', async (req, res) => {
  try {
    const{treino_id}=req.query;
    const result = await pool.query('SELECT * FROM exercicios WHERE treino_id=$1',
        [treino_id]
    );
    res.json(result.rows);
  } catch (erro) {
    console.error(erro);
    res.status(500).send('Erro ao buscar exercícios');
  }
});
module.exports=router;