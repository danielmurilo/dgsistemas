<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>


<%Integer funcionarioid = (Integer) session.getAttribute("funcionarioid");
			if (funcionarioid.equals(0)||funcionarioid==null) {out.print("login necessário");response.sendRedirect("/");} else {}%>
			
			<form action="/buscarprodutosmaisvendidos/inputCaixaDate1/inputCaixaDate2" id="formCaixa">
			Selecione Período Produtos Mais Vendidos
   		   	<div class="input-group mb-3">
   		   	<div class="input-group-prepend">
			<input style="width: 125px;" type="date" class="form-control" placeholder="Data" aria-label="Data" aria-describedby="basic-addon2" name="inputCaixaDate1" required>
			<input style="width: 125px;" type="date" class="form-control" placeholder="Data" aria-label="Data" aria-describedby="basic-addon2" name="inputCaixaDate2" required>
			</div>			
			<div class="input-group-append">
			<button class="btn btn-primary" type="submit">ok!</button>
			</div>
			</div>
			</form>
          
          	<div class="table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">Produto</th>
								<th scope="col">Vendas</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="produto" items="${produtos}" varStatus="loop">
								<tr>
									<th>${produto[0]}</th>
									<td>${produto[1]}</td>
																
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