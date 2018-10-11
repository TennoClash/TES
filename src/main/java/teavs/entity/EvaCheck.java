package teavs.entity;

public class EvaCheck {
	String course_name;
	String user_name;
	String teacher_id;
	String eva_user;
	String semester;
	String course_num;
	int Id;
	int eva_state;
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getEva_state() {
		return eva_state;
	}
	public void setEva_state(int eva_state) {
		this.eva_state = eva_state;
	}
	public String getTeacher_id() {
		return teacher_id;
	}
	public void setTeacher_id(String teacher_id) {
		this.teacher_id = teacher_id;
	}

	public String getEva_user() {
		return eva_user;
	}
	public void setEva_user(String eva_user) {
		this.eva_user = eva_user;
	}
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
	public String getCourse_num() {
		return course_num;
	}
	public void setCourse_num(String course_num) {
		this.course_num = course_num;
	}
	
	
}
