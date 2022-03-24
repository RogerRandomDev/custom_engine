extends TextEdit

#sets up the text editor objects
func _ready():
	loadd()
func loadd():
	get_child(0,true).rect_min_size=Vector2(120,0)
	get_child(1,true).rect_min_size=Vector2(0,104)


func _notification(_what):
	if get_child_count(true)!=0:
		get_child(0,true).visible=true
		get_child(1,true).visible=true
