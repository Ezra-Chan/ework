package cn.jitcx.ework.controller.login;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import cn.jitcx.ework.model.entity.user.User;
import cn.jitcx.ework.model.entity.user.LoginRecord;
import cn.jitcx.ework.model.dao.user.UserDao;
import cn.jitcx.ework.services.user.UserLongRecordService;
import cn.jitcx.ework.util.GetToken;
import cn.jitcx.ework.util.GsonUtils;
import cn.jitcx.ework.util.HttpUtil;
import eu.bitwalker.useragentutils.Browser;
import eu.bitwalker.useragentutils.UserAgent;
import eu.bitwalker.useragentutils.Version;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/")
public class FaceController {
    @Autowired
    private UserDao uDao;
    @Autowired
    UserLongRecordService ulService;

    /**
     *
     * @return人脸识别界面
     */
    @RequestMapping("faceRecognitionLogin")
    public String faceRecognitionLogin() {
        return "login/faceSearch";
    }

    /**
     *
     * @return账号登录界面
     */
    @RequestMapping("accountLogin")
    public String accountLogin(){
        return "login/account";
    }
    /**
     * 人脸识别
     * @param request
     * @return 可自行将String改为JSONObject
     * @throws Exception
     */
    @RequestMapping("faceAjax")
    @ResponseBody
    public Long face(HttpServletRequest request) throws Exception {
        String url = "https://aip.baidubce.com/rest/2.0/face/v3/search";//请求的url,可以查看官方文档查看不同请求的url

        Map<String, Object> map = new HashMap<>();
        map.put("image", request.getParameter("base"));//获取前台的人脸识别后发送的base64
        map.put("group_id_list", "superManager,manager,employee");//之前创建的人脸库，可以在百度云的管理控制台查看用户组
        map.put("image_type", "BASE64");//照片类型为base64
        map.put("liveness_control", "HIGH");//活体控制 检测结果中不符合要求的人脸会被过滤  NORMAL: 一般的活体要求(平衡的攻击拒绝率, 通过率)
        map.put("max_face_num", "3");//最多处理人脸的数目
        map.put("face_field", "age,beauty,expression,emotion,gender,glasses,race,quality,mask");

        String param = GsonUtils.toJson(map);

        String accessToken = GetToken.getAuth();
        try{
            String result = HttpUtil.post(url, accessToken, "application/json", param);
            if (result.contains("liveness check fail")){
                return -1l;
            }
            JSONObject jsonObject = (JSONObject) JSON.parse(result);
            JSONObject object = (JSONObject) jsonObject.get("result");
            JSONArray string = (JSONArray) object.get("user_list");
            JSONObject ob = (JSONObject) string.get(0);
            BigDecimal valueOf = (BigDecimal) ob.get("score");
            String group = (String) ob.get("group_id");
            String str = (String) ob.get("user_id");
            Long u_id = Long.parseLong(str);
            HttpSession session = request.getSession();
            session.setAttribute("user_id", u_id);
            session.setAttribute("group_id",group);
            if(valueOf.doubleValue() > 75) {
                System.out.println("识别相似度大于75分");
                return u_id;
            }else if (valueOf.doubleValue() > 30){
                System.out.println("识别相似度小于75分大于30分");
                return 0l;
            }else {
                System.out.println("识别相似度小于30分");
                return -3l;
            }
        }catch (NullPointerException e){
            return -2l;
        }

    }

    @RequestMapping("faceLogin")
    public String faceLogin(HttpServletRequest request, Model model) throws UnknownHostException {
        HttpSession session = request.getSession();
        String group = (String)session.getAttribute("group_id");
        Long id = (Long) session.getAttribute("user_id");

        User user = uDao.findOne(id);
        if(user.getIsLock()==1){
            model.addAttribute("errormess", "账号已被冻结!");
            return "login/login";
        }
        Object sessionId=session.getAttribute("userId");
        if(sessionId==user.getUserId()){
            model.addAttribute("hasmess", "当前用户已经登录了");
            session.setAttribute("thisuser", user);
            return "login/login";
        }else {
            session.setAttribute("userId", user.getUserId());
            Browser browser = UserAgent.parseUserAgentString(request.getHeader("User-Agent")).getBrowser();
            Version version = browser.getVersion(request.getHeader("User-Agent"));
            String info = browser.getName() + "/" + version.getVersion();
            String ip = InetAddress.getLocalHost().getHostAddress();
            /*新增登录记录*/
            ulService.save(new LoginRecord(ip, new Date(), info, user));
            session.setAttribute("user_session", user);
            session.setMaxInactiveInterval(24 * 60 * 60);
        }
        return "redirect:/index";
    }

    @RequestMapping("uploadFace")
    @ResponseBody
    public int upLoadFace(HttpServletRequest request) throws Exception{
        int i = 0;
        Long id;
        // 请求url
        String url = "https://aip.baidubce.com/rest/2.0/face/v3/faceset/user/add";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user_session");
        id= user.getUserId();
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("image", request.getParameter("base"));
            if(user.getSuperman()){
                //超级管理员
                map.put("group_id", "superManager");
            }else if(user.getFatherId() == 3 || user.getUserId() == 3) {
                //管理员
                map.put("group_id", "manager");
            }else {
                //员工
                map.put("group_id", "employee");
            }
            map.put("user_id", id);
            map.put("user_info", "");
            map.put("liveness_control", "NORMAL");
            map.put("image_type", "BASE64");
            map.put("quality_control", "LOW");

            String param = GsonUtils.toJson(map);

            String accessToken = GetToken.getAuth();

            String result = HttpUtil.post(url, accessToken, "application/json", param);

            //判断是否上传成功
            if (result.contains("SUCCESS")){
                i = 1;
            }else {
                i = 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            i = 0;
        }
        return i;
    }
}

