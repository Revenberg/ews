BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "token" (
	"rowid"	integer NOT NULL UNIQUE,
	"presentation_id"	integer,
	"uid"	text,
	"token_name"	text COLLATE UTF8_U_CI,
	"token_type"	int8,
	"token_format"	text,
	"token_interval"	int8,
	"token_time_value"	datetime,
	"token_time_value_fixed"	datetime,
	"token_allow_overrun"	boolean,
	"token_value"	text,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("presentation_id") REFERENCES "presentation"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "slide_property_group" (
	"rowid"	integer NOT NULL UNIQUE,
	"link_id"	integer,
	"group_name"	text,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("link_id") REFERENCES "slide"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "slide_property" (
	"rowid"	integer NOT NULL UNIQUE,
	"group_id"	integer,
	"value_type"	byte,
	"key"	text,
	"value"	text,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("group_id") REFERENCES "slide_property_group"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "slide" (
	"rowid"	integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"presentation_id"	integer NOT NULL,
	"title"	text,
	"slide_uid"	text,
	"slide_rev_uid"	text,
	"order_index"	integer,
	"layout_flag"	integer,
	"theme_id"	integer,
	"theme_slide_uid"	text,
	"modified_theme_id"	integer,
	"modified_theme_layout_revision"	integer,
	"layout_revision"	integer DEFAULT 1,
	"thumbnail_desired_rev"	integer DEFAULT 1,
	"thumbnail_rev"	integer DEFAULT 1,
	"thumbnail"	jpeg,
	FOREIGN KEY("presentation_id") REFERENCES "presentation"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_web" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"url"	text COLLATE UTF8_U_CI,
	"remove_scroll_bars"	boolean,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_video" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"file_id"	integer,
	"original_filename"	text,
	"filesize"	int64,
	"modified_date"	datetime,
	"start_pos"	int64 DEFAULT -1,
	"end_pos"	int64 DEFAULT -1,
	"poster_frame_pos"	int64 DEFAULT -1,
	"width"	integer,
	"height"	integer,
	"duration"	int64,
	"repeating"	boolean,
	"alpha_channel_mode"	int8,
	"video_stream_count"	integer,
	"audio_stream_count"	integer,
	"video_stream_type"	integer DEFAULT -1,
	"audio_stream_type"	integer DEFAULT -1,
	"audio_stream_profile"	integer DEFAULT -1,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("file_id") REFERENCES "file"("rowid") ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_text" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"rtf"	rtf,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_shape" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"shape_data"	text,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_powerpoint" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"file_id"	integer,
	"original_filename"	text,
	"filesize"	int64,
	"modified_date"	datetime,
	"width"	integer,
	"height"	integer,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("file_id") REFERENCES "file"("rowid") ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_image" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"file_id"	integer,
	"original_filename"	text,
	"filesize"	int64,
	"modified_date"	datetime,
	"width"	integer,
	"height"	integer,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("file_id") REFERENCES "file"("rowid") ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_gradient_color" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"color_from"	integer,
	"color_to"	integer,
	"percent_from"	double,
	"percent_to"	double,
	"ramp"	int8,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_gradient" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"angle"	integer,
	"transparent"	boolean,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_feed_pc" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"device_name"	text COLLATE UTF8_U_CI,
	"device_uid"	text,
	"video_standard"	integer,
	"color_compression"	text,
	"frame_rate"	integer,
	"input_port"	integer,
	"width"	integer,
	"height"	integer,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_feed" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"feed_type"	int8,
	"modified_date"	datetime,
	"thumbnail"	png,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_dvd_pc" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"segment_bookmark"	blob,
	"clip_bookmark"	blob,
	"bookmark_os_ver"	integer,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_dvd_disk" (
	"rowid"	integer NOT NULL UNIQUE,
	"disk_uid"	text,
	"disk_name"	text COLLATE UTF8_U_CI,
	PRIMARY KEY("rowid")
);
CREATE TABLE IF NOT EXISTS "resource_dvd" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"resource_dvd_disk_id"	integer,
	"modified_date"	datetime,
	"start_pos"	int64 DEFAULT -1,
	"end_pos"	int64 DEFAULT -1,
	"poster_frame_pos"	int64 DEFAULT -1,
	"width"	integer,
	"height"	integer,
	"duration"	int64,
	"repeating"	boolean,
	"clip_title"	integer,
	"clip_chapter"	integer,
	"clip_angle"	integer,
	"clip_audio"	integer,
	"clip_subpicture"	integer,
	"clip_segment_start_pos"	int64,
	"clip_segment_duration"	int64,
	"clip_fps_flag"	integer,
	"thumbnail"	jpeg,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("resource_dvd_disk_id") REFERENCES "resource_dvd_disk"("rowid") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_color" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"color"	integer,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource_audio" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_id"	integer,
	"file_id"	integer,
	"original_filename"	text,
	"filesize"	int64,
	"modified_date"	datetime,
	"start_pos"	int64 DEFAULT -1,
	"end_pos"	int64 DEFAULT -1,
	"duration"	int64,
	"repeating"	boolean,
	"video_stream_count"	integer,
	"audio_stream_count"	integer,
	"video_stream_type"	integer DEFAULT -1,
	"audio_stream_type"	integer DEFAULT -1,
	"audio_stream_profile"	integer DEFAULT -1,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("file_id") REFERENCES "file"("rowid") ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY("resource_id") REFERENCES "resource"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "resource" (
	"rowid"	integer NOT NULL UNIQUE,
	"resource_hash"	integer,
	"resource_uid"	text,
	"resource_type"	int8,
	"title"	text COLLATE UTF8_U_CI,
	"author"	text COLLATE UTF8_U_CI,
	"copyright"	text COLLATE UTF8_U_CI,
	"description"	text,
	"tags"	text COLLATE UTF8_U_CI,
	PRIMARY KEY("rowid")
);
CREATE TABLE IF NOT EXISTS "presentation_property_group_global" (
	"rowid"	integer NOT NULL UNIQUE,
	"link_id"	integer,
	"group_name"	text,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("link_id") REFERENCES "presentation"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "presentation_property_group" (
	"rowid"	integer NOT NULL UNIQUE,
	"link_id"	integer,
	"group_name"	text,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("link_id") REFERENCES "presentation"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "presentation_property_global" (
	"rowid"	integer NOT NULL UNIQUE,
	"group_id"	integer,
	"value_type"	byte,
	"key"	text,
	"value"	text,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("group_id") REFERENCES "presentation_property_group_global"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "presentation_property" (
	"rowid"	integer NOT NULL UNIQUE,
	"group_id"	integer,
	"value_type"	byte,
	"key"	text,
	"value"	text,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("group_id") REFERENCES "presentation_property_group"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "presentation" (
	"rowid"	integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"presentation_uid"	text,
	"presentation_rev_uid"	text,
	"presentation_global_uid"	text,
	"presentation_type"	int8,
	"aspect_ratio"	text,
	"group_level"	integer,
	"order_index"	integer,
	"thumbnail_slide_id"	integer,
	"layout_revision"	integer DEFAULT 1,
	"thumbnail_desired_rev"	integer DEFAULT 1,
	"thumbnail_rev"	integer DEFAULT 1,
	"thumbnail"	jpeg,
	"auto_theme"	boolean,
	"looping"	boolean,
	"title"	text COLLATE UTF8_U_CI,
	"author"	text COLLATE UTF8_U_CI,
	"copyright"	text COLLATE UTF8_U_CI,
	"administrator"	text COLLATE UTF8_U_CI,
	"description"	text,
	"tags"	text COLLATE UTF8_U_CI,
	"reference_number"	text COLLATE UTF8_U_CI,
	"vendor_id"	integer,
	"notes"	text,
	"modified_date"	datetime,
	"ready"	integer DEFAULT 1,
	"error_no"	integer,
	FOREIGN KEY("thumbnail_slide_id") REFERENCES "slide"("rowid") ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "info" (
	"rowid"	integer NOT NULL UNIQUE,
	"version"	text,
	"version_min"	text,
	PRIMARY KEY("rowid")
);
CREATE TABLE IF NOT EXISTS "file" (
	"rowid"	integer NOT NULL UNIQUE,
	"file_hash"	text,
	"filename"	text,
	"shared_filename"	text,
	PRIMARY KEY("rowid")
);
CREATE TABLE IF NOT EXISTS "element_property_group" (
	"rowid"	integer NOT NULL UNIQUE,
	"link_id"	integer,
	"group_name"	text,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("link_id") REFERENCES "element"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "element_property" (
	"rowid"	integer NOT NULL UNIQUE,
	"group_id"	integer,
	"value_type"	byte,
	"key"	text,
	"value"	text,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("group_id") REFERENCES "element_property_group"("rowid") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "element" (
	"rowid"	integer NOT NULL UNIQUE,
	"slide_id"	integer,
	"element_uid"	text,
	"element_type"	int8,
	"element_style_type"	int8,
	"order_index"	integer,
	"x"	double,
	"y"	double,
	"width"	double,
	"height"	double,
	"background_resource_id"	integer,
	"foreground_resource_id"	integer,
	"internal_mute"	boolean,
	"from_master"	boolean,
	PRIMARY KEY("rowid"),
	FOREIGN KEY("background_resource_id") REFERENCES "resource"("rowid") ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY("slide_id") REFERENCES "slide"("rowid") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("foreground_resource_id") REFERENCES "resource"("rowid") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (1,2,'Master','MASTER',NULL,0,2083,NULL,'SONG',NULL,NULL,4174860020257587200,4174860020407756801,4174860020257652736,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (2,1,'','1-87C52416-E36B-423B-9B70-9CE8B342E36E',NULL,0,2083,2,'MASTER',NULL,NULL,4174860024868184065,4174860024868249601,4174860024868249601,X'ffd8ffe000104a46494600010100000100010000ffdb0043000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f171816141812141514ffdb00430103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc000110800c0012003012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fcaaa28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a2bedaff00826e7ecade0cf8ff000fc49f1278af48b8f19cfe13b28a4d3bc1d6b7df633a94f22ccca1e50ca54130841f305cb92dc0c1cdfda67c1de14d72cbc3fe12d07f667f11fc16f8b7a9eb96f69636b35f4f7567aa5bb874291bcbb10bf9ad072ab8c1396a00f8de8afb0fc49ff04c3f887a2693af47a7f8bfc11e24f19787ec86a3abf83348d55a4d52d212bb81f2ca005b69071919c8da5b2b9e7fe12ffc13dbc71f16be12f863e2441e2df057877c2daedf4962936bdaa3dac9032492c7970d16d6dcf110aa8ccc77af006e2a01f2e515f5337fc138fe2c1fda466f8371ff0064c9abc5a7aeb126b3f6871a7a5896da272c537fdfca6dd99dc0f61baab7c5efd823c4df0a3e11eb3f12e0f1f780fc69e12d32fa3d3a49fc31aac977234cce89b788b602a5c6e52f9039c723201f31515ed7fb247827e177c40f8b7a668ff14f5bd5b4ad32e6e6da0b2b7d2adfcc37d70f32208247c131a306e5c723b63ad759ff000513f84de13f827fb526bde14f05690ba1f87edaceca58acd269250acf02b39dd233372493c9a00f9a28a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a00fa77f637b0f05b43ae6a175f1deffe05fc43b59a31a56a31452b5a5e5b153e6c7294da07cc13867c73f75bb7d87f153f6f5f04fc3ff077c23d0353f1f41f1dfc65e1ff0014db6afab788f4fd2c5ac505ac6d206f2f808f37972ec5da79c12c54919fc9fa2803f587c3ff00197e05fc13fda1fe287ed2763f1874ff001647e27d225874bf08595a4c3506b890c2e6394301b1775b800b05003f246d1bbe68f88ff1a7c1dadffc132be1afc3fb4d7ed64f1c69fe2e9f51bcd1625612c10b3ea043f4db8fdf45d0ff0010af8d68a00fd8ed7ff6ccf855ad7eda9ab5c58eb973af7827c43f0dd342bcd7740b19ee5b4e9d2f2e5c974442e1024dcb0520164cf1923ccfe2ff00c3df097c21ff008258789f44f0a78aef3c5ba3df78b619adb57bfd225d2fed521961dcb14529dccaab137cfd18abe3815f9dbf0a7e2f78bfe0878be2f1478235a9741d76289e15bb8a28e43b1b1b94ac8aca41c0ea2ba2f8cffb507c53fda152ca3f883e32bef115bd93992ded5d2382de37231bc4512a26ec1237633824679a00dbfd917c35e0dd5fe2e697abf8d3e21d87c3eb0f0f5ddaead14d7f6924e2f9e2b846302ec23692013b8e47b57b5ffc14cb52f865f147e245c7c52f037c52d2fc5777aa496ba7c9e1db3b49565b68e3b720ce656c061ba351b42e7e71e95f13d140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451401fffd9');
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (3,1,'','1-2A6B58E7-47B2-4E1A-91E7-E8E15CCF7EDB',NULL,1,2083,2,'MASTER',NULL,NULL,4174860025368354817,4174860025368420353,4174860025368420353,X'ffd8ffe000104a46494600010100000100010000ffdb0043000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f171816141812141514ffdb00430103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc000110800c0012003012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fcaaa28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a2bedaff00826e7ecade0cf8ff000fc49f1278af48b8f19cfe13b28a4d3bc1d6b7df633a94f22ccca1e50ca54130841f305cb92dc0c1cdfda67c1de14d72cbc3fe12d07f667f11fc16f8b7a9eb96f69636b35f4f7567aa5bb874291bcbb10bf9ad072ab8c1396a00f8de8afb0fc49ff04c3f887a2693af47a7f8bfc11e24f19787ec86a3abf83348d55a4d52d212bb81f2ca005b69071919c8da5b2b9e7fe12ffc13dbc71f16be12f863e2441e2df057877c2daedf4962936bdaa3dac9032492c7970d16d6dcf110aa8ccc77af006e2a01f2e515f5337fc138fe2c1fda466f8371ff0064c9abc5a7aeb126b3f6871a7a5896da272c537fdfca6dd99dc0f61baab7c5efd823c4df0a3e11eb3f12e0f1f780fc69e12d32fa3d3a49fc31aac977234cce89b788b602a5c6e52f9039c723201f31515eb7fb3c78dfe15780757d6b53f8a1e00baf88c82d9574ad261d41eca113eff99e5910e7685c8036b0c9e9debe8bfdb83e07fc2ad3ff00671f84df19fe1ef8567f87777e2f97cbb8f0ccd7925c2b46627712aef2480a635e576865990ed06803e19a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2803e9dfd8dec3c16d0eb9a85d7c77bff00817f10ed668c695a8c514ad69796c54f9b1ca53681f304e19f1cfdd6edf61fc54fdbd7c13f0ffc1df08f40d4fc7d07c77f19787fc536dabeade23d3f4b16b1416b1b481bcbe023cde5cbb1769e704b152467f27e8a00fd61f0ff00c65f817f04ff00687f8a1fb49d8fc61d3fc591f89f48961d2fc21656930d41ae2430b98e50c06c5dd6e002c1400fc91b46ef9a3e23fc69f076b7ff0004caf86bf0fed35fb593c71a7f8ba7d46f34589584b042cfa810fd36e3f7d1743fc42be35a2803f63b5ffdb33e156b5fb6a6ad7163ae5cebde09f10fc374d0af35dd02c67b96d3a74bcb9725d110b8409372c14805933c648f33f8bff0f7c25f087fe0961e27d13c29e2bbcf16e8f7de2d866b6d5eff0048974bfb548658772c514a7732aac4df3f462af8e057e76fc29f8bde2ff821e2f8bc51e08d6a5d075d8a27856ee28a390ec6c6e52b22b290703a8ae8be33fed41f14ff006854b28fe20f8cafbc456f64e64b7b5748e0b78dc8c6f1144a89bb048dd8ce0919e6803bdfd87bc19f053c49f126eb53f8e1e2c8342f0ee8e915c5b69570afb35594b1f91dd012117682ca002db80c819cfad7fc14375bf067c5a03c69a57c7fd17c69269cf1e9fa2781347d065b2834eb3279d8ed2b024055dcdb416c0036aaaa8f85a8a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a00fffd9');
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (4,3,'Master','MASTER',NULL,0,19,NULL,'',NULL,NULL,4174860021711661057,4174860021711726593,4174860021711726593,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (5,3,'Song','SONG',NULL,1,2083,NULL,'MASTER',NULL,NULL,4174860021711792129,4174860021711857665,4174860021711857665,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (6,3,'Scripture','SCRIPTURE',NULL,2,67,NULL,'MASTER',NULL,NULL,4174860021711923201,4174860021711988737,4174860021711988737,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (7,3,'Presentation','PRESENTATION',NULL,3,143,NULL,'MASTER',NULL,NULL,4174860021712054273,4174860021712119809,4174860021712119809,NULL);
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (1,1,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 1\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 1\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (2,2,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (3,3,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (4,4,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 2\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 2\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (5,5,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (6,6,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (1,-635329637,'1-F24B2E7D-6273-483C-8C60-7184D8D18EAF',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (2,-1607904850,'1-64E8A874-CA62-4137-B637-F9DE6EAF7903',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (3,1904655303,'1-DEC4A592-FFD5-4694-8582-B7EE5D791E40',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (4,-1050076976,'1-A6C54FF5-EF1D-4F9D-8282-61B76815417D',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (5,1827789933,'1-A522127A-E7EC-40A2-815C-A697C6960A25',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (6,408966689,'1-FBEA3BC2-C36D-4D1D-9672-D81FCBA1EBF2',6,'','','','','');
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (1,'5-A50BA9F0-64C7-A30D-31CA-8052894F3FC2','6-240659E7-1419-9EDD-FEE8-D309B3B85AF2',NULL,6,'',0,0,NULL,2072316776815861235,7553135444674717266,2314128624066440184,NULL,0,0,'testje','','','','','','',NULL,'',2723546817654806536,1,0);
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (2,'BLANK','6.0.7',NULL,13,'',1,0,NULL,4174860020257456128,4174860020407560193,4174860020257521664,NULL,1,0,'Blank','','','','','','',NULL,'',132120916145610000,1,0);
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (3,'GLOBAL','6.0.7',NULL,11,'',2,0,NULL,4174860021711529985,1,4174860021711595521,NULL,0,0,'Global','','','','','','',NULL,'',132120916367610000,1,0);
INSERT INTO "info" ("rowid","version","version_min") VALUES (1,'6.7.10.0','6.5.1.0');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (1,3,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (2,3,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (3,4,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (4,4,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (5,5,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (6,5,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (7,5,'Element');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (8,8,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (9,8,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (10,9,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (11,9,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (12,13,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (13,13,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (14,14,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (15,14,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (16,18,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (17,18,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (18,21,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (19,21,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (20,22,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (21,22,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (22,25,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (23,25,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (24,28,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (25,28,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (26,29,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (27,29,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (28,30,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (29,30,'Overrides');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (1,2,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (2,2,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (3,4,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (4,5,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (5,5,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (6,7,5,'Hidden','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (7,9,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (8,11,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (9,13,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (10,15,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (11,17,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (12,19,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (13,21,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (14,23,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (15,25,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (16,27,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (17,29,5,'mofDims','1');
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (1,1,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (2,1,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (3,1,'CONTENT_SONG',6,4,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (4,1,'COPYRIGHT',6,8,3,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (5,1,'CONTENT_SCRIPTURE',6,5,4,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (6,2,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (7,2,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (8,2,'CONTENT_SONG',6,4,2,0.0,0.0,1.0,1.0,NULL,1,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (9,2,'COPYRIGHT',6,8,3,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,2,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (10,2,'CONTENT_SCRIPTURE',6,5,4,0.0,0.0,1.0,1.0,NULL,3,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (11,3,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (12,3,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (13,3,'CONTENT_SONG',6,4,2,0.0,0.0,1.0,1.0,NULL,4,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (14,3,'COPYRIGHT',6,8,3,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,5,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (15,3,'CONTENT_SCRIPTURE',6,5,4,0.0,0.0,1.0,1.0,NULL,6,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (16,4,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (17,4,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (18,4,'CONTENT',6,1,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (19,5,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (20,5,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (21,5,'CONTENT_SONG',6,4,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (22,5,'COPYRIGHT',6,8,3,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (23,6,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (24,6,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (25,6,'CONTENT_SCRIPTURE',6,5,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (26,7,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (27,7,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (28,7,'TITLE',6,6,2,0.0199999995529652,0.0299999993294477,0.959999978542328,0.150000005960464,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (29,7,'SUBTITLE',6,7,3,0.0199999995529652,0.21000000834465,0.959999978542328,0.0750000029802322,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (30,7,'CONTENT_PRESENTATION',6,3,4,0.0199999995529652,0.314999997615814,0.959999978542328,0.65499997138977,NULL,NULL,0,0);
CREATE INDEX IF NOT EXISTS "slide_property_group_Index01" ON "slide_property_group" (
	"link_id",
	"group_name"
);
CREATE INDEX IF NOT EXISTS "slide_property_Index01" ON "slide_property" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "idx_slides_presentation_id_order_index" ON "slide" (
	"presentation_id",
	"order_index"
);
CREATE INDEX IF NOT EXISTS "resource_web_Index01" ON "resource_web" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_video_Index02" ON "resource_video" (
	"file_id"
);
CREATE INDEX IF NOT EXISTS "resource_video_Index01" ON "resource_video" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_text_Index01" ON "resource_text" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_shape_Index01" ON "resource_shape" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_powerpoint_Index02" ON "resource_powerpoint" (
	"file_id"
);
CREATE INDEX IF NOT EXISTS "resource_powerpoint_Index01" ON "resource_powerpoint" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_image_Index02" ON "resource_image" (
	"file_id"
);
CREATE INDEX IF NOT EXISTS "resource_image_Index01" ON "resource_image" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_gradient_color_Index01" ON "resource_gradient_color" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_gradient_Index01" ON "resource_gradient" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_feed_pc_Index01" ON "resource_feed_pc" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_feed_Index01" ON "resource_feed" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_dvd_pc_Index01" ON "resource_dvd_pc" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_dvd_Index01" ON "resource_dvd" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_color_Index01" ON "resource_color" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_audio_Index02" ON "resource_audio" (
	"file_id"
);
CREATE INDEX IF NOT EXISTS "resource_audio_Index01" ON "resource_audio" (
	"resource_id"
);
CREATE INDEX IF NOT EXISTS "resource_Index02" ON "resource" (
	"resource_uid"
);
CREATE INDEX IF NOT EXISTS "resource_Index01" ON "resource" (
	"resource_hash"
);
CREATE INDEX IF NOT EXISTS "presentation_property_group_global_Index01" ON "presentation_property_group_global" (
	"link_id",
	"group_name"
);
CREATE INDEX IF NOT EXISTS "presentation_property_group_Index01" ON "presentation_property_group" (
	"link_id",
	"group_name"
);
CREATE INDEX IF NOT EXISTS "presentation_property_global_Index01" ON "presentation_property_global" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "presentation_property_Index01" ON "presentation_property" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "presentation_Index01" ON "presentation" (
	"presentation_uid",
	"presentation_rev_uid"
);
CREATE INDEX IF NOT EXISTS "idx_presentations_group_level_order_index" ON "presentation" (
	"group_level",
	"order_index"
);
CREATE INDEX IF NOT EXISTS "file_Index01" ON "file" (
	"file_hash"
);
CREATE INDEX IF NOT EXISTS "element_property_group_Index01" ON "element_property_group" (
	"link_id",
	"group_name"
);
CREATE INDEX IF NOT EXISTS "element_property_Index01" ON "element_property" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "element_Index01" ON "element" (
	"slide_id",
	"order_index"
);
COMMIT;
