<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
				<!-- jquery ztree css -->
<link rel="stylesheet" href="${ctx}/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<!-- jquery ztree -->
<script src="${ctx}/js/ztree/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript">
	var tab;
	var win;
	var theForm;
	var projectTab;
	var theSeSysRoleTab;
	var theSeProRoleTab;
	var roleTree;
	var setting = {
			data: {
				simpleData: {
					enable: true
				}
			},
			check: {
				enable: true
			},
			view:{
				selectedMulti :true,
				expandSpeed:''
			}
		};

	var zNodes =[
		<c:forEach items="${menuList}" var="menu" varStatus="index">
			{ id:"${menu['id']}", pId:"${menu['pId']}", name:"${menu['name']}", isParent:"${menu['isParent']}"}
			<c:if test="${fn:length(menuList) != index.index+1}">,</c:if>  
		</c:forEach>
	];
	
	
	//刷新表格
	function reloadDg() {
		tab.datagrid("reload");
	}
	//重新查询
	function loadDg() {
		var jsonData = $("#theForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		tab.datagrid("load", params);
	}
	//重置表单后查询
	function resetForm(){
		theForm.form("clear");
		loadDg();
	}

	//弹出保存页面方法
	function addObj(t) {
		showWin("${ctx}/se/se!seUserForm.do", 900, 700);
	}
	//弹出编辑页面
	function editData(id) {
		showWin("${ctx}/se/se!seUserForm.do?seUser.userId=" + id,900, 700);
	}
	//弹出编辑页面
	function editData2() {
		var data = tab.datagrid("getSelected");
		if(data){
			editData(data.USER_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteDatas(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/se/se!deleteSeUserByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							tab.datagrid("clearChecked");
							loadDg();
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
		var data = tab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].USER_ID);
			str += (data[i].USER_ID + ",");
		};
		if(str != ""){
			str = str.substring(0,str.length - 1);
			return str;
		}else{
			return "";
		}
		
	}
	//删除操作
	function deleteData(id){
		if(confirm("确定删除此条记录么?")){
			$.ajax("${ctx}/se/se!deleteSeUserById.do?seUser.userId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	function setRole(){
		var data = tab.datagrid("getChecked");
		console.log(data);
		if(data.length < 0){
			alert("请选择人员");
		}
		var id = data[0].USER_ID
		var url = "${ctx}/se/se!seUserRoleSelector.do?cb=parent.saveUserRole&seUser.userId=" + id;
		opw({title:'角色设置',url:url,w:'900',h:'500'});
	}
	
	function saveUserRole(obj){
		console.log(obj);
		
		//alert(obj);
		var row = tab.datagrid("getSelected");
		var ids = "";
		if (row){
			for(var i = 0 , j = obj.length ; i < j ; i++){
				//alert(obj[i].ROLE_CODE);
				ids += (obj[i].ROLE_CODE+",");
			}
			
			
			//alert(ids);
			$.ajax({
				type: "POST",
				url: "${ctx}/se/se!saveUserRole.do",
				data: {
					'seMapUserRole.userId':row.USER_ID,
					'seMapUserRole.roleCode':ids,
					'projectId':'${projectId}'
				},
				success: function(msg){
					//alert(msg);
					if($.trim(msg)=="SUCCESS"){
						message("操作成功");
					}else{
						message("操作失败");
						return false;
					}
				},
				failure : function(msg){
					message("操作失败");
					return false;
				}
			});
		}else{
			alert("请选择人员");
		}
		
		
		
		clw();
	}
	
	function message(text){
		$.messager.show({
			title:'消息',
			msg:text,
			showType:'show'
		});
	}
	
	$(function() {
		theForm = $('#theForm').form({
			ajax:false
		})
		
		userTree =$.fn.zTree.init($("#userTree"), setting, zNodes);
		userTree.expandAll(true);
		
		roleTree =$.fn.zTree.init($("#roleTree"), setting, zNodes);
		roleTree.expandAll(true);
		
		$('input.ck').each(function(){
		    var self = $(this),
		      label = self.next(),
		      label_text = label.text();

		    label.remove();
		    self.iCheck({
		      checkboxClass: 'icheckbox_line-red',
		      radioClass: 'iradio_line-red',
		      insert: '<div class="icheck_line-icon"></div>' + label_text
		    });
 		});
		
		
		$('input.rck').each(function(){
		    var self = $(this),
		      label = self.next(),
		      label_text = label.text();

		    label.remove();
		    self.iCheck({
		      checkboxClass: 'icheckbox_line-red',
		      radioClass: 'iradio_line-red',
		      insert: '<div class="icheck_line-icon"></div>' + label_text
		    });
 		});
		
		
		
		
		//弹出窗口初始化
		win = $('#win').window({
		    width:900,
		    height:600,
		    modal:true,
		    border:false
		});
		$('#win').window('close');
		
		
		projectTab = $('#projectTab').datagrid({
			title:'项目列表',
			//title:'数据列表',
			iconCls : 'icon-ok',
			//数据来源
			url : '${ctx}/se/se!seProjectInfoListGetDate.do?r=' + Math.random(),
			//斑马纹
			striped : true,
			//主键字段
			idField : "PROJECT_ID",
			//宽度自适应
			//fitColumns: true,
			//表单提交方式
			method : "post",
			//是否只能选择一行
			singleSelect : true,
			nowrap : false,
			fit:true,
			border:true,
			//高度
			//height:450,
			//宽度
			//width:860,
			//是否分页
			//pagination : true,
			//分页信息
			//pageSize : 10,
			//每页显示条目下拉菜单
			//pageList : [ 5, 10, 20, 50, 100 ],
			//排序的列
			sortName : 'PROJECT_ID',
			//排序方式
			sortOrder : "desc",
			//pageNumber:5,s
			rownumbers : true,//行号 
			//分页工具所在位置
			//pagePosition : "bottom",
			checkOnSelect:false,
			selectOnCheck:false,
			//冻结的列
			frozenColumns : [ [
			//选择框		
					/*{
						field : 'PROJECT_ID',
						title : 'fid',
						checkbox : true,
						align : 'center'
					},*/
					{
						field : 'PROJECT_ID',
						title : '项目ID',
						checkbox : true,
						align : 'center'
					}
					] ],
			columns : [ [
					{
						field : 'PRO_NO',
						title : '项目标号',
						width : 100,
						sortable : true
					},
					{
						field : 'PRO_NAME',
						title : '项目名称',
						width : 100,
						sortable : true
					}/*,
					{
						field : 'PRO_DESCRIPTION',
						title : '项目描述',
						width : 100,
						sortable : true
					},
					{
						field : 'PRO_TARGET',
						title : '项目目标',
						width : 100,
						sortable : true
					},
					{
						field : 'PRO_BACKGROUND',
						title : '项目背景',
						width : 100,
						sortable : true
					},
					{
						field : 'FINAL_CONSIGN',
						title : '最终交付物',
						width : 100,
						sortable : true
					},
					{
						field : 'PRO_LEADER',
						title : '项目经理',
						width : 100,
						sortable : true
					},
					{
						field : 'PRO_MEMBER',
						title : '项目成员',
						width : 100,
						sortable : true
					},
					{
						field : 'OPER',
						title : '操作',
						width : 80,
						align : 'center',
						formatter : function(value, row, index) {
							var editStr =  '<a  href="#" title="编辑" onclick="editData(\'' + row.PROJECT_ID + '\')" >编辑</a>'
							var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.PROJECT_ID + '\')" >删除</a>';
							return editStr +"&nbsp;"+ deleteStr;
						}
					}*/ 
					] ]

			,
			/*
			toolbar :[{
				text:'收起搜索',
				iconCls:'icon-search',
				handler:function(){hideQuery()}
			},{
				text:'',
				iconCls:'icon-add',
				handler:function(){addObj()} 
			},{
				text:'',
				iconCls:'icon-edit',
				handler:function(){editData2()}
			},
			'-',
			{
				text:'编辑项目成员',
				iconCls:'icon-edit',
				handler:function(){editProjectUser()}
			},
			'-',
			{
				text:'',
				iconCls:'icon-remove',
				handler:function(){deleteDatas()}
			}],*/
			//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
			onSelect:function(){
				initUserProRole();
			}
			
		})
		
		
		
		
		theSeSysRoleTab = $('#theSeSysRoleTab')
		.datagrid(
				{
					//title:'数据列表',
					iconCls : 'icon-ok',
					//数据来源
					url : '${ctx}/se/se!seRoleListGetDate.do?r=' + Math.random(),
					queryParams:{PROJECT_ID:'1',ROLE_CLASSIFY:'<%=StaticVar.ROLECLASSIFY_SYSTEM %>'},
					//斑马纹
					striped : true,
					//主键字段
					idField : "ROLE_CODE",
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
					sortName : 'ROLE_CODE',
					//排序方式
					sortOrder : "desc",
					//pageNumber:5,s
					rownumbers : true,//行号 
					//分页工具所在位置
					pagePosition : "bottom",
					checkOnSelect:false,
					selectOnCheck:false,
					//冻结的列
					frozenColumns : [ [
					//选择框		
							/*{
								field : 'ROLE_CODE',
								title : 'fid',
								checkbox : true,
								align : 'center'
							},*/
							{
								field : 'ROLE_CODE',
								title : '角色Code',
								checkbox : true,
								align : 'center'
							}
							] ],
					columns : [ [
							{
								field : 'ROLE_NAME',
								title : '角色名称',
								width : 100,
								sortable : true
							},
							{
								field : 'ROLE_LEVEL',
								title : '角色等级',
								width : 100,
								sortable : true
							}
							] ]

					,
					onClickRow:function(){
						initSysRoleAuth();
						initSysRoleMenu();
					}
					
					
				})


		theSeProRoleTab = $('#theSeProRoleTab')
		.datagrid(
				{
					//title:'数据列表',
					iconCls : 'icon-ok',
					//数据来源
					url : '${ctx}/se/se!seRoleListGetDate.do?r=' + Math.random(),
					queryParams:{PROJECT_ID:'1',ROLE_CLASSIFY:'<%=StaticVar.ROLECLASSIFY_PROJECT %>'},
					//斑马纹
					striped : true,
					//主键字段
					idField : "ROLE_CODE",
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
					sortName : 'ROLE_CODE',
					//排序方式
					sortOrder : "desc",
					//pageNumber:5,s
					rownumbers : true,//行号 
					//分页工具所在位置
					pagePosition : "bottom",
					checkOnSelect:false,
					selectOnCheck:false,
					//冻结的列
					frozenColumns : [ [
					//选择框		
							/*{
								field : 'ROLE_CODE',
								title : 'fid',
								checkbox : true,
								align : 'center'
							},*/
							{
								field : 'ROLE_CODE',
								title : '角色Code',
								checkbox : true,
								align : 'center'
							}
							] ],
					columns : [ [
							{
								field : 'ROLE_NAME',
								title : '角色名称',
								width : 100,
								sortable : true
							},
							{
								field : 'ROLE_LEVEL',
								title : '角色等级',
								width : 100,
								sortable : true
							}
							] ]

					,
					onClickRow:function(){
						initProRoleAuth();
						initProRoleMenu();
					}
					
					
				})


		tab = $('#dataTable').datagrid({
				//title:'数据列表',
				iconCls : 'icon-ok',
				//数据来源
				url : '${ctx}/se/se!seUserListGetDate.do?r=' + Math.random(),
				//斑马纹
				striped : true,
				//主键字段
				idField : "USER_ID",
				//宽度自适应
				//fitColumns: true,
				//表单提交方式
				method : "post",
				//是否只能选择一行
				singleSelect : true,
				nowrap : false,
				fit:true,
				border:true,
				//高度
				//height:450,
				//宽度
				//width:860,
				//是否分页
				pagination : true,
				//分页信息
				pageSize : 10,
				//每页显示条目下拉菜单
				pageList : [ 5, 10, 20, 50, 100 ],
				//排序的列
				sortName : 'USER_ID',
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
							field : 'USER_ID',
							title : 'fid',
							checkbox : true,
							align : 'center'
						},*/
						{
							field : 'USER_ID',
							title : '用户ID',
							checkbox : true,
							align : 'center'
						}
						] ],
				columns : [ [
						{
							field : 'USER_NAME',
							title : '用户姓名',
							width : 100,
							sortable : true
						},
						{
							field : 'COMPANY_NAME',
							title : '所在公司',
							width : 100,
							sortable : true
						},
						{
							field : 'USER_MAIL',
							title : '邮箱',
							width : 100,
							sortable : true
						},
						{
							field : 'OPER',
							title : '操作',
							width : 80,
							align : 'center',
							formatter : function(value, row, index) {
								var editStr =  '<a  href="#" title="编辑" onclick="editData(\'' + row.USER_ID + '\')" >编辑</a>'
								var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.USER_ID + '\')" >删除</a>';
								return editStr +"&nbsp;"+ deleteStr;
							}
						} 
						] ]

				,
				toolbar :[{
					text:'设置角色',
					iconCls:'icon-user',
					handler:function(){
						setRole();
					}
				},'-',{
					//text:'Add',
					iconCls:'icon-add',
					title:'新增用户',
					handler:function(){addObj()} 
				},{
					//text:'Edit',
					iconCls:'icon-edit',
					title:'编辑用户',
					handler:function(){editData2()}
				},{
					//text:'Delete',
					iconCls:'icon-remove',
					title:'删除用户',
					handler:function(){deleteDatas()}
				},'-',{
					text:'resetForm',
					title:'重置查询条件',
					iconCls:'icon-clear',
					handler:function(){resetForm()}
				}
				
				
				
				
				],
				//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
				onSortColumn : function(sort, order) {
					$('#sort').val(sort);
					$('#order').val(order);
				}
				,
				
				onDblClickRow : function(rowIndex, rowData) {
					//不能选中条件中的行
					editData(rowData.USER_ID);
				},
				onClickRow:function(){
					initUserAuth();
					initUserMenu();
					initUserProject();
					initUserSysRole();
				}
				
			})
	})

	
	
