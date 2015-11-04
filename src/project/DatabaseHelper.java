package project;

import MD5.MD5;
import org.postgresql.largeobject.LargeObject;
import org.postgresql.largeobject.LargeObjectManager;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
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

    public void createMitarbeiter(String name, String passwort, String typ){
        try {
            stmt.executeUpdate("INSERT INTO tbl_mitarbeiter (mit_benutzer,mit_passwort,mit_typ) VALUES ('" + name + "','" + MD5.getMD5(passwort) + "','"+typ+"');");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public void updateMitarbeiter(String typ, String benutzerName){
        try {
            stmt.executeQuery("UPDATE tbl_mitarbeiter SET mit_typ = '"+ typ +"' WHERE mit_benutzer = '"+ benutzerName+"'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getMitarbeiterRolle(String name){
        String rolle=null;
        try {
            ResultSet rs=stmt.executeQuery("SELECT  mit_typ FROM  tbl_mitarbeiter WHERE  mit_benutzer='"+name+"'");
            if(!rs.isBeforeFirst()){

            }else{
                rs.next();
                rolle=rs.getString("mit_typ");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rolle;
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
            if (!rs.isBeforeFirst()){
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
            if (!rs.isBeforeFirst()){
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

    public void deleteKunde(String name){
        try {
            stmt.executeUpdate("DELETE FROM tbl_kunde WHERE kun_benutzer='"+name+"';");
        }catch(Exception e){
            e.printStackTrace();
        }
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

    public Integer createBuchung(String kundenmail, Date abholdatum, Date abgabedatum, List<Integer> produktids){
        Boolean verfuegbar = false;
        Integer kundenId = null;
        Integer buchcode = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        List<String> hwcodes = new ArrayList<String>();
        try {
            rs = stmt.executeQuery("SELECT kun_nummer FROM tbl_kunde WHERE kun_email = '"+ kundenmail +"'");
            rs2 = stmt.executeQuery("SELECT max(buch_code)+1 FROM tbl_buchungsliste");
            rs2.next();
            buchcode = rs.getInt("buch_code");
            if(!rs.next()) {
                kundenId = rs.getInt("kun_nummer");
                return -1;
            } else {
                for(Integer produkt : produktids){
                    if(produktVerfuegbar(produkt, abholdatum, abgabedatum)){
                        rs = stmt.executeQuery("SELECT prod_code FROM tbl_lagerliste WHERE prod_id = "+ produkt);
                        if(rs.next()){
                            String prodcode = rs.getString("prod_code");
                            hwcodes.add(prodcode);
                            stmt.executeUpdate("INSERT INTO tbl_buchung_produkt (bestell_id, produkt_code)" +
                                    " VALUES ("+ buchcode +", '"+ prodcode +"')");
                        } else{
                            return -1;
                        }
                    } else{
                        return -1;
                    }
                }
                verfuegbar=true;
                stmt.executeUpdate("INSERT INTO tbl_buchungsliste (kun_id, buch_abholdatum, buch_rueckgabedatum, buch_code, buch_status)" +
                        " VALUES ("+ kundenId +", "+ abholdatum +", "+ abgabedatum +", "+ buchcode +", 'ausstehend'");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }


        return buchcode;
    }

    public ResultSet getBuchungen(){
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_buchungsliste WHERE buch_status = 'ausstehend'");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    public Integer addProduct(String kategorie, String hersteller, Double preis, String beschreibung, String details, String bezeichnung, String infBezeichnung){
        Integer id = null;
        try {
            ResultSet rs = stmt.executeQuery("SELECT * FROM tbl_produkt");
            if(rs.isBeforeFirst()){
                stmt.executeUpdate("INSERT INTO tbl_produkt (prod_id, prod_kategorie, prod_hersteller, prod_preis, prod_beschreibung, prod_details, prod_bezeichn, prod_infbezeichn, buch_anzahl) " +
                        "VALUES ((SELECT max(prod_id) FROM tbl_produkt) + 1, '" + kategorie + "', '" + hersteller + "', " + preis + ", '" + beschreibung + "', '" + details + "', '" + bezeichnung + "', '" + infBezeichnung + "', 0)");
                rs = stmt.executeQuery("SELECT max(prod_id) AS id FROM tbl_produkt");
                rs.next();
                id = rs.getInt("id");
            } else {
                stmt.executeUpdate("INSERT INTO tbl_produkt (prod_id, prod_kategorie, prod_hersteller, prod_preis, prod_beschreibung, prod_details, prod_bezeichn, prod_infbezeichn, buch_anzahl) " +
                        "VALUES (1, '" + kategorie + "', '" + hersteller + "', " + preis + ", '" + beschreibung + "', '" + details + "', '" + bezeichnung + "', '" + infBezeichnung + "', 0)");
                rs = stmt.executeQuery("SELECT max(prod_id) AS id FROM tbl_produkt");
                rs.next();
                id = rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;
    }

    public void updateProduct(Integer id, String kategorie, String hersteller, Double preis, String beschreibung, String details, String bezeichnung, String infBezeichnung, Integer buchungAnzahl){
        try {
            stmt.executeQuery("UPDATE tbl_produkt SET prod_kategorie = '" + kategorie + "', prod_hersteller = '" + hersteller + "', prod_preis = " + preis + ", prod_beschreibung = '" + beschreibung + "', " +
                    "prod_details = '" + details + "', prod_bezeichn = '" + bezeichnung + "', prod_infbezeichn = '" + infBezeichnung + "', buch_Anzahl = " + buchungAnzahl + "WHERE prod_id = " + id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addKategorie(String name, String uebergeordnet, File bild){
        try {
            ResultSet rs = stmt.executeQuery("SELECT kat_name FROM tbl_kategorie WHERE kat_name = '"+ name +"'");
            if(!rs.isBeforeFirst()){
                c.setAutoCommit(false);

// Get the Large Object Manager to perform operations with
                LargeObjectManager lobj = ((org.postgresql.PGConnection)c).getLargeObjectAPI();

//create a new large object
                int oid = lobj.create(LargeObjectManager.READ | LargeObjectManager.WRITE);

//open the large object for write
                LargeObject obj = lobj.open(oid, LargeObjectManager.WRITE);

// Now open the file
                FileInputStream fis = new FileInputStream(bild);

// copy the data from the file to the large object
                byte buf[] = new byte[2048];
                int s, tl = 0;
                while ((s = fis.read(buf, 0, 2048)) > 0)
                {
                    obj.write(buf, 0, s);
                    tl += s;
                }

// Close the large object
                obj.close();

//Now insert the row into imagesLO
                PreparedStatement ps=c.prepareStatement("INSERT INTO tbl_kategorie VALUES (?,?,?)");
                ps.setString(1, name);
                ps.setInt(2,oid);
                ps.setString(3, uebergeordnet);
                ps.executeUpdate();
                ps.close();
                fis.close();
                c.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void updateKategorie(String name, String uebergeordnet, File bild){
        try {
            c.setAutoCommit(false);

// Get the Large Object Manager to perform operations with
            LargeObjectManager lobj = ((org.postgresql.PGConnection)c).getLargeObjectAPI();

//create a new large object
            int oid = lobj.create(LargeObjectManager.READ | LargeObjectManager.WRITE);

//open the large object for write
            LargeObject obj = lobj.open(oid, LargeObjectManager.WRITE);

// Now open the file
            FileInputStream fis = new FileInputStream(bild);

// copy the data from the file to the large object
            byte buf[] = new byte[2048];
            int s, tl = 0;
            while ((s = fis.read(buf, 0, 2048)) > 0)
            {
                obj.write(buf, 0, s);
                tl += s;
            }

// Close the large object
            obj.close();

//Now insert the row into imagesLO
            PreparedStatement ps=c.prepareStatement("INSERT INTO tbl_kategorie VALUES (?,?,?)");
            ps.setString(1, name);
            ps.setInt(2,oid);
            ps.setString(3, uebergeordnet);
            ps.executeUpdate();
            ps.close();
            fis.close();
            c.setAutoCommit(true);
        } catch (SQLException e1) {
            e1.printStackTrace();
        } catch (IOException e1) {
            e1.printStackTrace();
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
            rs = stmt.executeQuery("SELECT * FROM tbl_produkt WHERE prod_kategorie = '" + kategorie + "'");
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

    public Integer getAnzahlProdukteInKategorie(String category){
        Integer anzahl = null;
        try {
            ResultSet rs = stmt.executeQuery("SELECT COUNT(prod_id) AS id FROM tbl_produkt WHERE prod_kategorie = '"+ category +"'");
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

    public ResultSet getKategorie(String category){
        ResultSet cat = null;
        try {
            cat = stmt.executeQuery("SELECT * FROM tbl_kategorie WHERE kat_name = '" + category + "'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cat;
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

    public Boolean produktVerfuegbar(Integer produktid, Date abholungTemp, Date abgabeTemp){
        java.sql.Date abholung = new java.sql.Date(abholungTemp.getTime());
        java.sql.Date abgabe = new java.sql.Date(abgabeTemp.getTime());
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

            rs = stmt.executeQuery("SELECT buch_code FROM tbl_buchungsliste WHERE (buch_abholdatum <= '" + abholung + "' AND buch_rueckgabedatum >= '" + abholung + "') OR (buch_abholdatum <= '" + abgabe + "' AND buch_rueckgabedatum >= '" + abgabe + "') OR (buch_abholdatum >= '" + abholung + "' AND buch_rueckgabedatum <= '" + abgabe + "')");
            if(rs != null) {
                while (rs.next()) {
                    bCodes.add(rs.getInt("buch_code"));
                }
                for(String hwCode : codes){
                    for(Integer bcode : bCodes){
                        rs=stmt.executeQuery("SELECT * FROM tbl_buchung_produkt WHERE produkt_code = '"+ hwCode + "' AND bestell_id = "+ bcode);
                        if(!rs.isBeforeFirst()){
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

    public Integer getHWCode (Integer produktid, Date abholung, Date abgabe){
        List<String> codes = new ArrayList<String>();
        List<Integer> bCodes = new ArrayList<Integer>();
        ResultSet rs = null;
        Boolean inbuchung = false;
        Boolean verfuegbar = false;
        try {
            rs = stmt.executeQuery("SELECT prod_code FROM tbl_lagerliste WHERE prod_id =" + produktid);
            while(rs.next()){
                codes.add(rs.getString("prod_code"));
            }

            rs = stmt.executeQuery("SELECT buch_code FROM tbl_buchungsliste WHERE (buch_abholdatum <= '" + abholung + "' AND buch_rueckgabedatum >= '" + abholung + "') OR (buch_abholdatum <= '" + abgabe + "' AND buch_rueckgabedatum >= '" + abgabe + "') OR (buch_abholdatum >= '" + abholung + "' AND buch_rueckgabedatum <= '" + abgabe + "')");
            if(rs != null) {
                while (rs.next()) {
                    bCodes.add(rs.getInt("buch_code"));
                }
                for(String hwCode : codes){
                    for(Integer bcode : bCodes){
                        rs=stmt.executeQuery("SELECT * FROM tbl_buchung_produkt WHERE produkt_code = '"+ hwCode + "' AND bestell_id = "+ bcode);
                        if(!rs.isBeforeFirst()){
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
        return produktid;
    }

    public ResultSet getMitarbeiter(){
        ResultSet rs=null;
        try {
            rs=stmt.executeQuery("SELECT  * from tbl_mitarbeiter WHERE mit_typ='mitarbeiter'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public ResultSet getAdmin(){
        ResultSet rs=null;
        try {
            rs=stmt.executeQuery("SELECT  * from tbl_mitarbeiter WHERE mit_typ='admin'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public ResultSet getAllMitarbeiter(){
        ResultSet rs=null;
        try {
            rs=stmt.executeQuery("SELECT  * from tbl_mitarbeiter");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public ResultSet getKundenDatenByNr(Integer kundenNR){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_kunde WHERE kun_nummer = " + kundenNR);
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }
    public ResultSet getKundenDatenByLogin(String login){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_kunde WHERE kun_benutzer = '" + login +"'");
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }
    public void updateKundenDaten(Integer kundenNR, String nname, String vname, String strasse, String ort, String email, String hausn, int plz, int tele, int mobil, String passwort, String login){
        try{
            stmt.executeUpdate("UPDATE tbl_kunde " +
                    "SET kun_name = '"+nname+"', kun_vorname = '"+vname+"', kun_strasse = '"+strasse+"', kun_ort = '"+ort+"', kun_email = '"+email+"', kun_hausnummer = '"+hausn+"', kun_plz = '"+plz+"', kun_telefon = '"+tele+"', kun_mobil = '"+mobil+"', kun_passwort = '"+ MD5.getMD5(passwort)+"', kun_benutzer = '"+login+"' WHERE kun_nummer = '"+kundenNR+"' ");
        }catch(Exception e){
            e.printStackTrace();
}
}

    public Integer getAnzahlBuchungById(Integer produktid){
        Integer anzahl = null;
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT buch_anzahl FROM tbl_produkt WHERE prod_id = "+ produktid);
            rs.next();
            anzahl = rs.getInt("buch_anzahl");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return anzahl;
    }

    public String getUebergeordneteKategorie(String kname) {
        String uebergeordnet = null;
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT kat_uebergeordnet FROM tbl_kategorie WHERE kat_name = '"+ kname + "'");
            rs.next();
            uebergeordnet = rs.getString("kat_uebergeordnet");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return uebergeordnet;
    }
    public void saveFile(File bild, int prodid) throws SQLException, IOException {
        c.setAutoCommit(false);

// Get the Large Object Manager to perform operations with
        LargeObjectManager lobj = ((org.postgresql.PGConnection)c).getLargeObjectAPI();

//create a new large object
        int oid = lobj.create(LargeObjectManager.READ | LargeObjectManager.WRITE);

//open the large object for write
        LargeObject obj = lobj.open(oid, LargeObjectManager.WRITE);

// Now open the file
        FileInputStream fis = new FileInputStream(bild);

// copy the data from the file to the large object
        byte buf[] = new byte[2048];
        int s, tl = 0;
        while ((s = fis.read(buf, 0, 2048)) > 0)
        {
            obj.write(buf, 0, s);
            tl += s;
        }

// Close the large object
        obj.close();

//Now insert the row into imagesLO
       PreparedStatement ps=c.prepareStatement("INSERT INTO tbl_bild VALUES (?,?)");
        ps.setInt(1,prodid);
        ps.setInt(2,oid);
        ps.executeUpdate();
        ps.close();
        fis.close();
        c.setAutoCommit(true);
    }

    public void disconnectDatabase(){
        try {
            stmt.close();
            c.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
