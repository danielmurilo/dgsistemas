
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>

<%Integer funcionarioid = (Integer) session.getAttribute("funcionarioid");
			if (funcionarioid.equals(0)||funcionarioid==null) {out.print("login necessário");response.sendRedirect("/");} else {}%>
			
	<c:set var="total"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${conta.total}" /></c:set>

	<table id="tableContas" class="table table-striped table-wrapper-scroll-y">
		<thead>
			<tr>
				<th scope="col">Qtd</th>
				<th scope="col">Item</th>
				<th scope="col"><c:choose>
								<c:when test="${fn:length(pedidos)>0}">Valor</c:when>
								<c:otherwise><br>Conta ainda sem consumo!</c:otherwise>
								</c:choose></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="pedido" items="${pedidos}" varStatus="loop">
				<tr onclick="modalestorno(${pedido.id}, ${pedido.produto.id}, ${pedido.qtd}, '${pedido.produto.nome}', '${pedido.obs}', '${pedido.valorVenda}')">
					<td>${pedido.qtd}</td>
					<td>${pedido.produto.nome}<br> ${pedido.obs}</td>					
					<td>${pedido.valorVenda * pedido.qtd}</td>
				</tr>
			</c:forEach>
			<tr><td colspan="3">
				<div id="alert" class="alert alert-success" role="alert" style="display: none;"> Troco </div>			
			</td></tr>
		</tbody>
	</table>	
	<!--fechando divs head -->
	</div>
	</div>
	</div>
	</div>
	
<!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Pagamento</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      
        <p>Total R$ ${total}</p>
        <div class="form-group">
		    <label for="valorInput" id="labelinsiravalor">Insira Valor:</label>
		    <input type="number" class="form-control" id="valorInput" name="valorInput">
		    <label id="labeltroco"></label>
	  </div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <div class="btn-group btn-group-justified" style="width: 100%">
			<a id="din" class="btn btn-default btn-primary" style="color: white; border-right-color: white; border-right-style: solid; border-right-width: 3px;" class="btn btn-default btn-primary" onclick="dinheiro(${total})" >Dinheiro</a>
			<a id="cartao" class="btn btn-default btn-primary" style="color: white; border-right-color: white; border-right-style: solid; border-right-width: 3px;" class="btn btn-default btn-primary" onclick="cartao(${total})">Cartão</a>
			<a id="fecharconta" class="btn btn-default btn-primary" style="color: white;" onclick="fecharconta(${total})" >Encerrar Conta</a>
		</div>
      </div>

    </div>
  </div>
</div>


<!-- Modal parar estornar pedido -->
<div class="modal" tabindex="-1" role="dialog" id="modalestorno">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Menu Estorno</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p id="textopedidoestorno"></p>
        <p id="textoobspedidoestorno"></p>
        <label for="senhagerente" id="labelsenhagerente">Senha Gerente:</label>
        <input type="password" class="form-control" id="senhagerente" name="valorInput">
      </div>
      <div class="modal-footer">      
        <button id="buttonestorno" onclick="" type="button" class="btn btn-primary">Estornar</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
        <br>
        <button id="buttonconfirmarestorno" onclick="" type="button" class="btn btn-primary">Sim, Desejo Realmente Estornar</button>
      </div>
    </div>
  </div>
</div>





