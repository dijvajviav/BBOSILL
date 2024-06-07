<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기</title>

<style>
	.optionModalBtn:hover {
	cursor: pointer;
	}
</style>

<script>
$(document).ready(function() {
    // 폼 제출 이벤트를 감지합니다.
    $('.cart').submit(function(e) {
        // 폼의 기본 제출 이벤트를 방지합니다.
        e.preventDefault();

        // 폼 데이터를 FormData 객체로 생성합니다.
        var formData = new FormData(this);

        // AJAX 요청을 보냅니다.
        $.ajax({
            url: '/cart/write.do',
            type: 'POST',
            data: formData,
            processData: false, // FormData 객체를 사용할 때 필요
            contentType: false, // FormData 객체를 사용할 때 필요
            success: function(response) {
                // 사용자가 '예'를 선택할 경우 장바구니 페이지로 이동
                var moveToCart = confirm("장바구니에 물건을 담았습니다. 장바구니로 이동하시겠습니까?");
                if (moveToCart) {
                    window.location.href = '/cart/list.do';
                }
            },
            error: function(xhr, status, error) {
                // 오류 처리
                alert("장바구니에 담는 과정에서 오류가 발생했습니다.");
            }
        });
    });
});


</script>


<script>

var no = ${vo.itemNo};

console.log(no);

let replaceTR;

	$(function(){
		replaceTR = $(".pList"); 

		})



</script>



<script>
	$(function(){

//부트스트랩과 템플릿 충돌로 인해 모달태그 부모에 position속성이 설정되면, backdrop 클래스인 div가 화면 전체를 회색으로 덮는다.
//이를 막기 위해 body태그가 완전히 생성된 뒤에 모달창 html을 body끝쪽에 다시 생성한다. 임시방편으로 충돌을 피할 수 있다.
		$('#optionModal').appendTo("body");

		
		$("#deleteBtn").click(function(){
			if(!confirm("정말 삭제하시겠습니까?")) return false;
				
			});

		//옵션아이콘이나 버튼을 누르면 옵션을 관리하는 모달창을 띄운다.
		$(".optionModalBtn").click(function(){

		$("#optionModal").modal("show");
		


		})
		
	//옵션모달창의 추가 버튼들
	//#addType 버튼을 누르면 옵션종류 추가로 모달창의 내용을 바꾼다.
	
	$("#optionModal").on("click", "#addType" , function(){

	let html = "";

	html +=  "<div class=\"input-group mb-3 input-group-sm\" class =\"addType\">";
	html += 	"<div class=\"input-group-prepend\">";
	html += 		"<span class=\"input-group-text\">옵션 종류:</span>";
	html += 	"</div>";
	html += 	"<input class = \"form-control\" id = \"optionType\" name = \"optionType\">";
	html += "</div>";

	
	$("#optionInputs").html(html);
	$("#optionWrite").attr("action" , "/option/writeType.do");
	$("#putOptionBtn").text("등록하기");
	})		
	
	//#addValue 버튼을 누르면 옵션값 추가로 모달창의 내용을 바꾼다.
			
	let addValueHtml = $(".addValue").html();
			
	$("#optionModal").on("click", "#addValue" , function(){
	
	
	$("#optionInputs").html(addValueHtml);
	$("#optionWrite").attr("action" , "/option/writeValue.do");
	$("#putOptionBtn").text("등록하기");
	
	})		
	
	//#addOption 버튼을 누르면 상품옵션 추가로 모달창의 내용을 바꾼다.
	let addOptionHtml = $(".addOption").html();
	$("#optionModal").on("click", "#addOption" , function(){


	$("#optionInputs").html(addOptionHtml);
	$("#optionWrite").attr("action" , "/option/write.do");
	$("#putOptionBtn").text("등록하기");
	
	});		
		
	//optionModal 버튼을 클릭했을때, 한번만  html을 addOption html로바꾼다.
	$(".optionModalBtn").one("click", function(){

		$("#optionInputs").html(addOptionHtml);
		$("#optionWrite").attr("action" , "/option/write.do");
	
    });


    //옵션모달창의 삭제 버튼들
	//#deleteType 버튼을 누르면 옵션종류 삭제로 모달창의 내용을 바꾼다.
	
	let deleteTypeHtml = $("#typeSel").html();
	$("#optionModal").on("click", "#deleteType" , function(){

	
	$("#optionInputs").html(deleteTypeHtml);
	$("#optionWrite").attr("action" , "/option/deleteType.do");
	$("#putOptionBtn").text("삭제하기");
	})		
	
	//#deleteValue 버튼을 누르면 옵션값 삭제로 모달창의 내용을 바꾼다.
			
	let deleteValueHtml = $("#valueSel").html();
			
	$("#optionModal").on("click", "#deleteValue" , function(){
	
	
	$("#optionInputs").html(deleteValueHtml);
	$("#optionWrite").attr("action" , "/option/deleteValue.do");
	$("#putOptionBtn").text("삭제하기");
	})		
	
	//#deleteOption 버튼을 누르면 상품옵션 삭제로 모달창의 내용을 바꾼다.
	let deleteOptionHtml = $("#optionDeleteSel").html();
	$("#optionModal").on("click", "#deleteOption" , function(){


	$("#optionInputs").html(deleteOptionHtml);
	$("#optionWrite").attr("action" , "/option/deleteOption.do");
	$("#putOptionBtn").text("삭제하기");
	});		
	
	//#deleteOptionType 버튼을 누르면 상품옵션 종류 삭제로 모달창의 내용을 바꾼다.
	let deleteOptionTypeHtml = $("#distinctSel").html();
	$("#optionModal").on("click", "#deleteOptionType" , function(){


	$("#optionInputs").html(deleteOptionTypeHtml);
	$("#optionWrite").attr("action" , "/option/deleteOptionType.do");
	$("#putOptionBtn").text("삭제하기");
	});		
		
	//#deleteAllOption 버튼을 누르면 확인 창을 한번 띄우고, 예를 눌렀을 때만 상품의 모든 옵션을 제거한다.
	$("#optionModal").on("click", "#deleteAllOption" , function(){

	
	if(confirm("상품의 모든 옵션을 제거하시겠습니까?")){
	$("#optionWrite").attr("action" , "/option/deleteAllOption.do");
	$("#optionWrite").submit();
		}
	
	});		
		


	
	});
