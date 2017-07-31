<%@page import="com.hifive.history.model.BlogDto"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page contentType="application/vnd.ms-excel; charset=euc-kr" import="java.util.ArrayList.*"%>


<%@ page language="java" import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%
	UserDto user = new UserDto();
	
	if(session.getAttribute("user")!=null){
		user = (UserDto)session.getAttribute("user");
	}
	
	List<Map<String,Object>> excelList = new ArrayList<Map<String,Object>>();
	excelList = (List<Map<String,Object>>)request.getAttribute("excelList");
  	
	// 엑셀로 다운로드
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String today = formatter.format(new java.util.Date());
	String file_name = user.getId() + "_visit_" +today;
	String ExcelName  = new String(file_name.getBytes(),"euc-kr")+".xls";
	response.setContentType("application/vnd.ms-excel");
	
	response.setHeader("Content-Disposition", "attachment; filename="+ExcelName);
	response.setHeader("Pragma", "no-cache");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
</head>
<body>
	<%
		if(excelList!=null){
	%>
	<table>
	   	<tr>
			<th>날짜</th>
			<th>방문수</th>
	  	</tr>
	<%
		for(int i =0; i < excelList.size(); ++i){
	%>
		<tr>
			<td><%=excelList.get(i).get("CUR_DATE") %></td>
			<td><%=excelList.get(i).get("CNT") %>명</td>
		</tr>
	<%
		}
	%>
		
	</table>
	<%
		}
	%>
</body>
</html>