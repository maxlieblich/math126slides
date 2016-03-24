// Generated by CoffeeScript 1.6.3
(function() {
  var approxgraph;

  approxgraph = function() {
    var data, f, funcs, options, t, _i, _len;
    funcs = [];
    funcs.push({
      label: "f(t)=t^2",
      values: [],
      "function": function(x) {
        return x * x;
      }
    });
    funcs.push({
      label: "f(t)=t^3",
      values: [],
      "function": function(x) {
        return x * x * x;
      }
    });
    funcs.push({
      label: "f(t)=t^10",
      values: [],
      "function": function(x) {
        return Math.pow(x, 10);
      }
    });
    funcs.push({
      label: "f(t)=cos(t)-1",
      values: [],
      "function": function(x) {
        return Math.cos(x) - 1;
      }
    });
    data = [];
    options = {
      xaxis: {
        min: 0,
        max: 2
      },
      yaxis: {
        min: -1,
        max: 20
      }
    };
    for (_i = 0, _len = funcs.length; _i < _len; _i++) {
      f = funcs[_i];
      t = 0;
      while (t <= 2) {
        f.values.push([t, f["function"](t)]);
        t += 0.01;
      }
      data.push({
        label: f.label,
        data: f.values
      });
    }
    $.plot($("#graphcontainer"), data, options);
    return null;
  };

  approxgraph();

}).call(this);
