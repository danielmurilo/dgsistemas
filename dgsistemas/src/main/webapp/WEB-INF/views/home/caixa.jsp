<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>


<%Integer funcionarioid = (Integer) session.getAttribute("funcionarioid");
			if (funcionarioid.equals(0)||funcionarioid==null) {out.print("login necessário");response.sendRedirect("/");} else {}%>


			<table  style="width: 100%"  border="0">
		      <tbody>
		        <tr>
			        <td colspan="4">Selecione Funcionário e Data:</td>
		        </tr>
		        <tr>
		          <td colspan="4">
		          	<form action="/exibirCaixa/0/inputCaixaDate/" id="formCaixa">
          		   <div class="input-group mb-3">
          		   <div class="input-group-prepend">
          		   		<div class="dropdown" >
							<button class="btn btn-primary dropdown-toggle" type="button" id="buttonDropDown" data-toggle="dropdown" value="Todos" aria-expanded="false">
							 	Todos	
							 </button>
							 <div class="dropdown-menu" aria-labelledby="dropdownMenu2">
							 	<button class="dropdown-item" type="button" onclick="setarFuncionario(0, 'Todos')" value="Todos">Todos</button>
									<div class="dropdown-divider"></div>
								<c:forEach var="funcionario" items="${funcionarios}" varStatus="loop">
									<button class="dropdown-item" type="button" value="${funcionario.login}" onclick="setarFuncionario(${funcionario.id}, '${funcionario.login}')">${funcionario.login}</button>
									<div class="dropdown-divider"></div>
								</c:forEach>							 
							 </div>								
						</div>				
          		   </div>
					  <input type="date" class="form-control" placeholder="Data" aria-label="Data" aria-describedby="basic-addon2" name="inputCaixaDate" required>
					  <div class="input-group-append">
					    <button class="btn btn-primary" type="submit">Enviar</button>
					  </div>
					</div>
				   </form>				   					
		          </td>		    
				</tr>
			<tr><td colspan="4">Recebimentos:</td></tr>
		    <tr>			
			<td>Dinheiro: <br>R$ <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${valortotalemdinheiro * -1}" /></td>			
		    <td>Cartão: <br>R$ <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${valortotalemcartao * -1}" /></td>
		    <td>Total: <br>R$ <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${(valortotalemdinheiro + valortotalemcartao)*-1}" /></td>
		    <td><a id="printButton" class="btn btn-default btn-primary" onclick="imprimircaixa()"><i style="color: white" class="material-icons">print</i></a></td>
		    </tr>
		      </tbody>
		    </table>
		    
		    
		    
		    
			
			<div class="table-responsive">
		  <table class="table table-striped">
		  <thead>	
		  </thead>
		  
		  <tbody>
		    <tr>
		      <td scope="col">Conta</td>
		      <td scope="col">Nome/Mesa</td>
		      <td scope="col">Valor</td>
		      <td scope="col">Forma</td>
		      <td scope="col">Hora</td>		      
		      <td scope="col">Funcionario</td>
		      <td scope="col">Status</td>
		    </tr>
		 			<c:forEach var="pedido" items="${pedidos}" varStatus="loop">
							<tr>
								<th>${pedido.conta.id}</th>
								<td>${pedido.conta.nome_mesa}</td>
								<td>${pedido.valorVenda}</td>
								
								<c:choose>
									<c:when test="${pedido.produto.id==1}">
										<td>Dinheiro</td>
									</c:when>
									<c:when test="${pedido.produto.id==2}">
										<td>Cartão</td>
									</c:when>
								</c:choose>
								
								<td><fmt:formatDate value="${pedido.data}" pattern="HH:mm:ss"/></td>								
								<td>${pedido.conta.funcionarioAbertura.nome}</td>
								<c:choose>
									<c:when test="${pedido.conta.status>0}">
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
		</div>
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

		function setarFuncionario(id, login){
			$("#buttonDropDown").html(login);
			$('#formCaixa').attr('action', '/exibirCaixa/'+id+'/{inputCaixaDate}');				
			}
		
		window.onload = function(){
			$("#printButton").hide();
			 if ("${fn:length(pedidos)}" > 0){
				 $("#printButton").show();
				 }
			}


		function imprimircaixa(){
			var text = '<BOLD>${estabelecimento.nomeFantasia}'.toUpperCase() + '<BR>'+
			'Borderô de Caixa <fmt:formatDate value="${dataCaixa}" pattern="dd/MM/yyyy"/>'+
			'<BR><LINE>'+
			'<BR>RECEBIMENTOS:'+
			'<BR>Dinheiro: R$ <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${valortotalemdinheiro * -1}" /> <BR>Cartões: R$ <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${valortotalemcartao * -1}" /> <BR><BOLD>Total: R$ <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${(valortotalemdinheiro + valortotalemcartao)*-1}" />'+
			'<BR>'+
			'<BR>VALOR ;;FORMA ;;HORARIO ;;FUNCIONÁRIO <BR>'+
			<c:forEach var="pedido" items="${pedidos}" varStatus="loop">
				'${pedido.valorVenda} '+						
				'<c:choose><c:when test="${pedido.produto.id==1}"> ;;Dinheiro</c:when><c:when test="${pedido.produto.id==2}"> ;;Cartão</c:when></c:choose> '+
				' ;;<fmt:formatDate value="${pedido.data}" pattern="HH:mm"/> '+	
				' ;;${fn:substring(pedido.conta.funcionarioAbertura.nome,0,6)}<BR>'+	    
			</c:forEach>
			'<CUT>';			
			var textEncoded = encodeURI(text);
		    window.location.href="intent://"+textEncoded+"#Intent;scheme=quickprinter;package=pe.diegoveloper.printerserverapp;end;";
			}


		function imprimircaixaold(){
			var p = window.open('', '', 'left=0,top=0,width=80mm,toolbar=0,scrollbars=0,status=0');
		    p.document.write(
				    '<html><style>@page { size: auto;  margin: 1mm; }</style>'+
				    '<style>@media print{.noprint{display:none;}}</style>'+
				    '<body onload=\"window.print();\">'+
				    '<section class="sheet">'+
				    '<center>'+
				    '${estabelecimento.nomeFantasia}'.toUpperCase() + '<br>'+
                    'Borderô de Caixa Data: <fmt:formatDate value="${dataCaixa}" pattern="dd/MM/yyyy"/>'+
                    '<br>'+
                    '----------------------------------------------------'+
                    '<br></center>'+
					'<table>'+
					'<thead>Recebimentos: </thead>'+
                    '<tbody>'+
                    '<tr><td colspan="2">Dinheiro:<br>R$ ${valortotalemdinheiro * -1}</td>'+
                    '<td colspan="2">Cartões: <br>R$ ${valortotalemcartao * -1}</td>'+
                    '<td colspan="2">Total: <br>R$ ${(valortotalemdinheiro + valortotalemcartao)*-1}</td> </tr><br>'+
                    '<tr><td colspan="6">'+
                    '--------------------------------------------------'+
                    '<td></tr>'+                    
                    '<tr><td>Conta</td><td>Valor</td><td>Forma</td><td>Hora</td><td>Funcion.</td></tr>'+                    
                    '<c:forEach var="pedido" items="${pedidos}" varStatus="loop">'+
					'<tr>'+
						'<td>${pedido.conta.id}</td>'+
						'<td>${pedido.valorVenda}</td>'+						
						'<c:choose><c:when test="${pedido.produto.id==1}"><td>Dinh</td></c:when><c:when test="${pedido.produto.id==2}"><td>Cartão</td></c:when></c:choose><td><fmt:formatDate value="${pedido.data}" pattern="HH:mm"/></td>'+	
						'<td>${fn:substring(pedido.conta.funcionarioAbertura.nome,0,6)}</td>'+						    
					'</tr>'+
				'</c:forEach>'+		    
                    
                    '</tbody>'+                    
                    '</table>'+
                    '<br>Impresso em: '+dataAtualFormatada().substring()+' &nbsp;'+time()+
                    '<br>Pedidos e pagamentos lançados até às 3h terão horário 23:59h.'+
                    '<center><button class=\"noprint\" onclick=\"window.print()\" style=\"font-size : 50px; width: 100%; height:120px; bottom:140px;\">Imprimir Novamente</button><br><br>'+
					'<button class=\"noprint\" onclick=\"window.close()\" style=\"font-size : 50px; width: 100%; height:120px; bottom:10px;\">Fechar Impressão</button></center>'+
                    '</body>'+
                    '</html>');
		    p.document.close();

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

	</script>
</html>