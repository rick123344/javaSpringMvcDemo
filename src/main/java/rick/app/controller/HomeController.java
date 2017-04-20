package rick.app.controller;

import java.lang.reflect.Method; 
import java.util.HashSet; 
import java.util.Set;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;

import java.lang.StringBuilder;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import org.json.JSONObject;

//models
import rick.app.models.*;
//config beans
import rick.app.config.*;
//customer annotation
import rick.app.annotation.*;

@Controller
@AnnoRick(level=AnnoRick.Level.UNIT,name="HRick")
public class HomeController {
	
	@Value("#{'${user.dir}'.concat('${Sys.uploadPath}')}")
	public String path;
	
	@Value("#{'${user.dir}'.concat('${Sys.slidePath}')}")
	public String silder;
	
	private String progress = "0";
	
	//init implement repository (because can't be new )
	@Autowired
	private TicksRepository tickRepository;
	@Autowired
	private PublishRepository publishRepository;
	@Autowired
	private AuthorRepository authorRepository;
	@Autowired
	private BooksRepository bookRepository;
	@Autowired
	private SoldRepository soldRepository;
	
	//@Value => #表示spel(spring expression language)內容, $表示一般properties、yml等檔案的屬性
	// #=>#{?:}  =>可直接預設值   @Value("#{'abcdffffff'}")  
	// $=>${:}   =>不可直接預設值
	//@Value("#{'${user.dir}'.concat('yesss')?:noSuchVar}")
	//private	String hello;
	
	//when using @Value , the properties must be regist by using @PropertySource (annotation bean) to classpath
	//@Value("${user.admin:noSuchVar}")
	//@Value("#{messageSource[user.admin]?:noSuchVar}")//not working
	@Value("${what.the.fxck:noSuchVar}")
	private String hello;
	
	HomeController(){
		//instead using follow code, you can just using @Value to get properties data
		/*AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext();
		ctx.register(Config.class);
		ctx.refresh();
		MessageSource resources = ctx.getBean(MessageSource.class);
		path = System.getProperty("user.dir")+resources.getMessage("Sys.uploadPath", null, "Default", null);
		silder = System.getProperty("user.dir")+resources.getMessage("Sys.slidePath", null, "Default", null);*/
	}
	
    @RequestMapping("/home")
	@AnnoRick(level=AnnoRick.Level.UNIT,name="MethodRick")
	public String homes(@RequestParam(value="name", required=false, defaultValue="World") String name, Model model,HttpServletRequest req) {
        
		model.addAttribute("name", name);
		req.setAttribute("test","Request");
		
		getPublish();
		
		//System.out.println(hello);
		
		File file = new File(path);
		model.addAttribute("files",file.listFiles());
		
		List<Map> silderss = new ArrayList<Map>();
		file = new File(silder);
		for(File i : file.listFiles()){
			Map silders = new HashMap();
			silders.put("path","/Silder/"+i.getName());//
			silders.put("tag",i.getName());
			silders.put("descript","Beautiful Place "+i.getName());
			silderss.add(silders);
		}
		model.addAttribute("silder",silderss);
		
		return "index";// it's will archieve to src/main/resources/templates/index.ftl	
    }
	
	@RequestMapping("/annotation")
	public String homes(@RequestParam(value="name", required=false, defaultValue="World") String name, Model model) {
		return "annotation";
	}
	
	@RequestMapping("/upload")
    public String upload(@RequestParam("atta") MultipartFile[] files,Model model) {
		//System.out.println("testUpload");
		
		File dir = new File(path);
		if(!dir.exists()){
			try{
				dir.mkdir();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		System.out.println(path);
		try{
			for(MultipartFile uploadedFile : files) {
				File file = new File(path + uploadedFile.getOriginalFilename());
				uploadedFile.transferTo(file);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "redirect:home";
	}
	
	@ModelAttribute("pub")
	public Publish getPublish(){
		Publish p = new Publish();
		p.setName("SmilePublish");
		p.setId(new Long(55));
		return p;
	}
	
	//despacito stay 
	@RequestMapping(value = "/test")
	public @ResponseBody String test(@RequestBody String tick,HttpServletRequest req,@RequestParam("tick") String t){
		JSONObject obj = new JSONObject();
		
		obj.put("test",req.getParameter("id").toString());
		
		Ticks tes = tickRepository.findOne(new Long(1));
		System.out.println(tes.toString());
		t = t+" "+tes.toString();
		
		Publish p = publishRepository.findOne(new Long(1));
		System.out.println(p.toString());
		t = t+" "+p.toString();
		
		Author a = authorRepository.findOne(new Long(1));
		System.out.println(a.toString());
		t = t+" "+a.toString();
		
		Books b = bookRepository.findOne(new Long(2));
		System.out.println(b.toString());
		t = t+" "+b.toString();
		
		Sold s = soldRepository.findOne(new Long(1));
		System.out.println(s.toString());
		t = t+" "+s.toString();
		
		/*Ticks tes = tickRepository.save(getTick());
		System.out.println(tes.getId());
		System.out.println(tes.getTick());
		
		Ticks tt = tickRepository.findOne(new Long(1));
		System.out.println(tt.getId());
		System.out.println(tt.getTick());
		
		tickRepository.delete(tes.getId());*/
		obj.put("data",t);
		
		//simple test for the annotation is have values
		/*try{
			Class test = Class.forName("rick.app.controller.HomeController");
			Method[] method = test.getMethods();
			for(Method m: method) { 
				boolean flag = m.isAnnotationPresent(AnnoRick.class);
				if(flag){
					System.out.println(m.toString());
					AnnoRick ar = (AnnoRick)m.getAnnotation(AnnoRick.class);
					System.out.println(ar.name());
					System.out.println(ar.level());
					System.out.println(ar.tester());
				}
			} 
		}catch(Exception e){
			e.printStackTrace();
		}*/
		
		return obj.toString();
	}
	
	@RequestMapping(value = "/testEntityModel")
	public @ResponseBody String testEntityModel(@ModelAttribute(value="myform") Author author,@RequestBody String s){
		JSONObject obj = new JSONObject();
		System.out.println(s);
		System.out.println(author);
		obj.put("data",author);
		//obj.put("test",req.getParameter("id").toString());
		return obj.toString();
	}
	
	@RequestMapping(value = "/test2")
	@ResponseBody
	public String test2(@ModelAttribute(value="myform") Author author,@RequestBody String s){
		JSONObject obj = new JSONObject();
		System.out.println(s);
		System.out.println(author);
		obj.put("data",author);
		
		/*for(String l : author.getLinks()){
			obj.put(l,l);
		}*/
		
		obj.put("s",s);
		//obj.put("test",req.getParameter("id").toString());
		return obj.toString();
	}
	
	@RequestMapping(value="/getDbData")
	@ResponseBody
	public String dbData(){
		progress = "0";
		JSONObject obj = new JSONObject();
		obj.put("tick",tickRepository.findAll());
		progress = "0.2";
		obj.put("public",publishRepository.findAll());
		progress = "0.4";
		obj.put("author",authorRepository.findAll());
		progress = "0.6";
		obj.put("book",bookRepository.findAll());
		progress = "0.8";
		obj.put("sold",soldRepository.findAll());
		progress = "0.95";
		return obj.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/progress")
	public String getProgress(){
		return progress;
	}
	
	@ResponseBody
	@RequestMapping(value = "/doajax")
	public String test(@RequestParam("user") String t){
		return t;
	}
	
}

enum test{
	妳好(5);
	
	test(int value){this.value=value;}
	private int value;
	public int value(){return value;}
	
}
