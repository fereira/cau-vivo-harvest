package edu.cornell.mannlib.harvester.xslt;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ParseArticle {
	protected final static Log logger = LogFactory.getLog(ParseArticle.class);
	public ParseArticle() {
		// TODO Auto-generated constructor stub
	}
	
	public static String getTitle(String articleStr) {

		String title = new String();

		String[] articleParts = org.springframework.util.StringUtils.tokenizeToStringArray(articleStr, "|");
		int partsLen = articleParts.length;
        try {
		   if (articleParts.length > 3) {
			  title = articleParts[partsLen - 4];
		   } 
        }  catch (Exception e) {
		   logger.error("could not parse article: partsLen="+ partsLen);  	
		}
         

		return title;
	}
	
	public static String getArticleYear(String articleStr) {

		String year = new String();

		String[] articleParts = org.springframework.util.StringUtils.tokenizeToStringArray(articleStr, "|");
		int partsLen = articleParts.length;
        try {
		   if (articleParts.length > 1) {
			  year = articleParts[partsLen -2 ];
		   }
        }  catch (Exception e) {
 		   logger.error("could not parse article: partsLen="+ partsLen);  	
 		}
		return year;
	}
	
	public static String getAuthors(String articleStr) {

		String authors = new String();

		String[] articleParts = org.springframework.util.StringUtils.tokenizeToStringArray(articleStr, "|");
		int partsLen = articleParts.length;
        try {
			if (articleParts.length > 4) {
				
				 
				StringBuffer authorBuf = new StringBuffer();
				int auidx = partsLen - 5;
				for (int j = auidx; j > -1; j--) {
					authorBuf.append(articleParts[j] + ", ");
				}
				authors = StringUtils.removeEnd(authorBuf.toString(), ", "); 
			}
	    }  catch (Exception e) {
		   logger.error("could not parse article: partsLen="+ partsLen);  	
		}

		return authors;
	}
	
	public static String getJournalTitle(String articleStr) {

		String journalTitle = new String();

		String[] articleParts = org.springframework.util.StringUtils.tokenizeToStringArray(articleStr, "|");
		int partsLen = articleParts.length;
        try {
		   if (articleParts.length > 2) {
			  journalTitle = articleParts[partsLen - 3];
		   }
        }  catch (Exception e) {
 		   logger.error("could not parse article: partsLen="+ partsLen);  	
 		}
		return journalTitle;
	}
	 

}
