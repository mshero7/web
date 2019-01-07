package com.encore.model;

import java.sql.Date;

public class UserVO {
	private String id;
	private String password;
	private String name;
	private String email;
	private String gender;
	private Date birthday;
	private String partner;

	public UserVO() {
		super();
	}

	public UserVO(String id, String password, String name, String email, String gender, Date birthday, String partner) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.birthday = birthday;
		this.partner = partner;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getPartner() {
		return partner;
	}

	public void setPartner(String partner) {
		this.partner = partner;
	}

	@Override
	public String toString() {
		return "UserVO [id=" + id + ", password=" + password + ", name=" + name + ", email=" + email + ", gender="
				+ gender + ", birthday=" + birthday + ", partner=" + partner + "]";
	}

}
