package com.encore.place;

public class Summaries {
	String summariesStartName;
	String summariesEndName;
	String summariesVehiclesName;

	public Summaries(String summariesStartName, String summariesEndName,
			String summariesVehiclesName) {
		super();
		this.summariesStartName = summariesStartName;
		this.summariesEndName = summariesEndName;
		this.summariesVehiclesName = summariesVehiclesName;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("[summariesStartName=").append(summariesStartName).append(", summariesEndName=")
				.append(summariesEndName).append(", summariesVehiclesName=").append(summariesVehiclesName).append("]");
		return builder.toString();
	}

	public String getSummariesStartName() {
		return summariesStartName;
	}

	public void setSummariesStartName(String summariesStartName) {
		this.summariesStartName = summariesStartName;
	}

	public String getSummariesEndName() {
		return summariesEndName;
	}

	public void setSummariesEndName(String summariesEndName) {
		this.summariesEndName = summariesEndName;
	}

	public String getSummariesVehiclesName() {
		return summariesVehiclesName;
	}

	public void setSummariesVehiclesName(String summariesVehiclesName) {
		this.summariesVehiclesName = summariesVehiclesName;
	}

}
