<!DOCTYPE html>
<html>
<head>
<style>
.footer {
	position: fixed;
	left: 0;
	bottom: 0;
	width: 100%;
	background-color: black;
	color: gray;
	text-align: center;
	clear:both;
}

.sidenav {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: black;
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 50px;
  border-right-style: solid;
  border-right-width: 0px;
  border-right-color: #007BFF;
}
.navbareffects{
	border-right-style: solid;
	border-right-width: 4px;
	border-right-color: #007BFF;
}

.sidenav a {
  padding: 6px 6px 6px 32px;
  text-decoration: none;
  font-size: 20px;
  color: #818181;
  /* color: white; */
  display: block;
  transition: 0.3s;
}

.sidenav a:hover {
  color: #f1f1f1;
}

.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}
#closebutton {
  position: absolute;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
  color: #818181;
  padding-top: 20px;
}



#main {
  transition: margin-left .5s;
  padding: 16px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
</style>

<title>Waiter Express</title>
  <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>

<body style="margin-bottom: 100px">
<%Integer funcionarioid = (Integer) session.getAttribute("funcionarioid");
			if (funcionarioid.equals(0)||funcionarioid==null) {out.print("login necessário");response.sendRedirect("/");} else {}%>
			
			
<!-- side NavBar -->
<div id="mySidenav" class="sidenav" name="0">
  <a href="javascript:void(0)" onclick="closeNav()"> <i id="closebutton" class="material-icons">close</i> </a>
  <a href="/mainpage">Home</a>
  <a href="/caixa">Caixa</a>
  <a href="/cadastros">Cadastros</a>
	  <a href="/cadastros" style="padding-left: 60px; font-size: 15px">Estabelecimento</a>
	  <a href="/categorias" style="padding-left: 60px; font-size: 15px">Categorias</a>
	  <a href="/produtos" style="padding-left: 60px; font-size: 15px">Produtos</a>
	  <a href="/ingredientes" style="padding-left: 60px; font-size: 15px">Ingredientes</a>
	  <a href="/funcionarios" style="padding-left: 60px; font-size: 15px">Funcionarios</a>  
  <a href="/compras">Compras</a>
  <a href="/estoque">Estoque</a>
  <a href="/admin">Admin</a>  
  <a href="/">Sair</a>
</div>

<nav class="navbar sticky-top navbar-expand-md bg-primary navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="/mainpage">
  <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRe-kYZ0PsCaKCSO0la7LZVLYUg5y9aNji9EJ4NJHTqk67PkJKoSw" width="30" height="30" class="d-inline-block align-top rounded-circle" alt="">
  Waiter Express
  </a> <i class="material-icons" style="font-size:30px;cursor:pointer; color: white;  position: absolute; right: 20px;" onclick="openNav()">menu</i>
</nav>
			
			
<div class="section" style="display: flex; flex-direction: row; justify-content: center; align-items: center; margin-top: 8px;">
      <div class="container" style="max-width: 800px">
        <div class="row">
          <div class="col-md-12">
          
          