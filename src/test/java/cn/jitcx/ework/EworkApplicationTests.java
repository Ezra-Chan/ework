package cn.jitcx.ework;

import org.springframework.beans.factory.annotation.Autowired;

import cn.jitcx.ework.mappers.NoticeMapper;
import cn.jitcx.ework.services.inform.InformService;

//@RunWith(SpringRunner.class)
//@SpringBootTest
public class EworkApplicationTests {
	
	@Autowired
	private NoticeMapper nm;
	
	@Autowired
	private InformService informService;
	
	

		
//		List<Map<String, Object>> list=informService.informList(listOne);
//		for (Map<String, Object> map : list) {
//			System.out.println(map);
//		}

	
	

}
