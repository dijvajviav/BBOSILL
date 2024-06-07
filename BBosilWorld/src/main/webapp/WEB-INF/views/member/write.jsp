<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>회원가입</title>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

.container {
	
  
  

    max-width: 800px; /* 컨테이너의 최대 너비를 늘립니다 */
    background-color: #fff;
    padding: 2em; /* 컨테이너 내부의 여백을 늘립니다 */
      margin: 2% auto; /* 위아래 마진을 %로 변경하여 반응형으로 만듭니다 */
    box-shadow: 0 0 10px rgba(0,0,0,0.2); /* 그림자를 좀 더 두드러지게 */
    border-radius: 10px; /* 모서리 둥글게 */
    text-align: left; /* 텍스트 왼쪽 정렬 */
}

h2 {
    font-size: 24px; /* 제목 크기를 더 크게 */
    color: #333;
    margin-bottom: 30px; /* 제목과 폼 사이의 간격을 넓게 */
}

.form-group {
    margin-bottom: 25px; /* 폼 요소 사이의 간격을 넓게 */
}

label {
    display: block;
    margin-bottom: 10px;
    font-size: 16px; /* 라벨 크기를 더 크게 */
    color: #333; /* 라벨 색상을 진하게 */
}

input[type="text"],
input[type="email"],
input[type="password"] {
    width: calc(100% - 22px); /* 테두리를 포함한 100% 너비 */
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-bottom: 20px; /* 입력 필드 아래 간격을 넓게 */
    font-size: 16px; /* 입력 필드 글자 크기를 더 크게 */
}

.btn {
    width: auto; /* 버튼 너비를 내용에 맞게 조정 */
    padding: 10px 20px; /* 버튼 패딩을 좀 더 넓게 */
    border-radius: 5px;
    margin-bottom: 20px;
    background-color: #ffc107; /* 버튼 색상 변경 */
    color: white;
    font-size: 18px; /* 버튼 글자 크기를 더 크게 */
    border: none;
    cursor: pointer;
}

.btn:hover {
    background-color: #e0a800;
}
</style>

 <script>
        $(document).ready(function() {
            var now = new Date();
            var toDayYear = now.getFullYear();
            var yearRange = (toDayYear - 100) + ":" + toDayYear;

            $("#birth").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: new Date(),
                yearRange: yearRange,
                dateFormat: "yy-mm-dd",
                dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
                monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            });
        });
</script>

<script>
  $(document).ready(function() {
    // userProfile 객체에서 전화번호를 가져와서 '-' 기준으로 분리한 후 각 입력란에 채워넣습니다.
    var phoneNumber = '${userProfile.phoneNumber}';
    var id = '${userProfile.id}';
    var name = '${userProfile.name}';
    var email = '${userProfile.email}';
    
    if(phoneNumber) {
      var phoneNumberParts = phoneNumber.split('-');
      if(phoneNumberParts.length === 3) {
        $('#tel1').val(phoneNumberParts[0]).prop('readonly', true);
        $('#tel2').val(phoneNumberParts[1]).prop('readonly', true);
        $('#tel3').val(phoneNumberParts[2]).prop('readonly', true);
      }
    }

    if(id) {
          $('#id').val(id).prop('readonly', true);
        }
    if(name) {
        $('#name').val(name).prop('readonly', true);
      }
    if(email) {
        $('#email').val(email).prop('readonly', true);
      } 
  });
</script>



<script>

// 아이디 중복확인
function checkIdDuplicate() {
    var id = $('#id').val(); // 아이디 입력 필드의 값을 가져옵니다.
    if(id === null || id.trim() === "") {
        alert("아이디를 입력하세요.");
        return;
    }
    $.ajax({
        url: '/member/checkIdDuplicate', // 중복 확인을 처리할 서버의 URL
        type: 'POST',
        data: {id: id},
        dataType:'json',
        success: function(data) {
            if(data.isDuplicate) {
                alert("이미 사용 중인 아이디입니다." + data.isDuplicate);
                
            } else {
                alert("사용 가능한 아이디입니다.");
                $('#id').prop('readonly', true); // 아이디 입력 필드를 readonly로 설정합니다.
                $('#pw').focus();
            }
        },
        error: function(request, status, error) {
            alert("아이디 중복 확인 중 오류가 발생했습니다."+ data.isDuplicate);
        }
    });
};
// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// // 이메일 중복확인

