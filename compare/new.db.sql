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
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (1,2,'Master','MASTER',NULL,0,2083,NULL,'SONG',NULL,NULL,4517464071818756567,6205172820872874748,6625214104710181367,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (2,1,'','7-978F05B2-148A-BF33-CA14-CBD345549F4B',NULL,0,2083,2,'MASTER',NULL,NULL,2745845200228343670,1184875263185863242,1184875263185863242,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (3,1,'','1-C8BCA256-E4E6-805B-B585-9FDA49B555C3',NULL,1,2083,2,'MASTER',NULL,NULL,3864475152356710800,4800885155323133242,4800885155323133242,NULL);
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (1,1,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

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

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

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
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (1,NULL,'1-E5FC291A-445D-8DCC-0AAF-8D36D9CC60ED',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (2,NULL,'C-0C1ED8BE-34B2-9E11-88CF-ED2D66955C93',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (3,NULL,'4-17B91C42-2409-8C2C-C1BC-2AF591F0F521',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (4,NULL,'6-8DFA4258-94A8-9886-FE29-A82496EA5CFE',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (5,NULL,'3-958A6DEB-745F-8E75-53A5-FE00D9F19419',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (6,NULL,'3-17E1EE32-E412-897F-D9C5-A8216A7B2F84',6,'','','','','');
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (1,NULL,NULL,NULL,6,'',0,0,NULL,NULL,NULL,NULL,NULL,0,0,'mijn test','','','','','','',NULL,'',NULL,1,0);
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (2,'BLANK','6.0.7',NULL,13,'',1,0,NULL,NULL,NULL,NULL,NULL,1,0,'Blank','','','','','','',NULL,'',132120916145610000,1,0);
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (3,'GLOBAL','6.0.7',NULL,11,'',2,0,NULL,NULL,1,NULL,NULL,0,0,'Global','','','','','','',NULL,'',NULL,1,0);
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
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (3,1,'CONTENT_SONG',6,4,2,0.0,0.0,1.0,1.0,NULL,1,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (4,1,'COPYRIGHT',6,8,3,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,2,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (5,1,'CONTENT_SCRIPTURE',6,5,4,0.0,0.0,1.0,1.0,NULL,3,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (6,2,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (7,2,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (8,2,'CONTENT_SONG',6,4,2,0.0,0.0,1.0,1.0,NULL,4,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (9,2,'COPYRIGHT',6,8,3,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,5,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (10,2,'CONTENT_SCRIPTURE',6,5,4,0.0,0.0,1.0,1.0,NULL,6,0,0);
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