// $(function(){}) end

	
</script>

<script src = "/resources/js/price.js" ></script>
<script src = "/resources/js/priceProcess.js" ></script>

<style >
	
	th, td{
	padding : 5px 10px;
	}

</style>


</head>
<body>

<!-- Product Details Area Start -->
        <div class="single-product-area section-padding-100 clearfix">
            <div class="container-fluid">


                <div class="row">
                    <div class="col-12 col-lg-7">
                        <div class="single_product_thumb">
							<img src = "${vo.itemImage }">
                        </div>
                    </div>
                    <div class="col-12 col-lg-5">
                        <div class="single_product_desc">
                            <!-- Product Meta Data -->
                            <div class="product-meta-data">
                                <div class="line"></div>
                                    <h6>${vo.itemName }</h6>
                                <p class="producer" style="color: #99CCFF;">${vo.producer }</p>
                                <c:if test ="${vo.discount > 0 || vo.rate > 0 }">
                                <p class="product-price"><del>${vo.itemPrice }원</del></p>
                                </c:if>
                                <p class="product-price">${vo.price }원</p>
                              
                              <c:if test="${!empty login && login.gradeNo == 9 }">
                                <p class ="optionModalSec" >
                                <button class = "btn btn-sm optionModalBtn" style="width: 25%; height: 25%;"><i class="fa fa-pencil-square"></i> Option</button></p>
                              </c:if>
