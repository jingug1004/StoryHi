package com.hifive.history.model;

import java.io.Serializable;

public class FollowDto implements iDto, Serializable {

	private static final long serialVersionUID = 3981223978077899950L;
	
	private	String	my_id;
	private	String	you_id;
	private	String	fdate;
	private	String	sex;
	private	String	area;
	private	String	birth;
	private	String	state;
	
	public FollowDto() {
	}

	public FollowDto(String my_id, String you_id, String fdate, String sex, String area, String birth, String state) {
		this.my_id = my_id;
		this.you_id = you_id;
		this.fdate = fdate;
		this.sex = sex;
		this.area = area;
		this.birth = birth;
		this.state = state;
	}

	public String getMy_id() {
		return my_id;
	}

	public void setMy_id(String my_id) {
		this.my_id = my_id;
	}

	public String getYou_id() {
		return you_id;
	}

	public void setYou_id(String you_id) {
		this.you_id = you_id;
	}

	public String getFdate() {
		return fdate;
	}

	public void setFdate(String fdate) {
		this.fdate = fdate;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "FollowDto [my_id=" + my_id + ", you_id=" + you_id + ", fdate=" + fdate + ", sex=" + sex + ", area="
				+ area + ", birth=" + birth + ", state=" + state + "]";
	}
	
	

}
