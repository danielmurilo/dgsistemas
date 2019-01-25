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
	
	@Query(value = "SELECT c.id_conta, c.data_abertura, LEFT(c.nome_mesa, 10) AS nome_mesa, c.status, c.funcionario_id, c.id_conta, COALESCE(c.delivery, '0') as delivery, COALESCE(c.endereco, 'x') as endereco, (SELECT COALESCE(SUM(p.valor_venda*p.qtd), 0.00) FROM pedido p WHERE p.conta_id = c.id_conta) as total FROM conta c WHERE c.status = 1", 
			  nativeQuery = true)
	public List<Conta> listarContasComTotal();	
	
	@Query(value = "SELECT c.id_conta, c.data_abertura, LEFT(c.nome_mesa, 10) AS nome_mesa, c.status, c.funcionario_id, COALESCE(c.delivery, '0') as delivery, COALESCE(c.endereco, 'x') as endereco, (SELECT COALESCE(SUM(p.valor_venda*p.qtd), 0.00) FROM pedido p WHERE p.conta_id = c.id_conta) AS total FROM conta c WHERE c.id_conta = 1", 
			  nativeQuery = true)
	public Conta findContaComtotal();
	
	@Query(value = "SELECT COALESCE(SUM(p.valor_venda*p.qtd), 0.00) AS total FROM pedido p WHERE p.conta_id = :id", nativeQuery = true)
	public Double findTotal(@Param("id") Long id);
	
	@Modifying
	@Query(value = "UPDATE conta set status = 0 WHERE id_conta = :id", nativeQuery = true)
	public void fecharconta(@Param("id") Long id);
	
	@Query(value = "SELECT c.id_conta, c.data_abertura, LEFT(c.nome_mesa, 10) AS nome_mesa, c.status, c.funcionario_id, c.id_conta, COALESCE(c.delivery, '0') as delivery, COALESCE(c.endereco, 'x') as endereco, (SELECT COALESCE(SUM(p.valor_venda*p.qtd), 0.00) FROM pedido p WHERE p.conta_id = c.id_conta) as total FROM conta c WHERE DATE(c.data_abertura) = :data", 
			  nativeQuery = true)
	public List<Conta> listarContasComTotalPorData(@Param("data") Date data);
	
	@Query(value = "SELECT c.id_conta, c.data_abertura, LEFT(c.nome_mesa, 10) AS nome_mesa, c.status, c.funcionario_id, c.id_conta, COALESCE(c.delivery, '0') as delivery, COALESCE(c.endereco, 'x') as endereco, (SELECT COALESCE(SUM(p.valor_venda*p.qtd), 0.00) FROM pedido p WHERE p.conta_id = c.id_conta) as total FROM conta c WHERE DATE(c.data_abertura) = :data AND c.funcionario_id = :idFuncionario", 
			  nativeQuery = true)
	public List<Conta> listarContasComTotalPorDataAndFuncionario(@Param("data") Date data, @Param("idFuncionario") int idFuncionario);

}
