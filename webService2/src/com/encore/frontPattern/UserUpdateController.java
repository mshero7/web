package com.encore.frontPattern;

import java.util.Map;

import com.encore.model.UserService;
import com.encore.model.UserVO;

public class UserUpdateController implements CommonCtroller {
	UserService service = new UserService();
	@Override
	public void execute(Map<String, Object> map) {
		if (((String) map.get("method")).equals("get")) {
			int count = service.updateUser((UserVO) map.get("user"));
			map.put("userResult", count > 0 ? "회원정보 수정에 성공하였습니다." : "회원정보 수정에 실패했습니다.");
		} else {
			
		}

	}

}
