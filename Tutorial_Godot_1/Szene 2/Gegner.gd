extends CharacterBody2D


const speed = 100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = -1

var collision

signal PlayerCollision()

func _ready():
	var Player = get_node("../../Spieler")
	Player.EnemyHit.connect(_on_spieler_EnemyHit)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if "Spieler" in collision.get_collider().name :
			print("Player Collision")
			PlayerCollision.emit()
			
	if collision:
		print(collision.get_collider_rid())

func _on_collision_timer_timeout():
	if $RayCast2D.is_colliding():
		$RayCast2D.target_position *= -1
		direction *= -1

func _on_spieler_EnemyHit(Gegner_Name):
	print("Enemy Defeated")
	if Gegner_Name == self:
		self.queue_free()
