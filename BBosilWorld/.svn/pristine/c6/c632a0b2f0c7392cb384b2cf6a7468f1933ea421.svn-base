<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${empty param.id?"내 정보 보기":"회원 정보 보기" }</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<style>
  body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
  }

  .container {
    max-width: 800px;
    margin: 40px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
  }

  h1, h2, h3, h4, h5, h6 {
    color: #333;
    margin-bottom: 20px;
  }

  .card-body {
    padding: 20px;
  }

  .table {
    width: 100%;
    margin-bottom: 20px;
    border-collapse: collapse;
  }

  .table th, .table td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
  }

  .btn {
    display: inline-block;
    padding: 10px 15px;
    margin-right: 10px;
    font-size: 16px;
    border-radius: 5px;
    text-decoration: none;
    color: #fff;
    background-color: #007bff;
    border: none;
    cursor: pointer;
  }

  .btn:hover {
    background-color: #0056b3;
  }

  .btn-primary {
    background-color: #007bff;
  }

  .btn-primary:hover {
    background-color: #0056b3;
  }

  .btn-warning {
    background-color: #ffc107;
  }

  .btn-warning:hover {
    background-color: #e0a800;
  }

  .btn-info {
    background-color: #17a2b8;
  }

  .btn-info:hover {
    background-color: #138496;
  }

  /* 반응형 디자인을 위한 미디어 쿼리 */
  @media (max-width: 768px) {
    .container {
      width: 95%;
    }

    .table {
      display: block;
      overflow-x: auto;
    }

    .btn {
      padding: 10px;
      font-size: 14px;
    }
  }
</style>

<style>
  .btn {
    display: inline-block;
    padding: 10px 15px;
    margin-right: 10px;
    font-size: 16px;
    border-radius: 5px;
    text-decoration: none;
    color: #fff;
    background-color: #17a2b8; /* Bootstrap의 'info' 버튼 색상 */
    border: none;
    cursor: pointer;
    transition: background-color 0.3s ease; /* 부드러운 색상 전환 효과 */
  }

  .btn:hover {
    background-color: #138496; /* 호버 상태일 때 색상 */
  }

  .btn-primary {
    background-color: #28a745; /* Bootstrap의 'success' 버튼 색상 */
  }

  .btn-primary:hover {
    background-color: #218838; /* 호버 상태일 때 색상 */
  }

  .btn-warning {
    background-color: #ffc107; /* Bootstrap의 'warning' 버튼 색상 */
  }

  .btn-warning:hover {
    background-color: #e0a800; /* 호버 상태일 때 색상 */
  }

  .btn-info {
    background-color: #17a2b8; /* Bootstrap의 'info' 버튼 색상 */
  }

  .btn-info:hover {
    background-color: #138496; /* 호버 상태일 때 색상 */
  }

  .btn-danger {
    background-color: #dc3545; /* Bootstrap의 'danger' 버튼 색상 */
  }

  .btn-danger:hover {
    background-color: #c82333; /* 호버 상태일 때 색상 */
  }
</style>


<script type="text/javascript">
$(function(){
	$("#deleteBtn").click(function(e){
        e.preventDefault(); // 폼 제출 막기
        var password = prompt("비밀번호를 입력하세요:");
        if(password === null || password.trim() === "") {
            alert("비밀번호를 입력해야 탈퇴할 수 있습니다.");
            return;
        }
        
        // 비밀번호 확인 AJAX 요청
        $.ajax({
            url: "/member/checkPassword",
            type: "POST",
            data: { password: password },
            dataType:'json',
            success: function(data) {
                if(data.responsed) {
                    // 비밀번호 확인 후 탈퇴 처리 AJAX 요청
                    $.ajax({
                        url: "delete",
                        type: "POST",
                        success: function(deleteResponse) {
                            alert("탈퇴되었습니다.");
                            window.location.href = "/member/logout.do"; // 로그아웃 처리 후 메인 페이지로 리다이렉트
                        },
                        error: function() {
                            alert("탈퇴 처리 중 오류가 발생했습니다.");
                        }
                    });
                } else {
                    alert("비밀번호가 일치하지 않습니다.");
                }
            },
            error: function() {
                alert("비밀번호 확인 중 오류가 발생했습니다.");
            }
        });
    });
});
</script>

</head>
<body>
	<div class="container">
			<h1>${empty param.id?"내 정보 보기":"회원 정보 보기" }</h1>
		<div class="card-body">
			<div style="margin-bottom: 10px; padding: 0 15px;" class="row">
				<div id="searchDiv">
					<!-- form class="form-inline" -> bootstrap에서 한줄로 쭉 -->
					<form action="list.do" class="form-inline" id="searchForm">
						<input name="perPageNum" value="${pageObject.perPageNum }" type="hidden"/>
					</form>
				</div>
			</div>

	<table class="table">
		<tbody>
			<tr class="row">
				<th class="col-md-2">아이디</th>
				<td class="col-md-10">${vo.id }</td>
			</tr>
			<tr class="row">
				<th class="col-md-2">이름</th>
				<td class="col-md-10">${vo.name}</td>
			</tr>
			<tr class="row">
				<th class="col-md-2">이메일</th>
				<td class="col-md-10">${vo.email }</td>
			</tr>
			<tr class="row">
				<th class="col-md-2">전화번호</th>
				<td class="col-md-10">${vo.tel }</td>
			</tr>
			<tr class="row">
				<th class="col-md-2">우편번호</th>
				<td class="col-md-10">${vo.postalcode }</td>
			</tr>
			<tr class="row">
				<th class="col-md-2">기본주소</th>
				<td class="col-md-10">${vo.address }</td>
			</tr>
			<tr class="row">
				<th class="col-md-2">상세주소</th>
				<td class="col-md-10">${vo.detail_address }</td>
			</tr>
			<tr class="row">
				<th class="col-md-2">생년월일</th>
				<td class="col-md-10">${vo.birth }</td>
			</tr>
		</tbody>
	</table>
	
		<c:if test="${empty param.id }">
	<!-- 로그인 정보 표시에 내 정보 보기 클릭해서 넘어 왓다. -->
		<a href="update.do" class="btn btn-primary">수정</a>
		
	</c:if>
	<c:if test="${!empty param.id }">
	<!-- 회원 리스트에서 넘어 왓다. -->
<%-- 		<a href="updateForm.do?id=${param.id }&page=${param.page }&perPageNum=${param.perPageNum }&key=${parma.key }&word=${param.word}" --%>
<!-- 		 class="btn btn-default">수정</a> -->
	</c:if>
	<!-- Trigger the modal with a button -->
	<c:if test="${empty param.id }">
	<!-- 로그인 정보 표시에 내 정보 보기 클릭해서 넘어 왓다. -->
		<a href="delete.do" class="btn btn-primary" id="deleteBtn">회원탈퇴</a>
		<a href="changepw.do" class="btn btn-primary" id="deleteBtn">비밀번호 변경</a>
		<a href="/coupon/listMemCo.do" class="btn btn-primary" id="deleteBtn">쿠폰함 확인</a>
		<a href="list.do" class="btn btn-primary" id="deleteBtn">회원 리스트</a>
	</c:if>
	<c:if test="${!empty param.id }">
	<!-- 회원 리스트에서 넘어 왓다. -->
<%-- 		<a href="list.do?page=${param.page }&perPageNum=${param.perPageNum }&key=${parma.key }&word=${param.word}" --%>
<!-- 		 class="btn btn-primary">리스트</a> -->
		<a href="list.do" class="btn btn-primary">리스트</a>
	</c:if>
	
	</div>
</div>
</body>
</html>