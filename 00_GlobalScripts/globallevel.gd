extends Node

var current_tilemap_boundary : Array[Vector2]
signal TileMapBoundsChanged (bounds: Array[Vector2])

func ChangeTilemapBounds( bounds: Array[Vector2])-> void:
	current_tilemap_boundary = bounds
	TileMapBoundsChanged.emit(bounds)