function initUserProject(){
	projectTab.datagrid("clearChecked");
	//var node = userTree.getNodeByParam("id", 1, null);
	//userTree.checkNode(node, true, false);
	var data = tab.datagrid("getSelected");
	if(data){ 
		$.ajax({
			  dataType: "json",
			  url:'${ctx}/se/se!queryMyProject.do?id=' + data.USER_ID,
			  success: function(d){
				  console.log(d);
				  try{
					for(var i = 0 , j = d.length ; i < j ; i++){
						var rowIndex = projectTab.datagrid("getRowIndex",d[i].projectId);
						projectTab.datagrid("checkRow",rowIndex);
						
					}
				  }catch(e){
					  
				  }
			  },
			  async:false
		});
		
	}else{
		alert("请选择数据");
	}
}
	
	
function initUserSysRole(){
	theSeSysRoleTab.datagrid("clearChecked");
	//var node = userTree.getNodeByParam("id", 1, null);
	//userTree.checkNode(node, true, false);
	var data = tab.datagrid("getSelected");
	if(data){ 
		$.ajax({
			  dataType: "json",
			  url:'${ctx}/se/se!queryUserRole.do?',
			  data:{
				  id:data.USER_ID
			  },
			  success: function(d){
				  console.log(d);
				  try{
					for(var i = 0 , j = d.length ; i < j ; i++){
						var rowIndex = theSeSysRoleTab.datagrid("getRowIndex",d[i].ROLE_CODE);
						theSeSysRoleTab.datagrid("checkRow",rowIndex);
						
					}
				  }catch(e){
					  
				  }
			  },
			  async:false
		});
		
	}else{
		alert("请选择数据");
	}
}


