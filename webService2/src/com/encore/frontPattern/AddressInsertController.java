package com.encore.frontPattern;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.encore.model.AddressVO;
import com.encore.model.UserService;


public class AddressInsertController implements CommonCtroller {
	UserService service = new UserService();
	@Override
	public void execute(Map<String, Object> map) {
		if(((String) map.get("method")).equals("get")) {
			}else {
				@SuppressWarnings("unchecked")
				List<AddressVO> addlist = (ArrayList<AddressVO>) map.get("addlist");
				int count = service.insertAdd(addlist);
				map.put("userResult", count>0 ? count + "건 주소 등록이 성공적으로 이루어졌습니다." : count + "건 주소 등록에 실패하셨습니다.");
				map.remove("useradd");
			}
	}

}
