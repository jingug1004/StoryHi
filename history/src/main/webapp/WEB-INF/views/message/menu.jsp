<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
String unReadNotes = (String) request.getParameter("unReadNotes"); 
%>

<div class="list-group">
  <a class="list-group-item  <%if(request.getRequestURL().toString().contains("/WEB-INF/views/message/writeForm.jsp")) out.println("active");%>" href="writeForm.hi">쪽지쓰기 </a>
  <a class="list-group-item <%if(request.getRequestURL().toString().contains("/WEB-INF/views/message/message_list1.jsp")) out.println("active");%>" href="receive.hi">
  받은쪽지확인 <span style="font-weight: bold;font-size: 12px;color: red">(<%=unReadNotes %>)</span> </a>
  <a class="list-group-item <%if(request.getRequestURL().toString().contains("/WEB-INF/views/message/message_list2.jsp")) out.println("active");%>" href="send.hi">보낸쪽지확인 </a>
</div>
 
