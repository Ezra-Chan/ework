package cn.jitcx.ework.model.dao.informdao;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import cn.jitcx.ework.model.entity.notice.NoticeUserRelation;
import cn.jitcx.ework.model.entity.notice.NoticesList;
import cn.jitcx.ework.model.entity.user.User;

public interface InformRelationDao extends PagingAndSortingRepository<NoticeUserRelation, Long> {
	
	//根据用户找到通知联系人中间的集合
	List<NoticeUserRelation> findByUserId(User userId);
	
	//找到该用户未读的消息
	List<NoticeUserRelation> findByReadAndUserId(Boolean read,User userid);
	
	//根据通知找到所有的通知联系表中的集合
	List<NoticeUserRelation> findByNoticeId(NoticesList notice);
	
	//根据用户id和通知id找到唯一的对象
	NoticeUserRelation findByUserIdAndNoticeId(User userId,NoticesList notice);
	
}
