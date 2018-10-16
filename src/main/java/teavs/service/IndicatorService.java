package teavs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teavs.dao.IndicatorDao;
import teavs.entity.EvaCheck;
import teavs.entity.EvaDetail;
import teavs.entity.EvaManage;
import teavs.entity.Indicator;
import teavs.entity.LeaderCheck;
import teavs.entity.teacher;

@Service
public class IndicatorService {
	@Autowired
	private IndicatorDao indicatorDao;
	
	public List<Indicator> getIndicator(int i){
		return indicatorDao.getIndicator(i);
	}
	public List<Indicator> getIndicatorOR(int i){
		return indicatorDao.getIndicatorOR(i);
	}
	public int addIndicator(Indicator indicator){
		return indicatorDao.addIndicator(indicator);
	}
	public int add_Eva_Manage(EvaManage evaManage){
		return indicatorDao.add_Eva_Manage(evaManage);
	}
	public int ma_Open(int id){
		return indicatorDao.ma_Open(id);
	}
	public int ma_Close(int id){
		return indicatorDao.ma_Close(id);
	}
	public int ma_Delay(int id){
		return indicatorDao.ma_Delay(id);
	}
	public List<EvaCheck> getEveChecks(int num){
		return indicatorDao.getEveChecks(num);
	}
	public int getIsEva(int task_id,String teacher_id,String student_id){
		return indicatorDao.getIsEva(task_id, teacher_id, student_id);
	}
	public int eva_Sub(EvaDetail evaDetail){
		return indicatorDao.eva_Sub(evaDetail);
	}
	public int add_Eva_State(int eid,String teacher_id,String student_id){
		return indicatorDao.add_Eva_State(eid, teacher_id, student_id);
	}
	public List<EvaDetail> getTEva(String teacher_id){
		return indicatorDao.getTEva(teacher_id);
	}
	public List<teacher> getTM(String ministry){
		return indicatorDao.getTM(ministry);
	}
	public int getSCount(){
		return indicatorDao.getSCount();
	}
	public int getEvaCount(){
		return indicatorDao.getEvaCount();
	}
	public List<LeaderCheck> getLeaderChecks(){
		return indicatorDao.getLeaderChecks();
	}
}
