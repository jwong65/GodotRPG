class_name Camera extends Camera2D

func _ready():
	LevelManager.TileMapBoundsChanged.connect(UpdateLimits)
	UpdateLimits(LevelManager.current_tilemap_boundary )
	pass
	
func UpdateLimits(boundary: Array[Vector2]) -> void:
	if boundary == []:
		return
	
	limit_left = int(boundary[0].x)
	limit_top = int(boundary[0].y)
	limit_right = int(boundary[1].x)
	limit_bottom = int(boundary[1].y)
	pass
