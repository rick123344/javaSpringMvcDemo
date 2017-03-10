package rick.app.models;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

public interface TicksRepository extends CrudRepository<Ticks, Long> {

    List<Ticks> findBytick(String tick);
}