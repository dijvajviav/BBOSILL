<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록폼</title>

<script>
$(function(){
	
$("#imageFile").on("change", function(event){

	let file = event.target.files[0];

	let reader = new FileReader();
	reader.onload = function(e) {

		$("#showImg").attr("src" , e.target.result)
		
		} 

	reader.readAsDataURL(file);
	
	});
	
});
</script>

<style>
/*  #category{ */
/*      height: 60px; */
/*         border: none; */
/*         border-radius: 0; */
/*         background-color: #f5f7fa; */
/*         padding: 30px; */
/*         color: #6b6b6b; */
/*         font-size: 14px; */
/* } */

#category{
    display: block;
    width: 100%;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
    transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
}

</style>

</head>
<body>

                   <div class="col-12 col-lg-8">
                        <div class="checkout_details_area mt-50 clearfix">

                            <div class="cart-title">
                                <h2>Write Item</h2>
                            </div>

                            <form action="write.do" method="post" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <input type="text" class="form-control" name="itemName" id="itemName" value="" placeholder="상품명" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <input type="text" class="form-control" name="producer" id="producer" value="" placeholder="제조사" required>
                                    </div>
                                    <div class="col-12 mb-3">
                                    	<label for="imageFile" class="form-control">이미지 등록을 위해 클릭!</label>
                                        <input type="file" class="form-control" name="imageFile" id="imageFile" value="" style="display:none;">
                                        <img src = "https://via.placeholder.com/250x250" alt="noImg" id = "showImg">
                                    </div>
                                 
                                    
			                         <div class="col-12 mb-3 input-group ">
			                         	<div class = "input-group-prepend">
									  <label for="sel1">카테고리 선택:</label>
			                         	</div>
									  <select  id="category input-group" name="categoryNo">
									    <option value="1" selected>옷</option>
									    <option value="2" >사료</option>
										<option value="3">간식</option>
										<option value="4">건강관리</option>
										<option value="5">목욕</option>
										<option value="6">장난감</option>
										<option value="7">잡화</option>
										
									  </select>
									</div>
                                    
                                    <div class="col-12 mb-3">
                                        <input type="number" class="form-control mb-3" id="itemPrice" placeholder="상품가격" name = "itemPrice">
                                    </div>
                                    <div class="col-12 mb-3">
                                        <input type="number" class="form-control" id="discount" placeholder="할인가" name ="discount">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <input type="number" class="form-control" id="rate" placeholder="할인율" name ="rate">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                    	<label >시작일:
                                        <input type="date" class="form-control" id="startDate" min="0" placeholder="판매 시작일" name ="startDate"
                                        pattern ="yyyy-MM-dd">
                                    	</label>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                    	<label>종료일:
                                        <input type="date" class="form-control" id="endDate" min="0" placeholder="판매 종료일" name ="endDate"
                                        pattern = "yyyy-MM-dd" >
                                    	</label>
                                    </div>
                                    <div class="col-12 mb-3">
                                        <textarea name="itemContent" class="form-control w-100" id="itemContent" cols="30" rows="10" placeholder="상품  설명을 작성해주세요"
                                        maxlength="2000"></textarea>
                                    </div>

                                </div>
                                
                                <button class = "btn btn-primary">등록하기</button>
                                <button type = "reset" class = "btn btn-warning">초기화</button>
                                <button type = "button"  class = "btn btn-info"onclick="history.back()">리스트</button>
                            </form>
                        </div>
                    </div>
                    
</body>
</html>