package rick.app.models;

import java.util.List;

public interface BooksRepository extends BaseRepository<Books> {
	
    List<Books> findByname(String name);
	
	List<Books> findByprice(Long price);
	
	List<Books> findBypublishId(Long pid);
	
	List<Books> findByauthorId(Long aid);
	
}