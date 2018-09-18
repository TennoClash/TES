package TES.dao;

import TES.entity.User;

public interface UserDao {
	User getUser(User user);

	User getUserByName(String i);
	
	String getRole_Id(String name);
	
	int updateSPassWord(User user);
	
	int updateTPassWord(User user);
}
