package TES.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import TES.dao.UpDateDao;
import TES.dao.UserDao;
import TES.entity.Clazz;
import TES.entity.ClazzCourse;
import TES.entity.Course;
import TES.entity.User;
import TES.entity.student;
import TES.entity.teacher;

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
	
	public int Course_Update(List<Course> courses){
		return upDateDao.Course_Update(courses);
	}
	
	public int Clazz_Update(List<Clazz> clazzs){
		return upDateDao.Clazz_Update(clazzs);
	}
	
	public int Clazz_Course_Update(List<ClazzCourse> clazzCourses){
		return upDateDao.Clazz_Course_Update(clazzCourses);
	}
}
