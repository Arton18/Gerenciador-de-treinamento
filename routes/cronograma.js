const express = require('express');
const router = express.Router();
const pool = require('../bd');
const bcrypt = require('bcrypt');
//adicionar treino ao cronograma
router.post('/aluno_treino',async(req,res)=>{
    
    try{
        const{ 
            aluno_id,
            treino_id,
            dia_semana,
            horario
        }=req.body;
     const resultado = await pool.query(
        `INSERT INTO aluno_treino(aluno_id,treino_id,dia_semana,horario)
        VALUES($1,$2,$3,$4) 
        RETURNING *`,
        [aluno_id,
            treino_id,
            dia_semana,
            horario]
        );
        res.status(201).json({
            mensagem:"Treino adicionado ao cronograma",
            treino:resultado.rows[0]
        });
     
    }catch(erro){
        res.status(500).json({
            erro: erro.message
        });
    }
});
//
router.get('/aluno_treino',async(req,res)=>{
try{
    const{aluno_id}=req.query;
    const resultado= await pool.query(
        `SELECT
        at.id,
        at.aluno_id,
        at.treino_id,
        at.dia_semana,
        at.horario,
        t.titulo,
        t.descricao
        FROM aluno_treino at
        INNER JOIN treinos t
        ON at.treino_id = t.treino_id
        WHERE at.aluno_id=$1
        ORDER BY   
         CASE at.dia_semana
            WHEN 'Segunda-feira' THEN 1
            WHEN 'Terça-feira' THEN 2
            WHEN 'Quarta-feira' THEN 3
            WHEN 'Quinta-feira' THEN 4
            WHEN 'Sexta-feira' THEN 5
            WHEN 'Sábado' THEN 6
            WHEN 'Domingo' THEN 7
            END,
        at.horario;`,
        [aluno_id]
    );
    res.json(resultado.rows);
}catch(erro){
    res.status(500).json({
        erro:erro.message
    });
}
});
//deletar o treino errado
router.delete('/aluno_treino/:id', async(req,res)=>{

    try{
        const {id} = req.params;
        await pool.query(
            `DELETE FROM aluno_treino
             WHERE id = $1`,
            [id]
        );
        res.json({
            mensagem:"Treino removido do cronograma."
        });
    }catch(erro){
        res.status(500).json({
            erro:erro.message
        });
    }
});
//finalizar treino esses dados ainda tem que ser implementados
router.post('/historico_treino', async(req,res)=>{

    try{
        const {
            aluno_id,
            treino_id,
            tempo_minutos,
            calorias
        } = req.body;

        const resultado = await pool.query(
            `INSERT INTO historico_treino
            (
                aluno_id,
                treino_id,
                data,
                tempo_minutos,
                calorias
            )
            VALUES
            (
                $1,
                $2,
                CURRENT_DATE,
                $3,
                $4
            )
            RETURNING *`,
            [
                aluno_id,
                treino_id,
                tempo_minutos,
                calorias
            ]
        );
        res.status(201).json({
            mensagem:"Treino concluído e salvo no histórico",
            treino:resultado.rows[0]
        });
    }catch(erro){
        console.log(erro);
        res.status(500).json({
            erro:erro.message
        });
    }
});
module.exports = router;