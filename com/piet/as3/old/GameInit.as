import flash.display.Sprite;
import flash.display.MovieClip;


// Cheats

var cheat_invisible: Boolean = false;
var cheat_sight: Boolean = false;

// Controls

var double_check_pressed: Number = 0;
var double_check_cnt: Number = 0;

// # INIT

var game_update: Boolean = false;

var time_needed: Number = 0;
var time_framecount: Number = 0;

var screenend_left: Number = 204;
var screenend_right: Number = 590;

var tiles_start_x: Number = 176;
var tiles_start_y: Number = 16;

var level_nmbr: Number = 1;
var level_array: Array = new Array();

var tiles_amount: Number = 0;
var tiles_amount_x: Number = 0;
var tiles_amount_y: Number = 0;
var tiles_amount_max: Number = 49;
var tiles_amount_x_max: Number = 7;
var tiles_amount_y_max: Number = 7;
var tiles_build_process: Boolean = true;

var new_tile_x: Number = tiles_start_x;
var new_tile_y: Number = tiles_start_y;

var player_location: Number = 0;
var player_action: String = "idle";

var player_speed_init: Number = 5;
var player_speed: Number = player_speed_init;
var player_speed_max: Number = 40;
var player_rollspeed: Number = 8;
var player_move_direction: String = "right";

var player_walknorth: Boolean = true;
var player_speed_north: Number = 8;

var player_stand_delay_init: Number = 25;
var player_stand_delay: Number = player_stand_delay_init;
var player_duck: Boolean = false;
var firstshot: Boolean = true;

var player_pos_x: Number = 390;
var player_pos_y: Number = 400;

var player_start_x: Number = 340;
var player_start_y: Number = 400;

var anim_shoot: Boolean = true;
var bullet_speed: Number = 50;

var tiles_container: Sprite = new Sprite();
addChild(tiles_container);

var enemy_container: Sprite = new Sprite();
addChild(enemy_container);

var side_shooting_trigger:Boolean = false;
var enemy_seen:Boolean = false;

var player: Sprite = null;

var mc_guiBar: MovieClip = new GuiBar();

var count_viewBullets:Number = 0;
var viewBulletVar: Boolean = false;

var player_walknorth_shoot:Boolean = false;

var waypoint_waiting: Boolean = false;

var block_array: Array = new Array();
var wallarray: Array = new Array();
var cover_array: Array = new Array();
var northwalk_array: Array = new Array();
var enemy_array: Array = new Array();
var ground_array: Array = new Array();