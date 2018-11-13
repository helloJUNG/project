package org.jj.service;

import java.util.List;

import org.jj.domain.PageParam;
import org.jj.domain.ReplyVO;

public interface ReplyService {
	
	public int register(ReplyVO vo);
	public int remove(PageParam pageParam);
	public int modify(ReplyVO vo);
	public int count(PageParam pageParam);
	public ReplyVO get(PageParam pageParam);
	public List<ReplyVO> getList(PageParam pageParam);

}
