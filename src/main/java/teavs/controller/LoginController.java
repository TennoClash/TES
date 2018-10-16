package teavs.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import teavs.entity.User;
import teavs.service.LoginService;

@Controller
public class LoginController {
	@Autowired
	private LoginService loginService;

	@RequestMapping("/login")
	public String login() {
		return "login";
	}

	@RequestMapping("/welcome")
	public String welcome() {
		return "welcome";
	}

	@RequestMapping(value = "/ajax_login", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String login_submit(String name, String pass, HttpServletRequest request, HttpSession session) {
		System.out.println(name + pass);
		// request.setAttribute("username", username);
		
		boolean result = loginService.execute(name, pass);
		if (result) {
			User user = loginService.getUserByName(name);
			int usertype = user.getUser_type();
			String user_number = user.getUser_number();
			String role_id=loginService.getRole_Id(name);
			String d_type=user.getD_type();
			System.out.println(role_id);
			if (usertype == 1) {
				User user2 = loginService.getUser(name, pass);
				session.setAttribute("user", user2);
				session.setAttribute("user_type", usertype);
				session.setAttribute("role_id", role_id);
				session.setAttribute("user_number", user_number);
				session.setAttribute("d_type", d_type);
				return "教师登录成功";
			}
			if (usertype == 0) {
				User user2 = loginService.getUser(name, pass);
				session.setAttribute("user", user2);
				session.setAttribute("user_type", usertype);
				session.setAttribute("role_id", role_id);
				session.setAttribute("user_number", user_number);
				session.setAttribute("d_type", d_type);
				return "学生登录成功";
			}
			if (usertype == 2) {
				User user2 = loginService.getUser(name, pass);
				session.setAttribute("user", user2);
				session.setAttribute("user_type", usertype);
				session.setAttribute("role_id", role_id);
				session.setAttribute("user_number", user_number);
				return "院系领导登录成功";
			} else {
				User user2 = loginService.getUser(name, pass);
				session.setAttribute("user", user2);
				session.setAttribute("user_type", usertype);
				session.setAttribute("role_id", role_id);
				session.setAttribute("user_number", user_number);
				return "管理员登录成功";
			}

		} else {
			return "用户名或密码错误";
		}
	}
}
