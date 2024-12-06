extends CharacterBody2D

# EN: Change this to make the Player Run faster or Jump Higher
# DE: Hier wird die Sprunghöhe und Schnelligkeit des Players festgelegt
@export var speed = 300.0
@export var jump_velocity = -600.0


# EN: This imports a Built-in gravity setting normaly applied to Rigidbodys
# DE: Dass Importiert die Eingebaute Gravitation, welche Normalerweise zu Rigidbodys gehört
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# EN: Adds the gravity to the Player if they arent on the Ground
	# DE: Fügt Gravitation zum Player hinzu, wenn er nicht auf dem Boden ist
	if not is_on_floor():
		velocity.y += gravity * delta

	# EN: Makes the Player Jump
	# DE: Lässt den Player Springen
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = jump_velocity

	# EN: This var does the Player Inputs. If Left is pressed, it is -1, if Right +1.
	# DE: Diese Variable beinhaltet die Tastatureingaben. Linke Taste: Die variable ist -1. Rechte Taste: die Variable ist +1
	var direction = Input.get_axis("Left", "Right")

# EN: This means the Code runs if "Direction" is NOT 0.
# DE: Diese Stelle bedeutet dass der folgende Code ausgeführt wird wenn "Direction" ist NICHT 0.
	if direction:
		# EN: This calculates Direction and Speed of the Player
		# DE: Dass Berechnet die Richtung und Geschwindigkeit vom Player
		velocity.x = direction * speed
	else:
		# EN: If the Direction is 0 it means it will stop the Player
		# DE: Wenn kein Input gegeben ist wird der Player gestoppt
		velocity.x = move_toward(velocity.x, 0, speed)

	# EN: This makes the Code calculate the Players physics
	# DE: Dass Lässt den Code die Playerphysik berechnen
	move_and_slide()
