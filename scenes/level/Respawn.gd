extends Area2D

onready var letter = $Label

func ChangeColor(pColor: Color):
	letter.set_self_modulate(pColor)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
