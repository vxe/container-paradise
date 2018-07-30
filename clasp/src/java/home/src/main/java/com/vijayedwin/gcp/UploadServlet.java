package com.vijayedwin;

/*
@SuppressWarnings("serial")
@WebServlet(name = "upload", value = "/upload")
@MultipartConfig()
public class UploadServlet extends HttpServlet {

  private static final String BUCKET_NAME = System.getenv("BUCKET_NAME");
  private static Storage storage = null;

  @Override
  public void init() {
    storage = StorageOptions.getDefaultInstance().getService();
  }

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws IOException, ServletException {
    final Part filePart = req.getPart("file");
    final String fileName = filePart.getSubmittedFileName();

    // Modify access list to allow all users with link to read file
    List<Acl> acls = new ArrayList<>();
    acls.add(Acl.of(Acl.User.ofAllUsers(), Acl.Role.READER));
    // the inputstream is closed by default, so we don't need to close it here
    Blob blob =
        storage.create(
            BlobInfo.newBuilder(BUCKET_NAME, fileName).setAcl(acls).build(),
            filePart.getInputStream());

    // return the public download link
    resp.getWriter().print(blob.getMediaLink());
  }
}
*/
