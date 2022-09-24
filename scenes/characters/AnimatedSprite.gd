extends AnimatedSprite

onready var cat = get_parent()

const IDLE       = "idle"
const JUMP_START = "jump_start"
const JUMP_LOOP  = "jump_loop"
const JUMP_END   = "jump_end"
const WALK       = "walk"

# blink animation time when Cat is damanged
export var blinkFrequency: int = 10
export var maxBlinkTime: int = 100

const _DEFAULTCOLOR = Color.white
const _DAMANGECOLOR = Color.red
const _RESPAWNCOLOR = Color.black

var _blinkTimeCount:int = 0
var _currentBlinkColor: Color = _DEFAULTCOLOR

# Fetch animation durations to check finite animations finished
var duration: Dictionary

func Update():
	if(cat.catStatus & cat.GO_LEFT):
		flip_h = true
	elif(cat.catStatus & cat.GO_RIGHT):
		flip_h = false

	if(cat.catStatus == cat.IDLE):
		_Idle()
	elif(cat.catStatus & cat.JUMPING):
		_Jump()
	elif(cat.catStatus & cat.WALKING):
		_Walk()

func _Walk(pFlipLeft = true):
	play("walk") 

func _Idle():
	play("idle") 

func _Jump(pFalling = false):
	if(cat.catStatus & cat.JUMP):
		play(JUMP_START)
	elif(cat.catStatus & cat.JUMPED):
		if(duration[animation] == frame && animation == JUMP_START):
			play(JUMP_LOOP)

func TakeDamange():
	_currentBlinkColor = _DAMANGECOLOR

func Respawn():
	_currentBlinkColor = _RESPAWNCOLOR

# Called when the node enters the scene tree for the first time.
func _ready():
	# Fill duration dictionary
	var animationNames = frames.get_animation_names()
	for n in animationNames:
		duration[n] = frames.get_frame_count(n) - 1

func _process(delta):
	if(_currentBlinkColor != _DEFAULTCOLOR):
		if(_blinkTimeCount <= maxBlinkTime):
			_blinkTimeCount += 1
			if((_blinkTimeCount/blinkFrequency) % 2):
				set_modulate(_currentBlinkColor)
			else:
				set_modulate(_DEFAULTCOLOR)
		else:
			_blinkTimeCount = 0
			_currentBlinkColor = _DEFAULTCOLOR
			set_modulate(_DEFAULTCOLOR)
