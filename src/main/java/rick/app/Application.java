package rick.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class Application{
	
	private static final Logger log = LoggerFactory.getLogger(Application.class);
	
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
	
	/*@Bean
	public CommandLineRunner demo(TicksRepository repository) {
		return (args) -> {
			// save a couple of customers
			repository.save(new Ticks("Tickssss1"));
			repository.save(new Ticks("Tikceeee2"));
			// fetch all customers
			log.info("Customers found with findAll():");
			log.info("-------------------------------");
			for (Ticks ticks : repository.findAll()) {
				log.info(ticks.toString());
				System.out.println(ticks.toString());
			}
			log.info("");

			// fetch an individual customer by ID
			Ticks tick = repository.findOne(1L);
			log.info("Customer found with findOne(1L):");
			log.info("--------------------------------");
			log.info(tick.toString());
			log.info("");

			// fetch customers by last name
			log.info("Customer found with findByLastName('hello'):");
			log.info("--------------------------------------------");
			for (Ticks bauer : repository.findBytick("hello")) {
				log.info(bauer.toString());
			}
			log.info("");
		};
	}
	*/
	
}


/**********************************************************

Default freemarker file path => src/main/resources/templates/
	using in controller :
	public String home(Model model){
		model.addAttribute("name","some value");
		return "index"; => get the .ftl in src/main/resources/templates/index.ftl
	}

Default static file path => src/main/public/
	using in *.ftl file:
	It's wrong to put public in href or src (/public/css/...)	
	<link href="/css/bootstrap.min.css" rel="stylesheet"/>
	<script src="/js/jquery.min.js"></script>

Default application.properties path => src/main/resources/application.properties

***********************************************************/