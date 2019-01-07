package com.encore.jsonparser;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.encore.place.BusPlace;
import com.encore.place.Movement;
import com.encore.place.RouteSummaries;
import com.encore.place.SubwayPlace;
import com.encore.place.Summaries;
import com.encore.place.Walking;
import com.encore.util.Conversion_location;
import com.encore.util.DataUtil;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.hyosang.coordinate.CoordPoint;

public class PathJsonObject {
	
	public static void busJsonByMap(String json,Map<String,List<Movement>> busMap,Map<String,List<RouteSummaries>> routeSummariesMap) {
		DataUtil dataUtil = new DataUtil();
		Conversion_location convert_location = new Conversion_location();
		
		List<Movement> movementList = null;
		List<RouteSummaries> routeSummariesList = null;
		
		JsonParser parser = new JsonParser();
		JsonArray routesJsonArray = new JsonArray();
		JsonArray stepJsonArray = new JsonArray();
		JsonArray nodesJsonArray = new JsonArray();
		JsonElement je = parser.parse(json);
		
		// json의 in_local의 routes 얻어오기. routes는 갈수있는 모든 방법들을 담고있다.
		routesJsonArray = je.getAsJsonObject().getAsJsonObject("in_local").getAsJsonArray("routes");

		for (int i = 0; i < routesJsonArray.size(); i++) {
			JsonArray summariesJsonArray = routesJsonArray.get(i).getAsJsonObject().getAsJsonArray("summaries");

			String route_type = routesJsonArray.get(i).getAsJsonObject().get("type").getAsString();
			String ranking = routesJsonArray.get(i).getAsJsonObject().get("ranking").getAsString();
			int transfers = routesJsonArray.get(i).getAsJsonObject().get("transfers").getAsInt();

			// 해당 경로의 총 걸리는 시간
			String route_time = routesJsonArray.get(i).getAsJsonObject().get("time").getAsJsonObject().get("text")
					.getAsString();
			// 도보에 대한 시간
			String walking_time = routesJsonArray.get(i).getAsJsonObject().get("walkingTime").getAsJsonObject()
					.get("text").getAsString();

			Summaries summaries = null;
			List<Summaries> summariesList = new ArrayList<>();
			RouteSummaries routeSummaries = null;

			// summaries 정제 및 얻어오는 부분
			routeSummariesList = new ArrayList<>();
			for (int a = 0; a < summariesJsonArray.size(); a++) {

				JsonObject summariesStartJsonObject = summariesJsonArray.get(a).getAsJsonObject().get("startLocation")
						.getAsJsonObject();
				JsonObject summariesEndJsonObject = summariesJsonArray.get(a).getAsJsonObject().get("endLocation")
						.getAsJsonObject();
				JsonElement summariesVehicleJsonElement = summariesJsonArray.get(a).getAsJsonObject().get("vehicles");

				String summariesStartName = summariesStartJsonObject.get("name").getAsString();
				String summariesEndName = summariesEndJsonObject.get("name").getAsString();
				String summariesVehiclesName = summariesVehicleJsonElement.getAsJsonArray().get(0).getAsJsonObject()
						.get("name").getAsString();

				summaries = new Summaries(summariesStartName, summariesEndName, summariesVehiclesName);
				summariesList.add(summaries);
			}

			// BUS or SUBWAY or BUSANDSUBWAY?
			// 버스 관련 경로
			if (route_type.equals("BUS")) {
				
				movementList = new ArrayList<>(100);

				// 검색해서 나온 경로들에 대한 가는 방법이 담겨있는 step 변수.(if문으로 현재는 subway)
				stepJsonArray = routesJsonArray.get(i).getAsJsonObject().get("steps").getAsJsonArray();

				/*
				 * 버스이면서 노드를 갖지 못하는것은 역에서 역으로 이동하는 경로가 아니다. 노드를 가지고 start_location과
				 * end_location을 합쳐야 진짜 경로가 됨.
				 */

				// 중간 환승역을 넣어주기 위한 list_index
				
				for (int j = 0; j < stepJsonArray.size(); j++) {
					BusPlace busPlace;
					JsonElement stepTypeJsonElement = stepJsonArray.get(j).getAsJsonObject().get("type");
					JsonElement stepNodesJsonElement = stepJsonArray.get(j).getAsJsonObject().get("nodes");
					
					// 그래서 타입이 SUBWAY 면서 nodes 값이 널이 아닌 steps를 얻는중
					if (stepTypeJsonElement != null && stepTypeJsonElement.getAsString().equals("BUS")
							&& stepNodesJsonElement != null) {
						nodesJsonArray = stepJsonArray.get(j).getAsJsonObject().get("nodes").getAsJsonArray();

						JsonArray vehicleJsonArray = stepJsonArray.get(j).getAsJsonObject().get("vehicles")
								.getAsJsonArray();

						String line_name = vehicleJsonArray.get(0).getAsJsonObject().get("name").getAsString();
						String subtype_name = vehicleJsonArray.get(0).getAsJsonObject().get("subTypeName")
								.getAsString();

						// 시작점과 끝나는 점이 있어야 전체 경로가 출력됨
						JsonElement stepStartLocationJsonElement = stepJsonArray.get(j).getAsJsonObject()
								.get("startLocation");
						JsonElement stepEndLocationJsonElement = stepJsonArray.get(j).getAsJsonObject()
								.get("endLocation");

						double startLocationX = stepStartLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
						double startLocationY = stepStartLocationJsonElement.getAsJsonObject().get("y").getAsDouble();
						double endLocationX = stepEndLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
						double endLocationY = stepEndLocationJsonElement.getAsJsonObject().get("y").getAsDouble();

						String stepStartLocationName = stepJsonArray.get(j).getAsJsonObject().get("startLocation")
								.getAsJsonObject().get("name").getAsString();
						String stepEndLocationName = stepJsonArray.get(j).getAsJsonObject().get("endLocation")
								.getAsJsonObject().get("name").getAsString();

						CoordPoint start_wgs_Location_Point = convert_location.wcongToWgs84(startLocationX,
								startLocationY);
						CoordPoint end_wgs_Location_Point = convert_location.wcongToWgs84(endLocationX, endLocationY);

						String action = stepJsonArray.get(j).getAsJsonObject().get("action").getAsString();

						BusPlace startBusPlace = new BusPlace(start_wgs_Location_Point.x, start_wgs_Location_Point.y,
								stepStartLocationName, line_name, subtype_name);
						BusPlace endBusPlace = new BusPlace(end_wgs_Location_Point.x, end_wgs_Location_Point.y,
								stepEndLocationName, line_name, subtype_name);

						if (!action.equals("TRANSFER")) {
							movementList.add(startBusPlace);
						}
						for (int k = 0; k < nodesJsonArray.size(); k++) {
							String stationName = nodesJsonArray.get(k).getAsJsonObject().get("name").getAsString();

							double lat = nodesJsonArray.get(k).getAsJsonObject().get("x").getAsDouble();
							double lng = nodesJsonArray.get(k).getAsJsonObject().get("y").getAsDouble();
							CoordPoint pt = convert_location.wcongToWgs84(lat, lng);

							busPlace = new BusPlace(pt.x, pt.y, stationName, line_name, subtype_name);
							movementList.add(busPlace);
						}
						movementList.add(endBusPlace);
					}
					else if(stepTypeJsonElement != null && stepTypeJsonElement.getAsString().equals("WALKING")) {
						double startLocationX = 0.0;
						double startLocationY = 0.0;
						double endLocationX = 0.0;
						double endLocationY = 0.0;
						
						// 시작점과 끝나는 점이 있어야 전체 경로가 출력됨
						if (stepJsonArray.get(j).getAsJsonObject().get("startLocation") != null) {
							JsonElement stepStartLocationJsonElement = stepJsonArray.get(j).getAsJsonObject().get("startLocation");
							startLocationX = stepStartLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
							startLocationY = stepStartLocationJsonElement.getAsJsonObject().get("y").getAsDouble();
						}
						if (stepJsonArray.get(j).getAsJsonObject().get("endLocation") != null) {
							JsonElement stepEndLocationJsonElement = stepJsonArray.get(j).getAsJsonObject().get("endLocation");
							endLocationX = stepEndLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
							endLocationY = stepEndLocationJsonElement.getAsJsonObject().get("y").getAsDouble();
						}
						
						JsonElement polylineJsonElement = stepJsonArray.get(j).getAsJsonObject().get("polyline");
												
						// Walking 시작경로 끝경로 POLYLINE 얻어오는곳
						String stepinformation = stepJsonArray.get(j).getAsJsonObject().get("information").getAsString(); 
						String tempPolyline = polylineJsonElement.getAsString();
						
						CoordPoint start_wgs_Location_Point = convert_location.wcongToWgs84(startLocationX,
								startLocationY);
						CoordPoint end_wgs_Location_Point = convert_location.wcongToWgs84(endLocationX, endLocationY);
						
						// Polyline 을 다시 WGS84 좌표계로
						String [] arr = tempPolyline.split("\\|");
						Double [] polyline = new Double [arr.length];
						
						dataUtil.StringToDouble(arr, polyline);
						
						Walking Walking = new Walking(stepinformation,polyline, start_wgs_Location_Point.x, start_wgs_Location_Point.y,end_wgs_Location_Point.x,end_wgs_Location_Point.y);
						
						movementList.add(Walking);

					}

				}
				// 중간중간마다 걷는 경로.
				busMap.put(ranking, movementList);

			}				

			routeSummaries = new RouteSummaries(route_time, walking_time, transfers, summariesList);
			routeSummariesList.add(routeSummaries);
			routeSummariesMap.put(ranking, routeSummariesList);
		}
	}

