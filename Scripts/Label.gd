extends RichTextLabel

var txt: String

# Called when the node enters the scene tree for the first time.
func _ready():
	txt = text
	connect("mouse_entered", on_mouse_enter)
	connect("mouse_exited", on_mouse_exit)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_mouse_enter():
	text = "[u]" + txt + "[/u]"
	
func on_mouse_exit():
	text = txt

