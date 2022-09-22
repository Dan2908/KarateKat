extends Node2D

onready var cat = $Cat
onready var respawnPos = $Respawn
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_DeadLine_body_entered(body):
	if(body == cat):
		cat.Respawn()

func _on_Respawn_body_entered(body):
	if(body == cat):
		respawnPos.ChangeColor(Color.red)
		cat.SetRespawnPos(respawnPos.get_transform().get_origin())
