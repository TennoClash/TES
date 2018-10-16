package teavs.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import teavs.entity.EvaCheck;
import teavs.entity.EvaDetail;
import teavs.entity.EvaManage;
import teavs.entity.Indicator;
import teavs.entity.LeaderCheck;
import teavs.entity.Page;
import teavs.entity.teacher;
import teavs.service.IndicatorService;
import teavs.service.PagingService;
import teavs.util.TreeBuilderIndicator;

@Controller
public class IndicatorController {
	@Autowired
	private IndicatorService indicatorService;
	@Autowired
	private PagingService pagingService;

	@RequestMapping("/evaluate")
	public String evaluate() {
		return "evaluate";
	}

	@RequestMapping("/jump/jumpevaoc")
	public String jumpevaoc() {
		return "/jump/jumpevaoc";
	}

	@RequestMapping("/jump/jumpevama")
	public String jumpevama() {
		return "/jump/jumpevama";
	}

	@RequestMapping("/evastate")
	public String evastate() {
		return "/evastate";
	}

	@RequestMapping("/Indicator")
	public String Indicator() {
		return "Indicator";
	}

	@RequestMapping("/indicatorManage")
	public String indicatorManage() {
		return "indicatorManage";
	}

	@RequestMapping("/evacheck")
	public String evacheck() {
		return "evacheck";
	}
	@RequestMapping("/evacheckt")
	public String evacheckt() {
		return "evacheckt";
	}
	@RequestMapping("/teachercheck")
	public String teachercheck() {
		return "teachercheck";
	}
	@RequestMapping("/leadercheck")
	public String leadercheck() {
		return "/leadercheck";
	}

