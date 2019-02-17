<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>
				
				
					<div class="col-md-12 jumbotron" style="padding: 10px;">
						<select class="custom-select" style="height: 40px" id="selectcategorias">
							<option value="0" selected>Escolha Categoria</option>
							<c:forEach var="categoria" items="${categorias}" varStatus="loop">
								<option  value="${categoria.id}">${categoria.nome}</option>
							</c:forEach>
						</select>
						<br><br>
						<select class="custom-select" style="height: 40px" id="selectprodutos">
							<option value="0" selected>^^^^^^</option>							
						</select>
					</div>
					
					<form action="/salvarproduto" method="post" enctype="multipart/form-data">
							  <div class="form-group">
							    <input type="hidden" class="form-control" id="id" name="id">
							  </div>
							  <div class="form-group">
							    <label for="inputnome">Nome:</label>
							    <input type="text" class="form-control" id="inputnome" name="inputnome">
							  </div>
							    <div class="form-group">
							  <div class="custom-file">
							    <input type="file" class="custom-file-input" id="inputfoto" name="inputfoto">
    							<label class="custom-file-label" for="inputfoto">Foto do Produto</label>
							  </div>
							  </div>
							  <div class="form-group">
							    <label for="inputdescricao">Descrição:</label>
							    <textarea  rows="3" class="form-control" id="inputdescricao" name="inputdescricao"></textarea>
							  </div>
							  <div class="form-group">
							    <label for="inputpreco">Preco:</label>
							    <input type="number" class="form-control" id="inputpreco" name="inputpreco">
							  </div>
							  <div class="form-group">
							  	<div class="custom-control custom-switch">
							  		<input type="checkbox" class="custom-control-input" id="checkativo" name="checkativo">
									<label class="custom-control-label" for="checkativo">Ativo</label>										
								</div>
							  </div>
							  <div class="form-group">
							    <label for="">Foto:</label>
							    <img id="imgproduto" alt="" height="75px"	width="100px" class="rounded" src="https://bigriverequipment.com/wp-content/uploads/2017/10/no-photo-available.png">
							  </div>											  						  
							  <button type="submit" class="btn btn-primary btn-block">Salvar</button>
							</form>
							
							
							
							<br><h6> Receita:</h6>
							<table class="table">
							    <thead>
							      <tr>
							        <th>Ingredientes</th>
							        <th>Qtd</th>
							        <th></th>
							        <th></th>
							      </tr>
							    </thead>
							    <tbody id="tablebody">
							      			      
							    </tbody>
							  </table>
							  <div class="input-group mb-3">
								  <div class="input-group-prepend">
								    <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Escolha Ingrediente</button>
								    <div class="dropdown-menu" id="dropdowningredientes">
								      
								    </div>
								  </div>
								  <input type="number" class="form-control" placeholder="Qtd" id="inputqtd">
								  <button class="btn btn-primary" onclick="salvaringrediente()">Salvar</button>
								  <br>
								  <div class="alert alert-danger" id="alert">
								  <button type="button" class="close" data-dismiss="alert">×</button>
								    <strong>!!!</strong> É preciso inserir quantidade e selecionar ingrediente!
								  </div>
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
		

var idproduto;
var idingrediente;
$( "#selectcategorias" ).change(function() {
	if(this.value==='0'){
		limparcampos();
		}else{
			idcategoria = this.value;
			 $.get("/listarProdutosPorCategoriaTodos/"+this.value, function(json) {  
					$("#selectprodutos").empty();
					$("#selectprodutos").append('<option value="0" selected>Inserir Produto</option>');
					$.each(json, function(id, produto) {
						$("#selectprodutos").append('<option value="'+produto.id+'"> '+produto.nome+'</option>');
					});
				});					
			};
	
});

$( "#selectprodutos" ).change(function() {
	if(this.value===0){		
		limparcampos();
		}else{
			idproduto = this.value;
			$.get("/findProduto/"+this.value, function(json) {
				$("#id").val(json.id);
				$("#inputnome").val(json.nome);
				$("#inputdescricao").val(json.descricao);
				$("#inputpreco").val(json.preco);
				if(json.status === 1){$('#checkativo').prop('checked', true);}else{	$('#checkativo').prop('checked', false);};
				if(json.imgTO64 == undefined){
					$("#imgproduto").attr("src","https://bigriverequipment.com/wp-content/uploads/2017/10/no-photo-available.png");
					}else{
						$("#imgproduto").attr("src","data:image/jpg;base64, "+ json.imgTO64);
						}				
			});
			findreceitas(this.value);
			};
	
});

function findreceitas(id){
	$("#tablebody").empty();
	$.get("/findreceitasporproduto/"+id, function(json) {		
		$.each(json, function(i, receita) {
			$("#tablebody").append('<tr>');
			$("#tablebody").append('<td>'+receita.ingrediente.nome+'</td>');
			$("#tablebody").append('<td>'+receita.qtd+'</td>');
			$("#tablebody").append('<td>'+receita.ingrediente.unidade+'</td>');
			$("#tablebody").append('<td onclick="deletarreceita('+receita.id+')"><i class="material-icons">delete</i></td>');
			$("#tablebody").append('</tr>');
		});			
		});
	$.get("/findingredientes/", function(json) {
		$("#dropdowningredientes").empty();
		$.each(json, function(i, ingrediente) {
			$("#dropdowningredientes").append('<a class="dropdown-item" onclick="selecionaringrediente('+ingrediente.id+')">'+ingrediente.nome+'</a>');
			$("#dropdowningredientes").append('<div role="separator" class="dropdown-divider"></div>');			
			
			});
		
		});
}
function selecionaringrediente (id){
	idingrediente = id;
}
function salvaringrediente(){
	var qtdd = $("#inputqtd").val();
	if(qtdd>0){
		if(idproduto>0){
			if(idingrediente>0){
				$.post("salvarreceita", {idp: idproduto, i: idingrediente, qtd: qtdd});
				$("#inputqtd").val('');
				setTimeout(function(){ findreceitas(idproduto); }, 300);
				
				}

			}

		}
	
	
}

function deletarreceita(id){
	$.ajax({
	    url: 'deletereceita/'+id,
	    type: 'DELETE',
	    success: function(result) {
	        // Do something with the result
	    }
	});
	$("#inputqtd").val('');
	setTimeout(function(){ findreceitas(idproduto); }, 300);
}

function limparcampos(){
	$("#selectprodutos").empty();
	idingrediente = 0;
	idproduto = 0;
}


</script>
</html>