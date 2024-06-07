<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Title  -->
<title>장바구니</title>

<!-- Favicon  -->
<link rel="icon" href="img/core-img/favicon.ico">

<!-- Core Style CSS -->
<link rel="stylesheet" href="css/core-style.css">
<link rel="stylesheet" href="style.css">

<!-- Custom CSS -->
<style>
/*     	쿠폰함 모달을 위한 스타일 */

/* 모달 스타일 */
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
}

.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
/*     	쿠폰함 모달을 위한 스타일 */
.cart-table-area .table-responsive {
	overflow-x: auto; /* Enables horizontal scrolling */
}

.cart-table-area .table th, .cart-table-area .table td {
	white-space: nowrap; /* Prevents text from wrapping */
	padding: 10px; /* Adjust padding */
	font-size: 0.85em; /* Adjust font size */
}

.cart-summary {
	float: none; /* Remove float */
	margin-top: 0; /* Adjust margin */
}

.cart-summary .cart-btn a {
	white-space: nowrap; /* Prevent text from wrapping */
	font-size: 0.95em; /* Adjust button font size */
}
</style>

<style>
.dataRow {
	cursor: pointer; /* 손가락 모양 커서로 변경 */
}

.coupon-item {
	cursor: pointer;
}
</style>

<script>
// 전역 변수로 쿠폰 할인을 저장합니다.
var couponDiscount = 0;

$(document).ready(function() {
    // 페이지 로드 시 합계를 업데이트합니다.
    updateTotal();

    // 수량 감소 버튼 클릭 이벤트
    $('.qty-minus').click(function() {
        var cno = $(this).data('cart-no');
        var effect = this.nextElementSibling;
        var count = parseInt(effect.value, 10);
        if(!isNaN(count) && count > 1) {
            //effect.value = count - 1;
            updateQuantity(cno, effect.value);
        }
        updateTotal();
    });

    // 수량 증가 버튼 클릭 이벤트
    $('.qty-plus').click(function() {
        var cno = $(this).data('cart-no');
        var effect = this.previousElementSibling;
        var count = parseInt(effect.value, 10);
        if(!isNaN(count)) {
           // effect.value = count + 1;
            updateQuantity(cno, effect.value);
        }
        updateTotal();
    });

 // 쿠폰 목록을 불러오고 클릭 이벤트를 처리합니다.
    $('#viewCouponsBtn').click(function() {
        $.ajax({
            url: '/coupon/getUserCoupons',
            type: 'post',
            dataType: 'json',
            success: function(response) {
                if(response.status == 'success') {
                    var coupons = response.coupons;
                    var couponListHtml = '';
                    $.each(coupons, function(index, coupon) {
                        // 'undefined' 문제를 해결하기 위해 쿠폰 정보를 정확히 참조하도록 수정
                        couponListHtml += '<li class="coupon-item" data-discount="' + coupon.discountvalue + '" data-couponno="' + coupon.couponNo + '">' + coupon.couponname + ' - 할인금액: ' + coupon.discountvalue + '원</li>';
                    });
                    $('#couponList').html(couponListHtml);
                    $('#couponModal').show();
                } else {
                    alert('쿠폰 목록을 불러오는 데 실패했습니다.');
                }
            },
            error: function() {
                alert('서버 오류로 쿠폰 목록을 불러오는 데 실패했습니다.');
            }
        });
    });

    // 모달 닫기 이벤트
    $('.close').click(function() {
        $('#couponModal').hide();
    });
    window.onclick = function(event) {
        if (event.target == document.getElementById('couponModal')) {
            $('#couponModal').hide();
        }
    };

    // 쿠폰 선택 이벤트
    $(document).on('click', '.coupon-item', function() {
        couponDiscount = parseInt($(this).data('discount'));
        $('#couponDiscount').text(couponDiscount + '원');
        updateTotal();
        $('#couponModal').hide();
    });
});

// 서버에 수량 업데이트를 전송하고 합계를 업데이트하는 함수입니다.
function updateQuantity(cno, count) {
    $.ajax({
        url: '/cart/updateQuantity',
        type: 'post',
        data: { 'cno': cno, 'count': count },
        success: function(response) {
            if(response == 'success') {
                console.log('Quantity updated successfully');
            } else {
                alert('수량 업데이트에 실패했습니다.');
            }
        },
        error: function() {
            alert('수량 업데이트에 실패했습니다.');
        }
    });
}

// 최종 합계를 업데이트하는 함수입니다.
function updateTotal() {
    var total = 0;
    $('.itemRow').each(function() {
        var price = parseInt($(this).find('.itemPrice').text().replace('원', ''), 10);
        var quantity = parseInt($(this).find('.qty-text').val(), 10);
        total += price * quantity;
    });
    var finalTotal = total - couponDiscount;
    $('#totalPrice').text(total + '원');
    $('#finalTotal').text(finalTotal + '원');
  // 쿠폰 할인을 항상 보여주는 부분을 업데이트하는 함수입니다.	
 $('#couponDiscount').text(couponDiscount + '원');
    var finalTotal = total - couponDiscount;
    $('#finalTotal').text(finalTotal.toLocaleString() + '원'); // 최종 금액을 포매팅하여 표시합니다.
}

