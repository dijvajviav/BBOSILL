<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri  ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title  -->
    <title>쿠폰함</title>

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
    background-color: rgb(0,0,0);
    background-color: rgba(0,0,0,0.4);
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

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}
/*     	쿠폰함 모달을 위한 스타일 */
    
    
    
    
        .cart-table-area .table-responsive {
            overflow-x: auto; /* Enables horizontal scrolling */
        }

        .cart-table-area .table th,
        .cart-table-area .table td {
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
    
</head>

<body>
        <div class="cart-table-area section-padding-100">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12 col-lg-12">
                        <div class="cart-title mt-50">
                            <h2>쿠폰함</h2>
                        </div>

                        <div class="cart-table clearfix">
                            <table class="table table-responsive">
                            
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>쿠폰이름</th>
                                        <th>할인가격</th>
                                        <th>수량</th>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                <c:forEach items="${listMemCo }" var="vo">
						<!--       이게 하나다 -->
									<tr class="itemRow" data-item-no="${vo.id}">
									
                                         <td class="cart_product_desc dataRow view-detail">
                                            <h5>${vo.couponno}</h5>
                                        </td>
                                        
                                        <td class="cart_product_desc dataRow view-detail">
                                            <h5>${vo.couponname}</h5>
                                        </td>
                                 
                                        <td class="itemPrice">
                                        	<h5>${vo.couponname}</h5>
                                        </td>
                                        
                                        <td class="itemPrice">
                                        	<h5>${vo.usagelimit}</h5>
                                        </td>
                                    
                                    </tr>
                                  
                                    </c:forEach>
                                  <!--       이게 하나다 -->
                                  
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>

    <!-- ##### Main Content Wrapper End ##### -->

    <!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
    <script src="js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="js/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="js/bootstrap.min.js"></script>
    <!-- Plugins js -->
    <script src="js/plugins.js"></script>
    <!-- Active js -->
    <script src="js/active.js"></script>

</body>

</html>
