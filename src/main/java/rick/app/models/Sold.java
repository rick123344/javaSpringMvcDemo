package rick.app.models;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Column;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import javax.persistence.CascadeType;

import lombok.Data;

@Entity
@Data
public class Sold{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@Column(name="books_id")
	private Long booksId;
	private Long count;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="books_id",referencedColumnName="id",insertable=false,updatable=false)
	private Books book;
	
}
//green night     no frauds  