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
	        return json2;
	}
	
	@RequestMapping(value = "/menuaddf", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String  menuaddf(String mposition,String ctype,String nav_input,String navid) {	
		int i = menuService.orderplus(Integer.parseInt(mposition),Integer.parseInt(ctype));
		if(i>0){
			Menu menu=new Menu();
			menu.setContext(nav_input);
			menu.setMenu_type(Integer.parseInt(ctype));
			menu.setMenu_id(Integer.parseInt(mposition)+1);
			menu.setNav_id(navid);
			int ii=menuService.insert_menu(menu);		
		}		
		return "1";
	}
	
	@RequestMapping(value = "/menuadds", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String  menuadds(String mposition,String ctype,String nav_input,String navid,String pid) {	
		int i = menuService.orderplus(Integer.parseInt(mposition),Integer.parseInt(ctype));
		if(i>0){
			Menu menu=new Menu();
			menu.setContext(nav_input);
			menu.setMenu_type(Integer.parseInt(ctype));
			menu.setMenu_id(Integer.parseInt(mposition)+1);
			menu.setParent_id(navid);
			menu.setPid(Integer.parseInt(pid));
			int ii=menuService.insert_menu_2(menu);		
		}		
		return "1";
	}
	

}
