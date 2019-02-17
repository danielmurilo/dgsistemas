package br.com.dgsistemas.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import br.com.dgsistemas.models.Categoria;
import br.com.dgsistemas.models.CategoriaRepo;
import br.com.dgsistemas.models.Compra;
import br.com.dgsistemas.models.CompraRepo;
import br.com.dgsistemas.models.Conta;
import br.com.dgsistemas.models.ContaRepo;
import br.com.dgsistemas.models.Endereco;
import br.com.dgsistemas.models.EnderecoRepo;
import br.com.dgsistemas.models.Estabelecimento;
import br.com.dgsistemas.models.EstabelecimentoRepo;
import br.com.dgsistemas.models.Funcionario;
import br.com.dgsistemas.models.FuncionarioRepo;
import br.com.dgsistemas.models.Ingrediente;
import br.com.dgsistemas.models.IngredienteRepo;
import br.com.dgsistemas.models.Pedido;
import br.com.dgsistemas.models.PedidoRepo;
import br.com.dgsistemas.models.PedidoSerializado;
import br.com.dgsistemas.models.Produto;
import br.com.dgsistemas.models.ProdutoRepo;
import br.com.dgsistemas.models.Receita;
import br.com.dgsistemas.models.ReceitaRepo;

@Controller
@SessionAttributes({ "funcionarioid", "contaid" })
public class HomeController {

	@Autowired
	FuncionarioRepo funcionarioRepo;
	@Autowired
	ContaRepo contaRepo;
	@Autowired
	PedidoRepo pedidoRepo;
	@Autowired
	CategoriaRepo categoriaRepo;
	@Autowired
	ProdutoRepo produtoRepo;
	@Autowired
	EnderecoRepo enderecoRepo;
	@Autowired
	EstabelecimentoRepo estabelecimentoRepo;
	@Autowired
	IngredienteRepo ingredienteRepo;
	@Autowired
	ReceitaRepo receitaRepo;
	@Autowired
	CompraRepo compraRepo;

	@ModelAttribute("funcionarioid")
	public int setarFuncionarioIdNaSession() {
		return 0;
	}

	@ModelAttribute("contaid")
	public Long setarContaIdnNaSession() {
		return (long) 0;
	}

	@GetMapping("/mainpage")
	public ModelAndView mainpage() {
		ModelAndView mv = new ModelAndView("home/mainpage");
		List<Conta> contas = (List<Conta>) contaRepo.listarContasComTotal();
		mv.addObject("contas", contas);
		return mv;
	}

	@RequestMapping("/")
	public ModelAndView login() {
		ModelAndView mv = new ModelAndView("home/index");
		mv.addObject("hidden_attribute", "hidden");
		return mv;
	}

	@RequestMapping(value = "/login")
	public ModelAndView login(ModelMap model, HttpServletRequest request, HttpServletResponse res, @ModelAttribute("funcionarioid") int f_id) {
		ModelAndView mv;
		try {
			Funcionario f = funcionarioRepo.doLogin((String) request.getParameter("login"), (String) request.getParameter("password"));
			if(f != null) {
				mv = new ModelAndView("home/mainpage");
				mv.addObject("contas", (List<Conta>) contaRepo.listarContasComTotal());

				// adcionando dados funcionario a session
				f_id = f.getId();
				model.addAttribute("funcionarioid", f_id);

				// adcionando dados funcionario a mainpage
				mv.addObject("funcionario_id", f.getId());
				mv.addObject("funcionario_nome", f.getNome());						
			}else {
				mv = new ModelAndView("home/index");
				mv.addObject("hidden_attribute", "");
				mv.addObject("message1", "Ops!");
				mv.addObject("message2", "Login ou senha não encontrados!");	
			}
			
		} catch (Exception e) {
			mv = new ModelAndView("home/index");
			mv.addObject("hidden_attribute", "");
			mv.addObject("message1", "Ops!");
			mv.addObject("message2", "Login ou senha não encontrados!!");	
		}
		return mv;

	}

