package com.hifive.history.model;

import java.io.Serializable;

public class BoxDto implements iDto, Serializable {

	private static final long serialVersionUID = 5314011381477661187L;
	
	private	int		seq;
	private	String	post_seq;
	private	String	location;
	private	String	ori_name;
	private	String	save_name;

	public BoxDto() {
	}

	public BoxDto(int seq, String post_seq, String location, String ori_name, String save_name) {
		this.seq = seq;
		this.post_seq = post_seq;
		this.location = location;
		this.ori_name = ori_name;
		this.save_name = save_name;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getPost_seq() {
		return post_seq;
	}

	public void setPost_seq(String post_seq) {
		this.post_seq = post_seq;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getOri_name() {
		return ori_name;
	}

	public void setOri_name(String ori_name) {
		this.ori_name = ori_name;
	}

	public String getSave_name() {
		return save_name;
	}

	public void setSave_name(String save_name) {
		this.save_name = save_name;
	}

	@Override
	public String toString() {
		return "BoxDto [seq=" + seq + ", post_seq=" + post_seq + ", location=" + location + ", ori_name=" + ori_name
				+ ", save_name=" + save_name + "]";
	}
	
	
	
}
