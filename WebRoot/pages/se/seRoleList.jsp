<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		
		<!-- jquery ztree css -->
<link rel="stylesheet" href="${ctx}/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<!-- jquery ztree -->
<script src="${ctx}/js/ztree/js/jquery.ztree.all-3.5.js"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		
		<script type="text/javascript">
	var theSeRoleTab;

	var theSeRoleForm;
	
	
	
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
	
	var zTree;

	
	//刷新表格
	function reloadSeRoleDg() {
		theSeRoleTab.datagrid("reload");
	}
	//重新查询
	function loadSeRoleDg() {
		var jsonData = $("#theSeRoleForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSeRoleTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSeRoleForm(){
		theSeRoleForm.form("clear");
		loadSeRoleDg();
	}

	//弹出保存页面方法
	function addSeRoleObj(t) {
		showWin("${ctx}/se/se!seRoleForm.do", 900, 600);
	}
	//弹出编辑页面
	function editSeRoleDate(id) {
		showWin("${ctx}/se/se!seRoleForm.do?seRole.roleCode=" + id,900, 600);
	}
	//弹出编辑页面
	function editSeRoleDate2() {
		var data = theSeRoleTab.datagrid("getSelected");
		if(data){
			editSeRoleDate(data.ROLE_CODE);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSeRoleDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/se/se!deleteSeRoleByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSeRoleTab.datagrid("clearChecked");
							loadSeRoleDg();
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
		var data = theSeRoleTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].ROLE_CODE);
			str += (data[i].ROLE_CODE + ",");
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
			$.ajax("${ctx}/se/se!deleteSeRoleById.do?seRole.roleCode=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSeRoleDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theSeRoleForm = $('#theSeRoleForm').form({
			ajax:false
		})
		
		zTree=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		zTree.expandAll(true)
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
		
		
		
		$("#ROLE_CLASSIFY").combobox();
		
		theSeRoleTab = $('#theSeRoledataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seRoleListGetDate.do?r=' + Math.random(),
							queryParams:{PROJECT_ID:'1'},
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
							pagination : true,
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
									},
									{
										field : 'ROLE_CLASSIFY',
										title : '角色分类',
										width : 100,
										sortable : true
									},
									{
										field : 'IS_VALID',
										title : '是否有效',
										width : 100,
										sortable : true
									},
									/*{
										field : 'CREATOR',
										title : '创建人',
										width : 100,
										sortable : true
									},
									{
										field : 'CREATE_TIME',
										title : '创建时间',
										width : 100,
										sortable : true
									},
									{
										field : 'MODIFIER',
										title : '修改人',
										width : 100,
										sortable : true
									},
									{
										field : 'MODI_TIME',
										title : '修改时间',
										width : 100,
										sortable : true
									},*/
									{
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editSeRoleDate(\'' + row.ROLE_CODE + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.ROLE_CODE + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideSeRoleQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addSeRoleObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editSeRoleDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteSeRoleDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							onClickRow:function(){
								initAuth();
								initMenu();
							},
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editSeRoleDate(rowData.ROLE_CODE);
							}
							
						})

	})

	

var querySeRoleState = "open"
function hideSeRoleQuery(){
	if("open" == querySeRoleState){
		$('body').layout('collapse','north');
		querySeRoleState = "close";
	}else{
		$('body').layout('expand','north');
		querySeRoleState = "open";
	}
	
}
		
