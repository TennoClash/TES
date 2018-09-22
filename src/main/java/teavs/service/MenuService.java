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
	public int orderplus(int mposition,int ctype){
		return menuDao.orderplus(mposition,ctype);
	}
	public int orderreduce(int mposition,int ctype){
		return menuDao.orderreduce(mposition,ctype);
	}
	public int insert_menu(Menu menu){
		return menuDao.insert_menu(menu);
	}
	public int insert_menu_2(Menu menu){
		return menuDao.insert_menu_2(menu);
	}
	public int delete_menu(String i,String k){
		return menuDao.delete_menu(i,k);
	}
	public int orderreduce_2(int i,int k,int j){
		return menuDao.orderreduce_2(i,k,j);
	}
	public int delete_menu_2(int i){
		return menuDao.delete_menu_2(i);
	}
	
}
