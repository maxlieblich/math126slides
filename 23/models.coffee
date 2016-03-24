####
#postmortem= ->
#  exam= ->
#    @breakdown=true
#    $("#breakdown").toggle(true)
#    $("#total").toggle(false)
#    d1=[[0,22],[1,9],[2,10],[3,9],[4,8],[5,14],[6,252]]
#    d2=[[0,161],[1,47],[2,62],[3,31],[4,16],[5,4],[6,3]]
#    d3=[[0,12],[1,8],[2,14],[3,87],[4,159],[5,27],[6,17]]
#    d4=[[0,80],[1,54],[2,54],[3,62],[4,44],[5,21],[6,9]]
#    breakraw=[d1,d2,d3,d4]
#    breakdata=[]
#    breakdata.push {label: "Problem #{i}", data: breakraw[i-1]} for i in [1..4]
#
#    optionsbreak=
#      series:
#         lines:
#           show: true
#         bars:
#           show: false
#           barWidth: 1
#           align: "center"
#         xaxis:
#           min: 0
#
#
#    $.plot $("#breakdown"),breakdata,optionsbreak
#
#    totraw=[[0,7],[3,7],[6,14],[9,41],[12,99],[15,104],[18,41],[21,10],[24,1]]
#    totdata=[{label: "Total", data: totraw}]
#
#    optionstotal=
#      series:
#         lines:
#           show: false
#         bars:
#           show: true
#           barWidth: 3
#           align: "center"
#         xaxis:
#           min: 0
#       grid:
#         labelMargin: 30
#
#    $.plot $("#total"),totdata,optionstotal
#    null
#  test=new exam()
#  gui=new dat.GUI(
#    autoPlace: false
#  )
#  $("#controls").append gui.domElement
#  control=gui.add test,"breakdown"
#  control.onChange (value)->
#    $("#breakdown").toggle(value)
#    $("#total").toggle(!value)
#    null
#  null
#postmortem()
####
#
