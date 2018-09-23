package teavs.entity;

public class TeacherCourse {
	int Id;
	String course_num;
	String teacher_num;
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
	public String getTeacher_num() {
		return teacher_num;
	}
	public void setTeacher_num(String teacher_num) {
		this.teacher_num = teacher_num;
	}

	
}
