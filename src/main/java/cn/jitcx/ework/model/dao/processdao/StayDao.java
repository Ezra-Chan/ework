package cn.jitcx.ework.model.dao.processdao;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import cn.jitcx.ework.model.entity.process.EvectionMoney;
import cn.jitcx.ework.model.entity.process.Stay;

public interface StayDao extends PagingAndSortingRepository<Stay, Long>{
 
	List<Stay> findByEvemoney(EvectionMoney money);
}
