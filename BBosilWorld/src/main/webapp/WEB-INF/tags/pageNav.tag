<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="pageObject" required="true"
 type="com.webjjang.util.page.PageObject" %>
<%@ attribute name="listURI" required="true"
 type="java.lang.String" %>
<%@ attribute name="query" required="false"
 type="java.lang.String" %> 

<% /** PageNation을 위한 사용자 JSP 태그  *
	 * 작성자 웹짱 이영환 강사 
	 * 작성일 2023.07.27
	 * 버전 5.0
	 * BootStrap 4 적용 / BootStrap-icon.css 적용
	 
	 * query 데이터가 있는 경우 - 일반 게시판 페이지 정보로 사용한다. (int=1 --> int=0 으로 바꿔서 사용)
	 *   - listURI="list.do"
	 *	 - query 정보는 페이지 정보 외에 전달할 다른 정보가 있으면 &key=value 형식으로 작성한다.
	 * 사용방법 :<pageObject:pageNav listURI="list"
	 			pageObject= "웹짱 페이지 객체" query="일반 게시판 페이지 정보 외 다른 전달 정보" />
   */ %>

<% request.setAttribute("noLinkColor", "#999"); %>
<% request.setAttribute("tooltip", " data-toggle=\"tooltip\" data-placement=\"top\" "); %>
<% request.setAttribute("noMove", " title=\"no move page!\" "); %>
<!-- bootstrap-icons : Bootstrap 4의 아이콘을 사용하려면 css 라이브러리 등록 필요 -->
<ul class="pagination">
  	<li class="page-item"  data-page=1>
		<c:if test="${pageObject.page > 1 && empty query}">
			<!-- 맨 첫페이지로 이동 : query가 없는 경우 - 일반 게시판 페이지 처리 -->
	  		<a class="page-link" href="${listURI }?page=1&${pageObject.notPageQuery}"
	  		  title="click to move first page!" ${tooltip } >
	  			<i class="bi bi-skip-start"></i>
	  		</a>
  		</c:if>
		<c:if test="${pageObject.page == 1 }">
	  		<a class="page-link" href="" onclick="return false"
	  		 ${noMove }  ${tooltip } >
	  			<i class="bi bi-skip-start"  style="color: ${noLinkColor};"></i>
	  		</a>
	  	</c:if>
	</li>
	
	
	<li class="page-item"  data-page=${pageObject.startPage -1 }>
		<c:if test="${pageObject.startPage > 1 }">
	  		<a class="page-link" href="${listURI }?page=${pageObject.startPage - 1 }&${pageObject.notPageQuery}${query}"
	  		  title="click to move previous page group!" ${tooltip } >
	  			<i class="bi bi-caret-left"></i>
	  		</a>
	  	</c:if>
		<c:if test="${pageObject.startPage == 1 }">
	  		<a class="page-link" href="" onclick="return false"
	  		 ${noMove } ${tooltip }>
	  			<i class="bi bi-caret-left" style="color: ${noLinkColor};"></i>
	  		</a>
	  	</c:if>
  	</li>
	<c:forEach begin="${pageObject.startPage }" end="${pageObject.endPage }" var="cnt">
  	<li class='page-item ${(pageObject.page == cnt)?"active":"" }'
  	 data-page=${cnt }>
  	 	<!-- 페이지와 cnt가 같으면 링크가 없음 -->
  	 	<c:if test="${pageObject.page == cnt }">
  			<a class="page-link" href="" onclick="return false"
  			 ${noMove } ${tooltip }>${cnt}</a>
  	 	</c:if>
  	 	<!-- 페이지와 cnt가 같지 않으면 링크가 있음 -->
  	 	<c:if test="${pageObject.page != cnt }">
  			<a class="page-link" href="${listURI }?page=${cnt }&${pageObject.notPageQuery}${query}"
	  		 title="click to move ${cnt } page" ${tooltip }>${cnt}</a>
  		</c:if>
  	</li>
	</c:forEach>
	<c:if test="${pageObject.endPage < pageObject.totalPage }">
	  	<li class="page-item"  data-page=${pageObject.endPage + 1 }>
	  		<a class="page-link" href="${listURI }?page=${pageObject.endPage + 1 }&${pageObject.notPageQuery}${query}"
	  		  title="click to move next page group!" ${tooltip } >
	  			<i class="bi bi-caret-right"></i>
	  		</a>
	  	</li>
  	</c:if>
	<c:if test="${pageObject.endPage == pageObject.totalPage }">
	  	<li class="page-item"  data-page=${pageObject.endPage + 1 }>
	  		<a class="page-link" href="" onclick="return false"
	  		 ${noMove }  ${tooltip } >
	  			<i class="bi bi-caret-right" style="color: ${noLinkColor};"></i>
	  		</a>
	  	</li>
  	</c:if>
	<c:if test="${pageObject.page < pageObject.totalPage }">
	  	<li class="page-item"  data-page=${pageObject.totalPage }>
	  		<a class="page-link" href="${listURI }?page=${pageObject.totalPage }&${pageObject.notPageQuery}${query}"
	  		  title="click to move last page!" ${tooltip } >
		  		<i class="bi bi-skip-end"></i>
	  		</a>
	  	</li>
  	</c:if>
	<c:if test="${pageObject.page == pageObject.totalPage }">
	  	<li class="page-item"  data-page=${pageObject.totalPage }>
	  		<a class="page-link" href="" onclick="return false"
	  		 ${noMove }  ${tooltip } >
		  		<i class="bi bi-skip-end" style="color: ${noLinkColor};"></i>
	  		</a>
	  	</li>
  	</c:if>
</ul> 

<script>
$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();
  $(".pagination").mouseover(function(){
//   		$(".tooltip > *:last").css({"background-color": "red", "border": "1px dotted #444"});   
	});
});
</script>
