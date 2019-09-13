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
INSERT INTO "slide_property_group" ("rowid","link_id","group_name") VALUES (1,1,'TransitionIn');
INSERT INTO "slide_property" ("rowid","group_id","value_type","key","value") VALUES (1,1,5,'@changed','1');
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (1,2,'Master','MASTER',NULL,0,67,NULL,'SCRIPTURE',NULL,NULL,4173800388819120129,4173800388819316737,4173799954707382272,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (2,1,'Genesis 1:1 (NBV)','1-018CE32B-8E5E-4C12-98B3-7EA2EC39496F',NULL,0,67,2,'MASTER',NULL,NULL,4174854590104756225,4174854590104821761,4174854590104821761,X'ffd8ffe000104a46494600010100000100010000ffdb0043000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f171816141812141514ffdb00430103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc000110800c0012003012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fccff087c31f18fc418ee64f0b784f5cf12c76a55677d234d9ae8445b3b4398d4edce0e33d706b2fc45e1bd5fc21ac5c693aee957ba2eab6fb7ceb1d46ddede78b72865dc8e030cab29191c820f7afb83fe08e7e2bd66c7f69fb8f0fdbea9770e877fa3dcdcdd69c92b0827963da23774e85977b609e9b8d3ff679f02f82fe3cdafed4ff0011fe33e97a9fc40d4fc216d05f5adc36af3dbdd108b76a5048ad83f25b4280bab8508303d403e0bae9ecbe18f8af52f87fa878e6d740be9fc21a7dd0b2bbd692226da19cecc46cfd031f323e3fda15f517edc1f07fe18e87f06be087c52f869e159bc116de35b2b937ba2bdfcb7a91bc622da449212491b9c1230186d380739f4bfd9735cf09786ffe097bf13f52f1c786ae7c61e1cb7f1e42f3e896da81b1374db34ed8ad32ab32aeec13b46481804673401f9d7525bdbcb7771141044f34f2b048e28d4b33b1380001c924f6afd5ad4bfe09f7f0775bfda246a763a63695f0f22f87d1f8c24f0d5ceaf25bc4f72f248aa925d31678a0da9b9d81ca9190769c5713ab7c3af805e11f187c08f1a787edfc11278c7fe134b4d3757f067837c6efa9dac91cace2def55cb1954c522c2e5400ac4ed6eb9a00fce0d4f4bbdd16fa5b2d42d27b0bc8b1e65bdcc4d1c899008cab00464107f1aded47e18f8af48f01695e36bdd02fadbc25aacef6d63ac491116f732a970c88fdc831b823fd935f59ff00c156fc57e0ed43f69af15e87a6f814693e2fb1b9b47d4fc55fdaf34dfda71b5840513ecac3cb876064195393b327a9af5cf0f788fe1ff86bfe09b7fb3acdf117c0971f10b46b8f15df5b47a643aa49622377bbbf06526352d2155dd88f2a0923278a00fcc9a2bf58356ff8275fc28f87ff00133e33f886eedf4dbff0af86edb4f9b44d03c47e20934ed3ede6b95cbfdb2ec7ef046ac06c04f21b0c49c1ae46d3f635f809f173f691f845a678535ad00699abe997b7be2df0bf84bc4dfdab0db4f6c91b2a453ee322a4ad2919383b626dbb4f2003f3340c9c5753f117e16f8b7e11ebd1e8be33f0f5ff0086b569205ba4b3d4613148d13332ab807b128c33ec6bedbf883f0d7e04fc48fd903e38fc4af057c257f016bbe0ed72d747d3e76d7af2e8b21bbb58da5689dc22b324ae0a90f82720e466bdc7c55fb287c2ff00197edfbaaf837c4fa3eabe20f0cd9fc31fedb8edf50f10ea1713a5cadeaa0759e49da4c0577010b6ccb13b73401f915457db7f1f3e14fc1ef14fec35e16f8cbf0e3c0f77e02d513c46742bbb5b8d5a5d40dd46125cbbb3e06f2511b2aaa0659704608a3ff04f5f82bf09be2dd8f8edfc66ba36bbe3ab28e11e1cf0b78875c9349b3bc2dbb7b9922f9dc8200daa0819191f302a01f19574ff000ffe18f8afe2b6ad75a5f83f40bef116a36b6af7b35b69f1191e3815955a42074505d467fda15f7c785ff62cf06eadfb4cf8ed3c79f0d6efc01e15f05f844788eefc1ba5eb925fa6a4e0b8df05d13e6185c46e700ab061b78c1aeaff00e09dff0011fe137c42f8fdae4de05f8552fc32bcb7f05eacba9436dadcda843776e6e6c3ca2a66e5245c480e060e41f6001f987a0e85a878a35cd3b46d26ce5d4355d46e23b4b4b48177493cd23054451dcb31000f7ab9e33f056bbf0efc4d7be1df1369575a26b964556e6c2f23292c45943a8653d32aca7e8457e83699f04fe0b7c47f843f01be29780bc11a97802eaebe26699e19d42d86bd737135cc0d71b59fcf0cac921da8c1e208549603a291d85dfec77f0f356f8dff00b4978c3c4915b6afa4782eeb4fb2d2b4cf16f8a2e6d6cda696d616696f6fe4779b62ee40b9739c95e9b7001f95f457e9445fb307ecf7e34fdaabe03691e1e93c37abe91e2bb5d493c57e12f0c78a64d4ad6caeadec5e68da3b84904ca8cfc8c95cf95d3048ac6f17fc08f81df127e027ed0b73e0bf87977e03f137c26d564861d5e6d727be1a946b3c8a43ac9855cac4e02004a9319de72d900fcfbd2748bfd7f52b7d3b4cb2b8d4750b86d90da5a44d2cb2b7a2a28249f602ba6f1a7c18f883f0dece2bbf16f817c4be17b498ed8e7d6748b8b48dcfa06911413ed5f6affc135e33e0af807fb487c4df0d5ac37bf11fc3da2ac7a5bbc4b2c965118a691a44520e7263dc4743e401ea0def10f823e2e7c50fd90b5cf12cff00b45da7c47f096b977a3d96ada2dec725c3e9f7b3ddda15884ae4f94d134d1ee0b852b918e84007e75d5ad2b4bbbd7354b3d374fb792eefef264b7b7b78865e591d82aaa8ee49200fad7ea50fd95ff679b9fda4ee7f6604f877a945ab45e1ff00b62fc43feda9cde1bbf204bb8dbffa9d9b5ba636ee18dbdeb90f879f053e13fecc5f0dbe056bfe2df0349f113e2078f3c5090c1a9aeb13d9dbe9222bb554788479572b98db6bafcc4be48002d007e7b78dfc0be20f86be27bdf0e78a748bbd075db2d9f68d3ef6331cb16f45913729e9947561ec4547e0ff00076b7f103c4963e1ff000e69773ad6b77cc52dac2cd37cb33052c428efc027f0afa4ff00e0a91ff27d7f12fe9a67fe9b2d6bec2f82bf0a7e11fecc1f1bbf66ef06c7e039fc45f127c53a6ff6e5c78d65d5e6896ce47b7972b1dbae63917891769030bb492cc72003f2835ed0b50f0beb9a8e8dab59cba7eaba75c496977693aed9209a362ae8c3b1560411ea2a8d7ea63fecbdf0fae25f8dbf17fc6763e18d7f55bdf89fad693a7d978cbc4d2687a55b449792ee66963e5e6621f084e30011d0e7e3afdb97e1c7c2ef86ff0018eda1f843af699acf84f52d2e1be6834ad597538b4fb92f22496e260cc481b15c6e3bb0fe98a00f1fd47e18f8af48f01695e36bdd02fadbc25aacef6d63ac491116f732a970c88fdc831b823fd935cc57ea1f81353f87761ff04eefd9ae1f893e0cb9f1ce8f7fe30bbb1874f83527b248a596f6f97ce7283748114b11182a09c64e2b2f4cfd813e1a4bfb6efc5cf0ddc4257e1df833418b5f8345bad51ed92479608dc4335d1cba40ac6525f3b946cc9383900fcd0a2bf533c33fb2cfece1f13fe227c1d8604f048d6f53d5afac3c45e0cf05f8d65d52dae2d974fbc9e1b857120990abc10e7695197c1cf7c7d6fe0f7ecc83e037c56f1e43f08b58b75f859e307d1a7b48bc513f9badafda62802c92b0611464ce0e15778118c392c4d007e65d5dd0f44bff00136b7a7e8fa55a4b7faa6a1711da5a5a40bba49a69182a228ee5988007a9afd26f18fec1ff000bfc65fb6b7c2cf0bf872c6ebc31e02f14784d7c517fa44578f248bb7cccc5148e5986fc440f2703795c718dbb1f82ff0000edf5cf056b5e1f9fc01e11f887a0fc42d0d74cd27c29e396d664d4ec8ea56d1b2cd1cadb84ca1ddcec1ff2cf938c8001f995e31f066b9f0f7c4b7de1ef12e9773a2eb762ca9736178852584950c032f6cab03f8d6357d2ff00f0525ff93dcf8a5ff5f76dff00a47057cd1401ee1fb33fed77e2efd952e356baf07e8de1abdbfd47606bed6b4e3717102a860522915d4a2b6ef9877dabe957bfe1b4fc6b0c9f173ec3a2f85f49b7f89d656f61ad5a69da6b410429142f0836c8b262366123b313bb2c49f5ae6fe03fecd5e24f8f90f88f51b0d4747f0df863c35025c6b3e23f10dd1b7b2b257242292aacccedb5b0aaa7a738c8cfae69bff04d0f89baff00c42d37c33a3ebbe12d4ecf57f0f4de26d27c450ea129d3b50b48e4863711b884b0901b888e1940c37dea00f1af88bfb45f8a7e27fc29f00fc3ed5e1d39342f05472c7a63dac0c93b0936eef358b90df74630051a1fed15e29f0ffecf7e21f8376d0e9c7c25ae6aa9ac5d4b240c6ec4ebe4e023efda17fd1d382a7bf3cf1d97c73fd8a3c63f027e15e81f10ef3c41e16f15786755bbfecf377e17d4beda96d73b5cf96ee1029ff56ea4a16019483db3c77ece7fb38f8b7f69df1f37857c242ce09a0b67bebdd435294c56b656ea403248c031c65940001249e9804800f446ff0082847c5b8be227863c676771a4e9fa9e83a02f8652082c89b6bcb00dbbcbb88dddb7e580390579518c5627c4ff00db1bc45f11b4bd22c34ef04f80be1dc5a66b106bd1c9e09d0469f24b7b0ab88a5918bbeedbe63903a64d7d03f19bf635d07c1dfb177c373e175f0df8ebe256b9e3d5d0a3f12f84afdaee0d45255bcf2e057242f0c9103c0c14eb8e4f92f8e7fe09f5e34f07783fc63abda78bbc19e29d53c1708b8f13787b42d49e6bed2a3c1259d5a3556da158b61b8dadd71401c6fed1bfb5b7893f69e5b19bc55e17f07e9facc122c971aee87a49b6d42fcac7e5a8b898bb17555c617803031d2ba9f853fb7f78efe13fc34f0a7816dbc2fe08f11685e18b996f74d1e22d18de4b0dc492c92f9a1bcc1b5d5a57dac81481c73ce7c8fe0c7c275f8c3e29b9d224f187863c0f6f6d66f7b2eabe2cbf3696bb55d1362b0562d21320c281ce0fa57a37c5afd8b3c55f09a7f00dd4be28f097883c2be36bc5b2d2bc57a3ea4d2698b21754266919018d577124804008fdd48a009fc31fb7b7c59f0efc4bf1978cee6fb4cf11cde3148e2d7746d734f5b8d36fa28d4a451b41918544250052382412726ba0f0a7ed8da978afe387c34d5ee9fc2bf02f44f0cdc5db437de05f0cedb7b4fb4c4ab34925a82e67dfe5c6a57d09c60f359de38fd847c43e1df859e22f1f786be20f80be25689e1cd9fdb29e11d59eea6b30cd80e54c6a0af539ce4804804038def895ff0004c5f8bbf0c2dddef750f09ea77524b65058d869baa3b5d6a12dd5c25ba24113c48c76348a5d9f6a8524863820007b7fed6bfb6a781bc41fb2ef8abe1c68fe3eb5f89de28f166a76f73717fa3f8524d02cac618e6866394932d248cf08cb1662779e542807e7b97fe0a2bf14a5f8d77bf145acfc39ff000925df86cf85a48c594bf66fb21944b909e6e7ccdc07cdbb18ed5f40fc36ff00827d68bf0b3e197ed06ff11355f04f8dbc55a0f832e2fed2c345d5249ef341bc5b5b8915a68f6a6d2711952410769e31d7c0bc03ff0004f1f1cf8db45f0acb75e2bf06f85bc45e2db23a8f87bc2fadea4f16a3a95bed2e245448d950328caee604f390306803caae3f68bf14dcfecf36df065e1d3bfe112b7d58eb492881bed7e790c305f7eddbf31e36e7deb43e0afed2fa87c18d0352d0cf81bc0de3bd26f6e96f7ecbe34d17edeb04c176ef888742a48001e70715e5de21d0350f0a6bfa9e89ab5b3d96a9a6dccb67776d263745346e51d0e3b86523f0acfa00fa307edfbf1857e3d4bf169758b35f10cb6234a7b01683fb3dac41dc2d4c39cf97bbe6fbdbb7127766ba3d3ffe0a3de3cf0ef8862d57c33e06f873e0f0b617b60d63e1fd01ad2da5174d034d2baacd9693fd1a30189c019e39af9428a00f6df067ed77e38f02fc30f0af80f4eb7d21f44f0df89edfc5b64f3db3b4cd7b0c9bd03b090031e7aa800fbd747a2fedf5f13f44f8afe38f1cac7a05eb78d5228f5ff0f5fe9de7e937cb1c62340f0b396e172387e7737638af9be8a00fb53e027edb5a5ea1fb547c26f1378e743f077c32f03f845f557f27c19a0496b6d1bdd593c4cef145e648ecceb0ae4038f61935ca7ed23fb7578a3e28699e33f00f87acbc33a0780354d72e2f259fc39a37d82e35a8c4e5e196e89396660b1b31da8c48f9bd2be56a2803d37e00fed1de3bfd9a3c5f2788bc0baaad85cdc45f67bbb5b8884d6d771673b258cf5c1e411861ce08c9cfa5fc5dfdbf3c79f16be1b6ade045f0cf827c15e1cd5eea3bdd46dfc25a31b36bb9d248e4595d9a473bf7451e586090a06715f33d1401f5b49ff0537f8b72694eff00d9be104f19be9bfd92fe3e4d140d79adbfb9f68dfb7af3f73af3d79ae7be177edfbf11fe15fc2ed1fc096da5f853c43a5e897bf6ed1eebc47a40bdb9d324f30c87c862c157e666c3152cbb8ed61c63e6aa2803bbf8e7f19b5efda0fe296b5e3ef13c76516b9ab791f684d3e268e01e5411c2bb559988f9625cf279cd7bbf83bfe0a5ff0015bc1de19f06694ba4783b58bdf09422d74bd7757d17ed1a8c56e136087cede36aed0a0940ac428cb1e73f26d1401f47782bf6f1f887e0fbef1c8bad2fc2de2cf0f78cf59b8d7f55f0bf89749fb6e96d7933ef791232e1979db81bcfdc5ce48cd79a7c6ff8d9a9fc75f14586b3a8e85e1ef0d4761609a6d9e95e17d3858d8dbc0b24920548813cee95c9249ebed5e7945007afcdfb51f8c27f83be02f868d0697ff08f782f576d6f4c905bbfda1a732cb2912b6fc32ee99f80a0e31cd7532fede1f1507ed09a87c63b4b9d334ff14ea3649a75f5adbd99363756ca88be54913b312a7cb427e6ce464115f3bd1401f5447ff050ff0019695e23f0eeb1e1af87df0d3c17368ba8beaa90f86fc386ce3bbb86b5b8b5dd3e252cf88eea5c00c06483ce2bcfee3f6b2f1adcfc31f897e047b7d27fb17e206b5fdbdabb8b67f392e3cf8e7c42dbf0a9ba25e08638cf35e2f45007be7897f6dbf89de21f891e01f1d437761a2f88fc13a6c7a4e9771a6db15536ea194acaaece1f72bb2b74041e95d4f883fe0a13e30d6a44bab4f87bf0cfc3babbea565aadeeb1a2786fecf7ba84d6b7715dc7e7cbe692c0cd0a3301b49e7919af96a8a00ed3e337c5ad6fe3afc4dd77c75e238ed22d6b589125b94b08da384158d631b559988f950773ce6b8ba28a00fb47f60afdacbc31f05fc09f117e1f78ab5dbcf0545e26305ce9de2db2d263d4c69f708083e75b3ab7988404c00a7a3742430f7ff027edb5f0fbc11f13b4fbaf157c7dd47e29e9f6fe15d674d5bf5f05ff00645ada4d71369ed0c50c1142242596de62cce4a8d898c64e7f2be8a00faa750f8f1e0db8ff008274e99f09d35295bc6f078b8eacf606da4d82db6c83779bb76672c38ce79a7ffc13f3e3ff0082be0bf8b7c77a2fc42bcbad23c2be34f0f4da2cfac59c0f34964edc072a80b6ddacff007413bb6f18c91f29d1401fa2edfb587c1bf811f037e0f784be1ff8a751f8837be06f8829afdd7daf46934f6bbb32978b2bc61f2aa7170a14336ece0903040e83e38fed87e0cf18e81f11355f0e7ed29abdbe9de23d26f61b7f87abf0fade2b932cd03aadbcda81848316f6c16c97da4e1f77cd5f99145007d4dff04fcf8aff000bbe137c43f145f7c497834ab8bbd165b6d07c4775a41d523d26f09e26fb38562cdd3040fe12a480c4d7d01f17ff006c5f841e3af0cfc03d27c4fe2bbdf8b23c2be297bdf135c5ef878d80bcb6dd28593ecf8f2ca00c988812591406009207e6cd1401fa9df17ff6d8f851a8fc24f8f3e14d3be2acde2ab6f13d82c7e15d16dbc22fa5da6968438fb323840646195dcf22a8e1704e5b1e43fb47fed8fe04d77f6f5f86ff0017fc277371e20f0bf87ed6c22bcff4492094ec966f3951250a4b04972a7a138e6be0fa2803f4e35afda2ff00671f0949fb4deb7e1bf895ab6bfac7c58f0ede25b69f3e81730c569752c170a20f35972c4c930e4aaa28c0dcd826b4acbf6f1f07fc48f037802ee1f8e97df02fc49a0693069faae96de058b5c4bc923500cb6d3796e62cf380cd8008f972096fcb5a2803e88f1eea7f073c6fe09f8bde2bd43c53afeabf16afbc5b3dc7878dcdb0862d434e9278d8dc5c2c7088d256569d8a828010005e80fcef4514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451401ffd9');
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (3,3,'Master','MASTER',NULL,0,19,NULL,'',NULL,NULL,4174854588370452480,4174854588400820225,4174854588370518016,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (4,3,'Song','SONG',NULL,1,2083,NULL,'MASTER',NULL,NULL,4174854588370583552,4174854588401016833,4174854588370649088,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (5,3,'Scripture','SCRIPTURE',NULL,2,67,NULL,'MASTER',NULL,NULL,4174854588370714624,4174854588401213441,4174854588370780160,NULL);
INSERT INTO "slide" ("rowid","presentation_id","title","slide_uid","slide_rev_uid","order_index","layout_flag","theme_id","theme_slide_uid","modified_theme_id","modified_theme_layout_revision","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail") VALUES (6,3,'Presentation','PRESENTATION',NULL,3,143,NULL,'MASTER',NULL,NULL,4174854588370845696,4174854588401410049,4174854588370911232,NULL);
INSERT INTO "resource_text" ("rowid","resource_id","rtf") VALUES (1,1,'{\rtf1\ansi\deff0\sdeasyworship2
{\fonttbl{\f0 Tahoma;}}
{\colortbl ;}
{\pard\ql\qdef\sdewparatemplatestyle201\plain\sdewtemplatestyle203\fs32{\*\sdfsreal 16}{\*\sdfsdef 16}\sdfsauto\sdignorespelling 1\u160?\sdewtemplatestyle201\fs60{\*\sdfsreal 30}{\*\sdfsdef 30}\sdfsauto\nosupersub\sdstrokewidthf\sdshadradiusf\sdshadoffsf In het begin schiep God de hemel en de aarde. \par}
{\pard\sdparawysiwghidden\ql\qdef\sdewparatemplatestyle202\plain\sdewtemplatestyle202\fs60{\*\sdfsreal 30}{\*\sdfsdef 30}\sdignorespelling Genesis 1:1 (NBV)\par}
}');
INSERT INTO "resource" ("rowid","resource_hash","resource_uid","resource_type","title","author","copyright","description","tags") VALUES (1,1457561616,'1-0B0CF6F7-B911-4732-B19F-00CBEC37BD78',6,'','','','','');
INSERT INTO "presentation_property_group_global" ("rowid","link_id","group_name") VALUES (1,3,'Default_Scripture_BK');
INSERT INTO "presentation_property_group_global" ("rowid","link_id","group_name") VALUES (2,3,'Scripture_Attributes');
INSERT INTO "presentation_property_group_global" ("rowid","link_id","group_name") VALUES (3,3,'Text_Attributes');
INSERT INTO "presentation_property_global" ("rowid","group_id","value_type","key","value") VALUES (1,1,6,'FileType','11');
INSERT INTO "presentation_property_global" ("rowid","group_id","value_type","key","value") VALUES (2,1,1,'ID','48');
INSERT INTO "presentation_property_global" ("rowid","group_id","value_type","key","value") VALUES (3,2,5,'Show_Reference','0');
INSERT INTO "presentation_property_global" ("rowid","group_id","value_type","key","value") VALUES (4,2,5,'One_Verse_Per_Slide','0');
INSERT INTO "presentation_property_global" ("rowid","group_id","value_type","key","value") VALUES (5,3,2,'Minimum_Size_Limit','0.116666666666667');
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (1,'1-56B3F016-9C18-444F-8924-0655A524DB4F','1-56B3F016-9C18-444F-8924-0655A524DB4F',NULL,7,'',0,0,NULL,4174854590103576577,4174854590103642113,4174854590103642113,X'ffd8ffe000104a46494600010100000100010000ffdb0043000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f171816141812141514ffdb00430103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc000110800c0012003012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fcaaa28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a28a2803ffd9',0,0,'Genesis 1:1 (NBV)','','','','','','',NULL,'',132120087570010000,1,0);
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (2,'1-634AF657-4CF1-411F-B80C-862877F56B01','1-01F07EC4-4843-4E9F-9B71-8BDC10CD4007',NULL,14,'',1,0,NULL,4173800389014810625,4173800389014876161,4173799954707251200,NULL,1,0,'Sander','','','','','','',NULL,'',131959265248929984,1,0);
INSERT INTO "presentation" ("rowid","presentation_uid","presentation_rev_uid","presentation_global_uid","presentation_type","aspect_ratio","group_level","order_index","thumbnail_slide_id","layout_revision","thumbnail_desired_rev","thumbnail_rev","thumbnail","auto_theme","looping","title","author","copyright","administrator","description","tags","reference_number","vendor_id","notes","modified_date","ready","error_no") VALUES (3,'GLOBAL','1-F69AE437-B115-4B0F-9C8B-3E095824D864',NULL,11,'',2,0,NULL,4173800390360199169,4174854588400623617,4173799969004854273,NULL,0,0,'Global','','','','','','',NULL,'',131959201161130000,1,0);
INSERT INTO "info" ("rowid","version","version_min") VALUES (1,'6.7.10.0','6.5.1.0');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (1,1,'Element');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (2,2,'Element');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (3,3,'Text_Style_202');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (4,3,'Text_Style_201');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (5,3,'Text_Layout');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (6,3,'Text');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (7,3,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (8,3,'Text_Style_203');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (9,3,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (10,3,'Element');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (11,6,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (12,6,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (13,6,'Element');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (14,7,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (15,7,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (16,8,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (17,8,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (18,9,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (19,9,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (20,9,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (21,9,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (22,10,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (23,10,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (24,11,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (25,11,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (26,12,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (27,12,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (28,12,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (29,12,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (30,13,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (31,13,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (32,13,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (33,13,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (34,14,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (35,14,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (36,15,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (37,15,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (38,16,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (39,16,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (40,16,'Text_Style_203');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (41,16,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (42,16,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (43,17,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (44,17,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (45,18,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (46,18,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (47,19,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (48,19,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (49,19,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (50,19,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (51,20,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (52,20,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (53,20,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (54,20,'Foreground');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (55,21,'Background');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (56,21,'Text_Format');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (57,21,'Overrides');
INSERT INTO "element_property_group" ("rowid","link_id","group_name") VALUES (58,21,'Foreground');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (1,3,2,'Font_Size','0.0833333333333333');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (2,3,6,'Text_Alignment','0');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (3,3,5,'@changed','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (4,4,2,'Font_Size','0.0833333333333333');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (5,4,6,'Text_Alignment','0');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (6,4,5,'@changed','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (7,5,6,'Vertical_Alignment','0');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (8,5,5,'@changed','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (9,6,5,'@mofChanged','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (10,6,5,'@changed','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (11,7,6,'Auto_Size','0');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (12,7,5,'@changed','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (13,8,2,'Font_Size','0.0444444444444444');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (14,8,6,'Text_Alignment','0');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (15,8,5,'@changed','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (16,9,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (17,9,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (18,11,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (19,13,1,'ScriptureRangeID','3892240393181331456');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (20,20,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (21,28,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (22,28,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (23,32,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (24,32,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (25,40,5,'Hidden','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (26,40,5,'@changed','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (27,41,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (28,41,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (29,49,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (30,49,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (31,53,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (32,53,5,'mofDims','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (33,57,5,'mofText','1');
INSERT INTO "element_property" ("rowid","group_id","value_type","key","value") VALUES (34,57,5,'mofDims','1');
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (1,1,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (2,1,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (3,1,'CONTENT_SCRIPTURE',6,5,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (4,2,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (5,2,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (6,2,'CONTENT_SCRIPTURE',6,5,2,0.0,0.0,1.0,1.0,NULL,1,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (7,3,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (8,3,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (9,3,'CONTENT',6,1,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (10,4,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (11,4,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (12,4,'CONTENT_SONG',6,4,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (13,4,'COPYRIGHT',6,8,3,0.0,0.9200000166893,1.0,0.0799999982118607,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (14,5,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (15,5,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (16,5,'CONTENT_SCRIPTURE',6,5,2,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (17,6,'BACKGROUND',0,0,0,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (18,6,'AUDIO',5,0,1,0.0,0.0,1.0,1.0,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (19,6,'TITLE',6,6,2,0.0199999995529652,0.0299999993294477,0.959999978542328,0.150000005960464,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (20,6,'SUBTITLE',6,7,3,0.0199999995529652,0.21000000834465,0.959999978542328,0.0750000029802322,NULL,NULL,0,0);
INSERT INTO "element" ("rowid","slide_id","element_uid","element_type","element_style_type","order_index","x","y","width","height","background_resource_id","foreground_resource_id","internal_mute","from_master") VALUES (21,6,'CONTENT_PRESENTATION',6,3,4,0.0199999995529652,0.314999997615814,0.959999978542328,0.65499997138977,NULL,NULL,0,0);
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
