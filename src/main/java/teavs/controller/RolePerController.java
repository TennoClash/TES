package teavs.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import teavs.entity.Menu;
import teavs.entity.Page;
import teavs.entity.Permission;
import teavs.entity.Role;
import teavs.entity.RolePer;
import teavs.entity.student;
import teavs.entity.teacher;
import teavs.service.PagingService;
import teavs.service.RolePerService;


@Controller
public class RolePerController {
	@Autowired
	private RolePerService rolePerService;
	@Autowired
	private PagingService pagingService;
	
	@RequestMapping("/jump/jumprpdel")
	public String jumprpdel() {
		return "jump/jumprpdel";
	}
	
	@RequestMapping(value = "/rolex", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<Role> rolex() {
		List<Role> roles=rolePerService.getRoles();
	        return roles;
	}
	
	@RequestMapping(value = "/perx", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<Permission> perx() {
		List<Permission> permissions=rolePerService.getPermissions();
	        return permissions;
	}
	
	@RequestMapping("role_Per_Table")
	public String searchInvList(Page page, HttpServletRequest request) throws UnsupportedEncodingException {
		Page p = page;
		int pageSize = 6; 
		p.setPageSize(pageSize);
		int curPage = p.getCurrentPage();

		if (curPage == 0) {
			curPage = 1;
			p.setCurrentPage(curPage);
		}
		int startRow = page.getStartRow();

		if (!(p.getCurrentPage() == 0)) {
			startRow = getStartRowBycurrentPage(curPage, pageSize);
		}
		p.setStartRow(startRow);

		String queryCondition = null;
		if (page.getQueryCondition() != null) {
			queryCondition = page.getQueryCondition();
		}
		List<RolePer> rolePers = getInvListByCondition(page);
		Integer totalCounts = pagingService.searchTotalCountRP(page);
		int totalPages = (totalCounts % pageSize == 0) ? (totalCounts / pageSize) : (totalCounts / pageSize + 1);
		p.setTotalPage(totalPages);

		page.setTotalRows(totalCounts);

		request.setAttribute("rolePers", rolePers);

		request.setAttribute("page", page);

		return "roleper";
	}

	private List<RolePer> getInvListByCondition(Page page) {

		List<RolePer> rolePers = null;

		if (page.getQueryCondition() == null) {

			rolePers = pagingService.searchInvListRP(page);

			return rolePers;

		}

		rolePers = pagingService.getInvBycondtionRP(page);

		return rolePers;

	}

	public int getStartRowBycurrentPage(int currentPage, int pageSize) {
		int startRow = 0;
		if (currentPage == 1) {
			return startRow = 0;
		}
		startRow = (currentPage - 1) * pageSize;
		return startRow;
	}
	

	@RequestMapping("deleterl")
	public String deleteInvition(int pid,int rid) {	
		RolePer rolePer=new RolePer();
		rolePer.setPid(pid);
		rolePer.setRid(rid);
		int i=rolePerService.delectrp(rolePer);
		return "jump/jumprpdel";
	}
	
	@RequestMapping(value = "/newpera", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String  newpera(String newper) {	
	int i = rolePerService.addPer(newper);
	return "1";
	}
	
	@RequestMapping(value = "/delper", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String  delper(String per) {	
	int i = rolePerService.delectP(per);
	return "1";
	}
	
}
