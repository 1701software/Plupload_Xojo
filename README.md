# Plupload_Xojo
# Plupload HTML web upload dialog control for Xojo Web.
# Version 1.170702.0
# By: 1701 Software

Special thanks to Alexander Marthin @ Lumafilm.dk for sponsoring this project and generously donating it to the Xojo community.

Plupload is a widely used HTML/javascript web upload control facilitating the upload of large files via the web browser. The Xojo Web upload control is not well equipped for large files or when being used in a CGI environment.

Our objective here was to implement a web dialog control that presents a fully featured upload control powered by Plupload. Plupload can upload to any web server but by default provides a PHP script to facilitate file uploads. This repository contains a "www" folder which are the scripts and assets that need to be uploaded to your web server in order to facilitate the uploads. The "www/uploads" folder is where files are saved upon upload (configurable - see below).

To use in your Xojo Web project you want to copy the "Plupload" dialog control to your project. See the "btnShowUploader.Action" event in the example project for details on how to instantiate, configure, and show the control. 

Configuration properties:

URL (String) = URL to the "upload.php" file on your server that receives the file uploads.

Allow_Images (Boolean) = Determines if images can be uploaded

Allow_PDF (Boolean) = Determines if PDF's can be uploaded.

Allow_Zip (Boolean) = Determines if zip files can be uploaded.

Allow_Anything (Boolean) = Determines if any file type can be uploaded.

Enable_DragDrop (Boolean) = Determines if the end user can drag and drop a file to be uploaded.

Enable_Rename (Boolean) = Determines if a user can rename a file after being uploaded.

Enable_Sort (Boolean) = Determines if a user can re-sort the items in the upload list.

UploadComplete_CloseDialog (Boolean) = Determines if the upload dialog control should automatically close upon file upload.

UploadComplete_MessageText (String) = Message sent to a user after successful file upload.

UploadComplete_ShowMessage (Boolean) = Determines if we alert a user with the MessageText after successful file upload.
