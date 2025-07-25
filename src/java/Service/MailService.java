package Service;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.util.Properties;

public class MailService {

    public static void send(String toEmail, String subject, String content) {
        final String fromEmail = "ducanhdeptraile651@gmail.com";
        final String appPassword = "msrf hagi oken wwdj";        

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // TLS
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, "LGBT Hotel"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));

            message.setContent(content, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("✅ Email đã được gửi đến: " + toEmail);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
