package edu.cornell.mannlib.harvester.tools;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.NumberFormat;
import jxl.write.NumberFormats;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.Number; 

import org.apache.commons.lang.StringUtils; 
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import edu.cornell.mannlib.harvester.bo.CauPerson;
import edu.cornell.mannlib.harvester.dao.CauPersonDao;
import edu.cornell.mannlib.harvester.util.CauProperties;
import edu.cornell.mannlib.harvester.util.MiscUtils;
 
public class ExportCAUToExcel {
	
   private static CauProperties props; 
   private final int NUMBER = 0;
   private final int ORCID = 1;
   private final int NAME = 2;
   private final int SEX = 3;
   private final int PHOTO = 4;
   private final int POSITION = 5;
   private final int DAOSHITYPE = 6;
   private final int YUANSHI1 = 7;
   private final int YUANSHI2 = 8;
   private final int XUEWEI = 9;
   private final int XUEKE = 10;
   private final int ZHUANYE = 11;
   private final int FANAXIANG = 12;
   private final int UNIVERSITY = 13;
   private final int XUEYUAN = 14;
   private final int A1 = 15;
   private final int A2 = 16;
   private final int PROJECT = 17;
   private final int BOOKS = 18;
   private final int ARTICLE = 19;
   private final int CURSE = 20;
   private final int WEBSITE = 21;
   private final int ADDRESS = 22;
   private final int PHONE = 23;
   private final int EMAIL = 24;
   
   private CauPersonDao cauPersonDao;
	 
    
    public ExportCAUToExcel() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ExportCAUToExcel app = new ExportCAUToExcel();
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext("/spring.xml");
        props = (CauProperties) applicationContext.getBean("cauProperties");
		app.run();
	}
	
	public void run() {
		 
		int currentID = 0;
		System.out.println("Creating spreadsheet of document value chain values");
		try {
			
			WritableWorkbook workbook = Workbook.createWorkbook(new File(props.getCauHome()
					+ "/support/caudata-"
					+ MiscUtils.getFormattedDate() + ".xls"));
			WritableSheet sheet = workbook.createSheet("First Sheet", 0);
			
			WritableFont arial10font = new WritableFont(WritableFont.ARIAL, 10); 
			WritableCellFormat cellFormat = new WritableCellFormat (arial10font);
			 

			sheet.addCell(new Label(0, 0, "Docid"));
			sheet.addCell(new Label(1, 0, "Title"));
			sheet.addCell(new Label(2, 0, "Value Chain"));

			List<CauPerson> cauPersons = new ArrayList<CauPerson>();

			int row = 1;

			String sql = "SELECT * from vivotest";
			cauPersons = this.cauPersonDao.getCauPersonUsingSQL(sql);

			for (CauPerson cauPerson : cauPersons) {
				String docId = String.valueOf(cauPerson.getPersonId());
				sheet.addCell(new Label(0, row, docId));
				sheet.addCell(new Label(1, row, cauPerson.getName())); 
				row = row + 1;

			}

			// All sheets and cells added. Now write out the workbook
			workbook.write();
			workbook.close();
			
		} catch (Exception e) {
			System.err.println("Exception while reading: "+ currentID);
			e.printStackTrace();
		}
		
		System.out.println("Done.");  
	    
	}
	
	
	
	
	
	
}
