<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<style>
  body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
  }

  .container {
    max-width: 600px;
    background-color: #fff;
    padding: 50px;
    margin: 50px auto; 
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    border-radius: 5px;
    text-align: center;
  }

  h2 {
    color: #333;
    margin-bottom: 30px;
    font-size: 24px;
  }

  .form-group {
    margin-bottom: 15px;
    text-align: left;
    
  }

  label {
    display: block;
    margin-bottom: 5px;
    font-size: 18px;
  }

  input[type="text"],
  input[type="email"],
  input[type="password"] {
    width: 100%;
    padding: 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-bottom: 10px;
    font-size: 18px;
  }

  .btn {
    width: 100%;
    padding: 20px 0;
    border: none;
    border-radius: 5px;
    margin-bottom: 10px;
    background-color: #ffc107; /* Primary color */
    color: white;
    font-size: 18px
  }

  .btn:hover {
    background-color: #e0a800;
  }

  .btn-default {
    background-color: #6c757d; /* Secondary color */
  }

  .btn-default:hover {
    background-color: #545b62;
  }

  a.btn {
    text-decoration: none;
    display: inline-block;
    width: calc(50% - 4px);
    margin-right: 4px; /* Ensure that the buttons don't touch */
  }

  a.btn:last-child {
    margin-right: 0;
  }

  /* Adjust the bottom margin for the last form-group for better spacing */
  .form-group:last-child {
    margin-bottom: 30px;
  }
  
  
input[type="password"],
.btn {
  font-size: 20px; /* 입력 필드와 버튼의 글꼴 크기를 증가 */
}
</style>

<!-- jquery UI 라이브러리 등록 : CDN 방식 -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script type="text/javascript">
	$(function() {
		$("#changepw").submit(function() {
			// 비밀번호와 비밀번호 확인이 같아야 데이터를 넘긴다.
			if ($("#pw").val() != $("#pw2").val()) {
				alert("변경하실 비밀번호와 비밀번호 확인은 같아야 합니다.");
				// 데이터 지우기
				$("#pw").val("");
				$("#pw2").val("");
				// 커서를 비밀번호 입력란으로 이동시킨다.
				$("#pw").focus();
				// submit 취소시킨다.
				return false;
			}
		});
	});
</script>

</head>
<body>
	<div class="container">
	  <h2>비밀번호 변경</h2>

		<div class="card-body">
		  <form action="changepw.do" method="post" class="was-validated" id="changepw" >
		  	<c:choose>
		        <c:when test="${!empty login }">
		            <input type="hidden" class="form-control" id="id" name="id" value="${login.id }" required>
		        </c:when>
		        <c:otherwise>
		            <input type="hidden" class="form-control" id="id" name="id" value="${vo.id }" required>
		        </c:otherwise>
    		</c:choose>
		  
		  
		    <div class="form-group">
		      <label for="pw">변경하실 비밀번호:</label> 
		      <input type="password" class="form-control" id="pw" name="pw" required pattern="^.{4,20}$" maxlength="20">
		    </div>
		    
		    <div class="form-group">
		      <label for="pw2">변경하실 비밀번호 확인:</label> 
		      <input type="password" class="form-control" id="pw2" required pattern="^.{4,20}$" maxlength="20">
		    </div>
		    
		      <button type="submit" class="btn btn-primary">변경하기</button>
		  </form>
		</div>
	</div>
</body>
</html>