package br.com.dgsistemas.models;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;


@Transactional
public interface CategoriaRepo extends CrudRepository<Categoria, Integer> {

	@Query(value = "SELECT * FROM categoria c WHERE c.status = 1", 
			  nativeQuery = true)
	public List<Categoria> listarCategoriasAtivas();
	
}
