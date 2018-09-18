package TES.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import TES.dao.UserDao;
import TES.entity.User;

@Service
public class LoginService {
	@Autowired
	private UserDao userDao;

	public boolean execute(String user_number, String password) {
		User user = new User();
		user.setUser_number(user_number);
		user.setPassword(password);
		User u = userDao.getUser(user);
		if (u != null) {
			return true;
		} else {
			return false;
		}
	}

	public User getUser(String user_number, String password) {
		User user = new User();
		user.setUser_number(user_number);
		user.setPassword(password);
		User u = userDao.getUser(user);
		return u;
	}

	public User getUserByName(String i) {
		return userDao.getUserByName(i);
	}
	
	public String getRole_Id(String name){
		return userDao.getRole_Id(name);
	}
}
