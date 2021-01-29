$("#file").change(function(e){
    var fd = new FormData();
    var files = $('#file')[0].files;
    if(files.length>0){
        fd.append('file',files[0]);
        $.ajax({
            url: 'upload.php',
            type: 'post',
            data: fd,
            contentType: false,
            processData: false,
            success: function(response){
               if(response != 0){
                  $("#img").attr("src",response); 
                  $(".preview img").show(); // Display image element
               }else{
                  alert('file not uploaded');
               }
            },
         });
    }
    

    
    
})
$("#verifyForm").submit(function(e){
    e.preventDefault();
    var fd = new FormData();
    var files = $('#file')[0].files;
    var pid = $("#uid").val();
    if(files.length>0){
        fd.append('clicked_photo',files[0]);
        fd.append('patient_id',pid);
        // console.log(fd);
        $.ajax({
            url: 'http://20.198.3.123/api/core/check/',
            type: 'post',
            data: fd,
            contentType: false,
            processData: false,
            headers: {"Authorization": localStorage.getItem('token')},
            success: function(response){
                
                console.log(response.message);
                if(response.message==true){
                    alert("User has been verified");
                    var base = "http://20.198.3.123/api/core/vaccinated/";
                    var url = base+pid;
                    
                    $.ajax({
                        url: url,
                        type: 'get',
                        datatype: 'json',
                        crossDomain: true,
                        
                        headers: {"Authorization": localStorage.getItem('token')},
                        success: function(res){
                            window.location.href = "./Dashboard.php";
                        }
                
                    });
                }
                
            }

        });
        
    }

    
});

