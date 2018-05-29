package com.thd.util;

import java.io.InputStream;
import java.util.Properties;

public class ReadPro{
	public String read(String key){
		 InputStream in = this.getClass().getClassLoader().getResourceAsStream("sys.properties");
		 Properties properties = new Properties();
		 try{
			 properties.load(in);
			 return properties.getProperty(key);
		 }catch(Exception e){
			 System.out.println(e);
		 }
		 return null;

	}
	
	public static void main(String args[]){
		ReadPro rp = new ReadPro();
		System.out.println(rp.read("uploadPath"));		
	}
}
