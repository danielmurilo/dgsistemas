package br.com.dgsistemas.models;

import javax.transaction.Transactional;

import org.springframework.data.repository.CrudRepository;

@Transactional
public interface IngredienteRepo extends CrudRepository<Ingrediente, Integer> {

}
