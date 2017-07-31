package com.hifive.history.model;

import java.io.Serializable;

public class CategoryDto implements iDto, Serializable {

	private static final long serialVersionUID = -8914280864953208183L;
	
	private	int		seq;
	private	String	id;
	private	String	name;
	private	String	state;
	
	public CategoryDto() {
	}

	public CategoryDto(int seq, String id, String name, String state) {
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.state = state;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "CategoryDto [seq=" + seq + ", id=" + id + ", name=" + name + ", state=" + state + "]";
	}

	
}
