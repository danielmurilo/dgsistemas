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

.footer {
	position: fixed;
	left: 0;
	bottom: 0;
	width: 100%;
	background-color: #F8F8F8;
	color: Black;
	text-align: center;
}

#mainTable {
	table-layout: fixed;
}

#qtd {
	width: 30%;
}

.table-wrapper-scroll-y {
	max-height: 150px;
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

	<div class="navbar navbar-default navbar-static-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#navbar-ex-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/"><span> Waiter Express - Conta: ${contaid}</span></a>
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

	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">


				<!-- table comeca aqui -->
				<table class="table table-striped" id="mainTable">
					<tbody style="text-align: center;">
						<tr>
							<td colspan="1">
								<div class="dropdown">
									<button class="btn btn-primary dropdown-toggle" type="button"
										data-toggle="dropdown">
										Categorias <span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
										<c:forEach var="categoria" items="${categorias}"
											varStatus="loop">
											<li><a value="${categoria.id}"
												onclick="listarProdutosPorCategoria(${categoria.id})">${categoria.nome}</a></li>
											<li class="divider"></li>
										</c:forEach>
									</ul>
								</div>
							</td>
							<td>
								<div class="dropdown">
									<button class="btn btn-primary dropdown-toggle" type="button"
										data-toggle="dropdown">
										Produtos <span class="caret"></span>
									</button>
									<ul class="dropdown-menu" id="dropDownProdutos">
										<li>Escolha Uma Categoria!</li>
										<li class="divider"></li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3"><label id="labelProduto"></label></td>
						</tr>





						<tr>
							<td><button type="button" class="btn" name="menos"
									onclick="alterarQuantidadeMenos()">-</button></td>
							<td><input type="number" name="qtd" id="qtd" size="2"
								value="1" readonly="true"></td>
							<td><button type="button" class="btn" name="mais"
									onclick="alterarQuantidadeMais()">+</button></td>
						</tr>




						<tr>
							<td colspan="3">
								<div class="form-group">
									<label for="obs">Obs: (Opcional)</label>
									<textarea class="form-control" rows="2" id="obs"
										placeholder="Digite observações sobre o prato. &#10Ex.: Mal passado, bastante molho..."></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td><label class="checkbox-inline"><input
									type="checkbox" id="semverduras">Sem Verduras</label></td>
							<td><label class="checkbox-inline"><input
									type="checkbox" id="semmolho">Sem Molho</label></td>
							<td><label class="checkbox-inline"><input
									type="checkbox" id="paraviagem">Para Viagem</label></td>
						</tr>
						<tr>
							<td colspan="3">
								<div class="table-wrapper-scroll-y">
									<table id="tabelaPedidos1">
										<thead>
											<tr>
												<th colspan="3">Pedidos Adcionados</th>
											</tr>
										</thead>
										<tbody id="tabelaPedidos">

										</tbody>
									</table>
								</div>

							</td>
						</tr>
						<tr>
							<td colspan="3">
							<div class="btn-group btn-group-justified">
								<a class="btn btn-default btn-secondary" href="/mainpage" target="_self">Voltar Contas</a>
								<a class="btn btn-default btn-danger" id="btnLancarTodos" target="_self">Lançar Todos</a>
								<a class="btn btn-default btn-success" id="btnAdcionar" target="_self">Adcionar</a>
							</div>
							</td>
						</tr>
					</tbody>
				</table>


				<!-- table termina aqui -->


			</div>
		</div>
	</div>




	<!-- <div class="footer">
		<p>
			DG Sistemas<br>26.432.405/0001-92<br>+55(81)99939-3017
		</p>
	</div> -->



	<!-- json produtos -->


	<script type="text/javascript">

	var globalIdProduto;
	var globalNomeProduto;
	var globalListaPedidos = [];
	var tablerow = -1;
	
	function listarProdutosPorCategoria(id) {

        $.get("/listarProdutosPorCategoria/"+id, function(json) {  
			$("#dropDownProdutos").empty();
			$.each(json, function(i, nomeproduto) {
			    $("#dropDownProdutos").append('<li><a value="'+i+'" onclick="selecionarProduto('+i+', \''+nomeproduto+'\')"> '+nomeproduto+'</a></li>');
			    $("#dropDownProdutos").append('<li class="divider"></li>');
			    
			});
		});  
	}


	function selecionarProduto(id, nomeProduto){
		document.getElementById('labelProduto').innerHTML = nomeProduto;
		globalIdProduto = id;
		globalNomeProduto = nomeProduto;
		$("#btnAdcionar").attr("onclick","adcionar()");
		$("#btnLancarTodos").attr("onclick","lancarPedidos()");
		}
	
	
		function alterarQuantidadeMais() {

			document.getElementById('qtd').value = parseInt(document
					.getElementById('qtd').value) + 1;			
		}
		
		function alterarQuantidadeMenos() {
			if(parseInt(document.getElementById('qtd').value)>1){
				document.getElementById('qtd').value = parseInt(document
						.getElementById('qtd').value) - 1;
				}	

		}

		function adcionar() {
			var obsadd = '';
			if (document.getElementById('obs').value) {
				obsadd = obsadd + document.getElementById('obs').value + ',<br> '};
			if (document.getElementById("semverduras").checked == true) {
				obsadd = obsadd + "Sem Verduras,<br> "};
			if (document.getElementById("semmolho").checked == true) {
				obsadd = obsadd + "Sem Molho,<br> "};
			if (document.getElementById("paraviagem").checked == true) {
				obsadd = obsadd + "*PARA VIAGEM!!!* "};
							
			var pedido = {id:globalIdProduto, nome:globalNomeProduto, qtd:document.getElementById('qtd').value, obs:obsadd};
			globalListaPedidos.push(pedido);
			limparCampos();
			popularTabela();		
			
		}



		function lancarPedidos(){

			$.ajax({
				type: 'POST',
				dataType: 'json',
				contentType:'application/json',
				url: "/salvarPedidos",
				data:JSON.stringify(globalListaPedidos),
				success: function(data, textStatus ){
				console.log(data);
				alert("ok");
				},
				error: function(xhr, textStatus, errorThrown){
				//alert('request failed'+errorThrown);
				}
				});
			limparCampos();
			$("#tabelaPedidos").empty();
			globalListaPedidos.length = 0;
			alert('Pedido Lançado!');
			}

		

		

		function deleterow(position){
			globalListaPedidos.splice(position, 1);
			popularTabela();
			}

		function popularTabela(){
			$("#tabelaPedidos").empty();
			var i;
			for (i = 0; i < globalListaPedidos.length; i++) {

				if(i % 2 === 0){
					$("#tabelaPedidos").append('<tr style="background-color:powderblue;">');
					}else{
						$("#tabelaPedidos").append('<tr>');
						}
				$("#tabelaPedidos").append('<td>'+globalListaPedidos[i].qtd+'&nbsp;&nbsp;</td>');
				$("#tabelaPedidos").append('<td>'+globalListaPedidos[i].nome.substring(0, 10)+'&nbsp;&nbsp;</td>');
				$("#tabelaPedidos").append('<td> <a onclick="deleterow('+i+')" class="btn btn-default btn-md">Cancelar<a/></td>');
				$("#tabelaPedidos").append('<td>'+globalListaPedidos[i].obs.substring(0, 100)+'</td>');				
				$("#tabelaPedidos").append('</tr>');
				  
			}
		}

			function limparCampos(){
				$("#dropDownProdutos").empty();
				$("#dropDownProdutos").append('<li>Escolha Uma Categoria!</li>');
				$("#labelProduto").empty();
				$("#qtd").val("1");
				$("#obs").val("");
				$("#semverduras").prop( "checked", false );
				$("#semmolho").prop( "checked", false );
				$("#paraviagem").prop( "checked", false );
				$("#btnAdcionar").attr("onclick","");	
								
				}

		
	</script>


</body>
</html>