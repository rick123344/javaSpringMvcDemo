package rick.app.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Ticks{
	
	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String tick;
	
	protected Ticks(){}
	
	public Ticks(String tick){
		this.tick = tick;
	}
	
	@Override
	public String toString(){
		return String.format("Tick : [id=%d ,value=%s ]",id,tick);
	}
	
}