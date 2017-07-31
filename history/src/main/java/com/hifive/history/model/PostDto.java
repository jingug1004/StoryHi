package com.hifive.history.model;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class PostDto implements iDto, Serializable {

	private static final long serialVersionUID = -6251569249631447753L;
	private	int		seq;
	private	int		ct_seq;
	private	String	id;
	private	String	field;
	private	String	title;
	private	String	content;
	private	String	wdate;
	private	String	hashtag;
	private	String	state;
	private String	co_state;
	private List<Map<String,Object>> fileList;
	private int visit_id;

	public PostDto() {
	}

	public PostDto(int seq, int ct_seq, String id, String field, String title, String content, String wdate,
			String hashtag, String state, String co_state) {
		this.seq = seq;
		this.ct_seq = ct_seq;
		this.id = id;
		this.field = field;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.hashtag = hashtag;
		this.state = state;
		this.co_state = co_state;
	}

	public int getVisit_id() {
		return visit_id;
	}

	public void setVisit_id(int visit_id) {
		this.visit_id = visit_id;
	}

	public List<Map<String, Object>> getFileList() {
		return fileList;
	}

	public void setFileList(List<Map<String, Object>> fileList) {
		this.fileList = fileList;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getCt_seq() {
		return ct_seq;
	}

	public void setCt_seq(int ct_seq) {
		this.ct_seq = ct_seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public String getHashtag() {
		return hashtag;
	}

	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCo_state() {
		return co_state;
	}

	public void setCo_state(String co_state) {
		this.co_state = co_state;
	}

	@Override
	public String toString() {
		return "PostDto [seq=" + seq + ", ct_seq=" + ct_seq + ", id=" + id + ", field=" + field + ", title=" + title
				+ ", content=" + content + ", wdate=" + wdate + ", hashtag=" + hashtag + ", state=" + state
				+ ", visit_id=" + visit_id
				+ ", co_state=" + co_state + "]";
	}
	
	
	
	
}
