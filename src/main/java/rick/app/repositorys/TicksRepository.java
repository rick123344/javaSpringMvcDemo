package rick.app.models;

import java.util.List;

public interface TicksRepository extends BaseRepository<Ticks> {
	
    List<Ticks> findBytick(String tick);
}