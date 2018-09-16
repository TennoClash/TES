package TES.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import TES.entity.Menu;
import TES.entity.User;
import TES.service.LoginService;
import TES.service.MenuService;
import TES.service.UpDateService;

@Controller
public class IndexController {
	@Autowired
	private MenuService menuService;
	@Autowired
	private LoginService loginService;
	@Autowired
	private UpDateService upDateService;

	@RequestMapping(value = "/welcomeinit", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<Menu> welcomeinit(String i, HttpServletRequest request, HttpSession session) {
		int menu_type = Integer.parseInt(i);
		List<Menu> menu = menuService.getMenu(menu_type);
		return menu;
	}

	@RequestMapping("/passchange")
	public String passchange() {
		return "passchange";
	}

	@RequestMapping(value = "/pass_check", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login_submit(String name, String pass) {
		boolean result = loginService.execute(name, pass);
		if (result) {
			return "1";
		} else {
			return "0";
		}

	}

	@RequestMapping(value = "/pw_update", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String pw_update(String num,String pass,String type){
		User user=new User();
		user.setUser_number(num);
		user.setPassword(pass);
		System.out.println(type);
		if(type.equals("0")){
			System.out.println("学生"+pass+"+"+num);
			int i= upDateService.updateSPassWord(user);
			if(i>0){
				return "1";
			}else {
				return "0";
			}
		}else {
			System.out.println("老师"+pass+"+"+num);
			int i= upDateService.updateTPassWord(user);
			if(i>0){
				return "1";
			}else {
				return "0";
			}
		}
		
		
	}

}
