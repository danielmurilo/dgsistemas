<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>


<%Integer funcionarioid = (Integer) session.getAttribute("funcionarioid");
			if (funcionarioid.equals(0)||funcionarioid==null) {out.print("login necessário");response.sendRedirect("/");} else {}%>


				<!-- table comeca aqui -->
				<table class="table table-striped" id="mainTable">
					<tbody style="text-align: center;">
						<tr>
							<td colspan="1" width="50%">
								<div class="dropdown" style="width: 100%">									
									<select class="custom-select" style="height: 40px; width: 95%" id="selectcategorias">
										<option value="0" selected>Categoria</option>
										<c:forEach var="categoria" items="${categorias}" varStatus="loop">
											<option  value="${categoria.id}">${categoria.nome}</option>
										</c:forEach>
									</select>
								</div>
								</td>
								
								<td colspan="1" width="50%">							
								<div class="dropdown" style="width: 100%">
								
								<select class="custom-select" style="height: 40px; width: 95%" id="selectprodutos">
																	
								</select>								
								</div>
							</td>
						</tr>

						<tr>
							<td colspan="3">
							<button type="button" class="btn btn-default btn-primary" name="menos"	onclick="alterarQuantidadeMenos()" style="width: 20%; color: white; margin-right: 30px;"><i class="material-icons">exposure_neg_1</i></button>
							<input type="number" name="qtd" id="qtd" size="2" value="1" readonly="true" style="width: 30px">
							<button type="button" class="btn btn-default btn-primary" name="mais" onclick="alterarQuantidadeMais()" style="width: 20%; color: white; margin-left: 30px;"><i class="material-icons">exposure_plus_1</i></button>
							</td>
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
							<td colspan="3">
								<label class="checkbox-inline"><br><input type="checkbox" id="semverduras"> S/ Verd.</label>
								<label class="checkbox-inline"><br><input type="checkbox" id="semmolho"> S/ Molho</label>
								<label class="checkbox-inline"><br><input type="checkbox" id="paraviagem"> P/ Viagem</label>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<div class="table-wrapper-scroll-y" style="width: 100%">
									<table id="tabelaPedidos1" style="width: 100%">
										<thead style="width: 100%">
											<tr>
												<th></th>
												<th>Qtd</th>
												<th>Item</th>
												<th>Obs</th>
											</tr>
										</thead>
										<tbody id="tabelaPedidos">
										<tr>
											<td></td>
											<td><i class="material-icons">fastfood</i></td>
											<td>Faça Pedido!</td>
											<td><i class="material-icons">local_bar</i></td>	
										</tr>
										</tbody>
									</table>
								</div>

							</td>
						</tr>
					</tbody>
				</table>
				
				<!--fechando divs header -->
			</div>
		</div>
	</div>
</div>



	<footer class="footer">
	<!-- <p class="bg-primary" style="height: 4px; margin-bottom: 2px;"></p> -->
	<div class="btn-group btn-group-justified" style="width: 100%; color: white">
		<a class="btn btn-default btn-primary" onclick="window.history.back()" target="_self">Voltar</a>
		<a class="btn btn-default btn-danger" id="btnLancarTodos" target="_self" disabled="true">Salvar</a>
		<a class="btn btn-default btn-success" id="btnAdcionar" target="_self" disabled="true">Adcionar</a>
	</div>
	
	<p style="margin-top: 2px; margin-bottom: 1px">
		DG Sistemas 26.432.405/0001-92<br> <i class="material-icons" style="font-size:10px; color: #007BFF">phone</i> (81)99939-3017
	</p>
	</footer>
	
	
	
<!-- Modal -->
<div class="modal fade" id="modalConfirmarLancado" tabindex="-1" role="dialog" aria-labelledby="modalConfirmarLancado" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Waiter Express</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        Pedido Lançado!!!
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-primary" onclick="imprimirpedido()"><i style="color: white; font-size: 18px;" class="material-icons">local_printshop</i></button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" style="font-size: 17px;" onclick="location.href='/lancarpedido';">Ok</button>
      </div>
    </div>
  </div>
