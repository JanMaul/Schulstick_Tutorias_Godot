extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	is_current()
func _process(delta):

	zoom.x = get_viewport().get_visible_rect().size.x / 1280
	zoom.y = get_viewport().get_visible_rect().size.y / 720
 
