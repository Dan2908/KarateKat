extends KinematicBody2D

onready var animation = $AnimatedSprite
onready var _initial_pos = transform.get_origin()

export var walkSpeed = 40
export var jumpSpeed = 40
export var mass = 98

var _velocity_vector: Vector2 = Vector2(0, mass)
var _respawn_pos: Vector2
#===========
# status track for motion
const IDLE       = 0x0000
const ONFLOOR    = 0x0001
const WALK_RIGHT = 0x0002
const WALK_LEFT  = 0x0004
const JUMP       = 0x0008
const JUMPED     = 0x0010
const FLY_RIGHT  = 0x0020
const FLY_LEFT   = 0x0040

const GO_RIGHT   = WALK_RIGHT | FLY_RIGHT
const GO_LEFT    = WALK_LEFT | FLY_LEFT
const WALKING    = WALK_RIGHT | WALK_LEFT
const JUMPING	 = JUMP | JUMPED

var catStatus: int = 0

func UpdateCatStatus():
	ActionTracker.Update()
	catStatus = IDLE

	if(is_on_floor()):
		catStatus |= ActionTracker.GetFlag(ActionTracker.UP_JUST) * JUMP
		catStatus |= ActionTracker.GetFlag(ActionTracker.RIGHT) * WALK_RIGHT
		catStatus |= ActionTracker.GetFlag(ActionTracker.LEFT) * WALK_LEFT
	else:
		catStatus |= JUMPED
		catStatus |= ActionTracker.GetFlag(ActionTracker.RIGHT) * FLY_RIGHT
		catStatus |= ActionTracker.GetFlag(ActionTracker.LEFT) * FLY_LEFT

func Respawn():
	translate(_respawn_pos - transform.get_origin())

func SetRespawnPos(pNewPos: Vector2):
	_respawn_pos = pNewPos

#===========
func _ready():
	_respawn_pos = _initial_pos

func _physics_process(delta):
	UpdateCatStatus()

	_velocity_vector.x = 0
	if(catStatus & GO_RIGHT):
		_velocity_vector.x = walkSpeed
	elif(catStatus & GO_LEFT):
		_velocity_vector.x = -walkSpeed

	if(catStatus & JUMP):
		_velocity_vector.y = -jumpSpeed
	elif(catStatus & JUMPED):
		_velocity_vector.y = clamp(_velocity_vector.y + 5 + sqrt(abs(_velocity_vector.y)), -jumpSpeed, mass)
	else:
		_velocity_vector.y = 10

	move_and_slide(_velocity_vector, Vector2.UP)
	animation.Update()
