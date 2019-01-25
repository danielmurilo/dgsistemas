<%@page import="org.apache.jasper.tagplugins.jstl.core.If"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
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


	<table  style="width: 100%"  border="0">
      <tbody>
        <tr>
	        <td>Selecione uma data:</td>
	        <td>Funcionario:</td>
        </tr>
        <tr>
          <td><form action="/exibirCaixa/0/inputCaixaDate/" id="formCaixa">	
				<input type="date" name="inputCaixaDate" required>
				<input type="submit">
				</form>
          </td>

          <td>
      			<div class="dropdown">
					<button class="btn btn-primary dropdown-toggle" type="button" id="buttonDropDown"
						data-toggle="dropdown" value="Todos"> Todos	</button>
					<ul class="dropdown-menu">
							<li><a onclick="setarFuncionario(0, Todos)" value="Todos">Todos</a></li>
							<li class="divider"></li>
						<c:forEach var="funcionario" items="${funcionarios}" varStatus="loop">
							<li><a value="${funcionario.login}" onclick="setarFuncionario(${funcionario.id}, '${funcionario.login}')">${funcionario.login}</a></li>
							<li class="divider"></li>
						</c:forEach>
					</ul>
				</div>
          </td>
		</tr>
      </tbody>
    </table>
	
	
	<table class="table table-striped">
  <thead>
  <tr><td colspan="3">Recebimentos:</td>
  </tr>
    <tr>			
	<td>Dinheiro: <br>R$ ${valortotalemdinheiro * -1}</td>			
    <td>Cartão: <br>R$ ${valortotalemcartao * -1}</td>
    <td>Total: <br>${(valortotalemdinheiro + valortotalemcartao)*-1}</td>
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
	
	<script type="text/javascript">
	
		function setarFuncionario(id, login){
			$("#buttonDropDown").val(login);
			$('#formCaixa').attr('action', '/exibirCaixa/'+id+'/{inputCaixaDate}');
				
			}


	</script>
	
</body>
</html>