<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<style type="text/css">
.form-inline {
	padding-top: 1rem;
}
</style>

<title>Waiter Express</title>
<meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
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
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	rel="stylesheet" type="text/css">
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
					<li class=""><a target="_self" href="/admin">Admin</a></li>
						<li class=""><a target="_self" href="/mainpage">Pagina Principal</a></li>
						<li><a target="_self" href="/"> Sair</a></li>
				</ul>
			</div>

		</div>
	</div>


	<form action="/exibirCaixa/{inputCaixaDate}">
	Selecione uma data para exibir o caixa
	<input type="date" onclick="" name="inputCaixaDate">
	<input type="submit">
	</form>
	
	<table class="table table-striped">
  <thead>
  <tr><td>Totais:</td>
  </tr>
			<%--     <tr>
		    <fmt:setLocale value = "pt-BR"/>
		    <th>Dinheiro: <c:set var ="totaldin" value="${valortotalemdinheiro}"><fmt:formatNumber value = "totaldin" type ="currency" currencySymbol="R$"/></c:set></th>
		    <th>Cartão: <c:set var="totalcartao" value="${valortotalemcartao}"><fmt:formatNumber value = "totalcartao" type ="currency" currencySymbol="R$"/></c:set></th>
		    </tr> --%>
    <tr>
    <td>Dinheiro: ${valortotalemdinheiro}</td>
    <td>Cartão: ${valortotalemcartao}</td>
    </tr>
  </thead>
  
  <tbody>
    <tr>
      <td scope="col">Conta</td>
      <td scope="col">Nome/Mesa</td>
      <td scope="col">Total</td>
      <td scope="col">Funcionario</td>
      <td scope="col">Status</td>
    </tr>
 			<c:forEach var="conta" items="${contas}" varStatus="loop">
					<tr>
						<th>${conta.id}</th>
						<td>${conta.nome_mesa}</td>
						<td>${conta.total}</td>
						<td>${conta.funcionarioAbertura.nome}</td>
						<c:choose>
							<c:when test="${conta.status>0}">
								<td>Aberta</td>
							</c:when>
							<c:otherwise>
								<td>Encerrada</td>
							</c:otherwise>
						</c:choose>
						    
					</tr>
				</c:forEach>
				   
    
    
    
  </tbody>
</table>
	
	
	
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