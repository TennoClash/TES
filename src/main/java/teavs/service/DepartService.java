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

}
