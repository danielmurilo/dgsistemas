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
#tableContas {
	max-height: 50px;
	overflow-y: auto;
	-ms-overflow-style: -ms-autohiding-scrollbar;
}
</style>

<title>Waiter Express</title>
<meta charset="utf-8" name="viewport"
	content="width=device-width, initial-scale=1">
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

<%Integer funcionarioid = (Integer) session.getAttribute("funcionarioid");
			if (funcionarioid.equals(0)||funcionarioid==null) {out.print("login necessário");response.sendRedirect("/");} else {}%>

	<div class="navbar navbar-default navbar-static-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#navbar-ex-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/"><span> Waiter Express </span></a>
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

	<table id="tableContas" class="table table-striped table-wrapper-scroll-y">
		<thead>
			<tr>
				<th scope="col">Qtd</th>
				<th scope="col">Item</th>
				<th scope="col"><c:choose>
						<c:when test="${fn:length(lists)>0}">
						Valor
						</c:when>
						<c:otherwise>
							<br>Conta ainda sem consumo!
									</c:otherwise>
					</c:choose></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${lists}" varStatus="loop">
				<tr>
					<td>${list.qtd}</td>
					<td>${list.produto.nome}<br> ${list.obs}
					</td>
					<td>${list.valorVenda * list.qtd}</td>
				</tr>
			</c:forEach>
			<tr><td colspan="3">&nbsp;</td></tr>
			<tr><td colspan="3">&nbsp;</td></tr>
			<tr><td colspan="3">&nbsp;</td></tr>
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
#inputvalorconta {
	width: 60px;
	padding:8px;
	height:30px;
	padding:3px;
}
#divfecharconta{ display: none; }
</style>
	<div class="footer">
	<div id="divfecharconta">
		<a class="btn btn-default btn-secondary" onclick="dinheiro(${conta.total})"	target="_self">Dinheiro</a>
		<input type="number" id="inputvalorconta" value="0.00">
		<a class="btn btn-default btn-secondary" onclick="cartao()"	target="_self">Cartão</a>
		<br>
		<br>
		<br>
	</div>
		
		<p>
		<a class="btn btn-default btn-secondary" href="/mainpage"	target="_self">Voltar Contas</a>
		<a class="btn btn-default btn-danger" onclick="fecharconta(${conta.total})"	target="_self">Fechar Conta</a>
		<a class="btn btn-default btn-success" href="/lancarpedido"	target="_self">Lançar Pedido</a>
			<br>
			
			Conta ${conta.id}<br> ${conta.nome_mesa} <br><b> Total R$
			${conta.total}</b><br>
		</p>
	</div>
	
	
	<script type="text/javascript">

	function dinheiro(total){
		var valorInput = parseFloat($("#inputvalorconta").val());
		var valor;

		if( valorInput > total){
			var troco = valorInput - total;
			alert("Troco de R$ "+ troco);
			valor = total;
			}else{
					valor = valorInput;
				}	
		
		var r = confirm("Deseja Realmente \n Lançar este Pgto?\n Dinheiro R$ "+ valor);				
		if (r == true) {
			$.post( "/lancardinheiro/"+valor.toFixed(2)+0.01);
			setTimeout(
					  function() 
					  {
						  location.reload();
					  }, 1000);
		} else {

		}

		


		}		

	function cartao(){
		var valor = parseFloat($("#inputvalorconta").val());
		var r = confirm("Deseja Realmente \n Lançar este Pgto?\n Cartão R$ "+ valor);				
		if (r == true) {
			$.post( "/lancarcartao/"+valor.toFixed(2)+0.01);
			alert('Cartao Lancado!')
			setTimeout(
					  function() 
					  {
						  location.reload();
					  }, 1000);
			
		} else {

		}



		
		
		}
	
	
	function fecharconta(total){
				
		if(total > 0){			
			$("#divfecharconta").show();
			} else {
				var r = confirm("Deseja Realmente \n Fechar a Conta?");				
				if (r == true) {
					$.post( "/fecharcontapaga");
					alert('Conta Encerrada!');
				} else {
				  
				}
				
			}
		}
	</script>
	
	
	
</body>
</html>