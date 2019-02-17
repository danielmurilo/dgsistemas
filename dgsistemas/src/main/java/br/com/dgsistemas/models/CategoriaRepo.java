package br.com.dgsistemas.models;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;


@Transactional
public interface CategoriaRepo extends CrudRepository<Categoria, Long> {

	@Query(value = "SELECT * FROM categoria c WHERE c.status = 1", 
			  nativeQuery = true)
	public List<Categoria> listarCategoriasAtivas();
	
	@Query(value = "SELECT c.cobra_embalagem FROM categoria c inner join produto p on p.categoria_id = c.id_categoria WHERE p.id_produto = :idProduto", 
			  nativeQuery = true)
	public CharSequence cobraEmbalagem(@Param("idProduto") Long idProduto);
	
	
}

