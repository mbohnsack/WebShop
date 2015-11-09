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
import java.util.List;

/**
 * Created by Chris on 02.11.2015.
 */
@WebServlet("/updateKategorieServlet")
public class updateKategorieServlet extends HttpServlet {
    private final String UPLOAD_DIRECTORY = "upload";
    private final int THRESHOLD_SIZE     = 1024 * 1024 * 10; // 10MB
    private final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
    //Daten einer Kategorie überarbeiten/updaten
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        String kategorieName = null;
        String ueberKategorie = null;
        File storeFile=null;
        Boolean bild=false;

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
            List<FileItem> formItems = null;
            try {
                formItems = upload.parseRequest(request);
            } catch (FileUploadException e) {
                e.printStackTrace();
            }


            for (FileItem item: formItems) {
                // processes only fields that are not form fields
                if (!item.isFormField()) {

                    String fileName = new File(item.getName()).getName();
                    String filePath = uploadPath + File.separator + fileName;
                    storeFile = new File(filePath);
                    // saves the file on disk
                    if(item.getSize()!=0) {
                        try {
                            item.write(storeFile);
                            bild = true;
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }else{
                    String name=item.getFieldName();
                    if(name!=null) {
                        switch (name) {
                            case "produktid":
                                kategorieName = item.getString();
                                break;
                            case "ueberKategorie":
                                ueberKategorie = item.getString();
                                break;

                        }
                    }
                }

            }
            try {
                if(bild) {

                    db.updateKategorie(kategorieName, ueberKategorie, storeFile);
                }else{
                    db.updateKategorie(kategorieName, ueberKategorie);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
        db.disconnectDatabase();
        String url = "/MitarbeiterView/kategorieVerwalten.jsp";
        response.sendRedirect(url);

    }
}
