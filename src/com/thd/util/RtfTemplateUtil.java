package com.thd.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

import oracle.apps.xdo.template.FOProcessor;
import oracle.apps.xdo.template.RTFProcessor;

public class RtfTemplateUtil {
	//rtf模板名称路径
	private String rtfTemplateFilePath;
	//中间过程生成的xsl路径
	private String xslFilePath;
	//xml数据文件路径
	private String xmlFilePath;
	//配置文件位路径
	private String cfgFilePath;
	//输出最终文件路径
	private String resultPdfFilePath;
	// 输出格式
	private byte outputFormat;
	
	
	public RtfTemplateUtil(){}
	
	/**
	 * 构造方法
	 * @param rtfTemplateFilePath  rtf模板名称路径
	 * @param xslFilePath  中间过程生成的xsl路径
	 * @param xmlFilePath  xml数据文件路径
	 * @param cfgFilePath  配置文件位路径
	 * @param resultPdfFilePath  输出最终文件路径
	 * @param outputType 输出文件类型
	 * 	可直接使用静态变量 
	 *  FOProcessor.FORMAT_PDF
	 *  FOProcessor.FORMAT_RTF
	 *  FOProcessor.FORMAT_HTML
	 *  FOProcessor.FORMAT_EXCEL 
	 */
	public RtfTemplateUtil(String rtfTemplateFilePath, String xslFilePath,
			String xmlFilePath, String cfgFilePath, String resultPdfFilePath,byte outputFormat) {
		super();
		this.rtfTemplateFilePath = rtfTemplateFilePath;
		this.xslFilePath = xslFilePath;
		this.xmlFilePath = xmlFilePath;
		this.cfgFilePath = cfgFilePath;
		this.resultPdfFilePath = resultPdfFilePath;
		this.outputFormat = outputFormat;
	}

