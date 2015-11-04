package project; /**
 * Created by Malte on 26.10.2015.
 */

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.List;
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

    public static void sendSubmitMail(String produkt, String datum){
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
            message.setText("Sehr geeherter Kunde,"
                    + "\n\n Ihre Bestellung wurde erfolgreich angenommen." +
                    "\n Sie können Ihre Bestellung( "+produkt+")" +
                    "\n am "+datum+"bei uns abholen." +
                    "\n\n Mit freundlichen Grüßen" +
                    "\n Ihr Team von Hipster Rental Corp" +
                    "\n\n Hier könnte unsere Adresse oder Ihre Werbung stehen.");

            Transport transport = session.getTransport("smtp");
            transport.connect("smtp.gmail.com", username, password);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();


        } catch (Exception e) {
            e.printStackTrace();

        }
    }

    public static void sendBuchungMail(String mail,int buchung){
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
        DatabaseHelper db=new DatabaseHelper();
        List<String> produkte=db.getGebuchteProdukte(buchung);
        List<Double> preise=db.getGebuchteProduktePreis(buchung);
        int anzahl=db.getBuchungsZahlByMail(mail);
        int tage=db.getBuchungsdauerById(buchung);
        String dauer=db.getZeitraum(buchung);
        db.disconnectDatabase();
        String gebuchteProdukte="";
        Double gesamtPreis=0.0;
        Double modKunde=1.0;
        if(anzahl>=4){
            modKunde=0.8;
        }
        for(Double preis:preise){
            gesamtPreis+=(preis+(tage-1*preis*0.6))*modKunde;
        }
        for(int i=0;i<produkte.size();i++){
            gebuchteProdukte+="\n"+produkte.get(i)+" ("+ preise.get(i)+"\u20ac)";
        }
        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("hipsterrentalcorp@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(mail));
            message.setSubject("Bestellung erfasst");
            message.setText("Sehr geeherter Kunde,"
                    + "\n\n Ihre Bestellung wurde in unser System aufgenommen." +
                    "\n Folgende Produkte wurden bestellt:" + gebuchteProdukte +
                    "\n Der Preis betr\u00e4gt: "+gesamtPreis+"\u20ac"+
                    "\n Der Buchunszeitraum ist: "+dauer+
                    "\n Ein Mitarbeiter wird sich schnellstm\u00f6glich um Ihre Bestellung k\u00fcmmern.)" +
                    "\n Sie erhalten eine weitere Mail, sobald die Bestellung verbindlich angenommen wurde." +
                    "\n\n Mit freundlichen Gr\u00fc\u00dfen" +
                    "\n Ihr Team von Hipster Rental Corp" +
                    "\n\n Hier k\u00f6nnte unsere Adresse oder Ihre Werbung stehen.");

            Transport transport = session.getTransport("smtp");
            transport.connect("smtp.gmail.com", username, password);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();


        } catch (Exception e) {
            e.printStackTrace();

        }
    }

    public static void sendStatusUpdateMail(int buchung,String status){
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
        DatabaseHelper db=new DatabaseHelper();
        String mail=db.getKundenMail(buchung);
        db.disconnectDatabase();
        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("hipsterrentalcorp@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(mail));
            message.setSubject("Bestellung erfasst");
            message.setText("Sehr geeherter Kunde,"
                    + "\n\n Ihre Bestellung wurde " + status+"."+
                    "\n\n Mit freundlichen Gr\u00fc\u00dfen" +
                    "\n Ihr Team von Hipster Rental Corp" +
                    "\n\n Hier k\u00f6nnte unsere Adresse oder Ihre Werbung stehen.");

            Transport transport = session.getTransport("smtp");
            transport.connect("smtp.gmail.com", username, password);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();


        } catch (Exception e) {
            e.printStackTrace();

        }
    }
}


