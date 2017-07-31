package com.hifive.history.model;

import java.io.Serializable;

public class LoveDto implements iDto, Serializable {

	private static final long serialVersionUID = -6776754994725753042L;
	private	int		post_seq;
	private	String	id;
	private	String	ldate;
	private	String	sex;
	private	String	area;
	private	String	birth;

	public LoveDto() {
	}

	public LoveDto(int post_seq, String id, String ldate, String sex, String area, String birth) {
		this.post_seq = post_seq;
		this.id = id;
		this.ldate = ldate;
		this.sex = sex;
		this.area = area;
		this.birth = birth;
	}

	public int getPost_seq() {
		return post_seq;
	}

	public void setPost_seq(int post_seq) {
		this.post_seq = post_seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLdate() {
		return ldate;
	}

	public void setLdate(String ldate) {
		this.ldate = ldate;
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

	@Override
	public String toString() {
		return "LoveDto [post_seq=" + post_seq + ", id=" + id + ", ldate=" + ldate + ", sex=" + sex + ", area=" + area
				+ ", birth=" + birth + "]";
	}

	
}
