const express = require('express');
const pool = require('./bd')

const app = express();
const usuariosRoutes=require('./routes/usuarios');
const treinosRoutes= require('./routes/treinos');
const exerciciosRoutes=require('./routes/exercicios');
const cronogramaRoutes=require('./routes/cronograma');

app.use(express.json());
app.use(express.static('front'))
app.use('/api',usuariosRoutes)
app.use('/api',treinosRoutes)
app.use('/api',exerciciosRoutes)
app.use('/api',cronogramaRoutes)


app.listen(3000,()=>{
  console.log('va para para ver o funcionamento http://localhost:3000/api/usuarios')});