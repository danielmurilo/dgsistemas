<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<style>
body {
	background-image: url('');
	background-repeat: no-repeat;
	background-size: auto;
}
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
</style>

<head>
<title>Waiter Express</title>
  <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>

<body style="margin-bottom: 100px">
	

<nav class="navbar sticky-top navbar-expand-md bg-primary navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="/mainpage">
  <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRe-kYZ0PsCaKCSO0la7LZVLYUg5y9aNji9EJ4NJHTqk67PkJKoSw" width="30" height="30" class="d-inline-block align-top rounded-circle" alt="">
  Waiter Express
  </a>  
</nav>
	
	
	<div class="section" style="display: flex; flex-direction: row; justify-content: center; align-items: center; margin-top: 80px;">
		<div class="container" style="max-width: 300px;">
			<div class="row">
				<div class="col-md-12">
					<form role="form" action="login" method="post">
						<div class="form-group">
							<label class="control-label" for="inputlogin">Login</label>
							<input class="form-control" id="inputlogin"	placeholder="Entre com seu login" type="text" required="required" name="login">
						</div>
						<div class="form-group">
							<label class="control-label" for="exampleInputPassword1">Senha</label>
							<input class="form-control" id="exampleInputPassword1" placeholder="Digite sua senha" type="password" name="password" required="required">
						</div>
						<button type="submit" class="btn btn-default">Entrar</button>

						<p>
						<div ${hidden_attribute} class="row">
							<div class="col-md-12">
								<div class="alert alert-warning">
									<strong>${message1} </strong>${message2}
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
			
			
		
	
	<footer class="footer">
		<p class="bg-primary" style="height: 4px; margin-bottom: 2px;"></p>
	<p style="margin-top: 2px; margin-bottom: 1px">
		DG Sistemas 26.432.405/0001-92<br> <i class="material-icons" style="font-size:10px; color: #007BFF">phone</i> (81)99939-3017
	</p>
	</footer>
</body>
</html>