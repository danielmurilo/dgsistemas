<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>


<%Integer funcionarioid = (Integer) session.getAttribute("funcionarioid");
			if (funcionarioid.equals(0)||funcionarioid==null) {out.print("login necessário");response.sendRedirect("/");} else {}%>
				
				
					<div class="form-group jumbotron" style="padding: 10px;">
		              <label for="selectfuncionarios">Funcionario:</label>
		              <select class="form-control" id="selectfuncionarios">
		              <option value="0"> Incluir</option>
		              <c:forEach var="funcionario" items="${funcionarios}" varStatus="loop">
		              	<option value="${funcionario.id}">${funcionario.nome}</option>
		              </c:forEach>
		              </select>
		             </div>
					
						<form action="/salvarfuncionario" method="post">
							  <div class="form-group">
							    <input type="hidden" class="form-control" id="id" name="id">
							  </div>
							  <div class="form-group">
							    <label for="inputnome">Nome:</label>
							    <input type="text" class="form-control" id="inputnome" name="inputnome">
							  </div>
							  <div class="form-group">
							    <label for="inputlogin">Login:</label>
							    <input type="text" class="form-control" id="inputlogin" name="inputlogin">
							  </div>
							  <div class="form-group">
							    <label for="inputsenha">Senha:</label>
							    <input type="password" class="form-control" id="inputsenha" name="inputsenha">
							  </div>
							  <div class="form-group">
							    <label for="inputemail">E-mail:</label>
							    <input type="email" class="form-control" id="inputemail" name="inputemail">
							  </div>
							  <div class="form-group">
							    <label for="inputtelefone">Telefone:</label>
							    <input type="tel" class="form-control" id="inputtelefone" name="inputtelefone">
							  </div>
							  <div class="form-group">
							    <label for="inputaniversario">Aniversário:</label>
							    <input type="date" class="form-control" id="inputaniversario" name="inputaniversario">
							  </div>
							  <div class="form-group">
							    <label for="inputdataadmissao">Data Admissão:</label>
							    <input type="date" class="form-control" id="inputdataadmissao" name="inputdataadmissao">
							  </div>						  
							  <div class="form-group">
								  	<div class="custom-control custom-switch">
								  		<input type="checkbox" class="custom-control-input" id="checkgerente" name="checkgerente">
										<label class="custom-control-label" for="checkgerente">Gerente</label>										
									</div>
								</div>
								<div class="form-group">
							    <input type="hidden" class="form-control" id="inputrole" name="inputrole">
							  	</div>
							  	<div class="form-group">
								  	<div class="custom-control custom-switch">
								  		<input type="checkbox" class="custom-control-input" id="checkativo" name="checkativo">
										<label class="custom-control-label" for="checkativo">Ativo:</label>										
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
		

$( "#selectfuncionarios" ).change(function() {
	if(this.value==='0'){
		limparcampos();
		}else{
			 $.get("/findfuncionario",{id: this.value} ,function(json) {
				 $("#id").val(""+json.id+"");
				 $("#inputnome").val(""+json.nome+"");
				 $("#inputlogin").val(""+json.login+"");
				 $("#inputsenha").val(""+json.senha+"");
				 $("#inputemail").val(""+json.email+"");
				 $("#inputtelefone").val(""+json.telefone+"");				 
				 var formattedDate = new Date(json.dataAdmissao);
				 $("#inputdataadmissao").val(formattedDate.toISOString().substring(0, 10));
				 formattedDate = new Date(json.aniversario);				 
				 $("#inputaniversario").val(formattedDate.toISOString().substring(0, 10));				 
				 $("#inputrole").val(""+json.role+"");
				 if(json.admin === 1){ $('#checkgerente').prop('checked', true); }else{ $('#checkgerente').prop('checked', false); };
				if(json.status === 1){ $('#checkativo').prop('checked', true); }else{$('#checkativo').prop('checked', flase); };
							
			  });
					
			}
	 
	});

$("#checkgerente").change(function(){
	if($('#checkgerente').is(":checked")){
		$("#inputrole").val("'ADMIN'");
		}else{
			$("#inputrole").val("GARCOM");
			}
	
});
		

function limparcampos(){
	$("#id").val("");
	$("#inputnome").val("");
	$("#inputlogin").val("");
	$("#inputsenha").val("");
	$("#inputemail").val("");
	$("#inputtelefone").val("");
	$("#inputaniversario").val("");
	$("#inputdataadmissao").val("");
	$("#inputrole").val("");
	$('#checkgerente').prop('checked', false);
	$('#checkativo').prop('checked', false);		
}

</script>
</html>