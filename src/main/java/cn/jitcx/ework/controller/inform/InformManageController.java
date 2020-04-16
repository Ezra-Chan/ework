package cn.jitcx.ework.controller.inform;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.jitcx.ework.common.formValid.BindingResultVOUtil;
import cn.jitcx.ework.common.formValid.MapToList;
import cn.jitcx.ework.common.formValid.ResultEnum;
import cn.jitcx.ework.common.formValid.ResultVO;
import cn.jitcx.ework.mappers.NoticeMapper;
import cn.jitcx.ework.model.dao.informdao.InformDao;
import cn.jitcx.ework.model.dao.informdao.InformRelationDao;
import cn.jitcx.ework.model.dao.system.StatusDao;
import cn.jitcx.ework.model.dao.user.DeptDao;
import cn.jitcx.ework.model.dao.user.UserDao;
import cn.jitcx.ework.model.entity.notice.NoticeUserRelation;
import cn.jitcx.ework.model.entity.notice.NoticesList;
import cn.jitcx.ework.model.entity.system.SystemStatusList;
import cn.jitcx.ework.model.entity.user.User;
import cn.jitcx.ework.services.inform.InformRelationService;
import cn.jitcx.ework.services.inform.InformService;

@Controller
@RequestMapping("/")
public class InformManageController {

	Logger log = LoggerFactory.getLogger(getClass());
	@Autowired
	private StatusDao statusDao;
	@Autowired
	private InformDao informDao;
	@Autowired
	private InformService informService;
	@Autowired
	private UserDao uDao;
	@Autowired
	private DeptDao deptDao;
	@Autowired
	private InformRelationDao informrelationDao;
	@Autowired
	private InformRelationService informrelationservice;
	@Autowired
	private NoticeMapper nm;

	/**
	 * 公告管理面板
	 * 
	 * @return
	 */
	@RequestMapping("infrommanage")
	public String inform(@RequestParam(value = "page", defaultValue = "0") int page,@SessionAttribute("userId") Long userId,Model model) {
		Page<NoticesList> page2 = informService.pageThis(page,userId);
		List<NoticesList> noticeList=page2.getContent();
		List<Map<String, Object>> list=informService.fengZhuang(noticeList);
		model.addAttribute("list", list);
		model.addAttribute("page", page2);
		//设置变量，需要load的url；
		model.addAttribute("url", "infrommanagepaging");
		return "inform/informmanage";
	}
	
	@RequestMapping("forwardother")
	public String forwardOther(@SessionAttribute("userId")Long userId,@RequestParam(value="noticeId")Long noticeId){
		List<User> users=uDao.findByFatherId(userId);
		NoticesList nl=informDao.findOne(noticeId);
		List<NoticeUserRelation> nurs=new  ArrayList<>();
		for (User user : users) {
			nurs.add(new NoticeUserRelation(nl, user, false));
		}
		informrelationservice.saves(nurs);
		return "redirect:/infromlist";
	}

	/**
	 * 公告管理删除
	 */
	@RequestMapping("infromdelete")
	public String infromDelete(HttpSession session, HttpServletRequest req) {
		Long noticeId = Long.parseLong(req.getParameter("id"));
		Long userId = Long.parseLong(session.getAttribute("userId") + "");
		NoticesList notice = informDao.findOne(noticeId);
		if (!Objects.equals(userId, notice.getUserId())) {
			System.out.println("权限不匹配，不能删除");
			return "redirect:/notlimit";
		}
		informService.deleteOne(noticeId);
		return "redirect:/infrommanage";
	}

	/**
	 * 公告列表删除
	 */
	@RequestMapping("informlistdelete")
	public String informListDelete(HttpServletRequest req, HttpSession session) {
		Long userId = Long.parseLong(session.getAttribute("userId") + "");
		Long noticeId = Long.parseLong(req.getParameter("id"));
		NoticeUserRelation relation = informrelationDao.findByUserIdAndNoticeId(uDao.findOne(userId), informDao.findOne(noticeId));
		if (Objects.isNull(relation)) {
			System.out.println("权限不匹配，不能删除");
			return "redirect:/notlimit";
		}
		informrelationservice.deleteOne(relation);
		return "forward:/infromlist";
	}

	/**
	 * 公告列表
	 * 
	 * @return
	 */
	@RequestMapping("infromlist")
	public String infromList(HttpSession session, HttpServletRequest req, Model model,
			@RequestParam(value="pageNum",defaultValue="1") int page) {
		Long userId = Long.parseLong(session.getAttribute("userId") + "");
		PageHelper.startPage(page, 10);
		List<Map<String, Object>> list = nm.findMyNotice(userId);
		PageInfo<Map<String, Object>> pageinfo=new PageInfo<Map<String, Object>>(list);
		List<Map<String, Object>> list2=informrelationservice.setList(list);
		model.addAttribute("url", "informlistpaging");
		model.addAttribute("list", list2);
		model.addAttribute("page", pageinfo);
		return "inform/informlist";
	}

