<!-- sitemesh 사용을 위한 설정 파일 -->
<!-- 작성자 : 이영환 -->
<!-- 작성일 : 2024-02-23
	 web lib : Bootstrap 4 적용 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="description" content="">
     <meta name="author" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title  -->
    <title>♡ BBOSILL WORLDD ♡<decorator:title /></title>

    <!-- Favicon  -->
    <link rel="icon" href="/resources/img/core-img/favicon.ico">

    <!-- Core Style CSS -->
    <link rel="stylesheet" href="/resources/css/core-style.css">
    <link rel="stylesheet" href="/resources/style.css">

    <!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
    <script src="/resources/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="/resources/js/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="/resources/js/bootstrap.min.js"></script>
    <!-- Plugins js -->
    <script src="/resources/js/plugins.js"></script>
    <!-- Active js -->
    <script src="/resources/js/active.js"></script>

<!-- 일반 JS나 이벤트 처리 -->
	<script type="text/javascript">
		$(function(){
			$(".cancelBackBtn").click(function(){
				history.back();
	
			});

	

			
		});


		let checkCat = ${category};
		alert(checkCat)
	</script>
	
	<c:if test="${empty category }">
		<script type="text/javascript">
				$.getJSON('/category/list.do' , function(data){
					console.log(data);
			    	
					$('.dropdown-menu').append("<a class=\"dropdown-item\" href=\"/item/list.do\">전체</a>")
					
					$.each(data, function(i, vo){
						$('.dropdown-menu').append("<a class=\"dropdown-item\" href=\"/item/list.do?categoryNo="+vo.categoryNo+"\">"+vo.categoryName+"</a>")
						
						})
					
				});
		</script>
	</c:if>
	
	<style>
        /* li 요소의 하위 a 태그에 대해 글씨를 두껍게(Bold) 만듭니다. */
        li a {
            font-weight: bold;
            /* 다른 스타일도 필요한 경우 추가 */
        }
    </style>

<decorator:head />

		<script>

		</script>
	
</head>

<body>


    <!-- Search Wrapper Area Start -->
    <div class="search-wrapper section-padding-100">
        <div class="search-close">
            <i class="fa fa-close" aria-hidden="true"></i>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="search-content">
                        <form action="#" method="get">
                            <input type="search" name="search" id="search" placeholder="Type your keyword...">
                            <button type="submit"><img src="/resources/img/core-img/search.png" alt=""></button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Search Wrapper Area End -->

    <!-- ##### Main Content Wrapper Start ##### -->
    <div class="main-content-wrapper d-flex clearfix">

        <!-- Mobile Nav (max width 767px)-->
        <div class="mobile-nav">
            <!-- Navbar Brand -->
            <div class="amado-navbar-brand">
                <a href="/main.do"><img src="/resources/img/core-img/logo.png" alt=""></a>
            </div>
            <!-- Navbar Toggler -->
            <div class="amado-navbar-toggler">
                <span></span><span></span><span></span>
            </div>
        </div>

        <!-- Header Area Start -->
        <header class="header-area clearfix">
            <!-- Close Icon -->
            <div class="nav-close">
                <i class="fa fa-close" aria-hidden="true"></i>
            </div>
           <!-- Logo -->
            <div class="logo">
                <a href="/main/main.do"><img src="/resources/img/core-img/logo.png" alt=""></a>
            </div>
            	
                 <hr>
                 <!-- 로그인 정보 표시 -->
                <c:if test="${empty login }">
                <!-- 로그인을 하지 않은 경우 -->
	                <div style="margin-right: 15px;">
	                  <a href="/member/login.do">LOGIN</a>  /  <a href="/member/write.do">JOIN</a>
            		</div>
            	</c:if>
            <c:if test="${!empty login }">
            <!-- 로그인을 한 경우 -->
               <div style="margin-right: 15px;">
                  <a href="/member/logout.do">LOGOUT</a>  /  <a href="/member/view.do">MY PAGE</a>
            </div>
            <div style="margin-right: 15px;">
                  <a href="/orders/list.do">주문내역</a>
            </div>
            <hr>
             <div style="margin-right: 10px;" class="welcome">
                  ♡${login.id }님♡  반가워요!
            </div>
            </c:if>
         <br>
            <!-- Amado Nav -->
            <nav class="amado-nav">
                <ul>
                    <li class="active"><a href="/main/main.do">Home</a></li>
                    <li><a href="/item/list.do">Shop</a></li>
                    <li><a href="/cart/list.do">Cart</a></li>
                    <li><a href="/notice/list.do">Notice</a></li>
                </ul>
            </nav>
            
            <div class="dropdown">
			  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
			    Category
			  </button>
			  <div class="dropdown-menu" id="">
			  	<c:if test="${!empty category }">
			    	<a class="dropdown-item" href="/item/list.do">전체</a>
				  	<c:forEach items="${category }" var="cate">
				  		<a class="dropdown-item" href="/item/list.do?categoryNo=${cate.categoryNo }">${cate.categoryName }</a>
				    </c:forEach>
			    </c:if>		
			  </div>
			</div>

            <!-- Cart Menu -->
            <div class="cart-fav-search mb-100">
                <a href="/cart/list.do" class="cart-nav"><img src="/resources/img/core-img/cart.png" alt=""> Cart <span>(0)</span></a>
            </div>
            <!-- Social Button -->
            <div class="social-info d-flex justify-content-between">
                <a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            </div>
        </header>
        <!-- Header Area End -->
			
			
        
        <decorator:body>
        </decorator:body>
    </div>
   
   
   
    <!-- ##### Main Content Wrapper End ##### -->


    <!-- ##### Footer Area Start ##### -->
    <footer class="footer_area clearfix">
        <div class="container">
            <div class="row align-items-center">
                <!-- Single Widget Area -->
                <div class="col-12 col-lg-4">
                    <div class="single_widget_area">
                        <!-- Logo -->
                        <div class="footer-logo mr-50">
                            <a href="/resources/index.html"><img src="/resources/img/core-img/logo2.png" alt=""></a>
                        </div>
                        <!-- Copywrite Text -->
          <div class="copywrite">
		    <p>&nbsp;(주)BBOSILWorld &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제작자 Team1</p>
		    <p>경기 의정부시 신흥로258번길 25 해태프라자 2층</p>
		 </div>
                    </div>
                </div>
                <!-- Single Widget Area -->
                <div class="col-12 col-lg-8">
                    <div class="single_widget_area">
                        <!-- Footer Menu -->
                        <div class="footer_menu">
                            <nav class="navbar navbar-expand-lg justify-content-end">
                                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#footerNavContent" aria-controls="footerNavContent" aria-expanded="false" aria-label="Toggle navigation"><i class="fa fa-bars"></i></button>
                                <div class="collapse navbar-collapse" id="footerNavContent">
                                    <ul class="navbar-nav ml-auto">
                                        <li class="nav-item active">
                                            <a class="nav-link" href="/main/main">Home</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="/item/list.do">Shop</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="/cart/list.do">Cart</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="/order/list.do">Checkout</a>
                                        </li>
                                         <li class="nav-item">
                                            <a class="nav-link" href="/notice/list.do">Notice</a>
                                        </li>
                                    </ul>
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- ##### Footer Area End ##### -->


	<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          Modal body..
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>

</body>

</html>