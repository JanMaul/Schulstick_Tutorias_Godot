extends CharacterBody2D

# EN: Change this to make the Player Run faster or Jump Higher
# DE: Hier wird die Sprunghöhe und Schnelligkeit des Spielers festgelegt
const speed = 300.0
const jump_velocity = -600.0

const maxhealth = 3
var health: int

var invincible = false

var EnemyArray = []

signal EnemyHit(EnemyName: Node)
signal PlayerHit

# EN: This imports a Built-in gravity setting normaly applied to Rigidbodys
# DE: Dass Importiert die Eingebaute Gravitation, welche Normalerweise zu Rigidbodys gehört
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# 
func _ready():
	EnemyArray = get_node("../Gegner").find_children("*Gegner*")
	print(EnemyArray)
	for i in range(len(EnemyArray)):
		EnemyArray[i].PlayerCollision.connect(_on_gegner_player_collision)

	health = maxhealth

func _physics_process(delta):
	# EN: Adds the gravity to the Player
	# DE: Fügt Gravitation zum Spieler hinzu
	if not is_on_floor():
		velocity.y += gravity * delta

	# EN: Makes the Player Jump
	# DE: Lässt den Spieler Springen	
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = jump_velocity

	# EN: This var does the Player Inputs. If Left is pressed, it is -1, if Right +1.
	# DE: Diese Variable beinhaltet die Tastatureingaben. Linke Taste: Die variable ist -1. Rechte Taste: die Variable ist +1
	var direction = Input.get_axis("Left", "Right")

	# EN: This means the Code runs if "Direction" is NOT 0.
	# DE: Diese Stelle bedeutet dass der folgende Code ausgeführt wird wenn "Direction" ist NICHT 0.
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if $RayCast2D.is_colliding() && $RayCast2D.get_collider(0) in EnemyArray:
		print("Enemy Hit")
		EnemyHit.emit($RayCast2D.get_collider(0))

	# EN: This makes the Code calculate the Players physics
	# DE: Dass Lässt den Code die Spielerphysik berechnen
	move_and_slide()


func _on_gegner_player_collision():
	if invincible == false:
		health -= 1
		print("hit ", health)
		invincible = true
		$Invincible_timer.start()

func _on_invincible_timer_timeout():
	invincible = false
