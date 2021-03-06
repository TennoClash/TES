package teavs.entity;

import java.util.List;

public class Menu {
	int Id;
	String css_class;
	String context;
	String nav_id;
	String parent_id;
	int menu_type;
	int menu_id;
	String a_context;
	int pid;
	private List<Menu> children;
	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public String getCss_class() {
		return css_class;
	}

	public void setCss_class(String css_class) {
		this.css_class = css_class;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public String getNav_id() {
		return nav_id;
	}

	public void setNav_id(String nav_id) {
		this.nav_id = nav_id;
	}

	public String getParent_id() {
		return parent_id;
	}

	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}

	

	public int getMenu_type() {
		return menu_type;
	}

	public void setMenu_type(int menu_type) {
		this.menu_type = menu_type;
	}

	public int getMenu_id() {
		return menu_id;
	}

	public void setMenu_id(int menu_id) {
		this.menu_id = menu_id;
	}

	public String getA_context() {
		return a_context;
	}

	public void setA_context(String a_context) {
		this.a_context = a_context;
	}

	public List<Menu> getChildren() {
		return children;
	}

	public void setChildren(List<Menu> children) {
		this.children = children;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}


}
