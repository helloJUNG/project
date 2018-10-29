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

@Controller
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RequestMapping("/board/*")
public class BoardController {

	@Setter(onMethod_=@Autowired)
	private BoardService service;
	
	
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
	public void getList(@ModelAttribute("pagObj")PageParam pageParam, Model model){
		
		
		model.addAttribute("list",service.getList(pageParam));	
	}
	
}