// 장바구니 항목을 삭제하는 함수입니다.
$('.delete-btn').click(function(e) {
    e.preventDefault();
    var cno = $(this).data('cart-no');
    deleteItem(cno, $(this));
});

function deleteItem(cno, button) {
    $.ajax({
        url: '/cart/delete',
        type: 'post',
        data: { 'cno': cno },
        success: function(result) {
            if(result == 'success') {
                button.closest('tr').remove();
                updateTotal(); // 항목을 삭제한 후에 총합을 업데이트합니다.
            } else {
                alert('삭제 처리에 실패했습니다.');
            }
        },
        error: function() {
            alert('삭제 처리에 실패했습니다.');
        }
    });
}
</script>


<!-- 쿠폰함 클릭 시 쿠폰 리스트를 불러오는 스크립트 -->
<script>
$(document).ready(function() {
    // 쿠폰함 버튼 클릭 이벤트
    $('#viewCouponsBtn').click(function() {
        $.ajax({
            url: '/coupon/getUserCoupons', // 서버 측 처리 URL
            type: 'post',
            dataType: 'json', // 응답 데이터 타입
            success: function(response) {
                if(response.status == 'success') {
                    var coupons = response.coupons;
                    
                 	// 쿠폰함 버튼 클릭 이벤트 내에서 쿠폰 목록을 생성하는 부분
                    var couponListHtml = '';
                    $.each(coupons, function(index, coupon) {
                        couponListHtml += '<li class="coupon-item" data-discount="' + coupon.discountvalue + '" data-couponno="' + coupon.couponNo + '">' + coupon.couponname + ' - 할인금액: ' + coupon.discountvalue + '원</li>';
                    });
                    $('#couponList').html(couponListHtml);
                    
                    // 모달을 표시합니다.ㄹ
                    $('#couponModal').show();
                } else {
                    alert('쿠폰 목록을 불러오는 데 실패했습니다.');
                }
            },
            error: function() {
                alert('서버 오류로 쿠폰 목록을 불러오는 데 실패했습니다.');
            }
        });
    });
    
    // 모달 닫기 버튼 클릭 이벤트
    $('.close').click(function() {
        $('#couponModal').hide();
    });
    
    // 모달 바깥 영역 클릭 시 모달 닫기
    window.onclick = function(event) {
        if (event.target == document.getElementById('couponModal')) {
            $('#couponModal').hide();
        }
    }
});

// 쿠폰 클릭 이벤트 처리

$(document).ready(function() {
    // 쿠폰 목록을 보여주는 부분에 클릭 이벤트를 추가
    $(document).on('click', '.coupon-item', function() {
    	  var discountvalue = parseInt($(this).data('discount')); // 할인 금액을 데이터 속성에서 가져옴
    	    $('#couponDiscount').text(discountvalue + '원'); // 쿠폰 할인 금액을 업데이트
    	    
    	    // 최종 합계를 계산하기 위해 현재의 총 합계를 가져옵니다.
    	    var currentTotal = parseInt($('#totalPrice').text().replace('원', ''));
    	    var finalTotal = currentTotal - discountvalue; // 최종 합계에서 할인 금액을 뺌
    	    $('#finalTotal').text(finalTotal + '원'); // 최종 합계를 업데이트

    	    $('#couponModal').hide(); // 쿠폰 선택 후 모달을 닫음
    });
});


couponListHtml += '<li class="coupon-item" data-discount="' + coupon.discountvalue + '">' + coupon.couponname + ' - 할인금액: ' + coupon.discountvalue + '원</li>';

</script>


<!-- 쿠폰함 클릭 시 쿠폰 리스트를 불러오는 스크립트 -->

<script>
    // 페이지가 로드될 때 실행됩니다.
    // 장바구니 리스트의 각 행을 삭제하는 스크립트
    $(function(){
        // 삭제 버튼 클릭 이벤트를 바인딩합니다.
       $('.delete-btn').on('click', function(event){
	        event.preventDefault(); // 기본 이벤트 방지
	        var cno = $(this).data('cart-no');
	        deleteItem(cno, $(this));
        });

        function deleteItem(cno, button) {
            $.ajax({
                url: '/cart/delete', // 컨트롤러의 삭제 처리 URL
                type: 'post', // HTTP 메서드
                data: { cno: cno }, // 전송할 데이터
                success: function(result) {
                    // 삭제 요청 성공 시
                    if(result == 'success') {
                        // 해당 행을 화면에서 제거합니다.
                        button.closest('tr').remove();
                    } else {
                        alert('삭제 처리에 실패했습니다.');
                    }
                },
                error: function() {
                    alert('삭제 처리에 실패했습니다.');
                }
            });
        }
    });
