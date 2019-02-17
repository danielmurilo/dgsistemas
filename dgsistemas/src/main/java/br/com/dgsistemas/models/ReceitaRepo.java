package br.com.dgsistemas.models;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

@Transactional
public interface ReceitaRepo extends CrudRepository<Receita, Long>  {

	@Query(value = "select * from receita r WHERE r.produto_id = :id", nativeQuery = true)
	public List<Receita> listarReceitasPorProduto(@Param("id") Long id);

}
