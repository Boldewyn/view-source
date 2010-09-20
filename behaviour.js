<js>
var els = document.getElementsByClassName('element');
for (var el in els) {
  els[el].onclick = (function (a) { return function () {
    //alert(a);
  }; })(els[el].getAttribute('class'));
}
</js>
