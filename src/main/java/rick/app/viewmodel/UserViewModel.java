package rick.app.viewmodels;

public class UserViewModel{
	
	private Long id;
	private String user;
	
	protected UserViewModel(){}
	
	public void setUser(String user){
		this.user = user;
	}
	
	public String getUser(){
		return user;
	}
	
	public void setId(Long id){
		this.id = id;
	}
	
	public Long getId(){
		return id;
	}
	
	@Override
	public String toString(){
		return String.format("User : [id=%d ,value=%s ]",id,user);
	}
	
}