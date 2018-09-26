package teavs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teavs.dao.PagingDao;
import teavs.entity.CTTTable;
import teavs.entity.Page;
import teavs.entity.RolePer;
import teavs.entity.student;
import teavs.entity.teacher;

@Service
public class PagingService {
	@Autowired
	private PagingDao pagingDao;
	
	public List<student> searchInvList(Page page){
		return pagingDao.searchInvList(page);
	}
	public List<student> getInvBycondtion(Page page){
		return pagingDao.getInvBycondtion(page);
	}
	public Integer searchTotalCount(Page page){
		return pagingDao.searchTotalCount(page);
	}
	
	public List<teacher> searchInvListT(Page page){
		return pagingDao.searchInvListT(page);
	}
	public List<teacher> getInvBycondtionT(Page page){
		return pagingDao.getInvBycondtionT(page);
	}
	public Integer searchTotalCountT(Page page){
		return pagingDao.searchTotalCountT(page);
	}
	
	public List<RolePer> searchInvListRP(Page page){
		return pagingDao.searchInvListRP(page);
	}
	public List<RolePer> getInvBycondtionRP(Page page){
		return pagingDao.getInvBycondtionRP(page);
	}
	public Integer searchTotalCountRP(Page page){
		return pagingDao.searchTotalCountRP(page);
	}
	
	public List<CTTTable> searchInvListCT(Page page){
		return pagingDao.searchInvListCT(page);
	}
	public List<CTTTable> getInvBycondtionCT(Page page){
		return pagingDao.getInvBycondtionCT(page);
	}
	public Integer searchTotalCountCT(Page page){
		return pagingDao.searchTotalCountCT(page);
	}
}
