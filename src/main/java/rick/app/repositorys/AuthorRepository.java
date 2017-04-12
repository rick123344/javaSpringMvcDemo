package rick.app.models;

import java.util.List;

public interface AuthorRepository extends BaseRepository<Author> {
	
    List<Author> findByname(String name);
	
	List<Author> findByage(Long age);
	
}