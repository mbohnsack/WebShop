package project;

/**
 * Created by Chris on 03.11.2015.
 */
public class loginCookie {
    private String username;
    private String rolle;
    private String targetpage;
    private String sourcepage;

    public loginCookie(String username,  String sourcepage, String targetpage ){
        this.username= username;
        this.targetpage = targetpage;
        this.sourcepage = sourcepage;


        if(sourcepage.equals("../MitarbeiterView/login.jsp")) {
            DatabaseHelper db = new DatabaseHelper();
            System.out.println(db.getMitarbeiterRolle(username));
            this.rolle = db.getMitarbeiterRolle(username);
            db.disconnectDatabase();
        }else {
            this.rolle = "Kunde";
        }
    }

    public String getRolle() {
        return rolle;
    }

    public String getTargetpage() {
        return targetpage;
    }

    public String getSourcepage() {
        return sourcepage;
    }

    public String getUsername() {
        return username;
    }
}
