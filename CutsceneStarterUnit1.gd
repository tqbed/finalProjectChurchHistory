extends Area2D

var active = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, '_on_sign_body_entered')

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if active == 1:
			get_tree().paused = true
			var dialog = Dialogic.start('/unit1/Unit1Catchup')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)
			active = active + 1 
			 
func unpause(_timeline_name): 
	get_tree().paused = false
	
func _on_sign_body_entered(body):
		if body.name == 'Player':
			active = active + 1 
			
