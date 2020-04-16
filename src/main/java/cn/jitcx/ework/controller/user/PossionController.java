package cn.jitcx.ework.controller.user;

import java.util.List;

import cn.jitcx.ework.model.dao.user.UserDao;
import cn.jitcx.ework.model.entity.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cn.jitcx.ework.model.dao.user.DeptDao;
import cn.jitcx.ework.model.dao.user.PositionDao;
import cn.jitcx.ework.model.entity.user.Dept;
import cn.jitcx.ework.model.entity.user.Position;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class PossionController {
	
	@Autowired
	PositionDao pdao;
	@Autowired
	DeptDao ddao;
	@Autowired
	UserDao udao;
	/*
	* 显示所有职位
	* */
	@RequestMapping("positionmanage")
	public String positionmanage(Model model) {
		
		List<Position> positions = (List<Position>) pdao.findAll();
		
		model.addAttribute("positions",positions);
		
		return "user/positionmanage";
	}

	/*
	* 修改职位信息
	* */
	@RequestMapping(value = "positionedit" ,method = RequestMethod.GET)
	public String positioneditget(@RequestParam(value = "positionid",required=false) Long positionid,Model model){
		if(positionid!=null){
			Position position = pdao.findOne(positionid);
			Dept dept = ddao.findOne(position.getDeptid());
			model.addAttribute("positiondept",dept);
			model.addAttribute("position",position);
		}
		List<Dept> depts = (List<Dept>) ddao.findAll();
		model.addAttribute("depts", depts);
		return "user/positionedit";
	}
	
	@RequestMapping(value = "positionedit" ,method = RequestMethod.POST)
	public String positioneditpost(Position position,Model model){
		Position psition2 = pdao.save(position);
		if(psition2!=null){
			model.addAttribute("success",1);
			return "/positionmanage";
		}
		model.addAttribute("errormess","数据插入失败");
		return "user/positionedit";
	}

	/*
	*删除职位
	* */
	@RequestMapping("deletePosition")
	public String removeposition(@RequestParam("positionid") Long positionid, Model model, HttpSession session){
		String userId = session.getAttribute("userId").toString().trim();
		Long userid = Long.parseLong(userId);
		User user=udao.findOne(userid);
		if(user.getSuperman().equals(true)){
			List<User> useList=udao.findPosition(positionid);
			if(useList.size()>0){
				model.addAttribute("error", "此职位下还有职员，不允许删除。");
				return "common/proce";
			}else{
				pdao.delete(positionid);
				model.addAttribute("success",1);
			}
		}else{
			model.addAttribute("error", "只有超级管理员才能操作。");
			return "common/proce";
		}
		return "/positionmanage";
	}
}