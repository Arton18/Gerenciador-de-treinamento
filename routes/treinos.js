const express = require('express');
const router = express.Router();
const pool = require('../bd');
const bcrypt = require('bcrypt');

//cadastro de treino do treinador 
router.post('/treinos', async (req,res)=>{
    try{
        const {titulo,descricao,treinador_id} = req.body;

    const resultado = await pool.query(
        `INSERT INTO treinos
        (titulo,descricao,treinador_id)
        VALUES($1,$2,$3)
        RETURNING *`,
        [titulo,descricao,treinador_id]
    );

    res.status(201).json(resultado.rows[0]);

    }catch(erro){
        res.status(500).json({erro:erro.message});
    }
});
router.get('/treinos',async(req,res)=>{
    try{const{treinador_id}=req.query;
        const resultado= await pool.query('SELECT*FROM treinos WHERE treinador_id=$1',
        [treinador_id])
        res.json(resultado.rows);
    }catch(erro){
        res.status(500).json({erro:erro.message})
    }
});
module.exports = router;