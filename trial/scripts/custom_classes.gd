extends Node
class_name customs


#the functions used by the custom code
func grab(name_of):
	return data.stored.textures[name_of]
func add(obj):
	get_parent().get_node("TabContainer/Game/Objects").add_child(obj)


#basic functions for objects
class basic extends Node2D:
	var x=0
	var y=0
	var vars={}
	func move(xx,yy):
		position.x=xx;position.y=yy
		x=position.x;y=position.y
	func move_by(xx,yy):move(position.x+xx,position.y+yy)
	func _process(_delta):update()
	func add(obj):add_child(obj)
	func cset(n,val):vars[n]=val
	func cget(n):return vars[n]
	func fpos():position=Vector2(x,y)


class sprite extends basic:
	var texture = null
	func _draw():
		if texture!=null:draw_texture_rect(texture,Rect2(x,y,8,8),false)
