package br.com.dgsistemas.models;

import java.io.Serializable;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Conta implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(generator = "increment")
	@GenericGenerator(name = "increment", strategy = "increment")
	@Column(name="id_conta")
	private long id;
	private Date data_abertura;
	private String nome_mesa;
	private int status;
	private Double total;
	private int delivery;
	private String telefone;
	
	@ManyToOne(cascade = {CascadeType.REFRESH})
    @JoinColumn(name = "ENDERECO_ID")
	private Endereco endereco;
	
	@ManyToOne
    @JoinColumn(name = "FUNCIONARIO_ID")
	private Funcionario funcionarioAbertura;	

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

	public Date getData_abertura() {
		return data_abertura;
	}

	public void setData_abertura(Date data_abertura) {
		this.data_abertura = data_abertura;
	}

	public int getDelivery() {
		return delivery;
	}

	public void setDelivery(int delivery) {
		this.delivery = delivery;
	}

	public Endereco getEndereco() {
		return endereco;
	}

	public void setEndereco(Endereco endereco) {
		this.endereco = endereco;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}
	
	
	
	
	
	
	
	

}
