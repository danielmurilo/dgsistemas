<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>

						
					<form action="/salvarcompra" method="post">
					  <div class="form-group">
					    <input type="hidden" class="form-control" id="id" name="id">
					  </div>
					  <div class="form-group">
					  	<select class="custom-select" style="height: 40px" id="selectingredientes" name="selectingredientes" required>
							<option value="" selected>Escolha Ingrediente</option>
							<c:forEach var="ingrediente" items="${ingredientes}" varStatus="loop">
								<option  value="${ingrediente.id}">${ingrediente.nome}</option>
							</c:forEach>
						</select>					  
					  </div>					  
					  <div class="form-group">
					    <label for="inputqtd">Quantidade:</label>
					    <input type="number" class="form-control" id="inputqtd" required="required" name="inputqtd" >
					  </div>
					  <div class="form-group">
					    <label for="inputvalor">Valor R$:</label>
					    <input type="number" class="form-control" id="inputvalor" required="required" name="inputvalor">
					  </div>							  				  						  
					  <button type="submit" class="btn btn-primary btn-block">Salvar</button>
					</form>
					
					<div class="table-responsive" style="margin-top: 40px;">
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">Ingrediente</th>
								<th scope="col">qtd</th>
								<th scope="col">Data</th>
								<th scope="col">Valor</th>
								<th scope="col">Funcionario</th>							
							</tr>
						</thead>
						<tbody>
							<c:forEach var="compra" items="${compras}" varStatus="loop">
								<tr>
									<td>${compra.ingrediente.nome}</td>
									<td>${compra.qtd}</td>
									<td><fmt:formatDate value="${compra.date}" pattern="dd/MM/yyyy" /></td>
									<td>${compra.valor}</td>
									<td>${compra.funcionario.nome }</td>								
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
		
	</script>
</body>
</html>