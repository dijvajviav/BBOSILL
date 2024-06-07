<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
		 <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>NOTICE</title>
	
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>


<script type="text/javascript">

</script>
</head>
<body>
	<div class="container">
	
		<div class="card-header" style="background: #ffcc00">
			<h2>NOTICE</h2>
		</div>
		
		<div class="card-body">
			<!-- 실제적인 데이터가 들어가는 부분입니다. -->
			<!-- 데이터 list의 시작 -->
			<ul class="list-group">
			  <li class="list-group-item font-weight-bolder">
			  	${vo.title }
			  	<span class="badge badge-danger badge-pill float-right"></span>
			  </li>
			  <li class="list-group-item" style="height:300px;">${vo.content }</li>
			  <li class="list-group-item"><span class="float-right"> 작성일:"${vo.writeDate }"</span> </li>
			</ul>
		</div>
		
	<c:choose>
    <%-- 관리자인 경우 --%>
    <c:when test="${!empty login && login.gradeNo == 9}">
        <div class="card-footer" style="background-color: white; border: none;">
            <a href="update.do?no=${vo.no}&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}" class="btn btn-primary">수정</a>
            <a href="delete.do?no=${vo.no}" class="btn btn-primary">삭제</a>
      
            <a href="list.do?page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}" class="btn btn-info">목록으로</a>
        </div>
    </c:when>
    <%-- 관리자가 아닌 경우 --%>
    <c:otherwise>
        <div class="card-footer" style="background-color: white; border: none;">
            <a href="list.do?page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}" class="btn btn-info">목록으로</a>
        </div>
    </c:otherwise>
</c:choose>
	</div>
 </body>
</html>