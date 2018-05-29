package com.thd.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class MyBase64Utils {
	/**
	 * <p>
	 * 将文件转成base64 字符串
	 * </p>
	 * 
	 * @param path
	 *            文件路径
	 * @return
	 * @throws Exception
	 */
	public static String encodeBase64File(String path) throws Exception {
		FileInputStream inputFile = null;
		byte[] buffer;
		try {
			File file = new File(path);
			inputFile = new FileInputStream(file);
			buffer = new byte[(int) file.length()];
			inputFile.read(buffer);
			return new BASE64Encoder().encode(buffer);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			inputFile.close();
		}
		return "";
	}

	/**
	 * <p>
	 * 将base64字符解码保存文件
	 * </p>
	 * 
	 * @param base64Code
	 * @param targetPath
	 * @throws Exception
	 */
	public static void decoderBase64File(String base64Code, String targetPath)
			throws Exception {
		FileOutputStream out = null;
		try {
			byte[] buffer = new BASE64Decoder().decodeBuffer(base64Code);
			out = new FileOutputStream(targetPath);
			out.write(buffer);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}

	/**
	 * <p>
	 * 将base64字符保存文本文件
	 * </p>
	 * 
	 * @param base64Code
	 * @param targetPath
	 * @throws Exception
	 */
	public static void toFile(String base64Code, String targetPath)
			throws Exception {
		FileOutputStream out = null;
		try {
			byte[] buffer = base64Code.getBytes();
			out = new FileOutputStream(targetPath);
			out.write(buffer);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}
	
	/**
	 * 将字符串编码成base64字符串
	 * @param str
	 * @return
	 */
	public static String encodeStr(String str){
		return new BASE64Encoder().encode(str.getBytes());
	}
	
	/**
	 * 将base64字符串解码为字符串
	 * @param str
	 * @return
	 */
	public static String decodeStr(String str){
		String ret="";
		try {
			ret=  new String(new BASE64Decoder().decodeBuffer(str));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

	public static void main(String[] args) {
		try {

			// String base64Code = encodeBase64File("D:\\FileUpload.pdf");
			//
			// System.out.println(base64Code);
			//
			// decoderBase64File(base64Code, "D:\\FileUpload2.pdf");

			// toFile(base64Code, "D:\\three.txt");
			// String s = "1";
			// double d_time = 0;
			// d_time = Double.parseDouble(s);
			// System.out.println(d_time);
			// d_time = d_time * 60 * 60 * 1000;
			// System.out.println(d_time);
			// int time = (int)d_time;
			// System.out.println(time);
			// Date date = new Date();
			// System.out.println(date.getTime());
			// System.out.println(System.currentTimeMillis());
			// System.out.println(File2Code.encryptBASE64("11111111".getBytes()));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
