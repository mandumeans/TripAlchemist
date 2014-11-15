package member.dto;

public class MemberDTO {
	private String email;
	private String password;
	private String name;
	private String gender;
	private String DOB;
	public MemberDTO(){
		super();
	}
	public MemberDTO(String email, String password, String name, String gender, String DOB){
		super();
		this.email = email;
		this.password = password;
		this.name = name;
		this.gender = gender;
		this.DOB = DOB;
	}
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	public String getPassword(){
		return password;
	}
	public void setPassword(String password){
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getDOB() {
		return DOB;
	}
	public void setDOB(String DOB) {
		this.DOB = DOB;
	}
	public String toString(){
		return "MemberDTO [email =" + email + ",password = " + password + ",name =" + name + ",gender=" + gender +",DOB =" + DOB +"]";
	}
	public int hashCode(){
		final int prime = 31;
		int result =1;
		result = prime * result +((email == null) ? 0 :email.hashCode());
		result = prime * result +((name == null)? 0 :name.hashCode());
		result = prime * result +((password ==null)? 0 : password.hashCode());
		result = prime *result +((gender == null)? 0 : gender.hashCode());
		result = prime *result +((DOB == null)? 0 : DOB.hashCode());
		return result;
	}
	public boolean equals(Object obj){
		if(this == obj)
			return true;
		if(obj == null)
			return false;
		if(getClass() != obj.getClass())
			return false;
		MemberDTO other = (MemberDTO)obj;
		if(email == null){
			if(other.email != null)
				return false;
		}else if(!email.equals(other.email))
			return false;
		if(name == null){
			if(other.name != null)
				return false;
		}else if(!name.equals(other.name))
			return false;
		if(password == null){
			if(other.password != null)
				return false;
		}else if(!password.equals(other.password))
			return false;
		if(gender== null){
			if(other.gender != null)
				return false;
		}else if(!gender.equals(other.gender))
			return false;
		if(DOB== null){
			if(other.DOB != null)
				return false;
		}else if(!DOB.equals(other.DOB))
			return false;
		return true;			
	}
	
}
