package com.hifive.history.model;

import java.io.Serializable;

public class SearchDto implements iDto, Serializable {

	private static final long serialVersionUID = -1373177193822569565L;
	private	int		seq;
	private	String	search_word;
	private	String	s_id;
	private	String	sdate;
	private	String	sex;
	private	String	area;
	private	String	birth;
	
	public SearchDto() {
	}

	public SearchDto(int seq, String search_word, String s_id, String sdate, String sex, String area, String birth) {
		this.seq = seq;
		this.search_word = search_word;
		this.s_id = s_id;
		this.sdate = sdate;
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

	public String getSearch_word() {
		return search_word;
	}

	public void setSearch_word(String search_word) {
		this.search_word = search_word;
	}

	public String getS_id() {
		return s_id;
	}

	public void setS_id(String s_id) {
		this.s_id = s_id;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
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
		return "SearchDto [seq=" + seq + ", search_word=" + search_word + ", s_id=" + s_id + ", sdate=" + sdate
				+ ", sex=" + sex + ", area=" + area + ", birth=" + birth + "]";
	}

	
	
}