	@RequestMapping(value = "/conta/{id}")
	public ModelAndView listarPedidosPorConta(ModelMap model, @PathVariable("id") Long id,
			@ModelAttribute("contaid") Long contaid) {
		// setando contaid na session
		model.addAttribute("contaid", id);

		ModelAndView mv;
		mv = new ModelAndView("home/conta");
		List<Pedido> pedidos = (List<Pedido>) pedidoRepo.listarPedidosPorConta(id);
		Conta conta = contaRepo.findContaComtotal(id);
		conta.setTotal(contaRepo.findTotal(id));

		Estabelecimento e = estabelecimentoRepo.findOne(1);
		
		mv.addObject("pedidos", pedidos);
		mv.addObject("conta", conta);
		mv.addObject("estabelecimento", e);
		return mv;

	}

	@RequestMapping("/abrirconta")
	public ModelAndView abrirconta() {
		ModelAndView mv = new ModelAndView("home/abrirconta");
		return mv;
	}

	@RequestMapping(value = "/abrirconta/salvarconta")
	public ModelAndView salvarconta(HttpServletRequest request, @ModelAttribute("funcionarioid") int f_id) {
		ModelAndView mv = new ModelAndView("home/mainpage");
		Conta c = new Conta();
		c.setStatus(1);
		c.setNome_mesa(request.getParameter("nome_mesa"));
		if ("on".equals(request.getParameter("deliverycheck"))) {
			c.setDelivery(1);
			c.setTelefone(request.getParameter("telefone"));
			c.setEndereco(new Endereco());
			c.getEndereco().setCep(request.getParameter("cep"));
			c.getEndereco().setLogradouro(request.getParameter("logradouro"));
			c.getEndereco().setNumero(request.getParameter("numero"));
			c.getEndereco().setComplemento(request.getParameter("complemento"));
			c.getEndereco().setBairro(request.getParameter("bairro"));
			c.getEndereco().setCidade(request.getParameter("cidade"));
			c.getEndereco().setUf(request.getParameter("uf"));
			c.getEndereco().setReferencia(request.getParameter("referencia"));
			enderecoRepo.save(c.getEndereco());
		}
		Date hora = Calendar.getInstance().getTime();
		c.setDataAbertura(hora);
		c.setFuncionarioAbertura(funcionarioRepo.findOne(f_id));
		contaRepo.save(c);
		List<Conta> contas = (List<Conta>) contaRepo.listarContasComTotal();
		mv.addObject("contas", contas);
		return mv;
	}

	@RequestMapping("/fecharconta")
	public String fecharconta() {
		return "home/fecharconta";
	}

	@RequestMapping("/lancarpedido")
	public ModelAndView lancarpedido(ModelMap model, HttpServletRequest request,
			@ModelAttribute("contaid") Long contaid, @ModelAttribute("funcionarioid") int funcionarioid) {
		ModelAndView mv = new ModelAndView("home/lancarpedido");
		mv.addObject("categorias", (List<Categoria>) categoriaRepo.listarCategoriasAtivas());
		model.addAttribute("conta", contaRepo.findOne(contaid));
		model.addAttribute("funcionario", funcionarioRepo.findOne(funcionarioid));
		return mv;
	}

