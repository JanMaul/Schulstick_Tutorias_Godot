extends CharacterBody2D

# EN: Change this to make the Player Run faster or Jump Higher
# DE: Hier wird die Sprunghöhe und Schnelligkeit des Players
@export var speed = 300.0
@export var jump_velocity = -600.0

# EN: Max Health
# DE: Maximales Leben
@export var maxhealth = 3
var health: int

var invincible = false
var EnemyArray = []

# EN: Signals for Hitting the enemy and for Getting Hit by the enemy
# DE: Signale für vom Gegner Getroffen werden und fürs Gegner selber Treffen
signal EnemyHit(EnemyName: Node)
signal PlayerHit

# EN: Imports a Built-in gravity setting normaly applied to Rigidbodys. Better dont mess with this.
# DE: Dass Importiert die Eingebaute Gravitation, welche Normalerweise zu Rigidbodys gehört. Lieber nicht anfassen.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	# EN: Finds all Enemys in the Scene. In editor, enemys have to be put under the "Enemys" node
	# DE: Findet alle Gegner in der Szene. Im editor müssen Gegner unter "Enemys" geordnet sein.
	EnemyArray = get_node("../Enemys").find_children("*Enemy*")

	# EN: Loops over all found Enemys and connects them to the Signal handling Player Damage
	# DE: Loopt über alle gefundenen Gegner und verbindet sie mit dem Signal für Player Schaden
	for i in range(len(EnemyArray)):
		EnemyArray[i].PlayerCollision.connect(_on_gegner_player_collision)

	# EN: Simply puts the Health at the Maximum Health. This comment is a bit useless i guess.
	# DE: Stellt das Player-Leben auf das Maximum. Dieser Kommentar ist wahrscheinlich etwas nutzlos.
	health = maxhealth

func _physics_process(delta):
	# EN: Adds the gravity to the Player if they arent on the Ground
	# DE: Fügt Gravitation zum Player hinzu, wenn er nicht auf dem Boden ist
	if not is_on_floor():
		velocity.y += gravity * delta

	# EN: Makes the Player Jump
	# DE: Lässt den Spieler Springen
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = jump_velocity

	# EN: This var does the Player Inputs. If Left is pressed, it is -1, if Right +1.
	# DE: Diese Variable beinhaltet die Tastatureingaben. Linke Taste: Die variable ist -1. Rechte Taste: die Variable ist +1
	var direction = Input.get_axis("Left", "Right")

	# EN: Means the Code runs if "Direction" is NOT 0.
	# DE: Bedeutet dass der folgende Code ausgeführt wird wenn "Direction" NICHT 0 ist.
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# EN: This Shapecast checks if the Player was falling and is landing on an Enemy. Then it checks if 
	# it has collided with anything and then if the name of the collided object is on the EnemyArray
	# DE: Dieser Shapecast testet ob der Spieler fällt auf einen Gegner landen wird. Dann wird getestet
	# ob es eine kollision gab und dann ob dass kollisionsobjekt auf der "Gegnerliste" ist
	if velocity.y > 0 && $ShapeCast2D.is_colliding() && $ShapeCast2D.get_collider(0) in EnemyArray:

		# EN: If any Enemy is hit, all Enemys receive a Signal including the Name of the Hit object,
		# which they will cross-reference with their own Name.
		# DE: Wenn ein Gegner getroffen wird, erhalten nun Alle Gegner ein Signal, welches den Namen
		# des getroffenen Objectes enthält, welche die Gegener nun mit dem eigenen namen vergleichen.
		EnemyHit.emit($ShapeCast2D.get_collider(0))

	# EN: This makes the Code calculate the Players physics
	# DE: Dass Lässt den Code die Playerphysik berechnen
	move_and_slide()
	
	if health <= 0:
		print("Player Died")


func _on_gegner_player_collision():
	# EN: Checks if the Player is Invincible, happens for a short time after being hit
	# DE: Testet ob der Player unbesiegbar ist, was für eine kurze zeit nach einem Treffer der Fall ist
	if invincible == false:

		# EN: Removes some Health from the Player
		# DE: Entfernt ein bisschen Leben vom Player
		health -= 1

		# EN: The Player is made Invincible for a short time after being hit to give them a Chance to Escape
		# DE: Der Player wird nach einem Treffer kurz Unbesiegbar damit man der Gefahr entkommen kann
		invincible = true
		
		# En: Starts a timer to limit invincibility
		# DE: Startet einen Timer um die Unbesiegbarkeit zu begrenzen
		$Invincible_timer.start()

# EN: If the Invincibility runs Out the Player can be attacked Again
# DE: Wenn die Unbesiegbarkeit vorbei ist kann der Player wieder Angegriffen werden
func _on_invincible_timer_timeout():
	invincible = false
