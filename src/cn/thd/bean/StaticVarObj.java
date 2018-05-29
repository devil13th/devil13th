/** 
 * Class Description:########
 * Date : 2018年1月25日 下午11:59:15
 * Auth : ccse 
*/  

package cn.thd.bean;

public class StaticVarObj {
	private  static StaticVarObj instance;
	
	private String y = StaticVar.Y;
	private String n = StaticVar.N;
	
	private StaticVarObj(){}
	
	public static StaticVarObj getInstance(){
		if(instance == null){
			instance = new StaticVarObj();
		}
		return instance;
	}


	public String getY() {
		return y;
	}

	public String getN() {
		return n;
	}
	
	
}
