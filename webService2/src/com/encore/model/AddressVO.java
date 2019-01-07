package com.encore.model;

public class AddressVO {
	private String id;
	private int addNo;
	private String address;
	private String isMain;
	
	public AddressVO() {
		super();
	}

	public AddressVO(String id, int addNo, String address, String isMain) {
		super();
		this.id = id;
		this.addNo = addNo;
		this.address = address;
		this.isMain = isMain;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getAddNo() {
		return addNo;
	}

	public void setAddNo(int addNo) {
		this.addNo = addNo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getIsMain() {
		return isMain;
	}

	public void setIsMain(String isMain) {
		this.isMain = isMain;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("AddressVO [id=").append(id).append(", addNo=").append(addNo).append(", address=")
				.append(address).append(", isMain=").append(isMain).append("]");
		return builder.toString();
	}
	
}