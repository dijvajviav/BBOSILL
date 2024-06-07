<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NOTICE</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

 <script>
        $(document).ready(function() {
            var now = new Date();
            var toDayYear = now.getFullYear();
            var yearRange = (toDayYear - 100) + ":" + toDayYear;

            $("#startDate").datepicker({
                changeMonth: true,
                changeYear: true, 
                yearRange: yearRange,
                dateFormat: "yy-mm-dd",
                dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
                monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            });


            $("#endDate").datepicker({
                changeMonth: true,
                changeYear: true,
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
			<h2>&nbsp;&nbsp;공지사항 수정</h2>
		
		
		<div class="card-body">
		  <form action="update.do" method="post" class="was-validated">
		  	
		    <div class="form-group">
		      <label for="no">번호:</label>
		      <input type="text" class="form-control" name="no" value="${vo.no }" readonly>
		    </div>

				<div class="form-group">
					<label for="title">제목:</label> <input type="text"
						class="form-control" id="title" name="title" required
						pattern="^.{3,100}" value="${vo.title }">
					<div class="valid-feedback">적당한 데이터를 입력하셨습니다.</div>
					<div class="invalid-feedback">이 항목은 필수 입력이고 3자이상 100자 이내로
						작성하셔야 합니다.</div>
				</div>

				<div class="form-group">
					<label for="content">내용:</label>
					<textarea class="form-control" rows="5" id="content" name="content"
						required>${vo.content }</textarea>
					<div class="valid-feedback">적당한 데이터를 입력하셨습니다.</div>
					<div class="invalid-feedback">내용은 필수 입력니다.</div>
				</div>

				<!-- 공지시작 날짜 -->
				<div class="form-group">
					<label for="startDate">공지시작 날짜:</label> 
					<input type="text" class="form-control" id="startDate" name="startDate" value="${vo.endDate}" required readonly style="background: #fff;">
				</div>

				<!-- 공지종료 날짜 -->
				<div class="form-group">
					<label for="endDate">공지종료 날짜:</label> <input type="text"
						class="form-control" id="endDate" name="endDate"value="${vo.endDate }" required readonly style="background: #fff;">
				</div>


			<button type="submit" class="btn btn-primary">수정</button>
		    <button type="reset" class="btn btn-info">다시입력</button>
		    <button type="button" class="btn btn-warning cancelBackBtn">취소</button>
		  </form>
		</div>
	</div>
</body>
</html>