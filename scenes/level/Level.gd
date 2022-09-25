# Author: Danilo Brandolin
#	Description: Stores and keeps track of all actions triggered by the user
#   Scene: Level
extends Node2D

onready var cat = $Cat
onready var respawnPos = $Respawn
onready var levelStats = $LevelStats

# Resurrects Cat to the respawn position
func Resurrect():
	cat.Respawn()			# Respawn and
	levelStats.SetHealth()	# reset health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Cat felt under deadline
func _on_DeadLine_body_entered(body):
	if(body == cat):
		Resurrect()

# Cat checked a new respawn point, make this the current respawn position
func _on_Respawn_body_entered(body):
	if(body == cat):
		respawnPos.ChangeColor(Color.red)
		cat.SetRespawnPos(respawnPos.get_transform().get_origin())

# Enemy hit
func _on_Cat_enemyHit(body):
	levelStats.TakeDamange(body.GetDmgPoints())	# TODO: Enemy may be a class

# Cat health is over
func _on_LevelStats_zeroHealth():
	Resurrect()

