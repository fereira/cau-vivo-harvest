package edu.cornell.mannlib.harvester.util;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Field; 
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map; 
import java.util.regex.Matcher;
import java.util.regex.Pattern;
 
import org.apache.commons.lang.StringUtils; 
public class MiscUtils {
	
	 
   /** Logger for this class and subclasses */
   //protected final Log logger = LogFactory.getLog(getClass());  
   
   
	public MiscUtils() {
		// TODO Auto-generated constructor stub
	}
	
	 
	
	 
	public static boolean isNumeric(String str)	{
	    for (char c : str.toCharArray())  {
	        if (!Character.isDigit(c)) return false;
	    }
	    return true;
	}
	
	public static boolean isDecimal(String str) {
	   //if (StringUtils.countOccurrencesOf(str, ".") == 0) return false;
	 
	   if (StringUtils.countMatches(str, ".") == 0) return false;
	   try {
		 Double.parseDouble(str);
		 return true;
	   } catch (NumberFormatException ex) {
		   return false;
	   }
		 
	}
	
	public static boolean isValidRoman(String num) {
	   num = num.toUpperCase();
       //		    Checks each character if it is one of I, V, , L, C, D, M (Roman characters)
	   for (int k = 0; k < num.length(); k++) {
	        if (num.charAt(k) != 'I' &&
	                num.charAt(k) != 'V' &&
	                num.charAt(k) != 'X' &&
	                num.charAt(k) != 'L' &&
	                num.charAt(k) != 'C' &&
	                num.charAt(k) != 'D' &&
	                num.charAt(k) != 'M') {
	            return false;
	        }
	    }
	    return true;
	}
	
	 

	
	public static List<String> removeDuplicates(List<String> l1) {

		ArrayList<String> l2 = new ArrayList<String>();

		Iterator<String> iterator = l1.iterator();

		while (iterator.hasNext()) {
			String s = iterator.next();
			if (!l2.contains(s))
				l2.add(s);
		}
		return l2;
	}
	
	public static String getFormattedDate() {
	      String s = null;
	      Calendar today = Calendar.getInstance();
	      s = new SimpleDateFormat("yyyy-MM-dd").format(today.getTime());
	      return s;
	}
	
	public static String normalizePubdate(String pubdate) {
		  // pubdate comes in as 2012-12-11T15:37:16Z
		  Calendar cal = Calendar.getInstance();
		  SimpleDateFormat isdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		  SimpleDateFormat osdf = new SimpleDateFormat("MMMM dd, yyyy");
		  try {
			cal.setTime(isdf.parse(pubdate));
			return osdf.format(cal.getTime());
		  } catch (ParseException e) {
			return pubdate;
		  }// all done
	  }
	
	public static String extractYear(String str) {
		Pattern p = Pattern.compile("(\\d{4})");
		Matcher m = p.matcher(str);

		if (m.find()) {
		    return  m.group(1);
		} else {
			return "";
		}
	}
	
	public static String getStackTraceAsString(Exception ex) {
		StringWriter errors = new StringWriter();
		ex.printStackTrace(new PrintWriter(errors));
		return errors.toString();
	}
	
	public static Object replaceNullFieldWithEmptyString(Object obj) {
		Field[] fields = obj.getClass().getDeclaredFields();
        String str = new String();
		for (int i = 0; i < fields.length; i++) {
			Field field = fields[i];
			try {
				field.setAccessible(true);
				if (field.getType().isInstance(str) && field.get(obj) == null) {                 
				   //System.out.println(field.getName() + ": " + field.getType());
				   field.set(obj, "");
                }
			} catch (NullPointerException | IllegalArgumentException | IllegalAccessException e) {
				e.printStackTrace();
			}

		}
		return obj;
	}
	
    public static String convertAkiAuthor(String author) {
		
		StringBuffer sb = new StringBuffer();
		String[] authorsArray = StringUtils.split(author, '|');
		for (int i=0; i < authorsArray.length; i++) {
	       	  
		   String[] authArray = StringUtils.split(authorsArray[i], ',');
		   String lastName = authArray[0];
		    
		   if (authArray.length < 2) {
			   sb.append(lastName);
			   sb.append(", ");
		   } else {
			  sb.append(lastName); 
		      String[] firstNameArray = StringUtils.split(StringUtils.replace(authArray[1], "-", " "), ' ');
		      for (int j=0; j < firstNameArray.length ; j++) {
		    	  if (firstNameArray[j].equalsIgnoreCase("JR") || firstNameArray[j].equalsIgnoreCase("SR")) {
		    		  sb.append("-"+ firstNameArray[j]);
		    	  } else {
			         sb.append("-"+ firstNameArray[j].substring(0,1).toUpperCase());
		    	  }
		      }
		      sb.append(", ");
		   }
		}
		return StringUtils.removeEnd(sb.toString(), ", ");
	}
    
