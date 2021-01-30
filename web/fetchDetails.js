$(document).ready(function(){
    $.ajax({
        url: "http://20.198.3.123/api/core/",
        type: 'get',
        datatype: 'json',
        crossDomain: true,
        
        headers: {"Authorization": localStorage.getItem('token')},
        success: function(res){
            console.log(res);
            var content = ""
            content+= "<tr>";
            content+= "<td>"+ res["centre_name"] + "</td>";
            content+= "<td>"+ res["phone"] + "</td>";
            content+= "<td>"+ res["org_description"] + "</td>";
            content+= "<td>"+ res["vaccines_available"] + "</td>";
            content+= "<td>"+ res["price"] + "</td>";
            content+= "</tr>";
            $("#table_body").append(content);
            content="";

            

            
        }

    })
});