package util;

import java.security.MessageDigest;

public class SHA256 {

	//특정한 입력값 (이메일) 값에 해시적용한 값을 반환
	public static String getSHA256(String input) {
		
		StringBuffer result = new StringBuffer();
		
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");	//실제로 사용자가 입력한 값을 샤-256으로 알고리즘적용
			byte[] salt ="Hello! This is Salt.".getBytes();	//악의적인 공격방어
			digest.reset();
			digest.update(salt);	//salt값 적용
			byte[] chars = digest.digest(input.getBytes("UTF-8"));	//hash를 적용한 값을 chars에 담아줌
			for(int i = 0; i < chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);	//문자로 변환
				if(hex.length() == 1 )result.append('0');	//한자리수인 경우에는 0을 붙여서 총 16진수가 될수 있게 만들어줌
				result.append(hex);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
}
