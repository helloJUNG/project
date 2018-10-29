package org.jj.controller;

import org.jj.domain.Board;
import org.jj.mapper.BoardMapper;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class BoardMapperTests extends AbstractTests {

	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	
	
	
	
	@Test
	public void testInsert() {
		
		Board vo = new Board();
		
		vo.setTitle("찌꾸신");
		vo.setContent("나는찌꾸");
		vo.setWriter("코뿔소사육사");
		
		mapper.insert(vo);
	}
	

	
	@Test
	public void testModify() {
		
		Board vo = new Board();
		
		vo.setBno(5);
		vo.setTitle("정의의찌꾸");
		vo.setContent("화려한찌꾸");
		vo.setWriter("atree");
		log.info(mapper.modify(vo));
	}
}
