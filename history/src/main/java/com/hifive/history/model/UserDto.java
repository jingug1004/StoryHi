package com.hifive.history.model;

import java.io.Serializable;

public class UserDto implements iDto, Serializable{

	private static final long serialVersionUID = -498540406150018309L;
	private	String	id;
	private	String	password;
	private	String	birth;
	private	String	sex;
	private	String	name;
	private	String	email;
	private	String	area;
	private	String	grade;
	private	String	pf_image;
	private	String	pf_content;

	public UserDto() {
	}

	public UserDto(String id, String password, String birth, String sex, String name, String email, String area,
			String grade, String pf_image, String pf_content) {
		this.id = id;
		this.password = password;
		this.birth = birth;
		this.sex = sex;
		this.name = name;
		this.email = email;
		this.area = area;
		this.grade = grade;
		this.pf_image = pf_image;
		this.pf_content = pf_content;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getPf_image() {
		return pf_image;
	}

	public void setPf_image(String pf_image) {
		this.pf_image = pf_image;
	}

	public String getPf_content() {
		return pf_content;
	}

	public void setPf_content(String pf_content) {
		this.pf_content = pf_content;
	}

	@Override
	public String toString() {
		return "UserDto [id=" + id + ", password=" + password + ", birth=" + birth + ", sex=" + sex + ", name=" + name
				+ ", email=" + email + ", area=" + area + ", grade=" + grade + ", pf_image=" + pf_image
				+ ", pf_content=" + pf_content + "]";
	}
	
	
}
