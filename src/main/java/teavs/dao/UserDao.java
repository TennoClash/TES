package teavs.dao;

import teavs.entity.User;
import teavs.entity.student;
import teavs.entity.teacher;

public interface UserDao {
	User getUser(User user);

	User getUserByName(String i);
	
	String getRole_Id(String name);
	
	int updateSPassWord(User user);
	
	int updateTPassWord(User user);
	
	int passReset(student students);
	
	int passResetT(teacher teachers);
	
}
