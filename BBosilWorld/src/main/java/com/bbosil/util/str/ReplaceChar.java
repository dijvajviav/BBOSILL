package com.bbosil.util.str;

public class ReplaceChar {
	
	
	public static String specialChar(String str) {
		return str.replace("<", "&lt;").replace(">", "&gt;").replace("\n",
				"<br>").replace(" ", "&nbsp");
	}
}
