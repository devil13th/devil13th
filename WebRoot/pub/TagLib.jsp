<%@ page import="cn.thd.bean.StaticVar" %>
<%@ page import="cn.thd.bean.ProcessStaticVar" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String ctx = request.getContextPath();
	pageContext.setAttribute("ctx",ctx);
	String serverIp = request.getServerName();
	pageContext.setAttribute("serverIp",serverIp);
	int port = request.getServerPort();
	pageContext.setAttribute("port",port);
	String serverAddr = "http://" + serverIp + ":" + port +  ctx;
	pageContext.setAttribute("serverAddr",serverAddr);
	
%>
