package teavs.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

import teavs.entity.CTTTable;
import teavs.entity.Clazz;
import teavs.entity.ClazzCourse;
import teavs.entity.Course;
import teavs.entity.Page;
import teavs.entity.TeacherCourse;
import teavs.entity.student;
import teavs.entity.teacher;
import teavs.service.PagingService;
import teavs.service.UpDateService;

@Controller
public class ClassAffairController {
	@Autowired
	private UpDateService upDateService;
	@Autowired
	private PagingService pagingService;
	
	@RequestMapping("/course")
	public String course() {
		return "course";
	}
	@RequestMapping("/clazz")
	public String clazz() {
		return "clazz";
	}
	@RequestMapping("/clazzcourse")
	public String clazzcourse() {
		return "clazzcourse";
	}
	@RequestMapping("/teacherclazz")
	public String teacherclazz() {
		return "teacherclazz";
	}
	
	@RequestMapping(value = "/courseupload", produces = "application/json;charset=UTF-8")
	@ResponseBody 
	public String course_info(String ListSrt) {
		System.out.println(ListSrt);
			List<Course> courses = JSONObject.parseArray(ListSrt, Course.class);			
			int i=upDateService.Course_Update(courses);
			return String.valueOf(courses.size());		
	}
	
	@RequestMapping(value = "/clazzupload", produces = "application/json;charset=UTF-8")
	@ResponseBody 
	public String clazz_info(String ListSrt) {
		System.out.println(ListSrt);
			List<Clazz> clazzs = JSONObject.parseArray(ListSrt, Clazz.class);			
			int i=upDateService.Clazz_Update(clazzs);
			return String.valueOf(clazzs.size());		
	}
	
	@RequestMapping(value = "/clazzcourseupload", produces = "application/json;charset=UTF-8")
	@ResponseBody 
	public String clazz_course_info(String ListSrt) {
		System.out.println(ListSrt);
			List<ClazzCourse> clazzCourses = JSONObject.parseArray(ListSrt, ClazzCourse.class);			
			int i=upDateService.Clazz_Course_Update(clazzCourses);
			return String.valueOf(clazzCourses.size());		
	}
	
	@RequestMapping(value = "/tcupload", produces = "application/json;charset=UTF-8")
	@ResponseBody 
	public String tcupload(String ListSrt) {
		System.out.println(ListSrt);
			List<TeacherCourse> teacherCourses = JSONObject.parseArray(ListSrt, TeacherCourse.class);			
			int i=upDateService.Teacher_Course_Update(teacherCourses);
			return String.valueOf(teacherCourses.size());		
	}
	
	/**********************************************************************************************/
	@RequestMapping("ctt.do")
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
		List<CTTTable> cttTables = getInvListByCondition(page);
		Integer totalCounts = pagingService.searchTotalCountCT(page);
		int totalPages = (totalCounts % pageSize == 0) ? (totalCounts / pageSize) : (totalCounts / pageSize + 1);
		p.setTotalPage(totalPages);

		page.setTotalRows(totalCounts);

		request.setAttribute("cttTables", cttTables);

		request.setAttribute("page", page);

		return "teacherclazz";
	}

	private List<CTTTable> getInvListByCondition(Page page) {

		List<CTTTable> cttTables = null;

		if (page.getQueryCondition() == null) {

			cttTables = pagingService.searchInvListCT(page);

			return cttTables;

		}

		cttTables = pagingService.getInvBycondtionCT(page);

		return cttTables;

	}


	public int getStartRowBycurrentPage(int currentPage, int pageSize) {
		int startRow = 0;
		if (currentPage == 1) {
			return startRow = 0;
		}
		startRow = (currentPage - 1) * pageSize;
		return startRow;
	}
}
