import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Chris on 29.10.2015.
 */
@WebServlet("/addProduktServlet")
public class addProduktServlet extends HttpServlet {
    private final String UPLOAD_DIRECTORY = "upload";
    private final int THRESHOLD_SIZE     = 1024 * 1024 * 10; // 10MB
    private final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        File storeFile=null;
        String produktname = null;
        String produktname2 = null;
        String produktbeschreibung = null;
        String details = null;
        String kategorie = null;
        String hersteller = null;
        double preis=0.0;

        DatabaseHelper db = new DatabaseHelper();
        if (ServletFileUpload.isMultipartContent(request)) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(THRESHOLD_SIZE);
            factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setFileSizeMax(MAX_FILE_SIZE);
            upload.setSizeMax(MAX_REQUEST_SIZE);
            String uploadPath = getServletContext().getRealPath("")
                    + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            List formItems = null;
            try {
                formItems = upload.parseRequest(request);
            } catch (FileUploadException e) {
                e.printStackTrace();
            }
            Iterator iter = formItems.iterator();

            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();
                // processes only fields that are not form fields
                if (!item.isFormField()) {
                    String fileName = new File(item.getName()).getName();
                    String filePath = uploadPath + File.separator + fileName;
                    storeFile = new File(filePath);

                    // saves the file on disk
                    try {
                        item.write(storeFile);

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }else{
                    String name=item.getName();
                    switch(name){
                        case "produktname":
                            produktname=item.getString();
                            break;
                        case "produktname2":
                            produktname2=item.getString();
                            break;
                        case "produktbeschreibung":
                            produktbeschreibung=item.getString();
                            break;
                        case "details":
                            details=item.getString();
                            break;
                        case "kategorie":
                            kategorie=item.getString();
                            break;
                        case "hersteller":
                            hersteller=item.getString();
                            break;
                        case "preis":
                            preis=Double.parseDouble(item.getString());
                            break;
                    }
                }

            }
            try {
                int prodid=db.addProduct(kategorie, hersteller, preis, produktbeschreibung, details, produktname, produktname2);
                db.saveFile(storeFile,prodid);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        String url = "/MitarbeiterView/produktVerwalten.jsp";
        response.sendRedirect( url );
        db.disconnectDatabase();
    }
}
