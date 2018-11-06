package org.jj.service;

import java.util.List;

import org.jj.domain.Board;
import org.jj.domain.BoardAttachVO;
import org.jj.domain.PageParam;
import org.jj.mapper.BoardAttachMapper;
import org.jj.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	
	@Override
	public List<Board> getList(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.getList(pageParam);
	}

	@Transactional
	@Override
	public int remove(PageParam pageParam) {
		
		attachMapper.deleteAll(pageParam.getBno());
		
		return mapper.delete(pageParam);
	}

	@Override
	public int modify(Board board) {
		// TODO Auto-generated method stub
		return mapper.modify(board);
	}

	@Override
	public Board read(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.get(pageParam);
	}

	@Transactional
	@Override
	public int register(Board board) {
		
		int result = mapper.insert(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return result;
		}
		board.getAttachList().forEach(attach->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
		
		return result;
	}

	@Override
	public int getTotal() {
		// TODO Auto-generated method stub
		return mapper.count();
	}

	@Override
	public List<BoardAttachVO> getAttachList(int bno) {
		
		return attachMapper.findByBno(bno);
	}

}
