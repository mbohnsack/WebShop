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
                "jdbc:postgresql://HOSTNAME:PORT/Webshop", "postgres", ""); //Hier später die entsprechende Serveranbindung
            Statement stmt = c.createStatement();
        } catch (Exception e) {
            System.out.println("Could not create a statement");
            e.printStackTrace();
        }
    }

    public void createMitarbeiter(String name, String passwort){
        try {
            stmt.executeUpdate("INSERT INTO tbl_mitarbeiter (mit_benutzer,mit_passwort,mit_typ) VALUES (" + name + "," + passwort + ",buero);");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public void deleteMitarbeiter(String name){
        try {
            stmt.executeUpdate("DELETE FROM tbl_mitarbeiter WHERE mit_benutzer="+name+";");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public boolean MitarbeiterFrei(String name){
        Boolean frei=false;
        try {
            ResultSet rs=stmt.executeQuery("SELECT * FROM tbl_mitarbeiter WHERE mit_benutzer=" + name + ";");
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

    public void createKunde(String name,String passwort,String nname, String vname, String strasse, String hnummer, int plz,String ort, int tel, int mobil, String email){
        try{
            ResultSet rs =stmt.executeQuery( "SELECT MAX(kun_nummer) AS MaxID FROM tbl_kunde;" );
            int nummer=rs.getInt("MaxID")+1;
            stmt.executeUpdate("INSERT INTO tbl_kunde (kun_nummer, kun_benutzer, kun_passwort, kun_name, kun_vorname, kun_strasse, kun_hausnummer, kun_plz, kun_ort, kun_telefon, kun_mobil, kun_email)" +
                    "VALUES ("+nummer+","+name+","+passwort+","+nname+","+vname+","+strasse+","+hnummer+","+plz+","+ort+","+tel+","+mobil+","+email+");");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public boolean KundeFrei(String name){
        Boolean frei=false;
        try {
            ResultSet rs=stmt.executeQuery("SELECT * FROM tbl_kunde WHERE kun_benutzer=" + name + ";");
            if (rs==null){
                frei=true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return frei;
    }
}
