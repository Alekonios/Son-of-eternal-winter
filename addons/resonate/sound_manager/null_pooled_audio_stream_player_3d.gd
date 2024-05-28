class_name NullPooledAudioStreamPlayer3D
extends RefCounted #PooledAudioStreamPlayer3D
## An extension of PooledAudioStreamPlayer3D that nerfs all of its public methods.


###########################################################################
# ЖЕСТКИЕ ХАККИ АЛЕКСА
###########################################################################

## Emitted when this player has been released and should return to the pool.
signal released

## Whether this player has been reserved.
var reserved: bool

## Whether this player is in the process of being released.
var releasing: bool

## Whether this player has been configured to support polyphonic playback.
var poly: bool

## A collection of all active polyphonic stream IDs.
var poly_stream_ids: Array

## The collection of streams configured on this player.
var streams: Array

## The base/fallback volume of this player.
var base_volume: float

## The base/fallback pitch of this player.
var base_pitch: float

## The target this player should follow in 2D or 3D space.
var follow_target: Node

## When the player should sync its transform when following a target.
var follow_type: PoolEntity.FollowType

# ------------------------------------------------------------------------------
# Public methods
# ------------------------------------------------------------------------------


## Returns a new player.
static func create() -> PooledAudioStreamPlayer3D:
	return PoolEntity.create(PooledAudioStreamPlayer3D.new())


## Configure this player with the given streams and charateristics.
func configure(p_streams: Array, p_reserved: bool, p_bus: String, p_poly: bool, p_volume: float, p_pitch: float, p_mode: Node.ProcessMode) -> void:
	PoolEntity.configure(self, p_streams, p_reserved, p_bus, p_poly, p_volume, p_pitch, p_mode)


## Attach this player to a 2D/3D position or node.
func attach_to(p_node: Variant) -> void:
	PoolEntity.attach_to(self, p_node)


# ------------------------------------------------------------------------------
# Private methods
# ------------------------------------------------------------------------------


func _on_finished() -> void:
	PoolEntity.finished(self)

###########################################################################


## Whether this player is a [PooledAudioStreamPlayer3D], or a Null instance.
func is_null() -> bool:
	return true


## A nerfed (does nothing) version of [method PooledAudioStreamPlayer3D.trigger]
func trigger() -> void:
	return


## A nerfed (does nothing) version of [method PooledAudioStreamPlayer3D.trigger_varied]
func trigger_varied(p_pitch: float = 1.0, p_volume: float = 0.0) -> void:
	return


## A nerfed (does nothing) version of [method PooledAudioStreamPlayer3D.reset_volume]
func reset_volume() -> void:
	return

## A nerfed (does nothing) version of [method PooledAudioStreamPlayer3D.reset_pitch]
func reset_pitch() -> void:
	return

## A nerfed (does nothing) version of [method PooledAudioStreamPlayer3D.reset_all]
func reset_all() -> void:
	return


## A nerfed (does nothing) version of [method PooledAudioStreamPlayer3D.release]
func release(p_finish_playing: bool = false) -> void:
	return
