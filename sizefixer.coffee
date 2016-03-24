window.onresize=->
	db=document.body
	sx=800/window.innerWidth#db.clientWidth/window.innerWidth
	sy=600/window.innerHeight#db.clientHeight/window.innerHeight
	s=1/Math.max(sx.sy)
	if sx<1 and sy<1
		db.style.marginTop=(window.innerHeight-600)/2.toString()+"px"#(window.innerHeight-db.clientHeight)/2
	else
		transform="scale(#{s})"
		db.style.MosTransform=transform
		db.style.WebkitTransform=transform
		db.style.OTransform=transform
		db.style.msTransform=transform
		db.style.transform=transform
	return
window.onresize()					