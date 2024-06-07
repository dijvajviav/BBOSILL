<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 700px; /* 페이지 너비 증가 */
        width: 90%; /* 화면 크기에 따라 가변적으로 너비 설정 */
        background-color: #fff;
        padding: 40px; /* 내부 패딩을 늘려서 더 넓은 여백 제공 */
        margin: 50px auto; /* 상하 여백 조정 */
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        border-radius: 8px;
    }

    h2 {
        font-size: 28px; /* 제목 크기 증가 */
        color: #333;
        margin-bottom: 30px; /* 제목 아래 여백 */
        text-align: center;
    }

    .form-group {
        margin-bottom: 20px; /* 입력 필드 사이의 여백 */
    }

    label {
        display: block;
        margin-bottom: 10px; /* 라벨 아래 여백 */
        color: #333;
        font-size: 18px; /* 라벨 폰트 크기 */
    }

    input[type="text"],
    input[type="email"],
    input[type="button"] {
        width: calc(100% - 20px); /* 패딩을 고려한 너비 설정 */
        padding: 12px; /* 내부 패딩 증가 */
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px; /* 폰트 크기 증가 */
        margin-bottom: 15px; /* 하단 여백 */
    }

    .btn {
        width: 100%; /* 버튼의 너비를 100%로 설정 */
        padding: 12px; /* 버튼의 내부 패딩 */
        font-size: 18px; /* 버튼의 폰트 크기 */
        border-radius: 5px;
        border: none; /* 버튼의 테두리 제거 */
        margin-bottom: 15px; /* 버튼 사이 여백 */
    }

    .btn-primary {
        background-color: #ffc107;
        color: white;
    }

    .btn-primary:hover {
        background-color: #e0a800;
    }

    .btn:not(:last-child) {
        margin-bottom: 15px;
    }

    #Codeverify,
    #verifyButton {
        display: none; /* 기본적으로 숨김 처리 */
    }
</style>




<!-- jquery UI 라이브러리 등록 : CDN 방식 -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>


<script type="text/javascript">
$(function(){
	$("#findpw").submit(function(){
		
		// 정규표현식을 이용한 데이터 유효성 검사.
		const ex_id = /^[a-z0-9]{2,20}$/;
		
		let id = $("#id").val();
		// 정규 표현식 검사는 반드시 문자열 데이터가 있어야 한다.
		if(! new RegExp(ex_id).test(id)) {
			alert("아이디는 숫자와 영문자 소문자 2~20를 사용하셔야 합니다.");
			$("#id").focus();
			return false; // 페이지 이동을 막는다. submit을 막는다.
		}
	    if (!$('#Codeverify').prop('readonly')) {
	        alert('이메일 인증번호 확인이 필요합니다.');
	        event.preventDefault(); // 폼 제출을 방지합니다.
	    }
	    
	});
});

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//이메일 인증번호 발송 및 확인
function sendVerificationCode() {
    var email = $('#email').val(); // 이메일 입력 필드의 값을 가져옵니다.
    if (email === null || email.trim() === "") {
        alert("이메일을 입력하세요.");
        return;
    }
    // 이메일 필드가 readonly 상태가 아니면 인증번호 발송
    if (!$("#email").prop('readonly')) {
        // AJAX 요청
        $.ajax({
            url: "/member/sendVerificationEmail", // 서버의 URL
            type: "POST",
            data: { email: email },
            dataType: "json",
            success: function(data) {
                if (data.sent) {
                    alert("인증번호가 발송되었습니다. 이메일을 확인해 주세요.");
                    $('#email').prop('readonly', true); // 이메일 입력 필드를 읽기 전용으로 설정
                    $('#Codeverify').show(); // 인증번호 입력 필드를 보여줌
                    $('#verifyButton').show(); // 인증번호 확인 버튼을 보여줌
                } else {
                    alert("인증번호 발송에 실패했습니다.");
                }
            },
            error: function(xhr, status, error) {
                alert("에러가 발생했습니다. 다시 시도해 주세요.");
            }
        });
    }
}

////////////////////////////////////////////////////////////////////////////////
//입력한 인증번호(이메일)가 발송된 인증번호(이메일)과 일치하는지 검사
function verifyCode() {
 var Codeverify = $("#Codeverify").val(); // 사용자가 입력한 인증번호
 $.ajax({
     url: '/member/verifyVerificationCode', // 서버에 요청할 URL
     type: 'POST',
     data: {Codeverify: Codeverify}, // 서버로 보낼 데이터
     dataType: 'json', // 서버로부터 받을 데이터 형식
     success: function(data) {
         if(data.isVerified) {
             alert("인증되었습니다.");
             $('#Codeverify').prop('readonly', true); // 인증번호 입력 필드를 읽기 전용으로 설정
         } else {
             alert("인증번호가 일치하지 않습니다. 다시 확인해주세요.");
         }
     },
     error: function(request, status, error) {
         alert("인증번호 확인 중 오류가 발생했습니다.");
     }
 });
};

</script>

</head>

<body>
			
	
	<div class="container">
		<h2>비밀번호 찾기</h2>
		<div class="card-body">
		  <form action="findpw.do" method="post" class="was-validated" id="findpw" >
		  
		    <div class="form-group">
		       <label for="id">아이디</label>
	           <input type="text" class="form-control" id="id" name= "id" placeholder="아이디" required maxlength="20">
		    </div>
		    
		    <div class="form-group">
		      <label for="name">이름</label>
	          <input type="text" class="form-control" id="name" name= "name" placeholder="이름" required pattern="^[가-힣]{2,10}$" maxlength="20">
		    </div>
		    
		    <div class="form-group">
		      <label for="email">이메일:</label>
		      <input type="text" class="form-control" id="email" name="email" placeholder="이메일"
		     required pattern="^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$" >
		     <input type="button" onclick="sendVerificationCode()" value="인증번호 발송">
		     <input type="text" class="form-control" id="Codeverify" name="Codeverify" placeholder="인증번호 입력" required style="display:none;">
		     <input type="button" id="verifyButton" onclick="verifyCode()" value="인증번호 확인" style="display:none;">
		     
		    </div>
		    
		    <button type="submit" class="btn btn-primary">확인</button>
		   <a href = "/member/login.do" class="btn btn-primary">로그인하러 가기</a>
		   
		  </form>
		</div>
	</div>
</body>
</html>