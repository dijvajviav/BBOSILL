<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri  ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 리스트</title>

<style >

.dataRow:hover{
cursor: pointer;
background: #e0e0e0;
}

</style>

<script>
$(function(){
	
	$(".dataRow").click(function(){
		let no = $(this).find(".no").text();
		

		location = "view.do?no=" + no + "&inc=1" + "&${pageObject.pageQuery}";
		
	});

	//한 페이지 당 보여줄 데이터의 갯수(perPageNum) 변경 이벤트 
		$("#perPageNum").change(function(){
			$("#searchForm").submit();
			});

//		검색 데이터 세팅
		// key는 값이 없으면 t(제목)로 기본 세팅한다.
		$("#key").val("${(empty pageObject.key)?'n': pageObject.key}");
		$("#perPageNum").val("${pageObject.perPageNum}");
})
	


</script>

</head>
<body>



 <div class="amado_product_area section-padding-100" style = "width:auto; max-width: none;">
            <div class="container-fluid">
		
	<!-- 	  검색기능  : 상품명, 제조사, 가격  -->
	  	<div style="margin-bottom: 10px; padding : 0px 15px;" class="row">
		<div id="searchDiv">
			<form action="list.do" class="form-inline" id = "searchForm">
				<input name="page" value="1" type="hidden"/>
				<input name="categoryNo" value = "${param.categoryNo }" type ="hidden" >
				
				<div class = "input-group">
				<div class = "input-group-prepend">
				<div class="form-group">
					<select class="form-control" id="key" name="key">
						<option value="n" >상품명</option>
						<option value="p" >제조사</option>
					</select>
				</div>
				</div>
				</div>
				<div class="input-group">
					<input type="text" class="form-control" placeholder="Search"
						name="word" value="${pageObject.word }">
					<div class="input-group">
						<button class="btn btn-primary" type="submit">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</div>
				<div class="input-group float-right">
					<span class="input-group-text">Rows</span>
<!-- 					append , prepend : 동일 계층 요소의 앞이나 뒤에 붙인다 -->
				  <select class="form-control" id="perPageNum" name = "perPageNum">
				    <option >8</option>
				    <option >12</option>
				    <option >16</option>
				  </select>
				</div>
			</form>
		</div>
	  </div>
<!-- 	  검색 창 끝 -->

                <div class="row">
                    <div class="col-12">
                        <div class="product-topbar d-xl-flex align-items-end justify-content-between">
                           
                            <!-- Sorting -->
                        </div>
                    </div>
                </div>




<!-- 상품 리스트 표시 시작 부분 -->
                <div class="row">

					
		<c:forEach items="${list }" var = "vo" varStatus="vs">
 		<c:if test="${vs.index !=0 && vs.index % 4 == 0 }">
 		
 			${"</div>" }

 			${"<div class = \"row\"> "}
 			
 			
		</c:if>
 		
                    <!-- Single Product Area -->
                    <div class="col-12 col-sm-6 col-md-12 col-xl-3" >
                        <div class="single-product-wrapper dataRow" >
                            <!-- Product Image -->
                            <div class="product-img" style ="position: relative;">
                                <img src="${vo.itemImage }" alt="noImg" >
                            </div>
							<div style ="display:none;" class="no">${vo.itemNo }</div>
                            <!-- Product Description -->
                            <div class="product-description d-flex align-items-center justify-content-between">
                                <!-- Product Meta Data -->
                                <div class="product-meta-data">
                                    <div class="line"></div>
                                     <c:if test ="${vo.discount > 0 || vo.rate > 0 }">
                                    <p class="product-price"><del>${vo.itemPrice }원</del></p>
                                    </c:if>
                                    <p class="product-price">${vo.price }원</p>
                                        <div style ="color : orange;"> ${vo.categoryName}</div>
                                        <div> ${vo.itemName }</div> 
                                </div>
                                <!-- Ratings & Cart -->
<!--                                 <div class="ratings-cart text-right"> -->
<!--                                     <div class="ratings"> -->
<!--                                         <i class="fa fa-star" aria-hidden="true"></i> -->

<!--                                         <i class="fa fa-star" aria-hidden="true"></i> -->
<!--                                         <i class="fa fa-star" aria-hidden="true"></i> -->
<!--                                         <i class="fa fa-star" aria-hidden="true"></i> -->
<!--                                         <i class="fa fa-star" aria-hidden="true"></i> -->
<!--                                     </div> -->
<!--                                     <div class="cart"> -->
<!--                                         <a href="cart.html" data-toggle="tooltip" data-placement="left" title="Add to Cart"><img src="img/core-img/cart.png" alt=""></a> -->
<!--                                     </div> -->
                                </div>
                            </div>
                        </div>
<!--                     Single product end -->

		

		</c:forEach>
                    </div>
                     
                </div>
<!-- 상품 리스트 표시 row 끝부분 -->
 <c:if test="${!empty login && login.gradeNo == 9 }">
                <a href="write.do" class="btn amado-btn mb-15">상품 등록</a>
</c:if>

 <pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />

                
            </div>
<!--         </div> -->



</body>
</html>