package br.com.dgsistemas.models;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

@Transactional
public interface ContaRepo extends CrudRepository<Conta, Long>{
	
	@Query(value = "SELECT c.id_conta, c.data_abertura, LEFT(c.nome_mesa, 10) AS 'nome_mesa', c.status, c.funcionario_id, c.id_conta, (SELECT IFNULL(SUM(p.valor_venda*p.qtd), 0.00) FROM pedido p WHERE p.conta_id = c.id_conta) as total FROM conta c WHERE c.status = 1", 
			  nativeQuery = true)
	public List<Conta> listarContasComTotal();
	
	@Query(value = "SELECT c.id_conta, c.data_abertura, c.nome_mesa, c.status, c.funcionario_id, (SELECT IFNULL(SUM(p.valor_venda*p.qtd), 0.00) FROM pedido p WHERE p.conta_id = c.id_conta) AS total FROM conta c WHERE c.id_conta = :id", 
			  nativeQuery = true)
	public Conta findContaComtotal(@Param("id") Long id);
	
	@Query(value = "SELECT IFNULL(SUM(p.valor_venda*p.qtd), 0.00) AS total FROM pedido p WHERE p.conta_id = :id", nativeQuery = true)
	public Double findTotal(@Param("id") Long id);
	
	@Modifying
	@Query(value = "UPDATE conta c set c.status = 0 WHERE c.id_conta = :id", nativeQuery = true)
	public void fecharconta(@Param("id") Long id);
	
	@Query(value = "SELECT c.id_conta, c.data_abertura, LEFT(c.nome_mesa, 10) AS 'nome_mesa', c.status, c.funcionario_id, c.id_conta, (SELECT IFNULL(SUM(p.valor_venda*p.qtd), 0.00) FROM pedido p WHERE p.conta_id = c.id_conta) as total FROM conta c WHERE DATE(c.data_abertura) = :data", 
			  nativeQuery = true)
	public List<Conta> listarContasComTotalPorData(@Param("data") Date data);

}
