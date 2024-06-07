<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html >

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title  -->
    <title>♡ BBOSILL WORLDD ♡ </title>

    <!-- Favicon  -->
    <link rel="icon" href="/resources/img/core-img/favicon.ico">

    <!-- Core Style CSS -->
    <link rel="stylesheet" href="/resources/css/core-style.css">
    <link rel="stylesheet" href="/resources/style.css">

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
                <a href="index.html"><img src="/resources/img/core-img/logo.png" alt=""></a>
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
                <a href="/main/main.do"><img src="/resources/img/core-img/logo.png" alt=""></a><div>
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
                    <li class="active"><a href="/main/main">Home</a></li>
                    <li><a href="/item/list.do">Shop</a></li>
                    <li><a href="/cart/list.do">Cart</a></li>
                    <li><a href="/order/list.do">Checkout</a></li>
                    <li><a href="/notice/list.do">Notice</a></li>
                </ul>
            </nav>
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

        <!-- Product Catagories Area Start -->
        <div class="products-catagories-area clearfix">
            <div class="amado-pro-catagory clearfix">

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="/item/list.do?categoryNo=3">
                        <img src="/resources/img/bg-img/간식.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <h4>간식</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="/item/list.do?categoryNo=4">
                        <img src="/resources/img/bg-img/건강관리.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <h4>건강관리</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="/item/list.do?categoryNo=1">
                        <img src="/resources/img/bg-img/고양이옷.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <h4>고양이옷</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="/item/list.do?categoryNo=6">
                        <img src="/resources/img/bg-img/고양이 장난감.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <h4>고양이 장난감</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="/item/list.do?categoryNo=3">
                        <img src="/resources/img/bg-img/매트.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <h4>매트</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="/item/list.do?categoryNo=5">
                        <img src="/resources/img/bg-img/목욕용품.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <h4>목욕용품</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="/item/list.do?categoryNo=5">
                        <img src="/resources/img/bg-img/사료.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <h4>사료</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="/item/list.do?categoryNo=8">
                        <img src="/resources/img/bg-img/식기.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <h4>식기</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="/item/list.do?categoryNo=9">
                        <img src="/resources/img/bg-img/잡화.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <h4>잡화</h4>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        <!-- Product Catagories Area End -->
    </div>
    <!-- ##### Main Content Wrapper End ##### -->


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

</body>

</html>