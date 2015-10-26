
$(document).ready(function(){

    $(function() {
        $("#header").load("header.html");
        $("#footer").load("footer.html");
        $("#navigation_top").load("navigation_top.html");
        $("#navigation_left").load("navigation_left.html");
        $("#navigation_right").load("navigation_right.html");
        $("#content").load("content.html");
    });



})

function myFunction() {
    if (document.getElementById("demo").style.color != "red"){
    document.getElementById("demo").style.color = "red";}
    else {
    document.getElementById("demo").style.color = "green";
};
}

