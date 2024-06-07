<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정폼</title>


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

<script>

$(function(){
	
//기존에 있던 selected 속성을 제거한다.
// 	$(".category option").removeAttr("selected");



// 	$(".category option") 옵션태그에 selected을 추가한다. 
	let cNo = ${vo.categoryNo};
	$(".category option:nth-child("+cNo+")").prop("selected" , true);


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

</head>
<body>

                   <div class="col-12 col-lg-8">
                        <div class="checkout_details_area mt-50 clearfix">

                            <div class="cart-title">
                                <h2>상품수정</h2>
                            </div>

                            <form action="update.do" method="post" enctype="multipart/form-data">
                            <input type = "hidden" value = "${vo.itemImage }" name ="deleteFile">
                            <input type = "hidden" value = "${vo.itemNo }" name ="itemNo">
                            
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <input type="text" class="form-control" name="itemName" id="itemName" 
                                        value="${vo.itemName }"  required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <input type="text" class="form-control" name="producer"
                                         id="producer" value="${vo.producer }"  required>
                                    </div>
                                    <div class="col-12 mb-3" id ="imgWrapper">
                                    	<label for="imageFile">이미지 등록을 위해 이미지 클릭! </label>
                                        <input type="file" class="form-control" name="imageFile" id="imageFile" value="${vo.itemImage }" style="display:none;">
                                        <img src = "${vo.itemImage }" alt="noImg" id = "showImg">
                                    	
                                    </div>
                                 
                                    
			                         <div class="col-12 mb-3 input-group ">
			                         	<div class = "input-group-prepend">
									  <label for="sel1" >카테고리 선택:</label>
			                         	</div>
									  <select  class="category input-group" name="categoryNo" >
									    <option value="1" >옷</option>
									    <option value="2" >사료</option>
										<option value="3">간식</option>
										<option value="4">건강관리</option>
										<option value="5">목욕</option>
										<option value="6">장난감</option>
										<option value="7">잡화</option>
										
									  </select>
									</div>
                                    
                                    <div class="col-12 mb-3">
                                        <textarea name="itemContent" class="form-control w-100" id="itemContent" cols="30" rows="10" 
                                        maxlength="2000">${vo.itemContent }</textarea>
                                    </div>

                                </div>
                                
                                <button class = "btn btn-primary">수정하기</button>
                                <button type = "reset" class = "btn btn-warning">초기화</button>
                                <button type = "button"  class = "btn btn-info"onclick="history.back()">상세보기</button>
                            </form>
                        </div>
                    </div>
                    
</body>
</html>