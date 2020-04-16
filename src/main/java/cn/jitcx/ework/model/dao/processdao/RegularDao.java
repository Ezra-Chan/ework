package cn.jitcx.ework.model.dao.processdao;

import org.springframework.data.repository.PagingAndSortingRepository;

import cn.jitcx.ework.model.entity.process.ProcessList;
import cn.jitcx.ework.model.entity.process.Regular;

public interface RegularDao extends PagingAndSortingRepository<Regular, Long>{

	Regular findByProId(ProcessList pro);

}
