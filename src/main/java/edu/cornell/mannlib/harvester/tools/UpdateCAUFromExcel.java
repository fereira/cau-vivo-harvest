package edu.cornell.mannlib.harvester.tools;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List; 
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import jxl.Cell;
import jxl.CellType;
import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.read.biff.BiffException;
import edu.cornell.mannlib.harvester.dao.CauPersonDao;
import edu.cornell.mannlib.harvester.util.CauProperties; 

public class UpdateCAUFromExcel {
   private static CauProperties props;
   private String inputFile;
   private final int DOCID = 0;
   private final int TITLE = 1;
   private final int PUBDATE = 2;
   private final int AUTHORS = 3;
   private final int AUTHOR_AFFILIATION = 4;
   private final int AUTHOR_EMAIL = 5;
   private final int ORGANIZAIONAL_AUTHOR_LOCATION = 6;
   private final int FUNDEDBY = 7;
   private final int FILENAME = 8;
   
   CauPersonDao cauPersonDao;
   public void setInputFile(String inputFile) {
      this.inputFile = inputFile;
   }

   public String getInputFile() {
      return this.inputFile;
   }


   public static void main(String[] args) {
      UpdateCAUFromExcel app = new UpdateCAUFromExcel();
      ApplicationContext applicationContext = new ClassPathXmlApplicationContext("/spring.xml");
      props = (CauProperties) applicationContext.getBean("cauProperties");
      app.setInputFile(props.getCauHome() +"/support/cau-data.xls");
      
      
      try {
          
         
         Map<String, String> fundingMap = app.read();
         Iterator  iter = fundingMap.keySet().iterator();
         while (iter.hasNext()) {
            String docid = (String) iter.next();	 
        	String fundedBy = fundingMap.get(docid);
        	 
            System.out.println(docid +": "+fundedBy);
             
         }
          
      } catch (IOException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } catch (Exception e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      

  }

  

   public Map<String, String> read() throws IOException  {
	  System.out.println("reading: "+ inputFile);
      File inputWorkbook = new File(inputFile);
      Workbook w;
      WorkbookSettings settings = new WorkbookSettings();
      settings.setEncoding("Cp1252");
      Map<String, String> fundingmap = new HashMap<String, String>();
      try {
         //w = Workbook.getWorkbook(inputWorkbook);
         
         w = Workbook.getWorkbook(inputWorkbook, settings);
         // Get the first sheet
         Sheet sheet = w.getSheet(0);
         for (int row = 1; row < sheet.getRows(); row++) {              
             String docid = getCellContents(sheet.getCell(DOCID, row));
             String values = getCellContents(sheet.getCell(FUNDEDBY, row)); 
             fundingmap.put(docid, values);
          }
      } catch (BiffException e) {
         e.printStackTrace();
         return null;
      }
      return fundingmap;
   }
   
   

   
   
   public static String getCellContents(Cell cell) {
      if (cell.getType() == CellType.LABEL) {    	  
         return cell.getContents();
      } else if (cell.getType() == CellType.NUMBER) {
         return cell.getContents();
      } else {
         return "";
      }
   }

}

