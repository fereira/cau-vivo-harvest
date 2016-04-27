package edu.cornell.mannlib.harvester.tools;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
//import org.springframework.util.StringUtils;

import edu.cornell.mannlib.harvester.bo.CauPerson;
import edu.cornell.mannlib.harvester.dao.CauPersonDao;
import edu.cornell.mannlib.harvester.util.CauProperties;
import edu.cornell.mannlib.harvester.util.ObjectUtils;

public class GetCauData {
	
	CauProperties props;
	CauPersonDao cauPersonDao;

	public GetCauData() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		GetCauData app = new GetCauData();
		
		app.run();
	}
	
	protected void run() {
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext("/spring.xml");
        this.props = (CauProperties) applicationContext.getBean("cauProperties");
        this.cauPersonDao = (CauPersonDao) applicationContext.getBean("cauPersonDao");
        System.out.println("Begin...");
        String sql = "SELECT * from vivotest";
        try {
			List<CauPerson> personList = this.cauPersonDao.getCauPersonUsingSQL(sql);
			for (CauPerson person: personList) {
			  //ObjectUtils.printBusinessObject(person);
			   String articlesString = person.getArticle();
			   
			  String[] articles = org.springframework.util.StringUtils.tokenizeToStringArray(articlesString, ";");
			   
			  for (int i=0; i < articles.length ; i++) {
				  String articleStr = articles[i];
				  
				  String[] articleParts = org.springframework.util.StringUtils.tokenizeToStringArray(articleStr, "|");
				  int partsLen = articleParts.length;
				  
				  if (articleParts.length > 4) {
					  System.out.println("title: "+ articleParts[partsLen - 4]);
					  System.out.println("journal: "+ articleParts[partsLen - 3]);
					  System.out.println("year: "+ articleParts[partsLen - 2]);
					  System.out.println("vol: "+ articleParts[partsLen - 1]);
					  StringBuffer authorBuf = new StringBuffer();
					  int auidx = partsLen - 5;
					  for (int j = auidx ; j > -1; j--) {
						  authorBuf.append(articleParts[j] +", ");
					  }
					  System.out.println("authors: "+ StringUtils.removeEnd(authorBuf.toString(), ", "));
				  }
				  System.out.println();
				  
				  
			  } 
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        System.out.println("Done.");
	}
	

}