<footer class="footer">
	<div class="btn-group btn-group-justified" style="width: 100%">
		<a class="btn btn-default btn-primary" style="color: white; border-right-color: white; border-right-style: solid; border-right-width: 3px;" class="btn btn-default btn-primary" data-toggle="modal" data-target="#myModal">Pagar</a>
		<a style="border-right-color: white; border-right-style: solid; border-right-width: 3px;" class="btn btn-default btn-primary" onclick="imprimirconta()" target="_self"><i style="color: white" class="material-icons">print</i></a>
		<a class="btn btn-default btn-primary" style="color: white" href="/lancarpedido" target="_self">Pedido</a>
	</div>
		<p style="margin-top: 2px; margin-bottom: 1px">${conta.nome_mesa}<br>Total R$ ${total}</p>
		</footer>
	
	
	<script type="text/javascript" src="../../../img/epos-2.9.0.js"></script>
	<script type="text/javascript" src="../../../img/xxx.js"></script>
	<script type="text/javascript">	
	//funcoes sidenavbar
	$(window).on('load',function(){
		var total = parseFloat('${total}'.replace(",", "."));
		if (total * 100 == 0 * 100){
			$("#labeltroco").empty();
			$("#labeltroco").append("Deseja encerrar conta?");
			$('#din').hide();
			$('#cartao').hide();
			$('#labelinsiravalor').hide();			
			$('#valorInput').hide();
			
			
			}
		
		if(total * 100 == 0 * 100 && '${fn:length(pedidos)}' > 0){
				$('#myModal').modal('show');							
			}        
    });
	
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


	function modalestorno(pedidoid, produtoid, qtdpedido, nomeproduto, obspedido, valorvenda){
		if(valorvenda > 0  && !(obspedido == 'Item Estornado')){
			$('#textopedidoestorno').text(qtdpedido + 'x ' + nomeproduto);
			$('#textoobspedidoestorno').text(obspedido.replace(/<br>/g, ""));		
			$("#buttonestorno").attr("onclick","estornar()");
			$("#buttonconfirmarestorno").attr("onclick","confirmarestorno("+pedidoid+", "+qtdpedido+", "+produtoid+", '"+nomeproduto+"', "+valorvenda+")");
			$('#buttonconfirmarestorno').hide();
			$('#senhagerente').hide();
			$('#labelsenhagerente').hide();
			$('#modalestorno').modal('show');
			}
		
		}

	function estornar(){
		$('#buttonestorno').hide();
		$('#labelsenhagerente').show();
		$('#senhagerente').show();
		$('#buttonconfirmarestorno').show();
		}

	function confirmarestorno(pedidoid, qtdpedido, produtoid, nomeproduto, valorvendaa){
		var globalListaPedidos = [];
		var pedido = {id:produtoid, nome:nomeproduto, qtd:qtdpedido*-1, obs:'Item Estornado', valorvenda:valorvendaa};		
		globalListaPedidos.push(pedido);

		var log;
		$.get( "/logarGerente/"+$("#senhagerente").val(), function( data ) {
			if(parseFloat(data) > 0){
				$.ajax({
					type: 'POST',
					dataType: 'json',
					contentType:'application/json',
					url: "/estornarpedido/"+pedidoid,
					data:JSON.stringify(globalListaPedidos),
					success: function(data, textStatus ){
											
					},
					error: function(xhr, textStatus, errorThrown){
					//alert('request failed'+errorThrown);
					}
					});
				}else{
						alert('senha incorreta!!!');
					}
			  			  
			});
		setTimeout(function(){location.reload();}, 500);
		}

		
		
		
		
		
		


	function imprimirconta(){
		var text = '<BOLD><CENTER>${estabelecimento.nomeFantasia}'.toUpperCase()+
		'<BR><CENTER>${estabelecimento.logradouro}, ${estabelecimento.numero}'+
		'<BR><CENTER>${estabelecimento.bairro} - ${estabelecimento.cidade} - ${estabelecimento.uf}'+
		'<BR><CENTER>${estabelecimento.telefone}'+
		'<BR><CENTER>CNPJ:${estabelecimento.cnpj}'+
		'<BR><LINE>'+
		'<BR><CENTER>Recibo Não Fiscal'+
		'<BR><LEFT>     QTD  ITEM         UNIT R$    TOTAL R$ '+
		<c:forEach var="pedido" items="${pedidos}" varStatus="loop">
		'<BR><LEFT>${pedido.qtd}  ;;${fn:substring(pedido.produto.nome, 0, 12)}'.padEnd(12, '_')+'  ;;${pedido.valorVenda}  ;;${pedido.valorVenda * pedido.qtd}'+
		</c:forEach>
		'<BR><BR><CENTER><BOLD>TOTAL: R$ ${total}'
		
		
		
		<c:choose>
			<c:when test="${conta.delivery > 0}">
				+'<BR><BR><LINE>Delivery:'+
				'<BR>Nome: ${conta.nome_mesa}'+
				'<BR>Telefone: ${conta.telefone}'+
				'<BR>${conta.endereco.logradouro}, ${conta.endereco.numero}'
			
				<c:choose>	
					<c:when test="${conta.endereco.complemento.length()>0}">
						+'<BR>${conta.endereco.complemento}'
					</c:when>
				</c:choose>
							
				+'<BR>${conta.endereco.bairro} - ${conta.endereco.cidade} - ${conta.endereco.uf}'
				
				<c:choose>
					<c:when test="${conta.endereco.cep.length()>0}">
						+'<BR>${conta.endereco.cep}'
					</c:when>
				</c:choose>

				<c:choose>
					<c:when test="${conta.endereco.referencia.length()>0}">
					+'<BR>${conta.endereco.referencia}'
					</c:when>
				</c:choose>

			</c:when>
		</c:choose>
		+'<BR><CENTER>DG Sistemas (81)99939-3017 <CUT>'		
		;				
	    var textEncoded = encodeURI(text);
	    //var isChrome = /Chrome/.test(navigator.userAgent) && /Google Inc/.test(navigator.vendor);	     
	    //alert(navigator.appVersion);
	    
	    if(navigator.appVersion=='webview'){
	    	//window.location.href="quickprinter://"+textEncoded;
	    	window.location.href="intent://"+textEncoded+"#Intent;scheme=quickprinter;package=pe.diegoveloper.printerserverapp;end;";
		    }else{
		    	window.location.href="intent://"+textEncoded+"#Intent;scheme=quickprinter;package=pe.diegoveloper.printerserverapp;end;";
			    }
	    
		}

		
	
		
	
	
	
	
	function time() {
		  var d = new Date();
		  var n = d.toLocaleTimeString();
		  return n;
		}
	
	
	function dataAtualFormatada(){
	    var data = new Date();
	        dia  = data.getDate().toString();
	        if(dia.length == 0){ dia = '00'}
			if(dia.length == 1){ dia = '0' + dia; };	        
	        mes  = (data.getMonth()+1).toString(); //+1 pois no getMonth Janeiro começa com zero.
	        if(mes.length == 1){ mes = '0' + mes; };
	        ano = data.getFullYear();
	    return ""+dia+"/"+mes+"/"+ano;
	}
		
	$('#myModal').on('hide', function() {alert('close modal');});
		


