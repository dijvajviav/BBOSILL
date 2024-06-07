<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일반게시판 리스트</title>
<style type="text/css">
	.dataRow:hover{
		background: #e0e0e0;
		cursor: pointer;
	}
</style>

<script type="text/javascript">
$(function(){
	// 글보기로 이동 시키는 이벤트 처리
	$(".dataRow").click(function(){
		let id = $(this).find(".id").text();
		// alert(no);
		location = "view.do?id=" + id
				+ "&${pageObject.pageQuery}";
	});
	
	
	// 검색의 키 데이터 세팅
	${(!empty pageObject.key && !empty pageObject.word)? "$('#key').val('" += pageObject.key += "');" : ""}
	// perPageNum 데이터 세팅
	$("#perPageNum").val(${pageObject.perPageNum});
	
	// 한페이당 보여주는 데이터 개수 변경하는 이벤트
	$("#perPageNum").change(function(){
		location = "list.do?page=1&perPageNum=" + $("#perPageNum").val()
				+ "&key=${pageObject.key}&word=${pageObject.word}"
	});
});
</script>

</head>
<body>
	<div class="container">
		<h1>회원 리스트</h1>
			<!-- 검색 & perPageNum -->
			<!-- 게시판의 검색 : 제목, 내용, 작성자, 그외 복합 
					페이지는 1페이지, 한페이지에 표시할 데이터 갯수 전달. : hidden-->
			<div style="margin-bottom: 10px; padding: 0 15px;" class="row">
				<div id="searchDiv">
					<!-- form class="form-inline" -> bootstrap에서 한줄로 쭉 -->
					<form action="list.do" class="form-inline" id="searchForm">
						<input name="perPageNum" value="${pageObject.perPageNum }" type="hidden"/>
						<div class="input-group">
						
							<div class="input-group-prepend">
								<select class="form-control" id="key" name="key">
									<option value="id" >아이디</option>
									<option value="name" >이름</option>
									<option value="email" >이메일</option>
									<option value="status" >상태</option>
									<option value="gradeName" >등급명</option>
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
			</div>

			<table class="table">
	<thead>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
			<th>전화번호</th>
			<th>상태</th>
			<th>등급명</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${list }" var="vo">
	<!-- items - Contoller에서 담아 놓은 여러개의 VO 데이터를 request에 담겨져 있는 것은 꺼내서 표시하자.
		 vo - items에서 데이터를 한개씩 꺼내서 저장해 놓은 이름 - pageContext에 저장된다. : 현재 JSP만 사용 -->
		<tr class="dataRow">
			<td class="id">${vo.id }</td>
			<td>${vo.name }</td>
			<td>${vo.email }</td>
			<td>${vo.tel }</td>
			<td>${vo.status }</td>
			<td>${vo.gradeName }</td>
		</tr>
	</c:forEach>
	</tbody>
	</table>
		<div class="card-footer">
			<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
		</div>
	</div>
</body>
</html>