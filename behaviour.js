<js>
window.onload = function () {
  var els = []; //document.getElementsByClassNames('element');
  for (var el in els) {
    el.onclick = function () {
      alert(el.getAttribute('class'));
    };
  }
};
</js>
