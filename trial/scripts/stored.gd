extends Node

#will be used for storing and pulling all the data for the engine
var stored={"textures":{}}
var object={}

#convert the scripts given to it
func convert_from_string(string_in):
	load_script_check()
	#rebuilds it with correct methods
	string_in="extends customs\n"+string_in.to_lower().replace(
		"load(","grab(").replace(
		"apd(","append(").replace(
		"rmv(","remove(").replace(
		"v2(","Vector2(").replace(
		"fn ","func ").replace(
		".n()",".new()").replace(
		".txr",".texture").replace(
		'upd()',"_process(_delta)"
		)
	var holder = get_tree().current_scene.get_node("scriptholder")
	holder.set_script(null)
	if !check_valid_script(load("user://script.gd")):return false
	load("user://script.gd").set_source_code(string_in)
	load("user://script.gd").reload()
	var a=load("user://script.gd")
	holder.set_script(a)
	write_script(string_in)
	if holder.has_method("_ready"):
		holder._ready()


#writes script to the file
func write_script(write):
	file.open("user://script.gd",File.WRITE)
	file.store_line(write)
	file.close()
#makes sure script exists
var file=File.new()
func load_script_check():
	if !file.file_exists("user://script.gd"):
		file.open("user://script.gd",File.WRITE)
		file.store_line("")
		file.close()

#returns textures
func get_textures():
	return stored.textures
#stores texture
func add_texture(name_of,texture):
	stored.textures[name_of]=texture


func _notification(what):
	print(what)

#should be used to check if it is valid
func check_valid_script(list):
	var funcs = list
	var a=Script.new()
	#should check if both customs and node don't have the functions in them
	print(list.get_script_method_list())

	
	return true