<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#optionModal"> -->
<!--   Open modal -->
<!-- </button> -->
                            </div>
                             <div class="short_overview my-5">
                                <p>${vo.itemContent }</p>
                            </div>

                            <!-- Add to Cart Form -->
                            <form action="/cart/write.do" class="cart clearfix" method="post">
						
						<c:if test="${!empty option }">
							<c:forEach items="${distinctType }" var = "dt" varStatus="vs">
							
					<div class="form-group">
						<div class="input-group">
							<div class ="input-group-prepend">
								<span class="input-group-text">${dt.optionType } </span>
							</div>
							
							<select id = "optionSelect${vs.index }" class = "form-control" name ="optionValueNo">
							
							<c:forEach items="${option }" var="opt">
								<c:if test="${dt.optionType == opt.optionType}" >
									<option value = "${opt.optionValueNo }" >${opt.optionValue }</option>
								</c:if>
							</c:forEach>
							
							</select>
						</div>
					</div>	
							
							</c:forEach>
						</c:if>
							
                           

                            	<input type ="hidden" value ="${vo.itemNo }" name ="itemNo">
                                <div class="cart-btn d-flex mb-50">
                                    <p>Qty</p>
                                    <div class="quantity">
                                        <span class="qty-minus" onclick="var effect = document.getElementById('qty'); var qty = effect.value; if( !isNaN( qty ) &amp;&amp; qty &gt; 1 ) effect.value--;return false;"><i class="fa fa-caret-down" aria-hidden="true"></i></span>
                                        <input type="number" class="qty-text" id="qty" step="1" min="1" max="300" name="count" value="1">
                                        <span class="qty-plus" onclick="var effect = document.getElementById('qty'); var qty = effect.value; if( !isNaN( qty )) effect.value++;return false;"><i class="fa fa-caret-up" aria-hidden="true"></i></span>
                                    </div>
                                </div>
                             <c:if test="${!empty login}">
                                <button type="submit" name="addtocart"  class="btn amado-btn">장바구니</button>
                             </c:if>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        
       <c:if test="${!empty login && login.gradeNo == 9 }">
		<a href="update.do?no=${vo.itemNo }&${pageObject.pageQuery}" class="btn btn-info">상품 수정</a>
		<a href="delete.do?no=${vo.itemNo }&deleteFile=${vo.itemImage}&${pageObject.pageQuery}" class="btn btn-info" id="deleteBtn">상품 삭제</a>
        
        
       	<form  method = "post">
       		<input class = "form-control" type ="hidden" id = "itemNo"name = "itemNo" 
       			value="${vo.itemNo }" >
       	<table>
       	<thead>
       		<tr>
       			<th>가격번호</th>
       			<th>시작일</th>
       			<th>종료일</th>
       			<th>가격</th>
       			<th>할인가</th>
       			<th>할인율</th>
       			<th>*</th>
       			<th>*</th>
       		
       		</tr>
       	</thead>
       	
       	<tbody class = "pList">
       		
       		
       		
       	</tbody>
       	
       	</table>
       	</form>
      </c:if>
	</div>
        <!-- Product Details Area End -->
       
       
       
        

	

  <!-- The Modal -->
  
  
  <div class="modal fade" id="optionModal" style="z-index: 1050;">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
      <form action = "/option/write.do" id = "optionWrite">
      	<input type = "hidden" value ="${vo.itemNo }" name = "itemNo">
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">옵션 관리</h4>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        <div id = "addButtons">
          <button type ="button" class = "btn btn-sm " id ="addType">옵션  종류 등록</button>
          <button type ="button" class = "btn btn-sm " id ="addValue" >옵션 값 등록</button>
          
          <button type ="button" class = "btn btn-sm " id ="deleteType">옵션  종류 삭제</button>
          <button type ="button" class = "btn btn-sm " id ="deleteValue" >옵션 값 삭제</button>
        </div>
        
        
       	<div id = "deleteButtons" style = "margin-top: 10px;">
          
          <button type ="button" class = "btn btn-sm " id ="addOption">상품 옵션 추가</button>
          <button type ="button" class = "btn btn-sm " id ="deleteOption">상품 옵션 삭제</button>
          <button type ="button" class = "btn btn-sm " id ="deleteOptionType">상품 옵션종류 삭제</button>
       	</div>	

		<hr style="margin-top : 15px;">
		
          <button type ="button" class = "btn btn-danger " id ="deleteAllOption">상품 옵션전체 삭제</button>
          
          <hr>
          
          
