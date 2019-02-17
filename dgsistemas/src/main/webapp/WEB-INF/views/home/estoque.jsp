<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>


				<div class="table-responsive">
					<table class="table table-striped">
					  <tr>
					  	<th>Id</th>					  	
					    <th>Ingrediente</th>
					    <th>Quantidade</th>
					    <th>Unidade</th>
					  </tr>				  
					  <c:forEach var="ingrediente" items="${ingredientes}" varStatus="loop">
						<tr>
							<th>${ingrediente.id}</th>
							<td>${ingrediente.nome}</td>							
							<c:choose>
								<c:when test="${ingrediente.estoque < 1}">
									<td style="color: red;">${ingrediente.estoque}</td>								
								</c:when>
								<c:otherwise>
									<td>${ingrediente.estoque}</td>
								</c:otherwise>
							</c:choose>							
							<td>${ingrediente.unidade}</td>									
						</tr>
					 </c:forEach>
					</table>
				</div>

					
				<!--fechando divs header -->
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