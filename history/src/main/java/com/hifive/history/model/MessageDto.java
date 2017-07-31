package com.hifive.history.model;

import java.io.Serializable;

public class MessageDto implements iDto, Serializable {

	private static final long serialVersionUID = 4841893468544096972L;
	
	private	int		seq;
	private	String	send_id;
	private	String	take_id;
	private String  contents;
	private	String	wdate;
	private	String	rdate;
	private	String	state;
	private String  name;
	private String	send_view;
	private String  take_view;
	
	public MessageDto() {
	}

	public MessageDto(int seq, String send_id, String take_id, String contents, String wdate, String rdate,
			String state, String name, String send_view, String take_view) {
		super();
		this.seq = seq;
		this.send_id = send_id;
		this.take_id = take_id;
		this.contents = contents;
		this.wdate = wdate;
		this.rdate = rdate;
		this.state = state;
		this.name = name;
		this.send_view = send_view;
		this.take_view = take_view;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getSend_id() {
		return send_id;
	}

	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}

	public String getTake_id() {
		return take_id;
	}

	public void setTake_id(String take_id) {
		this.take_id = take_id;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public String getRdate() {
		return rdate;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSend_view() {
		return send_view;
	}

	public void setSend_view(String send_view) {
		this.send_view = send_view;
	}

	public String getTake_view() {
		return take_view;
	}

	public void setTake_view(String take_view) {
		this.take_view = take_view;
	}

	@Override
	public String toString() {
		return "MessageDto [seq=" + seq + ", send_id=" + send_id + ", take_id=" + take_id + ", contents=" + contents
				+ ", wdate=" + wdate + ", rdate=" + rdate + ", state=" + state + ", name=" + name + ", send_view="
				+ send_view + ", take_view=" + take_view + "]";
	}
	
}
