package rick.app.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Column;

import lombok.Data;

@Entity
@Data
public class Books{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String name;
	private Long price;
	@Column(name="publish_id")
	private Long publishId;
	@Column(name="author_id")
	private Long authorId;
	
}