package com.hifive.history.model;

import java.io.Serializable;

public class CodeDDto implements iDto, Serializable{
	
		/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
		private int cd_id;
		private int cd_d_id;
		private String cd_d_nm;
		public int getCd_id() {
			return cd_id;
		}
		public void setCd_id(int cd_id) {
			this.cd_id = cd_id;
		}
		public int getCd_d_id() {
			return cd_d_id;
		}
		public void setCd_d_id(int cd_d_id) {
			this.cd_d_id = cd_d_id;
		}
		public String getCd_d_nm() {
			return cd_d_nm;
		}
		public void setCd_d_nm(String cd_d_nm) {
			this.cd_d_nm = cd_d_nm;
		}
		@Override
		public String toString() {
			return "CodeD [cd_id=" + cd_id + ", cd_d_id=" + cd_d_id + ", cd_d_nm=" + cd_d_nm + "]";
		}
		
		
}
