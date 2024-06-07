/**
 *	03-22 김동건
 	 가격 테이블 조회에 사용할 JS. 실제 실행되는 함수를 작성함.
 */
 
 
 console.log("price js Loading......................");
 
 let priceService = (function(){
 
 //function list(param, callback, error)
 	
 	
 	function list (param,callback,error){
 	
 	let no = param.no;
 	
 	console.log("/price/list.do?no=" + no);
 	
 	$.getJSON("/price/list.do?no=" + no , function(data){
 	
 	if(callback) callback(data)
 	
 	}).fail(function(xhr,status,error){
 		if(error) error(xhr,status,error)
 		})
 	}
 // list() end
 
 	
 //function write(param, callback, error)
 	
 	
 	function write (param,callback,error){
 	
 	
 	console.log("priceWrite js...");
 	
 		$.ajax({
	 			
	 			type : "post" ,
	 			url : "/price/write.do",
	 			data : JSON.stringify(param),  //JSON 객체를 넘기지 않고, 문자열 JSON 데이터를 넘겨준다.
	 			contentType : "application/json; charset = utf-8",
	 			success : function(result, status, xhr){
	 				if(callback) {
	 					callback(result);
	 				}
	 			},
	 			//키 error와 변수 error 서로 다름.
	 		error : function(xhr, status, err){
	 			if(error) {
	 					error(xhr,status,err);
	 				}
	 		}
	 			
	 		
	 		});
	 		
  } //write() end
  
  
  
 //function update(param, callback, error)
 	
 	
 	function update (param,callback,error){
 	
 	
 	console.log("priceUpdate js...");
 	
 		$.ajax({
	 			
	 			type : "put" ,
	 			url : "/price/update.do",
	 			data : JSON.stringify(param),  //JSON 객체를 넘기지 않고, 문자열 JSON 데이터를 넘겨준다.
	 			contentType : "application/json; charset = utf-8",
	 			success : function(result, status, xhr){
	 				if(callback) {
	 					callback(result);
	 				}
	 			},
	 			//키 error와 변수 error 서로 다름.
	 		error : function(xhr, status, err){
	 			if(error) {
	 					error(xhr,status,err);
	 				}
	 		}
	 			
	 		
	 		});
	 		
  } //update() end
  
 //function remove(param, callback, error)
 	
 	
 	function remove (param,callback,error){
 	
 	
 	console.log("priceDelete js...");
 	
 		$.ajax({
	 			
	 			type : "delete" ,
	 			url : "/price/delete.do",
	 			data : JSON.stringify(param),  //JSON 객체를 넘기지 않고, 문자열 JSON 데이터를 넘겨준다.
	 			contentType : "application/json; charset = utf-8",
	 			success : function(result, status, xhr){
	 				if(callback) {
	 					callback(result);
	 				}
	 			},
	 			//키 error와 변수 error 서로 다름.
	 		error : function(xhr, status, err){
	 			if(error) {
	 					error(xhr,status,err);
	 				}
	 		}
	 			
	 		
	 		});
	 		
  } //remove() end
  
  

 
 	return {
 	list : list,
 	write : write,
 	update : update,
 	remove : remove
 	
 	}
 	
 
 	
 
 }
 )();
 
 //날짜형식을 밀리초 단위에서 년월일 형식으로 바꾼다.
 function dateForm(time){
 
 	date = new Date(time);
 	
 	let str = "";
 	
 	dd = date.getDate();
 	mm = date.getMonth() + 1;
 	yy = date.getFullYear();
 
 
 	str = yy + "-" + zero(mm) + "-" + zero(dd);
 
 	return str;
 }
 
 //9 이하인 숫자값에 0을 붙여준다.
 function zero(num){
 	
 	let checknum = ((Number(num) <= 9) ? ("0" + num) : num );
 	
 	return checknum;
 
 }
 