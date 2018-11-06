package org.jj.controller;



import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.jj.domain.Board;
import org.jj.domain.BoardAttachVO;
import org.jj.domain.PageParam;
import org.jj.service.BoardService;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RequestMapping("/board/*")
@Log4j
public class BoardController {

	@Setter(onMethod_=@Autowired)
	private BoardService service;
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("delete attach files....");
		log.info(attachList);
		
		attachList.forEach(attach ->{
			
			Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
			
			try {
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					
					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					
					Files.delete(thumbNail);
					
				}
				
			} catch (Exception e) {
				
				log.error("delete file error" + e.getMessage());
				
				e.printStackTrace();
			}
			
			
		});// end forEach
		
	}
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(int bno){
		
		log.info("getAttachList: " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") int bno, RedirectAttributes rttr,PageParam pageParam) {
		log.info("remove--------------------------------------------");
		log.info(pageParam.getBno());
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if(service.remove(pageParam) == 1) {
		
			int result = service.remove(pageParam);
			
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", result == 1? "SUCCESS":"FAIL");
		}
		return "redirect:/board/list?page=" + pageParam.getPage()+"&display="+pageParam.getDisplay();
	}
	
	@PostMapping("/modify")
	public String modify(RedirectAttributes rttr,Board board, PageParam pageParam) {
		
		int result = service.modify(board);
		log.info(pageParam);
		rttr.addFlashAttribute("result", result == 1? "SUCCESS":"FAIL");
		
		return pageParam.getLink("redirect:/board/read");
	}
	
	
	@GetMapping({"/read","/modify"})
	public void read(@ModelAttribute("pageObj")PageParam pageParam, Model model) {
		
		model.addAttribute("board", service.read(pageParam));
		
	}
	
	@GetMapping("/register")
	public void registerGet() {
		
	}
	
	@PostMapping("/register")
	public String register(Board board, RedirectAttributes rttr) {
		
		log.info("===================================");
		
		log.info("register:" +board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach-> log.info(attach));
		}
		
		log.info("===================================");
		
		
		int result = service.register(board);
		
		log.info(result);
		
		rttr.addAttribute("result", result == 1? "SUCCESS":"FAIL");		
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/list")
	public void getList(@ModelAttribute("pageObj")PageParam pageParam, Model model){
		
		log.info("total: "+ service.getTotal());
		pageParam.setTotal(service.getTotal());
		
		log.info("page:  " + pageParam);
		
		model.addAttribute("list",service.getList(pageParam));	
	}
	
}
