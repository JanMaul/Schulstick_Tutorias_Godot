extends CharacterBody2D


const speed = 300.0
const jump_velocity = -600.0

const maxhealth = 3
var health: int

var invincible = false

var EnemyArray = []

signal EnemyHit(EnemyName: Node)
signal PlayerHit

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# 
func _ready():
	EnemyArray = get_node("../Gegner").find_children("*Gegner*")
	print(EnemyArray)
	for i in range(len(EnemyArray)):
		EnemyArray[i].PlayerCollision.connect(_on_gegner_player_collision)

	health = maxhealth

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if $RayCast2D.is_colliding() && $RayCast2D.get_collider(0) in EnemyArray:
		print("Enemy Hit")
		EnemyHit.emit($RayCast2D.get_collider(0))
	move_and_slide()


func _on_gegner_player_collision():
	if invincible == false:
		health -= 1
		print("hit ", health)
		invincible = true
		$Invincible_timer.start()

func _on_invincible_timer_timeout():
	invincible = false
