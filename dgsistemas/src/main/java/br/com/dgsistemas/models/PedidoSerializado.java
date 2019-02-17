package br.com.dgsistemas.models;

public class PedidoSerializado {
	
	private Long id;
	private String nome;
	private int qtd;
	private String obs;
	private Double valorvenda;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
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
	public Double getValorvenda() {
		return valorvenda;
	}
	public void setValorvenda(Double valorvenda) {
		this.valorvenda = valorvenda;
	}

	
}
