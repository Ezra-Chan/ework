package cn.jitcx.ework.model.dao.processdao;

import org.springframework.data.repository.PagingAndSortingRepository;

import cn.jitcx.ework.model.entity.process.Bursement;
import cn.jitcx.ework.model.entity.process.ProcessList;

public interface BursementDao extends PagingAndSortingRepository<Bursement, Long>{

	Bursement findByProId(ProcessList process);
	
	

}
