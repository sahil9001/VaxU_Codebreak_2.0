
$(document).ready(function(){
    const token = window.localStorage.getItem("token");
    console.log(token);
    $.ajax({
        url: "http://20.198.3.123/api/core/list/",
        type: 'get',
        datatype: 'json',
        crossDomain: true,
        
        headers: {"Authorization": localStorage.getItem('token')},
        success: function(res){
            console.log(res);
            var users = document.getElementById("newUsers");
            users.innerText = res.length;
        }

    })
    $.ajax({
        url: "http://20.198.3.123/api/users/vaccinators/",
        type: 'get',
        datatype: 'json',
        crossDomain: true,
        
        headers: {"Authorization": localStorage.getItem('token')},
        success: function(res){
            console.log(res[0]);
            const vc = res[0]['vaccines_available'];
            var vic = document.getElementById("vis");
            vic.innerText = vc;
            // var users = document.getElementById("newUsers");
            // users.innerText = res.length;
        }

    })
    
});
function logout(){
    window.localStorage.removeItem("token");
    window.location.href("./login.php");
}