function checkEmailDuplicate() {
    var email = $('#email').val(); // 이메일 입력 필드의 값을 가져옵니다.
    if(email === null || email.trim() === "") {
        alert("이메일을 입력하세요.");
        return;
    }
    
    $.ajax({
        url: '/member/checkEmailDuplicate', // 중복 확인을 처리할 서버의 URL
        type: 'POST',
        data: {email: email},
        dataType:'json',
        success: function(data) {
            if(data.isDuplicateEmail) {
                alert("이미 사용 중인 이메일입니다.");
            } else {
                alert("사용 가능한 이메일입니다..");
                $('#email').prop('readonly', true); // 이메일 입력 필드를 readonly로 설정합니다.
            }
        },
        error: function(request, status, error) {
            alert("이메일 중복 확인 중 오류가 발생했습니다.");
        }
    });
};

// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// // 이메일 인증번호 발송 및 확인
function sendVerificationCode() {
    var email = $("#email").val(); // 사용자가 입력한 이메일 주소를 가져옵니다.
    // 이메일 필드가 readonly 상태인지 확인합니다.
    if ($("#email").prop('readonly')) {
        // AJAX 요청
        $.ajax({
            url: "/member/sendVerificationEmail", // 인증번호 발송을 처리할 서버의 URL
            type: "POST",
            data: { email: email }, // 데이터로 이메일 주소를 넘깁니다.
            dataType: "json",
            success: function(data) {
                if(data.sent) { // 서버에서 인증번호 발송 성공 여부를 'sent' 속성으로 반환한다고 가정합니다.
                    alert("인증번호가 발송되었습니다. 이메일을 확인해 주세요.");
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
    } else {
        alert("이메일 중복 확인이 필요합니다.");
    }
};
// ////////////////////////////////////////////////////////////////////////////////
// //입력한 인증번호(이메일)가 발송된 인증번호(이메일)과 일치하는지 검사
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
                alert("인증번호가 일치하지 않거나 만료되었습니다. 다시 확인해주세요.");
            }
        },
        error: function(request, status, error) {
            alert("인증번호 확인 중 오류가 발생했습니다.");
        }
    });
};
///////////////////////////////////////////////////////
//다음(카카오) 도로명 주소 API
    function sample6_execDaumPostcode() {
            new daum.Postcode({
            oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
            extraAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraAddr !== ''){
            extraAddr = ' (' + extraAddr + ')';
            }
            // 조합된 참고항목을 해당 필드에 넣는다.
            document.getElementById("sample6_extraAddress").value = extraAddr;

            } else {
            document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postalcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detail_address").focus();
            }
            }).open();
        }
</script>

