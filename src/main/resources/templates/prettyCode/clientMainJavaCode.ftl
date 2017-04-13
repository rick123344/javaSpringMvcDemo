package rick.app.controller;

...

//customer annotation
import rick.app.annotation.*;

@Controller
@AnnoRick(level=AnnoRick.Level.UNIT,name="HRick")
public class HomeController {
	
	...
	
    @RequestMapping("/home")
	@AnnoRick(level=AnnoRick.Level.UNIT,name="MethodRick")
	public String homes(@RequestParam(value="name", required=false, defaultValue="World") String name, Model model,HttpServletRequest req) {
        
		...
		
		return "index";
    }
}