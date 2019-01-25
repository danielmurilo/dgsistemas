package br.com.dgsistemas.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import br.com.dgsistemas.models.Categoria;
import br.com.dgsistemas.models.CategoriaRepo;
import br.com.dgsistemas.models.Conta;
import br.com.dgsistemas.models.ContaRepo;
import br.com.dgsistemas.models.Funcionario;
import br.com.dgsistemas.models.FuncionarioRepo;
import br.com.dgsistemas.models.Pedido;
import br.com.dgsistemas.models.PedidoRepo;
import br.com.dgsistemas.models.PedidoSerializado;
import br.com.dgsistemas.models.Produto;
import br.com.dgsistemas.models.ProdutoRepo;

@Controller
@SessionAttributes({"funcionarioid", "contaid"})
public class HomeController
{

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
	
	   @ModelAttribute("funcionarioid")
	   public int setarFuncionarioIdNaSession() {
	      return 0;
	   }
	   @ModelAttribute("contaid")
	   public Long setarContaIdnNaSession() {
	      return (long) 0;
	   }
	   
	
	
	

   @GetMapping("/mainpage")
   public ModelAndView mainpage()
   {
	   ModelAndView mv = new ModelAndView("home/mainpage");
		List<Conta> lists = (List<Conta>) contaRepo.listarContasComTotal();		
		mv.addObject("lists", lists);
		return mv;
   }
   
   @RequestMapping("/")
	public ModelAndView login() {
		ModelAndView mv = new ModelAndView("home/index");
		mv.addObject("hidden_attribute", "hidden");
		return mv;
	}
   
   @RequestMapping(value = "/login")
	public ModelAndView login(ModelMap model, HttpServletRequest request, HttpServletResponse res, @ModelAttribute("funcionarioid") int f_id ) {
	   
		ModelAndView mv;
		Funcionario funcionario = new Funcionario();		
		funcionario = funcionarioRepo.doLogin(request.getParameter("login"), request.getParameter("password"));
		if (funcionario != null) {
			mv = new ModelAndView("home/mainpage");
			List<Conta> lists = (List<Conta>) contaRepo.listarContasComTotal();		
			mv.addObject("lists", lists);
			
			//adcionando dados funcionario a session
			f_id = funcionario.getId();
			model.addAttribute("funcionarioid", f_id);
			
			//adcionando dados funcionario a mainpage
			mv.addObject("funcionario_id", funcionario.getId());
			mv.addObject("funcionario_nome", funcionario.getNome());

		} else {
			mv = new ModelAndView("home/index");
			mv.addObject("hidden_attribute", "");
			mv.addObject("message1", "Ops!");
			mv.addObject("message2", "Login ou senha não encontrados!");

		}
		return mv;

	}
   
   @RequestMapping(value = "/conta/{id}")
	public ModelAndView listarPedidosPorConta(ModelMap model, @PathVariable("id") Long id, @ModelAttribute("contaid") Long contaid){
	   //setando contaid na session 
	   contaid = id;
	    model.addAttribute("contaid",contaid);
	    
	    ModelAndView mv;		
		mv = new ModelAndView("home/conta");
		List<Pedido> lists = (List<Pedido>) pedidoRepo.listarPedidosPorConta(id);
		Conta conta = (Conta) contaRepo.findContaComtotal(id);
		conta.setTotal(contaRepo.findTotal(id));
		mv.addObject("lists", lists);
		mv.addObject("conta", conta);
		return mv;

	}
   
   @RequestMapping("/abrirconta")
   public ModelAndView abrirconta()
   {
	   ModelAndView mv = new ModelAndView("home/abrirconta");
	   return mv;
   }  
   
   
   @RequestMapping(value = "/abrirconta/salvarconta")
	public ModelAndView salvarconta(HttpServletRequest request, @ModelAttribute("funcionarioid") int f_id ) {
		ModelAndView mv = new ModelAndView("home/mainpage");
		
		   Conta c = new Conta();
		   c.setStatus(1);
		   c.setNome_mesa(request.getParameter("nome_mesa"));
		   c.setTotal(0.00);
		   Date hora = Calendar.getInstance().getTime();
		   c.setDataAbertura(hora);
		   c.setFuncionarioAbertura(funcionarioRepo.findOne(f_id));
		   contaRepo.save(c);		   
		   List<Conta> lists = (List<Conta>) contaRepo.listarContasComTotal();		
			mv.addObject("lists", lists);
			System.out.println("id:"+ f_id);
	      return mv;
   }
   
   @RequestMapping("/fecharconta")
   public ModelAndView fecharconta(ModelMap model, HttpServletRequest request) 
   {
	   return new ModelAndView("home/fecharconta");
   }
   
   
   
