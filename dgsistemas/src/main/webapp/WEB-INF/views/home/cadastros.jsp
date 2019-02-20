<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp"/>


<%Integer funcionarioid = (Integer) session.getAttribute("funcionarioid");
			if (funcionarioid.equals(0)||funcionarioid==null) {out.print("login necessário");response.sendRedirect("/");} else {}%>

            <div class="form-group jumbotron" style="padding: 10px;">
              <label for="sel1">Estabelecimento:</label>
              <select class="form-control" id="sel1">
              <option></option>
                <option>${estabelecimento.nomeFantasia}</option>
              </select>
            </div>
            <form role="form" method="post" action="salvarestabelecimento" enctype="multipart/form-data" id="formestabelecimento">
              <div class="form-group has-feedback">
                <input class="form-control" id="idInput" placeholder="" type="hidden" value="${estabelecimento.id}" name="id">
              </div>
              <div class="form-group">
                <label class="control-label" for="nomefantasiainput">Nome Fantasia</label>
                <input class="form-control" id="nomefantasialabel" placeholder="" type="text" value="${estabelecimento.nomeFantasia}" name="nomefantasia">
              </div>
              <div class="form-group">
                <label class="control-label" for="razaosocialinput">Razão Social</label>
                <input class="form-control" id="razaosocialinput" type="text" value="${estabelecimento.razaoSocial}" name="razaosocial">
              </div>
              <div class="form-group">
                <label class="control-label" for="cnpjInput">CNPJ</label>
                <input class="form-control" id="cnpjInput" type="text" value="${estabelecimento.cnpj}" name="cnpj">
              </div>
              <div class="form-group">
                <label class="control-label" for=logradouro>Logradouro</label>
                <input class="form-control" id="logradouro" type="text" value="${estabelecimento.logradouro}" name="logradouro"> 
              </div>
              <div class="form-group">
                <label class="control-label" for="numero">Número</label>
                <input class="form-control" id="numero" type="text" value="${estabelecimento.numero}" name="numero"> 
              </div>
              <div class="form-group">
                <label class="control-label" for="bairro">Bairro</label>
                <input class="form-control" id="bairro" type="text" value="${estabelecimento.bairro}" name="bairro"> 
              </div>
              <div class="form-group">
                <label class="control-label" for="cidade">Cidade</label>
                <input class="form-control" id="cidade" type="text" value="${estabelecimento.cidade}" name="cidade"> 
              </div>
              <div class="form-group">
                <label class="control-label" for="uf">UF</label>
                <input class="form-control" id="uf" type="text" value="${estabelecimento.uf}" name="uf"> 
              </div>
              <div class="form-group">
                <label class="control-label" for="cep">CEP</label>
                <input class="form-control" id="cep" type="text" value="${estabelecimento.cep}" name="cep"> 
              </div>
              <div class="form-group">
                <label class="control-label" for="cnpjInput">Telefone</label>
                <input class="form-control" id="cnpjInput" type="text" value="${estabelecimento.telefone}" name="telefone">
              </div>
              <div class="form-group">
                <div class="custom-control custom-switch">
                <c:choose>
                <c:when test="${estabelecimento.delivery == 1}"> <input type="checkbox" class="custom-control-input" id="switchdelivery" checked="checked" name="deliverycheck"> </c:when>
                <c:otherwise><input type="checkbox" class="custom-control-input" id="switchdelivery" name="deliverycheck"></c:otherwise>
                </c:choose>
                  <label class="custom-control-label" for="switchdelivery">Delivery Aberto</label>
                </div>
              </div>
              <div class="form-group">
                <div class="custom-control custom-switch">
                <c:choose>
	                <c:when test="${estabelecimento.impressoraCozinha == 1}"> 
	                	<input type="checkbox" class="custom-control-input" id="switchimpressoracozinha" checked="checked" name="checkimpressoracozinha"> 
	                </c:when>
                	<c:otherwise>
                		<input type="checkbox" class="custom-control-input" id="switchimpressoracozinha" name="checkimpressoracozinha">
                	</c:otherwise>
                </c:choose>                  
                  <label class="custom-control-label" for="switchimpressoracozinha">Impressora Cozinha</label>
                </div>
              </div>
              <div class="form-group">
                <label class="control-label" for="cnpjInput">Endereço impressora Cozinha</label>
                <input class="form-control" id="impressoracozinhainput" type="text" value="${estabelecimento.enderecoImpressoraCozinha}" name="inputenderecoimpressoracozinha">
              </div>
              <div class="form-group">
                <div class="custom-control custom-switch">
                <c:choose>
                <c:when test="${estabelecimento.impressoraCaixa == 1}"> <input type="checkbox" class="custom-control-input" id="switchimpressoracaixa" checked="checked" name="checkimpressoracaixa"> </c:when>
                <c:otherwise><input type="checkbox" class="custom-control-input" id="switchimpressoracaixa" name="checkimpressoracaixa"></c:otherwise>
                </c:choose>
                  
                  <label class="custom-control-label" for="switchimpressoracaixa">Impressora Caixa</label>
                </div>
              </div>
              <div class="form-group">
                <label class="control-label" for="fisco1input">Endereço impressora Caixa</label>
                <input class="form-control" id="fisco1input" type="text" value="${estabelecimento.enderecoImpressoraCaixa}" name="enderecoImpressoraCaixa">
              </div>
              <div class="form-group">
                <div class="custom-file">
                	<label class="" for="customfileimagelogo">Imagem Logo</label> 
                	<input type="file" name="logo" id="customfileimagelogo" class="inputfile" />                                            
                </div>
              </div>
           
              <div class="form-group">
                <div class="custom-file">
                  <label class="" for="customFileimagemprincipal">Imagem Site</label>                	
                  <input type="file" class="inputfile" id="customFileimagemprincipal" name="img" />                         
                </div>
              </div>
              <div class="form-group">
                <label class="control-label" for="fisco2input">Reservado ao Fisco 1</label>
                <input class="form-control" id="fisco12nput" type="text" value="${estabelecimento.fisco}" name="fisco1">
              </div>
              <div class="form-group">
                <label class="control-label" for="impressoracaixainput">Reservado ao Fisco 2</label>
                <input class="form-control" id="impressoracaixainput" type="text" value="${estabelecimento.fisco2}" name="fisco2">
              </div>
              <button type="submit" class="btn btn-primary btn-block">Salvar</button>
              
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </form>  
            <br><br>          
             <div class="section" id="imgs">
		      <div class="container">
		        <div class="row">
		          <div class="col-md-2">
			          <h4>logo:</h4>
			            <img src="data:image/jpg;base64, ${estabelecimento.logoTO64} " height="100px"	width="150px" class="rounded"/>
			            
		          </div>
		          <div class="col-md-2">
			          <h4>img site:</h4>    
			            <img src="data:image/jpg;base64, ${estabelecimento.imgTO64} " height="150px"	width="130px" class="rounded"/>
			            
		          </div>
		        </div>
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


$('#sel1').on('change', function() {
	if(this.value===""){
		$("#formestabelecimento").hide();
		$("#imgs").hide();
		
		}else{
			$("#formestabelecimento").show();
			$("#imgs").show();
			}
	});

</script>
</html>