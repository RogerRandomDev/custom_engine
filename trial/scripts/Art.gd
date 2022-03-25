extends Control
var tex = Image.new()
var img = ImageTexture.new()
#prepares the color palette you can use
func _ready():
	tex.create(8,8,false,Image.FORMAT_RGBA8)
	$spritehold/texture.texture = img
	for color in get_parent().get_parent().palette:
		$colorlist.add_icon_item(load("res://textures/editor/pixel.png"))
		$colorlist.set_item_icon_modulate($colorlist.get_item_count()-1,Color(color))
	$colorlist.select(0)

var hover_cell = Vector2i(0,0)
var active_color=Color("#000000")
#used for drawing on it
func _input(_event):
	if !visible||$choosepanel.visible:return
	var m_pos = $spritehold/texture.get_local_mouse_position()
	var size = $spritehold/texture.rect_size
	if m_pos.x<0||m_pos.y<0||m_pos.x>size.x||m_pos.y>size.y:return
	if Input.is_action_pressed("l_mouse"):
		tex.set_pixelv(hover_cell,active_color)
		img.create_from_image(tex)
	if Input.is_action_pressed("r_mouse"):
		tex.set_pixelv(hover_cell,Color.TRANSPARENT)
		img.create_from_image(tex)
	hover_cell = Vector2i(m_pos/8)
	update()
func _draw():
	var col = Color.BLACK
	var add = tex.get_pixelv(hover_cell)
	var add2 = (add.r+add.g+add.b)/3.
	if add.a!=0.&&add2<0.5:col=Color.WHITE
	draw_rect(Rect2(hover_cell*8+Vector2i(3,2),Vector2(7,7)),col,false,1.0)
	
var saving = false

func _on_colorlist_item_selected(index):
	active_color = $colorlist.get_item_icon_modulate(index)


func _on_save_pressed():
	saving = true
	load_panel()


func _on_load_pressed():
	saving = false
	load_panel()





#loads the choosepanel
func load_panel():
	$choosepanel/name_of.text=""
	for item in $choosepanel/current_names.get_item_count():
		$choosepanel/current_names.remove_item(0)
	for names in data.get_textures().keys():
		$choosepanel/current_names.add_item(names)
	$choosepanel.visible=true


func _on_cancel_pressed():
	$choosepanel.visible=false


func _on_yes_pressed():
	var name_of = $choosepanel/name_of.text
	if saving:
		data.add_texture(name_of.to_lower(),img.duplicate(true))
		new_img()
	else:
		if !data.get_textures().keys().has(name_of):return
		img = data.get_textures()[name_of].duplicate(true)
		tex.create_from_data(8,8,false,Image.FORMAT_RGBA8,img.get_image().get_data())
		$spritehold/texture.texture=img
	$choosepanel.visible=false


func _on_current_names_item_selected(index):
	$choosepanel/name_of.text=$choosepanel/current_names.get_item_text(index)


func _on_new_pressed():
	new_img()
#resets image texture
func new_img():
	tex.create(8,8,false,Image.FORMAT_RGBA8)
	img.create_from_image(tex)
