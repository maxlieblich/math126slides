(function() {

  window.onresize = function() {
    var db, s, sx, sy, transform;
    db = document.body;
    sx = 800 / window.innerWidth;
    sy = 600 / window.innerHeight;
    s = 1 / Math.max(sx.sy);
    if (sx < 1 && sy < 1) {
      db.style.marginTop = (window.innerHeight - 600) / 2..toString() + "px";
    } else {
      transform = "scale(" + s + ")";
      db.style.MosTransform = transform;
      db.style.WebkitTransform = transform;
      db.style.OTransform = transform;
      db.style.msTransform = transform;
      db.style.transform = transform;
    }
  };

  window.onresize();

}).call(this);