function initUserProRole(){
	theSeProRoleTab.datagrid("clearChecked");
	//var node = userTree.getNodeByParam("id", 1, null);
	//userTree.checkNode(node, true, false);
	var data = tab.datagrid("getSelected");
	var project = projectTab.datagrid("getSelected");
	if(data && project){ 
		$.ajax({
			  dataType: "json",
			  url:'${ctx}/se/se!queryUserRole.do?',
			  data:{
				  id:data.USER_ID,
				  projectId:project.PROJECT_ID
			  },
			  success: function(d){
				  console.log(d);
				  try{
					for(var i = 0 , j = d.length ; i < j ; i++){
						var rowIndex = theSeProRoleTab.datagrid("getRowIndex",d[i].ROLE_CODE);
						theSeProRoleTab.datagrid("checkRow",rowIndex);
						
					}
				  }catch(e){
					  
				  }
			  },
			  async:false
		});
		
	}else{
		alert("请选择用户和项目");
	}
}
	
function initUserAuth(){
	$('input.ck').each(function(o){
		$(this).iCheck('uncheck');
	});
	var data = tab.datagrid("getSelected");
	if(data){
		$.ajax({
			  dataType: "json",
			  url:'${ctx}/se/se!queryAuthOfUser.do?id=' + data.USER_ID,
			  success: function(d){
				  try{
					for(var i = 0 , j = d.length ; i < j ; i++){
						//alert(d[i].authCode)
						$("#"+d[i].authCode).iCheck('check');
					}
				  }catch(e){
					  
				  }
			  },
			  async:false
		});
		
	}else{
		alert("请选择数据");
	}
}
	
