/// @description 가상 조이스틱 업데이트
/// @param vstickID

var vstickID = argument0;

// 가상 조이스틱 입력 초기화
global.vstick[vstickID, VSTICK_SETTING.PRESSED] = false;
global.vstick[vstickID, VSTICK_SETTING.RELEASED] = false;

// 가상 조이스틱 눌렸을 때
for (var i = 0; i < 5; i++) {
	if (device_mouse_check_button_pressed(i, mb_left)) {
		// 이동 조이스틱 중심 설정
		if (vstickID == VSTICK.MOVE && device_mouse_x_to_gui(i) < global.gameWidth / 3 && device_mouse_y_to_gui(i) > global.gameHeight / 2) {
			global.vstick[vstickID, VSTICK_SETTING.CENTER_X] = device_mouse_x_to_gui(i);
			global.vstick[vstickID, VSTICK_SETTING.CENTER_Y] = device_mouse_y_to_gui(i);
		}
		
		if (point_distance(global.vstick[vstickID, VSTICK_SETTING.CENTER_X], global.vstick[vstickID, VSTICK_SETTING.CENTER_Y], device_mouse_x_to_gui(i), device_mouse_y_to_gui(i)) < global.vstick[vstickID, VSTICK_SETTING.RADIUS]) {
			global.vstick[vstickID, VSTICK_SETTING.DEVICE_ID] = i;
			global.vstick[vstickID, VSTICK_SETTING.CHECK] = true;
			global.vstick[vstickID, VSTICK_SETTING.PRESSED] = true;
			global.vstick[vstickID, VSTICK_SETTING.DRAW_X] = device_mouse_x_to_gui(i);
			global.vstick[vstickID, VSTICK_SETTING.DRAW_Y] = device_mouse_y_to_gui(i);
			break;
		}
	}
}

// 가상 조이스틱 누르고 있을 때
if (global.vstick[vstickID, VSTICK_SETTING.CHECK]) {
	var mx = device_mouse_x_to_gui(global.vstick[vstickID, VSTICK_SETTING.DEVICE_ID]);
	var my = device_mouse_y_to_gui(global.vstick[vstickID, VSTICK_SETTING.DEVICE_ID]);
	global.vstick[vstickID, VSTICK_SETTING.DISTANCE] = point_distance(global.vstick[vstickID, VSTICK_SETTING.CENTER_X], global.vstick[vstickID, VSTICK_SETTING.CENTER_Y], mx, my);
	
	// 가상 조이스틱 이동 설정
	if (global.vstick[vstickID, VSTICK_SETTING.DISTANCE] < global.vstick[vstickID, VSTICK_SETTING.RADIUS]) {
		global.vstick[vstickID, VSTICK_SETTING.X] = mx;
		global.vstick[vstickID, VSTICK_SETTING.Y] = my;
	}
	else {
		global.vstick[vstickID, VSTICK_SETTING.X] = global.vstick[vstickID, VSTICK_SETTING.CENTER_X] + lengthdir_x(global.vstick[vstickID, VSTICK_SETTING.RADIUS], global.vstick[vstickID, VSTICK_SETTING.DIRECTION]);
		global.vstick[vstickID, VSTICK_SETTING.Y] = global.vstick[vstickID, VSTICK_SETTING.CENTER_Y] + lengthdir_y(global.vstick[vstickID, VSTICK_SETTING.RADIUS], global.vstick[vstickID, VSTICK_SETTING.DIRECTION]);
	}
	
	// 가상 조이스틱 방향 설정
	if (global.vstick[vstickID, VSTICK_SETTING.DISTANCE] > global.vstick[vstickID, VSTICK_SETTING.RADIUS] / 2) {
		global.vstick[vstickID, VSTICK_SETTING.X_AXIS] = global.vstick[vstickID, VSTICK_SETTING.CENTER_X] > global.vstick[vstickID, VSTICK_SETTING.X] ? -1 : 1;
		global.vstick[vstickID, VSTICK_SETTING.Y_AXIS] = global.vstick[vstickID, VSTICK_SETTING.CENTER_Y] > global.vstick[vstickID, VSTICK_SETTING.Y] ? -1 : 1;
	}
	else {
		global.vstick[vstickID, VSTICK_SETTING.X_AXIS] = 0;
		global.vstick[vstickID, VSTICK_SETTING.Y_AXIS] = 0;
	}
	global.vstick[vstickID, VSTICK_SETTING.DIRECTION] = point_direction(global.vstick[vstickID, VSTICK_SETTING.CENTER_X], global.vstick[vstickID, VSTICK_SETTING.CENTER_Y], mx, my);

	// 가상 조이스틱 땠을 때
	if (device_mouse_check_button_released(global.vstick[vstickID, VSTICK_SETTING.DEVICE_ID], mb_left)) {
		global.vstick[vstickID, VSTICK_SETTING.DEVICE_ID] = -1;
		global.vstick[vstickID, VSTICK_SETTING.X] = global.vstick[vstickID, VSTICK_SETTING.CENTER_X];
		global.vstick[vstickID, VSTICK_SETTING.Y] = global.vstick[vstickID, VSTICK_SETTING.CENTER_Y];
		global.vstick[vstickID, VSTICK_SETTING.X_AXIS] = 0;
		global.vstick[vstickID, VSTICK_SETTING.Y_AXIS] = 0;
		global.vstick[vstickID, VSTICK_SETTING.CHECK] = false;
		global.vstick[vstickID, VSTICK_SETTING.RELEASED] = true;
	}
}
global.vstick[vstickID, VSTICK_SETTING.DRAW_X] = scr_tween_to(global.vstick[vstickID, VSTICK_SETTING.DRAW_X], global.vstick[vstickID, VSTICK_SETTING.X], 0.3);
global.vstick[vstickID, VSTICK_SETTING.DRAW_Y] = scr_tween_to(global.vstick[vstickID, VSTICK_SETTING.DRAW_Y], global.vstick[vstickID, VSTICK_SETTING.Y], 0.3);