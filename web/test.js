var response;
function animateValue(id, start, end, duration) {
    if (start === end) return;
    var range = end - start;
    var current = start;
    var increment = end > start? 1 : -1;
    var stepTime = Math.abs(Math.floor(duration / range));
    var obj = document.getElementById(id);
    var timer = setInterval(function() {
        current += increment;
        obj.innerHTML = current;
        if (current == end) {
            clearInterval(timer);
        }
    }, stepTime);
}
function spec(cases,rec,deaths){
    document.getElementById("cases").innerHTML=cases;
    document.getElementById("recovered").innerHTML=rec;
    document.getElementById("deaths").innerHTML=deaths;
}


$( document ).ready(function() {

    $.ajax({
        url: 'https://api.rootnet.in/covid19-in/stats/latest.json',
        type: 'get',
        datatype: 'json',
        
        success: function(res){
            
            response=res;
            console.log(res);
            localStorage.setItem("data",JSON.stringify(res.data));
            
            const cases= res.data.summary.confirmedCasesIndian;
            const deaths= res.data.summary.deaths;
            const rec= res.data.summary.discharged;
            spec(cases,rec,deaths);

            

             
        }
    });
    if(window.localStorage.getItem("token")!=null)  window.location.href = "./Dashboard.php";
    // $.ajax({
    //     url: 'http://20.198.3.123/api/users/vacc/register/',
    //     type: 'post',
    //     datatype: 'json',
    //     cors: true ,
    //     data:{
            
    //         username: "sanjeebnath382@gmail.com",
    //         email: "sanjeebnath382@gmail.com",
    //         phone: "700448069",
    //         password: "Abcd1234$",
    //         centre_name: "NIT Raipur",
    //         is_available: true,
    //         vaccines_available: 120,
    //         price: "130",
    //         org_description: "College vaccination",
    //         city: "Raipur",
    //         country: "India"
            

            


    //     },
        
        
    //     success: function(res){
            
    //         response=res;
    //         console.log(res);
            

            

             
    //     }
    // });
});


function myfun(){
    var selected= $("#states").val();
    if(selected>-1){
        const cases= response.data.regional[selected].confirmedCasesIndian;
        const deaths= response.data.regional[selected].deaths;
        const rec= response.data.regional[selected].discharged;
        
        spec(cases,rec,deaths);



    }
    else{
        const cases= response.data.summary.confirmedCasesIndian;
        const deaths= response.data.summary.deaths;
        const rec= response.data.summary.discharged;
        spec(cases,rec,deaths);
    }
   
    
}