package TES.dao;

import java.util.List;

import TES.entity.Clazz;
import TES.entity.ClazzCourse;
import TES.entity.Course;
import TES.entity.User;
import TES.entity.student;
import TES.entity.teacher;

public interface UpDateDao {
	int upInfo(List<student> students);
	
	int upInfo_t(List<teacher> teachers);
	
	int S_Role_Update(List<student> students);
	
	int Course_Update(List<Course> courses);
	
	int Clazz_Update(List<Clazz> clazzs);
	
	int Clazz_Course_Update(List<ClazzCourse> clazzCourses);
	
}
