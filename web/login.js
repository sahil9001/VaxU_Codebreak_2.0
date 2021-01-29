$("#loginForm").submit(function(e){
    e.preventDefault();
    console.log("aaya");
    const email = $("#email").val();
    const pass = $("#pass").val();
    console.log(email,pass);
    $.ajax({
        url: 'http://20.198.3.123/api/users/vacc/login/',
        type: 'post',
        datatype: 'json',
        cors: true ,
        data:{
            
            
            email: email,
            password: pass
            

            


        },
        
        
        success: function(res){
            
            
            console.log(res.token);
            if(res.token)   console.log("success token reciveed");
            window.localStorage.setItem("token",res.token);
            if(res.token){
                window.location.href = "./Dashboard.php";
            }
            

            

             
        },
        error : function(jqXHR, exception){
            var msg = '';
            if (jqXHR.status === 0) {
                msg = 'Not connect.\n Verify Network.';
            } else if (jqXHR.status == 404) {
                msg = 'Either the username or password or both are incorrect';
            } else if (jqXHR.status == 500) {
                msg = 'Internal Server Error [500].';
            } else if (exception === 'parsererror') {
                msg = 'Requested JSON parse failed.';
            } else if (exception === 'timeout') {
                msg = 'The connection timed out';
            } else if (exception === 'abort') {
                msg = 'Ajax request aborted.';
            } else {
                msg = 'Uncaught Error.\n' + jqXHR.responseText;
            }
            // console.log("aaya error");
            alert(msg);
        }
    });
});