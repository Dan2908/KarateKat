extends StaticBody2D

onready var translationVector = Vector2.ZERO

export var MAX_VERTICAL_STEPS: int = 32
export var speed: float

var _steps = 0

func _ready():
	translationVector.y = -speed

func _process(delta):

	if(_steps > MAX_VERTICAL_STEPS):
		translationVector.y = -translationVector.y
		_steps = 0

	translate(translationVector)
	_steps += speed
