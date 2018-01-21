var count = 10;

var h2_value = document.getElementById("h2-value");
var btn_alert = document.getElementById("btn-alert");
var btn_increment = document.getElementById("btn-increment");
var btn_append = document.getElementById("btn-append");
var div_append = document.getElementById("div-append");

var update_h2 = function() {
    h2_value.innerHTML = count;
}

var btn_alert_fn = function() {
    alert(count);
}

var btn_increment_fn = function() {
    count += 1;
    update_h2();
}

var btn_append_fn = function() {
    var new_p = document.createElement("p");
    new_p.innerHTML = count;
    div_append.appendChild(new_p);	
}


update_h2();
btn_alert.addEventListener("click", btn_alert_fn);
btn_increment.addEventListener("click", btn_increment_fn);
btn_append.addEventListener("click", btn_append_fn);