	/**
	 * RTF文件转换成XSL-FO文件
	 */
	public void genarateXsl(){
		try{
			//input template RTF模板路径
			RTFProcessor rtfProcessor = new RTFProcessor(this.rtfTemplateFilePath); 
			//生成的xsl路径
			rtfProcessor.setOutput(this.xslFilePath); 
			rtfProcessor.process();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public File genarateReportPdf() {
		try {
			this.genarateXsl();
			FOProcessor processor = new FOProcessor();
			//设置Oracle BI的配置文件信息（字体）
			processor.setConfig(this.cfgFilePath); 
			// set XSL input file
			processor.setTemplate(this.xslFilePath);  
			// set dataXML input file
			processor.setData(this.xmlFilePath);               
			processor.setOutput(this.resultPdfFilePath);     //set output file
//			processor.setOutputFormat(FOProcessor.FORMAT_PDF);                           //输出为pdf
//			processor.setOutputFormat(FOProcessor.FORMAT_RTF);                           //输出为pdf
//			processor.setOutputFormat(FOProcessor.FORMAT_HTML);
//			processor.setOutputFormat(FOProcessor.FORMAT_EXCEL);
			
			processor.setOutputFormat(outputFormat);
			processor.generate();
//			this.deleteTempFiles();
			return new File(this.resultPdfFilePath);
		} catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException("生成pdf文件失败!");
		}
	}
	
	
	
	/**
	 * 生成xdo.cfg文件，以加载BIP 的中文字体
	 * @param path 生成位置(文件夹名)
	 * @param fontPath 字体位置(字体所在文件夹)
	 * @throws IOException 
	 * */
	public static void generateXdoCfg(String cfgFilePath,String fontFolderPath)  {
		try{
			OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream (new File(cfgFilePath)),"utf-8");
			osw.write("<config version=\"1.0.0\"  xmlns=\"http://xmlns.oracle.com/oxp/config/\">");
			osw.write("<properties>");
			osw.write("<property name=\"pdf-security\">false</property>");
			osw.write("    <property name=\"pdf-open-password\">user</property>");
			osw.write("    <property name=\"pdf-permissions-password\">owner</property>");
			osw.write("    <property name=\"pdf-no-printing\">true</property>");
			osw.write("     <property name=\"pdf-no-changing-the-document\">true</property>");
			osw.write("</properties>");
			osw.write("<fonts>");
			osw.write("  <font family=\"Times New Roman\" style=\"normal\" weight=\"normal\">");
			//osw.write("   <truetype path=\""+appAbsolutePath+"/fonts/times.ttf\" />");
			osw.write("   <truetype path=\""+ fontFolderPath + File.separator + "times.ttf\" />");
			osw.write("   </font>");
			osw.write("  <font family=\"Wingdings\" style=\"normal\" weight=\"normal\">");
			//osw.write("   <truetype path=\""+appAbsolutePath+"/fonts/wingding.ttf\" />");
			osw.write("   <truetype path=\""+ fontFolderPath + File.separator +"wingding.ttf\" />");
			osw.write("  </font>");
			osw.write("  <font family=\"仿宋\" style=\"normal\" weight=\"normal\">");
			//osw.write("	  <truetype path=\""+appAbsolutePath+"/fonts/SIMFANG.TTF\" />");
			osw.write("	  <truetype path=\""+ fontFolderPath + File.separator + "SIMFANG.TTF\" />");
			osw.write("  </font>");
			osw.write("  <font family=\"宋体\" style=\"normal\" weight=\"normal\">");
			//osw.write("   <truetype path=\""+appAbsolutePath+"/fonts/SIMSUN.TTC\" />"); 
			osw.write("   <truetype path=\""+ fontFolderPath + File.separator + "SIMSUN.TTC\" />"); 
			osw.write("  </font>");
			osw.write("  <font family=\"宋体\" style=\"normal\" weight=\"bold\">");
			//osw.write("   <truetype path=\""+appAbsolutePath+"/fonts/simsun-bold.ttf\" />"); 
			osw.write("   <truetype path=\""+ fontFolderPath + File.separator + "simsun-bold.ttf\" />"); 
			osw.write("  </font>");
			osw.write("  <font family=\"Albany WT SC\" style=\"normal\" weight=\"normal\">");
			//osw.write("   <truetype path=\""+appAbsolutePath+"/fonts/ALBANWTS.ttf\" />"); 
			osw.write("   <truetype path=\""+ fontFolderPath + File.separator + "ALBANWTS.ttf\" />"); 
			osw.write("  </font>");
			
			osw.write("  <font family=\"黑体\" style=\"normal\" weight=\"normal\">");
			//osw.write("   <truetype path=\""+appAbsolutePath+"/fonts/ALBANWTS.ttf\" />"); 
			osw.write("   <truetype path=\""+ fontFolderPath + File.separator + "SIMHEI.TTF\" />"); 
			osw.write("  </font>");
			
			osw.write("</fonts>");
			osw.write("  </config>");
			osw.close();
		}catch(IOException ioe){
			ioe.printStackTrace();
		}
	}

	public String getRtfTemplateFilePath() {
		return rtfTemplateFilePath;
	}

	public void setRtfTemplateFilePath(String rtfTemplateFilePath) {
		this.rtfTemplateFilePath = rtfTemplateFilePath;
	}

	public String getXslFilePath() {
		return xslFilePath;
	}

	public void setXslFilePath(String xslFilePath) {
		this.xslFilePath = xslFilePath;
	}

	public String getXmlFilePath() {
		return xmlFilePath;
	}

	public void setXmlFilePath(String xmlFilePath) {
		this.xmlFilePath = xmlFilePath;
	}

	public String getCfgFilePath() {
		return cfgFilePath;
	}

	public void setCfgFilePath(String cfgFilePath) {
		this.cfgFilePath = cfgFilePath;
	}

	public String getResultPdfFilePath() {
		return resultPdfFilePath;
	}

	public void setResultPdfFilePath(String resultPdfFilePath) {
		this.resultPdfFilePath = resultPdfFilePath;
	}
	
	
}
