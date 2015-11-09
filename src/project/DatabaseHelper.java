package project;

import MD5.MD5;

import java.io.File;
import java.io.FileInputStream;
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

    //Initieren des DatebaseHelper inkl. Verbindungsaufbau zum PostgreSQL-Server
    public DatabaseHelper() {
        try {
            Class.forName("org.postgresql.Driver");
            c = DriverManager.getConnection(
                "jdbc:postgresql://mbohnbowling.ddns.net:5432/Webshop", "webuser", "winf114"); //Hier sp�ter die entsprechende Serveranbindung
             stmt = c.createStatement();
        } catch (Exception e) {
            System.out.println("Could not create a statement");
            e.printStackTrace();
        }
    }

    //Anlegen eines neuen Mitarbeiter in der Datenbank
    public void createMitarbeiter(String name, String passwort, String typ){
        try {
            stmt.executeUpdate("INSERT INTO tbl_mitarbeiter (mit_benutzer,mit_passwort,mit_typ) VALUES ('" + name + "','" + MD5.getMD5(passwort) + "','"+typ+"');");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    //Ändern der Rolle eines Mitarbeiters in der Datenbank
    public void updateMitarbeiter(String typ, String benutzerName){
        try {
            stmt.executeQuery("UPDATE tbl_mitarbeiter SET mit_typ = '"+ typ +"' WHERE mit_benutzer = '"+ benutzerName+"'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Rückgabe der Rolle eines Mitarbeiters
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

    //LÖschen eines Mitarbeiters aus der Datenbank
    public void deleteMitarbeiter(String name){
        try {
            stmt.executeUpdate("DELETE FROM tbl_mitarbeiter WHERE mit_benutzer='"+name+"';");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    //Löschen eines Kunden aus der Datenbank
    public void deleteKunde(String name){
        try {
            stmt.executeUpdate("DELETE FROM tbl_kunde WHERE kun_benutzer='"+name+"';");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    //Rückgabe, ob der Mitarbeitername noch ungenutzt/verfügbar ist
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

    //Rückgabe eines ReSultSets mit den 9 meistgebuchten Produkten
    public ResultSet getTopProducts(){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_produkt ORDER BY buch_anzahl DESC FETCH FIRST 9 ROWS ONLY ");
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }

    //Rüclgabe eines ResultSets mit dem Produkt, weches zur übergebenen ProduktId gehört
    public ResultSet getProductsById(Integer Id){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_produkt WHERE prod_id = " + Id);
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }

    //Rückgabe eines ResultSets mit allen Produkten der Datenbank (exkl. Pakete).
    public ResultSet getAllProducts(){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_produkt WHERE NOT prod_hersteller = 'Paket' ORDER BY prod_kategorie");
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }

    //Anlegen eines neuen Kunden mit der Rückgabe, ob das anlegen erfolgreich war
    public boolean createKunde(String name,String passwort,String nname, String vname, String strasse, String hnummer, int plz,String ort, int tel, int mobil, String email, String orga){
        try{
            ResultSet rs =stmt.executeQuery( "SELECT MAX(kun_nummer) AS MaxID FROM tbl_kunde;" );
            rs.next();
            int nummer=rs.getInt("MaxID")+1;
            stmt.executeUpdate("INSERT INTO tbl_kunde (kun_nummer, kun_benutzer, kun_passwort, kun_name, kun_vorname, kun_strasse, kun_hausnummer, kun_plz, kun_ort, kun_telefon, kun_mobil, kun_email, kun_orga)" +
                    "VALUES ("+nummer+",'"+name+"','"+MD5.getMD5(passwort)+"','"+nname+"','"+vname+"','"+strasse+"','"+hnummer+"',"+plz+",'"+ort+"',"+tel+","+mobil+",'"+email+"','"+orga+"');");
                    return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }

    //Rückgabe, ob der Kundenname verfügbar/ungenutzt ist
    public boolean KundeFrei(String name){
        Boolean frei=false;
        try {
            ResultSet rs=stmt.executeQuery("SELECT * FROM tbl_kunde WHERE kun_benutzer='" + name + "';");
            if (!rs.next()){
                frei=true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return frei;
    }

    //Rückgabe, ob die eingegebenen LoginDaten richtig sind (Kunde)
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


    //Rückgabe, ob die einggegebenen LoginDaten richtig sind (Mitarbeiter)
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

    @Deprecated
    public ResultSet draftBestellung(){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_buchungsliste WHERE buch_status='draft' ORDER BY buch_abholdatum ASC");
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }

    @Deprecated
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

    //Erstellen einer neuen Buchung inkl. Prüfung, ob Produkte verfügbar, Ermittlung der physischen Geräte und erhöhen des Buchungszählers; Rückgabe der BuchungsID bei Erfolg, ansonsten -1
    public Integer createBuchung(String kundenmail, Date abholdatum, Date abgabedatum, List<Integer> produktids){
        java.sql.Date abholung = new java.sql.Date(abholdatum.getTime());
        java.sql.Date abgabe = new java.sql.Date(abgabedatum.getTime());
        Boolean verfuegbar = false;
        Integer kundenId = null;
        Integer buchcode = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        List<String> hwcodes = new ArrayList<String>();
        try {
            rs2 = stmt.executeQuery("SELECT max(buch_code)+1 as buch_code FROM tbl_buchungsliste");
            rs2.next();
            buchcode = rs2.getInt("buch_code");
            rs = stmt.executeQuery("SELECT kun_nummer FROM tbl_kunde WHERE kun_email = '"+ kundenmail +"'");
            if(rs.isBeforeFirst()) {
                rs.next();
                kundenId = rs.getInt("kun_nummer");
                for(Integer produkt : produktids){
                    if(produktVerfuegbar(produkt, abholdatum, abgabedatum)){
                        rs = stmt.executeQuery("SELECT prod_code FROM tbl_lagerliste WHERE prod_id = "+ produkt);
                        if(rs.next()){
                            c.createStatement().executeUpdate("UPDATE tbl_produkt SET buch_anzahl =(SELECT buch_anzahl+1 FROM tbl_produkt where prod_id = " + produkt + ") WHERE prod_id = " + produkt);
                            String prodcode = rs.getString("prod_code");
                            hwcodes.add(prodcode);
                        } else{
                            return -1;
                        }
                    } else{
                        return -1;
                    }
                }
                verfuegbar=true;

                stmt.executeUpdate("INSERT INTO tbl_buchungsliste (kun_id, buch_abholdatum, buch_rueckgabedatum, buch_code, buch_status)" +
                        " VALUES ("+ kundenId +", '"+ abholung +"', '"+ abgabe +"', "+ buchcode +", 'ausstehend')");
                for(String hwcode : hwcodes){
                    stmt.executeUpdate("INSERT INTO tbl_buchung_produkt (bestell_id, produkt_code)" +
                            " VALUES (" + buchcode + ", '" + hwcode + "')");
                }
            } else {
                return -1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return buchcode;
    }

    //Rückgabe eines ResultSets mit allen ausstehenden Buchungen
    public ResultSet getBuchungen(){
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_buchungsliste WHERE buch_status = 'ausstehend'");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //Rückgabe eines ResultSets mit allen Buchungen eines bestimmten Kunden
    public ResultSet getBuchungenByKunId(int kunId){
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_buchungsliste WHERE kun_id = '"+kunId+"'");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //Rückgabe eines ResultSets mit einer Buchung, die mitHilde der BuchungsId ermittelt wird
    public ResultSet getBuchungById(int buchId){
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_buchungsliste WHERE buch_code = '"+buchId+"'");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //Ändern des Buchungsstatus in angenommen oder abgelehnt; Rückgabe, ob erfolgreich
    public Boolean updateBuchungsstatus(Integer buchungsId, String status){
        Boolean erfolgreich = false;

        try {
            stmt.executeUpdate("UPDATE tbl_buchungsliste SET buch_status = '"+ status +"' WHERE buch_code = "+ buchungsId);
            erfolgreich = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return erfolgreich;
    }

    //Rückgabe, wie viele Tage ein Produkt gebucht ist
    public Integer getBuchungsdauerById(Integer id){
        Integer tage = null;
        Date abholung = null;
        Date rueckgabe = null;
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_buchungsliste WHERE buch_code = "+ id);
            rs.next();
            abholung = rs.getDate("buch_abholdatum");
            rueckgabe = rs.getDate("buch_rueckgabedatum");
            tage = (int)((rueckgabe.getTime() - abholung.getTime())/1000/3600/24);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tage;
    }

    //Rückgabe eines Buchungszeitraumes als String
    public String getZeitraum(Integer buchungId){
        String zeitraum = null;
        Date abholung = null;
        Date rueckgabe = null;
        ResultSet rs = null;
        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_buchungsliste WHERE buch_code = "+ buchungId);
            rs.next();
            abholung = rs.getDate("buch_abholdatum");
            rueckgabe = rs.getDate("buch_rueckgabedatum");
            zeitraum = abholung.toString() + " - " + rueckgabe.toString();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return zeitraum;
    }

    //Anlegen eines neuen Produktes (exkl. Bild), Rückgabe der ProduktId
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

    //Aktualisiren/updaten der Produktdaten (exkl. Bild)
    public void updateProduct(Integer id, String kategorie, String hersteller, Double preis, String beschreibung, String details, String bezeichnung, String infBezeichnung, Integer buchungAnzahl){
        try {
            stmt.executeQuery("UPDATE tbl_produkt SET prod_kategorie = '" + kategorie + "', prod_hersteller = '" + hersteller + "', prod_preis = " + preis + ", prod_beschreibung = '" + beschreibung + "', " +
                    "prod_details = '" + details + "', prod_bezeichn = '" + bezeichnung + "', prod_infbezeichn = '" + infBezeichnung + "', buch_Anzahl = " + buchungAnzahl + "WHERE prod_id = " + id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Löschen eines Produktes (inkl. Bilder)
    public void deleteProduct(Integer id){
        try {
            stmt.executeUpdate("DELETE FROM tbl_bild WHERE prod_id ="+ id);
            stmt.executeUpdate("DELETE FROM tbl_lagerliste WHERE prod_id ="+ id);
            stmt.executeUpdate("DELETE FROM tbl_produkt WHERE prod_id = " + id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Neue Kategorie anegen (inkl. Bild)
    public void addKategorie(String name, String uebergeordnet, File bild) throws IOException, SQLException {

        FileInputStream fis = new FileInputStream(bild);
        PreparedStatement ps = c.prepareStatement("INSERT INTO tbl_kategorie VALUES (?, ?, ?)");
        ps.setString(1, name);
        ps.setString(2, uebergeordnet);
        ps.setBinaryStream(3, fis, bild.length());
        ps.executeUpdate();
        ps.close();
        fis.close();

    }

    //Neue Kategorie anlegen (exkl. Bild)
    public void addKategorie(String name, String uebergeordnet) throws IOException, SQLException {

        stmt.executeUpdate("INSERT INTO tbl_kategorie (kat_name, kat_uebergeordnet) VALUES ('"+ name +"', '"+ uebergeordnet +"')");

    }

    //Aktualisiren/updaten der Kategorie (inkl. Bild)
    public void updateKategorie(String name, String uebergeordnet, File bild) throws IOException, SQLException {

        FileInputStream fis = new FileInputStream(bild);
        PreparedStatement ps = c.prepareStatement("UPDATE tbl_kategorie SET kat_uebergeordnet = ?, kat_bild = ? WHERE kat_name = ?");
        ps.setString(1, uebergeordnet);
        ps.setBinaryStream(2, fis, bild.length());
        ps.setString(3, name);
        ps.executeUpdate();
        ps.close();
        fis.close();

    }

    //Aktualisiren/updaten der Kategorie (exkl. Bild)
    public void updateKategorie(String name, String uebergeordnet) throws IOException, SQLException {

        stmt.executeUpdate("UPDATE tbl_kategorie SET kat_uebergeordnet = '"+ uebergeordnet +"' WHERE kat_name = '"+ name +"'");

    }

    //Rückgabe des Produktpreises
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

    //Rückgabe eines ResultSets mit den Produkten einer bestimmten Kategorie
    public ResultSet getProductsByKategorie(String kategorie){
        ResultSet rs = null;
        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_produkt WHERE prod_kategorie = '" + kategorie + "'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    //Rückgabe der Anzahl aller Produkte
    @Deprecated
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

    //Rückgabe der Anzahl an Produkten in einer bestimmten Kategorie
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

    //Rückgabe eines ResultSets mit allen Kategorien
    public ResultSet getAllKategories(){
        ResultSet rs = null;
        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_kategorie");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    //Rückgabe eines ResultSets mit allen Kategorien, die Unterkategorien besitzen
    public ResultSet getAllKategorienWithUnterkategorien(){
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT kat_uebergeordnet FROM tbl_kategorie WHERE NOT kat_uebergeordnet = 'n. v.' Group BY kat_uebergeordnet");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //Rückgabe eines ResultSets mit allen Attributen der jeweiligen Kategorie
    public ResultSet getKategorie(String category){
        ResultSet cat = null;
        try {
            cat = stmt.executeQuery("SELECT * FROM tbl_kategorie WHERE kat_name = '" + category + "'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cat;
    }

    //Rückgabe eines ResultSets mit allen Produkten, die nach Namen sortiert sind
    public ResultSet getAllProductsSortedByName(){
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_produkt ORDER BY prod_hersteller, prod_bezeichn");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //Gibt die Bezeichnung eines Produktes zurück
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

    //Prüft ob ein Produkt verfügbar ist
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

            rs = stmt.executeQuery("SELECT buch_code FROM tbl_buchungsliste WHERE (buch_abholdatum <= '" + abholung + "' AND buch_rueckgabedatum >= '" + abholung + "') OR (buch_abholdatum <= '" + abgabe + "' AND buch_rueckgabedatum >= '" + abgabe + "') OR (buch_abholdatum >= '" + abholung + "' AND buch_rueckgabedatum <= '" + abgabe + "') AND NOT buch_status = 'abgelehnt'");
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

    //Fügt einen HardwareCode in der Lagerliste hinzu
    public void addHWCode(Integer produktid, String hwcode){
        try {
            stmt.executeUpdate("INSERT INTO tbl_lagerliste (prod_id, prod_code)" +
                    " VALUES ("+ produktid +", '"+ hwcode +"')");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Gibt den HardwareCode zurück
    @Deprecated
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

    //Löscht die jeweilige Kategorie
    public void deleteKategorie(String name){
        try {
            stmt.executeUpdate("DELETE FROM tbl_kategorie WHERE kat_name = '"+ name +"'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Löscht das jeweilige Paket
    public void deletePaket(Integer id){
        try {
            stmt.executeUpdate("DELETE FROM tbl_bild WHERE prod_id = "+ id);
            stmt.executeUpdate("DELETE FROM tbl_paketinhalte WHERE pak_id = "+ id +";");
            stmt.executeUpdate("DELETE FROM tbl_produkt WHERE prod_id = "+ id +";");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Rückgabe eines ResultSets mit allen Paketen
    public ResultSet getAllPakete(){
        ResultSet rs = null;
        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_produkt WHERE prod_hersteller = 'Paket'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    //Rückgabe eines ResultSets mit allen Mitarbeitern
    @Deprecated
    public ResultSet getMitarbeiter(){
        ResultSet rs=null;
        try {
            rs=stmt.executeQuery("SELECT  * from tbl_mitarbeiter WHERE mit_typ='mitarbeiter'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    //Rückgabe eines ResultSets mit allen Admins
    @Deprecated
    public ResultSet getAdmin(){
        ResultSet rs=null;
        try {
            rs=stmt.executeQuery("SELECT  * from tbl_mitarbeiter WHERE mit_typ='admin'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    //Rückgabe eines ResultSets mit allen Admins und Mitarbeitern
    public ResultSet getAllMitarbeiter(){
        ResultSet rs=null;
        try {
            rs=stmt.executeQuery("SELECT  * from tbl_mitarbeiter");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    //Rückgabe eines ResultSets mit den jeweiligen Kundendaten
    public ResultSet getKundenDatenByNr(Integer kundenNR){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_kunde WHERE kun_nummer = " + kundenNR);
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }

    //Rückgabe eines ResultSets mit den jeweiligen Kundendaten
    public ResultSet getKundenDatenByLogin(String login){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_kunde WHERE kun_benutzer = '" + login +"'");
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }

    //Rückgabe eines ResultSets mit den jeweiligen Kundendaten
    public ResultSet getKundenDatenByMail(String mail){
        ResultSet rs=null;
        try{
            rs=stmt.executeQuery("SELECT * FROM tbl_kunde WHERE kun_email = '" + mail +"'");
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }

    //Verändert die Kundendaten
    public void updateKundenDaten(Integer kundenNR, String nname, String vname, String strasse, String ort, String email, String hausn, int plz, int tele, int mobil, String passwort, String login, String orga){
        try{
            stmt.executeUpdate("UPDATE tbl_kunde " +
                    "SET kun_name = '"+nname+"', kun_vorname = '"+vname+"', kun_strasse = '"+strasse+"', kun_ort = '"+ort+"', kun_email = '"+email+"', kun_hausnummer = '"+hausn+"', kun_plz = '"+plz+"', kun_telefon = '"+tele+"', kun_mobil = '"+mobil+"', kun_passwort = '"+ MD5.getMD5(passwort)+"', kun_benutzer = '"+login+"', kun_orga = '"+orga+"' WHERE kun_nummer = '"+kundenNR+"' ");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    //Gibt die Anzahl der Buchungen des jeweiligen Produktes zurück
    @Deprecated
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

    //Gibt die übergeordnete Kategorie einer Kategorie zurück
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

    //Rückgabe eines ResultSets mit der Unterkategorie einer jeweiligen Kategorie
    public ResultSet getUnterkategorieRS(String kategorie){
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT kat_name FROM tbl_kategorie WHERE kat_uebergeordnet = '" + kategorie + "'");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //Gibt eine Liste aller Unterkategorien zurück
     public List<String> getUnterkategorie(String kategorie){
         List<String> unterkategorie = new ArrayList<String>();
         ResultSet rs = null;

            try {
                rs = stmt.executeQuery("SELECT kat_name FROM tbl_kategorie WHERE kat_uebergeordnet = '" + kategorie + "'");
            while(rs.next()){
                unterkategorie.add(rs.getString("kat_name"));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

         return unterkategorie;
     }

    //Gibt die Kundenmail anhand der Buchungs Id zurück
    public String getKundenMail(Integer buchungId){
        ResultSet rs = null;
        ResultSet rs2 = null;
        String mail = null;
        Integer kundenId = null;
        try {
            rs = stmt.executeQuery("SELECT kun_id FROM tbl_buchungsliste WHERE buch_code = "+ buchungId);
            rs.next();
            kundenId = rs.getInt("kun_id");
            rs2 = stmt.executeQuery("SELECT kun_email FROM tbl_kunde WHERE kun_nummer = "+ kundenId);
            rs2.next();
            mail = rs2.getString("kun_email");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return mail;
    }

    //Fügt ein Paket hinzu
    public void addPaket(Integer paketId, String pakettyp, Integer prio, Integer prodId){
        ResultSet rs = null;
        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_paketinhalte WHERE inhalt_id = 1");
            if(rs.isBeforeFirst()) {
                stmt.executeUpdate("INSERT INTO tbl_paketinhalte (pak_id, pak_typ, pak_priorisierung, prod_id, inhalt_id) " +
                        "VALUES (" + paketId + ", '" + pakettyp + "', " + prio + ", " + prodId + ", (SELECT max(inhalt_id) FROM tbl_paketinhalte)+1)");
            } else{
                stmt.executeUpdate("INSERT INTO tbl_paketinhalte (pak_id, pak_typ, pak_priorisierung, prod_id, inhalt_id) " +
                        "VALUES (" + paketId + ", '" + pakettyp + "', " + prio + ", " + prodId + ", "+ 1 +")");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Verändert ein Paket
    public void updatePaket(Integer paketId, String pakettyp, Integer prio, Integer prodId, Integer id){
        try {
                stmt.executeUpdate("UPDATE tbl_paketinhalte SET pak_id = "+ paketId +", pak_typ = '"+ pakettyp +"', pak_priorisierung = "+ prio +", prod_id = "+ prodId +" WHERE inhalt_id = "+ id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Löscht den Inhalt eines Paketes
    public void deletePaketKomponenten(Integer id){
        try {
            stmt.executeUpdate("DELETE FROM tbl_paketinhalte WHERE pak_id = "+ id);
        }catch(Exception e){
            e.printStackTrace();
        }

    }

    //Rückgabe eines ResultSets mit allen Produkten eines Paketes
    public ResultSet getProdukteOfPaket(Integer paketid){
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_paketinhalte WHERE pak_id = "+ paketid);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //Speichert ein Bild zum jeweiligen Produkt
    public void saveBildProdukt(File bild, int prodid) throws SQLException, IOException {

        FileInputStream fis = new FileInputStream(bild);
        PreparedStatement ps = c.prepareStatement("INSERT INTO tbl_bild VALUES (?, ?)");
        ps.setInt(1, prodid);
        ps.setBinaryStream(2, fis, bild.length());
        ps.executeUpdate();
        ps.close();
        fis.close();

    }

    //Liefert das jeweilige Bild eines Produktes zurück
    public byte[] getBildProdukt(Integer prodid, Integer number){

        PreparedStatement ps = null;
        byte[] imgBytes = null;
        try {
            ps = c.prepareStatement("SELECT bilder FROM tbl_bild WHERE prod_id=?");
            ps.setInt(1, prodid);
            ResultSet rs = ps.executeQuery();

            if (rs.isBeforeFirst()) {
                for (int i = 0; i < number; i++) {
                    rs.next();
                }
                imgBytes = rs.getBytes(1);
                // use the stream in some way here
                rs.close();
            }
//            img = ImageIO.read(new ByteArrayInputStream(imgBytes));
                ps.close();
            }catch(SQLException e){
                e.printStackTrace();
            }

        return imgBytes;
    }

    //Liefert das jeweilige Bild einer Kategorie zurück
    @Deprecated
    public byte[] getBildKategorie(String kategorie) {
        PreparedStatement ps = null;
        byte[] imgBytes = null;
        try {
            ps = c.prepareStatement("SELECT kat_bild FROM tbl_kategorie WHERE kat_name=?");
            ps.setString(1, kategorie);
            ResultSet rs = ps.executeQuery();

            if (rs.isBeforeFirst()) {
                rs.next();
                imgBytes = rs.getBytes(1);
                // use the stream in some way here
                rs.close();
            }
//            img = ImageIO.read(new ByteArrayInputStream(imgBytes));
            ps.close();
        }catch(SQLException e){
            e.printStackTrace();
        }

        return imgBytes;
    }

    //Trennt die Verbindung zur Datenbank
    public void disconnectDatabase(){
        try {
            stmt.close();
            c.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Liefert alle gebuchten Produkte zurück
    public List<String> getGebuchteProdukte(int buchung){
        Statement stmt2 = null;
        try {
            stmt2 = c.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        List<String> produkte =new ArrayList<String>();
        Integer id = null;
        String produktcode = null;
        ResultSet rs=null;
        ResultSet rsa=null;
        ResultSet rsb=null;
        try {
            rs=stmt2.executeQuery("SELECT  * FROM tbl_buchung_produkt WHERE bestell_id=" + buchung);
            while(rs.next()) {
                produktcode = rs.getString("produkt_code");
                rsa = stmt.executeQuery("SELECT prod_id FROM tbl_lagerliste WHERE prod_code = '"+ produktcode +"'");
                rsa.next();
                id = rsa.getInt("prod_id");
                rsb = stmt.executeQuery("SELECT * FROM tbl_produkt WHERE prod_id = "+ id);
                rsb.next();
                produkte.add(rsb.getString("prod_bezeichn"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            stmt2.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return produkte;
    }

    //Liefert alle Preis der gebuchten Produkte zurück
    public List<Double> getGebuchteProduktePreis(int buchung){
        Statement stmt2 = null;
        try {
            stmt2 = c.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        List<Double> preise =new ArrayList<Double>();
        Integer id = null;
        ResultSet rs=null;
        ResultSet rsa=null;
        ResultSet rsb=null;
        try {
            rs=stmt2.executeQuery("SELECT  * FROM tbl_buchung_produkt WHERE bestell_id="+buchung);
            while(rs.next()) {
                rsa=stmt.executeQuery("SELECT prod_id FROM tbl_lagerliste WHERE prod_code='"+rs.getString("produkt_code")+"'");
                rsa.next();
                id=rsa.getInt("prod_id");
                rsb=stmt.executeQuery("SELECT * FROM tbl_produkt WHERE prod_id = "+ id);
                rsb.next();
                preise.add(rsb.getDouble("prod_preis"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            stmt2.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return preise;
    }

    //Gibt die Anzahl der Buchungen über die Kundenmail zurück
    public int getBuchungsZahlByMail(String mail){
        int anzahl=0;
        ResultSet rs=null;
        try {
            ResultSet rs2 = c.createStatement().executeQuery("SELECT kun_nummer FROM tbl_kunde WHERE kun_email='"+ mail +"'");
            while(rs2.next()){
                rs=stmt.executeQuery("SELECT COUNT(kun_id) AS anzahl FROM tbl_buchungsliste WHERE kun_id = "+ rs2.getInt("kun_nummer"));
                rs.next();
                int anzahlTemp=rs.getInt("anzahl");
                if(anzahlTemp > anzahl){
                    anzahl = anzahlTemp;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return anzahl;
    }

    //Gibt die Anzahl der Buchungen über den Benutzernamen des Kunden zurück
    public int getBuchungsZahlByLogin(String login){
        int anzahl=0;
        ResultSet rs=null;
        try {
            rs=stmt.executeQuery("SELECT COUNT(kun_id) AS anzahl FROM tbl_buchungsliste WHERE kun_id=(SELECT kun_nummer FROM tbl_kunde WHERE kun_benutzer='"+login+"')");
            rs.next();
            anzahl=rs.getInt("anzahl");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return anzahl;
    }

    //Rückgabe eines ResultSets mit allen Physikalisch vorhandenen Produkten aus der Lagerliste
    public ResultSet getAllProductsInLagerliste(){
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT * FROM tbl_lagerliste");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //prüft ob ein Produkt in der Kategorie bzw. in der untersten Kategorie vorhanden ist
    public Boolean besitztProdukt(String katName){
        Boolean vorhanden = false;
        String unterKat = null;
        ResultSet rs = null;
        ResultSet rs2 = null;

        try {
            Statement stmt2 = c.createStatement();
            rs = stmt.executeQuery("SELECT prod_id FROM tbl_produkt WHERE prod_kategorie ='"+ katName +"'");
            rs2 = stmt2.executeQuery("SELECT kat_name FROM tbl_kategorie WHERE kat_uebergeordnet ='" + katName + "'");
            if(rs.next()){
                vorhanden = true;
            } else if(rs2.isBeforeFirst()){
                while(rs2.next()){
                    unterKat = rs2.getString("kat_name");
                    if(vorhanden==false) {
                       vorhanden=besitztProdukt(unterKat);
                    }
                }
            } else{
                vorhanden = false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vorhanden;
    }

    //gibt an, wie oft das Produkt im Paket vorhanden ist
    public Integer anzahlProduktImPaket(Integer prodid){
        Integer anzahl = null;
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT count(prod_id) AS anzahl FROM tbl_paketinhalte WHERE prod_id = "+ prodid);
            rs.next();
            anzahl = rs.getInt("anzahl");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return anzahl;
    }

    //gibt den jeweiligen Paketinhalt zurück wobei jedes Produkt nur einmal aufgelistet wird
    public ResultSet getSinglieProductOfPaket(Integer paketid){
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery("SELECT pak_id, prod_id FROM tbl_paketinhalte WHERE pak_id = "+ paketid +" GROUP BY pak_id, prod_id");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

}
