package cn.jitcx.ework.controller.user;

import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.util.StringUtil;
import com.github.stuxuhai.jpinyin.PinyinException;
import com.github.stuxuhai.jpinyin.PinyinFormat;
import com.github.stuxuhai.jpinyin.PinyinHelper;

import cn.jitcx.ework.model.dao.roledao.RoleDao;
import cn.jitcx.ework.model.dao.user.DeptDao;
import cn.jitcx.ework.model.dao.user.PositionDao;
import cn.jitcx.ework.model.dao.user.UserDao;
import cn.jitcx.ework.model.entity.role.Role;
import cn.jitcx.ework.model.entity.user.Dept;
import cn.jitcx.ework.model.entity.user.Position;
import cn.jitcx.ework.model.entity.user.User;

@Controller
@RequestMapping("/")
public class UserController {
	
	@Autowired
	UserDao udao;
	@Autowired
	DeptDao ddao;
	@Autowired
	PositionDao pdao;
	@Autowired
	RoleDao rdao;

	/*用户操作记录*/
	@RequestMapping("userlogmanage")
	public String userlogmanage() {
		return "user/userlogmanage";
	}

	/*用户列表*/
	@RequestMapping("usermanage")
	public String usermanage(Model model,@RequestParam(value="page",defaultValue="0") int page,
			@RequestParam(value="size",defaultValue="10") int size) {
		Sort sort=new Sort(new Order(Direction.ASC,"dept"));//通过部门排序
		Pageable pa=new PageRequest(page, size,sort);
		Page<User> userspage = udao.findByIsLock(0, pa);
		List<User> users=userspage.getContent();
		model.addAttribute("users",users);
		model.addAttribute("page", userspage);
		model.addAttribute("url", "usermanagepaging");
		return "user/usermanage";
	}

	@RequestMapping("getLockedUsers")
	public String getLockedUsers(Model model,@RequestParam(value="page",defaultValue="0") int page,
			@RequestParam(value="size",defaultValue="10") int size){
		Sort sort=new Sort(new Order(Direction.ASC,"dept"));//通过部门排序
		Pageable pa=new PageRequest(page, size,sort);
		Page<User> usersPage = udao.findByIsLock(1, pa);
		List<User> lockedUsers=usersPage.getContent();
		model.addAttribute("lockedUsers",lockedUsers);
		model.addAttribute("page", usersPage);
		model.addAttribute("url", "lockedUserPaging");
		return "user/editLockedUser";
	}
	
	@RequestMapping("usermanagepaging")
	public String userPaging(Model model,@RequestParam(value="page",defaultValue="0") int page,
			@RequestParam(value="size",defaultValue="10") int size,
			@RequestParam(value="usersearch",required=false) String usersearch){
		Sort sort=new Sort(new Order(Direction.ASC,"dept"));
		Pageable pa=new PageRequest(page, size,sort);
		Page<User> userspage = null;
		if(StringUtil.isEmpty(usersearch)){
			userspage =  udao.findByIsLock(0, pa);
		}else{
			userspage = udao.findNameLike(usersearch, pa);
		}
		List<User> users=userspage.getContent();
		model.addAttribute("users",users);
		model.addAttribute("page", userspage);
		model.addAttribute("url", "usermanagepaging");
		
		return "user/usermanagepaging";
	}

	@RequestMapping("lockedUserPaging")
	public String lockedUserPaging(Model model,@RequestParam(value="page",defaultValue="0") int page,
			@RequestParam(value="size",defaultValue="10") int size,
			@RequestParam(value="lockedUserSearch",required=false) String lockedUserSearch){
		Sort sort=new Sort(new Order(Direction.ASC,"dept"));
		Pageable pa=new PageRequest(page, size,sort);
		Page<User> userspage = null;
		if(StringUtil.isEmpty(lockedUserSearch)){
			userspage =  udao.findByIsLock(1, pa);
		}else{
//			model.addAttribute("searchCondition",lockedUserSearch);
			userspage = udao.findLockedUserNameLike(lockedUserSearch, pa);
		}
		List<User> lockedUsers=userspage.getContent();
		model.addAttribute("lockedUsers",lockedUsers);
		model.addAttribute("page", userspage);
		model.addAttribute("url", "lockedUserPaging");

		return "user/lockedUserPaging";
	}
	@RequestMapping("unlockUser")
    public String unlockUser(@RequestParam("userid") Long userid,Model model){
        User user = udao.findOne(userid);
        user.setIsLock(0);
        udao.save(user);
        model.addAttribute("success",1);
        return "/getLockedUsers";
    }

