extends AnimatedSprite2D

@onready var Player = get_node("../Spieler")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("Up"):
		self.play("JumpUp")
		
	elif Input.is_action_pressed("Left"):
		play("Run")
		scale.x = -4.5

	elif Input.is_action_pressed("Right"):
		play("Run")
		scale.x = 4.5

	else:
		play("Idle")
