package com.encore.frontPattern;

import java.util.List;
import java.util.Map;

import com.encore.model.AddressVO;
import com.encore.model.UserService;

public class setMyAddController implements CommonCtroller {
	UserService service = new UserService();
	@Override
	public void execute(Map<String, Object> map) {
		// TODO Auto-generated method stub
		if(map.get("method").equals("get")) {
			List<AddressVO> addlist = service.selectAllAdd((String) map.get("id"));
			map.put("addlist", addlist);
		} else {
			int count = service.updateAddMain((String)map.get("id"), Integer.parseInt(map.get("addNo").toString()));
			map.put("userResult", count>0 ? "공유 주소 설정을 완료하였습니다." : "공유 주소 설정에 실패하였습니다.");
		}
	}

}