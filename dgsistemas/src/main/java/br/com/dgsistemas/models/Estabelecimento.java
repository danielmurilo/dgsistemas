package br.com.dgsistemas.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Estabelecimento implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(generator = "increment")
	@GenericGenerator(name = "increment", strategy = "increment")
	@Column(name="id")
	private int id;	
	private String razaoSocial;
	private String nomeFantasia;
	private String cnpj;
	
	private String logradouro;
	private String numero;
	private String bairro;
	private String cidade;
	private String uf;
	private String cep;
	
	private String telefone;
	private int delivery;
	private int impressoraCozinha;
	private String enderecoImpressoraCozinha;
	private int impressoraCaixa;
	private String enderecoImpressoraCaixa;
	private String fisco;
	private String fisco2;
    @Column(name = "logo", nullable = true, columnDefinition = "BYTEA")
    private byte[] logo;    
    @Transient
    private String logoTO64;    
    @Column(name = "img", nullable = true, columnDefinition = "BYTEA")
    private byte[] img;    
    @Transient
    private String imgTO64;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRazaoSocial() {
		return razaoSocial;
	}
	public void setRazaoSocial(String razaoSocial) {
		this.razaoSocial = razaoSocial;
	}
	public String getNomeFantasia() {
		return nomeFantasia;
	}
	public void setNomeFantasia(String nomeFantasia) {
		this.nomeFantasia = nomeFantasia;
	}
	public String getCnpj() {
		return cnpj;
	}
	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}	

	public String getLogradouro() {
		return logradouro;
	}
	public void setLogradouro(String logradouro) {
		this.logradouro = logradouro;
	}
	public String getNumero() {
		return numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}
	public String getBairro() {
		return bairro;
	}
	public void setBairro(String bairro) {
		this.bairro = bairro;
	}
	public String getCidade() {
		return cidade;
	}
	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
	
	public String getUf() {
		return uf;
	}
	public void setUf(String uf) {
		this.uf = uf;
	}
	public String getCep() {
		return cep;
	}
	public void setCep(String cep) {
		this.cep = cep;
	}
	public String getTelefone() {
		return telefone;
	}
	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}
	public int getDelivery() {
		return delivery;
	}
	public void setDelivery(int delivery) {
		this.delivery = delivery;
	}
	public int getImpressoraCozinha() {
		return impressoraCozinha;
	}
	public void setImpressoraCozinha(int impressoraCozinha) {
		this.impressoraCozinha = impressoraCozinha;
	}
	public String getEnderecoImpressoraCozinha() {
		return enderecoImpressoraCozinha;
	}
	public void setEnderecoImpressoraCozinha(String enderecoImpressoraCozinha) {
		this.enderecoImpressoraCozinha = enderecoImpressoraCozinha;
	}
	public int getImpressoraCaixa() {
		return impressoraCaixa;
	}
	public void setImpressoraCaixa(int impressoraCaixa) {
		this.impressoraCaixa = impressoraCaixa;
	}
	public String getEnderecoImpressoraCaixa() {
		return enderecoImpressoraCaixa;
	}
	public void setEnderecoImpressoraCaixa(String enderecoImpressoraCaixa) {
		this.enderecoImpressoraCaixa = enderecoImpressoraCaixa;
	}
	public String getFisco() {
		return fisco;
	}
	public void setFisco(String fisco) {
		this.fisco = fisco;
	}
	public String getFisco2() {
		return fisco2;
	}
	public void setFisco2(String fisco2) {
		this.fisco2 = fisco2;
	}
	public byte[] getLogo() {
		return logo;
	}
	public void setLogo(byte[] logo) {
		this.logo = logo;
	}
	public String getLogoTO64() {
		return logoTO64;
	}
	public void setLogoTO64(String logoTO64) {
		this.logoTO64 = logoTO64;
	}
	public byte[] getImg() {
		return img;
	}
	public void setImg(byte[] img) {
		this.img = img;
	}
	public String getImgTO64() {
		return imgTO64;
	}
	public void setImgTO64(String imgTO64) {
		this.imgTO64 = imgTO64;
	}
	
	
}
