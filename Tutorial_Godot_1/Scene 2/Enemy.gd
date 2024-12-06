extends CharacterBody2D

# EN: Defines the Enemys Speed.
# DE: Definiert die Geschwindigkeit des Gegners
const speed = 100.0

# EN: This imports a Built-in gravity setting normaly applied to Rigidbodys
# DE: Dass Importiert die Eingebaute Gravitation, welche Normalerweise zu Rigidbodys gehört
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# EN: Sets the Initial movement direction. If the Value is Negative: moves Right, positive: Left. 0 means stop.
# DE: Setzt die Initiale bewegunsrichtung. Wenn der Wert Negativ ist nach rechts, sonst Links. 0 heisst stop.
@export var direction = -1

var collision

var Player

# EN: Signal meant for Damage to the Player
# DE: Signal für Schaden zum Spieler
signal PlayerCollision()

func _ready():
	# EN: Sets the Player variable and connects it with the Signal for dealing damage to the Enemy itself
	# DE: Setzt die Player variable und verbindet ihn mit dem Signal für Schaden zum Gegner selbst
	Player = get_node("../../Player")
	Player.EnemyHit.connect(_on_spieler_EnemyHit)

func _physics_process(delta):
	# EN: Adds  gravity to the Enemy if they arent on the Ground
	# DE: Fügt Gravitation zum Gegner hinzu, wenn er nicht auf dem Boden ist
	if not is_on_floor():
		velocity.y += gravity * delta

	# EN: Movement calculation, takes into account the Direction and max peed of the Enemy. if the
	# Direction is 0, it will stop.
	# DE: Bewegunsberechnung, nimmt die Richtung und maximale Geschwindigkeit des Gegners in
	# betracht. wenn die Richtung 0 ist, stoppt er.
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	# EN: Checks if (in all the Collisions the Enemie has found) the Player is detected and sends a 
	# Signal if this is the case
	# DE: Checkt ob (in allen vom Gegner momentan gefundenen Kollisionen) der Spieler entdeckt wurde
	# und Sendet ein signal wenn dies der Fall ist
	for i in get_slide_collision_count():
		collision = get_slide_collision(i)
		if Player == collision.get_collider():
			PlayerCollision.emit()

	# EN: Makes the Computer compute the Physics for moving the Enemy
	# DE: Lässt den Computer die Physik für die Bewegung des Gegners berechnen
	move_and_slide()

# EN: This is on a Timer to minimize performance loss. It is meant to check if the Raycast infront of
# the Enemy is detecting something other then the Player, and if yes, turn around.
# DE: Diese Funktion ist Timergebunden um Performanceverluste zu minimieren. Sie Testet ob der Raycast
# vor dem Gegner etwas anderes als den Spieler erkennt, und wenn ja, umdreht.
func _on_collision_timer_timeout():
	if $RayCast2D.is_colliding() and not Player == $RayCast2D.get_collider():
		$RayCast2D.target_position *= -1
		direction *= -1

# EN: If the Player hits an Enemy and the Name of the Hit object matches the Name of the Object
# executing the Script, the Enemy will delete itself.
# DE: Wenn der Spieler einen Gegner trifft und der Name des getroffenen Objektes mit dem Namen des
# Objektes wo das Script ausgeführt wird, löscht sich der Gegner selber.
func _on_spieler_EnemyHit(Gegner_Name):
	if Gegner_Name == self:
		self.queue_free()
