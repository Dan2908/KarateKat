# Author: Danilo Brandolin
#	Description: Stores and keeps track of all actions triggered by the user
# 
extends Node

#===================================
#	Constants
#===================================
#   Action flags
const NONE       = 0x0000
const UP         = 0x0001
const DOWN       = 0x0002
const LEFT       = 0x0004
const RIGHT      = 0x0008
const KICK       = 0x0010
const PUNCH      = 0x0020
const JUMP       = 0x0040
const UP_JUST    = 0x0080
const DOWN_JUST  = 0x0100
const LEFT_JUST  = 0x0200
const RIGHT_JUST = 0x0400
const KICK_JUST  = 0x0800
const PUNCH_JUST = 0x1000
const JUMP_JUST  = 0x2000

const MASK_ACTION = UP | DOWN | LEFT | RIGHT | KICK | PUNCH | UP_JUST | DOWN_JUST | LEFT_JUST | RIGHT_JUST | KICK_JUST | PUNCH_JUST
#===================================
#	Variables
#===================================
var _action: int = 0 setget _SetAction, _GetAction

#===================================
#	Public
#===================================
func Update():
	_SetIfPressed("move_up", UP)
	_SetIfPressed("move_down", DOWN)
	_SetIfPressed("move_left", LEFT)
	_SetIfPressed("move_right", RIGHT)
	_SetIfPressed("kick", KICK)
	_SetIfPressed("punch", PUNCH)
	_SetIfPressed("jump", JUMP)
	_SetIfJustPressed("move_up", UP_JUST)
	_SetIfJustPressed("move_down", DOWN_JUST)
	_SetIfJustPressed("move_left", LEFT_JUST)
	_SetIfJustPressed("move_right", RIGHT_JUST)
	_SetIfJustPressed("kick", KICK_JUST)
	_SetIfJustPressed("punch", PUNCH_JUST)
	_SetIfJustPressed("jump", JUMP_JUST)

func SetFlag(pFlag: int):
	_action |= pFlag

func ClearFlag(pFlag: int):
	_action &= ~pFlag

#return 1 if set, 0 otherwise
func GetFlag(pFlag: int):
	if(_action & pFlag):
		return 1
	return 0

# Returns true if no action is pressed, false otherwise
func NoActionPressed():
	return (_action == NONE)

#===================================
#	Private
#===================================
func _SetAction(pAction: int):
	_action = pAction

func _GetAction():
	return _action

func _SetIfPressed(pAction: String, pFlag: int):
	ClearFlag(pFlag)
	if(Input.is_action_pressed(pAction)):
		SetFlag(pFlag)

func _SetIfJustPressed(pAction: String, pFlag: int):
	ClearFlag(pFlag)
	if(Input.is_action_just_pressed(pAction)):
		SetFlag(pFlag)
