/// @description Insert description here

draw_clear(c_black);

// text
var camera = camera_get_active();

var xfrom = Player.x;
var yfrom = Player.y;
var zfrom = Player.z;
var xto = xfrom + dcos(Player.look_dir);
var yto = yfrom - dsin(Player.look_dir);
var zto = zfrom - dsin(Player.look_pitch);

camera_set_view_mat(camera, matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1));
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(60, window_get_width() / window_get_height(), 1, 32000));
camera_apply(camera);

// text
vertex_submit(vbuffer, pr_trianglelist, sprite_get_texture(spr_grass, 0));