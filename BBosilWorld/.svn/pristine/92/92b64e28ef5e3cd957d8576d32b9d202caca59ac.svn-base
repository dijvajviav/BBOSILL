<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 1000px; /* 최대 너비를 더 넓게 설정 */
        width: 90%; /* 화면 크기에 따라 너비가 변하도록 설정을 조정 */
        background-color: #fff;
        padding: 50px; /* 내부 패딩을 늘려서 더 넓은 여백을 제공 */
        margin: 100px auto; /* 상하 여백을 늘려줍니다 */
        box-shadow: 0 0 20px rgba(0,0,0,0.1);
        border-radius: 8px; /* 모서리를 둥글게 처리 */
    }

    h2 {
        font-size: 28px; /* 제목 폰트 크기를 늘립니다 */
        color: #333;
        margin-bottom: 40px; /* 제목 아래 마진 추가 */
    }

    .form-group {
        margin-bottom: 30px; /* 라벨과 입력 필드 사이의 여백을 늘립니다 */
    }

    label {
        display: block;
        margin-bottom: 12px; /* 라벨 아래 마진을 늘립니다 */
    }

    input[type="text"],
    input[type="password"] {
        width: calc(100% - 24px); /* 패딩 및 테두리 고려한 너비 설정 */
        padding: 14px; /* 입력 필드 내부 패딩을 늘립니다 */
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .btn {
        display: block;
        padding: 14px 20px; /* 버튼 패딩을 늘립니다 */
        font-size: 20px; /* 버튼 폰트 크기를 늘립니다 */
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
        margin-top: 12px;
    }

    /* 추가된 버튼 컬러 스타일 */
    .btn-primary {
        background-color: #ffc107;
        color: #fff;
    }

    .btn-primary:hover {
        background-color: #e0a800;
    }

    .btn-secondary {
        background-color: #6c757d;
        color: #fff;
    }

    .btn-secondary:hover {
        background-color: #545b62;
    }

    .btn-success {
        background-color: #28a745;
        color: #fff;
    }

    .btn-success:hover {
        background-color: #1e7e34;
    }

    .btn:not(:last-child) {
        margin-bottom: 15px;
    }

    /* 큰 화면에서도 넓게 보이도록 설정 조정 */
    @media (min-width: 1200px) {
        .container {
            width: 70%; /* 더 넓은 화면에서는 컨테이너의 너비를 70%로 설정 */
        }
    }
</style>






<script>
// 페이지가 로드될 때 실행되는 함수
window.onload = function() {
    // 서버로부터 받은 메시지가 있는지 확인
    <c:if test="${not empty msg}">
        // 메시지가 있다면 alert 팝업으로 보여줌
        alert("${msg}");
    </c:if>
};
</script>


</head>
<body>
	<div class="container">
		<h2>로그인</h2>

		
		  <form action="login.do" method="post" class="was-validated" >
		    <div class="form-group">
		      <label for="id">아이디:</label>
		      <input type="text" class="form-control" id="id" name="id" required
		       pattern="^[a-zA-Z0-9]{2,70}">
			    <div class="valid-feedback">적당한 아이디입니다.</div>
		    	<div class="invalid-feedback">이 항목은 필수 입력이고 2자이상 20자 이내 영숫자로 작성하셔야 합니다.</div>
		    </div>
		    <div class="form-group">
		      <label for="pw">비밀번호:</label>
		      <input type="password" class="form-control" id="pw" name="pw" required
		       pattern="^.{3,20}">
			    <div class="valid-feedback">비밀번호 알맞게 입력하셨습니다.</div>
		    	<div class="invalid-feedback">이 항목은 필수 입력이고 3자이상 20자 이내로 작성하셔야 합니다.</div>
		    </div>
		    <button type="submit" class="btn btn-primary">로그인</button>
		    <a href="/member/findid.do" class="btn btn-secondary">아이디 찾기</a>
		    <a href="/member/findpw.do" class="btn btn-secondary">비밀번호 찾기</a>
		    <a href="/call/login" class="btn btn-success">네이버로 회원가입</a>
		  </form>
<!-- 		</div> -->
	</div>
</body>
</html>