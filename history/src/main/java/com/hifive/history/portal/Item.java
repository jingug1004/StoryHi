package com.hifive.history.portal;

import javax.xml.bind.annotation.XmlElement;

public class Item {
	private String title        ;
	private String link         ;
	private String bloggername  ;
	private String bloggerlink  ;
	private String postdate     ;
	private String description;
	
	
	public String getDescription() {
		return description;
	}
	@XmlElement
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTitle() {
		return title;
	}
	@XmlElement
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLink() {
		return link;
	}
	@XmlElement
	public void setLink(String link) {
		this.link = link;
	}
	public String getBloggername() {
		return bloggername;
	}
	
	@XmlElement
	public void setBloggername(String bloggername) {
		this.bloggername = bloggername;
	}
	public String getBloggerlink() {
		return bloggerlink;
	}
	
	@XmlElement
	public void setBloggerlink(String bloggerlink) {
		this.bloggerlink = bloggerlink;
	}
	public String getPostdate() {
		return postdate;
	}
	
	@XmlElement
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
}
