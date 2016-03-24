funcs=[]
funcs.push {label:"sin",values:[],function:(x)->Math.sin(x)}
funcs.push {label:"linear",values:[],function:(x)->x} # find correct string expressions for superscript, if possible!
funcs.push {label:"cubic",values:[],function:(x)->x-1.0/6.0*x*x*x}
funcs.push {label:"quintic",values:[],function:(x)->x-1.0/6.0*x*x*x+1.0/120.0*Math.pow(x,5)}
funcs.push {label:"septic",values:[],function:(x)->x-1.0/6.0*x*x*x+1.0/120.0*Math.pow(x,5)-1.0/5040.0*Math.pow(x,7)}
funcs.push {label:"nonic",values:[],function:(x)->x-1.0/6.0*x*x*x+1.0/120.0*Math.pow(x,5)-1.0/5040.0*Math.pow(x,7)+1.0/362880.0*Math.pow(x,9)}
data=[]
options=
  xaxis:
    min:0
    max:2*Math.PI
  yaxis:
    min:-3
    max:3  
for f in funcs
  t=0
  while t<=2*Math.PI
    f.values.push [t,f.function(t)]
    t+=0.01
  data.push {label: f.label, data: f.values}
$.plot $("#graphcontainer"),data,options
