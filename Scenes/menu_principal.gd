extends Control

@onready
var animatedSprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	animatedSprite.play("Start bucle")

func _process(delta):
	if !animatedSprite.is_playing():
		get_tree().change_scene_to_file("res://Scenes/main.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			animatedSprite.play("start")
