package com.hifive.history.model;

import java.io.Serializable;

/**
 * Created by Admin on 2017-03-24.
 */
public class CommentDto implements iDto, Serializable {

	private static final long serialVersionUID = 490136938753537796L;
	
	private	int		seq;
	private	int		post_seq;
	private	String	id;
	private	String	name;
	private	String	content;
	private	int		parent;
	private	String	state;
	private	String	wdate;
	
	public CommentDto() {
	}

	public CommentDto(int seq, int post_seq, String id, String name, String content, int parent, String state,
			String wdate) {
		this.seq = seq;
		this.post_seq = post_seq;
		this.id = id;
		this.name = name;
		this.content = content;
		this.parent = parent;
		this.state = state;
		this.wdate = wdate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getParent() {
		return parent;
	}

	public void setParent(int parent) {
		this.parent = parent;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	@Override
	public String toString() {
		return "CommentDto [seq=" + seq + ", post_seq=" + post_seq + ", id=" + id + ", name=" + name + ", content="
				+ content + ", parent=" + parent + ", state=" + state + ", wdate=" + wdate + "]";
	}

	
	
}
