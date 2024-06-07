/**
 * 
 */
 showList();
 
 function showList(){
 	
 	//function list(param, 
 	priceService.list (
 	{no : no} ,
 	
 	function(data){
 	
 		let list = data
 		//getJSON메서드에서 함수의 매개변수로 서버에서 가져온 데이터가 담기게 되는데, 그 매개변수 이름이 data였다.
 		
 		console.log("데이터 받기 성공 list : " + JSON.stringify(list));
 		 		
 		if(list == null || list.length == 0){
 			replaceTR.html("");
 			return;
 		}
 		
 		//태그를 바꿔치기 하기 위한 문자열을 작성할 변수 선언.
 		let str = "";
 		
 		str += "<tr class = \"form-group writeInput\">";
       	str +=		"<td>*</td>";
       	str +=	"<td><input class = \"form-control\" type =\"date\" id = \"startDate\"name = \"startDate\"></td>";
       	str +=	"<td><input class = \"form-control\" type =\"date\" id = \"endDate\"name = \"endDate\"></td>";
       	str +=	"<td><input class = \"form-control\" type =\"text\" id = \"itemPrice\"name = \"itemPrice\"></td>";
       	str +=	"<td><input class = \"form-control\" type =\"text\" id = \"discount\"name = \"discount\"></td>";
       	str +=	"<td><input class = \"form-control\" type =\"text\" id = \"rate\"name = \"rate\"></td>";
       	str +=	"<td><button type = \"button\" class = \"btn btn-dark priceWriteBtn\">추가</button></td>";
       	str +=	"</tr>";
 		
 		
 		$(list).each(function(vo){
 		
 		str +=  " <tr class = \"prices\" > ";
       	str +=		"<td class =\"pno\"> "+ this.priceNo+ "</td>";
       	str +=		"<td class =\"startDate\"> "+ dateForm(this.startDate)+" </td>";
       	str +=		"<td class =\"endDate\">"+ dateForm(this.endDate) +" </td>";
       	str +=		"<td class =\"itemPrice\">"+ this.itemPrice +"</td>";
       	str +=		"<td class =\"discount\">"+ this.discount+ "</td>";
       	str +=		"<td class =\"rate\">"+this.rate+"</td>"	;
       	str +=		"<td class=\"changeTD\"><button type=\"button\" class = \"priceUpdateBtn btn btn-dark\">수정</button></td>";
       	str +=		"<td class=\"cancelTD\"><button type=\"button\" class = \"priceDeleteBtn btn btn-dark\">삭제</button></td>";
       	str +=	"</tr>";

 		});
 		
 		replaceTR.html(str);
 		
 	}
 
 	) //priceService.list() end
 	
 } //function showList() end
 
 
 
 $(function(){
 	
 	
 	
 	////priceWriteBtn.click()
 	$(".pList").on("click", ".priceWriteBtn" , function(){
 		console.log("writeClicked!")
 		
 	//데이터 수집	
 	let startDate = $("#startDate").val();
 	let endDate = $("#endDate").val();
 	let itemPrice = $("#itemPrice").val();
 	let discount = $("#discount").val();
 	let rate = $("#rate").val();
 	

 	//수집한 데이터를 JSON 객체로 변수에 담는다.자바 vo 프로퍼티와 이름이 같은 키로 넘겨줘야 한다.
 	let writeInfo = {
 	itemNo : no,
 	startDate : startDate,
 	endDate : endDate,
 	itemPrice: itemPrice,
 	discount: discount,
 	rate:rate
 	};
 	
 	 	alert(JSON.stringify(writeInfo));
 	
 		priceService.write(writeInfo, function(result){
 		showList();
 		console.log(result);
 		} , function(xhr,status,error){
 				console.log("가격 등록 처리중 오류 발생.");
 				console.log("xhr : " + xhr + ", status : " + status + ", error : " + error);
 		}); 
 		
 	}); //priceWriteBtn.click() end
 	
 	
 	//priceUpdate.click()
 	$(".pList").on("click", ".priceUpdateBtn" , function(){
 		console.log("updateFinished!") 	
 		
 		//버튼이 클릭된 행을 찾아서 변수에 저장한다.
 		targetRow = $(this).closest("tr");
 		
 		
 		//버튼 클릭시 tr태그내에 넣을 새로운 html을 작성할 변수.
 		let newHTML = "";
		
		//priceNo을 유지하기 위한 변수  		
 		let pno = targetRow.find(".pno").text();
 		let startDate = targetRow.find(".startDate").text();
 		let endDate = targetRow.find(".endDate").text();
 		let itemPrice = targetRow.find(".itemPrice").text();
 		let discount = targetRow.find(".discount").text();
 		let rate = targetRow.find(".rate").text();
 		
 		newHTML += "<td><input class = \"form-control\" type =\"text\" id = \"priceNoUp\"name = \"priceNo\" value = "+ pno +" readonly></td>";
 		newHTML += "<td><input class = \"form-control\" type =\"date\" id = \"startDateUp\"name = \"startDate\" value = "+ startDate +"></td>";
 		newHTML += "<td><input class = \"form-control\" type =\"date\" id = \"endDateUp\"name = \"endDate\" value = "+ endDate +"></td>";
 		newHTML += "<td><input class = \"form-control\" type =\"text\" id = \"itemPriceUp\"name = \"itemPrice\" value = "+ itemPrice +"></td>";
 		newHTML += "<td><input class = \"form-control\" type =\"text\" id = \"discountUp\"name = \"discount\" value = "+ discount +"></td>";	
 		newHTML += "<td><input class = \"form-control\" type =\"text\" id = \"rateUp\"name = \"rate\" value = "+ rate +"></td>";
 		newHTML += "<td><button type=\"button\" class = \"priceFinishBtn btn btn-secondary\">완료</button></td>";
 		newHTML += "<td><button type=\"button\" class = \"priceCancelBtn btn btn-secondary\">취소</button></td>";
 		
 		targetRow.html(newHTML);
 		
 		
 		//기존 수정,삭제버튼을 숨긴다.
 		$(".priceUpdateBtn").hide();
 		$(".priceDeleteBtn").hide();
 		
 		//등록 입력칸은 입력을 막는다.
 		$(".writeInput input").prop("disabled", true);
 		
 	}); //priceUpdate.click() end
 	
 	//priceCancelBtn.click()
 	$(".pList").on("click", ".priceCancelBtn" , function(){
 		console.log("updateCancel!") 	
 		
		showList(); 		
 	}); //priceCancelBtn.click() end
 	
 	
 	
 	 	////priceFinish.click()
 	$(".pList").on("click", ".priceFinishBtn" , function(){
 		console.log("FinishClicked!")
 		
 	//데이터 수집	
 	let priceNo = $("#priceNoUp").val();
 	let startDate = $("#startDateUp").val();
 	let endDate = $("#endDateUp").val();
 	let itemPrice = $("#itemPriceUp").val();
 	let discount = $("#discountUp").val();
 	let rate = $("#rateUp").val();
 	

 	//수집한 데이터를 JSON 객체로 변수에 담는다.자바 vo 프로퍼티와 이름이 같은 키로 넘겨줘야 한다.
 	let updateInfo = {
 	itemNo : no,
 	priceNo : priceNo,
 	startDate : startDate,
 	endDate : endDate,
 	itemPrice: itemPrice,
 	discount: discount,
 	rate:rate
 	};
 	
 	 	alert(JSON.stringify(updateInfo));
 	
 		priceService.update(updateInfo, function(result){
 		showList();
 		console.log(result);
 		} , function(xhr,status,error){
 				console.log("가격 수정 처리중 오류 발생.");
 				console.log("xhr : " + xhr + ", status : " + status + ", error : " + error);
 		}); 
 		
 	}); //priceFinish.click() end
 	
 	
 	 	////priceDeleteBtn.click()
 	$(".pList").on("click", ".priceDeleteBtn" , function(){
 		console.log("DeleteClicked!")
 		
 	if(!confirm("가격 삭제를 실행할까요?")) return ;
 		
 	//데이터 수집	
 	let priceNo = $(this).closest("tr").find(".pno").text();
 	
 	let deleteInfo = {
 	priceNo : priceNo
 	}
 	
 		priceService.remove(deleteInfo, function(result){
 		showList();
 		console.log(result);
 		} , function(xhr,status,error){
 				console.log("가격 삭제 처리중 오류 발생.");
 				console.log("xhr : " + xhr + ", status : " + status + ", error : " + error);
 		}); 
 		
 	}); //priceDeleteBtn.click() end




 });//$(function() end