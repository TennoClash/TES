package teavs.entity;

import java.util.List;

public class Indicator {
int Id;
int pid;
String weight;
int i_type;
String i_title;
private List<Indicator> children;


public List<Indicator> getChildren() {
	return children;
}
public void setChildren(List<Indicator> children) {
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
public String getWeight() {
	return weight;
}
public void setWeight(String weight) {
	this.weight = weight;
}
public int getI_type() {
	return i_type;
}
public void setI_type(int i_type) {
	this.i_type = i_type;
}
public String getI_title() {
	return i_title;
}
public void setI_title(String i_title) {
	this.i_title = i_title;
}


}
