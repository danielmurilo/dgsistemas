package br.com.dgsistemas.models;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

@Transactional
public interface FuncionarioRepo extends CrudRepository<Funcionario, Integer> {
	
	@Query(value = "SELECT * FROM funcionario f WHERE f.login = :login and f.senha = :password ", nativeQuery = true)
	public Funcionario doLogin(@Param("login") String login, @Param("password") String password);
	
	@Query(value = "SELECT * FROM funcionario f WHERE f.status = 1 ", nativeQuery = true)
	public List<Funcionario> listarFuncionariosAtivos();
	
	@Query(value = "SELECT count(f.id_funcionario) FROM funcionario f WHERE f.senha = :senha", nativeQuery = true)
	public int logarGerente(@Param("senha") String senha);
	

}
