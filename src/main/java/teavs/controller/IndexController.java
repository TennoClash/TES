package teavs.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import teavs.entity.Menu;
import teavs.entity.User;
import teavs.entity.student;
import teavs.entity.teacher;
import teavs.service.LoginService;
import teavs.service.MenuService;
import teavs.service.UpDateService;

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
	public List<Menu> welcomeinit(String r,HttpServletRequest request, HttpSession session) {
		int menu_type = Integer.parseInt(r);
		List<Menu> menu = menuService.getMenu(menu_type);
		return menu;
	}

	@RequestMapping("/passchange")
	public String passchange() {
		return "passchange";
	}
	@RequestMapping("/sinfo")
	public String sinfo() {
		return "sinfo";
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
	
	@RequestMapping(value = "/studentinfo", produces = "application/json;charset=UTF-8")
	@ResponseBody 
	public String student_info(String ListSrt,String u_type) throws JsonParseException, JsonMappingException, IOException{
		System.out.println(ListSrt);
		
		if(u_type.equals("s")){
			List<student> students = JSONObject.parseArray(ListSrt, student.class);			
			int i=upDateService.upInfo(students);
			int k=upDateService.S_Role_Update(students);
			System.out.println("学生信息插入:"+i);
			System.out.println("user_role:"+k);
			return String.valueOf(students.size());
		}else{
			List<teacher> teachers = JSONObject.parseArray(ListSrt, teacher.class);
			int i=upDateService.upInfo_t(teachers);
			System.out.println(i);
			System.out.println(u_type);
			return String.valueOf(teachers.size());
		}
		
		
	}

}
