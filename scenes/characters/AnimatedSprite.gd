extends AnimatedSprite

onready var cat = get_parent()

const IDLE       = "idle"
const JUMP_START = "jump_start"
const JUMP_LOOP  = "jump_loop"
const JUMP_END   = "jump_end"
const WALK       = "walk"

var duration: Dictionary

func Walk(pFlipLeft = true):
	flip_h = pFlipLeft
	play("walk") 

func Idle():
	play("idle") 

func Jump(pFalling = false):
	pass

func Update():
	if(cat.catStatus == cat.IDLE):
		play(IDLE)
	elif(cat.catStatus & cat.JUMP):
		play(JUMP_START)
	elif(cat.catStatus & cat.JUMPED):
		if(duration[animation] == frame && animation == JUMP_START):
			play(JUMP_LOOP)
	elif(cat.catStatus & cat.WALK_LEFT):
		flip_h = true
		play(WALK)
	elif(cat.catStatus & cat.WALK_RIGHT):
		flip_h = false
		play(WALK) 

# Called when the node enters the scene tree for the first time.
func _ready():
	# Fill duration dictionary
	var animationNames = frames.get_animation_names()
	for n in animationNames:
		duration[n] = frames.get_frame_count(n) - 1


