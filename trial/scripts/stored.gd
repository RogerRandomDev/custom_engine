extends Node

#will be used for storing and pulling all the data for the engine
var stored={"functions":{},"textures":{},"variables":{}}
var object={}

#convert the scripts given to it
func convert_from_string(string_in):
	string_in=string_in.to_lower()
	stored.functions={}
	stored.variables={}
	var split = string_in.replace("\n",";").replace(";;",";").split(";")
	var layers_in=[]
	for layer in split:
		var function = layer.contains("(")&&layer.contains(")")
		var store=null
		if function:
			var ready = layer.split("(")
			if ready[0].contains("="):
				ready[0]=ready[0].substr(ready[0].split("=")[0].length()+1,-1)
			if RUN.has_method(ready[0].to_upper()):
				var dat_in = ready[1].split(")")[0]
				dat_in=str(dat_in).replace('"','')
				dat_in=dat_in.split(",")
				var to_do=[]
				for obj in dat_in:
					to_do.append(get_as_variable(obj))
				store = RUN.call(ready[0].to_upper(),to_do)
				if typeof(store)==typeof(Object):
					object[str(store)]=store
		if layer.contains("var"):
			var ready=layer.split("var")[1].replace(" ","")
			var name_of=ready.split("=")[0]
			if ready.split("=").size()==0:
				fail()
				continue
			var value = store
			if store==null:
				value = do_the_math(ready.split("=")[1])
			stored.variables[name_of]=value


#failure
func fail():pass

#gets variables from the string
func get_as_variable(name_of):
	var returned = ""
	name_of=str(name_of)
	var names = name_of.split(",")
	for nameset in names:if stored.variables.has(nameset):returned+=","+str(stored.variables[nameset])
	if returned=="":
		returned=","+name_of
	return returned.substr(1,-1)


const math_functions="*+-/"
const numberset="0987654321"
#does any math inside of the string
func do_the_math(input_string):
	var number = ""
	var cur_number = 0
	
	for l in input_string.length():
		if !math_functions.contains(input_string[l]):
			number+=input_string[l]
		else:
			var next = input_string.substr(l+1,-1)
			number = str2var(get_as_variable(number))
			match input_string[l]:
				"+":number+=do_the_math(next)
				"-":number-=-do_the_math(next)
				"*":number*=do_the_math(next)
				"/":number/=do_the_math(next)
			return str2var(str(number))
	return str2var(str(number))

#returns textures
func get_textures():
	return stored.textures
#stores texture
func add_texture(name_of,texture):
	stored.textures[name_of]=texture
