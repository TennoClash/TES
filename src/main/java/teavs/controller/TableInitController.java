package teavs.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import teavs.entity.Page;
import teavs.entity.student;
import teavs.service.LoginService;
import teavs.service.PagingService;

@Controller
public class TableInitController {
	@Autowired
	private PagingService pagingService;
	@Autowired
	private LoginService loginService;
	
	@RequestMapping("/jump/jumpsp")
	public String jumpsp() {
		return "jump/jumpsp";
	}

	@RequestMapping("init.do")
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
		List<student> students = getInvListByCondition(page);
		Integer totalCounts = pagingService.searchTotalCount(page);
		int totalPages = (totalCounts % pageSize == 0) ? (totalCounts / pageSize) : (totalCounts / pageSize + 1);
		p.setTotalPage(totalPages);

		page.setTotalRows(totalCounts);

		request.setAttribute("students", students);

		request.setAttribute("page", page);

		return "spassmanage";
	}

	private List<student> getInvListByCondition(Page page) {

		List<student> students = null;

		if (page.getQueryCondition() == null) {

			students = pagingService.searchInvList(page);

			return students;

		}

		students = pagingService.getInvBycondtion(page);

		return students;

	}


	public int getStartRowBycurrentPage(int currentPage, int pageSize) {
		int startRow = 0;
		if (currentPage == 1) {
			return startRow = 0;
		}
		startRow = (currentPage - 1) * pageSize;
		return startRow;
	}

	@RequestMapping("passreset")
	public String deleteInvition(int id,String user_number) {
		System.out.println(id+"+++++"+user_number);
		student students=new student();
		students.setId(id);
		students.setPassword(user_number);
		loginService.passReset(students);
		return "jump/jumpsp";
	}

}
