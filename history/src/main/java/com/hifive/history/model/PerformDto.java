package com.hifive.history.model;

public class PerformDto implements iDto {
	String ID; 
	String CLASS_NM; 
	String METHOD_NM; 
	long   P_TIME; 
	String REG_DT; 
	String REG_ID;
	String ARGU_NM_VALUE;
	
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getCLASS_NM() {
		return CLASS_NM;
	}
	public void setCLASS_NM(String cLASS_NM) {
		CLASS_NM = cLASS_NM;
	}
	public String getMETHOD_NM() {
		return METHOD_NM;
	}
	public void setMETHOD_NM(String mETHOD_NM) {
		METHOD_NM = mETHOD_NM;
	}
	public long getP_TIME() {
		return P_TIME;
	}
	public void setP_TIME(long p_TIME) {
		P_TIME = p_TIME;
	}
	public String getREG_DT() {
		return REG_DT;
	}
	public void setREG_DT(String rEG_DT) {
		REG_DT = rEG_DT;
	}
	public String getREG_ID() {
		return REG_ID;
	}
	public void setREG_ID(String rEG_ID) {
		REG_ID = rEG_ID;
	}
	public String getARGU_NM_VALUE() {
		return ARGU_NM_VALUE;
	}
	public void setARGU_NM_VALUE(String aRGU_NM_VALUE) {
		ARGU_NM_VALUE = aRGU_NM_VALUE;
	}
	
	
}
