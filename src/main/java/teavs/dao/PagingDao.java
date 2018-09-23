package teavs.dao;

import java.util.List;

import teavs.entity.Page;
import teavs.entity.student;
import teavs.entity.teacher;

public interface PagingDao {
	public List<student> searchInvList(Page page);

	public List<student> getInvBycondtion(Page page);

	public Integer searchTotalCount(Page page);
	
	public List<teacher> searchInvListT(Page page);

	public List<teacher> getInvBycondtionT(Page page);

	public Integer searchTotalCountT(Page page);
}
