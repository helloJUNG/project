package org.jj.controller;

import org.jj.domain.PageParam;
import org.jj.domain.ReplyPageDTO;
import org.jj.domain.ReplyVO;
import org.jj.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/replies")
@Log4j
public class ReplyController {

	@Setter(onMethod_=@Autowired)
	private ReplyService service;
	
	//�뙎湲��벑濡�
	@PostMapping(value="/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		
		log.info("ReplyVO: " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT: " + insertCount);
				
		return insertCount == 1? new ResponseEntity<>("success",HttpStatus.OK)
									: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//由ъ뒪�듃異쒕젰
	@PreAuthorize("isAuthenticated()")
	@GetMapping(value="/pages/{bno}/{page}",
				produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page")int page,@PathVariable("bno")int bno){
		
		log.info("get reply list.....");
		
		PageParam pageParam = new PageParam();
		pageParam.setPage(page);
		pageParam.setBno(bno);
		
		return new ResponseEntity<>(service.getListPage(pageParam),HttpStatus.OK);
	}
	
	//Get
	@GetMapping(value="/{rno}",
				produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno")int rno){
		
		log.info("get: " + rno);
		
		PageParam pageParam = new PageParam();
		pageParam.setRno(rno);		
		
		return new ResponseEntity<>(service.get(pageParam), HttpStatus.OK);
	}
	
	//delete
	@DeleteMapping(value="/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno")int rno){
		
		log.info("remove: " + rno);
		
		PageParam pageParam = new PageParam();
		pageParam.setRno(rno);		
		
		int result = service.remove(pageParam);
		return result == 1? new ResponseEntity<>("success",HttpStatus.OK)
							:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	//modify
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value="/{rno}",
					consumes="application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno")int rno){
		
		vo.setRno(rno);
		log.info("rno: " + rno);
		log.info("modify: " + vo);
		
		int result = service.modify(vo);
		
		return result == 1? new ResponseEntity<>("success",HttpStatus.OK)
							:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
