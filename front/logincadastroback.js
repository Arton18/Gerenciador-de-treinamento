// CADASTRO
document.getElementById('cadastro')?.addEventListener('submit', async (e) => {
  e.preventDefault();

  const nome = document.getElementById('nome').value;
  const email = document.getElementById('email').value;
  const senha = document.getElementById('senha').value;
  const confirmaSenha = document.getElementById('confirmaSenha').value;

  const tipo_user = document.querySelector('input[name="tipo_user"]:checked')?.value;

  if (senha !== confirmaSenha) {
    document.getElementById('erroSenha').textContent = 'Senhas diferentes';
    return;
  }

  await fetch('/api/cadastro', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ nome, email, senha, tipo_user })
  });
});

// LOGIN
document.getElementById('login')?.addEventListener('submit', async (e) => {
  e.preventDefault();

  const email = document.getElementById('email').value;
  const senha = document.getElementById('senha').value;

  const res = await fetch('/api/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, senha })
  });
  //decisão de pagina
    const data = await res.json();
  console.log(data);
  if(res.ok){
    localStorage.setItem("usuario", JSON.stringify(data.usuario));
    
    if(data.usuario.tipo_user==="treinador"){
      window.location.href="/treinopaginaTreinador.html";
    }else{
      window.location.href="/paginaAluno.html";
    }
  }else{
    document.getElementById("erroSenha").textContent=data.erro;
  }
});