   @RequestMapping("/lancarpedido")
   public ModelAndView lancarpedido(ModelMap model, HttpServletRequest request, @ModelAttribute("contaid") Long contaid)
   {
	   ModelAndView mv = new ModelAndView("home/lancarpedido");
	   mv.addObject("categorias", (List<Categoria>)categoriaRepo.listarCategoriasAtivas());
	   model.addAttribute("contaid", contaid);
	   return mv;
   }
   
   @RequestMapping("/salvarPedidos")
   public ModelAndView salvarPedido(@RequestBody String json, @ModelAttribute("contaid") Long contaid, @ModelAttribute("funcionarioid") int f_id) {
	   ObjectMapper mapper = new ObjectMapper();
	   try {
			PedidoSerializado[] pedidos = mapper.readValue(json, PedidoSerializado[].class);
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
			    pedidoRepo.save(pedido);

			} 
		
		} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}    
	   System.out.println(json);
	   return new ModelAndView("home/mainpage");   
   }
   
   @RequestMapping("/lancardinheiro/{valor}")
   public String lancardinheiro(@PathVariable("valor") Double valor, @ModelAttribute("contaid") Long contaid, @ModelAttribute("funcionarioid") int f_id) {
	   Pedido p = new Pedido();
	   p.setObs("Pagamento");
	   p.setValorVenda(valor*-1.00);
	   p.setQtd(1);
	   p.setStatus(1);
	   Date hora = Calendar.getInstance().getTime();
	   p.setData(hora);
	   p.setProduto(produtoRepo.findOne((long) 1));
	   p.setConta(contaRepo.findOne(contaid));
	   p.setFuncionario(funcionarioRepo.findOne(f_id));	   
	   pedidoRepo.save(p);
	   return "/conta/"+contaid;
   }
   
   
   
   @RequestMapping("/lancarcartao/{valor}")
   public String lancarcartao(@PathVariable("valor") Double valor, @ModelAttribute("contaid") Long contaid, @ModelAttribute("funcionarioid") int f_id) {
	   Pedido p = new Pedido();
	   p.setObs("Pagamento");
	   p.setValorVenda(valor *-1.00);
	   p.setQtd(1);
	   p.setStatus(1);
	   Date hora = Calendar.getInstance().getTime();
	   p.setData(hora);
	   p.setProduto(produtoRepo.findOne((long) 2));
	   p.setConta(contaRepo.findOne(contaid));
	   p.setFuncionario(funcionarioRepo.findOne(f_id));	   
	   pedidoRepo.save(p);
	   return "/conta/"+contaid;
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
	  if(contaRepo.findTotal(contaid)==0.00) {
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
   public ModelAndView exibirCaixa(@RequestParam("inputCaixaDate") @DateTimeFormat(pattern="yyyy-MM-dd") Date date, @PathVariable("idFuncionario") String idFuncionario) {
	   System.out.println(date + " idFuncionario:" + idFuncionario);
	   ModelAndView mv = new ModelAndView("home/caixa");
	   List<Conta> contas;
	   if(Integer.parseInt(idFuncionario) > 0) {
		   contas = (List<Conta>)contaRepo.listarContasComTotalPorDataAndFuncionario(date, Integer.parseInt(idFuncionario));
		   mv.addObject("valortotalemdinheiro", pedidoRepo.valorTotalVendasEmDinheiroPorDataAndFuncionario(date, Integer.parseInt(idFuncionario)));		   
		   mv.addObject("valortotalemcartao", pedidoRepo.valorTotalVendasEmCartaoPorDataAndFuncionario(date, Integer.parseInt(idFuncionario)));	   
	   }else {
		   contas = (List<Conta>)contaRepo.listarContasComTotalPorData(date);
		   mv.addObject("valortotalemdinheiro", pedidoRepo.valorTotalVendasEmDinheiroPorData(date));
		   mv.addObject("valortotalemcartao", pedidoRepo.valorTotalVendasEmCartaoPorData(date));	   
	   }
	   
	   for (int i = 0; i < contas.size(); i++) {
		   try {
			contas.get(i).setFuncionarioAbertura(funcionarioRepo.findOne(contas.get(i).getFuncionarioAbertura().getId()));
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
	} catch (Exception e) {	}	   
	   
   }
   @RequestMapping(value = "/getIdTaxaEmbalagem")
   public void getIdTaxaEmbalagem(HttpServletResponse response) {
	   try {
		   response.setContentType("text/html");
		   PrintWriter out = response.getWriter();
		   out.append(categoriaRepo.getIdTaxaEmbalagem());
		   out.close();
	} catch (Exception e) {	}		   
	   
   }
   

  
   
   
}
