class_name LevelTileMap extends TileMapLayer

func _ready():
	LevelManager.ChangeTilemapBounds(GetTileMapBoundary())
	pass

func GetTileMapBoundary() -> Array[Vector2]:
	var rect := get_used_rect()
	var boundary: Array[Vector2] = []

	if rect.size == Vector2i.ZERO:
		push_warning("TileMap has no used cells.")
		return boundary

	# Calculate top-left in pixels
	var top_left = Vector2(rect.position) * rendering_quadrant_size + position
	# Calculate bottom-right in pixels (subtract 1 to get inclusive boundary)
	var bottom_right = Vector2(rect.position + rect.size) * rendering_quadrant_size + position - Vector2(1,1)

	boundary.append(top_left)
	boundary.append(bottom_right)
	return boundary
