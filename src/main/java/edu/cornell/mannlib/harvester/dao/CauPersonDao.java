package edu.cornell.mannlib.harvester.dao;

import java.util.List;

import edu.cornell.mannlib.harvester.bo.CauPerson; 

public interface CauPersonDao {
   public List<CauPerson> getCauPersonUsingSQL(String str) throws Exception;	
}
