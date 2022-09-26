# Scene Ghost
# Author: Danilo Brandolin
#	Description: Enermy type ghost. This one floats around in a limited range and 
# attacks by passing over the player.
extends "res://Enemy.gd"

onready var _sprite = $AnimatedSprite

export var movingRadius:int = 60
export var speed:int = 40

func _ready():
	SetDmgPoints(15)
	SetHealth(10)
	SetScoreValue(100)

func Move(pDelta):
	if(abs(_currentPos.x) > movingRadius):
		speed *= -1	# Change sense
		if(speed < 0):
			_sprite.set_flip_h(true)
		else:
			_sprite.set_flip_h(false)
	move_and_slide(Vector2(speed, 0))
	_currentPos.x += speed * pDelta
