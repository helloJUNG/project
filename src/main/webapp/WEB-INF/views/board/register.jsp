<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

<style>
form {
  width:100%;
}
</style>

<!-- row -->
<div class="row tm-mt-big">
	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
		<div class="bg-white tm-block">
			<div class="row">
				<div class="col-12">
					<h2 class="tm-block-title d-inline-block">Register</h2>
				</div>
			</div>


			<div class="row col-xl-12 col-lg-12 col-md-12 col-sm-12">
				<form role="form" action="/board/register" method="post">

						<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">
							Title </label> <input id="title" name="title" type="text"
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							data-large-mode="true">
					</div>
					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">
							Writer </label> <input id="writer" name="writer" type="text"
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							data-large-mode="true">
					</div>
					<div class="form-group">
						<label class="col-xl-4 col-lg-4 col-md-4 col-sm-5 mb-2">Content</label>
						<textarea
							class="form-control validate col-xl-12 col-lg-12 col-md-12 col-sm-12"
							rows="3" name="content" required></textarea>
					</div>

					<div class="form-group">
						<div class="ml-auto col-xl-8 col-lg-8 col-md-8 col-sm-7 pl-0">
							<button type="submit" class="btn btn-default">Register</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<%@include file="../includes/footer.jsp"%>