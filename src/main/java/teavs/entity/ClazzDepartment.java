package teavs.entity;

public class ClazzDepartment {
	int Id;
	String clazz_name;
	String clazz_num;
	String ministry_id;
	String institute;
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public String getClazz_name() {
		return clazz_name;
	}
	public void setClazz_name(String clazz_name) {
		this.clazz_name = clazz_name;
	}
	public String getClazz_num() {
		return clazz_num;
	}
	public void setClazz_num(String clazz_num) {
		this.clazz_num = clazz_num;
	}
	public String getMinistry_id() {
		return ministry_id;
	}
	public void setMinistry_id(String ministry_id) {
		this.ministry_id = ministry_id;
	}
	public String getInstitute() {
		return institute;
	}
	public void setInstitute(String institute) {
		this.institute = institute;
	}
	public ClazzDepartment() {
		super();
		// TODO Auto-generated constructor stub
	}


	

}
