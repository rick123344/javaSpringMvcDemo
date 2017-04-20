package rick.app.config;

import javax.sql.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.ResourceBundleMessageSource;

@Configuration
//set Bean's properties path
@PropertySource("classpath:properties/testMsg.properties")
@PropertySource("classpath:properties/second.properties")
public class Config {
    
	@Bean(name = "messageSource")
	public static MessageSource messageSource() {
		ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
		messageSource.setBasenames("properties/testMsg");//testMsg
		messageSource.setDefaultEncoding("UTF-8");
		return messageSource;
	} 
	
}