	@RequestMapping(value = "/evaluatex", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String evaluatex(String i) {
		List<Indicator> indicators = indicatorService.getIndicator(Integer.parseInt(i));

		String json = new TreeBuilderIndicator().buildTree(indicators);
		String json1 = json.replace("i_title", "text");
		String json2 = json1.replace("children", "nodes");
		return json2;
	}

	@RequestMapping(value = "/evaluateOrigin", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<Indicator> evaluateOrigin(String i) {
		List<Indicator> indicators = indicatorService.getIndicatorOR(Integer.parseInt(i));
		return indicators;
	}

	@RequestMapping(value = "/addindi", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String addindi(int pid, String weight, int i_type, String i_title) {
		Indicator indicator = new Indicator();
		indicator.setPid(pid);
		indicator.setI_title(i_title);
		indicator.setI_type(i_type);
		indicator.setWeight(weight);
		int i = indicatorService.addIndicator(indicator);
		if (i > 0) {
			return "1";
		} else {
			return "0";
		}

	}

	@RequestMapping(value = "/add_task", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String add_task(String sem, int in_type, String start, String end) {
		EvaManage evaManage = new EvaManage();
		evaManage.setEnd_time(end);
		evaManage.setEva_type(in_type);
		evaManage.setSemester(sem);
		evaManage.setStart_time(start);
		evaManage.setState(0);
		indicatorService.add_Eva_Manage(evaManage);
		return "1";
	}

	@RequestMapping("eva_M_table")
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
		List<EvaManage> evaManages = getInvListByCondition(page);
		Integer totalCounts = pagingService.searchTotalCountEvaManages(page);
		int totalPages = (totalCounts % pageSize == 0) ? (totalCounts / pageSize) : (totalCounts / pageSize + 1);
		p.setTotalPage(totalPages);

		page.setTotalRows(totalCounts);

		request.setAttribute("evaManages", evaManages);

		request.setAttribute("page", page);

		return "evastate";
	}

	private List<EvaManage> getInvListByCondition(Page page) {

		List<EvaManage> evaManages = null;

		if (page.getQueryCondition() == null) {

			evaManages = pagingService.searchInvListEvaManages(page);

			return evaManages;

		}

		evaManages = pagingService.getInvBycondtionEvaManages(page);

		return evaManages;

	}

	public int getStartRowBycurrentPage(int currentPage, int pageSize) {
		int startRow = 0;
		if (currentPage == 1) {
			return startRow = 0;
		}
		startRow = (currentPage - 1) * pageSize;
		return startRow;
	}

	@RequestMapping(value = "/add_ma_open", produces = "text/html;charset=UTF-8")
	public String add_ma_open(int id) {
		int i = indicatorService.ma_Open(id);
		return "/jump/jumpevaoc";
	}

	@RequestMapping(value = "/add_ma_close", produces = "text/html;charset=UTF-8")
	public String add_ma_close(int id) {
		int i = indicatorService.ma_Close(id);
		return "/jump/jumpevaoc";
	}

	@RequestMapping(value = "/add_ma_delay", produces = "text/html;charset=UTF-8")
	public String add_ma_delay(int id) {
		int i = indicatorService.ma_Delay(id);
		return "/jump/jumpevaoc";
	}

	@RequestMapping(value = "/eva_check")
	public String eva_check(int clazz_num, String eva_user, HttpServletRequest request) {
		List<EvaCheck> evaChecks = indicatorService.getEveChecks(clazz_num);
		for (int i = 0; i < evaChecks.size(); i++) {
			int ii = indicatorService.getIsEva(evaChecks.get(i).getId(), evaChecks.get(i).getTeacher_id(), eva_user);
			if (ii > 0) {
				evaChecks.get(i).setEva_state(0);
			} else {
				evaChecks.get(i).setEva_state(1);
			}
		}
		request.setAttribute("evaChecks", evaChecks);
		return "evacheck";
	}

	@RequestMapping(value = "/eva_check.do")
	public String eva_checkDo(String teacher_id, String semester, String course_id, int eva_type, String eva_user,
			int id, HttpServletRequest request) {
		request.setAttribute("teacher_id", teacher_id);
		request.setAttribute("semester", semester);
		request.setAttribute("course_id", course_id);
		request.setAttribute("eva_user", eva_user);
		request.setAttribute("eva_type", eva_type);
		request.setAttribute("eid", id);
		System.out.println(id);
		return "evaluate";
	}

	@RequestMapping(value = "/eva_sub", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String eva_sub(String teacher_id, String semester, String course_id, int eva_type, String eva_user,
			String score, int eid) {
		EvaDetail evaDetail = new EvaDetail();
		evaDetail.setTeacher_id(teacher_id);
		evaDetail.setSemester(semester);
		evaDetail.setCourse_id(course_id);
		evaDetail.setEva_user(eva_user);
		evaDetail.setEva_type(eva_type);
		evaDetail.setScore(score);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println(df.format(new Date()));
		evaDetail.setEva_time(df.format(new Date()));
		int i = indicatorService.eva_Sub(evaDetail);
		int ii = indicatorService.add_Eva_State(eid, teacher_id, eva_user);
		return "1";
	}
	
	@RequestMapping(value = "/getTeva", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<EvaDetail> eva_sub(String teacher_id) {
		List<EvaDetail> evaDetails = indicatorService.getTEva(teacher_id);
		if(evaDetails.size()!=0){
			
		}
		return evaDetails;
	}
	
	@RequestMapping(value = "/eva_check_t")
	public String eva_check_t(String ministry, HttpServletRequest request) {
		System.out.println(ministry);
		List<teacher> teachers = indicatorService.getTM(ministry);
		request.setAttribute("teachers", teachers);
		return "evacheckt";
	}
	
	@RequestMapping(value = "/eva_check_t.do")
	public String eva_check_t_DO(String teacher_id, String semester, int eva_type, String eva_user, HttpServletRequest request) {
		request.setAttribute("teacher_id", teacher_id);
		request.setAttribute("semester", semester);
		request.setAttribute("eva_user", eva_user);
		request.setAttribute("eva_type", eva_type);
		return "evaluate";
	}
	
	@RequestMapping(value = "/eva_sub_t", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String eva_sub_t(String teacher_id, String semester ,int eva_type, String eva_user,
			String score) {
		EvaDetail evaDetail = new EvaDetail();
		evaDetail.setTeacher_id(teacher_id);
		evaDetail.setSemester(semester);
		evaDetail.setEva_user(eva_user);
		evaDetail.setEva_type(eva_type);
		evaDetail.setScore(score);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println(df.format(new Date()));
		evaDetail.setEva_time(df.format(new Date()));
		int i = indicatorService.eva_Sub(evaDetail);
		return "1";
	}
	
	@RequestMapping(value = "/get_Lead_Check", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<LeaderCheck> get_Lead_Check(String teacher_id) {
		int i=indicatorService.getSCount();
		int ii=indicatorService.getEvaCount();
		List<LeaderCheck> leaderChecks =indicatorService.getLeaderChecks();
		for(int k=0;k<leaderChecks.size();k++){
			leaderChecks.get(k).setScount(i);
			leaderChecks.get(k).setEvacount(ii);
		}
		return leaderChecks;
	}
}
