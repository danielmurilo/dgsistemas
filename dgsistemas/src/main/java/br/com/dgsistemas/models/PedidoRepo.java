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

}
