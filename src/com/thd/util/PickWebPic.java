package com.thd.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

public class PickWebPic {

	public static void copy (String u,File t){
		int HttpResult;
		InputStream in = null;
		OutputStream out = null;
		try {
			
			URL url = new URL(u); // 创建URL
			URLConnection urlconn = url.openConnection(); // 试图连接并取得返回状态码
			urlconn.connect();
			HttpURLConnection httpconn = (HttpURLConnection) urlconn;
			HttpResult = httpconn.getResponseCode();
			System.out.println("服务器响应状态：" + HttpResult);
			if (HttpResult != HttpURLConnection.HTTP_OK) {// 不等于HTTP_OK说明连接不成功
				System.out.println("failure");
			} else {
				int BUFFER_SIZE = 16 * 1024;
				in = new BufferedInputStream(url.openStream());
				out = new BufferedOutputStream(new FileOutputStream(t),
	                    BUFFER_SIZE);
	            byte[] buffer = new byte[BUFFER_SIZE];
	            int len = 0;
	           
	            while ((len = in.read(buffer)) > 0) {
	                out.write(buffer, 0, len);
	            }
				System.out.println("finish");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
            if (null != in) {
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (null != out) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
	};
	
	
	
	public static void main(String[] args) {
		//WebPicSaveTest.copy("http://img1.gtimg.com/1/102/10289/1028943_550x550_0.jpg",new File("d://lxr//4.jpg"));
	
	}	
	
	

}
