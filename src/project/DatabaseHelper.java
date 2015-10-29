package project;

import MD5.MD5;

import javax.management.Notification;
import java.sql.*;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;

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
    //test

    public ResultSet getAllProducts(){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_produkt ORDER BY prod_kategorie");
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

    public void addProduct(String kategorie, String hersteller, Double preis, String beschreibung, String details, String bezeichnung, String infBezeichnung){
        try {
            ResultSet rs = stmt.executeQuery("SELECT * FROM tbl_produkt");
            if(rs != null){
                stmt.executeQuery("INSERT INTO tbl_produkt (prod_id, prod_kategorie, prod_hersteller, prod_preis, prod_beschreibung, prod_details, prod_bezeichn, prod_infbezeichn, buch_anzahl) " +
                        "VALUES ((SELECT max(prod_id) FROM tbl_produkt) + 1, '" + kategorie + "', '" + hersteller + "', "+ preis +", '" + beschreibung +"', '"+ details +"', '"+ bezeichnung +"', '"+ infBezeichnung +"', 0)");
            } else {
                stmt.executeQuery("INSERT INTO tbl_produkt (prod_id, prod_kategorie, prod_hersteller, prod_preis, prod_beschreibung, prod_details, prod_bezeichn, prod_infbezeichn, buch_anzahl) " +
                        "VALUES (1, '" + kategorie + "', '" + hersteller + "', "+ preis +", '" + beschreibung +"', '"+ details +"', '"+ bezeichnung +"', '"+ infBezeichnung +"', 0)");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Integer id, String kategorie, String hersteller, Double preis, String beschreibung, String details, String bezeichnung, String infBezeichnung, Integer buchungAnzahl){
        try {
            stmt.executeQuery("UPDATE tbl_produkt SET prod_kategorie = '"+ kategorie +"', prod_hersteller = '"+ hersteller +"', prod_preis = "+ preis +", prod_beschreibung = '"+ beschreibung +"', " +
                    "prod_details = '"+ details +"', prod_bezeichn = '"+ bezeichnung +"', prod_infbezeichn = '"+ infBezeichnung +"', buch_Anzahl = "+ buchungAnzahl + "WHERE prod_id = "+ id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addKategorie(String name, String uebergeordnet){
        try {
            ResultSet rs = stmt.executeQuery("SELECT kat_name FROM tbl_kategorie WHERE kat_name = '"+ name +"'");
            if(rs != null){
                stmt.executeQuery("INSERT INTO tbl_kategorie (kat_name, kat_uebergeordnet))" +
                        "VALUES ('"+ name +"', '"+ uebergeordnet +"')");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateKategorie(String name, String uebergeordnet){
        try {
            stmt.executeQuery("UPDATE tbl_kategorie SET kat_name = '"+ name + "', kat_uebergeordnet = '"+ uebergeordnet + "' WHERE kat_name = '"+ name + "' ");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public double getPrice(Integer id){
        Double preis = null;
        try {
            ResultSet rs = stmt.executeQuery("SELECT prod_preis FROM tbl_produkt WHERE prod_id = "+ id);
            rs.next();
            preis = rs.getDouble("prod_preis");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return preis;
    }

    public ResultSet getProductsByKategorie(String kategorie){
        ResultSet rs = null;
        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_produkt WHERE prod_kategorie = '"+ kategorie +"'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public Integer getAnzahlProdukte(){
        Integer anzahl = null;
        try {
            ResultSet rs = stmt.executeQuery("SELECT COUNT(prod_id) AS id FROM tbl_produkt");
            rs.next();
            anzahl = rs.getInt("id");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return anzahl;
    }

    public ResultSet getAllKategories(){
        ResultSet rs = null;
        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_kategorie");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public String getBezeichnung(Integer produktid){
        String bezeichnung = null;
        try {
            ResultSet rs = stmt.executeQuery("SELECT prod_bezeichn FROM tbl_produkt WHERE prod_id = " + produktid);
            rs.next();
            bezeichnung = rs.getString("prod_bezeichn");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bezeichnung;
    }

    public Boolean produktVerfuegbar(Integer produktid, Date abholung, Date abgabe){
        Boolean verfuegbar = false;
        ResultSet rs = null;
        List<String> codes = new ArrayList<String>();
        List<Integer> bCodes = new ArrayList<Integer>();
        Boolean inbuchung = false;
        try {
            rs = stmt.executeQuery("SELECT prod_code FROM tbl_lagerliste WHERE prod_id =" + produktid);
            while(rs.next()){
                codes.add(rs.getString("prod_code"));
            }

            rs = stmt.executeQuery("SELECT buch_code FROM tbl_buchungsliste WHERE (buch_abholungsdatum <= "+ abholung + " AND buch_rueckgabedatum >= "+ abholung+ ") OR (buch_abholungsdatum <= "+ abgabe +" AND buch_rueckgabedatum >= "+ abgabe +") OR (buch_abholdatum >= "+ abholung +" AND buch_rueckgabedatum <= "+ abgabe +")");
            if(rs != null) {
                while (rs.next()) {
                    bCodes.add(rs.getInt("buch_code"));
                }
                for(String hwCode : codes){
                    for(Integer bcode : bCodes){
                        rs=stmt.executeQuery("SELECT * FROM tbl_buchungsliste_produkt WHERE prod_id = '"+ hwCode + "' AND bestell_id = "+ bcode);
                        if(rs != null){
                            inbuchung=true;
                        }
                    }
                    if(!inbuchung){
                        verfuegbar=true;
                        break;
                    }
                }
            } else{
                verfuegbar=true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return verfuegbar;
    }
}
