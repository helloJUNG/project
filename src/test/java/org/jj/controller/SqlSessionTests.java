package org.jj.controller;

import static org.junit.Assert.assertNotNull;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class SqlSessionTests extends AbstractTests{

	@Setter(onMethod_=@Autowired)
	private SqlSessionFactory factory;
	
	@Test
	public void test() {
		log.info(factory);
		assertNotNull(factory);
	}
}