/*builder.addTextAlign(builder.ALIGN_CENTER);
            builder.addText('<html><style>	@page { size: auto;  margin: 1mm; }</style>'+
					'<head><title>DG</title></head>'+
                    '<body onload=\"window.print(); window.close();\">'+
				    '<center>'+
				    '${estabelecimento.nomeFantasia}'.toUpperCase() + '<br>'+
				    '${estabelecimento.logradouro}, ${estabelecimento.numero} - ${estabelecimento.bairro}<br>'+
				    '${estabelecimento.cidade} - ${estabelecimento.uf} - CEP ${estabelecimento.cep} <br>'+
				    '${estabelecimento.telefone}<br>'+
                    '</center><br>'+
                    '<strong>CNPJ:${estabelecimento.cnpj}</strong>'+
                    '<br>----------------------------------------------------<br>'+
                     dataAtualFormatada().substring()+' &nbsp;'+time()+ '<span style="float:right;"><strong>COO: ${conta.id} &nbsp </strong> </span>'+
                    '<center><strong>CONTA</strong></center>'+
                    '<br>QTD &nbsp;&nbsp;&nbsp; ITEM &nbsp;&nbsp;&nbsp; UNIT R$ &nbsp;&nbsp;&nbsp; TOTAL R$ <br>'+

                    <c:forEach var="pedido" items="${pedidos}" varStatus="loop">
                    '<p style="text-align: left;">&nbsp;&nbsp; ${pedido.qtd} &nbsp;&nbsp;'+
                    '${fn:substring(pedido.produto.nome, 0, 12)}'+
                    '<span style="float:right;"> ${pedido.valorVenda}'+
                    <c:choose>
						<c:when test="${(pedido.valorVenda * pedido.qtd) > 9.99}">
							'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${pedido.valorVenda * pedido.qtd} &nbsp;&nbsp;&nbsp;&nbsp;</span></p>'+
						</c:when>
						<c:otherwise>
							'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${pedido.valorVenda * pedido.qtd} &nbsp;&nbsp;&nbsp;&nbsp;</span></p>'+
						</c:otherwise>
					</c:choose>                  
    				</c:forEach>
    				'<span style="float:right;">--------------------------</span><br>'+
    				'<span style="float:right;">Total: <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${conta.total} &nbsp;&nbsp;&nbsp;&nbsp;</span>'+
    				<c:choose>
						<c:when test="${conta.delivery > 0}">
						'<br><br>----------------------------------------Delivery<br>'+
						'Nome: ${conta.nome_mesa}<br>'+
						'Telefone: ${conta.telefone}<br>'+
						'${conta.endereco.logradouro}, ${conta.endereco.numero}<br>'+
						<c:choose>
							<c:when test="${conta.endereco.complemento.length()>0}">
							'${conta.endereco.complemento} <br>'+
							</c:when>
						</c:choose>	
						'${conta.endereco.bairro} - ${conta.endereco.cidade} - ${conta.endereco.uf} &nbsp; <br>'+
						<c:choose>
							<c:when test="${conta.endereco.cep.length()>0}">
							'${conta.endereco.cep} <br>'+
							</c:when>
					</c:choose>	
						'${conta.endereco.referencia}'+
						</c:when>					
					</c:choose>
					'<br><br><center><p style="font-size: 10">DG Sistemas (81)99939-3017</p><center>'+
                    '</body></html>');
            builder.addHLine(0, 100, builder.LINE_THIN_DOUBLE);*/