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


        if(sourcepage == "../MitarbeiterView/login.jsp"){
            DatabaseHelper db = new DatabaseHelper();
            if(db.getMitarbeiterRolle(username).equals("mitarbeiter") || db.getMitarbeiterRolle(username).equals("admin")) {
                this.rolle = db.getMitarbeiterRolle(username);
            }
            db.disconnectDatabase();
        }else{
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
