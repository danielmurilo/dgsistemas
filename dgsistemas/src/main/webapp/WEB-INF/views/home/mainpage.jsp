<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>

			<input type="hidden" class="form-control" type="text" name="inputHiddenFuncionarioID" value="${funcionarioid}">
				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">Conta</th>
								<th scope="col">Nome/Mesa</th>
								<th scope="col">Total</th>
								<th scope="col"></th>
								<th scope="col"></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="conta" items="${contas}" varStatus="loop">
								<tr onclick="window.location='/conta/${conta.id}';">
									<th scope="row">${conta.id}</th>
									<td>${conta.nome_mesa}</td>
									<td>${conta.total}</td>
									<td><c:choose>
										<c:when test="${conta.delivery == 1}"><i class="material-icons">motorcycle</i></c:when>
										<c:otherwise></c:otherwise>
										</c:choose>
									</td>									
								</tr>
							</c:forEach>
							<tr>
							<td colspan="5"><div>
									<a class="btn btn-primary btn-block" href="/abrirconta" target="_self">Abrir Conta</a>
								</div></td>
								</tr>
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