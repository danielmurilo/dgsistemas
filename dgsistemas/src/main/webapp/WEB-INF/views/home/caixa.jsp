<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>


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
			$("#buttonDropDown").val(login);
			$('#formCaixa').attr('action', '/exibirCaixa/'+id+'/{inputCaixaDate}');				
			}
	</script>
</html>