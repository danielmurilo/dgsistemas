package br.com.dgsistemas.models;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Pedido implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(generator = "increment")
	@GenericGenerator(name = "increment", strategy = "increment")
	@Column(name = "ID_PEDIDO")
	private long id;
	private int qtd;
	private String obs;
	private Double valorVenda;
	private Date data;
	private int status;	
	
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "FUNCIONARIO_ID")
	private Funcionario funcionario = new Funcionario();
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "CONTA_ID")
	private Conta conta = new Conta();
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "PRODUTO_ID")
	private Produto produto = new Produto();
	
	
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public int getQtd() {
		return qtd;
	}
	public void setQtd(int qtd) {
		this.qtd = qtd;
	}
	public String getObs() {
		return obs;
	}
	public void setObs(String obs) {
		this.obs = obs;
	}
	public Double getValorVenda() {
		return valorVenda;
	}
	public void setValorVenda(Double valorVenda) {
		this.valorVenda = valorVenda;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Funcionario getFuncionario() {
		return funcionario;
	}
	public void setFuncionario(Funcionario funcionario) {
		this.funcionario = funcionario;
	}
	public Conta getConta() {
		return conta;
	}
	public void setConta(Conta conta) {
		this.conta = conta;
	}
	public Produto getProduto() {
		return produto;
	}
	public void setProduto(Produto produto) {
		this.produto = produto;
	}
	@Override
	public String toString() {
		return "Pedido [id=" + id + ", qtd=" + qtd + ", obs=" + obs + ", valorVenda=" + valorVenda + ", data=" + data
				+ ", status=" + status + ", funcionario=" + funcionario + ", conta=" + conta + ", produto=" + produto
				+ "]";
	}
	
	
	
	
	
	

}
