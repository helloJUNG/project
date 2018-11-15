package org.jj.service;

import java.util.List;

import org.jj.domain.PageParam;
import org.jj.domain.ReplyPageDTO;
import org.jj.domain.ReplyVO;
import org.jj.mapper.BoardMapper;
import org.jj.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardMapper boardmapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		
		log.info("register...." + vo);
		
		boardmapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Transactional
	@Override
	public int remove(PageParam pageParam) {
		
		log.info("remove...." + pageParam.getRno());
		
		ReplyVO vo = mapper.read(pageParam);
		boardmapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(pageParam);
	}

	@Override
	public int modify(ReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public int replyCount(PageParam pageParam) {
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

	@Override
	public ReplyPageDTO getListPage(PageParam pageParam) {
		// TODO Auto-generated method stub
		return new ReplyPageDTO(mapper.count(pageParam), mapper.getList(pageParam));
	}

}
