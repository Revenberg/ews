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
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (1,2,'Master','MASTER',NULL,0,2083,NULL,'SONG',NULL,NULL,1575420714821615587,2518624753370454507,4011834106025527021,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (2,1,'','9-3F2F43C9-B416-A765-270B-4F328ED75AE0',NULL,0,2083,2,'MASTER',NULL,NULL,586263775616243632,1888633375202780122,1888633375202780122,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (3,1,'','F-E79D3896-8471-952A-B794-E61E208FB4EB',NULL,1,2083,2,'MASTER',NULL,NULL,8423067326341622370,6301032533750228345,6301032533750228345,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (4,1,'','8-AA813FC0-F47F-9B28-50F2-345D19F151C5',NULL,2,2083,2,'MASTER',NULL,NULL,6254280883481170572,1008468177046781478,1008468177046781478,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (5,1,'','2-6D490AC4-7495-964E-E60B-7047A90E896C',NULL,3,2083,2,'MASTER',NULL,NULL,8451545725304137668,6854401000674207072,6854401000674207072,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (6,3,'','3-32241E8F-E4DE-B566-0759-A52B7C875ED2',NULL,0,2083,2,'MASTER',NULL,NULL,5135136128845787200,507774687601801626,507774687601801626,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (7,3,'','2-E7B9587C-F415-A7F2-A4FE-9F02E789C635',NULL,1,2083,2,'MASTER',NULL,NULL,2113831562514667550,3835424112567176828,3835424112567176828,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (8,4,'','5-E90ED1F5-3476-A81F-7163-D057BAC3EC9D',NULL,0,2083,2,'MASTER',NULL,NULL,6261137754083081332,6227145216435125863,6227145216435125863,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (9,4,'','6-5B3BB077-04B9-B1BF-6E93-0A74DF98A5B3',NULL,1,2083,2,'MASTER',NULL,NULL,8605007714376183056,7331384106102045026,7331384106102045026,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (10,4,'','9-0D842A74-1435-A8CE-2124-E5EED8FE52B6',NULL,2,2083,2,'MASTER',NULL,NULL,3424564223450226860,2507113800175083705,2507113800175083705,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (11,4,'','D-C9CF67F7-94F1-8B7D-48EA-146E3199F7AB',NULL,3,2083,2,'MASTER',NULL,NULL,7001113184411713525,6384071008052823647,6384071008052823647,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (12,4,'','C-7A6090E7-F414-9EE8-BF2F-C7D5E578EF42',NULL,4,2083,2,'MASTER',NULL,NULL,4323682028051585005,1138054882305813167,1138054882305813167,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (13,5,'','E-F39343CA-641A-B924-8776-373D5A45729B',NULL,0,2083,2,'MASTER',NULL,NULL,7744275778182413632,1232148372757110111,1232148372757110111,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (14,5,'','9-92391FB9-E43B-84F5-F9B7-6108D23C6868',NULL,1,2083,2,'MASTER',NULL,NULL,5420161761578612254,7250464172554258843,7250464172554258843,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (15,5,'','2-2149FFA0-0462-94E9-0918-1BB47BC9D33F',NULL,2,2083,2,'MASTER',NULL,NULL,8184845011244110638,3478853005056873841,3478853005056873841,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (16,5,'','E-0D076653-E4D6-A64F-E231-46EABE611CE5',NULL,3,2083,2,'MASTER',NULL,NULL,7681723768825782227,4781504102122502616,4781504102122502616,NULL);
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
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (7,7,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 3\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 3\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (8,8,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (9,9,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (10,10,'{\rtf1\ansi\deff0\sdeasyworship2
{\fonttbl{\f0 Tahoma;}}
{\colortbl ;}
{\pard\sdlistlevel-1\qc\qdef\sdewparatemplatestyle300{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle300\plain\sdewtemplatestyle300\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Vers 2\par}
}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (11,12,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 1\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 1\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (12,13,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (13,14,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (14,15,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 2\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 2\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (15,16,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (16,17,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (17,18,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 1\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 1\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (18,19,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (19,20,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (20,21,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 2\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 2\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (21,22,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (22,23,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (23,24,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 3\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 3\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (24,25,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (25,26,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (26,27,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 4\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 4\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (27,28,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (28,29,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (29,30,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 5\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 5\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (30,31,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (31,32,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (32,33,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 1\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 1\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (33,34,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (34,35,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (35,36,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 2\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 2\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (36,37,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (37,38,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (38,39,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 3\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 3\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (39,40,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (40,41,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (41,42,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdparawysiwghidden\sdlistlevel-1\qc\qdef\sdewparatemplatestyle102\plain\sdewtemplatestyle102\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Label 4\par}

{\pard\sdlistlevel0\qc\qdef\sdewparatemplatestyle101{\*\sdasfactor 1}{\*\sdasbaseline 32.4}\sdastextstyle101\plain\sdewtemplatestyle101\fs64{\*\sdfsreal 32.4}{\*\sdfsdef 32.4}\sdfsauto Song 4\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (42,43,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\ql\qdef\plain\fs28{\*\sdfsreal 14.4}{\*\sdfsdef 14.4}\sdfsauto\par}

}');
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (43,44,'{\rtf1\ansi\deff0\sdeasyworship2

{\fonttbl{\f0 Tahoma;}}

{\colortbl ;}

{\pard\sdlistlevel0\qc\qdef\plain\fs40{\*\sdfsreal 20}{\*\sdfsdef 20}\sdfsauto\par}

}');
INSERT INTO "resource_image" ("rowid","resource_id","file_id","original_filename","filesize","modified_date","width","height") VALUES (1,11,1,'<images>001-1_image-00001.png',42694,1567972740002,1744,1216);
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (1,NULL,'6-61A82092-C47C-A7A9-287B-D8C7ECE8650B',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (2,NULL,'A-0FA78A3C-D4E5-919F-FD9F-9C70A4CB8EFD',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (3,NULL,'6-6A822694-143B-8A75-136F-595A20AC058A',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (4,NULL,'E-820D0A73-34B7-89E9-C62E-18E9C464D6AD',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (5,NULL,'1-5978EABE-D41D-A232-B318-CEB1D502914D',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (6,NULL,'2-5010C12B-F45D-9333-8178-DC2CA85D3059',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (7,NULL,'8-D0506058-94A7-983C-9E07-F3512B7AF66D',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (8,NULL,'A-E17068BE-C401-A509-3DEA-5C82FDF34743',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (9,NULL,'E-C4E13118-6441-9AF0-D283-14618C8B2361',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (10,NULL,'C-2B0FABC6-B45E-9A4E-D518-DFB3890EB63B',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (11,NULL,'0-231E6873-B4AE-9A0A-9176-F5DF02B12400',6,'001-1_image-00001.png','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (12,NULL,'1-F9B99AAA-04B3-857E-23CE-669DCCB931FB',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (13,NULL,'B-268E494B-D40E-A7FE-B212-858D6BAD5338',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (14,NULL,'6-4AB428DF-B4EB-A825-25C0-22660419A65A',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (15,NULL,'D-7AE96F7A-F498-9E61-85AB-28328B11A644',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (16,NULL,'B-5E2E8B91-C40B-95C2-6CAC-823B3AFD3317',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (17,NULL,'2-34B38958-7450-B1C6-9363-D319BC892FE3',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (18,NULL,'D-D04E93AD-E445-A882-8A51-4AB96E24E1F1',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (19,NULL,'8-FD3E650B-246B-95BF-E964-C22718DA7CD6',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (20,NULL,'B-7154C459-D445-A9AE-995D-16B841D741D5',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (21,NULL,'E-A58D2182-C44C-BBD4-B554-A8D9D7E6A6F0',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (22,NULL,'C-BC41FA62-D435-AEAA-228E-3DBF2ADF9B64',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (23,NULL,'4-4BB4E482-5449-A761-9FD6-076318519FD9',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (24,NULL,'5-C131E6D4-34CB-8DDF-A93E-45DDA1920022',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (25,NULL,'4-B0A8A53A-14B1-AE8B-AB4F-107F2333136C',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (26,NULL,'0-33D598A3-1408-A68E-EA27-3A7043275D1A',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (27,NULL,'A-AA0FB127-8493-9717-7248-DF7CAE03E8D5',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (28,NULL,'3-B63B5448-44F0-8AFD-BF1F-1FB2A3C3AB82',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (29,NULL,'3-21F40151-B4C5-909C-FDBE-664422FC5FFC',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (30,NULL,'B-8638E219-34B7-935A-7EC5-246066EE8662',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (31,NULL,'0-743820DD-24FA-B04C-5E27-63B0A5351095',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (32,NULL,'4-FB4CD0C2-A484-A51F-1779-DF6B6EC14209',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (33,NULL,'B-6169309B-A46B-97E8-FF02-E50192386C06',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (34,NULL,'2-C9F63856-54A2-84DB-EDD9-FB292165AE2E',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (35,NULL,'7-2CF2277B-0482-851A-300D-DCD6CF31C670',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (36,NULL,'B-5F98D594-B479-9098-3EE7-E4C0CFE743EB',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (37,NULL,'A-F8B2A3AA-E4B2-9E82-A103-3EB851B606AD',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (38,NULL,'8-9C342A5C-A49D-B2E7-27EA-337BD5A25002',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (39,NULL,'B-9ED49241-E4CA-96F5-77EF-3651E9660492',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (40,NULL,'9-F878993B-6426-8F4B-B0F4-7E85F7359CA2',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (41,NULL,'F-11171359-8462-A242-58A4-0201296CE31D',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (42,NULL,'9-CA222CF4-343E-84EE-6CFC-04577048B62F',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (43,NULL,'6-59F4A8FC-F415-BC40-9CFA-C438D35ECB1C',6,'','','','','');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (44,NULL,'B-B2B4916D-B48E-94BB-32D7-A1F7D39D1DFC',6,'','','','','');
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (1,NULL,NULL,NULL,6,'',0,0,NULL,NULL,NULL,NULL,NULL,0,0,'mijn test','','','','','','',NULL,'',NULL,1,0);
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (2,'BLANK','6.0.7',NULL,13,'',1,0,NULL,NULL,NULL,NULL,NULL,1,0,'Blank','','','','','','',NULL,'',132120916145610000,1,0);
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (3,NULL,NULL,NULL,8,'',0,0,NULL,NULL,NULL,NULL,NULL,0,0,'lied 2','','','','','','',NULL,'',NULL,1,0);
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (4,NULL,NULL,NULL,8,'',0,0,NULL,NULL,NULL,NULL,NULL,0,0,'lied 3','','','','','','',NULL,'',NULL,1,0);
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (5,NULL,NULL,NULL,8,'',0,0,NULL,NULL,NULL,NULL,NULL,0,0,'lied 4','','','','','','',NULL,'',NULL,1,0);
INSERT INTO "info" ("rowid","version","version_min") VALUES (1,'6.7.10.0','6.5.1.0');
INSERT INTO "file" ("rowid","file_hash","filename","shared_filename") VALUES (1,'','001-1_image-00001.png',NULL);
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (1,3,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (2,3,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (3,4,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (4,4,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (5,8,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (6,8,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (7,9,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (8,9,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (9,13,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (10,13,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (11,14,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (12,14,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (13,19,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (14,19,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (15,20,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (16,20,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (17,23,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (18,23,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (19,24,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (20,24,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (21,28,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (22,28,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (23,29,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (24,29,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (25,33,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (26,33,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (27,34,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (28,34,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (29,38,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (30,38,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (31,39,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (32,39,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (33,43,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (34,43,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (35,44,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (36,44,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (37,48,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (38,48,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (39,49,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (40,49,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (41,53,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (42,53,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (43,54,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (44,54,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (45,58,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (46,58,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (47,59,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (48,59,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (49,63,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (50,63,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (51,64,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (52,64,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (53,68,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (54,68,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (55,69,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (56,69,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (57,73,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (58,73,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (59,74,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (60,74,'Overrides');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (1,1,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (2,1,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (3,2,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (4,2,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (5,3,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (6,4,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (7,4,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (8,5,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (9,5,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (10,6,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (11,6,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (12,7,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (13,7,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (14,8,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (15,9,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (16,9,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (17,10,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (18,10,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (19,11,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (20,11,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (21,12,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (22,12,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (23,13,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (24,14,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (25,14,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (26,15,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (27,15,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (28,16,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (29,16,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (30,17,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (31,17,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (32,19,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (33,20,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (34,21,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (35,21,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (36,22,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (37,22,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (38,23,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (39,24,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (40,24,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (41,25,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (42,25,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (43,26,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (44,26,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (45,27,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (46,27,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (47,28,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (48,29,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (49,29,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (50,30,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (51,30,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (52,31,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (53,31,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (54,32,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (55,32,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (56,33,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (57,34,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (58,34,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (59,35,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (60,35,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (61,36,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (62,36,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (63,37,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (64,37,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (65,38,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (66,39,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (67,39,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (68,40,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (69,40,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (70,41,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (71,41,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (72,42,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (73,42,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (74,43,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (75,44,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (76,44,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (77,45,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (78,45,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (79,46,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (80,46,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (81,47,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (82,47,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (83,48,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (84,49,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (85,49,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (86,50,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (87,50,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (88,51,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (89,51,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (90,52,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (91,52,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (92,53,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (93,54,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (94,54,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (95,55,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (96,55,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (97,56,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (98,56,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (99,57,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (100,57,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (101,58,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (102,59,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (103,59,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (104,60,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (105,60,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (106,61,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (107,61,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (108,62,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (109,62,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (110,63,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (111,64,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (112,64,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (113,65,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (114,65,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (115,66,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (116,66,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (117,67,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (118,67,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (119,68,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (120,69,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (121,69,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (122,70,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (123,70,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (124,71,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (125,71,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (126,72,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (127,72,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (128,73,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (129,74,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (130,74,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (131,75,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (132,75,5,'mofDims','1');
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (1,2,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (2,2,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (3,2,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,1,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (4,2,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,2,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (5,2,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,3,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (6,3,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (7,3,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (8,3,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,4,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (9,3,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,5,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (10,3,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,6,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (11,4,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (12,4,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (13,4,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,7,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (14,4,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,8,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (15,4,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,9,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (16,5,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (17,5,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (19,5,'TITLE',6,6,0,0.0199999995529652,0.0266660004854202,0.959999978542328,0.150000005960464,NULL,10,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (20,5,'4-1FB4631D-7455-AE44-6771-B5BC900E49D2',2,0,0,0.0199999995529652,0.314999997615814,0.959999978542328,0.65499997138977,NULL,11,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (21,6,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (22,6,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (23,6,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,12,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (24,6,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,13,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (25,6,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,14,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (26,7,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (27,7,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (28,7,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,15,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (29,7,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,16,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (30,7,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,17,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (31,8,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (32,8,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (33,8,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,18,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (34,8,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,19,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (35,8,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,20,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (36,9,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (37,9,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (38,9,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,21,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (39,9,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,22,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (40,9,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,23,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (41,10,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (42,10,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (43,10,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,24,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (44,10,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,25,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (45,10,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,26,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (46,11,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (47,11,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (48,11,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,27,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (49,11,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,28,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (50,11,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,29,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (51,12,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (52,12,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (53,12,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,30,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (54,12,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,31,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (55,12,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,32,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (56,13,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (57,13,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (58,13,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,33,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (59,13,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,34,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (60,13,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,35,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (61,14,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (62,14,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (63,14,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,36,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (64,14,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,37,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (65,14,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,38,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (66,15,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (67,15,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (68,15,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,39,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (69,15,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,40,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (70,15,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,41,0,1);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (71,16,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (72,16,'AUDIO',5,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (73,16,'CONTENT_SONG',6,4,0,0.0,0.0,1.0,1.0,NULL,42,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (74,16,'COPYRIGHT',6,8,0,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,43,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (75,16,'CONTENT_SCRIPTURE',6,5,0,0.0,0.0,1.0,1.0,NULL,44,0,1);
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
