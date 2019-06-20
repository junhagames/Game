switch (global.chrMap[? "warriorWeapon"]) {
	case "bat":
		price = 5;
		name = "도끼";
		sprite_index = spr_weapon_axe;
		break;
	case "axe":
		price = 10;
		name = "빠루";
		sprite_index = spr_weapon_crowbar;
		break;
	case "crowbar":
		price = 15;
		name = "오함마";
		sprite_index = spr_weapon_hammer;
		break;
	case "hammer":
		price = 20;
		name = "뚜러뻥";
		sprite_index = spr_weapon_plunger;
		break;
	case "plunger":
		price = 25;
		name = "장미칼";
		sprite_index = spr_weapon_knife;
		break;
	case "knife":
		price = 30;
		name = "닭다리";
		sprite_index = spr_weapon_chicken;
		break;
}

event_inherited();
