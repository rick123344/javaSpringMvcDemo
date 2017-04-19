package rick.app.models;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Column;
import javax.persistence.OneToMany;
import javax.persistence.JoinColumn;
import javax.persistence.FetchType;
import javax.persistence.CascadeType;

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
	
	//mappedBy using declared variable, and JoinColumn name using database real column name
	//@OneToMany(mappedBy="booksId",cascade = CascadeType.ALL)
	//@JoinColumn(name="books_id",insertable=false,updatable=false)
	//private List<Sold> solds;
	
}