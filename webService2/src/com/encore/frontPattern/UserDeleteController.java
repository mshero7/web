package com.encore.frontPattern;

import java.util.Map;

import com.encore.model.UserService;

public class UserDeleteController implements CommonCtroller {

	@Override
	public void execute(Map<String, Object> map) {
		UserService service = new UserService();
		 
		int count = service.deleteUser((String) map.get("userid"));
		map.put("userResult", count);

	}

}
