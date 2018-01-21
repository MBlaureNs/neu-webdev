var btn_lorem = document.getElementById("btn-lorem");
var btn_bottle = document.getElementById("btn-bottle");
var btn_last = document.getElementById("btn-last");
var div_right = document.getElementById("div-right");

var set_div_right = function(text) {
    div_right.innerHTML = text;
}

var btn_lorem_fn = function() {
    var lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<br/><br/>";
    var t = lorem.repeat(4);
    t += "<a href=\"https://en.wikipedia.org/wiki/Lorem_ipsum\">wikipedia source</a>"
    set_div_right(t);
}

var btn_bottle_fn = function() {
    var t = "99 bottles of beer on the wall, 99 bottles of beer.<br/>\
    Take one down, pass it around, 98 bottles of beer on the wall...<br/><br/>\
    98 bottles of beer on the wall, 98 bottles of beer.<br/>\
    Take one down, pass it around, 97 bottles of beer on the wall...<br/><br/>\
    97 bottles of beer on the wall, 97 bottles of beer.<br/>\
    Take one down, pass it around, 96 bottles of beer on the wall...<br/><br/>\
    96 bottles of beer on the wall, 96 bottles of beer.<br/>\
    Take one down, pass it around, 95 bottles of beer on the wall...<br/><br/>"
    t += "<a href=\"https://en.wikipedia.org/wiki/99_Bottles_of_Beer\">wikipedia source</a>"
    set_div_right(t);
}

var btn_last_fn = function() {
    var t = "this is the third thing";
    set_div_right(t);
}

btn_lorem_fn();
btn_lorem.addEventListener("click", btn_lorem_fn);
btn_bottle.addEventListener("click", btn_bottle_fn);
btn_last.addEventListener("click", btn_last_fn);

