package teavs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teavs.dao.DepartDao;
import teavs.entity.Depart;

@Service
public class DepartService {
	@Autowired
	private DepartDao departDao;
	
	public List<Depart>  getDepartX(){
		return departDao.getDepartX();
	}
	
	public int deletepart(int id){
		return departDao.deletepart(id);
	}
	
	public int isFatherNode(int id){
		return departDao.isFatherNode(id);
	}
	
	public int deleteAllTree(int id){
		return departDao.deleteAllTree(id);
	}
	
	public int addDepartment(String name){
		return departDao.addDepartment(name);
	}
	
	public int addDepartment_2(String name,int i){
		return departDao.addDepartment_2(name,i);
	}

}
