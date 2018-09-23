package teavs.entity;

public class Page {
int pageSize;
int currentPage;
int startRow;
String queryCondition;
int totalPage;
Integer totalRows;


public int getPageSize() {
	return pageSize;
}
public void setPageSize(int pageSize) {
	this.pageSize = pageSize;
}
public int getCurrentPage() {
	return currentPage;
}
public void setCurrentPage(int currentPage) {
	this.currentPage = currentPage;
}
public int getStartRow() {
	return startRow;
}
public void setStartRow(int startRow) {
	this.startRow = startRow;
}
public String getQueryCondition() {
	return queryCondition;
}
public void setQueryCondition(String queryCondition) {
	this.queryCondition = queryCondition;
}
public int getTotalPage() {
	return totalPage;
}
public void setTotalPage(int totalPage) {
	this.totalPage = totalPage;
}
public Integer getTotalRows() {
	return totalRows;
}
public void setTotalRows(Integer totalRows) {
	this.totalRows = totalRows;
}






}
