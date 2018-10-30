package org.jj.mapper;

import java.util.List;

import org.jj.domain.Board;
import org.jj.domain.PageParam;

public interface BoardMapper {

	public List<Board> getList(PageParam pageParam);
	
	public Board get(PageParam pageParam); 
	
	public int insert(Board board);
	
	public int delete(PageParam pageParam);
	
	public int modify(Board board);
	
	public int count();


}