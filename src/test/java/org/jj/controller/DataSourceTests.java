package org.jj.controller;

import javax.sql.DataSource;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.extern.log4j.Log4j;

@Log4j
public class DataSourceTests extends AbstractTests{
	
	@Autowired
	private DataSource ds;
	
	@Test
	public void testConnection()throws Exception {
		log.info(ds.getConnection());
	}
	
	

}
