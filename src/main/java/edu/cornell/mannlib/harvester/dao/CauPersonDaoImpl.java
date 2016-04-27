package edu.cornell.mannlib.harvester.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import edu.cornell.mannlib.harvester.bo.CauPerson; 

public class CauPersonDaoImpl implements CauPersonDao {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	protected DataSource dataSource;
	protected JdbcTemplate jdbcTemplate;
	
	public CauPersonDaoImpl() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * @return
	 */
	public DataSource getDataSource() {
		return dataSource;
	}
	
	/**
	 * @param dataSource
	 */
	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	@Override
	public List<CauPerson> getCauPersonUsingSQL(String sql) throws Exception { 
		try {
	    	  List<CauPerson> documentList = this.jdbcTemplate.query(sql, new CauPersonMapper());
	         return documentList;
	      } catch (EmptyResultDataAccessException ex) {
	         logger.info("Empty result set");
	         logger.info("Query was: "+ sql);
	         return null;
	      } catch (Exception ex) {
	         logger.error("Exception: "+ ex);
	         logger.error("Query was: "+ sql);
	         throw ex;
	      }

	}
	
	@SuppressWarnings("rawtypes")
	private static final class CauPersonMapper implements RowMapper {
		public CauPerson mapRow(ResultSet rs, int rowNum) throws SQLException {
			CauPerson cauPerson = new CauPerson();
			cauPerson.setPersonId(rs.getString("number"));
			cauPerson.setName(rs.getString("name"));
		    cauPerson.setSex(rs.getString("sex"));
		    cauPerson.setPhoto(rs.getString("photo"));
		    cauPerson.setPosition(rs.getString("position"));
		    cauPerson.setDaoshitype(rs.getString("daoshitype"));
		    cauPerson.setYuanshi1(rs.getString("yuanshi1"));
		    cauPerson.setYuanshi1(rs.getString("yuanshi2"));
		    cauPerson.setXuewei(rs.getString("xuewei"));
		    cauPerson.setXueke(rs.getString("xueke"));
		    cauPerson.setZhuanye(rs.getString("zhuanye"));
		    cauPerson.setFangxiang(rs.getString("fangxiang"));
		    cauPerson.setUniversity(rs.getString("university"));
		    cauPerson.setXueyuan(rs.getString("xueyuan"));
		    cauPerson.setA1(rs.getString("a1"));
		    cauPerson.setA2(rs.getString("a2"));
		    cauPerson.setProject(rs.getString("project"));
		    cauPerson.setBooks(rs.getString("books"));
		    cauPerson.setArticle(rs.getString("article"));
		    cauPerson.setCurse(rs.getString("curse"));
		    cauPerson.setWebsite(rs.getString("website"));
		    cauPerson.setAddress(rs.getString("address"));
		    cauPerson.setPhone(rs.getString("phone"));
		    cauPerson.setEmail(rs.getString("email")); 
			
			return cauPerson;
		}
	} 
	
}