	/**
	 * 编辑公告界面
	 */
	@RequestMapping("informedit")
	public String infromEdit(HttpServletRequest req, HttpSession session, Model model) {
		session.removeAttribute("noticeId");
		List<SystemStatusList> statusList = statusDao.findByStatusModel("inform");
		if (!StringUtils.isEmpty(req.getAttribute("errormess"))) {
			req.setAttribute("errormess", req.getAttribute("errormess"));
		}
		if (!StringUtils.isEmpty(req.getAttribute("success"))) {
			req.setAttribute("success", "数据保存成功");
		}
		req.setAttribute("statusList", statusList);
		if (!StringUtils.isEmpty(req.getParameter("id"))) {
			Long noticeId = Long.parseLong(req.getParameter("id"));
			NoticesList noticeList = informDao.findOne(noticeId);
			model.addAttribute("noticeList", noticeList);
			model.addAttribute("statusName", statusDao.findOne(noticeList.getStatusId()).getStatusName());
			session.setAttribute("noticeId", noticeId);
		}
		return "inform/informedit";
	}

	/**
	 * 详细公告显示
	 */
	@RequestMapping("informshow")
	public String informShow(HttpServletRequest req, Model model) {
		Long noticeId = Long.parseLong(req.getParameter("id"));
		if (!StringUtils.isEmpty(req.getParameter("read"))) {
			if (("0").equals(req.getParameter("read"))) {
				Long relationId = Long.parseLong(req.getParameter("relationid"));
				NoticeUserRelation relation = informrelationDao.findOne(relationId);
				relation.setRead(true);
				informrelationservice.save(relation);
			}
		}
		NoticesList notice = informDao.findOne(noticeId);
		User user = uDao.findOne(notice.getUserId());
		model.addAttribute("notice", notice);
		model.addAttribute("realName", user.getRealName());
		return "inform/informshow";
	}

	/**
	 * 系统管理表单验证
	 * 
	 * @param req
	 * @param menu
	 * @param br
	 *            后台校验表单数据，不通过则回填数据，显示错误信息；通过则直接执行业务，例如新增、编辑等；
	 * @return
	 */
	@RequestMapping("informcheck")
	public String testMess(HttpServletRequest req, @Valid NoticesList menu, BindingResult br) {
		HttpSession session = req.getSession();
		Long menuId = null;
		req.setAttribute("menuObj", menu);
		Long userId = Long.parseLong(session.getAttribute("userId") + "");
		menu.setUserId(userId);

		// 这里返回ResultVO对象，如果校验通过，ResultEnum.SUCCESS.getCode()返回的值为200；否则就是没有通过；
		ResultVO res = BindingResultVOUtil.hasErrors(br);
		// 校验失败
		if (!ResultEnum.SUCCESS.getCode().equals(res.getCode())) {
			List<Object> list = new MapToList<>().mapToList(res.getData());
			req.setAttribute("errormess", list.get(0).toString());
			// 下面的info信息是打印出详细的信息
			log.info("getData:{}", res.getData());
			log.info("getCode:{}", res.getCode());
			log.info("getMsg:{}", res.getMsg());
		}
		// 校验通过，下面写自己的逻辑业务
		else {
			// 判断是否从编辑界面进来的，前面有"session.setAttribute("getId",getId);",在这里获取，并remove掉；
			if (!StringUtils.isEmpty(session.getAttribute("noticeId"))) {
				menuId = (Long) session.getAttribute("noticeId"); // 获取进入编辑界面的menuID值
				NoticesList inform = informDao.findOne(menuId);
				menu.setNoticeTime(inform.getNoticeTime());
				menu.setNoticeId(menuId);
				session.removeAttribute("noticeId");
				informService.save(menu);
			} else {
				menu.setNoticeTime(new Date());
				menu.setUserId(userId);
				NoticesList noticeList = informService.save(menu);
				if (userId == 1){
					//超级管理员发布的公告给所有人看
					List<User> userList = uDao.findAll();
					for (User user : userList) {
						informrelationservice.save(new NoticeUserRelation(noticeList, user, false));
					}
				}else {
					List<User> userList = uDao.findByFatherId(userId);
					for (User user : userList) {
						informrelationservice.save(new NoticeUserRelation(noticeList, user, false));
					}
				}
			}
			// 执行业务代码
			req.setAttribute("success", "后台验证成功");
		}
		return "forward:/informedit";
	}
}
