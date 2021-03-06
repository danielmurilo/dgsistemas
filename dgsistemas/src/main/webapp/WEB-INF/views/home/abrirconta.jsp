<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<jsp:include page="header.jsp"/>


<%Integer funcionarioid = (Integer) session.getAttribute("funcionarioid");
			if (funcionarioid.equals(0)||funcionarioid==null) {out.print("login necessário");response.sendRedirect("/");} else {}%>


		<form role="form" action="/abrirconta/salvarconta" method="post" id="form1">
			<div class="form-group">
				<label class="control-label" for="inputNomeMesa">Nome/Mesa</label>
				<input class="form-control" id="nome_mesa" type="text"	placeholder="Digite o nome do cliente ou nº da mesa"	required  name="nome_mesa">
				<br>
				<input style="padding-left: 50px" type="checkbox" class="form-check-input" id="deliverycheck" name="deliverycheck">
				<label class="form-check-label" for="deliverycheck">Delivery</label>
				
				<div id="endereco" style="display: none;">
				
					<label class="control-label" for="telefone">Telefone</label>
					<input class="form-control" id="telefone" type="tel"	name="telefone">
					
					<label class="control-label" for="cep">Cep</label>
					<input class="form-control" id="cep" type="text" placeholder="(Opcional)" name="cep">
					
					<label class="control-label" for="rua">Logradouro</label>
					<input class="form-control" id="logradouro" type="text"	placeholder="Rua, Av." name="logradouro">
					
					<label class="control-label" for="numero">Numero</label>
					<input class="form-control" id="numero" type="number"	placeholder="" name="numero">
					
					<label class="control-label" for="complemento">Complemento</label>
					<input class="form-control" id="complemento" type="text"	placeholder="Apto:" name="complemento">
					
					<label class="control-label" for="referencia">Referência</label>
					<input class="form-control" id="referencia" type="text"	placeholder="Após o colegio Santos Dumont" name="referencia">
					
					<label class="control-label" for="bairro">Bairro</label>
					<input class="form-control" id="bairro" type="text"	value="Boa Viagem" name="bairro">
					
					<label class="control-label" for="cidade">Cidade</label>
					<input class="form-control" id="cidade" type="text"	value="Recife" name="cidade">
					
					<label class="control-label" for="uf">UF</label>
					<input class="form-control" id="uf" type="text"	value="PE" name="uf">
				</div>				
			</div>
			<button type="submit" target="_self" class="btn btn-primary btn-block">Salvar</button>
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

	$('#deliverycheck').change(function() {
        if(this.checked) {
        	$("#endereco").show();
        	$("#footer").hide();
        }else{
        	$("#endereco").hide();
        	$("#footer").show();
            }
    });
	</script>
</body>
</html>