package teavs.entity;

import java.util.List;

public class Depart {
	int Id;
	int pid;
	String institute;
	private List<Depart> children;

	
	public List<Depart> getChildren() {
		return children;
	}

	public void setChildren(List<Depart> children) {
		this.children = children;
	}

	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getInstitute() {
		return institute;
	}

	public void setInstitute(String institute) {
		this.institute = institute;
	}

}
