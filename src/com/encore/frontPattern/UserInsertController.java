package com.encore.frontPattern;

import java.util.Map;

import com.encore.model.UserService;
import com.encore.model.UserVO;


public class UserInsertController implements CommonCtroller {
	UserService service = new UserService();
	@Override
	public void execute(Map<String, Object> map) {
		if(((String) map.get("method")).equals("get")) {
//			map.put("userlist", service.selectAllUser());
			}else {
				int count = service.insertUser((UserVO)map.get("user"));
				map.put("userResult", count>0 ? "회원가입에 성공하셨습니다." : "회원가입에 실패하셨습니다.");
				map.remove("user");
			}
	}
	

}
