<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
		 <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>NOTICE</title>
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
    $(document).ready(() => {
        $('.btn.btn-info').click(() => {
            $.ajax({
                url: 'deleteExpiredNotices.do',
                type: 'POST',
                success: (response) => {
                    const data = JSON.parse(response);
                    if (data.success) {
                        alert("기간이 지난 공지사항들이 삭제되었습니다.");
                        location.reload(); // 페이지를 새로고침하여 최신 상태로 표시
                    } else {
                        alert("삭제에 실패했습니다.");
                    }
                },
                error: () => {
                    alert("서버와의 통신 중 오류가 발생했습니다.");
                }
            });
        });
    });
</script>





<style type="text/css">
			@media screen and (max-width: 768px) { /* 768px 미만일 때 적용할 스타일 */
		  .container {
		    overflow: auto; /* 컨테이너에 스크롤바를 추가 */
		 	 }
			}  
</style>

</head>
<body>
	<div class="container">
			<h2>NOTICE</h2>
			<hr style="border-top: 2px solid black;">
			
			<c:if test="${login != null && login.gradeNo == 9 }">
			<div style="padding: 5px;">
			<!--기간이 지난 공지들을 데이터베이스에서 지워준다 -->
			<button class = "btn btn-info">공지 정리</button>
			</div>
			</c:if>
		
			
			<!-- 실제적인 데이터가 들어가는 부분입니다. -->
				<!-- 데이터 card의 시작 -->
				<table class="table" style="margin: 4px 0">
					<thead style="background: #e0e0e0">
					<tr>
					<th>NO</th>
					<th>TITLE</th>
					<th>WRITE DATE</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${list }" var="vo">
						<tr class="dataRow">
							<td class="no">${vo.no }</td>
							<td><a href="view.do?no=${vo.no}">${vo.title }</a></td>
							<td>
							    <fmt:parseDate value="${vo.writeDate}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedDate" />
							    <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
							</td>
						</tr>
					</c:forEach>
					</tbody>
					</table>
				<!-- 데이터 card의 끝 -->
				
		<div class="footer">
			  <pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
   
</div>
		<BR><BR>
		
		<!-- 검색 & perPageNum -->
			<!-- 게시판의 검색 : 제목, 내용, 작성자, 그외 복합 
					페이지는 1페이지, 한페이지에 표시할 데이터 갯수 전달. : hidden-->
			<div style="margin-bottom: 10px; padding: 0 15px;" class="row">
				<div id="searchDiv" class="col-md-8">
					<!-- form class="form-inline" -> bootstrap에서 한줄로 쭉 -->
					<form action="list.do" class="form-inline" id="searchForm">
						<input name="page" value="1" type="hidden"/>
						<div class="input-group">
							<div class="input-group-prepend">
								<select class="form-control" id="key" name="key">
									<option value="t" >제목</option>
									<option value="c" >내용</option>
									<option value="tc" >제목/내용</option>
									<option value="tcw" >전체</option>
								</select>
							</div>
							<input type="text" class="form-control" placeholder="Search"
								name="word" value="${pageObject.word }">
							<div class="input-group-append">
								<button class="btn btn-primary" type="submit">
									<i class="bi bi-search"></i>
								</button>
							</div>
						</div>
						<div class="input-group float-right">
							<div class="input-group-prepend">
								<span class="input-group-text">Rows</span>
							</div>
							<select class="form-control" id="perPageNum" name="perPageNum">
							  <option >10</option>
							  <option >15</option>
							  <option >20</option>
							</select>
						</div>
					</form>
				</div>
				 <c:if test="${!empty login && login.gradeNo == 9 }">
				 <!-- 관리자만 볼 수 있다. : 로그인이 되어 있어야 한다. gradeNo = 9 -->
				 <div class="col-md-4 text-right">
			<a href="write.do?perPageNum=${pageObject.perPageNum }" class="btn btn-primary">등록</a>
			</div>
			</c:if>
			<!-- 검색 & perPageNum 끝 -->
		
			</div>
			</div>
			
</body>
</html>