function limparmodal(){$("#valorInput").val('');$("#labeltroco").empty();}
	

	function dinheiro(){
		var total = parseFloat('${total}'.replace(",", "."));
		/* $.get('/checkconnectionn').then(function(result){alert(result);},function (jqXHR,textStatus,errorThrown ){alert('jqXHR: '+ jqXHR + 'textStatus: '+textStatus+' errorThrown: '+errorThrown);}); */

				if($("#valorInput").val() == ''){
					$("#labeltroco").empty();
					$("#labeltroco").append("Valor não informado!");
				}else{
						var valorInput = parseFloat($("#valorInput").val());
						if(valorInput < 0.50 || valorInput.length == 0 || valorInput.length == 'undefined' || valorInput == ''){
							$("#labeltroco").empty();
							$("#labeltroco").append("Valor não permitido!");
						}
						if(valorInput > 0.49 && valorInput <= total)	{
							$.post( "/lancardinheiro/"+valorInput.toFixed(2)+0.01);
							setTimeout(function(){location.reload();}, 300);
						}						
						 if( valorInput > total){
									var troco = parseFloat(valorInput.toFixed(2)) - parseFloat(total.toFixed(2));
									$("#labelinsiravalor").empty();
									$("#labelinsiravalor").append('Valor Pago: R$ '+valorInput);									
									$("#labeltroco").empty();
									$("#labeltroco").css("font-size", "20px");
									$("#labeltroco").append('Troco R$' +troco+ ' <br> <a class="btn btn-default btn-primary" style="color: white" onclick="refresh()" target="_self"> Atualizar Conta</a>');
									$('#din').hide();
									$('#cartao').hide();
									$('#fecharconta').hide();
									
									$("#alert").show();
									$("#alert").empty();
									$("#alert").append('Troco R$ '+troco);
									//$("#valorInput").remove();
									$.post( "/lancardinheiro/"+total.toFixed(2)+0.01);
									}									
						
					}
		}
				

		
	function refresh(){location.reload();}

	function cartao(total){
		if($("#valorInput").val() == ''){
			$("#labeltroco").empty();
			$("#labeltroco").append("Valor não informado!");		
			}else{
				var valor = parseFloat($("#valorInput").val());
				if(valor < 0.50 || valor.length == 0 || valor.length == 'undefined' || valor == ''){
					$("#labeltroco").empty();
					$("#labeltroco").append("Valor não permitido!");
					}else if(valor > total){
						$("#labeltroco").empty();
						$("#labeltroco").append("valor maior que total!");
							}else{
							$.post( "/lancarcartao/"+valor.toFixed(2)+0.01);
							setTimeout(function(){location.reload();}, 300);
				}		
	
		}
	}
	
	
	function fecharconta(total){					
		if(total > 0){
			$("#labeltroco").empty();
			$("#labeltroco").append("O total precisa ser R$ 0 para a conta ser encerrada!");
			} else {
				$.post( "/fecharcontapaga");
				$("#labeltroco").empty(); 
				$("#labeltroco").append("Conta encerrada!");
				$("#alert").show();
				$("#alert").empty();
				$("#alert").append("Conta Encerrada!");
				setTimeout(function(){window.location.href = "/mainpage";}, 500);
				}
		}
	</script>
	
	
	
</body>
</html>