	public static void subwayJsonByMap(String json,Map<String,List<Movement>> subwayMap,Map<String,List<RouteSummaries>> routeSummariesMap) {
		DataUtil dataUtil = new DataUtil();

		Conversion_location convert_location = new Conversion_location();
		
		List<Movement> movementList = null;
		List<RouteSummaries> routeSummariesList = null;

		JsonParser parser = new JsonParser();
		JsonArray routesJsonArray = new JsonArray();
		JsonArray stepJsonArray = new JsonArray();
		JsonArray nodesJsonArray = new JsonArray();
		JsonElement je = parser.parse(json);

		// json의 in_local의 routes 얻어오기. routes는 갈수있는 모든 방법들을 담고있다.
		routesJsonArray = je.getAsJsonObject().getAsJsonObject("in_local").getAsJsonArray("routes");

		for (int i = 0; i < routesJsonArray.size(); i++) {
			JsonArray summariesJsonArray = routesJsonArray.get(i).getAsJsonObject().getAsJsonArray("summaries");

			String route_type = routesJsonArray.get(i).getAsJsonObject().get("type").getAsString();
			String ranking = routesJsonArray.get(i).getAsJsonObject().get("ranking").getAsString();
			int transfers = routesJsonArray.get(i).getAsJsonObject().get("transfers").getAsInt();

			// 해당 경로의 총 걸리는 시간
			String route_time = routesJsonArray.get(i).getAsJsonObject().get("time").getAsJsonObject().get("text")
					.getAsString();
			// 도보에 대한 시간
			String walking_time = routesJsonArray.get(i).getAsJsonObject().get("walkingTime").getAsJsonObject()
					.get("text").getAsString();

			Summaries summaries = null;
			List<Summaries> summariesList = new ArrayList<>();
			RouteSummaries routeSummaries = null;

			// summaries 정제 및 얻어오는 부분
			routeSummariesList = new ArrayList<>();
			for (int a = 0; a < summariesJsonArray.size(); a++) {

				JsonObject summariesStartJsonObject = summariesJsonArray.get(a).getAsJsonObject().get("startLocation")
						.getAsJsonObject();
				JsonObject summariesEndJsonObject = summariesJsonArray.get(a).getAsJsonObject().get("endLocation")
						.getAsJsonObject();
				JsonElement summariesVehicleJsonElement = summariesJsonArray.get(a).getAsJsonObject().get("vehicles");

				String summariesStartName = summariesStartJsonObject.get("name").getAsString();
				String summariesEndName = summariesEndJsonObject.get("name").getAsString();
				String summariesVehiclesName = summariesVehicleJsonElement.getAsJsonArray().get(0).getAsJsonObject()
						.get("name").getAsString();

				summaries = new Summaries(summariesStartName, summariesEndName, summariesVehiclesName);
				summariesList.add(summaries);
			}

			// BUS or SUBWAY or BUSANDSUBWAY?

			// 지하철을 이동수단으로 활용할때
			// 여기서 WALKING, BUS 정도로 나누어 구분가능함.
			if (route_type.equals("SUBWAY")) {
				movementList = new ArrayList<>(100);

				// 검색해서 나온 경로들에 대한 가는 방법이 담겨있는 step 변수.(if문으로 현재는 subway)
				stepJsonArray = routesJsonArray.get(i).getAsJsonObject().get("steps").getAsJsonArray();

				/*
				 * 지하철이면서 노드를 갖지 못하는것은 역에서 역으로 이동하는 경로가 아니다. 노드를 가지고 start_location과
				 * end_location을 합쳐야 진짜 경로가 됨.
				 */

				// 중간 환승역을 넣어주기 위한 list_index

				for (int j = 0; j < stepJsonArray.size(); j++) {
					SubwayPlace subwayPlace;
					JsonElement stepTypeJsonElement = stepJsonArray.get(j).getAsJsonObject().get("type");
					JsonElement stepNodesJsonElement = stepJsonArray.get(j).getAsJsonObject().get("nodes");

					// 그래서 타입이 SUBWAY 면서 nodes 값이 널이 아닌 steps를 얻는중
					if (stepTypeJsonElement != null && stepTypeJsonElement.getAsString().equals("SUBWAY")
							&& stepNodesJsonElement != null) {

						nodesJsonArray = stepJsonArray.get(j).getAsJsonObject().get("nodes").getAsJsonArray();
						JsonArray vehicleJsonArray = stepJsonArray.get(j).getAsJsonObject().get("vehicles")
								.getAsJsonArray();

						String line_name = vehicleJsonArray.get(0).getAsJsonObject().get("name").getAsString();
						String subtype_name = vehicleJsonArray.get(0).getAsJsonObject().get("subTypeName")
								.getAsString();

						// 시작점과 끝나는 점이 있어야 전체 경로가 출력됨.(어거지로넣기)
						JsonElement stepStartLocationJsonElement = stepJsonArray.get(j).getAsJsonObject()
								.get("startLocation");
						JsonElement stepEndLocationJsonElement = stepJsonArray.get(j).getAsJsonObject()
								.get("endLocation");

						double startLocationX = stepStartLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
						double startLocationY = stepStartLocationJsonElement.getAsJsonObject().get("y").getAsDouble();
						double endLocationX = stepEndLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
						double endLocationY = stepEndLocationJsonElement.getAsJsonObject().get("y").getAsDouble();

						String stepStartLocationName = stepJsonArray.get(j).getAsJsonObject().get("startLocation")
								.getAsJsonObject().get("name").getAsString();
						String stepEndLocationName = stepJsonArray.get(j).getAsJsonObject().get("endLocation")
								.getAsJsonObject().get("name").getAsString();

						CoordPoint start_wgs_Location_Point = convert_location.wcongToWgs84(startLocationX,
								startLocationY);
						CoordPoint end_wgs_Location_Point = convert_location.wcongToWgs84(endLocationX, endLocationY);

						String action = stepJsonArray.get(j).getAsJsonObject().get("action").getAsString();

						SubwayPlace startSubwayPlace = new SubwayPlace(start_wgs_Location_Point.x,
								start_wgs_Location_Point.y, stepStartLocationName, line_name, subtype_name);
						SubwayPlace endSubwayPlace = new SubwayPlace(end_wgs_Location_Point.x, end_wgs_Location_Point.y,
								stepEndLocationName, line_name, subtype_name);

						if (!action.equals("TRANSFER")) {
							movementList.add(startSubwayPlace);
						}
						
						for (int k = 0; k < nodesJsonArray.size(); k++) {
							String stationName = nodesJsonArray.get(k).getAsJsonObject().get("name").getAsString();

							double lat = nodesJsonArray.get(k).getAsJsonObject().get("x").getAsDouble();
							double lng = nodesJsonArray.get(k).getAsJsonObject().get("y").getAsDouble();
							CoordPoint pt = convert_location.wcongToWgs84(lat, lng);

							subwayPlace = new SubwayPlace(pt.x, pt.y, stationName, line_name, subtype_name);
							movementList.add(subwayPlace);

						}

						movementList.add(endSubwayPlace);

					}
					else if(stepTypeJsonElement != null && stepTypeJsonElement.getAsString().equals("WALKING")) {
						double startLocationX = 0.0;
						double startLocationY = 0.0;
						double endLocationX = 0.0;
						double endLocationY = 0.0;
						
						// 시작점과 끝나는 점이 있어야 전체 경로가 출력됨
						if (stepJsonArray.get(j).getAsJsonObject().get("startLocation") != null) {
							JsonElement stepStartLocationJsonElement = stepJsonArray.get(j).getAsJsonObject().get("startLocation");
							startLocationX = stepStartLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
							startLocationY = stepStartLocationJsonElement.getAsJsonObject().get("y").getAsDouble();
						}
						if (stepJsonArray.get(j).getAsJsonObject().get("endLocation") != null) {
							JsonElement stepEndLocationJsonElement = stepJsonArray.get(j).getAsJsonObject().get("endLocation");
							endLocationX = stepEndLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
							endLocationY = stepEndLocationJsonElement.getAsJsonObject().get("y").getAsDouble();
						}
						
						JsonElement polylineJsonElement = stepJsonArray.get(j).getAsJsonObject().get("polyline");
						
						
						
						// Walking 시작경로 끝경로 POLYLINE 얻어오는곳
						String stepinformation = stepJsonArray.get(j).getAsJsonObject().get("information").getAsString(); 
						String tempPolyline = polylineJsonElement.getAsString();
						
						CoordPoint start_wgs_Location_Point = convert_location.wcongToWgs84(startLocationX,
								startLocationY);
						CoordPoint end_wgs_Location_Point = convert_location.wcongToWgs84(endLocationX, endLocationY);
						
						// Polyline 을 다시 WGS84 좌표계로
						String [] arr = tempPolyline.split("\\|");
						Double [] polyline = new Double [arr.length];
						
						dataUtil.StringToDouble(arr, polyline);
						
						Walking Walking = new Walking(stepinformation,polyline, start_wgs_Location_Point.x, start_wgs_Location_Point.y,end_wgs_Location_Point.x,end_wgs_Location_Point.y);
						
						movementList.add(movementList.size(), Walking);
					}

				}
				subwayMap.put(ranking, movementList);
			}
			routeSummaries = new RouteSummaries(route_time, walking_time, transfers, summariesList);
			routeSummariesList.add(routeSummaries);
			routeSummariesMap.put(ranking, routeSummariesList);
		}
	}

