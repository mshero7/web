package com.encore.place;

import java.util.Arrays;

public class Walking extends Movement {
	String information;
	Double[] polyline;
	double s_lat;
	double s_lng;
	double e_lat;
	double e_lng;
	
	public String getInformation() {
		return information;
	}
	public void setInformation(String information) {
		this.information = information;
	}
	public Double[] getPolyline() {
		return polyline;
	}
	public void setPolyline(Double[] polyline) {
		this.polyline = polyline;
	}
	public double getS_lat() {
		return s_lat;
	}
	public void setS_lat(double s_lat) {
		this.s_lat = s_lat;
	}
	public double getS_lng() {
		return s_lng;
	}
	public void setS_lng(double s_lng) {
		this.s_lng = s_lng;
	}
	public double getE_lat() {
		return e_lat;
	}
	public void setE_lat(double e_lat) {
		this.e_lat = e_lat;
	}
	public double getE_lng() {
		return e_lng;
	}
	public void setE_lng(double e_lng) {
		this.e_lng = e_lng;
	}
	public Walking(String information, Double[] polyline, double s_lat, double s_lng, double e_lat, double e_lng) {
		super();
		this.information = information;
		this.polyline = polyline;
		this.s_lat = s_lat;
		this.s_lng = s_lng;
		this.e_lat = e_lat;
		this.e_lng = e_lng;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("[information=").append(information).append(", polyline=")
				.append(Arrays.toString(polyline)).append(", s_lat=").append(s_lat).append(", s_lng=").append(s_lng)
				.append(", e_lat=").append(e_lat).append(", e_lng=").append(e_lng).append("]");
		return builder.toString();
	}

	
}
