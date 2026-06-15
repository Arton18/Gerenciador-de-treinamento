const express = require('express');
const pool = require('./bd')

const app = express();
const usuariosRoutes=require('./routes/usuarios');
app.use(express.json());
app.use(express.static('front'))
app.use('/api',usuariosRoutes)

app.listen(3000,()=>{
  console.log('va para para ver o funcionamento http://localhost:3000/api/usuarios')});