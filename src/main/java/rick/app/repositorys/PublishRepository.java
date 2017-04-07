package rick.app.models;

import java.util.List;

public interface PublishRepository extends BaseRepository<Publish> {
	
    List<Publish> findByname(String name);
}