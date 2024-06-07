package com.bbosil.item.util;

import javax.servlet.http.HttpServletRequest;

import com.webjjang.util.page.PageObject;

public class ItemPageObject extends PageObject{

	private long categoryNo;
	private String order;
	private String producer;
	private String itemName;
	private int gradeNo;
	
	
	public long getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(long categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getProducer() {
		return producer;
	}
	public void setProducer(String producer) {
		this.producer = producer;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	
	public int getGradeNo() {
		return gradeNo;
	}
	public void setGradeNo(int gradeNo) {
		this.gradeNo = gradeNo;
	}
	public ItemPageObject() {
		
		super();
		
		this.categoryNo = 0;
		this.producer = "";
		this.order = "new";
		this.itemName = "";
		
	}
	
	public ItemPageObject(HttpServletRequest request) throws Exception{
		
		
	}

	public static ItemPageObject getInstance(HttpServletRequest request) throws Exception {

		// 페이지 처리를 위한 프로그램
		// 페이지 처리를 위한 객체 사용
		ItemPageObject pageObject = new ItemPageObject();
		// 페이지에 대한 정보를 받는다.
		// page는 jsp에서 기본객체로 사용하고 있다. -> 페이지의 정보가 담겨져 있다.
		String strPage = request.getParameter("page");
		// 넘어오는 페이지가 있는 경우는 넘어오는 페이지를 현재 페이지로 셋팅. 그렇지 않으면 1이 셋팅된다.
		if(strPage != null && !strPage.equals("")) pageObject.setPage(Integer.parseInt(strPage));
		// 한페이지에 표시할 데이터의 수를 받는다.
		String strPerPageNum = request.getParameter("perPageNum");
		// 한 페이지당 표시할 데이터의 수가 안넘어오면 10으로 셋팅된다. 넘어오면 넘어 오는 데이터를 사용한다.
		if(strPerPageNum != null && !strPerPageNum.equals("")) {
			pageObject.setPerPageNum(Integer.parseInt(strPerPageNum));
		}else {
			pageObject.setPerPageNum(8);
		}
		
		// 검색을 위한 데이터 전달
		
		//카테고리 숫자. parse 단계에서 null 오류가 발생하지 않도록 조건 처리를 해준다.
		String categoryNo = request.getParameter("categoryNo");
		if(categoryNo != null && !categoryNo.equals("")) pageObject.setCategoryNo(Long.parseLong(categoryNo));
		
		pageObject.setKey(request.getParameter("key"));
		pageObject.setWord(request.getParameter("word"));
		//아이템 검색 추가 데이터
		pageObject.setProducer(request.getParameter("producer"));
		
		pageObject.setOrder(request.getParameter("order"));
		
		pageObject.setItemName(request.getParameter("itemName"));
		
		
		// PageObject - 확인
		System.out.println("PageObject.getInstance() [pageObject = " + pageObject + " ]");

		return pageObject;
	}
	
	@Override
	public String getPageQuery() throws Exception {
		return "catagoryNo=" + getCategoryNo() + "&order=" + getOrder()
		+ "&producer=" + getProducer() + "&itemName=" + getItemName()
		+ "&" + super.getPageQuery()
		;
	}
	
	
	
	@Override
	public String toString() {
		return super.toString() + "categoryNo=" + categoryNo 
				+ ", order=" + order +"," + "producer=" + producer 
				+ ", itemName=" + itemName +"]" ;
	}
	
	
	
	
	
	
}
