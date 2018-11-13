package org.jj.domain;



import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class PageParam {

	private int start,end,total,bno,rno;
	private int display,page;
	private double per;

	private boolean prev, next;
	
	private String type;
	private String types[];
	private String keyword;

	public PageParam() {

		this.page = 1;
		this.display = 10;
		this.per = 10.0;
	}

	public void setTotal(int total) {

		this.total = total;
		this.end = (int)(Math.ceil(this.page / this.per)) * this.display;
		this.start = this.end - this.display + 1;
		

		if (this.end * this.display >= total) {
			this.end = (int)(Math.ceil(this.total / this.per));
			this.next = false;
		} else {
			this.next = true;
		}
		this.prev = this.start != 1;
	}

	public int getSkip() {

		return (this.page - 1) * this.display;
	}

	public void setDisplay(int display) {

		this.display = display;
		this.per = (double) display;

	}

	public int getDisplay() {

		return this.display;
	}

	public String getLink(String path) {

		return UriComponentsBuilder.fromPath(path)
				.queryParam("bno", this.bno).queryParam("page", this.page)
				.queryParam("type", this.type).queryParam("keyword",this.keyword).queryParam("display", this.display)
				.toUriString();
	}
	
	public void setType(String type) {
		
		this.type = type;
		if(type == null || type.trim().length() == 0) {
			
			this.types = null;
			return;
		}
		this.types = type.split("");
	}
}
