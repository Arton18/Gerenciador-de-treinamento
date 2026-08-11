const nodemailer = require("nodemailer");
const transporter= nodemailer.createTransport({
host:'smtp.gmail.com',
port:587,
secure:false,
auth:{
    user: process.env.EMAIL_USER,
    pass:process.env.EMAIL_SENHA
}
});
transporter.verify((erro, sucesso) => {

    if (erro) {
        console.error("================================");
        console.error("ERRO NO SMTP DO GMAIL");
        console.error(erro);
        console.error("================================");
    } else {
        console.log("================================");
        console.log("SMTP DO GMAIL CONECTADO!");
        console.log("================================");
    }

});
module.exports=transporter;