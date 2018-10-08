package teavs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teavs.dao.IndicatorDao;
import teavs.entity.Indicator;

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
}
