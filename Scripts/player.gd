extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready
var anim_tree = $AnimationTree
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	anim_tree.active = true

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		anim_tree.set("parameters/conditions/jump", true)
	else:
		anim_tree.set("parameters/conditions/jump", false)
		
	if (direction != 0 and is_on_floor()):
		anim_tree.set("parameters/Jump/blend_position",direction)
		anim_tree.set("parameters/Idle/blend_position",direction)
		anim_tree.set("parameters/Walk/blend_position",direction)
		anim_tree.set("parameters/conditions/idle", false)
		anim_tree.set("parameters/conditions/walk", true)
		print(direction)
	else:
		anim_tree.set("parameters/conditions/walk", false)
		anim_tree.set("parameters/conditions/idle", true)

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
