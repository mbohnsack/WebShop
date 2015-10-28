import MD5.MD5;

import java.sql.*;

/**
 * Created by Malte on 14.10.2015.
 */
public class DatabaseHelper{
    Connection c;
    Statement stmt;

    public DatabaseHelper() {
        try {
            Class.forName("org.postgresql.Driver");
            c = DriverManager.getConnection(
                "jdbc:postgresql://mbohnbowling.ddns.net:5432/Webshop", "webuser", "winf114"); //Hier später die entsprechende Serveranbindung
             stmt = c.createStatement();
        } catch (Exception e) {
            System.out.println("Could not create a statement");
            e.printStackTrace();
        }
    }

    public void createMitarbeiter(String name, String passwort){
        try {
            stmt.executeUpdate("INSERT INTO tbl_mitarbeiter (mit_benutzer,mit_passwort,mit_typ) VALUES ('" + name + "','" + MD5.getMD5(passwort) + "','buero');");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public void deleteMitarbeiter(String name){
        try {
            stmt.executeUpdate("DELETE FROM tbl_mitarbeiter WHERE mit_benutzer='"+name+"';");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public boolean mitarbeiterFrei(String name){
        Boolean frei=false;
        try {
            ResultSet rs=stmt.executeQuery("SELECT * FROM tbl_mitarbeiter WHERE UPPER(mit_benutzer)=UPPER('" + name + "');");
            if (rs==null){
                frei=true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return frei;
    }

    public ResultSet getTopProducts(){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_produkt ORDER BY buch_anzahl DESC FETCH FIRST 10 ROWS ONLY ");
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }

    public ResultSet getProductsById(Integer Id){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_produkt WHERE prod_id = " + Id);
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }

    public void createKunde(String name,String passwort,String nname, String vname, String strasse, String hnummer, int plz,String ort, int tel, int mobil, String email){
        try{
            ResultSet rs =stmt.executeQuery( "SELECT MAX(kun_nummer) AS MaxID FROM tbl_kunde;" );
            int nummer=rs.getInt("MaxID")+1;
            stmt.executeUpdate("INSERT INTO tbl_kunde (kun_nummer, kun_benutzer, kun_passwort, kun_name, kun_vorname, kun_strasse, kun_hausnummer, kun_plz, kun_ort, kun_telefon, kun_mobil, kun_email)" +
                    "VALUES ("+nummer+",'"+name+"','"+passwort+"','"+nname+"','"+vname+"','"+strasse+"','"+hnummer+"',"+plz+",'"+ort+"',"+tel+","+mobil+",'"+email+"');");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public boolean KundeFrei(String name){
        Boolean frei=false;
        try {
            ResultSet rs=stmt.executeQuery("SELECT * FROM tbl_kunde WHERE kun_benutzer='" + name + "';");
            if (rs==null){
                frei=true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return frei;
    }
    public boolean loginKunde(String name, String password) {
        Boolean loginstate = false;
        try {
            ResultSet rs = stmt.executeQuery("SELECT * FROM tbl_kunde WHERE kun_benutzer='" + name + "'");
            while (rs.next()) {
                if (rs.getString("kun_passwort").equals(MD5.getMD5(password))) {
                    loginstate = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return loginstate;
    }

    public boolean loginMitarbeiter(String name, String password) {
        Boolean loginstate = false;
        try {
            ResultSet rs = stmt.executeQuery("SELECT * FROM tbl_mitarbeiter WHERE mit_benutzer='" + name + "'");
            while (rs.next()) {
                if (rs.getString("mit_passwort").equals(MD5.getMD5(password))) {
                    loginstate = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return loginstate;
    }

    public ResultSet draftBestellung(){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_buchungsliste WHERE buch_status='draft' ORDER BY buch_abholdatum ASC");
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }

    public void submitBuchung (String buchung){
        try {
            int buchungi=Integer.parseInt(buchung);
            stmt.executeUpdate("UPDATE tbl_buchungsliste SET buch_status='angenommen'");
            ResultSet rs=stmt.executeQuery("SELECT * FROM tbl_buchungsliste b JOIN tbl_produkk p WHERE b.buch_code='"+buchungi+"' AND b.buch_produkt=p.prod_id");
            rs.next();
            String produkt=rs.getString("prod_bezeichn");
            String datum=rs.getString("buch_abholdatum");
            SendMailSSL.sendSubmitMail(produkt, datum);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void createBuchung(){

    }
}
