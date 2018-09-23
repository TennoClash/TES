package teavs.dao;

import java.util.List;

import teavs.entity.Clazz;
import teavs.entity.ClazzCourse;
import teavs.entity.Course;
import teavs.entity.TeacherCourse;
import teavs.entity.User;
import teavs.entity.student;
import teavs.entity.teacher;

public interface UpDateDao {
	int upInfo(List<student> students);
	
	int upInfo_t(List<teacher> teachers);
	
	int S_Role_Update(List<student> students);
	
	int T_Role_Update(List<teacher> teachers);
	
	int Course_Update(List<Course> courses);
	
	int Clazz_Update(List<Clazz> clazzs);
	
	int Clazz_Course_Update(List<ClazzCourse> clazzCourses);

	int Teacher_Course_Update(List<TeacherCourse> teacherCourses);
	
}
