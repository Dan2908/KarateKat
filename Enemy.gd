# Enemy.gd
# Author: Danilo Brandolin
#	Description: Base class for enemies in the game
extends KinematicBody2D

#*********************************
# Variables
#*********************************
export var enemyType: int = 0

var _dmgPoints:int setget SetDmgPoints, GetDmgPoints
var _health:int setget SetHealth, GetHealth
var _scoreValue:int setget SetScoreValue, GetScoreValue

#*********************************
# Functions
#*********************************
# Enemy movement, must override for each type
func Move():
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
