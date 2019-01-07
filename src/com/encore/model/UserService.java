package com.encore.model;

import java.util.List;

public class UserService {
	public UserVO selectUser(String id, String psw) {
		return UserDAO.selectUser(id, psw);
	}

	public List<UserVO> selectAllUser() {
		return UserDAO.selectAllUser();
	}

	public boolean checkUserId(String id) {
		return UserDAO.CheckUserId(id);
	}

	public int insertUser(UserVO user) {
		return UserDAO.insertUser(user);
	}

	public int updateUser(UserVO user) {
		return UserDAO.updateUser(user);
	}

	public int deleteUser(String id) {
		UserDAO.deleteAddByUser(id);
		return UserDAO.deleteUser(id);
	}

	public boolean checkUserPw(String id, String password) {
		// TODO Auto-generated method stub
		return UserDAO.checkUserPw(id, password);
	}

	public List<AddressVO> selectAllAdd(String id) {
		// TODO Auto-generated method stub
		return UserDAO.selectAllAdd(id);
	}

	public int insertAdd(List<AddressVO> addlist) {
		// TODO Auto-generated method stub
		int count = 0;
		int realCnt = UserDAO.countRows(addlist.get(0).getId());
		for (AddressVO add : addlist) {
			add.setAddNo(add.getAddNo()+realCnt);
			count += UserDAO.insertUser(add);
		}
		return count;
	}

	public int updateAddMain(String id, int addNo) {
		// TODO Auto-generated method stub
		UserDAO.updateAddReset(id);
		return UserDAO.updateAddMain(id,addNo);
	}

}
