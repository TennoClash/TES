package TES.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import TES.dao.UserDao;
import TES.entity.User;

@Service
public class UpDateService {
	@Autowired
	private UserDao userDao;

	public int updateSPassWord(User user) {
		return userDao.updateSPassWord(user);
	}

	public int updateTPassWord(User user) {
		return userDao.updateTPassWord(user);
	}
}
