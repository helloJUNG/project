<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Admin page</h1>

<P>principal:<sec:authentication property="principal"/></P>
<P>MemberVO:<sec:authentication property="principal.member"/></P>
<P>사용자이름:<sec:authentication property="principal.member.userName"/></P>
<P>사용자아이디:<sec:authentication property="principal.username"/></P>
<P>사용자권한리스트:<sec:authentication property="principal.member.authList"/></P>
<a href="/customLogout">Logout</a>
</body>
</html>