<script type="text/javascript">

     // 아이디를 중복확인 이후 다시 입력하려고 할 때
	$(function() {
		$('#id').click(function() {
		    // 입력 필드가 readonly 상태인지 확인합니다.
		    if ($(this).prop('readonly')) {
		        // readonly 상태를 해제합니다.
		        $(this).prop('readonly', false);
		    }
		});
		
		// 전화번호 입력 시 자동으로 다음 칸으로 넘어가게 하려고 만듬
		$("#tel1").keyup(function() {
			if ($("#tel1").val().length == 3)
				$("#tel2").focus();
		});

		$("#tel2").keyup(function() {
			if ($("#tel2").val().length == 4)
				$("#tel3").focus();
		});

		$("#tel3").keyup(function() {
			if ($("#tel3").val().length == 4)
				$("#email").focus();
		});
		
		// 최종적으로 회원가입 등록버튼 누를 때 빼 먹은 거 없는지 체크하도록 만드는 부분, 빼 먹은 거 있으면 제출 X
		$("#write").submit(function() {
			
			// 아이디 입력 필드가 readonly 상태가 아니라면 폼 제출을 방지합니다.
		    if (!$('#id').prop('readonly')) {
		        alert('아이디 중복 확인이 필요합니다.');
		        event.preventDefault(); // 폼 제출을 방지합니다.
		        $("#id").focus();
		        return false;
		    }
		    if (!$('#email').prop('readonly')) {
		        alert('이메일 중복 확인이 필요합니다.');
		        event.preventDefault(); // 폼 제출을 방지합니다.
		        $("#email").focus();
		        return false;
		    }
		    if (!$('#Codeverify').prop('readonly')) {
		        alert('이메일 인증번호 확인이 필요합니다.');
		        event.preventDefault(); // 폼 제출을 방지합니다.
		        $("#Codeverify").focus();
		        return false;
		    }
		    if (!$('#verificationCode').prop('readonly')) {
		        alert('휴대폰 인증번호 확인이 필요합니다.');
		        event.preventDefault(); // 폼 제출을 방지합니다.
		        $("##verificationCode").focus();
		        return false;
		    }

			// 정규표현식을 이용한 데이터 유효성 검사.
			const ex_id = /^[a-z0-9]{2,70}$/;

			let id = $("#id").val();
			// 정규 표현식 검사는 반드시 문자열 데이터가 있어야 한다.
			if (!new RegExp(ex_id).test(id)) {
				alert("아이디는 숫자와 영문자 소문자 2~70를 사용하셔야 합니다.");
				$("#id").focus();
				return false; // 페이지 이동을 막는다. submit을 막는다.
			}

			// 비밀번호와 비밀번호 확인이 같아야 데이터를 넘긴다.
			if ($("#pw").val() != $("#pw2").val()) {
				alert("비밀번호와 비밀번호 확인은 같아야 합니다.");
				// 데이터 지우기
				$("#pw").val("");
				$("#pw2").val("");
				// 커서를 비밀번호 입력란으로 이동시킨다.
				$("#pw").focus();
				// submit 취소시킨다.
				return false;
			}

			// 생년월일 입력 확인
		    if ($("#birth").val().trim() === "") {
		        alert("생년월일을 입력해야 합니다.");
		        event.preventDefault(); // 폼 제출을 방지합니다.
		        $("#birth").focus(); // 생년월일 입력 필드에 포커스를 줍니다.
		        return false; // 여기서 함수 실행을 멈춥니다.
		    }
		    
		    // 우편번호 입력 확인
		    if ($("#postalcode").val().trim() === "") {
		        alert("우편번호를 입력해야 합니다.");
		        event.preventDefault(); // 폼 제출을 방지합니다.
		        $("#postalcode").focus(); // 우편번호 입력 필드에 포커스를 줍니다.
		        return false; // 여기서 함수 실행을 멈춥니다.
		    }
		    
		    // 주소 입력 확인
		    if ($("#address").val().trim() === "") {
		        alert("주소를 입력해야 합니다.");
		        event.preventDefault(); // 폼 제출을 방지합니다.
		        $("#address").focus(); // 주소 입력 필드에 포커스를 줍니다.
		        return false; // 여기서 함수 실행을 멈춥니다.
		    }
		    
		    // 상세주소 입력 확인
		    if ($("#detail_address").val().trim() === "") {
		        alert("상세주소를 입력해야 합니다.");
		        event.preventDefault(); // 폼 제출을 방지합니다.
		        $("#detail_address").focus(); // 상세주소 입력 필드에 포커스를 줍니다.
		        return false; // 여기서 함수 실행을 멈춥니다.
		    }
		    
			 // 전화번호 필드 입력 확인
		    if ($("#tel1").val().trim() === "" || $("#tel2").val().trim() === "" || $("#tel3").val().trim() === "") {
		        alert("전화번호를 모두 입력해야 합니다.");
		        event.preventDefault(); // 폼 제출을 방지합니다.
		        if ($("#tel1").val().trim() === "") {
		            $("#tel1").focus(); // 첫 번째 전화번호 입력 필드에 포커스를 줍니다.
		            
		        } else if ($("#tel2").val().trim() === "") {
		            $("#tel2").focus(); // 두 번째 전화번호 입력 필드에 포커스를 줍니다.
		            
		        } else {
		            $("#tel3").focus(); // 세 번째 전화번호 입력 필드에 포커스를 줍니다.
		            
		        }
		        
		        return false; // 여기서 함수 실행을 멈춥니다.
		    }
		    
		    
		});
	});
