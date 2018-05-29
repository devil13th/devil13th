<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>

</head>

<frameset cols="330,*" frameborder="no" border="0" framespacing="0">
	<frame src="${ctx}/checklist/checklist!tree.do?tree.treeId=${tree.treeId}" name="leftFrame"  noresize="noresize" id="leftFrame" title="header" />
	<frame src="" name="rightFrame" id="rightFrame" title="bodyer" />
</frameset>
<noframes><body>
</body>
</noframes></html>