</div>	
	





	<script type="text/javascript">
	//funcoes sidenavbar
	var i = 0;
	function openNav() {
		if(i == 0){	i = i + 1; document.getElementById("mySidenav").style.width = "250px";
			document.getElementById("mySidenav").style.borderRight = "4px solid #007BFF";
			}else{closeNav();}

	}

	function closeNav() {
		 i = 0;
		 document.getElementById("mySidenav").value = '0';
		 document.getElementById("mySidenav").style.width = "0";
		 document.getElementById("mySidenav").style.borderRight = "0px solid white";

	}//fim funcoes sidenavbar
		
	
	var globalIdProduto;
	var globalNomeProduto;
	var globalprecoProduto;
	var produtosCategoria;
	var globalListaPedidos = [];
	var tablerow = -1;


	function imprimirpedido(){
		$.get("/findestabelecimento/", function(json) { 
			var p = window.open('', '', 'left=0,top=0,width=80mm,height=100,toolbar=0,scrollbars=0,status =0');
		    p.document.write('<html><style>	@page { size: auto;  margin: 1mm; }</style>'+
		    		'<style>@media print{.noprint{display:none;}}</style>'+
				    '<body onload=\"window.print()\">'+				    
				    '<center>'+
				    json.razaoSocial.toUpperCase() + '<br>'+
				    'COMANDA INTERNA'+				    
                    '<br>----------------------------------------------------<br></center>'+
                    dataAtualFormatada().substring()+' &nbsp;'+time()+'<span style="float:right;"> ${funcionario.nome} &nbsp </span>'+
                    '<br><center>PEDIDO</center>'+
                    '<br>QTD &nbsp;&nbsp;&nbsp;&nbsp; ITEM <br>'+                  
                    items()+
					'<br><h3>${conta.nome_mesa}'+
					 <c:choose>
						<c:when test="${(conta.delivery == 1) }">
							' (DELIVERY)'+
						</c:when>
					</c:choose>        
					'</h3>'+
					'<center><button class=\"noprint\" onclick=\"window.print()\" style=\"font-size : 50px; width: 100%; height:120px; bottom:140px;\">Imprimir Novamente</button><br><br>'+
					'<button class=\"noprint\" onclick=\"window.close()\" style=\"font-size : 50px; width: 100%; height:120px; bottom:10px;\">Fechar Impressão</button></center>'+
                    '</body></html>');
		    p.document.close();		    
			});
		}
	
	function items(){
		var items = '';
		for (i = 0; i < globalListaPedidos.length; i++) {
			var qtd = globalListaPedidos[i].qtd;
			if(qtd.length == 1){qtd = '0' + qtd;};
			items = items +'<p style="text-align: left;">&nbsp;&nbsp;'+ qtd + ' &nbsp;&nbsp; ';
			items = items + globalListaPedidos[i].nome.substring(0, 30);
			items = items + '<br><i style="padding-left: 50px">'+ globalListaPedidos[i].obs.replace(/<br>/g, '</i><br><i style="padding-left: 50px">');
			items = items + '</i>';
			};
			return items;


			
		}
	
	function time() {
		  var d = new Date();
		  var n = d.toLocaleTimeString();
		  return n;
		}
	
	function dataAtualFormatada(){
	    var data = new Date();
	        dia  = data.getDate().toString();
			if(dia.length == 1){ dia = '0' + dia; };	        
	        mes  = (data.getMonth()+1).toString(); //+1 pois no getMonth Janeiro começa com zero.
	        if(mes.length == 1){ mes = '0' + mes; };
	        ano = data.getFullYear();
	    return ""+dia+"/"+mes+"/"+ano;
	}

	
	$( "#selectcategorias" ).change(function() {
        $.get("/listarProdutosPorCategoria/"+this.value, function(json) {  
			$("#selectprodutos").empty();
			$("#selectprodutos").append('<option value="0" selected>Escolha Produto</option>');
			produtosCategoria = json;
			$.each(json, function(id, produto) {
				$("#selectprodutos").append('<option value="'+produto.id+'"> '+produto.nome+' R$ '+produto.preco+'</option>');
			});
		});
	});

	$( "#selectprodutos" ).change(function() {
		globalIdProduto = this.value;
		$("#btnAdcionar").removeAttr("disabled");
		$.each(produtosCategoria, function(id, produto) {
			if(produto.id == globalIdProduto){globalNomeProduto = produto.nome; globalprecoProduto = produto.preco;};
		});		
		$("#btnAdcionar").attr("onclick","adcionar()");
		$("#btnLancarTodos").attr("onclick","lancarPedidos()");
		});
	
	
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
				obsadd = obsadd + "S/ Verduras,<br> "};
			if (document.getElementById("semmolho").checked == true) {
				obsadd = obsadd + "S/ Molho,<br> "};
			if (document.getElementById("paraviagem").checked == true) {
				obsadd = obsadd + "*P/ VIAGEM!!!* "};

				var qtdInput = document.getElementById('qtd').value

							
			var pedido = {id:globalIdProduto, nome:globalNomeProduto, qtd:qtdInput, obs:obsadd, valorvenda:globalprecoProduto};
			globalListaPedidos.push(pedido);

			if(document.getElementById("paraviagem").checked == true){

				$.get("/cobraEmbalagem/"+globalIdProduto, function(cobraEmbalagem) {  
					
					if(cobraEmbalagem === '1'){
							$.get("getIdTaxaEmbalagem", function(embalagem){
								var embalagem = {id:embalagem.id, nome:'Embalagem', qtd:qtdInput, obs:'', valorvenda:embalagem.preco};
								globalListaPedidos.push(embalagem);
								popularTabela();
								});

						}
				});  
			}
			$("#btnLancarTodos").removeAttr("disabled");
			limparCampos();
			popularTabela();		
			
		}



		function lancarPedidos(){
			if(globalListaPedidos.length < 1){
				}else{
					$.ajax({
						type: 'POST',
						dataType: 'json',
						contentType:'application/json',
						url: "/salvarPedidos",
						data:JSON.stringify(globalListaPedidos),
						success: function(data, textStatus ){
						console.log(data);				
						},
						error: function(xhr, textStatus, errorThrown){
						//alert('request failed'+errorThrown);
						}
						});
					/* imprimirpedido(); */
					limparCampos();			
					$("#tabelaPedidos").empty();
					 $("#btnLancarTodos").attr("disabled", true);
					 $("#btnAdcionar").attr("disabled", true);
					$('#modalConfirmarLancado').modal('show');
					$("#btnAdcionar").attr("onclick","adcionar()");
					$("#btnLancarTodos").attr("onclick","lancarPedidos()");
					imprimirpedido();
					/* setTimeout(function(){ globalListaPedidos.length = 0; }, 300);
					$('#selectprodutos')[0].options.length = 0; */
					}
							
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
				$("#tabelaPedidos").append('<td onclick="deleterow('+i+')"><i class="material-icons">delete</i></td>');
				$("#tabelaPedidos").append('<td>&nbsp;&nbsp'+globalListaPedidos[i].qtd+'&nbsp;&nbsp;</td>');
				$("#tabelaPedidos").append('<td>'+globalListaPedidos[i].nome.substring(0, 12)+'&nbsp;&nbsp;</td>');
				$("#tabelaPedidos").append('<td>'+globalListaPedidos[i].obs.substring(0, 100)+'</td>');				
				$("#tabelaPedidos").append('</tr>');
				  
			}
		}

			function limparCampos(){
				$("#qtd").val("1");
				$("#obs").val("");
				$("#semverduras").prop( "checked", false );
				$("#semmolho").prop( "checked", false );
				$("#paraviagem").prop( "checked", false );
				$("#btnAdcionar").attr("onclick","");
				$("#selectcategorias").val('0');
				$("#selectprodutos").val('0');												
				}

		
	</script>


</body>
</html>