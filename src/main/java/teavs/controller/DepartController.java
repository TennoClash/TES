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
	
	@RequestMapping(value = "/deletede", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String  deletede(int i) {
		int x=departService.isFatherNode(i);
		System.out.println(x);
		if(x==0){
			int ii= departService.deletepart(i);
		}else{
			int iii=departService.deleteAllTree(i);
		}
		return "1";
	}
	
	@RequestMapping(value = "/addpartment", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String  addpartment(String i) {
		int ii=departService.addDepartment(i);
		return "1";
	}
	
	@RequestMapping(value = "/addpartment_2", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String  addpartment_2(String name,int pid,int i) {
		if(pid==0){
			int ii=departService.addDepartment_2(name, i);
		}else {
			int ii = departService.addDepartment_2(name, pid);
		}
		return "1";
	}
	
}
