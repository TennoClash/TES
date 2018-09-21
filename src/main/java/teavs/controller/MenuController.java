package teavs.controller;

import java.lang.reflect.Array;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import teavs.entity.Menu;
import teavs.service.MenuService;
import teavs.util.TreeBuilder;

@Controller
public class MenuController {
	@Autowired
	private MenuService menuService;
	
	@RequestMapping("/menumanage")
	public String menumanage() {
		return "menumanage";
	}
	
	
	@RequestMapping(value = "/menux", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String  menux(String i) {
	     List<Menu> menus =menuService.getMenux(Integer.parseInt(i));

	        String json = new TreeBuilder().buildTree(menus);
	       String json1= json.replace("context", "text");
	       String json2= json1.replace("children", "nodes");
	        System.out.println(json2);
	        return json2;
	}
	

}
