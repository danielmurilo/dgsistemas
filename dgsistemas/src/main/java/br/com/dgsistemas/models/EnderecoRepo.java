package br.com.dgsistemas.models;

import javax.transaction.Transactional;

import org.springframework.data.repository.CrudRepository;

@Transactional
public interface EnderecoRepo extends CrudRepository<Endereco, Integer> {

}
