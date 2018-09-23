package teavs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import teavs.entity.Role;
import teavs.service.RolePerService;


@Controller
public class RolePerController {
	@Autowired
	private RolePerService rolePerService;
	
	@RequestMapping(value = "/rolex", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<Role> rolex() {
		List<Role> roles=rolePerService.getRoles();
	        return roles;
	}
	
	@RequestMapping(value = "/perx", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<Role> perx() {
		List<Role> roles=rolePerService.getRoles();
	        return roles;
	}
}
