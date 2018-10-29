<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

	<!-- row -->
	<div class="row tm-content-row tm-mt-big">
		<div class="col-xl-8 col-lg-12 tm-md-12 tm-sm-12 tm-col">
			<div class="bg-white tm-block h-100">
				<div class="row">
					<div class="col-md-8 col-sm-12">
						<h2 class="tm-block-title d-inline-block">Board</h2>

					</div>
					<div class="col-md-4 col-sm-12 text-right">
						<a href="/board/register" class="btn btn-small btn-primary">Register</a>
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
								<th scope="col" class="text-center">regdate</th>
								<th scope="col">&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="board">
							<tr>
								<th scope="row"><input type="checkbox"aria-label="Checkbox"></th>
								<td class="text-center"><c:out value="${board.bno}"></c:out></td>
								<td class="text-center"><c:out value="${board.title}"></c:out></td>
								<td class="text-center"><c:out value="${board.writer}"></c:out></td>
								<td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${board.regdate}" /></td>
								<td><i class="fas fa-trash-alt tm-trash-icon"></i></td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<div class="tm-table-mt tm-table-actions-row">
					<div class="tm-table-actions-col-left">
						<button class="btn btn-danger">Delete Selected Items</button>
					</div>
					<div class="tm-table-actions-col-right">
						<span class="tm-pagination-label"></span>
						<nav aria-label="Page navigation" class="d-inline-block">
						<%-- 	<ul class="pagination tm-pagination">
								<c:if test ="${pageObj.prev}">
								<li class="page-item active"><a class="page-link" href="${pageObj.start-1}}">Prev</a></li>
								</c:if>
								
								<c:forEach begin="${pageObj.start}" end="{pageObj.end}" var="num">
								<li class="page-item" data-page='${num}'><a class="page-link"  href="${num}"><c:out value="${num}"></c:out></a></li>
								</c:forEach>
								
								<c:if test="${pageObj.next}">
								<li class="page-item"><a class="page-link" href="${pageObj.end+1}">Next</a></li>
								</c:if>
						
							</ul> --%>
						</nav>
					</div>
				</div>
			</div>
		</div>


	</div>
	
</div>
<form id="actionForm">
	<input type="hidden" name="page" id="page" value="${pageObj.page}">
</form>
<%@include file="../includes/footer.jsp"%>

<script>
	/* $(document).ready(function(){
		
		var actionForm = $("#actionForm");
		var pageNum = ${pageObj.page};
		
	$('.pagination tm-pagination li[data-page ='+pageNum+']').addClass("active");
		
	$('.pagination li a').on("click",function(e){
			
			e.preventDefault(); //기본동작을 막아버림... 눌려도 아무변화가 없다.
			var target = $(this).attr("href");
			console.log(target);
			$("#page").val(target);
			actionForm.attr("action","/board/list").attr("method","get").submit();
		
	}); */
</script>