<!--           optionInputs start -->
          <div id = "optionInputs" >
          
<!-- 옵션타입 테이블 추가 -->
			<div class="input-group mb-3 input-group-sm" class ="addType">
				<div class="input-group-prepend">
					<span class="input-group-text">옵션 종류:</span>
				</div>
			</div>
		
			
<!-- 	옵션값테이블 추가 -->
		<div class ="addValue">
			<div id="typeSel">
				<div class="input-group mb-3 input-group-sm" >
					<div class="input-group-prepend">
						<span class="input-group-text">옵션 종류:</span>
					</div>
				      <select class="form-control"  name="optionNo">
				       <c:forEach items ="${optionType}" var = "ot">
				        <option value = "${ot.optionNo }">${ot.optionType }</option>
				       </c:forEach>
				      </select>
				</div>
			</div>
			
			
			<div class="input-group mb-3 input-group-sm" >
				<div class="input-group-prepend">
					<span class="input-group-text">옵션 값:</span>
				</div>
				<input class = "form-control" id = "optionType" name = "optionValue">
			</div>
			
		</div>
		
<!-- 		상품에 옵션추가 -->

		<div class ="addOption">
		
			<div class="input-group mb-3 input-group-sm" >
				<div class="input-group-prepend">
					<span class="input-group-text">상품 번호:</span>
				</div>
				<input class = "form-control" id = "optionType" name = "itemNo" value ="${vo.itemNo}" readonly>
			</div>
			
			<div class="input-group mb-3 input-group-sm" >
				<div class="input-group-prepend">
					<span class="input-group-text">상품 이름:</span>
				</div>
				<div class = "form-control">${vo.itemName }</div>
			</div>
			
			<div id="valueSel">
				<div class="input-group mb-3 input-group-sm" >
					<div class="input-group-prepend">
						<span class="input-group-text">옵션 :</span>
					</div>
					      <select class="form-control"  name="optionValueNo">
							<c:forEach items="${optionValue }" var="ov">
								
								<option value = "${ov.optionValueNo }">${ov.optionType } - ${ov.optionValue }</option>
								
							</c:forEach>
					      </select>
				</div>
			</div>
			
		</div>


		<div id = "distinctSel"> 
				<div class="input-group mb-3 input-group-sm" >
					<div class="input-group-prepend">
						<span class="input-group-text">상품옵션 종류:</span>
					</div>
				      <select class="form-control"  name="optionNo">
				       <c:forEach items ="${distinctType}" var = "dt">
				        <option value = "${dt.optionNo }">${dt.optionType }</option>
				       </c:forEach>
				      </select>
				</div>
		</div>
		
		<div id = "optionDeleteSel"> 
				<div class="input-group mb-3 input-group-sm" >
					<div class="input-group-prepend">
						<span class="input-group-text">옵션 값:</span>
					</div>
				      <select class="form-control"  name="optionValueNo">
				       <c:forEach items ="${option}" var = "opt">
				        <option value = "${opt.optionValueNo }">${opt.optionValue }</option>
				       </c:forEach>
				      </select>
				</div>
		</div>
		
		

          </div>
<!--           optionInputs End -->
          
        </div>
        <div class = "row">
        <div class ="col text-center">
        <button id = "putOptionBtn" class = "btn btn-sm " >등록하기</button>
        </div>
        </div>
        	
        </form>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        </div>
        
      </div>
    </div>
  </div>
	

</body>
</html>