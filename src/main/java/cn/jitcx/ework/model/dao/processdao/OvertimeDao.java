package cn.jitcx.ework.model.dao.processdao;

import org.springframework.data.repository.PagingAndSortingRepository;

import cn.jitcx.ework.model.entity.process.Overtime;
import cn.jitcx.ework.model.entity.process.ProcessList;

public interface OvertimeDao extends PagingAndSortingRepository<Overtime, Long>{

	Overtime findByProId(ProcessList pro);

}
