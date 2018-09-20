package teavs.entity;

public class User {
int Id;
String user_name;
String password;
String user_number;
String d_type;
int user_type;

public User() {
	super();
	// TODO Auto-generated constructor stub
}
public int getId() {
	return Id;
}
public void setId(int id) {
	Id = id;
}
public String getUser_name() {
	return user_name;
}
public void setUser_name(String user_name) {
	this.user_name = user_name;
}
public String getPassword() {
	return password;
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
public String getD_type() {
	return d_type;
}
public void setD_type(String d_type) {
	this.d_type = d_type;
}



}
