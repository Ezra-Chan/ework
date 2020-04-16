package cn.jitcx.ework.model.dao.processdao;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import cn.jitcx.ework.model.entity.process.Bursement;
import cn.jitcx.ework.model.entity.process.DetailsBurse;

public interface DetailsBurseDao extends PagingAndSortingRepository<DetailsBurse, Long>{

	List<DetailsBurse> findByBurs(Bursement bu);
}
