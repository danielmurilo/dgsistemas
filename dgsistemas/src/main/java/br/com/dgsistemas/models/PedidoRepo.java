package br.com.dgsistemas.models;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

@Transactional
public interface PedidoRepo extends CrudRepository<Pedido, Long> {
	
	@Query(value = "SELECT * FROM pedido p WHERE p.conta_id = :id", 
			  nativeQuery = true)
	public List<Pedido> listarPedidosPorConta(@Param("id") Long id);
	
	@Query(value = "SELECT COALESCE(SUM(p.valor_venda),0.00) AS  totalDinheiro  FROM pedido p WHERE p.produto_id = 1 AND DATE(p.data) = :date", 
			  nativeQuery = true)
	public Double valorTotalVendasEmDinheiroPorData(@Param("date") Date date);
	
	@Query(value = "SELECT COALESCE(SUM(p.valor_venda),0.00) AS  totalCartao  FROM pedido p WHERE p.produto_id = 2 AND DATE(p.data) = :date", 
			  nativeQuery = true)
	public Double valorTotalVendasEmCartaoPorData(@Param("date") Date date);
	
	@Query(value = "SELECT COALESCE(SUM(p.valor_venda),0.00) AS  totalDinheiro  FROM pedido p WHERE p.produto_id = 1 AND DATE(p.data) = :date AND p.funcionario_id = :id", 
			  nativeQuery = true)
	public Double valorTotalVendasEmDinheiroPorDataAndFuncionario(@Param("date") Date date, @Param("id") int idFuncionario);
	
	@Query(value = "SELECT COALESCE(SUM(p.valor_venda),0.00) AS  totalCartao  FROM pedido p WHERE p.produto_id = 2 AND DATE(p.data) = :date AND p.funcionario_id = :id", 
			  nativeQuery = true)
	public Double valorTotalVendasEmCartaoPorDataAndFuncionario(@Param("date") Date date, @Param("id") int idFuncionario);
	
	@Query(value = "select produto.nome, sum(pedido.qtd) as total from pedido inner join produto on pedido.produto_id = produto.id_produto WHERE NOT (produto.id_produto = 2 OR produto.id_produto = 1)  GROUP by  produto.nome ORDER by total DESC", nativeQuery = true)
	public List<Object[]>  produtosMaisVendidos();
	
	@Query(value = "SELECT c.id_conta, LEFT(c.nome_mesa, 10) as nome_mesa, p.\"data\", c.status, c.funcionario_id, COALESCE(c.delivery, '0'), (p.valor_venda*-1) as valor_venda, p.id_pedido, c.id_conta, p.conta_id, p.obs, p.produto_id, p.qtd FROM pedido p inner join conta c on p.conta_id = c.id_conta WHERE (p.produto_id = 1 or p.produto_id = 2) and  DATE(c.data_abertura) = :date", 
			  nativeQuery = true)
	public List<Pedido> listarPagamentosPorData(@Param("date") Date date);
	
	@Query(value = "SELECT c.id_conta, LEFT(c.nome_mesa, 10) as nome_mesa, p.\"data\", c.status, c.funcionario_id, COALESCE(c.delivery, '0'), (p.valor_venda*-1) as valor_venda, p.id_pedido, c.id_conta, p.conta_id, p.obs, p.produto_id, p.produto_id, p.qtd FROM pedido p inner join conta c on p.conta_id = c.id_conta WHERE (p.produto_id = 1 or p.produto_id = 2) and  (DATE(c.data_abertura) = :date and p.funcionario_id = :id)", 
			  nativeQuery = true)
	public List<Pedido> listarPagamentosPorDataEFuncionario(@Param("date") Date date, @Param("id") int idFuncionario);
	

}
