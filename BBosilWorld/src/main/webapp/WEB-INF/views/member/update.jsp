<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
<!-- jquery UI 라이브러리 등록 : CDN 방식 -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
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
  max-width: 800px;
  background-color: #fff;
  padding: 40px;
  margin: 40px auto;
  box-shadow: 0 0 15px rgba(0,0,0,0.1);
  border-radius: 8px;
}

h1 {
  color: #333;
  font-size: 28px;
  margin-bottom: 40px;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  font-size: 18px;
  margin-bottom: 10px;
  color: #666;
}

.form-control {
  font-size: 16px;
  border-radius: 4px;
  border: 1px solid #ccc;
  padding: 10px;
  width: 100%;
}

.btn {
  font-size: 18px;
  padding: 10px 20px;
  border-radius: 4px;
  border: none;
  cursor: pointer;
  display: inline-block;
  margin-right: 10px;
}

.btn-default {
  background-color: #5cb85c;
  color: white;
}

.btn-default:hover {
  background-color: #4cae4c;
}

/* 우편번호 찾기 버튼 */
#sample6_extraAddress {
  display: inline-block;
  margin-top: 10px;
}

/* 추가된 스타일 */
.row {
  margin-right: 0;
  margin-left: 0;
}

.col-md-1, .col-md-10 {
  position: relative;
  min-height: 1px;
  padding-right: 15px;
  padding-left: 15px;
}

.col-md-1 {
  width: 8.33333333%;
  float: left;
}

.col-md-10 {
  width: 83.33333333%;
  float: left;
}

@media (max-width: 768px) {
  .col-md-1, .col-md-10 {
    width: 100%;
    float: none;
  }
}

/* 상세주소 스타일링 */
#detail_address {
  margin-top: 10px;
}
</style>



<script>
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


<script>

$("#tel1").keyup(function(){
	if($("#tel1").val().length == 3) $("#tel2").focus();
});

$("#tel2").keyup(function(){
	if($("#tel2").val().length == 4) $("#tel3").focus();
});

        $(document).ready(function() {

        	// 기존의 전화번호 가져오기
            var fullTel = "${vo.tel}"; // 010-nnnn-nnnn 형태로 가정
            if(fullTel) {
                var telParts = fullTel.split('-');
                if(telParts.length === 3) {
                    $('#tel1').val(telParts[0]);
                    $('#tel2').val(telParts[1]);
                    $('#tel3').val(telParts[2]);
                }
            }

            
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

</head>
<body>
	<div class="container">
			<h1>내 정보 수정</h1>
		<div class="card-body">
			<!-- 검색 & perPageNum -->
			<!-- 게시판의 검색 : 제목, 내용, 작성자, 그외 복합 
					페이지는 1페이지, 한페이지에 표시할 데이터 갯수 전달. : hidden-->
			<div style="margin-bottom: 10px; padding: 0 15px;" class="row">
				<div id="searchDiv">
					<!-- form class="form-inline" -> bootstrap에서 한줄로 쭉 -->
					<form action="list.do" class="form-inline" id="searchForm">
						<input name="perPageNum" value="${pageObject.perPageNum }" type="hidden"/>
					</form>
				</div>
			</div>

	<form action="update.do" method="post" id="updateForm">
			<div class="form-group">
				<label for="id">아이디:</label>
				<!-- required : 필수 입력 -->
				<input type="text" class="form-control" id="id" name="id" readonly
					value="${vo.id }" maxlength="20">
				<!-- 	     required pattern="^[a-z0-9]{2,20}$" maxlength="20"> -->
			</div>

			<div class="form-group">
				<label for="name">이름:</label>
				<input type="text" class="form-control" id="name" name="name"
				 value="${vo.name }" pattern="^[가-힣]{2,10}$">
			</div>

			<!-- jquery UI 라이브러리를 이용한 Datepicker 사용하기. -> 라이브러리 필요. -->
			<div class="form-group">
				<label for="birth">생년월일:</label> <input type="text"
					class="form-control" id="birth" name="birth" readonly
					value="${vo.birth }">
			</div>

			<div class="form-group row">
				<label class="col-md-1">전화번호:</label>
				<!-- required : 필수 입력 -->
				<div class="col-md-2">
					<input type="text" class="form-control" id="tel1" name="tels"
						pattern="^0\d{1,2}$" maxlength="3">
				</div>
				<div class="col-md-2">
					<input type="text" class="form-control" id="tel2" name="tels"
						pattern="^\d{3,4}$" maxlength="4">
				</div>
				<div class="col-md-2">
					<input type="text" class="form-control" id="tel3" name="tels"
						pattern="^^\d{4}$" maxlength="4">
				</div>
			</div>

			<div class="form-group">
				<label for="email">이메일:</label>
				<input type="text" class="form-control" id="email" name="email"
					value="${vo.email }" readonly="readonly"
					pattern="^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$">
			</div>

			<div class="form-group">
				<label for="postalcode">우편번호</label>
				<input type="text" class="form-control" id="postalcode" readonly
					name="postalcode" value="${vo.postalcode }" placeholder="우편번호">
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<label for="address">기본주소</label>
				<input type="text"class="form-control" id="address" name="address" value="${vo.address }" readonly placeholder="주소">
				<label for="detail_address">상세주소</label>
				<input type="text" class="form-control" id="detail_address" name="detail_address" value="${vo.detail_address }" placeholder="상세주소"> 
				<input type="hidden" class="form-control" id="sample6_extraAddress" placeholder="참고항목">
			</div>
			<button type="submit" class="btn btn-default">내정보수정</button>
		</form>
	
	</div>
</div>
</body>
</html>