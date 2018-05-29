<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>
		<script type="text/javascript">
	var traceNoteDataTable;
	var ue;
	var traceNoteForm;
	var traceId ="";
	
	var input_user_list_setting ={
			url:'${ctx}/common/common!queryUserListJsonStr.do',
			valueField:'USER_ID',
			textField:'USER_NAME'
	};
	
	
	
	//刷新表格
	function reloadTraceNoteDg() {
		traceNoteDataTable.datagrid("reload");
	}
	//重新查询
	function loadTraceNoteDg() {
		var jsonData = $("#traceNoteForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//alert(traceId)
		params.TRACE_ID = traceId;
		console.log("----" + params);
		traceNoteDataTable.datagrid("load", params);
	}
	//重置表单后查询
	function resetTraceNoteForm(){
		traceNoteForm.form("clear");
		traceId="";
		loadTraceNoteDg();
	}

	//弹出保存页面方法
	function addTraceNote(t) {
		showWin("${ctx}/se/se!seTraceNoteForm.do?seTraceNote.traceId=" + traceId, 1080, 600);
	}
	//弹出编辑页面
	function editTraceNoteData(id) {
		showWin("${ctx}/se/se!seTraceNoteForm.do?seTraceNote.noteId=" + id,1080, 600);
	}
	//弹出编辑页面
	function editTraceNoteData2() {
		var data = traceNoteDataTable.datagrid("getSelected");
		if(data){
			editTraceNoteData(data.NOTE_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteTraceNoteDatas(){
		var checkedIds = getTraceNoteCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/se/se!deleteSeTraceNoteByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							traceNoteDataTable.datagrid("clearChecked");
							loadTraceNoteDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
		
	}
	//获取勾选的行
	function getTraceNoteCheckedIds(){
		var data = traceNoteDataTable.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].NOTE_ID);
			str += (data[i].NOTE_ID + ",");
		};
		if(str != ""){
			str = str.substring(0,str.length - 1);
			return str;
		}else{
			return "";
		}
		
	}
	//删除操作
	function deleteTraceNoteData(id){
		if(confirm("确定删除此条记录么?")){
			$.ajax("${ctx}/se/se!deleteSeTraceNoteById.do?seTraceNote.noteId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadTraceNoteDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		traceNoteForm = $('#traceNoteForm').form({
			ajax:false
		})
		
		$("#traceNoteUserId").combobox(input_user_list_setting);
		
		traceNoteDataTable = $('#traceNoteDataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seTraceNoteListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "NOTE_ID",
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
							sortName : 'NOTE_ID',
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
										field : 'NOTE_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'NOTE_ID',
										title : '遗留备忘id',
										checkbox : true,
										align : 'center'
									},
									{
										field : 'NOTE_TYPE',
										title : '记事种类',
										width : 100,
										sortable : true
									},
									{
										field : 'NOTE_TITLE',
										title : '遗留备忘标题',
										width : 200,
										sortable : true
									}
									] ],
							columns : [ [
									
									/*{
										field : 'NOTE_CONTENT',
										title : '遗留备忘内容',
										width : 100,
										sortable : true
									},*/
									{
										field : 'NOTE_STATUS',
										title : '状态',
										width : 100,
										sortable : true
									},
									{
										field : 'USER_NAME',
										title : '执行人',
										width : 100,
										sortable : true
									},
									
									{
										field : 'TRACE_NAME',
										title : '矩阵名称',
										width : 150,
										sortable : true
									},
									{
										field : 'ALARM_DATE',
										title : '提醒日期',
										width : 100,
										sortable : true
									},
									{
										field : 'ALARM_DAYS',
										title : '预警天数',
										width : 100,
										sortable : true
									}
									/*{
										field : 'IS_VALID',
										title : '是否有效',
										width : 100,
										sortable : true
									},
									{
										field : 'IS_DELETE',
										title : '是否删除',
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
										field : 'UPDATE_TIME',
										title : '修改时间',
										width : 100,
										sortable : true
									},
									{
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editTraceNoteData(\'' + row.NOTE_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.NOTE_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} */
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addTraceNote()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editTraceNoteData2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteTraceNoteDatas()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editTraceNoteData(rowData.NOTE_ID);
							},
							onClickRow:function(rowIndex,rowData){
								$("#noteId").val(rowData.NOTE_ID);
								$.ajax("${ctx}/se/se!queryContentOfTraceNote.do",
									{
										type:"post",
										data:{id:rowData.NOTE_ID},
										success:function(r){
											var str = $.trim(r);
											//alert(str);
											ue.setContent(str, false);
										}
									}
								)
							}
						})

	})

	

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
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="traceNoteForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0" class="table_none_border">
								<tr>
									<!-- 记事种类  遗留 备忘 缺陷 -->
									<!--<td>
										<span class="Fieldname">种类：</span>
									</td>-->
									<td>
							
							 			 <s:select 
							 id="NOTE_TYPE" 
							 cssStyle="width:100px;"
							 cssClass="easyui-combobox" 
							 name="NOTE_TYPE" 
							  list="#{'遗留':'遗留','备忘':'备忘','缺陷':'缺陷','变更':'变更','设计缺陷':'设计缺陷'}" 
							 headerKey="" 
							 headerValue="请选择种类"></s:select>
									</td>
									<!-- 遗留备忘状态 -->
									<!-- <td>
										<span class="Fieldname">状态：</span>
									</td>-->
									<td>
											 
											 <s:select 
										 id="NOTE_STATUS" 
										 cssStyle="width:100px;"
										 cssClass="easyui-combobox" 
										 name="NOTE_STATUS" 
										 list="#{'未落实':'未落实','已落实':'已落实'}" 
										 headerKey="" 
										 headerValue="请选择状态"></s:select>
									</td>
									<td>
										<input type="text"  id="traceNoteUserId"  name="userId" style="width:130px;"/>
									</td>
									<!-- 遗留备忘标题 -->
									<td>
										<span class="Fieldname">标题|内容：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="NOTE_TITLE"
											id="NOTE_TITLE"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 遗留备忘内容 -->
									<!--<td>
										<span class="Fieldname">内容：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="NOTE_CONTENT"
											id="NOTE_CONTENT"
											type="text" 
											style="width:150px;"
											 />
									</td>-->
									
									
									<td>
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadTraceNoteDg()">查询</a>  
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetTraceNoteForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="traceNoteDataTable"></table>
		</div>
		<div data-options="region:'east',split:true,title:'内容'" style="width:460px;">
			<input type="hidden" id="noteId" name="noteId"/>
			<textarea id="content" name="content"></textarea>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="saveContent(0)">保存</a> 
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="saveContent(1)">保存并落实</a>   
		</div>	
				
