<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>

<style>
form {
	width: 100%;
}
</style>

<!-- row -->
<div class="row tm-mt-big">
	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
		<div class="bg-white tm-block">
			<div class="row">
				<div class="col-12">
					<h2 class="tm-block-title d-inline-block">Modify</h2>
				</div>
			</div>
			<div class="row col-xl-12 col-lg-12 col-md-12 col-sm-12">
				<form role="form" action="/board/modify" method="post">
					<input type="hidden" name="bno" value="${board.bno}">

					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">
							Title </label> <input id="title" name="title" type="text" required
							value="<c:out value="${board.title}"/>"
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							data-large-mode="true">
					</div>
					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">
							Writer </label> <input id="writer" name="writer" type="text" required
							value="<c:out value="${board.writer}"/>" readonly="readonly"
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							data-large-mode="true">
					</div>
					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 mb-2">Content</label>
						<textarea
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							rows="3" name="content" required><c:out
								value="${board.content}" />"</textarea>
					</div>
					
					<button type="submit" class="btn btn-small btn-primary">Modify</button>
				</form>
			</div>
			<form role="form" action="/board/list" method="get">
				<input type="hidden" name="page" value="${pageObj.page}">
				<button type="submit" class="btn btn-small btn-primary">List
					Button</button>
			</form>
			<form role="form" action="/board/remove" method="post">
				<input type="hidden" name="page" value="${pageObj.page}"> <input
					type="hidden" name="bno" value="${pageObj.bno}">
				<button type="sumbit" class="btn btn-danger">Remove</button>
			</form>
		</div>
	</div>
</div>
<%@include file="../includes/footer.jsp"%>