function initUserMenu(){
	userTree.checkAllNodes(false);
	//var node = userTree.getNodeByParam("id", 1, null);
	//userTree.checkNode(node, true, false);
	var data = tab.datagrid("getSelected");
	if(data){ 
		$.ajax({
			  dataType: "json",
			  url:'${ctx}/se/se!queryMenuOfUser.do?id=' + data.USER_ID,
			  success: function(d){
				  try{
					for(var i = 0 , j = d.length ; i < j ; i++){
						var node = userTree.getNodeByParam("id", d[i].menuId, null);
						userTree.checkNode(node, true, false);
					}
				  }catch(e){
					  
				  }
			  },
			  async:false
		});
		
	}else{
		alert("请选择数据");
	}
}

function initProRoleAuth(){
	$('input.rck').each(function(o){
		$(this).iCheck('uncheck');
	});
	var data = theSeProRoleTab.datagrid("getSelected");
	if(data){
		$.ajax({
			  dataType: "json",
			  url:'${ctx}/se/se!queryAuthOfRole.do',
			  method:"post",
			  data:{
				  id:data.ROLE_CODE
			  },
			  success: function(d){
				  try{
					for(var i = 0 , j = d.length ; i < j ; i++){
						//alert(d[i].authCode)
						$("#r_"+d[i].authCode).iCheck('check');
					}
				  }catch(e){
					  
				  }
			  },
			  async:false
		});
		
	}else{
		alert("请选择数据");
	}
}
	
