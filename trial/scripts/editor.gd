extends Node2D

var palette=["#000000","#1D2B53","#7E2553","#008751","#AB5236","#5F574F","#C2C3C7","#FFF1E8","#FF004D","#FFA300","#FFEC27","#00E436","#29ADFF","#83769C","#FF77A8","#FFCCAA"]

func _ready():
	RUN.root=$TabContainer

func _process(_delta):
	if $scriptholder.has_method("_process"):
		$scriptholder.call("_process",_delta)

var last_tab=0

func force_change_tab(tab):
	last_tab=tab
	$TabContainer.current_tab=tab