	@RequestMapping(value="useredit",method = RequestMethod.GET)
	public String usereditget(@RequestParam(value = "userid",required=false) Long userid,Model model) {
		if(userid!=null){
			User user = udao.findOne(userid);
			model.addAttribute("where","xg");
			model.addAttribute("user",user);
		}
		
		List<Dept> depts = (List<Dept>) ddao.findAll();
		List<Position> positions = (List<Position>) pdao.findAll();
		List<Role> roles = (List<Role>) rdao.findAll();
		
		model.addAttribute("depts", depts);
		model.addAttribute("positions", positions);
		model.addAttribute("roles", roles);
		return "user/edituser";
	}
	
	@RequestMapping(value="useredit",method = RequestMethod.POST)
	public String usereditpost(User user,
			@RequestParam("deptid") Long deptid,
			@RequestParam("positionid") Long positionid,
			@RequestParam("roleid") Long roleid,
			@RequestParam(value = "isbackpassword",required=false) boolean isbackpassword,
			Model model) throws PinyinException {
		Dept dept = ddao.findOne(deptid);
		Position position = pdao.findOne(positionid);
		Role role = rdao.findOne(roleid);
		if(user.getUserId()==null){
			String pinyin=PinyinHelper.convertToPinyinString(user.getUserName(), "", PinyinFormat.WITHOUT_TONE);
			user.setPinyin(pinyin);
			String password="123456";
			String s = DigestUtils.md5Hex(password);
			user.setPassword(s);
			user.setDept(dept);
			user.setRole(role);
			user.setPosition(position);
			user.setFatherId(dept.getDeptmanager());
			udao.save(user);
		}else{
			User user2 = udao.findOne(user.getUserId());
			user2.setUserTel(user.getUserTel());
			user2.setRealName(user.getRealName());
			user2.setAddress(user.getAddress());
			user2.setUserEdu(user.getUserEdu());
			user2.setSchool(user.getSchool());
			user2.setIdCard(user.getIdCard());
			user2.setBank(user.getBank());
			user2.setThemeSkin(user.getThemeSkin());
			user2.setSalary(user.getSalary());
			user2.setFatherId(dept.getDeptmanager());
			user2.setBirth(user.getBirth());
			if(isbackpassword){
				String password="123456";
				String s = DigestUtils.md5Hex(password);
				user2.setPassword(s);
			}
			user2.setDept(dept);
			user2.setRole(role);
			user2.setPosition(position);
			udao.save(user2);
		}
		
		model.addAttribute("success",1);
		return "/usermanage";
	}
	
	/*删除用户*/
	@RequestMapping("deleteuser")
	public String deleteuser(@RequestParam("userid") Long userid,Model model){
		User user = udao.findOne(userid);
		user.setIsLock(1);
		udao.save(user);
		model.addAttribute("success",1);
		return "/usermanage";
	}
	
	@RequestMapping("useronlyname")
    public @ResponseBody boolean useronlyname(@RequestParam("username") String username){
		User user = udao.findByUserName(username);
		if(user==null){
			return true;
		}
		return false;
    }
	
	@RequestMapping("selectdept")
	public @ResponseBody List<Position> selectdept(@RequestParam("selectdeptid") Long deptid){
		
		return pdao.findByDeptidAndNameNotLike(deptid, "%经理");
	}
	
	

}
