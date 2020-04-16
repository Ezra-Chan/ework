package cn.jitcx.ework.model.dao.processdao;

import org.springframework.data.repository.PagingAndSortingRepository;

import cn.jitcx.ework.model.entity.process.EvectionMoney;
import cn.jitcx.ework.model.entity.process.ProcessList;

public interface EvectionMoneyDao extends PagingAndSortingRepository<EvectionMoney, Long>{

	EvectionMoney findByProId(ProcessList pro);
}
