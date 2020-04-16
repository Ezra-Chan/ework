package cn.jitcx.ework.model.dao.processdao;

import org.springframework.data.repository.PagingAndSortingRepository;

import cn.jitcx.ework.model.entity.process.ProcessList;
import cn.jitcx.ework.model.entity.process.Resign;

public interface ResignDao extends PagingAndSortingRepository<Resign, Long>{

	Resign findByProId(ProcessList process);

}
