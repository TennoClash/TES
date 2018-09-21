package teavs.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teavs.dao.MenuDao;
import teavs.entity.Menu;

@Service
public class MenuService {
	@Autowired
	private MenuDao menuDao;
	
	public List<Menu> getMenu(int i){
		List<Menu> menu=menuDao.getMenu(i);
		return menu;
	}
	
	public List<Menu> getMenux(int i){
		List<Menu> menu=menuDao.getMenux(i);
		return menu;
	}
}