function initSysRoleMenu(){
	roleTree.checkAllNodes(false);
	//var node = userTree.getNodeByParam("id", 1, null);
	//userTree.checkNode(node, true, false);
	var data = theSeSysRoleTab.datagrid("getSelected");
	if(data){ 
		$.ajax({
			  dataType: "json",
			  url:'${ctx}/se/se!queryMenuOfRole.do',
			  method:"post",
			  data:{
				  id:data.ROLE_CODE
			  },
			  success: function(d){
				  try{
					for(var i = 0 , j = d.length ; i < j ; i++){
						var node = roleTree.getNodeByParam("id", d[i].menuId, null);
						roleTree.checkNode(node, true, false);
					}
				  }catch(e){
					  
				  }
			  },
			  async:false
		});
		
	}else{
		alert("请选择数据");
	}
}



function initSysRoleAuth(){
	$('input.rck').each(function(o){
		$(this).iCheck('uncheck');
	});
	var data = theSeSysRoleTab.datagrid("getSelected");
	if(data){
		$.ajax({
			  dataType: "json",
			  url:'${ctx}/se/se!queryAuthOfRole.do',
			  method:"post",
			  data:{
				  id:data.ROLE_CODE
			  },
			  success: function(d){
				  try{
					for(var i = 0 , j = d.length ; i < j ; i++){
						//alert(d[i].authCode)
						$("#r_"+d[i].authCode).iCheck('check');
					}
				  }catch(e){
					  
				  }
			  },
			  async:false
		});
		
	}else{
		alert("请选择数据");
	}
}
	
function initProRoleMenu(){
	roleTree.checkAllNodes(false);
	//var node = userTree.getNodeByParam("id", 1, null);
	//userTree.checkNode(node, true, false);
	var data = theSeProRoleTab.datagrid("getSelected");
	if(data){ 
		$.ajax({
			  dataType: "json",
			  url:'${ctx}/se/se!queryMenuOfRole.do',
			  method:"post",
			  data:{
				  id:data.ROLE_CODE
			  },
			  success: function(d){
				  try{
					for(var i = 0 , j = d.length ; i < j ; i++){
						var node = roleTree.getNodeByParam("id", d[i].menuId, null);
						roleTree.checkNode(node, true, false);
					}
				  }catch(e){
					  
				  }
			  },
			  async:false
		});
		
	}else{
		alert("请选择数据");
	}
}

var queryState = "open"
function hideQuery(){
	if("open" == queryState){
		$('body').layout('collapse','north');
		queryState = "close";
	}else{
		$('body').layout('expand','north');
		queryState = "open";
	}
	
}
		

