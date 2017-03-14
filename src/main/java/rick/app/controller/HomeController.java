package rick.app.controller;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestBody;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.beans.factory.annotation.Autowired;

import org.json.JSONObject;

//models
import rick.app.models.*;
import rick.app.viewmodels.*;

@Controller
public class HomeController {
	
	//init implement repository (because can't be new )
	@Autowired
	private TicksRepository repository;
	
    @RequestMapping("/home")
    public String home(@RequestParam(value="name", required=false, defaultValue="World") String name, Model model,HttpServletRequest req) {
        
		//get the Bean data
		/*AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext();
		ctx.register(Config.class);
		ctx.refresh();
		MessageSource resources = ctx.getBean(MessageSource.class);
		String admin = resources.getMessage("user.admin", null, "Default", null);
		System.out.println(admin);*/
		
		model.addAttribute("name", name);
		req.setAttribute("test","123456789");
		
		List<String> lang = new ArrayList<String>();
		lang.add("Chinese");
		lang.add("English");
		lang.add("Genemar");
		model.addAttribute("lang",lang);
		
		for (Ticks ticks : repository.findAll()) {
			lang.add(ticks.toString());
		}
		getAnother();
		return "index";// it's will archieve to src/main/resources/templates/index.ftl	
    }
	
	@ModelAttribute("another")
	public String getAnother(){
		return "yes amn";
	}
	
	@RequestMapping(value = "/test")
	public @ResponseBody String test(@RequestBody String tick,HttpServletRequest req,@RequestParam("tick") String t){
		JSONObject obj = new JSONObject();
		obj.put("data",t);
		obj.put("test",req.getParameter("id").toString());
		return obj.toString();
	}
	
	@RequestMapping(value = "/test2")
	public @ResponseBody String test2(@ModelAttribute(value="myform") UserViewModel user,@RequestBody String s){
		JSONObject obj = new JSONObject();
		System.out.println(s);
		System.out.println(user);
		obj.put("data",user);
		//obj.put("test",req.getParameter("id").toString());
		return obj.toString();
	}
	
}

/********************************************************

@ModelAttribute using model class is ViewModel,
not JPA model

********************************************************/