package cn.jitcx.ework.model.dao.processdao;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import cn.jitcx.ework.model.entity.process.Subject;

public interface SubjectDao extends PagingAndSortingRepository<Subject, Long>{

	List<Subject> findByParentId(Long id);
	
	List<Subject> findByParentIdNot(Long id);
	
	
}
