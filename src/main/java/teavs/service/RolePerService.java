package teavs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teavs.dao.RolePerDao;
import teavs.entity.Permission;
import teavs.entity.Role;
import teavs.entity.RolePer;

@Service
public class RolePerService {
	@Autowired
	private RolePerDao rolePerDao;

	public List<Role> getRoles(){
		return rolePerDao.getRoles();
	}
	
	public List<Permission> getPermissions(){
		return rolePerDao.getPermissions();
	}
	
	public int delectrp(RolePer rolePer){		
		return rolePerDao.delectrp(rolePer);
	}
	
	public int addPer(String p){
		return rolePerDao.addPer(p);
	}
	
	public int delectP(String p){
		return rolePerDao.delectP(p);
	}
}

