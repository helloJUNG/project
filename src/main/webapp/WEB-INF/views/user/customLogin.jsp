<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Login Page - Dashboard Admin Template</title>
<!--

    Template 2108 Dashboard

	http://www.tooplate.com/view/2108-dashboard

    -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600">
<!-- https://fonts.google.com/specimen/Open+Sans -->
<link rel="stylesheet" href="../resources/css/fontawesome.min.css">
<!-- https://fontawesome.com/ -->
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<!-- https://getbootstrap.com/ -->
<link rel="stylesheet" href="../resources/css/tooplate.css">
</head>

<body class="bg03">
	<div class="container">
		<div class="row tm-mt-big">
			<div class="col-12 mx-auto tm-login-col">
				<div class="bg-white tm-block">
					<div class="row">
						<div class="col-12 text-center">
							<i class="fas fa-3x fa-tachometer-alt tm-site-icon text-center"></i>
							<h2 class="tm-block-title mt-3">Login</h2>
						</div>
					</div>
					<div class="row mt-2">
						<div class="col-12">
							<form role="form" action="/login" method="post"
								class="tm-login-form">
								<div class="input-group">
									<label for="username"
										class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">Username</label>
									<input name="username" type="text"
										class="form-control validate col-xl-9 col-lg-8 col-md-8 col-sm-7"
										required>
								</div>
								<div class="input-group mt-3">
									<label for="password"
										class="col-xl-4 col-lg-4 col-md-4 col-sm-5 col-form-label">Password</label>
									<input name="password" type="password"
										class="form-control validate" required>
								</div>
								<div>
									<input type="checkbox" name="remember-me">Remember Me
								</div>
								<div class="input-group mt-3">
									<button type="submit"
										class="btn btn-primary d-inline-block mx-auto" id="loginBtn">Login</button>
								</div>
								<div class="input-group mt-3">
									<p>
										<em>Just put a character to login.</em>
									</p>
								</div>
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="/resources/js/jquery-3.3.1.min.js"></script>
	<!-- https://jquery.com/download/ -->
	<script src="/resources/jquery-ui-datepicker/jquery-ui.min.js"></script>
	<!-- https://jqueryui.com/download/ -->
	<script src="/resources/js/bootstrap.min.js"></script>
	
	<script>
	
	$("#loginBtn").on("click",function(e){
		
		e.preventDefault();
		$("form").submit();
		
	});
	
	</script>
</body>

</html>