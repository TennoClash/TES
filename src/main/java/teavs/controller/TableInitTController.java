package teavs.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import teavs.entity.Page;
import teavs.entity.teacher;
import teavs.service.LoginService;
import teavs.service.PagingService;

@Controller
public class TableInitTController {
	@Autowired
	private PagingService pagingService;
	@Autowired
	private LoginService loginService;
	
	@RequestMapping("/jump")
	public String jump() {
		return "jump";
	}
	
	@RequestMapping("initt.do")
	public String searchInvList(Page page, HttpServletRequest request) throws UnsupportedEncodingException {
		Page p = page;
		int pageSize = 5; 
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
		List<teacher> teachers = getInvListByCondition(page);
		Integer totalCounts = pagingService.searchTotalCountT(page);
		int totalPages = (totalCounts % pageSize == 0) ? (totalCounts / pageSize) : (totalCounts / pageSize + 1);
		p.setTotalPage(totalPages);
		page.setTotalRows(totalCounts);
		request.setAttribute("teachers", teachers);
		request.setAttribute("page", page);
		return "tpassmanage";
	}

	private List<teacher> getInvListByCondition(Page page) {
		List<teacher> teachers = null;
		if (page.getQueryCondition() == null) {
			teachers = pagingService.searchInvListT(page);
			return teachers;
		}
		teachers = pagingService.getInvBycondtionT(page);
		return teachers;
	}


	public int getStartRowBycurrentPage(int currentPage, int pageSize) {
		int startRow = 0;
		if (currentPage == 1) {
			return startRow = 0;
		}
		startRow = (currentPage - 1) * pageSize;
		return startRow;
	}

	@RequestMapping("passresett")
	public String deleteInvition(int id,String user_number) {
		System.out.println(id+"+++++"+user_number);
		teacher teachers=new teacher();
		teachers.setId(id);
		teachers.setPassword(user_number);
		loginService.passResetT(teachers);
		return "jump";
	}
}