</script>


<script>
// 휴대폰 인증번호 발송
function sendVerificationCodeToPhone() {
	var phoneNumber = $("#tel1").val() + $("#tel2").val() + $("#tel3").val();
    if(phoneNumber.trim() === "") {
        alert("휴대폰 번호를 입력해주세요.");
        return;
    }

    $.ajax({
        url: '/member/sendsms', // 변경해야 할 부분: 서버의 인증번호 발송 처리 URL
        type: 'POST',
        data: { phoneNumber: phoneNumber },
        dataType: 'json',
        success: function(response) {
            if(response.sent) { // 변경해야 할 부분: 발송 성공 여부를 확인하는 방법
                alert("인증번호가 발송되었습니다. 문자메시지를 확인해주세요.");
                $('#tel1').prop('readonly', true);
                $('#tel2').prop('readonly', true);
                $('#tel3').prop('readonly', true);
                $("#verificationCodeInput").show(); // 인증번호 입력란을 보여줌
            } else {
                alert("인증번호 발송에 실패했습니다. 다시 시도해주세요.");
            }
        },
        error: function(xhr, status, error) {
            alert("에러가 발생했습니다. 다시 시도해주세요.");
        }
    });
}

// 휴대폰 인증번호 검증
function verifyPhoneNumber() {
	var phoneNumber = $("#tel1").val() + $("#tel2").val() + $("#tel3").val();
    var verificationCode = $("#verificationCode").val();

    $.ajax({
        url: '/member/verifyPhoneNumber', // 변경해야 할 부분: 서버의 인증번호 검증 처리 URL
        type: 'POST',
        data: {
            phoneNumber: phoneNumber,
            verificationCode: verificationCode
        },
        dataType: 'json',
        success: function(response) {
            if(response.verified) { // 변경해야 할 부분: 인증 성공 여부를 확인하는 방법
                alert("인증되었습니다.");
                $('#verificationCode').prop('readonly', true);
            } else {
                alert("인증번호가 일치하지 않습니다. 다시 확인해주세요.");
            }
        },
        error: function(xhr, status, error) {
            alert("인증 확인 중 에러가 발생했습니다. 다시 시도해주세요.");
        }
    });
}
</script>

