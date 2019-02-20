<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>


<%Integer funcionarioid = (Integer) session.getAttribute("funcionarioid");
			if (funcionarioid.equals(0)||funcionarioid==null) {out.print("login necessário");response.sendRedirect("/");} else {}%>
				
				
						<div class="col-md-12 jumbotron" style="padding: 10px;">
							<select class="custom-select" style="height: 40px" id="selectcategorias">
								<option value="0" selected>Escolha uma Categoria</option>
								<c:forEach var="categoria" items="${categorias}" varStatus="loop">
									<option  value="${categoria.id}" onclick="findcategoria(${categoria.id})">${categoria.nome}</option>
								</c:forEach>
							</select>
						</div>						
						<form action="/salvarcategoria" method="post">
							  <div class="form-group">
							    <input type="hidden" class="form-control" id="id" name="id">
							  </div>
							  <div class="form-group">
							    <label for="inputnome">Nome:</label>
							    <input type="text" class="form-control" id="inputnome" name="inputnome">
							  </div>
							  <div class="form-group">
								  	<div class="custom-control custom-switch">
								  		<input type="checkbox" class="custom-control-input" id="checkativo" name="checkativo">
										<label class="custom-control-label" for="checkativo">Ativo</label>										
									</div>
								</div>
								<div class="form-group">
									<div class="custom-control custom-switch">										 
										<input type="checkbox" class="custom-control-input"	id="checkembalagem" name="checkembalagem">
										<label class="custom-control-label" for="checkembalagem">Cobra Embalagem</label>
									</div>
								</div>					  						  
							  <button type="submit" class="btn btn-primary btn-block">Salvar</button>
							</form>

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

	$( "#selectcategorias" ).change(function() {
		if(this.value==='0'){
			limparcampos();
			}else{
				 $.get("/findcategoria/",{id: this.value} ,function(json) {
					  $("#id").val(""+json.id+"");
						$("#inputnome").val(""+json.nome+"");
						if(json.status === 1){
							$('#checkativo').prop('checked', true);
							}else{
								$('#checkativo').prop('checked', false);
								}
						if(json.cobraEmbalagem === 1){
							$('#checkembalagem').prop('checked', true);
							}else{
								$('#checkembalagem').prop('checked', false);
								}
					
				  });
						
				}
		 
		});
			

	function limparcampos(){
		$("#id").val("");
		$("#inputnome").val("");
		$('#checkativo').prop('checked', false);
		$('#checkembalagem').prop('checked', false);		
	}
</script>
</html>