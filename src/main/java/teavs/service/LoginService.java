package teavs.service;

import java.security.MessageDigest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teavs.dao.UserDao;
import teavs.entity.User;
import teavs.entity.student;
import teavs.entity.teacher;
import teavs.util.Md5Hex;

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
	public int passReset(student students){
		String opass=students.getPassword();
		opass=MD5(opass);
		students.setPassword(opass);
		return userDao.passReset(students);
	}
	public int passResetT(teacher teachers){
		String opass=teachers.getPassword();
		opass=MD5(opass);
		teachers.setPassword(opass);
		return userDao.passResetT(teachers);
	}
	
	private static String MD5(String s) {
	    try {
	        MessageDigest md = MessageDigest.getInstance("MD5");
	        byte[] bytes = md.digest(s.getBytes("utf-8"));
	        return toHex(bytes);
	    }
	    catch (Exception e) {
	        throw new RuntimeException(e);
	    }
	}

	private static String toHex(byte[] bytes) {

	    final char[] HEX_DIGITS = "0123456789abcdef".toCharArray();
	    StringBuilder ret = new StringBuilder(bytes.length * 2);
	    for (int i=0; i<bytes.length; i++) {
	        ret.append(HEX_DIGITS[(bytes[i] >> 4) & 0x0f]);
	        ret.append(HEX_DIGITS[bytes[i] & 0x0f]);
	    }
	    return ret.toString();
	}
}
