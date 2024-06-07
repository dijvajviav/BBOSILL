<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 </title>
</head>
<body>
	<div class="container">
	
		<div class="card-header font-weight-bold bg-primary text-white">
			<h2>아이디 찾기 </h2>
		</div>
		
		<div class="card-body">
		  <form action="findid.do" method="post" class="was-validated" >
		  
		  	 <c:if test="${!empty vo.id }">
				<div class="form-group">
			        <p>회원님의 아이디는 <strong>${vo.id } 입니다.</strong></p>
			        <a href="/member/findpw.do" class ="btn btn-primary">비밀번호 찾기</a>
			        <a href = "/member/login.do" class="btn btn-primary">로그인하러 가기</a>
	 			</div>
	        </c:if>
	
	 		<c:if test="${empty vo.id }">
			    <div class="form-group">
			        <p><strong>일치하는 회원 정보가 없습니다.</strong></p>
				</div>
			</c:if>	 
			  
		  </form>
		</div>
		
	</div>
</body>
</html>