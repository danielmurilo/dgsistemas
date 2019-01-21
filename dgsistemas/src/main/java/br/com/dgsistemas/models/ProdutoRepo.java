package br.com.dgsistemas.models;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

@Transactional
public interface ProdutoRepo extends CrudRepository<Produto, Long> {
	
	@Query(value = "SELECT * FROM produto p WHERE p.categoria_id = :id", 
			  nativeQuery = true)
	public List<Produto> listarProdutosPorCategoria(@Param("id") Long id);
	
	@Query(value = "SELECT * FROM produto p WHERE p.status = 1", 
			  nativeQuery = true)
	public List<Produto> listarProdutosAtivos();

}
