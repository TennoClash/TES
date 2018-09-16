package TES.entity;

public class teacher {
	int Id;
	String user_name;
	String password;
	String user_number;
	int user_Type;
	int ministry_id;

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

	public int getUser_Type() {
		return user_Type;
	}

	public void setUser_Type(int user_Type) {
		this.user_Type = user_Type;
	}

	public int getMinistry_id() {
		return ministry_id;
	}

	public void setMinistry_id(int ministry_id) {
		this.ministry_id = ministry_id;
	}

}