	@RequestMapping("/salvarPedidos")
	public ModelAndView salvarPedido(@RequestBody String json, @ModelAttribute("contaid") Long contaid,
			@ModelAttribute("funcionarioid") int f_id) {
		ObjectMapper mapper = new ObjectMapper();
		try {
			PedidoSerializado[] pedidos = mapper.readValue(json, PedidoSerializado[].class);
			List<Pedido> pedidoslist = new ArrayList<Pedido>();
			for (PedidoSerializado p : pedidos) {
				Pedido pedido = new Pedido();
				pedido.setProduto(produtoRepo.findOne(p.getId()));
				pedido.setValorVenda(pedido.getProduto().getPreco());
				pedido.setQtd(p.getQtd());
				pedido.setObs(p.getObs());
				Date hora = Calendar.getInstance().getTime();
				pedido.setData(hora);
				pedido.setStatus(1);
				pedido.setConta(contaRepo.findOne(contaid));
				pedido.setFuncionario(funcionarioRepo.findOne(f_id));
				pedidoslist.add(pedido);
			}
			pedidoRepo.save(pedidoslist);
			//Dar baixa em estoque (receita)
			for (Pedido pedido : pedidoslist) {
				List<Receita> receitasProduto = (List<Receita>) receitaRepo.listarReceitasPorProduto(pedido.getProduto().getId());
				
				for (Receita receita : receitasProduto) {
					Ingrediente i = receita.getIngrediente();
					i.setEstoque(i.getEstoque() - (receita.getQtd()*pedido.getQtd()));
					ingredienteRepo.save(i);
				}
			}		

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("home/mainpage");
	}

	@RequestMapping("/lancardinheiro/{valor}")
	public String lancardinheiro(@PathVariable("valor") Double valor, @ModelAttribute("contaid") Long contaid,
			@ModelAttribute("funcionarioid") int f_id) {
		Pedido p = new Pedido();
		p.setObs("Pagamento");
		p.setValorVenda(valor * -1.00);
		p.setQtd(1);
		p.setStatus(1);
		Date hora = Calendar.getInstance().getTime();
		p.setData(hora);
		p.setProduto(produtoRepo.findOne((long) 1));
		p.setConta(contaRepo.findOne(contaid));
		p.setFuncionario(funcionarioRepo.findOne(f_id));
		pedidoRepo.save(p);
		return "/conta/" + contaid;
	}

	@RequestMapping("/lancarcartao/{valor}")
	public String lancarcartao(@PathVariable("valor") Double valor, @ModelAttribute("contaid") Long contaid,
			@ModelAttribute("funcionarioid") int f_id) {
		Pedido p = new Pedido();
		p.setObs("Pagamento");
		p.setValorVenda(valor * -1.00);
		p.setQtd(1);
		p.setStatus(1);
		Date hora = Calendar.getInstance().getTime();
		p.setData(hora);
		p.setProduto(produtoRepo.findOne((long) 2));
		p.setConta(contaRepo.findOne(contaid));
		p.setFuncionario(funcionarioRepo.findOne(f_id));
		pedidoRepo.save(p);
		return "/conta/" + contaid;
	}

	@RequestMapping(value = "/listarProdutosPorCategoria/{id}")
	public void listarProdutosPorCategoria(@PathVariable("id") Long id, HttpServletResponse response) {

		List<Produto> produtos = (List<Produto>) produtoRepo.listarProdutosPorCategoria(id);
		String json = new Gson().toJson(produtos);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/fecharcontapaga")
	public void fecharconta(@ModelAttribute("contaid") Long contaid) {
		if (contaRepo.findTotal(contaid) == 0.00) {
			contaRepo.fecharconta(contaid);
		}

	}

	@RequestMapping(value = "/caixa")
	public ModelAndView caixa() {
		ModelAndView mv = new ModelAndView("home/caixa");
		mv.addObject("funcionarios", funcionarioRepo.listarFuncionariosAtivos());
		return mv;
	}

	@RequestMapping(value = "/exibirCaixa/{idFuncionario}/{inputCaixaDate}")
	public ModelAndView exibirCaixa(@RequestParam("inputCaixaDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date date,
			@PathVariable("idFuncionario") String idFuncionario) {
		ModelAndView mv = new ModelAndView("home/caixa");
		List<Conta> contas;
		if (Integer.parseInt(idFuncionario) > 0) {
			contas = (List<Conta>) contaRepo.listarContasComTotalPorDataAndFuncionario(date,
					Integer.parseInt(idFuncionario));
			mv.addObject("valortotalemdinheiro",
					pedidoRepo.valorTotalVendasEmDinheiroPorDataAndFuncionario(date, Integer.parseInt(idFuncionario)));
			mv.addObject("valortotalemcartao",
					pedidoRepo.valorTotalVendasEmCartaoPorDataAndFuncionario(date, Integer.parseInt(idFuncionario)));
		} else {
			contas = (List<Conta>) contaRepo.listarContasComTotalPorData(date);
			mv.addObject("valortotalemdinheiro", pedidoRepo.valorTotalVendasEmDinheiroPorData(date));
			mv.addObject("valortotalemcartao", pedidoRepo.valorTotalVendasEmCartaoPorData(date));
		}

		for (int i = 0; i < contas.size(); i++) {
			try {
				contas.get(i).setFuncionarioAbertura(
						funcionarioRepo.findOne(contas.get(i).getFuncionarioAbertura().getId()));
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		mv.addObject("funcionarios", funcionarioRepo.listarFuncionariosAtivos());

		mv.addObject("contas", contas);
		return mv;

	}

	@RequestMapping(value = "/admin")
	public String admin() {
		return "/home/admin";
	}

	@RequestMapping(value = "/cobraEmbalagem/{idProduto}")
	public void cobraEmbalagem(@PathVariable("idProduto") Long idProduto, HttpServletResponse response) {
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.append(categoriaRepo.cobraEmbalagem(idProduto));
			out.close();
		} catch (Exception e) {
		}

	}

	@RequestMapping(value = "/getIdTaxaEmbalagem")
	public void getIdTaxaEmbalagem(HttpServletResponse response) {
		String json = new Gson().toJson((Produto)produtoRepo.getTaxaEmbalagem());
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@GetMapping("/cadastros")
	public ModelAndView cadastros() {
		ModelAndView mv = new ModelAndView("home/cadastros");
		Estabelecimento estabelecimento = estabelecimentoRepo.findOne(1);
		try {
			if (estabelecimento.getImg() != null) {
				estabelecimento.setImgTO64(DatatypeConverter.printBase64Binary(estabelecimento.getImg()));
			}
			;
			if (estabelecimento.getLogo() != null) {
				estabelecimento.setLogoTO64(DatatypeConverter.printBase64Binary(estabelecimento.getLogo()));
			}
			;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.addObject("estabelecimento", estabelecimento);
		return mv;
	}

	@PostMapping("/salvarestabelecimento")
	public ModelAndView salvarEstabelecimento(HttpServletRequest request, @RequestParam MultipartFile logo,
			@RequestParam MultipartFile img) {
		Estabelecimento e = estabelecimentoRepo.findOne(Integer.parseInt(request.getParameter("id")));
		e.setRazaoSocial(request.getParameter("razaosocial"));
		e.setNomeFantasia(request.getParameter("nomefantasia"));
		e.setCnpj(request.getParameter("cnpj"));
		e.setLogradouro(request.getParameter("logradouro"));
		e.setNumero(request.getParameter("numero"));
		e.setBairro(request.getParameter("bairro"));
		e.setCidade(request.getParameter("cidade"));
		e.setUf(request.getParameter("uf"));
		e.setCep(request.getParameter("cep"));
		
		e.setTelefone(request.getParameter("telefone"));
		if ("on".equals(request.getParameter("deliverycheck"))) {
			e.setDelivery(1);
		} else {
			e.setDelivery(0);
		}
		if ("on".equals(request.getParameter("checkimpressoracozinha"))) {
			e.setImpressoraCozinha(1);
		} else {
			e.setImpressoraCozinha(0);
		}
		e.setEnderecoImpressoraCozinha(request.getParameter("inputenderecoimpressoracozinha"));
		if ("on".equals(request.getParameter("checkimpressoracaixa"))) {
			e.setImpressoraCaixa(1);
		} else {
			e.setImpressoraCaixa(0);
		}
		e.setEnderecoImpressoraCaixa(request.getParameter("enderecoImpressoraCaixa"));

		if (!logo.isEmpty()) {
			try {
				InputStream is = logo.getInputStream();
				e.setLogo(IOUtils.toByteArray(is));
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				System.out.println(e1.getMessage());
			}
		}
		if (!img.isEmpty()) {
			try {
				InputStream is = img.getInputStream();
				e.setImg(IOUtils.toByteArray(is));
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				System.out.println(e1.getMessage());
			}

		}
		e.setFisco(request.getParameter("fisco1"));
		e.setFisco2(request.getParameter("fisco2"));
		estabelecimentoRepo.save(e);
		try {
			e.setImgTO64(DatatypeConverter.printBase64Binary(e.getImg()));
			e.setLogoTO64(DatatypeConverter.printBase64Binary(e.getLogo()));

		} catch (Exception e2) {
			// TODO: handle exception
		}

		ModelAndView mv = new ModelAndView("home/cadastros");
		mv.addObject("estabelecimento", e);
		return mv;

	}

	@GetMapping("/categorias")
	public ModelAndView categorias() {
		ModelAndView mv = new ModelAndView("home/categorias");
		List<Categoria> categorias = (List<Categoria>) categoriaRepo.findAll();
		mv.addObject("categorias", categorias);
		return mv;
	}

	@GetMapping("/findcategoria")
	public void findCategoria(@RequestParam("id") Long id, HttpServletResponse response) {
		Categoria c = categoriaRepo.findOne(id);
		String json = new Gson().toJson(c);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@PostMapping("/salvarcategoria")
	public String salvarcategoria(HttpServletRequest request) {
		Categoria c = new Categoria();
		if(!"".equals(request.getParameter("id"))) {
			c = categoriaRepo.findOne(Long.parseLong(request.getParameter("id")));
		}
		c.setNome(request.getParameter("inputnome"));
		if ("on".equals(request.getParameter("checkativo"))) {
				c.setStatus(1);
		} else {
			c.setStatus(0);
		}
		if ("on".equals(request.getParameter("checkembalagem"))) {
			c.setCobraEmbalagem(1);
		} else {
			c.setCobraEmbalagem(0);
		}
		categoriaRepo.save(c);		
		return "redirect:categorias";

	}
	
	@GetMapping("funcionarios")
	public ModelAndView funcionarios() {
		ModelAndView mv = new ModelAndView("home/funcionarios");
		List<Funcionario> funcionarios = (List<Funcionario>) funcionarioRepo.findAll();
		mv.addObject("funcionarios", funcionarios);
		return mv;
	}
	@GetMapping("findfuncionario")
	public void findFuncionario(@RequestParam("id") Integer id, HttpServletResponse response) {
		Funcionario f = funcionarioRepo.findOne(id);
		String json = new Gson().toJson(f);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	@PostMapping("salvarfuncionario")
	public String salvarfuncionario (HttpServletRequest request) throws ParseException {
		Funcionario f = new Funcionario();
		if(!"".equals(request.getParameter("id"))) {
			f = funcionarioRepo.findOne(Integer.parseInt(request.getParameter("id")));		
		}
		f.setNome(request.getParameter("inputnome"));
		f.setLogin(request.getParameter("inputlogin"));
		f.setSenha(request.getParameter("inputsenha"));
		f.setEmail(request.getParameter("inputemail"));
		f.setTelefone(request.getParameter("inputtelefone"));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(!"".equals(request.getParameter("inputaniversario"))){
			Date date = sdf.parse(request.getParameter("inputaniversario"));
			f.setAniversario(date);
		}
		if(!"".equals(request.getParameter("inputdataadmissao"))) {
			Date date = sdf.parse(request.getParameter("inputdataadmissao"));
			f.setDataAdmissao(date);
		}
		if("on".equals(request.getParameter("checkgerente"))) {
			f.setAdmin(1);
		}
		if("on".equals(request.getParameter("checkativo"))) {
			f.setStatus(1);
		}
		funcionarioRepo.save(f);
		return "redirect:funcionarios";
	}
	
	@GetMapping("ingredientes")
	public ModelAndView ingredientes () {
		ModelAndView mv = new ModelAndView("home/ingredientes");
		List<Ingrediente> ingredientes = (List<Ingrediente>) ingredienteRepo.findAll();
		mv.addObject("ingredientes", ingredientes);
		return mv;
		
	}
	@GetMapping("findingredientes")
	public void findingredientes(HttpServletResponse response) {
		List<Ingrediente> list = (List<Ingrediente>) ingredienteRepo.findAll();
		String json = new Gson().toJson(list);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@PostMapping("salvaringrediente")
	public String salvaringrediente (HttpServletRequest request) {
		Ingrediente i = new Ingrediente();
		if(!"".equals(request.getParameter("id"))) {
			i = ingredienteRepo.findOne(Integer.parseInt(request.getParameter("id")));
		}
		i.setNome(request.getParameter("inputnome"));
		//i.setEstoque(Integer.parseInt(request.getParameter("inputestoque")));
		i.setEstoque(0);
		i.setUnidade(request.getParameter("inputunidade"));
		ingredienteRepo.save(i);
		return "redirect:ingredientes";
	}
	
	@GetMapping("findingrediente")
	public void findingrediente(@RequestParam("id") Integer id, HttpServletResponse response) {
		Ingrediente i = ingredienteRepo.findOne(id);
		String json = new Gson().toJson(i);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("produtos")
	public ModelAndView produtos () {
		ModelAndView mv = new ModelAndView("home/produtos");
		List<Categoria> categorias = (List<Categoria>) categoriaRepo.findAll();
		mv.addObject("categorias", categorias);
		return mv;
		
	}
	
	@RequestMapping(value = "/listarProdutosPorCategoriaTodos/{id}")
	public void listarProdutosPorCategoriaTodos(@PathVariable("id") Long id, HttpServletResponse response) {

		List<Produto> produtos = (List<Produto>) produtoRepo.listarProdutosPorCategoriaTodos(id);
		String json = new Gson().toJson(produtos);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	@GetMapping("findProduto/{id}")
	public void findProduto(@PathVariable("id") Long id, HttpServletResponse response) {
		Produto p = produtoRepo.findOne(id);
		if (p.getImage() != null) {
			try {p.setImgTO64(DatatypeConverter.printBase64Binary(p.getImage()));} catch (Exception e) {e.printStackTrace();}
		}
		p.setImage(null);
		String json = new Gson().toJson(p);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
	
	@PostMapping("salvarproduto")
	public String salvarProduto(HttpServletRequest request, @RequestParam MultipartFile inputfoto) {
		Produto p = new Produto();		
		if(!"".equals(request.getParameter("id"))) {
			p = produtoRepo.findOne(Long.parseLong(request.getParameter("id")));
		}
		p.setNome(request.getParameter("inputnome"));
		p.setDescricao(request.getParameter("inputdescricao"));
		p.setPreco(Double.valueOf(request.getParameter("inputpreco")));
		if("on".equals(request.getParameter("checkativo"))) {
			p.setStatus(1);
		}else {
			p.setStatus(0);
		}		
		if(!inputfoto.isEmpty()) {
			try {
				InputStream is = inputfoto.getInputStream();
				p.setImage(IOUtils.toByteArray(is));
			} catch (IOException e1) {
				// TODO Auto-generated catch block
			}
		}		
		produtoRepo.save(p);
		return "redirect:produtos";
	}
	
	@GetMapping("findreceitasporproduto/{id}")
	public void findReceitasPorProduto (@PathVariable("id") Long id, HttpServletResponse response) {
		List<Receita> receitas = receitaRepo.listarReceitasPorProduto(id);
		for (int i = 0; i < receitas.size(); i++) {
			receitas.get(i).setIngrediente(ingredienteRepo.findOne((int) receitas.get(i).getIngrediente().getId()));
		}
		String json = new Gson().toJson(receitas);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
	@PostMapping ("salvarreceita")
	public void salvarReceita(HttpServletRequest request) {
		Receita r = new Receita();
		r.setQtd(Integer.parseInt(request.getParameter("qtd")));
		r.setProduto( produtoRepo.findOne(Long.parseLong(request.getParameter("idp"))));
		r.setIngrediente(ingredienteRepo.findOne(Integer.parseInt(request.getParameter("i"))));
		receitaRepo.save(r);
		
	}
	@DeleteMapping ("deletereceita/{id}")
	public void deleteReceita(@PathVariable("id") long id) {
		receitaRepo.delete(id);
	}

	@GetMapping("findestabelecimento")
	public void findEstabelecimento(HttpServletResponse response) {
		String json = new Gson().toJson( (Estabelecimento) estabelecimentoRepo.findOne(1));
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");		
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
	
	@GetMapping("compras")
	public ModelAndView compras() {
		ModelAndView mv = new ModelAndView("home/compra");
		List<Ingrediente> i = (List<Ingrediente>) ingredienteRepo.findAll();
		List<Compra> c = (List<Compra>) compraRepo.findAll();
		mv.addObject("ingredientes", i);
		mv.addObject("compras", c);
		return mv;
	}
	
	@PostMapping("salvarcompra")
	public ModelAndView salvarCompra(HttpServletRequest request, @ModelAttribute("funcionarioid") int f_id) {
		Compra c = new Compra();
		c.setQtd(Integer.parseInt(request.getParameter("inputqtd")));
		c.setIngrediente(ingredienteRepo.findOne(Integer.parseInt(request.getParameter("selectingredientes"))));
		c.getIngrediente().setEstoque(c.getIngrediente().getEstoque()+c.getQtd());		
		Date hora = Calendar.getInstance().getTime();
		c.setDate(hora);
		c.setValor(Double.valueOf(request.getParameter("inputvalor")));
		c.setFuncionario(funcionarioRepo.findOne(f_id));
		compraRepo.save(c);
		return compras();
	}
	@GetMapping("estoque")
	public ModelAndView estoque() {
		ModelAndView mv = new ModelAndView("home/estoque");
		List<Ingrediente> i = (List<Ingrediente>) ingredienteRepo.findAll();
		mv.addObject("ingredientes", i);
		return mv;
	}

}
