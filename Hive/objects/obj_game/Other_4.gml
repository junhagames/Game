var _roomMap = global.roomMap[? global.currentIndex];
var infoMap = _roomMap[? "info"];
var entryMap = _roomMap[? "entry"];

// 시야 밝히기
infoMap[? "search"] = "known";

#region 입구 생성
with (obj_parent_entry) {
	var isEntry = false;
	
	for (var i = 0; i < ds_map_size(entryMap); i++) {
		var _entryMap = entryMap[? i];
		
		if (pos == _entryMap[? "pos"]) {
			targetIndex = _entryMap[? "targetIndex"];
			isEntry = true;
			break;
		}
	}
	var wall = instance_create_layer(x, y, "layer_solid", obj_solid_wall);
	wall.image_xscale = sprite_width / wall.sprite_width;
	wall.image_yscale = sprite_height / wall.sprite_height;
	wallID = wall.id;
		
	if (isEntry) {
		var targetRoomMap = global.roomMap[? targetIndex];
		var targetInfoMap = targetRoomMap[? "info"];
		
		// 인접한 룸 시야 밝히기
		if (targetInfoMap[? "search"] == "unknown") { 
			targetInfoMap[? "search"] = "close";
		}
		
		// 입구 스프라이트 설정
		var posTo;
		
		if (pos == "top" || pos == "topleft" || pos == "topright") {
			posTo = "top";
		}
		else if (pos == "right" || pos == "righttop" || pos == "rightbottom") {
			posTo = "right"
		}
		else if (pos == "bottom" || pos == "bottomright" || pos == "bottomleft") {
			posTo = "bottom";
		}
		else if (pos == "left" || pos == "leftbottom" || pos == "lefttop") {
			posTo = "left"
		}
				
		switch (targetInfoMap[? "event"]) {
			#region boss
			case "boss":
				if (posTo == "top") {
					sprite_index = spr_entry_boss_top;
				}
				else if (posTo == "right") {
					sprite_index = spr_entry_boss_right;
				}
				else if (posTo == "bottom") {
					sprite_index = spr_entry_boss_bottom;
				}
				else if (posTo == "left") {
					sprite_index = spr_entry_boss_left;
				}
				break;
			#endregion
			#region miniboss
			case "miniboss":
				if (posTo == "top") {
					sprite_index = spr_entry_miniboss_top;
				}
				else if (posTo == "right") {
					sprite_index = spr_entry_miniboss_right;
				}
				else if (posTo == "bottom") {
					sprite_index = spr_entry_miniboss_bottom;
				}
				else if (posTo == "left") {
					sprite_index = spr_entry_miniboss_left;
				}
				break;
			#endregion
			#region supply
			case "supply":
				if (posTo == "top") {
					sprite_index = spr_entry_supply_top;
				}
				else if (posTo == "right") {
					sprite_index = spr_entry_supply_right;
				}
				else if (posTo == "bottom") {
					sprite_index = spr_entry_supply_bottom;
				}
				else if (posTo == "left") {
					sprite_index = spr_entry_supply_left;
				}
				break;
			#endregion
			#region potionshop
			case "potionshop":
				if (posTo == "top") {
					sprite_index = spr_entry_potionshop_top;
				}
				else if (posTo == "right") {
					sprite_index = spr_entry_potionshop_right;
				}
				else if (posTo == "bottom") {
					sprite_index = spr_entry_potionshop_bottom;
				}
				else if (posTo == "left") {
					sprite_index = spr_entry_potionshop_left;
				}
				break;
			#endregion
			#region weaponshop
			case "weaponshop":
				if (posTo == "top") {
					sprite_index = spr_entry_weaponshop_top;
				}
				else if (posTo == "right") {
					sprite_index = spr_entry_weaponshop_right;
				}
				else if (posTo == "bottom") {
					sprite_index = spr_entry_weaponshop_bottom;
				}
				else if (posTo == "left") {
					sprite_index = spr_entry_weaponshop_left;
				}
				break;
			#endregion
			#region encounter
			case "encounter":
				if (posTo == "top") {
					sprite_index = spr_entry_encounter_top;
				}
				else if (posTo == "right") {
					sprite_index = spr_entry_encounter_right;
				}
				else if (posTo == "bottom") {
					sprite_index = spr_entry_encounter_bottom;
				}
				else if (posTo == "left") {
					sprite_index = spr_entry_encounter_left;
				}
				break;
			#endregion
			#region default
			default:
				if (posTo == "top") {
					sprite_index = spr_entry_stage_top;
				}
				else if (posTo == "right") {
					sprite_index = spr_entry_stage_right;
				}
				else if (posTo == "bottom") {
					sprite_index = spr_entry_stage_bottom;
				}
				else if (posTo == "left") {
					sprite_index = spr_entry_stage_left;
				}
				break;
			#endregion
		}
	}
	else {
		instance_destroy();
	}
}
#endregion
#region 캐릭터|시스템 생성
if (!instance_exists(obj_chr)) {
	var startX, startY; 

	if (global.previousIndex == noone) {
		startX = room_width / 2;
		startY = room_height / 2;
	}
	else {
		with (obj_parent_entry) {
			var entryw = (bbox_left + bbox_right) / 2;
			var entryh = (bbox_top + bbox_bottom) / 2;
			var chrw = 80;
			var chrh = 80;

			if (targetIndex == global.previousIndex) {
				var entryCount = 0;
			
				for (var i = 0; i < ds_map_size(entryMap); i++) {
					var _entryMap = entryMap[? i];
					
					if (targetIndex == _entryMap[? "targetIndex"]) {
						entryCount++;
					}
				}
			
				if (global.previousPos == "top" || global.previousPos == "topleft" || global.previousPos == "topright") {
					if (entryCount == 1 ||
						(entryCount == 2 && ((global.previousPos == "topleft" && pos == "bottomleft") || (global.previousPos == "topright" && pos == "bottomright")))) {
						startX = entryw;
						startY = entryh - chrh;
					}
				}
				else if (global.previousPos == "right" || global.previousPos == "righttop" || global.previousPos == "rightbottom") {
					if (entryCount == 1 ||
						(entryCount == 2 && ((global.previousPos == "righttop" && pos == "lefttop") || (global.previousPos == "rightbottom" && pos == "leftbottom")))) {
						startX = entryw + chrw;
						startY = entryh;
					}
				}
				else if (global.previousPos == "bottom" || global.previousPos == "bottomright" || global.previousPos == "bottomleft") {
					if (entryCount == 1 ||
						(entryCount == 2 && ((global.previousPos == "bottomright" && pos == "topright") || (global.previousPos == "bottomleft" && pos == "topleft")))) {
						startX = entryw;
						startY = entryh + chrh;
					}
				}
				else if (global.previousPos == "left" || global.previousPos == "leftbottom" || global.previousPos == "lefttop") {
					if (entryCount == 1 ||
						(entryCount == 2 && ((global.previousPos == "leftbottom" && pos == "rightbottom") || (global.previousPos == "lefttop" && pos == "righttop")))) {
						startX = entryw - chrw;
						startY = entryh;
					}
				}
			}
		}
	}
	instance_create_layer(startX, startY, "layer_inst", obj_chr);
}
instance_create_layer(0, 0, "layer_system", obj_camera);
instance_create_layer(0, 0, "layer_draw", obj_draw);
#endregion

// 인스턴스 정보 초기화|불러오기
scr_room_inst_start();

// 길찾기 그리드 생성
enemyPathGrid = mp_grid_create(0, 0, room_width div CELL_WIDTH, room_height div CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT);
mp_grid_add_instances(enemyPathGrid, obj_parent_solid, false);
mp_grid_add_instances(enemyPathGrid, obj_parent_entry, false);

// 미니맵 생성
scr_minimap_create();