package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;


//구글에 접속헤서 계정 보안수준이 낮은 앱 허용 가능하게 해야됨
public class Gmail extends Authenticator {
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("ugee719@gmail.com","djfwkdwls1!");
	}

	
	
}