    public static String convertTeealAuthor(String author) {
		
		StringBuffer sb = new StringBuffer();
		if (! StringUtils.contains(author, "|")) return author;
		String[] authorsArray = StringUtils.split(author, '|');
		for (int i=0; i < authorsArray.length; i++) {
	       	  
		   String[] authArray = StringUtils.split(authorsArray[i], ',');
		   String lastName = authArray[0];
		    
		   if (authArray.length < 2) {
			   sb.append(lastName);
			   sb.append(", ");
		   } else {
			  sb.append(lastName); 
		      String[] firstNameArray = StringUtils.split(StringUtils.replace(authArray[1], "-", " "), ' ');
		      for (int j=0; j < firstNameArray.length ; j++) {
		    	  if (firstNameArray[j].equalsIgnoreCase("JR") || firstNameArray[j].equalsIgnoreCase("SR")) {
		    		  sb.append("-"+ firstNameArray[j]);
		    	  } else {
			         sb.append("-"+ firstNameArray[j].substring(0,1).toUpperCase());
		    	  }
		      }
		      sb.append(", ");
		   }
		}
		return StringUtils.removeEnd(sb.toString(), ", ");
	}

   public static String fixGreek(String str) {
	   final Map<String, String> greekmap = new HashMap<String, String>();
	   greekmap.put("alpha", "α");
	   greekmap.put("beta", "β");
	   greekmap.put("gamma", "γ");
	   greekmap.put("delta", "δ");
	   greekmap.put("DELTA", "Δ");
	   greekmap.put("epsilon", "ε");
	   greekmap.put("theta", "θ");
	   greekmap.put("phi", "φ");
	   greekmap.put("PHI", "Φ");
	   greekmap.put("psi", "ψ");
	   greekmap.put("chi", "χ");
	   greekmap.put("eta", "η");
	   greekmap.put("iota", "ι");
	   greekmap.put("kappa", "κ");
	   greekmap.put("KAPPA", "Κ");
	   greekmap.put("lambda", "λ");
	   greekmap.put("mu", "μ");
	   greekmap.put("pi", "π");
	   greekmap.put("rho", "π");
	   greekmap.put("sigma", "σ");
	   greekmap.put("tau", "τ");
	   greekmap.put("omega", "ω"); 
	   greekmap.put("zeta", "ζ");
	   
	   String s = str.replaceAll("@a", greekmap.get("alpha"));
	   s = s.replaceAll("@b", greekmap.get("beta"));
	   s = s.replaceAll("@c", greekmap.get("gamma"));
	   s = s.replaceAll("@D", greekmap.get("DELTA"));
	   s = s.replaceAll("@d", greekmap.get("delta"));
	   s = s.replaceAll("@e", greekmap.get("epsilon"));
	   s = s.replaceAll("@f", greekmap.get("phi"));
	   s = s.replaceAll("@F", greekmap.get("PHI"));
	   s = s.replaceAll("@g", greekmap.get("chi"));
	   s = s.replaceAll("@j", greekmap.get("psi"));
	   s = s.replaceAll("@h", greekmap.get("eta"));
	   s = s.replaceAll("@i", greekmap.get("iota"));
	   s = s.replaceAll("@k", greekmap.get("kappa"));
	   s = s.replaceAll("@K", greekmap.get("KAPPA"));
	   s = s.replaceAll("@l", greekmap.get("lambda"));
	   s = s.replaceAll("@m", greekmap.get("mu"));
	   s = s.replaceAll("@p", greekmap.get("pi"));
	   s = s.replaceAll("@q", greekmap.get("theta"));
	   s = s.replaceAll("@r", greekmap.get("rho"));
	   s = s.replaceAll("@s", greekmap.get("sigma"));
	   s = s.replaceAll("@t", greekmap.get("tau"));
	   s = s.replaceAll("@w", greekmap.get("omega")); 
	   s = s.replaceAll("@z", greekmap.get("zeta")); 
	   
	   return s;
	}
   
	 
	
	public static String getFormatedElapsedTime(long start, long end) {
		long elapsedTime = end - start;
	     
	    int seconds = (int) (elapsedTime / 1000L);
	    int minutes = seconds / 60;
	    seconds -= minutes * 60;
	    int hours = minutes / 60;
	    minutes -= hours * 60;
	     
	    if (hours > 0) {
	        return String.format("%2d Hours %02d Minutes %02d Seconds", hours, minutes, seconds );
	    } else if (minutes > 0) {
	        return String.format("%2d Mintues, %02d Seconds", minutes, seconds );
	    } else {
	        return String.format("%2d Seconds", seconds );
	    }
	}

}
