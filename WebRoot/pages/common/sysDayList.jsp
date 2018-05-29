<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSysDayTab;
	var yearWin;
	var theSysDayForm;
	var theSysDayYeardataTab;
	//刷新表格
	function reloadSysDayDg() {
		theSysDayTab.datagrid("reload");
	}
	
	function reloadSysDayYearDg(){
		theSysDayYeardataTab.datagrid("reload");
	}
	//重新查询
	function loadSysDayDg() {
		var jsonData = $("#theSysDayForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSysDayTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSysDayForm(){
		theSysDayForm.form("clear");
		loadSysDayDg();
	}

	//弹出保存页面方法
	function addSysDayObj(t) {
		showWin("${ctx}/common/common!sysDayForm.do", 900, 600);
	}
	//弹出编辑页面
	function editSysDayDate(id) {
		showWin("${ctx}/common/common!sysDayForm.do?sysDay.id=" + id,900, 600);
	}
	//弹出编辑页面
	function editSysDayDate2() {
		var data = theSysDayTab.datagrid("getSelected");
		if(data){
			editSysDayDate(data.ID);
		}else{
			alert("请选择数据");
		}
	}
	
	function getSelectedYear(){
		var data = theSysDayYeardataTab.datagrid("getSelected");
		if(data){
			return data.y;
		}
		return null;
	}
	
	
	function deleteSysDayDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/common/common!deleteSysDayByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSysDayTab.datagrid("clearChecked");
							reloadSysDayDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
		
	}
	//获取勾选的行
	function getCheckedIds(){
		var data = theSysDayTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].ID);
			str += (data[i].ID + ",");
		};
		if(str != ""){
			str = str.substring(0,str.length - 1);
			return str;
		}else{
			return "";
		}
		
	}
	//删除操作
	function changeType(id){
		var ids = getCheckedIds();
		if(!ids){
			alert("请勾选数据后再操作");
		}
		//if(confirm("确定切换自然日类型么?")){
			$.ajax("${ctx}/common/common!changetypeOfDay.do",
				{
					type:"POST",
					data:{ids:ids},
					success:function(r){
						var str = $.trim(r);
						if(str == "SUCCESS"){
							//alert('操作成功');
							reloadSysDayDg();
						}else{
							alert(str);
						};
					}
				}
			)
		//}
	}
	
	function deleteYear(y){
		var data = theSysDayYeardataTab.datagrid("getSelected");
		if(!data){
			alert("请选择年份");
		}
		if(confirm("确定删除该年份下所有自然日吗?")){
			$.ajax("${ctx}/common/common!deleteYear.do",
				{
					type:"POST",
					data:{year:data.y},
					success:function(r){
						var str = $.trim(r);
						if(str == "SUCCESS"){
							reloadSysDayYearDg();
							reloadSysDayDg();
						}else{
							alert(str);
						};
					}
				}
			)
			
		}
	}
	
	
	

	$(function() {
		theSysDayForm = $('#theSysDayForm').form({
			ajax:false
		})
		
		
		yearWin=$('#yearWinDiv').dialog({
		    title: '请输入四位年份',
		    width: 220,
		    height: 120,
		    closed: true,
		    modal: true ,
		    buttons:[{
				text:' SUBMIT ',
				handler:function(){
					var y = $("#year").textbox("getValue");
					if($.trim(y) != ""){
						$.ajax({
							type: "POST",
							dataType:"text",
							url: "${ctx}/common/common!initYearDay.do",
							data: {"year":y},
							success:function(data){
								if($.trim(data) == "SUCCESS"){
									showMsg("提示",'操作成功!');
									reloadSysDayYearDg();
									reloadSysDayDg();
									yearWin.dialog('close');
								}else{
									showMsg("提示",data);
								};
								
							}
						}); 
					}else{
						
						showMsg("提示",'请选择操作年份!');
					}
					
				}
			},{
				text:'CANCEL',
				handler:function(){
					yearWin.dialog('close');
			  	}
			}]
		});
		
		
		theSysDayYeardataTab = $('#theSysDayYeardataTable')
		.datagrid(
				{
					title:'年份',
					iconCls : 'icon-ok',
					//数据来源
					url : '${ctx}/common/common!sysDayYearListGetDate.do?r=' + Math.random(),
					//斑马纹
					striped : true,
					//主键字段
					idField : "y",
					//宽度自适应
					//fitColumns: true,
					//表单提交方式
					method : "post",
					//是否只能选择一行
					singleSelect : true,
					nowrap : false,
					fit:true,
					border:false,
					//高度
					//height:450,
					//宽度
					//width:860,
					//是否分页
					pagination : false,
					//分页信息
					pageSize : 10,
					//每页显示条目下拉菜单
					pageList : [ 5, 10, 20, 50, 100 ],
					//排序的列
					sortName : 'ID',
					//排序方式
					sortOrder : "desc",
					//pageNumber:5,s
					rownumbers : true,//行号 
					//分页工具所在位置
					pagePosition : "bottom",
					checkOnSelect:false,
					selectOnCheck:false,
					//冻结的列
					/*frozenColumns : [ [
							{
								field : 'y',
								title : '',
								checkbox : true,
								align : 'center'
							}
							] ],*/
					columns : [ [
							{
								field : 'y',
								title : '年份',
								width : 100,
								sortable : true
							}
							] ]

					,
					toolbar :[{
						text:'初始化年份',
						iconCls:'icon-search',
						handler:function(){inputYear()}
					},{
						text:'删除自然日',
						iconCls:'icon-remove',
						handler:function(){deleteYear()}
					}],
					//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
					onSortColumn : function(sort, order) {
						$('#sort').val(sort);
						$('#order').val(order);
					}
					,
					onClickRow : function(rowIndex, rowData) {
						//不能选中条件中的行
						var y = getSelectedYear();
						setYear(y);
					}
					
				})
		
		theSysDayTab = $('#theSysDaydataTable')
				.datagrid(
						{
							title:'自然日',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/common/common!sysDayListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "ID",
							//宽度自适应
							//fitColumns: true,
							//表单提交方式
							method : "post",
							//是否只能选择一行
							singleSelect : false,
							nowrap : false,
							fit:true,
							border:false,
							//高度
							//height:450,
							//宽度
							//width:860,
							//是否分页
							pagination : true,
							//分页信息
							pageSize : 366,
							//每页显示条目下拉菜单
							pageList : [ 5, 10, 20, 50, 100,366 ],
							//排序的列
							sortName : 'ID',
							//排序方式
							sortOrder : "desc",
							//pageNumber:5,s
							rownumbers : true,//行号 
							//分页工具所在位置
							pagePosition : "bottom",
							checkOnSelect:true,
							selectOnCheck:true,
							//冻结的列
							frozenColumns : [ [
							//选择框		
									/*{
										field : 'ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'ID',
										title : '',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'DAY',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'STATUS',
										title : '类型',
										width : 100,
										sortable : true
									}/*,
									{
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editSysDayDate(\'' + row.ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} */
									] ]

							,
							toolbar :[{
								text:'切换类型',
								iconCls:'icon-add',
								handler:function(){changeType()} 
							},{
								text:'Jun.',
								iconCls:'icon-add',
								handler:function(){setMonth(1)} 
							},{
								text:'Feb.',
								iconCls:'icon-add',
								handler:function(){setMonth(2)} 
							},{
								text:'Mar.',
								iconCls:'icon-add',
								handler:function(){setMonth(3)} 
							},{
								text:'Apr.',
								iconCls:'icon-add',
								handler:function(){setMonth(4)} 
							},{
								text:'May.',
								iconCls:'icon-add',
								handler:function(){setMonth(5)} 
							},{
								text:'Jun.',
								iconCls:'icon-add',
								handler:function(){setMonth(6)} 
							},{
								text:'Jul.',
								iconCls:'icon-add',
								handler:function(){setMonth(7)} 
							},{
								text:'Aug.',
								iconCls:'icon-add',
								handler:function(){setMonth(8)} 
							},{
								text:'Sept.',
								iconCls:'icon-add',
								handler:function(){setMonth(9)} 
							},{
								text:'Oct.',
								iconCls:'icon-add',
								handler:function(){setMonth(10)} 
							},{
								text:'Nov.',
								iconCls:'icon-add',
								handler:function(){setMonth(11)} 
							},{
								text:'Dec.',
								iconCls:'icon-add',
								handler:function(){setMonth(12)} 
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							/*,
							
							onDblClickRow : function(rowIndex, rowData) {
								editSysDayDate(rowData.ID);
							}*/
							
						})

	})

	

var querySysDayState = "open"
function hideSysDayQuery(){
	if("open" == querySysDayState){
		$('body').layout('collapse','north');
		querySysDayState = "close";
	}else{
		$('body').layout('expand','north');
		querySysDayState = "open";
	}
	
}
		

function inputYear(){
	yearWin.dialog('open');
}


function showMsg(tit,msg){
	$.messager.show({
		title:tit,
		msg:msg,
		timeout:2000,
		showType:'slide'
	});	
}	

function setMonth(m){
	
	$("#MONTH").textbox("setValue",m);
	loadSysDayDg();
}

function setYear(y){
	
	$("#YEAR").textbox("setValue",y);
	loadSysDayDg();
}


</script>
	</head>
	<body class="easyui-layout">
	
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSysDayForm" method="post">
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<table border="0"  class="table_none_border">
								<tr>

									<td>
										<span class="Fieldname">年份：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-numberbox" 
											name="YEAR"
											id="YEAR"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<td>
										<span class="Fieldname">月份：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-numberbox" 
											name="MONTH"
											id="MONTH"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<td>
										<span class="Fieldname">日期：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="DAY"
											id="DAY"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<td>
										<span class="Fieldname">状态：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="STATUS"
											id="STATUS"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSysDayDg()">查询</a>  
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSysDayForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
						
				</form>
		</div>
		 
		<div data-options="region:'west',split:true" style="width:300px;">
			<table id="theSysDayYeardataTable">

				</table>
		</div>
		<div data-options="region:'center'">
			
				<table id="theSysDaydataTable">

				</table>
		</div>
		
		
		
		
		
		
		
		
		<div id="yearWinDiv" style="padding:10px;">
			<input type="text" class="easyui-textbox" id="year" />
		</div>
				
		
	</body>

</html>
