package org.jj.service;

import java.util.List;

import org.jj.domain.Board;
import org.jj.domain.PageParam;
import org.jj.mapper.BoardMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;
	
	@Override
	public List<Board> getList(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.getList(pageParam);
	}

	@Override
	public int remove(PageParam pageParam) {
		// TODO Auto-generated method stub
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

	@Override
	public int register(Board board) {
		// TODO Auto-generated method stub
		return mapper.insert(board);
	}

	@Override
	public int count(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.count(pageParam);
	}

}
