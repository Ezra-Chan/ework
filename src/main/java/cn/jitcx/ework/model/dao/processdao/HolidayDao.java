package cn.jitcx.ework.model.dao.processdao;

import org.springframework.data.repository.PagingAndSortingRepository;

import cn.jitcx.ework.model.entity.process.Holiday;
import cn.jitcx.ework.model.entity.process.ProcessList;

public interface HolidayDao extends PagingAndSortingRepository<Holiday, Long>{

	Holiday findByProId(ProcessList pro);

}
