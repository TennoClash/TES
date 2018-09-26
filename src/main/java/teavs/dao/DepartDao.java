package teavs.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import teavs.entity.Depart;

public interface DepartDao {
	public List<Depart> getDepartX();
	
	public int deletepart(int id);
	
	public int isFatherNode(int id);
	
	public int deleteAllTree(int id);
	
	public int addDepartment(String name);
	
	public int addDepartment_2(@Param("name")String name,@Param("pid")int pid);
}
