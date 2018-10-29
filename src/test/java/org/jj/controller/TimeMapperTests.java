package org.jj.controller;

import org.jj.mapper.BoardMapper;
import org.jj.mapper.TimeMapper;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class TimeMapperTests extends AbstractTests{
	
	@Setter(onMethod_=@Autowired)
	private TimeMapper timemapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardMapper boardMapper;
	
	@Test
	public void getTimetest() {
		
		log.info(timemapper.getTime());
	}
	
	

}
