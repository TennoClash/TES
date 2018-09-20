package teavs.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

import teavs.entity.Clazz;
import teavs.entity.ClazzCourse;
import teavs.entity.Course;
import teavs.entity.student;
import teavs.entity.teacher;
import teavs.service.UpDateService;

@Controller
public class ClassAffairController {
	@Autowired
	private UpDateService upDateService;
	
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
}