function opw(obj){
	
	document.getElementById("winSrc").src = obj.url;
	$("#win").window("setTitle",obj.title);
	var w =  obj.w;
	if(!w){
		w = document.body.clientWidth * 0.95;
	}
	var h = obj.h;
	if(!h){
		h = document.body.clientHeight * 0.95;
	}
	$('#win').window('open');// open a window
	$('#win').window('resize',{
		width:w,
		height:h
	});
	$('#win').window('center');
	
}

function clw(){
	$('#win').window('close');
}
</script>
	</head>
	<body class="easyui-layout">
		
		<div data-options="region:'west',split:true,border:false,width:330">
			<div class="easyui-layout" data-options="fit:true,border:false,split:true">
				<div data-options="region:'north',split:true,border:false" style="height:33px;padding:2px;">
					<form action="" id="theForm" method="post">
						<!-- 是否全部导出 -->
						<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
						<input type="hidden" id="sort" name="sort" value="status" />
						<input type="hidden" id="order" name="order" value="desc" />
						
						
							<div class="complex_search_area" id="search_all">
								<!-- 显示的查询条件 -->
						            <input class="easyui-textbox" name="USER_NAME" id="USER_NAME" data-options="buttonText:'SEARCH',prompt:'Search...',onClickButton:loadDg" style="width:100%;">
								<!-- 
								<table border="0" class="table_none_border">
									<tr>
										<td>
											<span class="Fieldname">用户姓名：</span>
										</td>
										<td>
												<input 
												type="text"
												class="easyui-textbox" 
												name="USER_NAME"
												id="USER_NAME"
												type="text" 
												style="width:150px;"
												 />
										</td>
										
										<td>
											<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadDg()">查询</a>  
								<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetForm()">重置</a>  
										</td>
									</tr>
								</table>
								 -->
							</div>
					</form>
				</div>
				<div data-options="region:'center',border:false">
					<table id="dataTable"></table>
				</div>
			</div>
		</div>
		<div data-options="region:'center',border:false">
			<div class="easyui-layout" data-options="fit:true,border:false,split:true">
				<div data-options="region:'center',split:true,title:'用户菜单权限'">
					<ul id="userTree" class="ztree"></ul>
				</div>
				<div data-options="region:'south',split:true,title:'用户功能权限'" style="height:235px;">
					<c:forEach items="${authList}" var="auth">
						<div style="margin-bottom:5px;width:350px;float:left;margin-right:3px;" >
							<input type="checkbox" class="ck" id="${auth["AUTH_CODE"]}" value="${auth["AUTH_CODE"]}"/>
							<label> ${auth["AUTH_CODE"]} ${auth["AUTH_DESC"]}</label>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div data-options="region:'east',border:false,width:600,split:true">
			<div class="easyui-layout" data-options="fit:true,border:false">
				
				<div data-options="region:'west',split:true,border:false,width:300">
					<div class="easyui-layout" data-options="fit:true,border:false">
						<div data-options="region:'north',split:true,border:false" style="height:135px;">
							<table id="projectTab"></table>
						</div>
						<div data-options="region:'center',split:true,title:'项目角色'">
							<table id="theSeProRoleTab"></table>
						</div>
						<div data-options="region:'south',split:true,title:'系统角色'" style="height:235px;">
							<table id="theSeSysRoleTab"></table>
						</div>
					</div>
				</div>
				<div data-options="region:'center',split:true,border:false">
					<div class="easyui-layout" data-options="fit:true,border:false">
						<div data-options="region:'center',split:true,title:'角色菜单权限'">
							<ul id="roleTree" class="ztree"></ul>
						</div>
						<div data-options="region:'south',split:true,title:'角色功能权限'" style="height:235px;">
							<c:forEach items="${authList}" var="auth">
								<div style="margin-bottom:5px;width:350px;float:left;margin-right:3px;" >
									<input type="checkbox" class="rck" id="r_${auth["AUTH_CODE"]}" value="${auth["AUTH_CODE"]}"/>
									<label> ${auth["AUTH_CODE"]} ${auth["AUTH_DESC"]}</label>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div id="win" title="角色设置"><iframe id="winSrc" frameborder="0" width="100%" height="100%"></iframe></div>
	</body>

</html>
