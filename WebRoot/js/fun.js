

//------------------------ window.open 打开窗口 --------------------------------
function openWindow(obj){
	if(obj.url == undefined || obj.url == null){
		throw new Error("please set obj.url");
	}
	var url = obj.url;

	if(url.indexOf("?")!=-1){
		url = url+ "&r_=" + Math.random();
	}else {
		url = url+ "?r_=" + Math.random();
	}
	
	//alert(obj.width + "," + obj.height + "," + obj.top + "," + obj.left);

	var w ;
	if(!obj.width){
		w = screen.width/1.8;
	}else{
		w = parseInt(obj.width);
	}

	var h ;
	if(!obj.height){
		//h = 500;
		
		h=screen.height/1.8;
	}else{
		
		h = parseInt(obj.height);
	}

	var t ;
	if(!obj.top){
		t = 0;
	}else{
		t = parseInt(obj.top);
	}

	var l;
	if(!obj.left){
		l = (screen.width - parseInt(w))/2;
	}else{
		l = parseInt(obj.left);
	}
	
	w = parseInt(w);
	h = parseInt(h);
	l = parseInt(l);
	t = parseInt(t);
	
	//窗口句柄
	var name;
	if(!obj.name){
		name = "win_" + new Date().getTime();
	}else{
		name = obj.name;
	}

	//alert(name);

	//是否可以改变窗口大小
	var resizable = obj.resizable || "yes";

	//是否有滚动条
	var scrollbars= obj.scrollbars || "yes";

	//是否有状态栏
	var status = obj.status || "no";

	//是否有菜单栏
	var menubar = obj.menubar || "no";
	
	//是否有工具栏
	var toolbar = obj.toolbar || "yes";
	
	//是否有地址栏
	var locations = obj.locations || "yes";
	
	return window.open (url,name,"height=" + h + ",width=" + w +  ",top=" + t + ",left=" + l + ",toolbar=" + toolbar + ",menubar=" + menubar + ",scrollbars=" + scrollbars + ", resizable=" + resizable + ",location=" + locations + ", status=" + status + ",hotkeys=esc"); 
}





Date.prototype.Format = function(fmt){  
    var o = {  
        "M+": this.getMonth() + 1, //月份   
        "d+": this.getDate(), //日   
        "h+": this.getHours(), //小时   
        "m+": this.getMinutes(), //分   
        "s+": this.getSeconds(), //秒   
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
        "S": this.getMilliseconds() //毫秒   
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
    for (var k in o)  
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
    return fmt;  
    
  //调用：var date= new Date().Format("yyyy-MM-dd");//Format("输入你想要的时间格式:yyyy-MM-dd,yyyyMMdd")
}  


/**
 * 日期加减
 * @param date : 基础日期 例如2018-01-01
 * @pram i : 加减天数，加为正数，减为负数
 * @return 字符串 例如 2018-01-01
 */
function dayAdd(date,i){
	var temp = new Date(date);//获取当前时间  
	temp.setDate(temp.getDate() + i);//设置天数 -1 天  
	return temp.Format("yyyy-MM-dd");  
}



//打开窗口的快捷方法
function showWin(url,w,h){
	var width = w || (window.innerWidth * 0.9) + "px";
	var height = h || (window.innerHeight * 0.9) + "px";

	openWindow({
		url : url,
		width : width,
		height : height
	});
}


//获取使用window.open打开的窗口的父窗口对象
function getParent(){
	var p = "";
	if (window.opener != undefined) {
		p = window.opener;
	}
	else {
		p = window.dialogArguments;
	};
	return p;
}

function getFormJsonData(formId){
	var paramsObj = $("#" + formId).serializeArray();
	console.log(paramsObj);
	return formToJson(paramsObj);
}

function formToJson(objArray){
	var jsonObj = {};
	for(var i = 0 , j = objArray.length ; i < j ;i++){
		var obj = objArray[i];
		if(!jsonObj[obj.name]){
			jsonObj[obj.name] = obj.value;
		}else{
			jsonObj[obj.name] += ","+obj.value;
		}
	}
	return jsonObj;
}


