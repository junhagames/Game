/// @description 룸 메모리 파괴

var _roomMap = global.roomMap[? global.currentIndex];
var memoryMap = _roomMap[? "memory"];

for (var i = 0; i < ds_map_size(memoryMap); i++) {
	var _memoryMap = memoryMap[? i];
	
	if (id == _memoryMap[? "id"]) {
		_memoryMap[? "hp"] = 0;
		break;
	}
}