</script>

<script>
	// 장바구니 리스트에서 클릭된 상품 상세 페이지로 이동
    $(function(){
        // <tr> 요소의 클릭 이벤트를 처리합니다.
           $(".view-detail").click(function(){
        // 클릭된 요소가 속한 행에서 data-item-no 속성의 값을 가져옵니다.
        var itemNo = $(this).closest("tr").data("item-no");
        // 상품 상세 페이지로 이동합니다.
        location.href = "/item/view.do?no=" + itemNo + "&inc=0";
        });
    });
</script>

<script>
// 쿠폰함 모달 관련 스크립트
var modal = document.getElementById('couponModal');
var btn = document.getElementById('viewCouponsBtn');
var span = document.getElementsByClassName('close')[0];

btn.onclick = function() {
    modal.style.display = "block";
}

span.onclick = function() {
    modal.style.display = "none";
}

window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>




</head>

<body>
	<div class="cart-table-area section-padding-100">
		<div class="container-fluid">
			<div class="row">
				<div class="col-12 col-lg-9">
					<div class="cart-title mt-50">
						<h2>장바구니</h2>
					</div>
					<div class="cart-table clearfix">
						<table class="table table-responsive">

							<thead>
								<tr>
									<th></th>
									<th>상품명</th>
									<th>판매가</th>
									<th>수량</th>
									<th>삭제</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${list }" var="vo">
									<!--       이게 하나다 -->
									<tr class="itemRow" data-item-no="${vo.itemNo}">
										<td class="cart_product_img dataRow view-detail"><a
											href="#"><img src="${vo.itemImage}" alt="Product"></a>
										</td>

										<td class="cart_product_desc dataRow view-detail">
											<h5>${vo.itemName}</h5>
											 <div style="font-size: 0.85em;">${vo.optionnames}</div>
										</td>

										<td class="itemPrice"><c:choose>
												<c:when test="${vo.discount > 0 or vo.rate > 0}">
													<!-- 할인이 적용된 경우: 기존 가격에 빨간 줄 적용 -->
													<div style="text-decoration: line-through; color: red;">${vo.itemPrice}원</div>
													<!-- 할인된 가격 표시 -->
													<div>${vo.price}원</div>
												</c:when>

												<c:otherwise>
													<!-- 할인이 없는 경우: 단순히 가격 표시 -->
													<div>${vo.itemPrice}원</div>
												</c:otherwise>
											</c:choose></td>

										<td class="qty">
											<div class="qty-btn d-flex">
												<span class="qty-minus" data-cart-no="${vo.cno}"
													onclick="var effect = this.nextElementSibling; var qty = effect.value; if(!isNaN(qty) && qty > 1) { effect.value--; updateQuantity(${vo.cno}, effect.value);}"><i
													class="fa fa-minus" aria-hidden="true"></i></span> <input
													type="number" class="qty-text" id="qty${vo.cno}" step="1"
													min="1" max="300" name="quantity" value="${vo.count}">
												<span class="qty-plus" data-cart-no="${vo.cno}"
													onclick="var effect = this.previousElementSibling; var qty = effect.value; if(!isNaN(qty)) { effect.value++; updateQuantity(${vo.cno}, effect.value);}"><i
													class="fa fa-plus" aria-hidden="true"></i></span>
											</div>
										</td>
										<td class="action"><a href="#" class="btn btn-secondary delete-btn"
											data-cart-no="${vo.cno}">삭제</a></td>
									</tr>

								</c:forEach>
								<!--       이게 하나다 -->
							</tbody>
						</table>
					</div>
				</div>
				<div class="col-12 col-lg-3">
					<div class="cart-summary">
						<h5>장바구니 합계</h5>
						<ul class="summary-table">
							<li><span>합계:</span> <span id="totalPrice">0원</span></li>
							<li><span>쿠폰 할인:</span> <span id="couponDiscount">0원</span></li>
							<li><span>최종 합계:</span> <span id="finalTotal">0원</span></li>
						</ul>
						<div class="cart-btn mt-100">
							<button id="viewCouponsBtn" class="btn amado-btn w-100">쿠폰함</button>
							<a href ="/orders/writeForm.do" class ="btn amado-btn w-100">주문하기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Popper js -->
	<script src="js/popper.min.js"></script>
	<!-- Bootstrap js -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Plugins js -->
	<script src="js/plugins.js"></script>
	<!-- Active js -->
	<script src="js/active.js"></script>

	<!-- 쿠폰함 모달 -->
	<div id="couponModal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<h2>나의 쿠폰</h2>
			<ul id="couponList">
				<!-- 쿠폰 목록이 동적으로 삽입됩니다. -->
			</ul>
		</div>
	</div>

	<!-- jQuery CDN -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</body>

</html>
