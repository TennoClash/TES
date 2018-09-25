package teavs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import teavs.entity.Depart;
import teavs.service.DepartService;
import teavs.util.TreeBuilderDepart;

@Controller
public class DepartController {
	@Autowired
	private DepartService departService;
	
	@RequestMapping("/department")
	public String department() {
		return "department";
	}
	
	@RequestMapping(value = "/departmentx", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String  menux(String i) {
	     List<Depart> departs =departService.getDepartX();

	        String json = new TreeBuilderDepart().buildTree(departs);
	       String json1= json.replace("institute", "text");
	       String json2= json1.replace("children", "nodes");
	        return json2;
	}
}
