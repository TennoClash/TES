package teavs.dao;

import java.util.List;

import teavs.entity.Permission;
import teavs.entity.Role;

public interface RolePerDao {
	public List<Role> getRoles();
	
	public List<Permission> getPermissions();

}
