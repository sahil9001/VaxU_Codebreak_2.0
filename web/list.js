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
            var content = ""
            res.forEach(pat => {
                content+= '<tr>';
                content+= '<td>'+pat.patient+'</td>';
                content+= '<td>'+pat.patient_id+'</td>';
                content+= '<td>'+pat.timeslot+'</td>';
                content+= '</tr>';
                $("#table_body").append(content);
                content="";
            });
        }

    });
}
);
