package org.jj.mapper;

import java.util.List;

import org.jj.domain.PageParam;
import org.jj.domain.ReplyVO;

public interface ReplyMapper {
	
	public int insert(ReplyVO vo);
	
	public ReplyVO read(PageParam pageParam);
	
	public int delete(PageParam pageParam);
	
	public int update(ReplyVO vo);
	
	public int count(PageParam pageParam);
	
	public List<ReplyVO> getList(PageParam pageParam);

}
