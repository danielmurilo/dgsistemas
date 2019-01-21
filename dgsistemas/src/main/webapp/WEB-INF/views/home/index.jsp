<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript"
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<script type="text/javascript"
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css"
	rel="stylesheet" type="text/css">
<style>
body {
	background-image: url('');
	background-repeat: no-repeat;
	background-size: auto;
}
</style>
</head>

<body>
	<div class="navbar navbar-default navbar-static-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#navbar-ex-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/"><span>Waiter Express</span></a>
			</div>
			<div class="collapse navbar-collapse" id="navbar-ex-collapse">
				<ul class="nav navbar-nav navbar-right">
					<li class="active"></li>
					<li></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="section"
		style="display: flex; flex-direction: row; justify-content: center; align-items: center">
		<div class="container" style="max-width: 300px;">
			<div class="row">
				<div class="col-md-12">
					<form role="form" action="login" method="post">

						<div class="form-group">
							<label class="control-label" for="inputlogin">Login</label>
							<input class="form-control" id="inputlogin"
								placeholder="Entre com seu login" type="text"
								required="required" name="login">
						</div>
						<div class="form-group">
							<label class="control-label" for="exampleInputPassword1">Senha</label>
							<input class="form-control" id="exampleInputPassword1"
								placeholder="Digite sua senha" type="password" name="password"
								required="required">
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
			
			
			
			<style>
.footer {
	position: fixed;
	left: 0;
	bottom: 0;
	width: 100%;
	background-color: #F8F8F8;
	color: Black;
	text-align: center;
}
</style>
	<div class="footer">
		<p>DG Sistemas<br>26.432.405/0001-92<br>+55(81)99939-3017</p>
	</div>
	
	
</body>
</html>