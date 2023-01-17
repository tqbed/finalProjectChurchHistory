extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
		var dialog = Dialogic.start('/unit1/Unit1Crucify')
		dialog.connect('timeline_end', self, 'unpause')
		add_child(dialog)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
