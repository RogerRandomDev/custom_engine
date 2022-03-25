extends Node

#this will be filled with the custom functions for the custom engine here

var root=null

func PRINT(val):
	val=val[0]
	print(val)
func IF():
	pass


var draws = []
func DRAWTEX(tex_name):
	tex_name = tex_name[0]
	if data.stored.textures.has(tex_name.to_upper()):
		var draw = Sprite2D.new()
		draw.texture = data.stored.textures[tex_name.to_upper()]
		draw.centered=false
		root.add_child(draw)
		return draw
	return null


func REMOVEOBJ(obj):
	obj=obj[0]
	if is_instance_valid(obj)&&!obj.is_queued_for_deletion():
		obj.queue_free()


func MOVE(obj):
	
	var x=str2var(obj[1])
	var y=str2var(obj[2])
	obj=data.object[data.get_as_variable(obj[0])]
	if str(obj)=="null":return
	
	obj.position=Vector2(x,y)
