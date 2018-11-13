<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<style>
.li data-page{
	background-color: gray;
}
#asd{
	float:right;
}
</style>
<!-- row -->
<div class="row tm-content-row tm-mt-big">

	<div class="col-xl-12 col-lg-12 tm-md-12 tm-sm-12 tm-col">
		<div class="bg-white tm-block h-100">
			<div class="row">
				<div class="col-md-12 col-sm-12">
					<h2 class="tm-block-title d-inline-block">Board</h2>
					  <div class="input-group mb-3"> 
					  	<label for="category" class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">select list amount</label>
						<select name="display" class="custom-select col-xl-3 col-lg-3 col-md-3 col-sm-3" id="category">
						  <option value="10"<c:out value="${pageObj.display == 10 ?'selected':'' }"/>>10-list in this page</option>
						  <option value="20"<c:out value="${pageObj.display == '20'?'selected':'' }"/>>20-list</option>
						  <option value="50"<c:out value="${pageObj.display == '50'?'selected':'' }"/>>50-list</option>
						</select> 
						<input type='hidden' name='display' value="${pageObj.display}">
					</div>
				</div>

				<div class="col-md-4 col-sm-12 text-right" id='asd'>
					<a href="/board/register" class="btn btn-danger">Register</a>
				</div>
			</div>
			<div class="table-responsive">
				<table
					class="table table-hover table-striped tm-table-striped-even mt-3">
					<thead>
						<tr class="tm-bg-gray">
							<th scope="col">&nbsp;</th>
							<th scope="col" class="text-center">bno</th>
							<th scope="col" class="text-center">title</th>
							<th scope="col" class="text-center">writer</th>
							<th scope="col" class="text-center">hit</th>
							<th scope="col" class="text-center">regdate</th>
							<th scope="col" class="text-center">updatedate</th>
							<th scope="col">&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="board">
							<tr>
								<th scope="row"><input type="checkbox"
									aria-label="Checkbox"></th>
								<td class="text-center"><c:out value="${board.bno}"></c:out></td>
								<td class="text-center"><a href="${board.bno}"
									class="board"><c:out value="${board.title}" /></a></td>
								<td class="text-center"><c:out value="${board.writer}"></c:out></td>
								<td class="text-center">0</td>
								<td class="text-center"><fmt:formatDate
										pattern="yyyy-MM-dd hh:mm:ss" value="${board.regdate}" /></td>
								<td class="text-center"><fmt:formatDate
										pattern="yyyy-MM-dd hh:mm:ss" value="${board.updatedate}" /></td>
								<td>
									<div>
										<button class="fas fa-trash-alt tm-trash-icon"></button>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
				<div class="input-group mb-3">
					<select name="type" class="custom-select col-xl-9 col-lg-8 col-md-8 col-sm-7">
						<option <c:out value="${pageObj.type == null?'selected':'' }"/>>--</option>
						<option value="t"<c:out value="${pageObj.type == 't'?'selected':'' }"/>>제목</option>
						<option value="c"<c:out value="${pageObj.type == 'c'?'selected':'' }"/>>내용</option>
						<option value="w"<c:out value="${pageObj.type == 'w'?'selected':'' }"/>>작성자</option>
						<option value="tc"<c:out value="${pageObj.type == 'tc'?'selected':'' }"/>>제목+내용</option>
						<option value="tcw"<c:out value="${pageObj.type == 'tcw'?'selected':'' }"/>>제목+내용+작성자</option>
					</select> 
					<input type='text' name='keyword' value="${pageObj.keyword}" class="form-control validate col-xl-9 col-lg-8 col-md-8 col-sm-7">
					<button class="btn btn-danger" id="searchBtn">Search</button>
				</div>	
	
		 <div class="tm-table-mt tm-table-actions-row justify-content-center">
				<ul class="pagination tm-pagination">
					<c:if test="${pageObj.prev}">
						<li class="page-item active">
						  <a class="page-link" href="${pageObj.start-1}">Prev</a>
						</li>
					</c:if>

					<c:forEach begin="${pageObj.start}" end="${pageObj.end}" var="num">
						<li class="page-item" data-page='${num}'>
						  <a class="page-link" href="${num}"><c:out value="${num}"/></a>
						</li>
					</c:forEach>

					<c:if test="${pageObj.next}">
						<li class="page-item">
						  <a class="page-link" href="${pageObj.end+1}">Next</a>
						  
						  
						</li>
					</c:if>
				</ul>
			</div> 
			
		</div>
	</div>
</div>

<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel"></h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
<form id="actionForm">
	<input type="hidden" name="page" id="page" value="${pageObj.page}">
	<input type="hidden" name="keyword" id="keyword" value="${pageObj.keyword}" >
	<input type="hidden" name="type" id ="type" value="${pageObj.type}">
	<input type="hidden" name="display" id="display" value="${pageObj.display}">
</form>	


<%@include file="../includes/footer.jsp"%>

<script>
$(document).ready(function(){
	
	var actionForm = $("#actionForm");
	var pageNum = ${pageObj.page};
		
	$(".board").on("click",function(e){
		
		e.preventDefault();
		
		var bno = $(this).attr("href");
		actionForm.append("<input type='hidden' name='bno' value='"+bno+"'>");
		actionForm.attr("action","/board/read").attr("method","get").submit();
		
	});
	


	$('.pagination tm-pagination li[data-page ='+pageNum+']').addClass("active");
		
	$('.page-link').on("click",function(e){
			
			e.preventDefault();
			var target = $(this).attr("href");
			console.log(target);
			$("#page").val(target);
			actionForm.attr("action","/board/list").attr("method","get").submit();
		
	  }); 
		 
	var result = '<c:out value="${result}"/>';
	console.log(result);
	var msg = $("#myModal");
					
	checkModal(result);
	history.replaceState({},null,null);
					
	function checkModal(result){
						
		if(result === '' || history.state){
			return;	
		
		}
						
		if (result === 'SUCCESS') {
			$(".modal-body").html("작업성공!");
			msg.modal('show');
						
		}		
	}
	
	
	
	$("#searchBtn").on("click",function(e){
		
		var searchTypeValue =$("select[name='type'] option:selected").val();
		var searchKeyword = $("input[name='keyword']").val();
		
		console.log(searchKeyword);
		if(searchKeyword.trim().length == 0){
			
			alert("검색어없음");
			
			return;
		}
		if(searchTypeValue === '--'){
			
			alert("검색조건을 선택하세요.");
			return;
		}
		
		actionForm.attr("action","/board/list");
		$("#keyword").val(searchKeyword);
		actionForm.find("input[name='type']").val(searchTypeValue);
		$("#page").val(1);		
		actionForm.submit();		
	});
	
	$("select[name='display']").change(function(e){
		
		var displayValue =$("select[name='display'] option:selected").val();
		
		actionForm.attr("action","/board/list");
		actionForm.find("input[name='display']").val(displayValue);
		$("#page").val(1);		
		actionForm.submit();		
	});
	
	/* $('div button').on('click',function(e){
		e.preventDefault();
		console.log('click');
		var input=e.target;
		var bno=input.getAttribute('data-bno');
		console.log(bno);
		actionForm.attr("action","/board/remove").attr("method","post");
		actionForm.append("<input type='hidden' name='bno' value='"+bno+"'>");
		actionForm.submit();
	})
	 */
	

});
</script>
