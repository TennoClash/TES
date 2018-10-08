package teavs.dao;

import java.util.List;

import teavs.entity.Indicator;

public interface IndicatorDao {
	List<Indicator> getIndicator(int i);
	List<Indicator> getIndicatorOR(int i);
	int addIndicator(Indicator indicator);
}
