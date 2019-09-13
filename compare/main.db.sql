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
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (1,1,'Master','MASTER',NULL,0,19,NULL,'',NULL,NULL,4174831049496395776,4174831049553671169,4174831049496461312,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (2,1,'Song','SONG',NULL,1,2083,NULL,'MASTER',NULL,NULL,4174831049496526848,4174831049553867777,4174831049496592384,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (3,1,'Scripture','SCRIPTURE',NULL,2,67,NULL,'MASTER',NULL,NULL,4174831049496657920,4174831049554064385,4174831049496723456,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (4,1,'Presentation','PRESENTATION',NULL,3,143,NULL,'MASTER',NULL,NULL,4174831049496788992,4174831049554260993,4174831049496854528,NULL);
INSERT INTO "presentation_property_group_global" ("rowid","link_id","group_name") VALUES (1,1,'Default_Scripture_BK');
INSERT INTO "presentation_property_group_global" ("rowid","link_id","group_name") VALUES (2,1,'Scripture_Attributes');
INSERT INTO "presentation_property_group_global" ("rowid","link_id","group_name") VALUES (3,1,'Text_Attributes');
INSERT INTO "presentation_property_global" ("rowid","group_id","value_type","key","value") VALUES (1,1,6,'FileType','11');
INSERT INTO "presentation_property_global" ("rowid","group_id","value_type","key","value") VALUES (2,1,1,'ID','48');
INSERT INTO "presentation_property_global" ("rowid","group_id","value_type","key","value") VALUES (3,2,5,'Show_Reference','0');
INSERT INTO "presentation_property_global" ("rowid","group_id","value_type","key","value") VALUES (4,2,5,'One_Verse_Per_Slide','0');
INSERT INTO "presentation_property_global" ("rowid","group_id","value_type","key","value") VALUES (5,3,2,'Minimum_Size_Limit','0.116666666666667');
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (1,'GLOBAL','1-F69AE437-B115-4B0F-9C8B-3E095824D864',NULL,11,'',2,0,NULL,4173800390360199169,4174831049553474561,4173799969004854273,NULL,0,0,'Global','','','','','','',NULL,'',131959201161130000,1,0);
INSERT INTO "info" ("rowid","version","version_min") VALUES (1,'6.7.10.0','6.5.1.0');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (1,1,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (2,1,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (3,2,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (4,2,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (5,3,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (6,3,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (7,3,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (8,3,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (9,4,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (10,4,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (11,5,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (12,5,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (13,6,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (14,6,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (15,6,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (16,6,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (17,7,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (18,7,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (19,7,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (20,7,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (21,8,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (22,8,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (23,9,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (24,9,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (25,10,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (26,10,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (27,10,'Text_Style_203');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (28,10,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (29,10,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (30,11,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (31,11,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (32,12,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (33,12,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (34,13,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (35,13,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (36,13,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (37,13,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (38,14,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (39,14,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (40,14,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (41,14,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (42,15,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (43,15,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (44,15,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (45,15,'Foreground');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (1,7,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (2,15,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (3,15,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (4,19,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (5,19,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (6,27,5,'Hidden','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (7,27,5,'@changed','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (8,28,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (9,28,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (10,36,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (11,36,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (12,40,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (13,40,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (14,44,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (15,44,5,'mofDims','1');
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (1,1,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (2,1,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (3,1,'CONTENT',6,1,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (4,2,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (5,2,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (6,2,'CONTENT_SONG',6,4,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (7,2,'COPYRIGHT',6,8,3,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (8,3,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (9,3,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (10,3,'CONTENT_SCRIPTURE',6,5,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (11,4,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (12,4,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (13,4,'TITLE',6,6,2,0.0199999995529652,0.0299999993294477,0.959999978542328,0.150000005960464,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (14,4,'SUBTITLE',6,7,3,0.0199999995529652,0.21000000834465,0.959999978542328,0.0750000029802322,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (15,4,'CONTENT_PRESENTATION',6,3,4,0.0199999995529652,0.314999997615814,0.959999978542328,0.65499997138977,NULL,NULL,0,0);
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
