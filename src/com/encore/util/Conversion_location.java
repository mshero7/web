package com.encore.util;
import kr.hyosang.coordinate.CoordPoint;
import kr.hyosang.coordinate.TransCoord;

public class Conversion_location {
	public static final int COORD_TYPE_TM = 1;
	public static final int COORD_TYPE_KTM = 2;
	public static final int COORD_TYPE_UTM = 3;
	public static final int COORD_TYPE_CONGNAMUL = 4;
	public static final int COORD_TYPE_WGS84 = 5;
	public static final int COORD_TYPE_BESSEL = 6;
	public static final int COORD_TYPE_WTM = 7;
	public static final int COORD_TYPE_WKTM = 8;
	public static final int COORD_TYPE_WCONGNAMUL = 10;
	// 492228.75 1127823.75
	
	public CoordPoint wgs84ToWcong(double x, double y) {
		CoordPoint pt = new CoordPoint(x ,y); //서울시청
		CoordPoint ktmPt = TransCoord.getTransCoord(pt, COORD_TYPE_WGS84, TransCoord.COORD_TYPE_WCONGNAMUL);
		
		return ktmPt;
	}
	
	public CoordPoint wcongToWgs84(double x, double y) {
		CoordPoint pt = new CoordPoint(x ,y); //서울시청
		CoordPoint ktmPt = TransCoord.getTransCoord(pt, COORD_TYPE_WCONGNAMUL, TransCoord.COORD_TYPE_WGS84);
		
		return ktmPt;
	}
	
	
	
	public static void main(String[] args) {
		
		CoordPoint pt = new CoordPoint(126.93031132029586 ,37.61004418899863); //서울시청
		CoordPoint ktmPt = TransCoord.getTransCoord(pt, COORD_TYPE_WGS84, TransCoord.COORD_TYPE_WCONGNAMUL);
//		CoordPoint ktmPt = TransCoord.getTransCoord(pt, TransCoord.COORD_TYPE_WCONGNAMUL, COORD_TYPE_WGS84);
		
		System.out.println(ktmPt.x);
		System.out.println(ktmPt.y);
	}
}
