# Enemy.gd
# Author: Danilo Brandolin
#	Description: Base class for enemies in the game
extends KinematicBody2D

#*********************************
# Variables
#*********************************
var _dmgPoints:int setget SetDmgPoints, GetDmgPoints
var _health:int setget SetHealth, GetHealth
var _scoreValue:int setget SetScoreValue, GetScoreValue
# Positioning
var _initialPosition:Vector2
var _currentPos:Vector2 = Vector2.ZERO
#*********************************
# Functions
#*********************************
# Enemy movement, must override for each type
func Move(pDelta):
	pass

#*********************************
# SetGet
#*********************************
# ==================== Damage
func SetDmgPoints(pPoints: int):
	_dmgPoints = pPoints

func GetDmgPoints():
	return _dmgPoints
# ==================== Health
func SetHealth(pPoints: int):
	_health = pPoints

func GetHealth():
	return _health
# ==================== Score Value
func SetScoreValue(pPoints: int):
	_scoreValue = pPoints

func GetScoreValue():
	return _scoreValue

#*********************************
# Private
#*********************************
func _physics_process(delta):
	Move(delta)
