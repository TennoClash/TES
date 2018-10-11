package teavs.entity;

public class EvaDetail {
	int Id;
String teacher_id;
String semester;
String course_id;
String eva_user;
int eva_type;
String score;
String eva_time;
public int getId() {
	return Id;
}
public void setId(int id) {
	Id = id;
}
public String getTeacher_id() {
	return teacher_id;
}
public void setTeacher_id(String teacher_id) {
	this.teacher_id = teacher_id;
}
public String getSemester() {
	return semester;
}
public void setSemester(String semester) {
	this.semester = semester;
}
public String getCourse_id() {
	return course_id;
}
public void setCourse_id(String course_id) {
	this.course_id = course_id;
}
public String getEva_user() {
	return eva_user;
}
public void setEva_user(String eva_user) {
	this.eva_user = eva_user;
}
public int getEva_type() {
	return eva_type;
}
public void setEva_type(int eva_type) {
	this.eva_type = eva_type;
}
public String getScore() {
	return score;
}
public void setScore(String score) {
	this.score = score;
}
public String getEva_time() {
	return eva_time;
}
public void setEva_time(String eva_time) {
	this.eva_time = eva_time;
}


}
