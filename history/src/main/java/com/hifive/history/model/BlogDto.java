package com.hifive.history.model;

import java.io.Serializable;

public class BlogDto implements iDto, Serializable {

	private static final long serialVersionUID = 5888024038692537214L;
	
	private	String	id;
	private	String	title;
	private	String	theme;
	
	public BlogDto() {
	}
	
	public BlogDto(String id, String title, String theme) {
		this.id = id;
		this.title = title;
		this.theme = theme;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	@Override
	public String toString() {
		return "BlogDto [id=" + id + ", title=" + title + ", theme=" + theme + "]";
	}
	
	

}
