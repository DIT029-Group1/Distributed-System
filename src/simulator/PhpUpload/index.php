

<?php
if(isset($_POST['btn-upload']))
{
     $pic = rand(1000,100000)."-".$_FILES['pic']['name'];
     $pic_loc = $_FILES['file']['tmp_name'];
     $folder="uploads/";
     if(move_uploaded_file($pic_loc,$folder.$pic))
     {
        ?><script>alert('Upload Successful!');</script><?php
     }
     else
     {
        ?><script>alert('Error uploading!');</script><?php
     }
}

?>

<!DOCTYPE html>
    <html xmlns="">
        <head>
            <title>PHP File Upload</title>
        </head>
        <body>
            <form action="" method="post" enctype="multipart/form-data">
                <input type="file" name="pic" />
                <button type="submit" name="btn-upload">Upload</button>
            </form>
        </body>
</html>