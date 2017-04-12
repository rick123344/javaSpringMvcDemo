package rick.app.models;

import java.util.List;

public interface SoldRepository extends BaseRepository<Sold> {
	
    List<Sold> findBybooksId(Long bid);
	
	List<Sold> findBycount(Long count);
	
}