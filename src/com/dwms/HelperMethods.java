package com.dwms;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class HelperMethods {
	public static String changeDateFormat(String date) {
		String[] tmp=date.split("/");
		date= tmp[2]+"-"+tmp[0]+"-"+tmp[1];
		return date;
	}
	
	public static int getAge(String dob) {
		return (Integer.parseInt((new SimpleDateFormat("yyyy").format(new Date())))-Integer.parseInt(dob.substring(0, 4)));
	}
	
	public static String[] getOrderID(String rowno) {
		return rowno.split("\\+");
	}
	
	static class KMP_String_Matching { 
	    static String KMPSearch(String pat, String txt) 
	    { 
	    	String[] str=pat.split("\\+");
	    	
	    	int len=str.length;
	    	for(int p=0;p<len;p++) {
	    	
	    		int M = str[p].length(); 
	    		int N = txt.length(); 
	    		int lps[] = new int[M]; 
	    		int j = 0; 
	    		computeLPSArray(str[p], M, lps); 
	  
	    		int i = 0; // index for txt[] 
	    		while (i < N) { 
	    			if (str[p].charAt(j) == txt.charAt(i)) { 
	    				j++; 
	    				i++; 
	    			} 
	    			if (j == M) { 
	    				txt=txt.substring((i-j), (i-j)+M); 
	    				j = lps[j - 1]; 
	    			} 
	    			else if (i < N && str[p].charAt(j) != txt.charAt(i)) { 
	    				if (j != 0) 
	    					j = lps[j - 1]; 
	    				else
	    					i = i + 1; 
	    			} 
	    		} 
	    	}
	    	
	    	return txt;
	    } 
	  
	    static void computeLPSArray(String pat, int M, int lps[]) 
	    { 
	        // length of the previous longest prefix suffix 
	        int len = 0; 
	        int i = 1; 
	        lps[0] = 0; // lps[0] is always 0 
	  
	        // the loop calculates lps[i] for i = 1 to M-1 
	        while (i < M) { 
	            if (pat.charAt(i) == pat.charAt(len)) { 
	                len++; 
	                lps[i] = len; 
	                i++; 
	            } 
	            else // (pat[i] != pat[len]) 
	            { 
	                // This is tricky. Consider the example. 
	                // AAACAAAA and i = 7. The idea is similar 
	                // to search step. 
	                if (len != 0) { 
	                    len = lps[len - 1]; 
	  
	                    // Also, note that we do not increment 
	                    // i here 
	                } 
	                else // if (len == 0) 
	                { 
	                    lps[i] = len; 
	                    i++; 
	                } 
	            } 
	        } 
	    } 
	}
}