</head>
<body>
	<div class="container">
		<h2>회원가입</h2>
		
		<div class="card-body">
		  <form action="write.do" method="post" class="was-validated" id="write" >
			
            <!-- 아이디 -->
		    <div class="form-group">
		      <label for="id">아이디:</label>
		      <input type="text" class="form-control" id="id" name="id" placeholder="아이디" required maxlength="20"
		       pattern="^[a-zA-Z0-9]{2,70}">
			    <div class="valid-feedback">적당한 아이디입니다.</div>
		    	<div class="invalid-feedback">이 항목은 필수 입력이고 2자이상 70자 이내 영숫자로 작성하셔야 합니다.</div>
		    	<input type="button" onclick="checkIdDuplicate()" value="중복확인">
		    </div>
		    
		    <!-- 비밀번호 -->
		    <div class="form-group">
		      <label for="pw">비밀번호:</label>
		      <input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호" required
		       pattern="^.{4,20}$" maxlength="20">
			    <div class="valid-feedback">비밀번호 알맞게 입력하셨습니다.</div>
		    	<div class="invalid-feedback">이 항목은 필수 입력이고 4자이상 20자 이내로 작성하셔야 합니다.</div>
		    </div>
		    
		    <!-- 비밀번호 확인 -->
		      <div class="form-group">
		       <label for="pw2">비밀번호 확인:</label>
		       <input type="password" class="form-control" id="pw2" placeholder="비밀번호 확인" required
		        pattern="^.{4,20}$" maxlength="20">
			     <div class="valid-feedback">비밀번호 알맞게 입력하셨습니다.</div>
		    	 <div class="invalid-feedback">이 항목은 필수 입력이고 4자이상 20자 이내로 작성하셔야 합니다.</div>
		    </div>
		    
		    <!-- 이름  -->
		    <div class="form-group">
			    <label for="name">이름:</label>
			    <input type="text" class="form-control" id="name" name="name" placeholder="이름(한글만 입력해주세요)"
			     required pattern="^[가-힣]{2,10}$">
			    <div class="valid-feedback">이름을 알맞게 입력하셨습니다.</div>
		    	<div class="invalid-feedback">이 항목은 필수 입력이고 한글 2자이상 10자 이내로 작성하셔야 합니다.</div>
	       </div>
	       
	   		<!-- 생년월일 -->
	  		<div class="form-group">
			    <label for="birth">생년월일:</label>
			    <input type="text" class="form-control" id="birth" name="birth" 
			     required readonly style="background: #fff;" placeholder="click해서 입력해야 합니다.">
	 		</div>
	 		
			<!-- 전화번호 -->
	  		<div class="form-group row">
			    <label class="col-md-1">전화번호:</label>
			    <div class="col-md-2" >
				    <input type="text" class="form-control" id="tel1" name="tels" placeholder="010"
				     pattern="^0\d{1,2}$" maxlength="3">
			    </div>
			    <div class="col-md-2" >
				    <input type="text" class="form-control" id="tel2" name="tels" placeholder="0000"
				     pattern="^\d{3,4}$" maxlength="4">
			    </div>
			    <div class="col-md-2" >
				    <input type="text" class="form-control" id="tel3" name="tels" placeholder="0000"
				     pattern="^^\d{4}$" maxlength="4">
			    </div>
			     <input type="button" onclick="sendVerificationCodeToPhone()" value="인증번호 발송">
			    <div class="valid-feedback">전화번호를 알맞게 입력하셨습니다.</div>
				<div class="invalid-feedback">이 항목은 필수 입력입니다.</div>
	  		</div>
	  		<div class="form-group" id="verificationCodeInput" style="display: none;">
			    <label for="verificationCode">인증번호:</label>
			    <input type="text" class="form-control" id="verificationCode" name="verificationCode" placeholder="인증번호 입력" required>
			    <input type="button" onclick="verifyPhoneNumber()" value="인증번호 확인">
			</div>
	  
	  		<!-- 이메일 -->
	  		<div class="form-group">
			    <label for="email">이메일:</label>
			    <input type="text" class="form-control" id="email" name="email" placeholder="이메일"
			     required pattern="^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$" >
			     <input type="button" onclick="checkEmailDuplicate()" value="중복확인">
			     <input type="button" onclick="sendVerificationCode()" value="인증번호 발송">
			     <input type="text" class="form-control" id="Codeverify" name="Codeverify" placeholder="인증번호 입력" required style="display:none;">
			     <input type="button" id="verifyButton" onclick="verifyCode()" value="인증번호 확인" style="display:none;">
	  		</div>
	  		
	  		<!-- 우편번호, 주소, 상세주소 -->
	  		<div class="form-group">
			 	<input type="text" class="form-control" id="postalcode" name="postalcode" placeholder="우편번호" readonly>
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" class="form-control" id="address" name = "address" placeholder="주소" readonly><br>
				<input type="text"  class="form-control"id="detail_address" name = "detail_address" placeholder="상세주소">
				<input type="hidden" class="form-control" id="sample6_extraAddress" placeholder="참고항목">
	  		</div>
		    
		    
		    <button type="submit" class="btn btn-primary">등록</button>
		    <button type="reset" class="btn btn-info">다시입력</button>
		    <button type="button" class="btn btn-warning cancelBackBtn">취소</button>
		  </form>
		</div>
	</div>
</body>
</html>