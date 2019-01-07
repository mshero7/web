package com.encore.place;

import java.util.List;

public class RouteSummaries {
	String route_time;
	String walking_time;
	int transfers;
	List<Summaries> summaries;
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();

		builder.append(route_time+",")
		.append(walking_time+",")
		.append(transfers+",");

		for(int i=0; i<summaries.size(); i++) {
			builder.append(i==0 ? "[" : "" +summaries.get(i).getSummariesStartName()+",")
					.append(summaries.get(i).getSummariesEndName()+",")
					.append(i==summaries.size()-1 ? summaries.get(i).getSummariesVehiclesName() : summaries.get(i).getSummariesVehiclesName()+",");
		}
		builder.append("]");
		return builder.toString();
	}
	
	public RouteSummaries(String route_time, String walking_time, int transfers, List<Summaries> summaries) {
		super();
		this.route_time = route_time;
		this.walking_time = walking_time;
		this.transfers = transfers;
		this.summaries = summaries;
	}
	public String getRoute_time() {
		return route_time;
	}
	public void setRoute_time(String route_time) {
		this.route_time = route_time;
	}
	public String getWalking_time() {
		return walking_time;
	}
	public void setWalking_time(String walking_time) {
		this.walking_time = walking_time;
	}
	public int getTransfers() {
		return transfers;
	}
	public void setTransfers(int transfers) {
		this.transfers = transfers;
	}
	public List<Summaries> getSummaries() {
		return summaries;
	}
	public void setSummaries(List<Summaries> summaries) {
		this.summaries = summaries;
	}
	
	
}
