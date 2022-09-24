extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite

export var damange: int = 10
export var speed = 60
export var moveRange: = 100

var _stepCount = 0
var direction: bool

func Move(pDelta):
	_stepCount += abs(speed)
	if(_stepCount > moveRange/pDelta):
		_stepCount = 0
		speed *= -1
		direction = !direction
		animatedSprite.set_flip_h(direction)

	move_and_slide(Vector2(speed, 0), Vector2.UP)

func _ready():
	if(speed > 0):
		direction = false
	else:
		direction = true

func _physics_process(delta):
	Move(delta)
