package teavs.entity;

public class teacher {
	int Id;
	String user_name;
	String password;
	String user_number;
	int user_type;
	String ministry_id;
	String semester;
	
	

	public String getSemester() {
		return semester;
	}

	public void setSemester(String semester) {
		this.semester = semester;
	}

	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public String getPassword() {
		return password;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUser_number() {
		return user_number;
	}

	public void setUser_number(String user_number) {
		this.user_number = user_number;
	}

	public int getUser_type() {
		return user_type;
	}

	public void setUser_type(int user_type) {
		this.user_type = user_type;
	}

	public String getMinistry_id() {
		return ministry_id;
	}

	public void setMinistry_id(String ministry_id) {
		this.ministry_id = ministry_id;
	}

}
