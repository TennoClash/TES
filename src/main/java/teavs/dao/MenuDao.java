package teavs.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import teavs.entity.Menu;

public interface MenuDao {
List<Menu> getMenu(int i);

List<Menu> getMenux(int i);

int orderplus(@Param("menu_id")int mposition,@Param("menu_type")int ctype);

int orderreduce(@Param("menu_id")int mposition,@Param("menu_type")int ctype);

int insert_menu(Menu menu);

int insert_menu_2(Menu menu);

int delete_menu(@Param("nav_id")String nav_id,@Param("parent_id")String parent_id);

int orderreduce_2(@Param("menu_id")int menu_id,@Param("menu_id_2")int menu_id_2,@Param("menu_type")int menu_type);

int delete_menu_2(int id);

}
