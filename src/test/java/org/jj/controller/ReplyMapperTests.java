package org.jj.controller;

import java.util.stream.IntStream;

import org.jj.domain.PageParam;
import org.jj.domain.ReplyVO;
import org.jj.mapper.ReplyMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

	private int[] bnoArr = {19,18,17,16,15};
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void getList() {
		
		PageParam pageParam = new PageParam();
		pageParam.setBno(150);
		
		log.info(mapper.getList(pageParam));
		
	}
	
	@Test
	public void testCount() {
		
		PageParam pageParam = new PageParam();
		pageParam.setBno(371);
		
		log.info(mapper.count(pageParam));
		
	}
	
	@Test
	public void testUpdate() {
		
		ReplyVO vo = new ReplyVO();
		vo.setRno(1);
		vo.setReply("업데이트됫다123123");
		mapper.update(vo);
		log.info(mapper.update(vo));
	}
	
	@Test
	public void testDelete() {
		
		PageParam pageParam = new PageParam();
		pageParam.setRno(17);
		
		mapper.delete(pageParam);
		
	}
	
	
	@Test
	public void testRead() {
		
		PageParam pageParam = new PageParam();
		
		pageParam.setRno(17);
		
		ReplyVO vo = mapper.read(pageParam);
		
		log.info(vo);
	}
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	@Test
	public void testInsert() {
		
		IntStream.range(1, 250).forEach(i -> {
			
			ReplyVO vo = new ReplyVO();
			
			vo.setBno(379);
			vo.setReply("test" + i);
			vo.setReplyer("zziggu"+i);
			
			mapper.insert(vo);
		});
		
	}
}
