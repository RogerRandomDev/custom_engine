extends Control

#prepares the color palette you can use
func _ready():
	for color in get_parent().get_parent().palette:
		$colorlist.add_icon_item(load("res://textures/editor/pixel.png"))
		$colorlist.set_item_icon_modulate($colorlist.get_item_count()-1,Color(color))
