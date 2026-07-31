const express = require('express');
const router = express.Router();
const pool = require('../bd');
console.log("informacaoUtil carregado");
router.get('/informacao/aluno/:id/mes',async(req,res)=>{
    try{
        const{ id} = req.params;
        const resultado =await pool.query( 
             `
        SELECT
            TO_CHAR(data,'MM/YYYY') AS mes,
            COUNT(*)::int AS quantidade

        FROM historico_treino

        WHERE aluno_id=$1

        GROUP BY
            TO_CHAR(data,'MM/YYYY'),
            DATE_TRUNC('month',data)

        ORDER BY DATE_TRUNC('month',data)
        `,[id]);
        res.json(resultado.rows);
    } catch(erro){
        res.status(500).json({
            erro:erro.message
        });
    }

});

/// caloria
router.get('/informacao/aluno/:id/caloria',async(req,res)=>{
    try{
        const{ id} = req.params;
        const resultado =await pool.query( 
             `
        SELECT
            TO_CHAR(data,'MM/YYYY') AS mes,
            SUM(calorias):: int AS calorias
            

        FROM historico_treino

        WHERE aluno_id=$1

        GROUP BY
            TO_CHAR(data,'MM/YYYY'),
            DATE_TRUNC('month',data)

        ORDER BY DATE_TRUNC('month',data)
        `,[id]);
        res.json(resultado.rows);
    } catch(erro){
        res.status(500).json({
            erro:erro.message
        });
    }

});
///TEMPO
router.get('/informacao/aluno/:id/tempo',async(req,res)=>{
    try{
        const{ id} = req.params;
        const resultado =await pool.query( 
             `
        SELECT
            TO_CHAR(data,'MM/YYYY') AS mes,
            SUM(tempo_minutos):: int AS minutos
            

        FROM historico_treino

        WHERE aluno_id=$1

        GROUP BY
            TO_CHAR(data,'MM/YYYY'),
            DATE_TRUNC('month',data)

        ORDER BY DATE_TRUNC('month',data)
        `,[id]);
        res.json(resultado.rows);
    } catch(erro){
        res.status(500).json({
            erro:erro.message
        });
    }

});
router.get('/informacao/treinador/:id/alunos',async(req, res)=>{
    
    try{
        const{id}=req.params;
        const resultado =await pool.query(`
            SELECT
            u.user_id,
            u.nome,
            u.email
            FROM aluno_treinador at
            INNER JOIN usuarios u
            ON u.user_id = at.aluno_id
            WHERE at.treinador_id =$1
            ORDER BY u.nome`
        ,[id]);
        res.json(resultado.rows);
    }catch(erro){
        res.status(500).json({erro: erro.message});
    }
});
module.exports=router;