function initAuth(id){
	$('input.ck').each(function(o){
		$(this).iCheck('uncheck');
	});
	 
	var data = theSeRoleTab.datagrid("getSelected");
	if(data){ 
		$.ajax({
			  dataType: "json",
			  url:'${ctx}/se/se!queryAuthOfRole.do?id=' + data.ROLE_CODE,
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

function initMenu(){
	
	zTree.checkAllNodes(false);
	//var node = zTree.getNodeByParam("id", 1, null);
	//zTree.checkNode(node, true, false);
	var data = theSeRoleTab.datagrid("getSelected");
	if(data){ 
		$.ajax({
			  dataType: "json",
			  url:'${ctx}/se/se!queryMenuOfRole.do?id=' + data.ROLE_CODE,
			  success: function(d){
				  try{
					for(var i = 0 , j = d.length ; i < j ; i++){
						var node = zTree.getNodeByParam("id", d[i].menuId, null);
						zTree.checkNode(node, true, false);
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
function saveMenuOfRole(){
	var data = theSeRoleTab.datagrid("getSelected");
	if(data){ 
		
		
		var nodes = zTree.getCheckedNodes(true);
		//console.log(nodes);
		var menuIds = "";
		if(nodes){
			for(var i = 0 , j = nodes.length ; i < j ; i++){
				menuIds += "," + nodes[i].id
			}
		}
		if(menuIds){
			menuIds = menuIds.substring(1,menuIds.length);
		}
		//alert(menuIds);
		
		$.ajax({
			  dataType: "text",
			  url:"${ctx}/se/se!saveMenuOfRole.do",
			  data:{
				  id:data.ROLE_CODE,
				  ids:menuIds
			  },
			  success: function(d){
				  if($.trim(d) == "SUCCESS"){
					  alert("操作成功");
				  }else{
					  alert(d);
				  };
			  },
			  async:false
		});
	}else{
		alert("请选择数据");
	}
}

function saveAuthOfRole(){
	var data = theSeRoleTab.datagrid("getSelected");
	if(data){ 
		
		var auths = "";
		<c:forEach items="${authList}" var="auth">
			if(true == $("#${auth["AUTH_CODE"]}").is(':checked')){
				auths += ",${auth["AUTH_CODE"]}";
			}
		</c:forEach>
		if(auths){
			auths = auths.substring(1,auths.length);
		}
		//alert(auths);
		$.ajax({
			  dataType: "text",
			  url:"${ctx}/se/se!saveAuthOfRole.do",
			  data:{
				  id:data.ROLE_CODE,
				  ids:auths
			  },
			  success: function(d){
				  if($.trim(d) == "SUCCESS"){
					  alert("操作成功");
				  }else{
					  alert(d);
				  };
			  },
			  async:false
		});
	}else{
		alert("请选择数据");
	}
	
	
}

function selectAllMenu(){
	zTree.checkAllNodes(true);
}

function clearAllMenu(){
	zTree.checkAllNodes(false);
}
</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSeRoleForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 角色Code -->
									<td>
										<span class="Fieldname">角色Code：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="ROLE_CODE"
											id="ROLE_CODE"
											type="text" 
											style="width:150px;"
											 />
									</td>


									<!-- 角色名称 -->
									<td>
										<span class="Fieldname">角色名称：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="ROLE_NAME"
											id="ROLE_NAME"
											type="text" 
											style="width:150px;"
											 />
									</td>
									
									<!-- 角色分类 -->
									<td>
										<span class="Fieldname">角色分类：</span>
									</td>
									<td>
									<select id="ROLE_CLASSIFY" name="ROLE_CLASSIFY"  cssClass="easyui-combobox" >
										<option value="">全部</option>
										<option value="SYSTEM">系统角色</option>
										<option value="PROJECT">项目角色</option>
									</select>
								 
								 
									</td>
									
									<td>
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSeRoleDg()">查询</a>  
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSeRoleForm()">重置</a>  
									</td>
									
									
									<!-- 
									<td>
										<span class="Fieldname">角色等级：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="ROLE_LEVEL"
											id="ROLE_LEVEL"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<span class="Fieldname">是否有效：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="IS_VALID"
											id="IS_VALID"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<span class="Fieldname">创建人：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="CREATOR"
											id="CREATOR"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<span class="Fieldname">创建时间：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="CREATE_TIME"
											id="CREATE_TIME"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<td>
										<span class="Fieldname">修改人：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MODIFIER"
											id="MODIFIER"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<span class="Fieldname">修改时间：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="MODI_TIME"
											id="MODI_TIME"
											type="text" 
											style="width:100px;"
											 />
									</td>
									 -->
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'west',split:true,width:600,title:'角色列表'" >
				<table id="theSeRoledataTable">
				</table>
		</div>
		<div data-options="region:'center',border:true,title:'菜单权限'">
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveMenuOfRole()">保存</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="selectAllMenu()">全选</a>  	
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="clearAllMenu()">全不选</a>  	  		
			<ul id="treeDemo" class="ztree"></ul>
			
		</div>
		<div data-options="region:'south',split:true,title:'功能权限'" style="height:300px;padding:5px;">
			<table width="100%">
				<c:forEach items="${authList}" var="auth">
					<tr>
						<td width="180">
							<div style="margin-bottom:3px;">
								<input type="checkbox" class="ck" id="${auth["AUTH_CODE"]}" value="${auth["AUTH_CODE"]}"/>
								<label> ${auth["AUTH_CODE"]}</label>
							</div>
						</td>
						<td>
						${auth["AUTH_DESC"]}
						</td>
					</tr>
				</c:forEach>
			</table>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveAuthOfRole()">保存</a>  		
					
		</div>
				
				
		
	</body>

</html>
