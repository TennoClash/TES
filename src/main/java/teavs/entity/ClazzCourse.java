package teavs.entity;

public class ClazzCourse {
	int Id;
	String course_num;
	String clazz_num;

	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public String getCourse_num() {
		return course_num;
	}

	public void setCourse_num(String course_num) {
		this.course_num = course_num;
	}

	public String getClazz_num() {
		return clazz_num;
	}

	public void setClazz_num(String clazz_num) {
		this.clazz_num = clazz_num;
	}

	public ClazzCourse() {
		super();
		// TODO Auto-generated constructor stub
	}

}
