package cn.jitcx.ework.model.dao.processdao;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import cn.jitcx.ework.model.entity.process.EvectionMoney;

import cn.jitcx.ework.model.entity.process.Traffic;

public interface TrafficDao extends PagingAndSortingRepository<Traffic, Long>{

	List<Traffic> findByEvection(EvectionMoney money);
}
