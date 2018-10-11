package teavs.dao;

import java.util.List;

import teavs.entity.CTTTable;
import teavs.entity.Clazz;
import teavs.entity.ClazzDepartment;
import teavs.entity.EvaCheck;
import teavs.entity.EvaManage;
import teavs.entity.Page;
import teavs.entity.RolePer;
import teavs.entity.student;
import teavs.entity.teacher;

public interface PagingDao {
	public List<student> searchInvList(Page page);

	public List<student> getInvBycondtion(Page page);

	public Integer searchTotalCount(Page page);
	
	public List<teacher> searchInvListT(Page page);

	public List<teacher> getInvBycondtionT(Page page);

	public Integer searchTotalCountT(Page page);
	
	public List<RolePer> searchInvListRP(Page page);

	public List<RolePer> getInvBycondtionRP(Page page);

	public Integer searchTotalCountRP(Page page);
	
	public List<CTTTable> searchInvListCT(Page page);

	public List<CTTTable> getInvBycondtionCT(Page page);

	public Integer searchTotalCountCT(Page page);
	
	public List<ClazzDepartment> searchInvListClazz(Page page);

	public List<ClazzDepartment> getInvBycondtionClazz(Page page);

	public Integer searchTotalCountClazz(Page page);
	
	public List<EvaManage> searchInvListEvaManages(Page page);

	public List<EvaManage> getInvBycondtionEvaManages(Page page);

	public Integer searchTotalCountEvaManages(Page page);
	

}
