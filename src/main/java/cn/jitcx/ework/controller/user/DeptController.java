package cn.jitcx.ework.controller.user;


import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cn.jitcx.ework.model.dao.user.DeptDao;
import cn.jitcx.ework.model.dao.user.PositionDao;
import cn.jitcx.ework.model.dao.user.UserDao;
import cn.jitcx.ework.model.entity.user.Dept;
import cn.jitcx.ework.model.entity.user.Position;
import cn.jitcx.ework.model.entity.user.User;

@Controller
@RequestMapping("/")
public class DeptController {
	
	@Autowired
	DeptDao deptdao;
	@Autowired
	UserDao udao;
	@Autowired
	PositionDao pdao;
	
	/**
	 * 第一次进入部门管理页面
	 * 显示部门列表
	 * @return
	 */
	@RequestMapping("deptmanage")
	public String deptmanage(Model model) {
		List<Dept> depts = (List<Dept>) deptdao.findAll();
		model.addAttribute("depts",depts);
		return "user/deptmanage";
	}
	
	@RequestMapping(value = "deptedit" ,method = RequestMethod.POST)
	public String adddept(@Valid Dept dept,@RequestParam("xg") String xg,BindingResult br,Model model){
		if(!br.hasErrors()){
			Dept adddept = deptdao.save(dept);
			if("add".equals(xg)){
				Position jinli = new Position();
				jinli.setDeptid(adddept.getDeptId());
				jinli.setName("经理");
				Position wenyuan = new Position();
				wenyuan.setDeptid(adddept.getDeptId());
				wenyuan.setName("文员");
				pdao.save(jinli);
				pdao.save(wenyuan);
			}
			if(adddept!=null){
				model.addAttribute("success",1);
				return "/deptmanage";
			}
		}
		model.addAttribute("errormess","错误！~");
		return "user/deptedit";
	}
	
	@RequestMapping(value = "deptedit" ,method = RequestMethod.GET)
	public String changedept(@RequestParam(value = "dept",required=false) Long deptId,Model model){
		if(deptId!=null){
			Dept dept = deptdao.findOne(deptId);
			model.addAttribute("dept",dept);
		}
		return "user/deptedit";
	}

	/*
	* 展示部门所有员工及部门经理
	* */
	@RequestMapping("readdept")
	public String readdept(@RequestParam(value = "deptid") Long deptId,Model model){
		Dept dept = deptdao.findOne(deptId);
		User deptmanage = null;
		if(dept.getDeptmanager()!=null){ //如果该部门有经理
			deptmanage = udao.findOne(dept.getDeptmanager());
			model.addAttribute("deptmanage",deptmanage);
		}
		List<Dept> depts = (List<Dept>) deptdao.findAll();
		List<Position> positions = pdao.findByDeptidAndNameNotLike(1L, "%经理");
		List<User> formaluser = new ArrayList<>();
		List<User> formaluser1 = new ArrayList<>();
		List<User> deptusers = udao.findByDept(dept);
		for(User deptUser : deptusers) {
			Integer isLock = deptUser.getIsLock();
			if(isLock.equals(0)){
				formaluser.add(deptUser);
			}
		}
		
		for (User deptuser : formaluser) {
			Position position = deptuser.getPosition();
			if(!position.getName().endsWith("经理")){
				formaluser1.add(deptuser);
			}
		}
		model.addAttribute("positions",positions);
		model.addAttribute("depts",depts);
		model.addAttribute("deptuser",formaluser1);
		model.addAttribute("dept",dept);
		model.addAttribute("isread",1);
		
		return "user/deptread";
		
	}
	
	@RequestMapping("deptandpositionchange")
	public String deptandpositionchange(@RequestParam("positionid") Long positionid,
			@RequestParam("changedeptid") Long changedeptid,
			@RequestParam("userid") Long userid,
			@RequestParam("deptid") Long deptid,
			Model model){
		User user = udao.findOne(userid);
		Dept changedept = deptdao.findOne(changedeptid);
		Position position = pdao.findOne(positionid);
		user.setDept(changedept);
		user.setPosition(position);
		udao.save(user);
		
		model.addAttribute("deptid",deptid);
		return "/readdept";
	}
	
	@RequestMapping("deletdept")
	public String deletdept(@RequestParam("deletedeptid") Long deletedeptid){
		Dept dept = deptdao.findOne(deletedeptid);
		List<Position> ps = pdao.findByDeptid(deletedeptid);
		for (Position position : ps) {
			pdao.delete(position);
		}
		deptdao.delete(dept);
		return "/deptmanage";
		
	}

	/*
	* 更换部门经理
	* */
	@RequestMapping("deptmanagerchange")
	public String deptmanagerchange(@RequestParam(value="positionid",required=false) Long positionid,
			@RequestParam(value="changedeptid",required=false) Long changedeptid,
			@RequestParam(value="oldmanageid",required=false) Long oldmanageid,
			@RequestParam(value="newmanageid",required=false) Long newmanageid,
			@RequestParam("deptid") Long deptid,
			Model model){
		Dept deptnow = deptdao.findOne(deptid);
		if(oldmanageid!=null){
			User oldmanage = udao.findOne(oldmanageid);
			Position namage = oldmanage.getPosition();
			Dept changedept = deptdao.findOne(changedeptid);
			Position changeposition = pdao.findOne(positionid);
			oldmanage.setDept(changedept);
			oldmanage.setPosition(changeposition);
			udao.save(oldmanage);
			if(newmanageid!=null){
				User newmanage = udao.findOne(newmanageid);
				newmanage.setPosition(namage);
				deptnow.setDeptmanager(newmanageid);
				deptdao.save(deptnow);
				udao.save(newmanage);
			}else{
				deptnow.setDeptmanager(null);
				deptdao.save(deptnow);
			}
		}else{
			User newmanage = udao.findOne(newmanageid);
			Position manage = pdao.findByDeptidAndNameLike(deptid, "%经理").get(0);
			newmanage.setPosition(manage);
			deptnow.setDeptmanager(newmanageid);
			deptdao.save(deptnow);
			udao.save(newmanage);
		}
		model.addAttribute("deptid",deptid);
		return "/readdept";
	}
}
