package com.hifive.history.model;

import java.io.Serializable;

public class TokenDto implements iDto, Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6715689003781571415L;
	
	private	int		seq;
	private String  id;
	private String  token;
	private String  gdate;
	
	public TokenDto() {
				
	}

	public TokenDto(int seq, String id, String token, String gdate) {
		super();
		this.seq = seq;
		this.id = id;
		this.token = token;
		this.gdate = gdate;
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

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getGdate() {
		return gdate;
	}

	public void setGdate(String gdate) {
		this.gdate = gdate;
	}

	@Override
	public String toString() {
		return "TokenDto [seq=" + seq + ", id=" + id + ", token=" + token + ", gdate=" + gdate + "]";
	}

}
