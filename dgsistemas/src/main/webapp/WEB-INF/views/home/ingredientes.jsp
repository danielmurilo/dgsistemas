<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>


<%Integer funcionarioid = (Integer) session.getAttribute("funcionarioid");
			if (funcionarioid.equals(0)||funcionarioid==null) {out.print("login necessário");response.sendRedirect("/");} else {}%>
				
					<div class="form-group jumbotron" style="padding: 10px;">
		              <label for="selectingredientes">Ingrediente:</label>
		              <select class="form-control" id="selectingredientes">
		              <option value="0"> Incluir</option>
		              <c:forEach var="ingrediente" items="${ingredientes}" varStatus="loop">
		              	<option value="${ingrediente.id}">${ingrediente.nome}</option>
		              </c:forEach>
		              </select>
            		</div>
            		
            		
    				<form action="/salvaringrediente" method="post">
					  <div class="form-group">
					    <input type="hidden" class="form-control" id="id" name="id">
					  </div>
					  <div class="form-group">
					    <label for="inputnome">Nome:</label>
					    <input type="text" class="form-control" id="inputnome" name="inputnome">
					  </div>
					  <div class="form-group">
					    <label for="inputestoque">Estoque:</label>
					    <input type="number" class="form-control" id="inputestoque" placeholder="Digite Apenas Números" name="inputestoque" disabled>
					  </div>
					  <div class="form-group">
					    <label for="inputunidade">Unidade de Medida:</label>
					    <input type="text" class="form-control" id="inputunidade" placeholder="Ex. Gramas, fatias, unidades" name="inputunidade">
					  </div>									 					  						  
					  <button type="submit" class="btn btn-primary btn-block">Salvar</button>
				   
					<!-- fechando divs header -->
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
		

$( "#selectingredientes" ).change(function() {
	if(this.value==='0'){
		limparcampos();
		}else{
			$.get("/findingrediente",{id: this.value} ,function(json) {
				$("#id").val(""+json.id+"");
				$("#inputnome").val(""+json.nome+"");
				$("#inputestoque").val(""+json.estoque+"");
				$("#inputunidade").val(""+json.unidade+"");				
				});

			};
	
});
function limparcampos(){
	$("#id").val("");
	$("#inputnome").val("");
	$("#inputestoque").val("");
	$("#inputunidade").val("");
}

</script>
</html>