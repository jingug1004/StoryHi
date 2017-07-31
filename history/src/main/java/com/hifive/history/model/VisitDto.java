package com.hifive.history.model;

import java.io.Serializable;

public class VisitDto implements iDto, Serializable {

	private static final long serialVersionUID = 8391824843497659685L;
	private	int		seq;
	private	String	id;
	private	String	v_id;
	private	String	vdate;
	private	String	sex;
	private	String	area;
	private	String	birth;

	public VisitDto() {
	}

	public VisitDto(int seq, String id, String v_id, String vdate, String sex, String area, String birth) {
		this.seq = seq;
		this.id = id;
		this.v_id = v_id;
		this.vdate = vdate;
		this.sex = sex;
		this.area = area;
		this.birth = birth;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getV_id() {
		return v_id;
	}

	public void setV_id(String v_id) {
		this.v_id = v_id;
	}

	public String getVdate() {
		return vdate;
	}

	public void setVdate(String vdate) {
		this.vdate = vdate;
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
		return "VisitDto [seq=" + seq + ", id=" + id + ", v_id=" + v_id + ", vdate=" + vdate + ", sex=" + sex
				+ ", area=" + area + ", birth=" + birth + "]";
	}
	
	
	
	
}
