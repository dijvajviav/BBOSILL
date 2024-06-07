<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 700px; /* 컨테이너 최대 너비 증가 */
        width: 90%; /* 브라우저 창에 따라 가변적으로 너비 설정 */
        background-color: #fff;
        padding: 50px; /* 패딩 증가로 더 넓은 여백 제공 */
        margin: 50px auto; /* 상단과 하단의 여백을 줄여 조화로움 유지 */
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
        border-radius: 8px;
    }

    h2 {
        font-size: 28px; /* 제목 크기 증가 */
        color: #333;
        margin-bottom: 30px; /* 제목과 입력 필드 사이 여백 증가 */
        text-align: center;
    }

    .form-group {
        margin-bottom: 20px; /* 입력 필드 사이의 여백 증가 */
    }

    label {
        display: block;
        margin-bottom: 10px; /* 라벨 아래 여백 증가 */
        color: #333;
        font-size: 18px; /* 라벨 폰트 크기 증가 */
    }

    input[type="text"],
    input[type="email"] {
        width: calc(100% - 20px); /* 패딩을 고려한 너비 설정 */
        padding: 15px; /* 입력 필드 내부 패딩 증가 */
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px; /* 입력 필드 폰트 크기 증가 */
    }

    .btn {
        width: 100%; /* 버튼 너비를 100%로 설정 */
        padding: 15px; /* 버튼 내부 패딩 증가 */
        font-size: 18px; /* 버튼 폰트 크기 증가 */
        border-radius: 5px;
        margin-bottom: 15px; /* 버튼 사이의 여백 증가 */
    }

    .btn-primary {
        background-color: #ffc107;
        color: white;
    }

    .btn-primary:hover {
        background-color: #e0a800;
    }

    a.btn {
        background-color: #6c757d; /* 버튼 배경색 설정 */
        padding: 15px; /* 링크(버튼) 내부 패딩 증가 */
        font-size: 18px; /* 링크(버튼) 폰트 크기 증가 */
        border-radius: 5px;
    }

    a.btn:hover {
        background-color: #545b62;
    }
</style>


</head>
<body>
	<div class="container">
			<h2>아이디 찾기</h2>

		
		<div class="card-body">
		  <form action="findid.do" method="post" class="was-validated" >
		  
		    <div class="form-group">
		      <label for="name">이름</label>
			  <input type="text" class="form-control" id="name" name= "name" placeholder="이름" required pattern="^[가-힣]{2,10}$" maxlength="20">
		    </div>
		    
		    <div class="form-group">
		      <label for="email">이메일</label>
	          <input type=text class="form-control" id="email" name="email" placeholder="이메일" required pattern="^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$">
		    </div>
		    
		    <button type="submit" class="btn btn-primary">확인</button>
		   <a href = "/member/login.do" class="btn btn-primary">로그인하러 가기</a>
		   
		  </form>
		</div>
	</div>
</body>
</html>