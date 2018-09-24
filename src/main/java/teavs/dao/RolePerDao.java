package teavs.dao;

import java.util.List;

import teavs.entity.ORolePer;
import teavs.entity.Permission;
import teavs.entity.Role;
import teavs.entity.RolePer;

public interface RolePerDao {
	public List<Role> getRoles();
	
	public List<Permission> getPermissions();
	
	public int delectrp(RolePer rolePer);
	
	public int delectP(String p);
	
	public int addPer(String p);
	
	public int addRolePer(ORolePer oRolePer);
}
