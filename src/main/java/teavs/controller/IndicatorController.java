package teavs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import teavs.entity.Indicator;
import teavs.entity.Menu;
import teavs.service.IndicatorService;
import teavs.util.TreeBuilder;
import teavs.util.TreeBuilderIndicator;

@Controller
public class IndicatorController {
	@Autowired
	private IndicatorService indicatorService;
	
	@RequestMapping("/evaluate")
	public String evaluate() {
		return "evaluate";
	}
	@RequestMapping("/Indicator")
	public String Indicator() {
		return "Indicator";
	}
	
	
	@RequestMapping(value = "/evaluatex", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String  evaluatex(String i) {
	     List<Indicator> indicators =indicatorService.getIndicator(Integer.parseInt(i));

	        String json = new TreeBuilderIndicator().buildTree(indicators);
	       String json1= json.replace("i_title", "text");
	       String json2= json1.replace("children", "nodes");
	        return json2;
	}
	@RequestMapping(value = "/evaluateOrigin", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public  List<Indicator>  evaluateOrigin(String i) {
	     List<Indicator> indicators =indicatorService.getIndicatorOR(Integer.parseInt(i));
	        return indicators;
	}
	
	@RequestMapping(value = "/addindi", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String  addindi(int pid,String weight,int i_type,String i_title) {
		Indicator indicator = new Indicator();
		indicator.setPid(pid);
		indicator.setI_title(i_title);
		indicator.setI_type(i_type);
		indicator.setWeight(weight);
		int i = indicatorService.addIndicator(indicator);
		if(i>0){
			return "1";
		}else {
			return "0";
		}
		
	}
	
	
}
