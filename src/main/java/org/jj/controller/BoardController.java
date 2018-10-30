package org.jj.controller;

import org.jj.domain.Board;
import org.jj.domain.PageParam;
import org.jj.service.BoardService;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@PostMapping("/remove")
	public String remove(PageParam pageParam, RedirectAttributes rttr) {
		log.info("remove--------------------------------------------");
		log.info(pageParam.getBno());
		
		int result = service.remove(pageParam);
		
		rttr.addFlashAttribute("result", result == 1? "SUCCESS":"FAIL");
		
		return "redirect:/board/list?page=" + pageParam.getPage();
	}
	
	@PostMapping("/modify")
	public String modify(Board board, PageParam pageParam, RedirectAttributes rttr) {
		
		int result = service.modify(board);
		
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
		
		int result = service.register(board);
				
		rttr.addAttribute("result", result == 1? "SUCCESS":"FAIL");		
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/list")
	public void getList(@ModelAttribute("pageObj")PageParam pageParam, Model model){
		
		
		model.addAttribute("list",service.getList(pageParam));	
	}
	
}
