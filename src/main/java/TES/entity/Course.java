package TES.entity;

public class Course {
	int Id;
	private String course_name;
	private String course_num;
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public String getCourse_num() {
		return course_num;
	}
	public void setCourse_num(String course_num) {
		this.course_num = course_num;
	}
	public Course() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
