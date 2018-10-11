package teavs.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import teavs.entity.EvaCheck;
import teavs.entity.EvaDetail;
import teavs.entity.EvaManage;
import teavs.entity.Indicator;

public interface IndicatorDao {
	List<Indicator> getIndicator(int i);
	List<Indicator> getIndicatorOR(int i);
	int addIndicator(Indicator indicator);
	int add_Eva_Manage(EvaManage evaManage);
	int ma_Open(int id);
	int ma_Close(int id);
	int ma_Delay(int id);
	List<EvaCheck> getEveChecks(int num);
	int getIsEva(@Param("arg0")int task_id,@Param("arg1")String teacher_id,@Param("arg2")String student_id);
	int eva_Sub(EvaDetail evaDetail);
	int add_Eva_State(@Param("arg0")int eid,@Param("arg1")String teacher_id,@Param("arg2")String student_id);
	List<EvaDetail> getTEva(String teacher_id);
}
