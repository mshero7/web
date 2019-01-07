package com.encore.frontPattern;

import java.util.Map;

import com.encore.model.UserService;

public class LoginController implements CommonCtroller {

	@Override
	public void execute(Map<String, Object> map) {
		// TODO Auto-generated method stub
		if (map.get("method").equals("get")) {

		} else {
			UserService service = new UserService();
			map.put("user", service.selectUser((String) map.get("id"), (String) map.get("password")));
			if (map.get("user") != null) {
				map.put("loginResult", "yes");
			} else {
				System.out.println("user가 존재하지 않습니다...");
				map.put("loginResult", "no");
			}
		}
	}

}
