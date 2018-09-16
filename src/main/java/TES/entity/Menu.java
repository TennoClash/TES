package TES.entity;

public class Menu {
	int Id;
	String css_class;
	String context;
	String nav_id;
	String parent_id;
	String menu_type;
	String menu_id;
	String a_context;

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

	public String getMenu_type() {
		return menu_type;
	}

	public void setMenu_type(String menu_type) {
		this.menu_type = menu_type;
	}

	public String getMneu_id() {
		return menu_id;
	}

	public void setMneu_id(String mneu_id) {
		this.menu_id = mneu_id;
	}

	public String getA_context() {
		return a_context;
	}

	public void setA_context(String a_context) {
		this.a_context = a_context;
	}

}
