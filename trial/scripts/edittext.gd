extends CodeEdit

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




func _on_runcode_pressed():
	var base=get_parent().get_parent().get_parent().get_parent().get_node_or_null("Game")
	if base!=null:
		for child in base.get_node("Objects").get_children():child.queue_free()
	get_parent().get_parent().get_parent().get_parent().get_node("Game").visible=true
	data.convert_from_string(text)


func _on_stopcode_pressed():
	get_parent().get_parent().get_parent().get_parent().get_node("scriptholder").set_script(null)
	get_parent().get_parent().get_parent().get_parent().get_node("Game").visible=false
