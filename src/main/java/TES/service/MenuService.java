package TES.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import TES.dao.MenuDao;
import TES.entity.Menu;

@Service
public class MenuService {
	@Autowired
	private MenuDao menuDao;
	
	public List<Menu> getMenu(int i){
		List<Menu> menu=menuDao.getMenu(i);
		return menu;
	}
}
