package teavs.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import teavs.entity.Menu;

public interface MenuDao {
List<Menu> getMenu(int i);

List<Menu> getMenux(int i);

int orderplus(@Param("menu_id")int mposition,@Param("menu_type")int ctype);
}
