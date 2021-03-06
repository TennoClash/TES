package teavs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teavs.dao.UpDateDao;
import teavs.dao.UserDao;
import teavs.entity.Clazz;
import teavs.entity.ClazzCourse;
import teavs.entity.Course;
import teavs.entity.TeacherCourse;
import teavs.entity.User;
import teavs.entity.student;
import teavs.entity.teacher;

@Service
public class UpDateService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private UpDateDao upDateDao;

	public int updateSPassWord(User user) {
		return userDao.updateSPassWord(user);
	}

	public int updateTPassWord(User user) {
		return userDao.updateTPassWord(user);
	}

	public int upInfo(List<student> students) {
		return upDateDao.upInfo(students);
	}

	public int upInfo_t(List<teacher> teachers) {
		return upDateDao.upInfo_t(teachers);
	}

	public int S_Role_Update(List<student> students) {
		return upDateDao.S_Role_Update(students);
	}
	
	public int T_Role_Update(List<teacher> teachers) {
		return upDateDao.T_Role_Update(teachers);
	}
	
	public int Course_Update(List<Course> courses){
		return upDateDao.Course_Update(courses);
	}
	
	public int Clazz_Update(List<Clazz> clazzs){
		return upDateDao.Clazz_Update(clazzs);
	}
	
	public int Clazz_Course_Update(List<ClazzCourse> clazzCourses){
		return upDateDao.Clazz_Course_Update(clazzCourses);
	}
	
	public int Teacher_Course_Update(List<TeacherCourse> teacherCourses){
		return upDateDao.Teacher_Course_Update(teacherCourses);
	}
	
	public int deleteStudent(int id){
		return userDao.deleteStudent(id);
	}
	
	public int deleteTeacher(int id){
		return userDao.deleteTeacher(id);
	}
}
