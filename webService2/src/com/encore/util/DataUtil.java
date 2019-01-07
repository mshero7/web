package com.encore.util;

import kr.hyosang.coordinate.CoordPoint;

public class DataUtil {
	public void StringToDouble (String [] arr1, Double [] arr2) {
		Conversion_location cl = new Conversion_location();
		
		for(int i=0 ; i<arr1.length/2 ; i++) {
			CoordPoint c  = cl.wcongToWgs84(Double.parseDouble(arr1[i]), Double.parseDouble(arr1[i+1]));
			arr2[2*i] = c.x;
			arr2[2*i+1] = c.y;
		}
	}
}
