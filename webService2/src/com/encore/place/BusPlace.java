package com.encore.place;

public class BusPlace extends Movement{
	double latitude;
	double longitude;
	String stationName;
	
	public String getLine_name() {
		return line_name;
	}


	public void setLine_name(String line_name) {
		this.line_name = line_name;
	}


	public String getSubtype_name() {
		return subtype_name;
	}

	public void setSubtype_name(String subtype_name) {
		this.subtype_name = subtype_name;
	}
	String line_name;
	String subtype_name;
	
	public BusPlace(double latitude, double longitude, String stationName, String line_name, String subtype_name) {
		super();
		this.latitude = latitude;
		this.longitude = longitude;
		this.stationName = stationName;
		this.line_name = line_name;
		this.subtype_name = subtype_name;
	}


	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("[latitude=").append(latitude).append(", longitude=").append(longitude)
				.append(", stationName=").append(stationName).append(", line_name=").append(line_name)
				.append(", subtype_name=").append(subtype_name).append("]");
		return builder.toString();
	}


	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
}
