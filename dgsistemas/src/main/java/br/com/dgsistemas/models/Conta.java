package br.com.dgsistemas.models;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Conta implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name="id_conta")
	private long id;
	private Date data_abertura;
	private String nome_mesa;
	private int status;
	private Double total;
	
	@ManyToOne
    @JoinColumn(name = "FUNCIONARIO_ID")
	private Funcionario funcionarioAbertura = new Funcionario();
	
	
	

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getDataAbertura() {
		return data_abertura;
	}

	public void setDataAbertura(Date dataAbertura) {
		this.data_abertura = dataAbertura;
	}

	public String getNome_mesa() {
		return nome_mesa;
	}

	public void setNome_mesa(String nome_mesa) {
		this.nome_mesa = nome_mesa;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Funcionario getFuncionarioAbertura() {
		return funcionarioAbertura;
	}

	public void setFuncionarioAbertura(Funcionario funcionarioAbertura) {
		this.funcionarioAbertura = funcionarioAbertura;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}
	
	
	
	
	
	

}
