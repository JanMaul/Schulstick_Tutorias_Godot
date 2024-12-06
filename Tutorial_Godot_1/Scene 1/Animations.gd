extends AnimatedSprite2D

# EN: This Script handles Animation for the Player
# DE: Dieses Script handlet Animationen für den Player

# EN: Selects the Player Node
# DE: 
@onready var Player = get_node("../Player")

func _process(delta):
	if Input.is_action_pressed("Left"):
		play("Run")
		scale.x = -4.5

	elif Input.is_action_pressed("Right"):
		play("Run")
		scale.x = 4.5

	else:
		play("Idle")
