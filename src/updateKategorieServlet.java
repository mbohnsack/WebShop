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
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        String kategorieName = null;
        String ueberKategorie = null;
        File storeFile=null;

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
                    try {
                        item.write(storeFile);

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }else{
                    String name=item.getFieldName();
                    if(name!=null) {
                        switch (name) {
                            case "kategorieName":
                                kategorieName = item.getString();
                                break;
                            case "ueberKategorie":
                                ueberKategorie = item.getString();
                                break;
                        }
                    }
                }

            }
            db.updateKategorie(kategorieName, ueberKategorie, storeFile);

        }
        String url = "/MitarbeiterView/kategorieVerwalten.jsp";
        response.sendRedirect( url );
        db.disconnectDatabase();
    }
}
