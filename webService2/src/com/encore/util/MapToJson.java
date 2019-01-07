package com.encore.util;

import java.util.List;
import java.util.Map;

import org.apache.catalina.tribes.util.Arrays;

import com.encore.place.BusPlace;
import com.encore.place.Movement;
import com.encore.place.RouteSummaries;
import com.encore.place.SubwayPlace;
import com.encore.place.Summaries;
import com.encore.place.Walking;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class MapToJson {
	
	public static String BusAndSubwayMapToJSon(Map<String, List<Movement>> busAndSubwayMap) {
		JsonObject jsonObject = new JsonObject();
		Gson gson = new Gson();
		
		for(String key : busAndSubwayMap.keySet()) {

			JsonObject busAndSubwayJsonObject = null;
			JsonArray busAndSubwayJsonArray = new JsonArray();
			
			BusPlace busPlace = null;
			SubwayPlace subwayPlace = null;
			Walking walking = null;
			
				for(int k=0; k<busAndSubwayMap.get(key).size(); k++) {
					busAndSubwayJsonObject = new JsonObject();

					// 버스 경로일때.
					if( busAndSubwayMap.get(key).get(k) instanceof BusPlace) {
						busPlace = (BusPlace)busAndSubwayMap.get(key).get(k);
						
						busAndSubwayJsonObject.addProperty("latitude", busPlace.getLatitude());
						busAndSubwayJsonObject.addProperty("longitude", busPlace.getLongitude());
						busAndSubwayJsonObject.addProperty("stationName", busPlace.getStationName());
						busAndSubwayJsonObject.addProperty("line_name", busPlace.getLine_name());
						busAndSubwayJsonObject.addProperty("subtype_name", busPlace.getSubtype_name());
						
						busAndSubwayJsonArray.add(busAndSubwayJsonObject);
					}
					// 지하철 경로일때
					else if (busAndSubwayMap.get(key).get(k) instanceof SubwayPlace) {
						// 상속관계로 인한 형변환.
						subwayPlace = (SubwayPlace)busAndSubwayMap.get(key).get(k);
						
						busAndSubwayJsonObject.addProperty("latitude", subwayPlace.getLatitude());
						busAndSubwayJsonObject.addProperty("longitude", subwayPlace.getLongitude());
						busAndSubwayJsonObject.addProperty("stationName", subwayPlace.getStationName());
						busAndSubwayJsonObject.addProperty("line_name", subwayPlace.getLine_name());
						busAndSubwayJsonObject.addProperty("subtype_name", subwayPlace.getSubtype_name());
						
						busAndSubwayJsonArray.add(busAndSubwayJsonObject);
					}
					// 걷기 경로일때
					else if (busAndSubwayMap.get(key).get(k) instanceof Walking) {
						walking = (Walking)busAndSubwayMap.get(key).get(k);
						
						busAndSubwayJsonObject.addProperty("information", walking.getInformation());
						busAndSubwayJsonObject.addProperty("polyline", Arrays.toString(walking.getPolyline()));
						busAndSubwayJsonObject.addProperty("s_lat",  walking.getS_lat());
						busAndSubwayJsonObject.addProperty("s_lng", walking.getS_lng());
						busAndSubwayJsonObject.addProperty("e_lat", walking.getE_lat());
						busAndSubwayJsonObject.addProperty("e_lng", walking.getE_lng());

						busAndSubwayJsonArray.add(busAndSubwayJsonObject);
					}
				}
				jsonObject.add(key, busAndSubwayJsonArray);
			}

		return gson.toJson(jsonObject);
	}
	
	// Map 타입을 Json으로 변환.
	public static String SubwayMapToJson(Map<String,List<Movement>> subwayMap) {
		JsonObject jsonObject = new JsonObject();
		Gson gson = new Gson();

		for(String key : subwayMap.keySet()) {

			JsonObject SubwayJsonObject = null;
			JsonArray SubwayJsonArray = new JsonArray();
			
			SubwayPlace subwayPlace = null;
			Walking walking = null;
			
				for(int k=0; k<subwayMap.get(key).size(); k++) {
					SubwayJsonObject = new JsonObject();

					// 지하철 경로일때
					if (subwayMap.get(key).get(k) instanceof SubwayPlace) {
						// 상속관계로 인한 형변환.
						subwayPlace = (SubwayPlace)subwayMap.get(key).get(k);
						
						SubwayJsonObject.addProperty("latitude", subwayPlace.getLatitude());
						SubwayJsonObject.addProperty("longitude", subwayPlace.getLongitude());
						SubwayJsonObject.addProperty("stationName", subwayPlace.getStationName());
						SubwayJsonObject.addProperty("line_name", subwayPlace.getLine_name());
						SubwayJsonObject.addProperty("subtype_name", subwayPlace.getSubtype_name());
						
						SubwayJsonArray.add(SubwayJsonObject);
					}
					// 걷기 경로일때
					else if (subwayMap.get(key).get(k) instanceof Walking) {
						walking = (Walking)subwayMap.get(key).get(k);
						
						SubwayJsonObject.addProperty("information", walking.getInformation());
						SubwayJsonObject.addProperty("polyline", Arrays.toString(walking.getPolyline()));
						SubwayJsonObject.addProperty("s_lat",  walking.getS_lat());
						SubwayJsonObject.addProperty("s_lng", walking.getS_lng());
						SubwayJsonObject.addProperty("e_lat", walking.getE_lat());
						SubwayJsonObject.addProperty("e_lng", walking.getE_lng());

						SubwayJsonArray.add(SubwayJsonObject);

					}
				}
				jsonObject.add(key, SubwayJsonArray);
			}
		
		return gson.toJson(jsonObject);
	}
	
	
	public static String BusMapToJson(Map<String,List<Movement>> busMap) {
		JsonObject jsonObject = new JsonObject();
		Gson gson = new Gson();
		
		for(String key : busMap.keySet()) {

			JsonObject busJsonObject = null;
			JsonArray busJsonArray = new JsonArray();
			
			BusPlace busPlace = null;
			Walking walking = null;
			
				for(int k=0; k<busMap.get(key).size(); k++) {
					busJsonObject = new JsonObject();

					// 버스 경로일때.
					if( busMap.get(key).get(k) instanceof BusPlace) {
						busPlace = (BusPlace)busMap.get(key).get(k);
						
						busJsonObject.addProperty("latitude", busPlace.getLatitude());
						busJsonObject.addProperty("longitude", busPlace.getLongitude());
						busJsonObject.addProperty("stationName", busPlace.getStationName());
						busJsonObject.addProperty("line_name", busPlace.getLine_name());
						busJsonObject.addProperty("subtype_name", busPlace.getSubtype_name());
						
						busJsonArray.add(busJsonObject);
					}
					// 걷기 경로일때
					else if (busMap.get(key).get(k) instanceof Walking) {
						walking = (Walking)busMap.get(key).get(k);
						
						busJsonObject.addProperty("information", walking.getInformation());
						busJsonObject.addProperty("polyline", Arrays.toString(walking.getPolyline()));
						busJsonObject.addProperty("s_lat",  walking.getS_lat());
						busJsonObject.addProperty("s_lng", walking.getS_lng());
						busJsonObject.addProperty("e_lat", walking.getE_lat());
						busJsonObject.addProperty("e_lng", walking.getE_lng());

						busJsonArray.add(busJsonObject);
					}
				}
				jsonObject.add(key, busJsonArray);
			}
		
		return gson.toJson(jsonObject);
	}
	
	public static String RoutesSummariesMapToJson(Map<String,List<RouteSummaries>> routeSummariesMap) {
		JsonObject jsonObject = new JsonObject();
		Gson gson = new Gson();
		
		int step = 1;
	
		for(String key : routeSummariesMap.keySet()) {
			
			JsonObject routeSummariesJsonObject = null;
			JsonObject summariesJsonObject = null;
			
			JsonArray summariesJsonArray = new JsonArray();
			JsonArray routeSummariesJsonArray = new JsonArray();
			
			RouteSummaries routeSummaries = null;
			
			for(int j=0; j<routeSummariesMap.get(key).size(); j++) {
				routeSummariesJsonObject = new JsonObject();
				
				String route_time = routeSummariesMap.get(key).get(j).getRoute_time();
				String walking_time = routeSummariesMap.get(key).get(j).getWalking_time();
				int transfers = routeSummariesMap.get(key).get(j).getTransfers();
				List<Summaries> summaries = routeSummariesMap.get(key).get(j).getSummaries();
				
				routeSummaries = new RouteSummaries(route_time, walking_time, transfers, summaries);
				
				routeSummariesJsonObject.addProperty("route_time", route_time);
				routeSummariesJsonObject.addProperty("walking_time", walking_time);
				routeSummariesJsonObject.addProperty("transfers", transfers);
				
				for(int k=0 ; k<summaries.size(); k++) {
					summariesJsonObject = new JsonObject();
					Summaries items = summaries.get(k);
					
					String startName = items.getSummariesStartName();
					String endName = items.getSummariesEndName();
					String VehiclesName = items.getSummariesVehiclesName();
					
					summariesJsonObject.addProperty("startName", startName);
					summariesJsonObject.addProperty("endName", endName);
					summariesJsonObject.addProperty("VehiclesName", VehiclesName);
					
					summariesJsonArray.add(summariesJsonObject);
				}
				routeSummariesJsonObject.add("summaries", summariesJsonArray);
				routeSummariesJsonArray.add(routeSummariesJsonObject);
			}
			
			jsonObject.add(String.valueOf(step), routeSummariesJsonArray);
			step++;
		}
		
		return gson.toJson(jsonObject);
	}
	
}