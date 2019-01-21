package br.com.dgsistemas.models;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

@Transactional
public interface FuncionarioRepo extends CrudRepository<Funcionario, Integer> {
	
	@Query(value = "SELECT * FROM funcionario a WHERE a.login = :login and a.senha = :password", 
			  nativeQuery = true)
	public Funcionario doLogin(@Param("login") String login, @Param("password") String password);

}
