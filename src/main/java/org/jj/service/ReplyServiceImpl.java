package org.jj.service;

import java.util.List;

import org.jj.domain.PageParam;
import org.jj.domain.ReplyVO;
import org.jj.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.insert(vo);
	}

	@Override
	public int remove(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.delete(pageParam);
	}

	@Override
	public int modify(ReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public int count(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.count(pageParam);
	}

	@Override
	public ReplyVO get(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.read(pageParam);
	}

	@Override
	public List<ReplyVO> getList(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.getList(pageParam);
	}

}
