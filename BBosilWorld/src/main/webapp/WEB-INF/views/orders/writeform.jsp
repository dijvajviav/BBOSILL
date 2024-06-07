<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문하기</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- jQuery -->
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Bootstrap JavaScript -->
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script
    src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() { // 함수 이름 수정
        new daum.Postcode(
                {
                    oncomplete : function(data) {
                        var address = '';

                        if (data.userSelectedType === 'R') {
                            address = data.roadAddress;
                        } else {
                            address = data.jibunAddress;
                        }

                        document.getElementById('sample6_postcode').value = data.zonecode;
                        document.getElementById('sample6_address').value = address;
                        document.getElementById('sample6_detailAddress')
                                .focus();
                    }
                }).open();
    }
</script>

</head>
<body>
    <div class="container">
        <h1>주문하기</h1>
    
    <div class="card">
        <div class="card-header">구매자 정보</div>
        <div class="card-body">
            <div class="row">
                <div class="col-lg-2 th">이름</div>
                <div class="col-lg-2 td">${login.name }</div>
            </div>
        </div>
    </div>

    <div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        배송 정보

    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-lg-2 th">수령인 이름</div>
            <div class="col-lg-3 td">
                <input type="text" name="oName"
                class="form-control"required pattern="^[가-힣a-zA-Z]{2,20}$">
            </div>
        </div>
        <div class="row">
            <div class="col-lg-2 th">수령인 연락처</div>
            <div class="col-lg-3 td">
                <input type="text" name="oTel"
                class="form-control" required>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-2 th">우편 번호
                <input type="button" class="btn btn-sm btn-outline-dark" 
                onclick="sample6_execDaumPostcode()" value="우편번호 찾기"
                required style="padding: 1px 3px 1px 3px;"><br>
            </div>
            <div class="col-lg-3 td">
                <input type="text" id="sample6_postcode" 
                placeholder="우편번호" class="form-control" name="oPostCode" 
                value="${vo.OPostCode }" required readonly >
            </div>
        </div>
        <div class="row">
            <div class="col-lg-2 th">기본 주소</div>
            <div class="col-lg-6 td">
                <input type="text" id="sample6_address" placeholder="주소" 
                class="form-control" name="oAddress" value="${vo.OAddress }" required>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-2 th">상세 주소</div>
            <div class="col-lg-6 td"> 
                <input type="text" id="sample6_detailAddress" 
                placeholder="상세주소" class="form-control"  name="oDetailAddress" 
                value="${vo.ODetailAddress }" required>
            </div>
        </div>
        <input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
        <div class="row">
            <div class="col-lg-2 th">배송요청<br>메시지</div>
            <div class="col-lg-6 td">
                <textarea rows="3" name="oMsg" class="form-control" style="resize: none"></textarea>
            </div>
        </div>
    </div>
</div>

    <div class="card">
        <div class="card-header">상품 정보</div>
        <div class="card-body">
            <!-- 여러 상품에 대한 정보 출력 -->
            <table class="table">
                <thead>
                    <tr>
                        <th>상품 이미지</th>
                        <th>상품명</th>
                        <th>가격</th>
                        <th>수량</th>
                        <th>합계</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="totalPrice" value="0" />
                    <c:forEach items="${list}" var="orderDetail">
                        <c:set var="itemTotal" value="${orderDetail.itemPrice * orderDetail.count}" />
                        <c:set var="totalPrice" value="${totalPrice + itemTotal}" />
                        <tr>
                            <td><img src="${orderDetail.itemImage}" alt="itemImage"
                                style="width: 50px;"></td>
                            <td>${orderDetail.itemName}</td>
                            <td>${orderDetail.itemPrice}원</td>
                            <td>${orderDetail.count}개</td>
                            <td>${itemTotal}원</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="card" style="margin-bottom: 10px">
        <div class="card-header">결제 정보</div>
        <div class="card-body">
            <div class="row">
                <div class="col-lg-2 th">상품 합계</div>
                <div class="col-lg-6 td">${totalPrice}원</div>
            </div>
            <div class="row">
                <div class="col-lg-2 th">배송비</div>
                    <input name="oDeliveryCharge" type="hidden" value="${deliveryCharge }">
                <div class="col-lg-6 td">${deliveryCharge }원
                    <c:if test="${deliveryCharge == 0}">(무료)</c:if>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-2 th">결제 금액</div>
                <div class="col-lg-6 td" style="font-size: 115%; color: red; font-weight: bold">
                    ${totalPrice + deliveryCharge}원
                    <input id="oPrice" name="oPrice" type="hidden" value="${orderPrice }">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-2 th">결제 방법</div>
                    <input id="pg" value="" type="hidden">
                <div class="col-lg-6 td">
                    <input id="oPayment" name="oPayment" type="hidden" value="1">
                    <input name="oCardOrBank" type="hidden" value="">
                    <label class="radio-inline"><input class="paymentRadio" 
                    type="radio" name="paymentRadio" value="1" checked> 무통장 입금</label>
                    <label class="radio-inline"><input class="paymentRadio" 
                    type="radio" name="paymentRadio" value="2"> 카드 결제</label>
                    <label class="radio-inline"><input class="paymentRadio" 
                    type="radio" name="paymentRadio" value="3"> 카카오페이</label>
                </div>
            </div>
            <div class="row" id="bankDiv">
                <div class="col-lg-2 th">은행 선택</div>
                <div class="col-lg-6 td">
                    <select name="oCardOrBank">
                        <option value="" selected disabled hidden>은행을 선택하세요</option>
                        <option>국민은행</option>
                        <option>신한은행</option>
                        <option>우리은행</option>
                        <option>하나은행</option>
                        <option>농협</option>
                        <option>SC제일은행</option>
                        <option>카카오뱅크</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    
    
    </div>
    

</body>
</html>
