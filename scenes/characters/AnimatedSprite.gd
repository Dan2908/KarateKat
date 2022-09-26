# Author: Danilo Brandolin
#	Description: This script provides an Update function that plays the corresponding
# animation checking the parent (Cat) catStatus flag. Also provides functions for blinking
# 	Name: Cat animated sprite
extends AnimatedSprite

onready var cat = get_parent()

#===================================
#	Variables
#===================================
const IDLE         = "idle"
const JUMP_START   = "jump_start"
const JUMP_LOOP    = "jump_loop"
const JUMP_END     = "jump_end"
const KICK_HIGH    = "kick_high"
const KICK_MIDDLE  = "kick_middle"
const KICK_LOW     = "kick_low"
const KICK_JUMPING = "kick_jumping"
const PUNCH        = "punch"
const WALK         = "walk"

const _DEFAULTCOLOR = Color.white
const _DAMANGECOLOR = Color.red
const _RESPAWNCOLOR = Color.black

# blink animation time when Cat is damanged
export var blinkFrequency: int = 10
export var maxBlinkTime: int = 100

var _blinkTimeCount:int = 0
var _currentBlinkColor:Color = _DEFAULTCOLOR
var _animationOnCourse:bool = false	#animations that must be finished before change

# Fetch animation durations to check finite animations finished
var duration: Dictionary
var animationCheckPriority: Array = [ '_Punch', '_Kick', '_Idle', '_Jump', '_Walk' ]

#===================================
#	Functions
#===================================
func TakeDamange():
	_currentBlinkColor = _DAMANGECOLOR

func Respawn():
	_currentBlinkColor = _RESPAWNCOLOR

func Update():
	_CheckFacingSide(cat.catStatus)

	if(_animationOnCourse):
		if(duration[animation] == frame):
			_animationOnCourse = false

	for check in animationCheckPriority:
		if(call(check)):
			break

#===================================
#	Private
#===================================
func _CheckFacingSide(pStatus: int):
	if(cat.catStatus & cat.GO_LEFT):
		flip_h = true
	elif(cat.catStatus & cat.GO_RIGHT):
		flip_h = false

func _Walk():
	var result = cat.catStatus & cat.WALKING
	if(result):
		play("walk") 
	return result

func _Idle():
	if(_animationOnCourse): 
		return false
	if(cat.catStatus == cat.IDLE):
		play("idle") 
		return true
	return false

func _Jump():
	if(_animationOnCourse): 
		return false
	if(cat.catStatus & cat.JUMP):
		play(JUMP_START)
		_animationOnCourse = true
	elif(cat.catStatus & cat.JUMPED):
		play(JUMP_LOOP)
	else:
		return false
	return true

func _Kick():
	if(cat.catStatus & cat.KICK):
		if(cat.catStatus & cat.JUMPED):
			play(KICK_JUMPING)
		elif(cat.catStatus & cat.PRESSING_UP):
			play(KICK_HIGH)
		elif(cat.catStatus & cat.PRESSING_DOWN):
			play(KICK_LOW)
		else:
			play(KICK_MIDDLE)
		_animationOnCourse = true
		frame = 0
		return true
	return false

func _Punch():
	if(cat.catStatus & cat.PUNCH):
		play(PUNCH)
		_animationOnCourse = true
		return true
	return false

# Blinks if the _currentBlinkColor is other than default.
# _currentBlinkColor are used both as blink color and as flag to control the blink 
func _Blink():
	if(_currentBlinkColor != _DEFAULTCOLOR):
		if(_blinkTimeCount <= maxBlinkTime):
			_blinkTimeCount += 1
			if((_blinkTimeCount/blinkFrequency) % 2):
				set_modulate(_currentBlinkColor)
			else:
				set_modulate(_DEFAULTCOLOR)
		else:	# Reset to default
			_blinkTimeCount = 0
			_currentBlinkColor = _DEFAULTCOLOR
			set_modulate(_DEFAULTCOLOR)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Fill duration dictionary
	var animationNames = frames.get_animation_names()
	for n in animationNames:
		duration[n] = frames.get_frame_count(n) - 1

func _process(delta):
	_Blink()
