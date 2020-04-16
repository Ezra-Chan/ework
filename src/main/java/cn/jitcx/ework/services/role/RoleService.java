package cn.jitcx.ework.services.role;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.jitcx.ework.model.dao.roledao.RolepowerlistDao;
import cn.jitcx.ework.model.entity.role.Role;
import cn.jitcx.ework.model.entity.role.Rolepowerlist;
import cn.jitcx.ework.model.entity.system.SystemMenu;

@Service
@Transactional
public class RoleService {
	@Autowired
	private RolepowerlistDao rldao;
	
	public void index(List<SystemMenu>  menulist,Role rolep){
		
		for (SystemMenu systemMenu : menulist) {
			rldao.save(new Rolepowerlist(rolep,systemMenu));
		}
	}
	//保存一个对象；	
	public Rolepowerlist sava(Rolepowerlist rolepower){
		return rldao.save(rolepower);
	}

}