<script>
//消息
function message(text){
	$.messager.show({
		title:'消息',
		msg:text,
		showType:'show'
	});
}
function saveContent(s){
	//alert(ue.getContent());
	var noteId = $("#noteId").val();
	if(noteId){
		$.ajax("${ctx}/se/se!saveSeTraceNoteContent.do",
			{
				type:"post",
				data:{
					"seTraceNote.noteId":noteId,
					"seTraceNote.noteContent":ue.getContent(),
					"seTraceNote.noteStatus":s
				},
				success:function(r){
					if("success" == $.trim(r)){
						message("操作成功");
						loadTraceNoteDg();
					}
				}
			}
		)
	}else{
		alert("请选择一条记录");
	}
	
}
ue = UE.getEditor('content',{
	serverUrl: "${ctx}/se/se!uploadFile.do",
   	imageUrlPrefix:"",
   	imageActionName:'img',
   	imageFieldName:'imgFile',
   	imageAllowFiles:[".png", ".jpg", ".jpeg", ".gif", ".bmp"],
   	initialFrameWidth:'100%',   //初始化编辑器宽度,默认1000 
    initialFrameHeight:300,  //初始化编辑器高度,默认320
   	fileActionName: "uploadfile", /* controller里,执行上传视频的action名称 */
    fileFieldName: "imgFile", /* 提交的文件表单名称 */
    fileUrlPrefix: "", /* 文件访问路径前缀 */
    fileMaxSize: 51200000, /* 上传大小限制，单位B，默认50MB */
    fileAllowFiles: [
        ".png", ".jpg", ".jpeg", ".gif", ".bmp",
        ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
        ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid",
        ".rar", ".zip", ".tar", ".gz", ".7z", ".bz2", ".cab", ".iso",
        ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt", ".md", ".xml"
    ],
    videoActionName: "uploadvideo", /* 执行上传视频的action名称 */
    videoFieldName: "imgFile", /* 提交的视频表单名称 */
    videoMaxSize: 102400000, /* 上传大小限制，单位B，默认100MB */
    videoAllowFiles: [
        ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
        ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid"], /* 上传视频格式显示 */
    enableAutoSave: false
});
</script>	
	</body>

</html>
