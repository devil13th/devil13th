package com.thd.util;

import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

/**
 * 导出excel与pdf<br>
 * <p>
 * 
 * 
 * @author cjj
 * 
 */
public class ExportUtil {

	/**
	 * 导出excel<br>
	 * <p>
	 * 方法的详述<br>
	 * 
	 * @param 参数
	 *            参数描述   list是object
	 * 
	 * @author cjj
	 */
	public static void ExportXlsForObj(List list, OutputStream os, String colId,
			String colName) {

		// 2003版本
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet1 = (HSSFSheet) wb.createSheet("sheet1");

		HSSFRow row = sheet1.createRow((short) 0);
		HSSFCell cell = null;
		CellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setWrapText(true);
		org.apache.poi.ss.usermodel.Font font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		style.setFont(font);

		String[] cName = colName.split(",");
		for (int index = 0; index < cName.length; index++) {
			cell = row.createCell(index);
			cell.setCellStyle(style);
			cell.setCellValue(cName[index]);
		}

		if (list != null && list.size() > 0) {
			style = wb.createCellStyle();
			style.setAlignment(HSSFCellStyle.VERTICAL_CENTER);
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			font = wb.createFont();
			font.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
			style.setFont(font);

			String[] cid = colId.split(",");
			Method method = null;
			String value = "";
			for (int indexList = 0; indexList < list.size(); indexList++) {
				row = sheet1.createRow((short) indexList + 1);
				Object obj = list.get(indexList);
				for (int index = 0; index < cid.length; index++) {
					value = getValue(cid[index], obj);
					cell = row.createCell(index);
					cell.setCellStyle(style);
					cell.setCellValue(value);
					sheet1.autoSizeColumn((short) index);
					value = "";
				}
			}
		}

		try {
			wb.write(os);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	/**
	 * 导出excel<br>
	 * <p>
	 * 方法的详述<br>
	 * 
	 * @param 参数
	 *            参数描述  List<Map>
	 * 
	 * @author cjj
	 */
	public static void ExportXlsForMap(List<Map> list, OutputStream os, String colId,
			String colName) {

		// 2003版本
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet1 = (HSSFSheet) wb.createSheet("sheet1");

		HSSFRow row = sheet1.createRow((short) 0);
		HSSFCell cell = null;
		CellStyle style = wb.createCellStyle();
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
		style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		style.setWrapText(true);
		org.apache.poi.ss.usermodel.Font font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		style.setFont(font);

		String[] cName = colName.split(",");
		for (int index = 0; index < cName.length; index++) {
			cell = row.createCell(index);
			cell.setCellStyle(style);
			cell.setCellValue(cName[index]);
		}

		if (list != null && list.size() > 0) {
			style = wb.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			style.setBorderRight(HSSFCellStyle.BORDER_THIN);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
			style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			style.setWrapText(true);
			font = wb.createFont();
			font.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
			style.setFont(font);

			String[] cid = colId.split(",");
			Method method = null;
			String value = "";
			for (int indexList = 0; indexList < list.size(); indexList++) {
				row = sheet1.createRow((short) indexList + 1);
				Object obj = list.get(indexList);
				for (int index = 0; index < cid.length; index++) {
					//将Object转换为Map
					Map m = (Map) list.get(indexList);
					value=m.get(cid[index])!=null?m.get(cid[index]).toString():"";
					cell = row.createCell(index);
					cell.setCellStyle(style);
					cell.setCellValue(value);
					sheet1.autoSizeColumn((short) index);
					value = "";
				}
			}
		}

		try {
			wb.write(os);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 导出pdf<br>
	 * <p>
	 * 方法的详述<br>
	 * 
	 * @param 参数
	 *            参数描述
	 * 
	 * @author cjj
	 */
	public static void ExportPdf(List<Object> list, OutputStream os,
			String colId, String colName) {
		Document document = new Document();

		try {
			// open output stream
			PdfWriter.getInstance(document, os);
			// open PDF document
			document.open();
			// set chinese font
			BaseFont bfChinese = BaseFont.createFont("STSong-Light",
					"UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);
			com.lowagie.text.Font font = new com.lowagie.text.Font(bfChinese,
					8, com.lowagie.text.Font.BOLD);

			// process business data
			String[] cid = colId.split(",");
			String[] cname = colName.split(",");
			// create table with columns
			PdfPTable table = new PdfPTable(cid.length);
			// 100% width
			table.setWidthPercentage(100);
			table.setHorizontalAlignment(PdfPTable.ALIGN_LEFT);
			// create cells
			PdfPCell cell = new PdfPCell();
			// set color
			// cell.setBackgroundColor(new Color(213, 141, 69));
			cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
			// set title
			for (int index = 0; index < cname.length; index++) {
				cell.setPhrase(new Paragraph(cname[index], font));
				table.addCell(cell);
			}

			font = new com.lowagie.text.Font(bfChinese, 8,
					com.lowagie.text.Font.NORMAL);
			if (list != null && list.size() > 0) {
				Method method = null;
				String value = "";
				for (int indexList = 0; indexList < list.size(); indexList++) {
					Object obj = list.get(indexList);
					for (int index = 0; index < cid.length; index++) {
						//判断obj是否是Map对象
						if(obj instanceof Map){
							Map m = (Map) obj;
							value=m.get(cid[index])!=null?m.get(cid[index]).toString():"";
						}else{//obj是bean类型
							value = getValue(cid[index], obj);
						}
						cell.setPhrase(new Paragraph(value, font));
						table.addCell(cell);
						value = "";
					}
				}
			}

			document.add(table);
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			document.close();
		}

	}

	/**
	 * 
	 * 对时间或数字进行格式处理<br>
	 * <p>
	 * 方法的详述<br>
	 * 
	 * @param 参数
	 *            参数描述
	 * 
	 * @return String
	 * 
	 * @author cjj
	 */
	public static String getValue(String cid, Object obj) {
		String value = "";
		String methodStr = "";
		Method method = null;

		try {
			if (cid.indexOf("javaRenderer") == -1) {
				int iPoint = cid.indexOf(".");
				if(iPoint!=-1){			// 取出关联实体里的数据 add by zhangpengyu
					String begin = cid.substring(0, iPoint);
					String end = cid.substring(iPoint+1,cid.length());
					String beginMed = "get"+begin.substring(0,1).toUpperCase()+begin.substring(1,begin.length());
					String endMed = "get"+end.substring(0,1).toUpperCase()+end.substring(1,end.length());
					Method bmed = obj.getClass().getMethod(beginMed, null);
					Object fentity = bmed.invoke(obj, null);
					Method emed = fentity.getClass().getMethod(endMed, null);
					value = String.valueOf(emed.invoke(fentity, null));
				}else{
					methodStr = "get" + cid.substring(0, 1).toUpperCase()
							+ cid.substring(1, cid.length());
					method = obj.getClass().getMethod(methodStr, null);
					if (method != null) {
						String typeName = method.getReturnType().getName();
						if (method.invoke(obj, null) == null) {
							value = "";
						} else {
							if (typeName.indexOf("Date") != -1) {
								SimpleDateFormat f = new SimpleDateFormat(
										"yyyy-MM-dd HH:mm:ss");

								value = f.format(method.invoke(obj, null));
							} else {
								value = String.valueOf(method.invoke(obj, null));
							}
						}
					}					
				}
			} else {

				methodStr = cid.split("javaRenderer")[1];
				method = obj.getClass().getMethod(methodStr, null);
				value = String.valueOf(method.invoke(obj, null));
			}
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}

		return value;
	}
	
}
