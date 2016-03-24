approxgraph= ->
  funcs=[]
  funcs.push {label:"f(t)=t^2",values:[],function:(x)->x*x} # find correct string expressions for superscript, if possible!
  funcs.push {label:"f(t)=t^3",values:[],function:(x)->x*x*x}
  funcs.push {label:"f(t)=t^10",values:[],function:(x)->Math.pow(x,10)}
  funcs.push {label:"f(t)=cos(t)-1",values:[],function:(x)->Math.cos(x) - 1}
  data=[]
  options=
    xaxis:
      min:0
      max:2
    yaxis:
      min:-1
      max:20  
  for f in funcs
    t=0
    while t<=2
      f.values.push [t,f.function(t)]
      t+=0.01
    data.push {label: f.label, data: f.values}
  $.plot $("#graphcontainer"),data,options
  null
approxgraph()