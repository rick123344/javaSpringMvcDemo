/*package rick.app.service;

import java.util.List;
import java.util.stream.Collectors;
import rick.app.models.Ticks;

import org.springframework.stereotype.Service;

@Service
public interface TickServiceImpl implements TickService{
	
	private List<Ticks> ticks = new ArrayList<Ticks>();
	
	@Override
	List<Ticks> findAll(){
		return this.ticks;
	}
	
	@Override
	List<Ticks> findLatest(){
		return this.ticks.stream()
			.limit(5)
			.collect(Collectors.toList());
	}
	
	@Override
	List<Ticks> findBytick(){
		
	}
	
	@Override
	Ticks findById(Long id){
		
	}
	
	@Override
	Ticks create(Ticks tick){
		
	}
	
	@Override
	Ticks edit(Ticks tick){
		
	}
	
	@Override
	void deleteById(Long id){
		
	}
	
    //List<Ticks> findBytick(String tick);
}*/