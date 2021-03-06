// Generated by CoffeeScript 1.4.0
(function() {
  var data, f, funcs, options, t, _i, _len;

  funcs = [];

  funcs.push({
    label: "sin",
    values: [],
    "function": function(x) {
      return Math.sin(x);
    }
  });

  funcs.push({
    label: "linear",
    values: [],
    "function": function(x) {
      return x;
    }
  });

  funcs.push({
    label: "cubic",
    values: [],
    "function": function(x) {
      return x - 1.0 / 6.0 * x * x * x;
    }
  });

  funcs.push({
    label: "quintic",
    values: [],
    "function": function(x) {
      return x - 1.0 / 6.0 * x * x * x + 1.0 / 120.0 * Math.pow(x, 5);
    }
  });

  funcs.push({
    label: "septic",
    values: [],
    "function": function(x) {
      return x - 1.0 / 6.0 * x * x * x + 1.0 / 120.0 * Math.pow(x, 5) - 1.0 / 5040.0 * Math.pow(x, 7);
    }
  });

  funcs.push({
    label: "nonic",
    values: [],
    "function": function(x) {
      return x - 1.0 / 6.0 * x * x * x + 1.0 / 120.0 * Math.pow(x, 5) - 1.0 / 5040.0 * Math.pow(x, 7) + 1.0 / 362880.0 * Math.pow(x, 9);
    }
  });

  data = [];

  options = {
    xaxis: {
      min: 0,
      max: 2 * Math.PI
    },
    yaxis: {
      min: -3,
      max: 3
    }
  };

  for (_i = 0, _len = funcs.length; _i < _len; _i++) {
    f = funcs[_i];
    t = 0;
    while (t <= 2 * Math.PI) {
      f.values.push([t, f["function"](t)]);
      t += 0.01;
    }
    data.push({
      label: f.label,
      data: f.values
    });
  }

  $.plot($("#graphcontainer"), data, options);

}).call(this);
