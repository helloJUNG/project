<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<!-- row -->
<div class="row tm-content-row tm-mt-big">

	<div class="col-xl-12 col-lg-12 tm-md-12 tm-sm-12 tm-col">
		<div class="bg-white tm-block h-100">
			<div class="row">
				<div class="col-md-12 col-sm-12">
					<h2 class="tm-block-title d-inline-block">Board</h2>
			
			     <%--  <form id="pageForm" action="/board/list" method="get">		
					<select name="pageType">
						<option value="${pageObj.display}">10</option>
						<option value="${pageObj.display+10}">20</option>
						<option value="${pageObj.display+30}">50</option>
					</select>
				  </form> --%>
				</div>
				
					
				
				<div class="col-md-4 col-sm-12 text-right">
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
			


		 <div class="tm-table-mt tm-table-actions-row">
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
	


	$('.pagination tm-pagination[data-page ='+pageNum+']').addClass("active");
		
	$('.page-link').on("click",function(e){
			
			e.preventDefault();
			var target = $(this).attr("href");
			console.log(target);
			$("#page").val(target);
			actionForm.attr("action","/board/list").attr("method","get").submit();
		
	  }); 
		 
	var result = '<c:out value="${result}"/>';
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
