# Author: Danilo Brandolin
#	Description: Basic functions to control graphic indicators
# 
extends CanvasLayer

# TODO: signal hub
# emmited when health reaches under 0 (dies)
signal zeroHealth

onready var healthBar: ProgressBar = $Health

export var maxHealth = 100
var _health: float

# Sets health bar to pAmount. Defaults to maxHealth, calling with no arguments resets back this indicator
# to the default (max value)
func SetHealth(pAmount = maxHealth):
	_health = pAmount
	healthBar.value = _health

# Takes pAmount damange (in health), and emmits "zeroHealth" signal when health reaches under 0.
func TakeDamange(pAmount: float):
	SetHealth(_health - pAmount)
	if(_health <= 0):
		emit_signal("zeroHealth")

# Reset health at start
func _ready():
	SetHealth()
