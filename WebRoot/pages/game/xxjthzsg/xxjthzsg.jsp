
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../../pub/pubCssJs.jsp"%>
		

   
		<title>xxjt hzsg</title>
	
<style>
#solider th{text-align:center;display:none;}
#solider td{cursor:pointer;height:30px;text-align:center;}
#solider td:hover{background:#eee;font-weight:bold;}
 
</style>

<script>
var gjtab;
var fstab
$(function() {

	
	gjtab = $('#fs')
	.datagrid
	({
		//title:'数据列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/common/common!getXxjtHzsgData.do',
		queryParams:{
			soliderType:'b_bb',
			order:'gj'
		},
		//斑马纹
		striped : true,
		//主键字段
		idField : "xh",
		//宽度自适应
		fitColumns: true, 
		//表单提交方式
		method : "post",
		//是否只能选择一行
		singleSelect : true,
		nowrap : false,
		border:true,
		//高度
		//height:450,
		fit:true,
		//分页信息
		pageSize : 10,
		//每页显示条目下拉菜单
		pageList : [ 5, 10, 20, 50, 100 ],

		

		columns : [ [
				{
					field : 'gjbz',
					title : '攻击兵种',
					width : 50
				},
				{
					field : 'fsbz',
					title : '防守兵种',
					width : 50
				},
				{
					field : 'bzfl',
					title : '兵种分类',
					width : 50
				},
				{
					field : 'bzdj',
					title : '兵种登记',
					width : 50
				},
				{
					field : 'jc',
					title : '攻击加成',
					width : 50,
					sortable : true
				}
				] ]
		,
	
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		}
		
		
	}) 
	
	
	
	
	fstab = $('#gj')
	.datagrid
	({
		//title:'数据列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/common/common!getXxjtHzsgData.do',
		queryParams:{
			soliderType:'b_bb',
			order:'fs'
		},
		//斑马纹
		striped : true,
		//主键字段
		idField : "xh",
		//宽度自适应
		fitColumns: true, 
		//表单提交方式
		method : "post",
		//是否只能选择一行
		singleSelect : true,
		nowrap : false,
		border:true,
		//高度
		//height:450,
		fit:true,
		//分页信息
		pageSize : 10,
		//每页显示条目下拉菜单
		pageList : [ 5, 10, 20, 50, 100 ],

		

		columns : [ [
				{
					field : 'gjbz',
					title : '攻击兵种',
					width : 50
				},
				{
					field : 'fsbz',
					title : '防守兵种',
					width : 50
				},
				{
					field : 'bzfl',
					title : '兵种分类',
					width : 50
				},
				{
					field : 'bzdj',
					title : '兵种登记',
					width : 50
				},
				{
					field : 'jc',
					title : '攻击加成',
					width : 50,
					sortable : true
				}
				] ]
		,
	
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		}
		
		
	}) 
	
	
	function queryData(st){
		var params = {};
		
		params = {soliderType:st,order:'gj'}
		gjtab.datagrid("load", params);
		
		 params = {soliderType:st,order:'fs'}
		fstab.datagrid("load", params);
	}
	
	$("#solider td").click(function(){
		
		var solidertype = $(this).attr("bz");
		queryData(solidertype);
	})
	
})



</script>
	</head>

	<body class="easyui-layout">
	
	

	
	<div data-options="region:'west',split:true,title:'我方防守'" style="width:400px;padding:1px;" >
		<table id ="fs"></table>
	</div>

	<div data-options="region:'center',iconCls:'icon-ok',title:'兵种'" >
	     <table width="100%" id="solider">
	     	<tr>
	     		<th>步兵</th>
	     		<td bz="b_bb">步兵</td>
	     		<td bz="b_chxs">车下虎士</td>
	     		<td bz="b_hwj">虎卫军</td>
	     		<td bz="b_xzy">陷阵营</td>
	     	</tr>
	     	<tr>
	     		<th>弓兵</th>
	     		<td bz="g_gb">弓兵</td>
	     		<td bz="g_lns">连弩士</td>
	     		<td bz="g_wdfj">无当飞军</td>
	     		<td bz="g_xdss">先登死士</td>
	     	</tr>
	     	<tr>
	     		<th>骑兵</th>
	     		<td bz="q_qb">骑兵</td>
	     		<td bz="q_jrqb">精锐骑兵</td>
	     		<td bz="q_hbq">虎豹骑</td>
	     		<td bz="q_xltq">西凉铁骑</td>
	     	</tr>
	     	<tr>
	     		<th>盾兵</th>
	     		<td bz="d_db">盾兵</td>
	     		<td bz="d_ddb">大盾兵</td>
	     		<td bz="d_bmj">白眊军</td>
	     		<td bz="d_tjb">藤甲兵</td>
	     	</tr>
	     	<tr>
	     		<th>矛兵</th>
	     		<td bz="m_mb">矛兵</td>
	     		<td bz="m_jrmb">精锐矛兵</td>
	     		<td bz="m_djs">大戟士</td>
	     		<td bz="m_tcb">突陈兵</td>
	     	</tr>
	     	<tr>
	     		<th>策兵</th>
	     		<td bz="c_ms">谋士</td>
	     		<td bz="c_js">军师</td>
	     		<td bz="c_yss">妖术师</td>
	     		<td bz="c_lj">谋略家</td>
	     	</tr>
	     	<tr>
	     		<th width="20%" bz="s_qs">骑射</th>
	     		<td width="20%" bz="s_gqb">弓骑兵</td>
	     		<td width="20%" bz="s_lsg">猎射官</td>
	     		<td width="20%" bz="s_xnyq">匈奴游骑</td>
	     		<td width="20%" bz="s_bmyc">白马义从</td>
	     	</tr>
	     	<tr>
	     		<th>医兵</th>
	     		<td bz="y_yg">医官</td>
	     		<td bz="y_yy">御医</td>
	     		<td bz="y_xss">仙术士</td>
	     		<td bz="y_fss">方术士</td>
	     	</tr>
	     </table>
	</div>

	<div data-options="region:'east',split:true,title:'我方进攻'" style="width:400px;padding:1px;" >
		<table id ="gj"></table>
	</div>



	
		
	</body>
</html>