	public static void subwayAndBusJsonByMap(String json,Map<String,List<Movement>> busAndSubwayMap, Map<String,List<RouteSummaries>> routeSummariesMap) {
		DataUtil dataUtil = new DataUtil();
		Conversion_location convert_location = new Conversion_location();

		ArrayList<Movement> movementList = null;
		List<RouteSummaries> routeSummariesList = null;

		JsonParser parser = new JsonParser();
		JsonArray routesJsonArray = new JsonArray();
		JsonArray stepJsonArray = new JsonArray();
		JsonArray nodesJsonArray = new JsonArray();
		JsonElement je = parser.parse(json);

		// json의 in_local의 routes 얻어오기. routes는 갈수있는 모든 방법들을 담고있다.
		routesJsonArray = je.getAsJsonObject().getAsJsonObject("in_local").getAsJsonArray("routes");

		for (int i = 0; i < routesJsonArray.size(); i++) {
			// BUS or SUBWAY or BUSANDSUBWAY?
			JsonArray summariesJsonArray = routesJsonArray.get(i).getAsJsonObject().getAsJsonArray("summaries");

			String route_type = routesJsonArray.get(i).getAsJsonObject().get("type").getAsString();
			String ranking = routesJsonArray.get(i).getAsJsonObject().get("ranking").getAsString();
			int transfers = routesJsonArray.get(i).getAsJsonObject().get("transfers").getAsInt();

			// 해당 경로의 총 걸리는 시간
			String route_time = routesJsonArray.get(i).getAsJsonObject().get("time").getAsJsonObject().get("text")
					.getAsString();
			// 도보에 대한 시간
			String walking_time = routesJsonArray.get(i).getAsJsonObject().get("walkingTime").getAsJsonObject()
					.get("text").getAsString();

			Summaries summaries = null;
			List<Summaries> summariesList = new ArrayList<>();
			RouteSummaries routeSummaries = null;

			// summaries 정제 및 얻어오는 부분
			routeSummariesList = new ArrayList<>();
			for (int a = 0; a < summariesJsonArray.size(); a++) {

				JsonObject summariesStartJsonObject = summariesJsonArray.get(a).getAsJsonObject().get("startLocation")
						.getAsJsonObject();
				JsonObject summariesEndJsonObject = summariesJsonArray.get(a).getAsJsonObject().get("endLocation")
						.getAsJsonObject();
				JsonElement summariesVehicleJsonElement = summariesJsonArray.get(a).getAsJsonObject().get("vehicles");

				String summariesStartName = summariesStartJsonObject.get("name").getAsString();
				String summariesEndName = summariesEndJsonObject.get("name").getAsString();
				String summariesVehiclesName = summariesVehicleJsonElement.getAsJsonArray().get(0).getAsJsonObject()
						.get("name").getAsString();

				summaries = new Summaries(summariesStartName, summariesEndName, summariesVehiclesName);
				summariesList.add(summaries);
			}
			// 버스와 지하철을 같이 타는 경로
			if (route_type.equals("BUS_AND_SUBWAY")) {

				movementList = new ArrayList<>(100);

				// 검색해서 나온 경로들에 대한 가는 방법이 담겨있는 step 변수.(if문으로 현재는 subway)
				stepJsonArray = routesJsonArray.get(i).getAsJsonObject().get("steps").getAsJsonArray();

				/*
				 * 지하철이면서 노드를 갖지 못하는것은 역에서 역으로 이동하는 경로가 아니다. 노드를 가지고 start_location과
				 * end_location을 합쳐야 진짜 경로가 됨.
				 */

				for (int j = 0; j < stepJsonArray.size(); j++) {
					SubwayPlace subwayPlace;
					BusPlace busPlace;
					JsonElement stepTypeJsonElement = stepJsonArray.get(j).getAsJsonObject().get("type");
					JsonElement stepNodesJsonElement = stepJsonArray.get(j).getAsJsonObject().get("nodes");
					
					if (stepTypeJsonElement != null && stepTypeJsonElement.getAsString().equals("SUBWAY")
							&& stepNodesJsonElement != null) {

						nodesJsonArray = stepJsonArray.get(j).getAsJsonObject().get("nodes").getAsJsonArray();
						JsonArray vehicleJsonArray = stepJsonArray.get(j).getAsJsonObject().get("vehicles")
								.getAsJsonArray();

						String line_name = vehicleJsonArray.get(0).getAsJsonObject().get("name").getAsString();
						String subtype_name = vehicleJsonArray.get(0).getAsJsonObject().get("subTypeName")
								.getAsString();

						// 시작점과 끝나는 점이 있어야 전체 경로가 출력됨.(어거지로넣기)
						JsonElement stepStartLocationJsonElement = stepJsonArray.get(j).getAsJsonObject()
								.get("startLocation");
						JsonElement stepEndLocationJsonElement = stepJsonArray.get(j).getAsJsonObject()
								.get("endLocation");

						double startLocationX = stepStartLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
						double startLocationY = stepStartLocationJsonElement.getAsJsonObject().get("y").getAsDouble();
						double endLocationX = stepEndLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
						double endLocationY = stepEndLocationJsonElement.getAsJsonObject().get("y").getAsDouble();

						String stepStartLocationName = stepJsonArray.get(j).getAsJsonObject().get("startLocation")
								.getAsJsonObject().get("name").getAsString();
						String stepEndLocationName = stepJsonArray.get(j).getAsJsonObject().get("endLocation")
								.getAsJsonObject().get("name").getAsString();

						CoordPoint start_wgs_Location_Point = convert_location.wcongToWgs84(startLocationX,
								startLocationY);
						CoordPoint end_wgs_Location_Point = convert_location.wcongToWgs84(endLocationX, endLocationY);

						String action = stepJsonArray.get(j).getAsJsonObject().get("action").getAsString();

						SubwayPlace startSubwayPlace = new SubwayPlace(start_wgs_Location_Point.x,
								start_wgs_Location_Point.y, stepStartLocationName, line_name, subtype_name);
						SubwayPlace endSubwayPlace = new SubwayPlace(end_wgs_Location_Point.x, end_wgs_Location_Point.y,
								stepEndLocationName, line_name, subtype_name);

						// action이 TRANSFER이면 시작지점이 짤리는 상황이 있음.
						if (!action.equals("TRANSFER")) {
							movementList.add(startSubwayPlace);
						}
						
						for (int k = 0; k < nodesJsonArray.size(); k++) {
							String stationName = nodesJsonArray.get(k).getAsJsonObject().get("name").getAsString();

							double lat = nodesJsonArray.get(k).getAsJsonObject().get("x").getAsDouble();
							double lng = nodesJsonArray.get(k).getAsJsonObject().get("y").getAsDouble();
							CoordPoint pt = convert_location.wcongToWgs84(lat, lng);

							subwayPlace = new SubwayPlace(pt.x, pt.y, stationName, line_name, subtype_name);
							movementList.add(subwayPlace);
						}
						

						movementList.add(endSubwayPlace);

					} 
					else if (stepTypeJsonElement != null && stepTypeJsonElement.getAsString().equals("BUS")
							&& stepNodesJsonElement != null) {

						nodesJsonArray = stepJsonArray.get(j).getAsJsonObject().get("nodes").getAsJsonArray();

						JsonArray vehicleJsonArray = stepJsonArray.get(j).getAsJsonObject().get("vehicles")
								.getAsJsonArray();

						String line_name = vehicleJsonArray.get(0).getAsJsonObject().get("name").getAsString();
						String subtype_name = vehicleJsonArray.get(0).getAsJsonObject().get("subTypeName")
								.getAsString();

						// 시작점과 끝나는 점이 있어야 전체 경로가 출력됨
						JsonElement stepStartLocationJsonElement = stepJsonArray.get(j).getAsJsonObject()
								.get("startLocation");
						JsonElement stepEndLocationJsonElement = stepJsonArray.get(j).getAsJsonObject()
								.get("endLocation");

						double startLocationX = stepStartLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
						double startLocationY = stepStartLocationJsonElement.getAsJsonObject().get("y").getAsDouble();
						double endLocationX = stepEndLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
						double endLocationY = stepEndLocationJsonElement.getAsJsonObject().get("y").getAsDouble();

						String stepStartLocationName = stepJsonArray.get(j).getAsJsonObject().get("startLocation")
								.getAsJsonObject().get("name").getAsString();
						String stepEndLocationName = stepJsonArray.get(j).getAsJsonObject().get("endLocation")
								.getAsJsonObject().get("name").getAsString();

						CoordPoint start_wgs_Location_Point = convert_location.wcongToWgs84(startLocationX,
								startLocationY);
						CoordPoint end_wgs_Location_Point = convert_location.wcongToWgs84(endLocationX, endLocationY);

						String action = stepJsonArray.get(j).getAsJsonObject().get("action").getAsString();

						BusPlace startBusPlace = new BusPlace(start_wgs_Location_Point.x, start_wgs_Location_Point.y,
								stepStartLocationName, line_name, subtype_name);
						BusPlace endBusPlace = new BusPlace(end_wgs_Location_Point.x, end_wgs_Location_Point.y,
								stepEndLocationName, line_name, subtype_name);

						if (!action.equals("TRANSFER")) {
							movementList.add(startBusPlace);
						}
						
						for (int k = 0; k < nodesJsonArray.size(); k++) {
							String stationName = nodesJsonArray.get(k).getAsJsonObject().get("name").getAsString();

							double lat = nodesJsonArray.get(k).getAsJsonObject().get("x").getAsDouble();
							double lng = nodesJsonArray.get(k).getAsJsonObject().get("y").getAsDouble();
							CoordPoint pt = convert_location.wcongToWgs84(lat, lng);

							busPlace = new BusPlace(pt.x, pt.y, stationName, line_name, subtype_name);
							movementList.add(busPlace);

						}
						movementList.add(endBusPlace);
					}
					else if(stepTypeJsonElement != null && stepTypeJsonElement.getAsString().equals("WALKING")) {
							double startLocationX = 0.0;
							double startLocationY = 0.0;
							double endLocationX = 0.0;
							double endLocationY = 0.0;
							
							// 시작점과 끝나는 점이 있어야 전체 경로가 출력됨
							if (stepJsonArray.get(j).getAsJsonObject().get("startLocation") != null) {
								JsonElement stepStartLocationJsonElement = stepJsonArray.get(j).getAsJsonObject().get("startLocation");
								startLocationX = stepStartLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
								startLocationY = stepStartLocationJsonElement.getAsJsonObject().get("y").getAsDouble();
							}
							if (stepJsonArray.get(j).getAsJsonObject().get("endLocation") != null) {
								JsonElement stepEndLocationJsonElement = stepJsonArray.get(j).getAsJsonObject().get("endLocation");
								endLocationX = stepEndLocationJsonElement.getAsJsonObject().get("x").getAsDouble();
								endLocationY = stepEndLocationJsonElement.getAsJsonObject().get("y").getAsDouble();
							}
							
							JsonElement polylineJsonElement = stepJsonArray.get(j).getAsJsonObject().get("polyline");
							
							
							
							// Walking 시작경로 끝경로 POLYLINE 얻어오는곳
							String stepinformation = stepJsonArray.get(j).getAsJsonObject().get("information").getAsString(); 
							String tempPolyline = polylineJsonElement.getAsString();
							
							CoordPoint start_wgs_Location_Point = convert_location.wcongToWgs84(startLocationX,
									startLocationY);
							CoordPoint end_wgs_Location_Point = convert_location.wcongToWgs84(endLocationX, endLocationY);
							
							// Polyline 을 다시 WGS84 좌표계로
							String [] arr = tempPolyline.split("\\|");
							Double [] polyline = new Double [arr.length];
							
							dataUtil.StringToDouble(arr, polyline);
							
							Walking Walking = new Walking(stepinformation,polyline, start_wgs_Location_Point.x, start_wgs_Location_Point.y,end_wgs_Location_Point.x,end_wgs_Location_Point.y);
							
							movementList.add(Walking);
						}
					}
					busAndSubwayMap.put(ranking, movementList);
				}

			routeSummaries = new RouteSummaries(route_time, walking_time, transfers, summariesList);
			routeSummariesList.add(routeSummaries);
			routeSummariesMap.put(ranking, routeSummariesList);
			}
		}
	}
