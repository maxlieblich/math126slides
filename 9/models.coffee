plotstickers1= ->
  spiral= ->
    @power=1
    @multiple=2
    @render= (p,m)->
      d1=[]
      t=0#-@multiple*Math.PI
      while t<=m*Math.PI
        d1.push [Math.pow(t,p)*Math.cos(t),Math.pow(t,p)*Math.sin(t)]
        t+=0.01
      data=[ d1 ]
      nut=Math.max(Math.pow(@multiple*Math.PI,@power),1/Math.pow(@multiple*Math.PI,@power))
      options = 
         series:
           lines:
             show: true
             shadowSize: 0
         xaxis:
           max: nut
           min: -nut
         yaxis:
           max: nut
           min: -nut           
      $.plot $("#plotstickers1"),data,options
      null 
#    render(@power,@multiple)
    null
  snail=new spiral()  
  gui=new dat.GUI(
    autoPlace: false
  )
  $("#plotstickers1controls").append gui.domElement   
  powercontrol=gui.add snail,"power",-2,3
  multiplecontrol=gui.add snail,"multiple",1,10
  snail.render snail.power,snail.multiple
  powercontrol.onChange (value) -> 
    snail.render value,snail.multiple
    null
  multiplecontrol.onChange (value) -> 
    snail.render snail.power,value
    null
  null
plotstickers1()    

plotstickers2= ->
  yummy= ->
    @love=8/5
    @multiple=10
    @render= (p,m)->
      d1=[]
      t=0#-@multiple*Math.PI
      while t<=m*Math.PI
        d1.push [Math.sin(p*t)*Math.cos(t),Math.sin(p*t)*Math.sin(t)]
        t+=0.01
      data=[ d1 ]
      options = 
         series:
           lines:
             show: true
             shadowSize: 0
         xaxis:
           max: 1
           min: -1
         yaxis:
           max: 1
           min: -1           
      $.plot $("#plotstickers2"),data,options
      null 
#    render(@power,@multiple)
    null
  bowl=new yummy()  
  gui=new dat.GUI(
    autoPlace: false
  )
  $("#plotstickers2controls").append gui.domElement   
  powercontrol=gui.add(bowl,"love",0,5).step(0.1)
  multiplecontrol=gui.add bowl,"multiple",10,50
  bowl.render bowl.love,bowl.multiple
  powercontrol.onChange (value) -> 
    bowl.render value,bowl.multiple
    null
  multiplecontrol.onChange (value) -> 
    bowl.render bowl.love,value
    null
  null
plotstickers2()

plotstickers3= ->
  jiggly= ->
    @c=1
    @love=1
    @multiple=2
    @render= (c,p,m)->
      d1=[]
      t=0#-@multiple*Math.PI
      while t<=m*Math.PI
        d1.push [(c+Math.sin(p*t))*Math.cos(t),(c+Math.sin(p*t))*Math.sin(t)]
        t+=0.01
      data=[ d1 ]
      options = 
         series:
           lines:
             show: true
             shadowSize: 0
         xaxis:
           max: 6
           min: -6
         yaxis:
           max: 6
           min: -6           
      $.plot $("#plotstickers3"),data,options
      null 
#    render(@power,@multiple)
    null
  bowl=new jiggly()  
  gui=new dat.GUI(
    autoPlace: false
  )
  $("#plotstickers3controls").append gui.domElement   
  powercontrol=gui.add(bowl,"love",0,5).step(0.1)
  multiplecontrol=gui.add bowl,"multiple",1,50
  ccontrol=gui.add bowl,"c",0,5
  bowl.render bowl.c,bowl.love,bowl.multiple
  powercontrol.onChange (value) -> 
    bowl.render bowl.c,value,bowl.multiple
    null
  multiplecontrol.onChange (value) -> 
    bowl.render bowl.c,bowl.love,value
    null
  ccontrol.onChange (value) -> 
    bowl.render value,bowl.love,bowl.multiple
    null
  null
plotstickers3()

firstdemo= ->
  demo= ->
    @r=1
    @theta=0
    @render= (rad,theta)->
      d1=[]
      p1=[[rad*Math.cos(theta),rad*Math.sin(theta)]]
      t=0
      while t<=2*Math.PI
        d1.push [rad*Math.cos(t),rad*Math.sin(t)]
        t+=0.01
      data=[ d1, {data: p1, color: "purple", hoverable: true, points: {show: true}} ]
      options = 
         series:
           lines:
             show: true
             shadowSize: 0
         grid:
           hoverable: true    
         xaxis:
           max: 6
           min: -6
         yaxis:
           max: 3.75
           min: -3.75           
      $.plot $("#democontainer"),data,options
      null 
#    render(@power,@multiple)
    null
  graph=new demo()  
  gui=new dat.GUI(
    autoPlace: false
  )
  $("#democontrols").append gui.domElement   
  rcontrol=gui.add graph,"r",0,3.5
  thetacontrol=gui.add graph,"theta",0,2*Math.PI
  graph.render graph.r,graph.theta
  rcontrol.onChange (value) -> 
    graph.render value,graph.theta
    null
  thetacontrol.onChange (value) -> 
    graph.render graph.r,value
    null
  showTooltip = (x, y, contents) ->
    $("<div id=\"tooltip\">" + contents + "</div>").css(
      position: "absolute"
      display: "none"
      top: y + 5
      left: x + 5
      border: "1px solid #fdd"
      padding: "2px"
      "background-color": "#fee"
      opacity: 0.80
    ).appendTo("body").fadeIn 200
    null
  previousPoint = null
  $("#democontainer").bind "plothover", (event, pos, item) ->
    $("#x").text pos.x.toFixed(2)
    $("#y").text pos.y.toFixed(2)
    if item
      unless previousPoint is item.dataIndex
        previousPoint = item.dataIndex
        $("#tooltip").remove()
        x = item.datapoint[0].toFixed(2)
        y = item.datapoint[1].toFixed(2)
        showTooltip item.pageX, item.pageY, "(#{x},#{y})"
    else
      $("#tooltip").remove()      
    null    
  null
firstdemo()