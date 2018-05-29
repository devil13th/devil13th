/** 
 * Class Description:########
 * Date : 2017年8月14日 上午10:40:26
 * Auth : wanglei 
*/  

package cn.thd.staticbean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.thd.bean.Option;

public class FixedDicCollectionBean {
	//字典列表
	private List<Option> dicList = new ArrayList<Option>();
	//字典键值
	private Map<String,String> dicMap = new HashMap<String,String>();
	public Map<String, String> getDicMap() {
		return dicMap;
	}
	public void setDicMap(Map<String, String> dicMap) {
		this.dicMap = dicMap;
	}
	public List<Option> getDicList() {
		return dicList;
	}
	public void setDicList(List<Option> dicList) {
		this.dicList = dicList;
	}
	
}
