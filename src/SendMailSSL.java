/**
 * Created by Malte on 26.10.2015.
 */
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
public class SendMailSSL {
    public static void sendMail() {

        final String username = "hipsterrentalcorp@gmail.com";
        final String password = "YXCVBNM;";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.starttls.enable", true);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "587");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username,password);
            }
        };

        Session session = Session.getDefaultInstance(props,auth);


        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("hipsterrentalcorp@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse("m.bohnsack99@web.de"));
            message.setSubject("Testing Subject");
            message.setText("Dear Employee,"
                    + "\n\n Login Succesfull!");

            Transport transport = session.getTransport("smtp");
            transport.connect("smtp.gmail.com", username, password);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();


        } catch (Exception e) {
            e.printStackTrace();

        }
    }
}

