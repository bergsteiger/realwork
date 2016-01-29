(*
Copyright (c) 1998-2004 by HiComponents. All rights reserved.

This software comes without any warranty either implied or expressed.
In no case shall the author be liable for any damage or unwanted behavior of any
computer hardware and/or software.

HiComponents grants you the right to include the compiled component
in your application, whether COMMERCIAL, SHAREWARE, or FREEWARE,
BUT YOU MAY NOT DISTRIBUTE THIS SOURCE CODE OR ITS COMPILED .DCU IN ANY FORM.

ImageEn may not be included in any commercial, shareware or freeware DELPHI
libraries or components.

email: support@hicomponents.com

http://www.hicomponents.com

*)

unit iewia;

{$R-}
{$Q-}


{$I ie.inc}

interface

{$ifdef IEINCLUDEWIA}

uses Windows, Classes, Sysutils, Graphics, hyieutils, hyiedefs;

const

   // Image types
   WiaImgFmt_UNDEFINED:TGUID = '{b96b3ca9-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_RAWRGB:TGUID =    '{bca48b55-f272-4371-b0f1-4a150d057bb4}';
   WiaImgFmt_MEMORYBMP:TGUID = '{b96b3caa-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_BMP:TGUID =       '{b96b3cab-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_EMF:TGUID =       '{b96b3cac-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_WMF:TGUID =       '{b96b3cad-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_JPEG:TGUID =      '{b96b3cae-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_PNG:TGUID =       '{b96b3caf-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_GIF:TGUID =       '{b96b3cb0-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_TIFF:TGUID =      '{b96b3cb1-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_EXIF:TGUID =      '{b96b3cb2-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_PHOTOCD:TGUID =   '{b96b3cb3-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_FLASHPIX:TGUID =  '{b96b3cb4-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_ICO:TGUID =       '{b96b3cb5-0728-11d3-9d7b-0000f81ef32e}';
   WiaImgFmt_CIFF:TGUID =      '{9821a8ab-3a7e-4215-94e0-d27a460c03b2}'; // Canon Image File Format
   WiaImgFmt_PICT:TGUID =      '{a6bc85d8-6b3e-40ee-a95c-25d482e41adc}'; // Quickdraw Image Format
   WiaImgFmt_JPEG2K:TGUID =    '{344ee2b2-39db-4dde-8173-c4b75f8f1e49}'; // JPEG 2000 baseline file format
   WiaImgFmt_JPEG2KX:TGUID =   '{43e14614-c80a-4850-baf3-4b152dc8da27}'; // JPEG 2000 extended file format

   // Document and other types
   WiaImgFmt_RTF:TGUID =       '{573dd6a3-4834-432d-a9b5-e198dd9e890d}';
   WiaImgFmt_XML:TGUID = 		 '{b9171457-dac8-4884-b393-15b471d5f07e}';
   WiaImgFmt_HTML:TGUID = 		 '{c99a4e62-99de-4a94-acca-71956ac2977d}';
   WiaImgFmt_TXT:TGUID = 		 '{fafd4d82-723f-421f-9318-30501ac44b59}';
   WiaImgFmt_MPG:TGUID = 		 '{ecd757e4-d2ec-4f57-955d-bcf8a97c4e52}';
   WiaImgFmt_AVI:TGUID = 		 '{32f8ca14-087c-4908-b7c4-6757fe7e90ab}';
   WiaImgFmt_ASF:TGUID = 		 '{8d948ee9-d0aa-4a12-9d9a-9cc5de36199b}';
   WiaImgFmt_SCRIPT:TGUID = 	 '{fe7d6c53-2dac-446a-b0bd-d73e21e924c9}';
   WiaImgFmt_EXEC:TGUID = 		 '{485da097-141e-4aa5-bb3b-a5618d95d02b}';
   WiaImgFmt_UNICODE16:TGUID = '{1b7639b6-6357-47d1-9a07-12452dc073e9}';
   WiaImgFmt_DPOF:TGUID = 	    '{369eeeab-a0e8-45ca-86a6-a83ce5697e28}';

	// Audio types
	WiaAudFmt_WAV:TGUID =       '{f818e146-07af-40ff-ae55-be8f2c065dbe}';
	WiaAudFmt_MP3:TGUID =  	    '{0fbc71fb-43bf-49f2-9190-e6fecff37e54}';
	WiaAudFmt_AIFF:TGUID = 		 '{66e2bf4f-b6fc-443f-94c8-2f33c8a65aaf}';
	WiaAudFmt_WMA:TGUID =  		 '{d61d6413-8bc2-438f-93ad-21bd484db6a1}';

	WIA_DIP_DEV_ID                           = 2;
   WIA_DIP_DEV_NAME                         = 7;
	WIA_DIP_SERVER_NAME                      = 8;
	WIA_DIP_DEV_DESC                         = 4;
	WIA_DIP_DEV_TYPE                         = 5;
   WIA_DIP_DRIVER_VERSION                   = 15;
	WIA_DIP_PORT_NAME                        = 6;
	WIA_DIP_VEND_DESC                        = 3;

   StiDeviceTypeDefault          = 0;
   StiDeviceTypeScanner          = 1;
   StiDeviceTypeDigitalCamera    = 2;
   StiDeviceTypeStreamingVideo   = 3;

   WiaItemTypeFree                         =$00000000;
   WiaItemTypeImage                        =$00000001;
   WiaItemTypeFile                         =$00000002;
   WiaItemTypeFolder                       =$00000004;
   WiaItemTypeRoot                         =$00000008;
   WiaItemTypeAnalyze                      =$00000010;
   WiaItemTypeAudio                        =$00000020;
   WiaItemTypeDevice                       =$00000040;
   WiaItemTypeDeleted                      =$00000080;
   WiaItemTypeDisconnected                 =$00000100;
   WiaItemTypeHPanorama                    =$00000200;
   WiaItemTypeVPanorama                    =$00000400;
   WiaItemTypeBurst                        =$00000800;
   WiaItemTypeStorage                      =$00001000;
   WiaItemTypeTransfer                     =$00002000;
   WiaItemTypeGenerated                    =$00004000;
   WiaItemTypeHasAttachments               =$00008000;
   WiaItemTypeVideo                        =$00010000;

	WiaItemTypeTwainCapabilityPassThrough   =$00020000;
	WiaItemTypeRemoved                      =$80000000;
	WiaItemTypeMask                         =$8003FFFF;

   TYMED_HGLOBAL  = 1;
   TYMED_FILE     = 2;
   TYMED_ISTREAM  = 4;
   TYMED_ISTORAGE = 8;
   TYMED_GDI  = 16;
   TYMED_MFPICT   = 32;
   TYMED_ENHMF  = 64;
   TYMED_NULL   = 0;

	// IImageTransfer Callback Status. Messages must be a single value
   IT_MSG_DATA_HEADER                      =$0001;
   IT_MSG_DATA                             =$0002;
   IT_MSG_STATUS                           =$0003;
   IT_MSG_TERMINATION                      =$0004;
   IT_MSG_NEW_PAGE                         =$0005;
   IT_MSG_FILE_PREVIEW_DATA                =$0006;
   IT_MSG_FILE_PREVIEW_DATA_HEADER         =$0007;

   // IImageTransfer TYMED
   WIA_TYMED_CALLBACK                          =128;
   WIA_TYMED_MULTIPAGE_FILE                    =256;
   WIA_TYMED_MULTIPAGE_CALLBACK                =512;

   WIA_RESERVED_FOR_NEW_PROPS              = 1024;
   WIA_DIP_FIRST                           = 2;
   WIA_DPA_FIRST                           = WIA_DIP_FIRST + WIA_RESERVED_FOR_NEW_PROPS;
	WIA_DPC_FIRST                           = WIA_DPA_FIRST + WIA_RESERVED_FOR_NEW_PROPS;
   WIA_DPS_FIRST                           = WIA_DPC_FIRST + WIA_RESERVED_FOR_NEW_PROPS;
   WIA_IPA_FIRST                           = WIA_DPS_FIRST + WIA_RESERVED_FOR_NEW_PROPS;
   WIA_IPC_FIRST                           = WIA_IPA_FIRST + WIA_RESERVED_FOR_NEW_PROPS;

	WIA_DIP_REMOTE_DEV_ID                   = 9;
	WIA_DIP_UI_CLSID                        = 10;
	WIA_DIP_HW_CONFIG                       = 11;
	WIA_DIP_BAUDRATE                        = 12;
	WIA_DIP_STI_GEN_CAPABILITIES            = 13;
	WIA_DIP_WIA_VERSION                     = 14;


   // Common device properties
	WIA_DPA_FIRMWARE_VERSION                = WIA_DPA_FIRST + 0;
	WIA_DPA_CONNECT_STATUS                  = WIA_DPA_FIRST + 1;
	WIA_DPA_DEVICE_TIME                     = WIA_DPA_FIRST + 2;
	WIA_DPA_LAST                            = WIA_DPA_FIRST + 3;


   // Scanner item properties
   WIA_IPS_FIRST                          =WIA_IPC_FIRST + WIA_RESERVED_FOR_NEW_PROPS;
   WIA_IPS_CUR_INTENT                     =WIA_IPS_FIRST + 0;
   WIA_IPS_XRES                           =WIA_IPS_FIRST + 1;
   WIA_IPS_YRES                           =WIA_IPS_FIRST + 2;
   WIA_IPS_XPOS                           =WIA_IPS_FIRST + 3;
   WIA_IPS_YPOS                           =WIA_IPS_FIRST + 4;
   WIA_IPS_XEXTENT                        =WIA_IPS_FIRST + 5;
   WIA_IPS_YEXTENT                        =WIA_IPS_FIRST + 6;
   WIA_IPS_PHOTOMETRIC_INTERP             =WIA_IPS_FIRST + 7;
   WIA_IPS_BRIGHTNESS                     =WIA_IPS_FIRST + 8;
   WIA_IPS_CONTRAST                       =WIA_IPS_FIRST + 9;
   WIA_IPS_ORIENTATION                    =WIA_IPS_FIRST + 10;
   WIA_IPS_ROTATION                       =WIA_IPS_FIRST + 11;
   WIA_IPS_MIRROR                         =WIA_IPS_FIRST + 12;
   WIA_IPS_THRESHOLD                      =WIA_IPS_FIRST + 13;
   WIA_IPS_INVERT                         =WIA_IPS_FIRST + 14;
   WIA_IPS_WARM_UP_TIME                   =WIA_IPS_FIRST + 15;

	// Scanner device properties
   WIA_DPS_HORIZONTAL_BED_SIZE                    =WIA_DPS_FIRST + 0;
   WIA_DPS_VERTICAL_BED_SIZE                      =WIA_DPS_FIRST + 1;
   WIA_DPS_HORIZONTAL_SHEET_FEED_SIZE             =WIA_DPS_FIRST + 2;
   WIA_DPS_VERTICAL_SHEET_FEED_SIZE               =WIA_DPS_FIRST + 3;
   WIA_DPS_SHEET_FEEDER_REGISTRATION              =WIA_DPS_FIRST + 4;
   WIA_DPS_HORIZONTAL_BED_REGISTRATION            =WIA_DPS_FIRST + 5;
   WIA_DPS_VERTICAL_BED_REGISTRATION              =WIA_DPS_FIRST + 6;
   WIA_DPS_PLATEN_COLOR                           =WIA_DPS_FIRST + 7;
   WIA_DPS_PAD_COLOR                              =WIA_DPS_FIRST + 8;
   WIA_DPS_FILTER_SELECT                          =WIA_DPS_FIRST + 9;
   WIA_DPS_DITHER_SELECT                          =WIA_DPS_FIRST + 10;
   WIA_DPS_DITHER_PATTERN_DATA                    =WIA_DPS_FIRST + 11;
   WIA_DPS_DOCUMENT_HANDLING_CAPABILITIES         =WIA_DPS_FIRST + 12;
   WIA_DPS_DOCUMENT_HANDLING_STATUS               =WIA_DPS_FIRST + 13;
   WIA_DPS_DOCUMENT_HANDLING_SELECT               =WIA_DPS_FIRST + 14;
   WIA_DPS_DOCUMENT_HANDLING_CAPACITY             =WIA_DPS_FIRST + 15;
   WIA_DPS_OPTICAL_XRES                           =WIA_DPS_FIRST + 16;
   WIA_DPS_OPTICAL_YRES                           =WIA_DPS_FIRST + 17;
   WIA_DPS_ENDORSER_CHARACTERS                    =WIA_DPS_FIRST + 18;
   WIA_DPS_ENDORSER_STRING                        =WIA_DPS_FIRST + 19;
   WIA_DPS_SCAN_AHEAD_PAGES                       =WIA_DPS_FIRST + 20;
   WIA_DPS_MAX_SCAN_TIME                          =WIA_DPS_FIRST + 21;
   WIA_DPS_PAGES                                  =WIA_DPS_FIRST + 22;
   WIA_DPS_PAGE_SIZE                              =WIA_DPS_FIRST + 23;
   WIA_DPS_PAGE_WIDTH                             =WIA_DPS_FIRST + 24;
   WIA_DPS_PAGE_HEIGHT                            =WIA_DPS_FIRST + 25;
   WIA_DPS_PREVIEW                                =WIA_DPS_FIRST + 26;
   WIA_DPS_TRANSPARENCY                           =WIA_DPS_FIRST + 27;
   WIA_DPS_TRANSPARENCY_SELECT                    =WIA_DPS_FIRST + 28;
   WIA_DPS_SHOW_PREVIEW_CONTROL                   =WIA_DPS_FIRST + 29;
   WIA_DPS_MIN_HORIZONTAL_SHEET_FEED_SIZE         =WIA_DPS_FIRST + 30;
   WIA_DPS_MIN_VERTICAL_SHEET_FEED_SIZE           =WIA_DPS_FIRST + 31;

   // Common item properties
   WIA_IPA_ITEM_NAME                       =WIA_IPA_FIRST + 0;
   WIA_IPA_FULL_ITEM_NAME                  =WIA_IPA_FIRST + 1;
   WIA_IPA_ITEM_TIME                       =WIA_IPA_FIRST + 2;
   WIA_IPA_ITEM_FLAGS                      =WIA_IPA_FIRST + 3;
   WIA_IPA_ACCESS_RIGHTS                   =WIA_IPA_FIRST + 4;
   WIA_IPA_DATATYPE                        =WIA_IPA_FIRST + 5;
   WIA_IPA_DEPTH                           =WIA_IPA_FIRST + 6;
   WIA_IPA_PREFERRED_FORMAT                =WIA_IPA_FIRST + 7;
   WIA_IPA_FORMAT                          =WIA_IPA_FIRST + 8;
   WIA_IPA_COMPRESSION                     =WIA_IPA_FIRST + 9;
   WIA_IPA_TYMED                           =WIA_IPA_FIRST + 10;
   WIA_IPA_CHANNELS_PER_PIXEL              =WIA_IPA_FIRST + 11;
   WIA_IPA_BITS_PER_CHANNEL                =WIA_IPA_FIRST + 12;
   WIA_IPA_PLANAR                          =WIA_IPA_FIRST + 13;
   WIA_IPA_PIXELS_PER_LINE                 =WIA_IPA_FIRST + 14;
   WIA_IPA_BYTES_PER_LINE                  =WIA_IPA_FIRST + 15;
   WIA_IPA_NUMBER_OF_LINES                 =WIA_IPA_FIRST + 16;
   WIA_IPA_GAMMA_CURVES                    =WIA_IPA_FIRST + 17;
   WIA_IPA_ITEM_SIZE                       =WIA_IPA_FIRST + 18;
   WIA_IPA_COLOR_PROFILE                   =WIA_IPA_FIRST + 19;
   WIA_IPA_MIN_BUFFER_SIZE                 =WIA_IPA_FIRST + 20;
   WIA_IPA_BUFFER_SIZE                     =WIA_IPA_FIRST + 20;
   WIA_IPA_REGION_TYPE                     =WIA_IPA_FIRST + 21;
   WIA_IPA_ICM_PROFILE_NAME                =WIA_IPA_FIRST + 22;
   WIA_IPA_APP_COLOR_MAPPING               =WIA_IPA_FIRST + 23;
   WIA_IPA_PROP_STREAM_COMPAT_ID           =WIA_IPA_FIRST + 24;
   WIA_IPA_FILENAME_EXTENSION              =WIA_IPA_FIRST + 25;
   WIA_IPA_SUPPRESS_PROPERTY_PAGE          =WIA_IPA_FIRST + 26;
   WIA_IPA_LAST                            =WIA_IPA_FIRST + 26;

   // camera info
   WIA_DPC_PICTURES_TAKEN                  =WIA_DPC_FIRST + 0;
   WIA_DPC_PICTURES_REMAINING              =WIA_DPC_FIRST + 1;
   WIA_DPC_EXPOSURE_MODE                   =WIA_DPC_FIRST + 2;
   WIA_DPC_EXPOSURE_COMP                   =WIA_DPC_FIRST + 3;
   WIA_DPC_EXPOSURE_TIME                   =WIA_DPC_FIRST + 4;
   WIA_DPC_FNUMBER                         =WIA_DPC_FIRST + 5;
   WIA_DPC_FLASH_MODE                      =WIA_DPC_FIRST + 6;
   WIA_DPC_FOCUS_MODE                      =WIA_DPC_FIRST + 7;
   WIA_DPC_FOCUS_MANUAL_DIST               =WIA_DPC_FIRST + 8;
   WIA_DPC_ZOOM_POSITION                   =WIA_DPC_FIRST + 9;
   WIA_DPC_PAN_POSITION                    =WIA_DPC_FIRST + 10;
   WIA_DPC_TILT_POSITION                   =WIA_DPC_FIRST + 11;
   WIA_DPC_TIMER_MODE                      =WIA_DPC_FIRST + 12;
   WIA_DPC_TIMER_VALUE                     =WIA_DPC_FIRST + 13;
   WIA_DPC_POWER_MODE                      =WIA_DPC_FIRST + 14;
   WIA_DPC_BATTERY_STATUS                  =WIA_DPC_FIRST + 15;
   WIA_DPC_THUMB_WIDTH                     =WIA_DPC_FIRST + 16;
   WIA_DPC_THUMB_HEIGHT                    =WIA_DPC_FIRST + 17;
   WIA_DPC_PICT_WIDTH                      =WIA_DPC_FIRST + 18;
   WIA_DPC_PICT_HEIGHT                     =WIA_DPC_FIRST + 19;
   WIA_DPC_DIMENSION                       =WIA_DPC_FIRST + 20;
   WIA_DPC_COMPRESSION_SETTING             =WIA_DPC_FIRST + 21;
   WIA_DPC_FOCUS_METERING                  =WIA_DPC_FIRST + 22;
   WIA_DPC_TIMELAPSE_INTERVAL              =WIA_DPC_FIRST + 23;
   WIA_DPC_TIMELAPSE_NUMBER                =WIA_DPC_FIRST + 24;
   WIA_DPC_BURST_INTERVAL                  =WIA_DPC_FIRST + 25;
   WIA_DPC_BURST_NUMBER                    =WIA_DPC_FIRST + 26;
   WIA_DPC_EFFECT_MODE                     =WIA_DPC_FIRST + 27;
   WIA_DPC_DIGITAL_ZOOM                    =WIA_DPC_FIRST + 28;
   WIA_DPC_SHARPNESS                       =WIA_DPC_FIRST + 29;
   WIA_DPC_CONTRAST                        =WIA_DPC_FIRST + 30;
   WIA_DPC_CAPTURE_MODE                    =WIA_DPC_FIRST + 31;
   WIA_DPC_CAPTURE_DELAY                   =WIA_DPC_FIRST + 32;
   WIA_DPC_EXPOSURE_INDEX                  =WIA_DPC_FIRST + 33;
   WIA_DPC_EXPOSURE_METERING_MODE          =WIA_DPC_FIRST + 34;
   WIA_DPC_FOCUS_METERING_MODE             =WIA_DPC_FIRST + 35;
   WIA_DPC_FOCUS_DISTANCE                  =WIA_DPC_FIRST + 36;
   WIA_DPC_FOCAL_LENGTH                    =WIA_DPC_FIRST + 37;
   WIA_DPC_RGB_GAIN                        =WIA_DPC_FIRST + 38;
   WIA_DPC_WHITE_BALANCE                   =WIA_DPC_FIRST + 39;
   WIA_DPC_UPLOAD_URL                      =WIA_DPC_FIRST + 40;
   WIA_DPC_ARTIST                          =WIA_DPC_FIRST + 41;
   WIA_DPC_COPYRIGHT_INFO                  =WIA_DPC_FIRST + 42;

   // camera item info
   WIA_IPC_THUMBNAIL                       =WIA_IPC_FIRST + 0;
   WIA_IPC_THUMB_WIDTH                     =WIA_IPC_FIRST + 1;
   WIA_IPC_THUMB_HEIGHT                    =WIA_IPC_FIRST + 2;
   WIA_IPC_AUDIO_AVAILABLE                 =WIA_IPC_FIRST + 3;
   WIA_IPC_AUDIO_DATA_FORMAT               =WIA_IPC_FIRST + 4;
   WIA_IPC_AUDIO_DATA                      =WIA_IPC_FIRST + 5;
   WIA_IPC_NUM_PICT_PER_ROW                =WIA_IPC_FIRST + 6;
   WIA_IPC_SEQUENCE                        =WIA_IPC_FIRST + 7;
   WIA_IPC_TIMEDELAY                       =WIA_IPC_FIRST + 8;


   // WIA_DPC_WHITE_BALANCE constants
   WIA_WHITEBALANCE_MANUAL        =1;
   WIA_WHITEBALANCE_AUTO          =2;
   WIA_WHITEBALANCE_ONEPUSH_AUTO      =3;
   WIA_WHITEBALANCE_DAYLIGHT          =4;
   WIA_WHITEBALANCE_FLORESCENT        =5;
   WIA_WHITEBALANCE_TUNGSTEN          =6;
   WIA_WHITEBALANCE_FLASH         =7;

   // WIA_DPC_FOCUS_MODE constants
   WIA_FOCUSMODE_MANUAL        =1;
   WIA_FOCUSMODE_AUTO          =2;
   WIA_FOCUSMODE_MACROAUTO     =3;

   // WIA_DPC_EXPOSURE_METERING_MODE constants
   WIA_EXPOSUREMETERING_AVERAGE    =1;
   WIA_EXPOSUREMETERING_CENTERWEIGHT   =2;
   WIA_EXPOSUREMETERING_MULTISPOT  =3;
   WIA_EXPOSUREMETERING_CENTERSPOT =4;

   // WIA_DPC_FLASH_MODE constants
   WIA_FLASHMODE_AUTO          =1;
   WIA_FLASHMODE_OFF           =2;
   WIA_FLASHMODE_FILL          =3;
   WIA_FLASHMODE_REDEYE_AUTO       =4;
   WIA_FLASHMODE_REDEYE_FILL       =5;
   WIA_FLASHMODE_EXTERNALSYNC      =6;

   // WIA_DPC_EXPOSURE_MODE constants
   WIA_EXPOSUREMODE_MANUAL     =1;
   WIA_EXPOSUREMODE_AUTO       =2;
   WIA_EXPOSUREMODE_APERTURE_PRIORITY  =3;
   WIA_EXPOSUREMODE_SHUTTER_PRIORITY   =4;
   WIA_EXPOSUREMODE_PROGRAM_CREATIVE   =5;
   WIA_EXPOSUREMODE_PROGRAM_ACTION =6;
   WIA_EXPOSUREMODE_PORTRAIT       =7;

   // WIA_DPC_CAPTURE_MODE constants
   WIA_CAPTUREMODE_NORMAL      =1;
   WIA_CAPTUREMODE_BURST       =2;
   WIA_CAPTUREMODE_TIMELAPSE       =3;

   // WIA_DPC_EFFECT_MODE constants
   WIA_EFFECTMODE_STANDARD     =1;
   WIA_EFFECTMODE_BW           =2;
   WIA_EFFECTMODE_SEPIA        =3;

   // WIA_DPC_FOCUS_METERING_MODE constants
   WIA_FOCUSMETERING_CENTERSPOT    =1;
   WIA_FOCUSMETERING_MULTISPOT     =2;

   // WIA_DPC_POWER_MODE constants
   WIA_POWERMODE_LINE              =1;
   WIA_POWERMODE_BATTERY           =2;

   // WIA_DPS_SHEET_FEEDER_REGISTRATION and
   // WIA_DPS_HORIZONTAL_BED_REGISTRATION constants
   WIA_LEFT_JUSTIFIED             =0;
   WIA_CENTERED                   =1;
   WIA_RIGHT_JUSTIFIED            =2;

   // WIA_DPS_VERTICAL_BED_REGISTRATION constants
   WIA_TOP_JUSTIFIED              =0;
   //WIA_CENTERED                   =1;
   WIA_BOTTOM_JUSTIFIED           =2;

   // WIA_DPS_ORIENTATION and WIA_DPS_ROTATION constants
   WIA_PORTRAIT                   =0;
   WIA_LANSCAPE                   =1;
   WIA_ROT180                     =2;
   WIA_ROT270                     =3;

   // WIA_DPS_MIRROR flags
   WIA_MIRRORED                   =$01;

   // WIA_DPS_DOCUMENT_HANDLING_SELECT flags
   WIA_FEEDER                     =$001;
   WIA_FLATBED                    =$002;
   WIA_DUPLEX                     =$004;
   WIA_FRONT_FIRST                =$008;
   WIA_BACK_FIRST                 =$010;
   WIA_FRONT_ONLY                 =$020;
   WIA_BACK_ONLY                  =$040;
   WIA_NEXT_PAGE                  =$080;
   WIA_PREFEED                    =$100;
   WIA_AUTO_ADVANCE               =$200;

   // WIA_DPS_TRANSPARENCY flags
   WIA_LIGHT_SOURCE_PRESENT_DETECT =$01;
   WIA_LIGHT_SOURCE_PRESENT        =$02;
   WIA_LIGHT_SOURCE_DETECT_READY   =$04;
   WIA_LIGHT_SOURCE_READY          =$08;

   // WIA_DPS_TRANSPARENCY_SELECT flags
   WIA_LIGHT_SOURCE_SELECT        =$001;

   // WIA_DPS_SCAN_AHEAD_PAGES constants
   WIA_SCAN_AHEAD_ALL         =0;

   // WIA_DPS_PAGES constants
   WIA_ALL_PAGES                  =0;

   // WIA_DPS_PREVIEW constants
   WIA_FINAL_SCAN              =0;
   WIA_PREVIEW_SCAN            =1;

   // WIA_DPS_SHOW_PREVIEW_CONTROL constants
   WIA_SHOW_PREVIEW_CONTROL        =0;
   WIA_DONT_SHOW_PREVIEW_CONTROL   =1;

   // Predefined strings for WIA_DPS_ENDORSER_STRING
   WIA_ENDORSER_TOK_DATE       ='$DATE$';
   WIA_ENDORSER_TOK_TIME       ='$TIME$';
   WIA_ENDORSER_TOK_PAGE_COUNT ='$PAGE_COUNT$';
   WIA_ENDORSER_TOK_DAY        ='$DAY$';
   WIA_ENDORSER_TOK_MONTH      ='$MONTH$';
   WIA_ENDORSER_TOK_YEAR       ='$YEAR$';

   // WIA_DPS_PAGE_SIZE constants
   WIA_PAGE_A4         =0;
   WIA_PAGE_LETTER     =1;
   WIA_PAGE_CUSTOM     =2;

   // WIA_IPA_COMPRESSION constants
   WIA_COMPRESSION_NONE        =0;
   WIA_COMPRESSION_BI_RLE4     =1;
   WIA_COMPRESSION_BI_RLE8     =2;
   WIA_COMPRESSION_G3          =3;
   WIA_COMPRESSION_G4          =4;
   WIA_COMPRESSION_JPEG        =5;

   // WIA_IPA_PLANAR constants
   WIA_PACKED_PIXEL            =0;
   WIA_PLANAR                  =1;

   // WIA_IPA_DATATYPE constants
   WIA_DATA_THRESHOLD                      =0;
   WIA_DATA_DITHER                         =1;
   WIA_DATA_GRAYSCALE                      =2;
   WIA_DATA_COLOR                          =3;
   WIA_DATA_COLOR_THRESHOLD                =4;
   WIA_DATA_COLOR_DITHER                   =5;

   // WIA_IPA_SUPPRESS_PROPERTY_PAGE flags
   WIA_PROPPAGE_SCANNER_ITEM_GENERAL       =$00000001;
   WIA_PROPPAGE_CAMERA_ITEM_GENERAL        =$00000002;

   // WIA_IPS_CUR_INTENT flags
   //WIA_INTENT_NONE                 =$00000000;
   WIA_INTENT_IMAGE_TYPE_COLOR     =$00000001;
   WIA_INTENT_IMAGE_TYPE_GRAYSCALE =$00000002;
   WIA_INTENT_IMAGE_TYPE_TEXT      =$00000004;
   WIA_INTENT_IMAGE_TYPE_MASK      =$0000000F;
   WIA_INTENT_MINIMIZE_SIZE        =$00010000;
   WIA_INTENT_MAXIMIZE_QUALITY     =$00020000;
   WIA_INTENT_BEST_PREVIEW         =$00040000;
   WIA_INTENT_SIZE_MASK            =$000F0000;

   // WIA_IPS_PHOTOMETRIC_INTERP constants
   WIA_PHOTO_WHITE_1      =0;   // default, white is 1, black is 0
   WIA_PHOTO_WHITE_0      =1;   // default, white is 0, black is 1

   // WIA Extended Property Identifiers
   WIA_RANGE_MIN                          =0;
   WIA_RANGE_NOM                          =1;
   WIA_RANGE_MAX                          =2;
   WIA_RANGE_STEP                         =3;
   WIA_RANGE_NUM_ELEMS                    =4;
   WIA_LIST_COUNT                         =0;
   WIA_LIST_NOM                           =1;
   WIA_LIST_VALUES                        =2;
   WIA_LIST_NUM_ELEMS                     =2;
   WIA_FLAG_NOM                           =0;
   WIA_FLAG_VALUES                        =1;
   WIA_FLAG_NUM_ELEMS                     =2;

   WIA_PROP_READ            =$01;
   WIA_PROP_WRITE           =$02;
   WIA_PROP_RW              = WIA_PROP_READ or WIA_PROP_WRITE;
   WIA_PROP_SYNC_REQUIRED   =$04;
   WIA_PROP_NONE            =$08;
   WIA_PROP_RANGE           =$10;
   WIA_PROP_LIST            =$20;
   WIA_PROP_FLAG            =$40;
   WIA_PROP_CACHEABLE       =$10000;

   WIA_ITEM_CAN_BE_DELETED  =$80;
   WIA_ITEM_READ            =WIA_PROP_READ;
   WIA_ITEM_WRITE           =WIA_PROP_WRITE;
   WIA_ITEM_RD              = WIA_ITEM_READ or WIA_ITEM_CAN_BE_DELETED;
   WIA_ITEM_RWD             = WIA_ITEM_READ or WIA_ITEM_WRITE or WIA_ITEM_CAN_BE_DELETED;



   // Device connection status
   WIA_DEVICE_NOT_CONNECTED               =0;
   WIA_DEVICE_CONNECTED                   =1;



	// WIA_DPS_DOCUMENT_HANDLING_CAPABILITIES flags
	WIA_FEED                       =$01;
	WIA_FLAT                       =$02;
	WIA_DUP                        =$04;
	WIA_DETECT_FLAT                =$08;
	WIA_DETECT_SCAN                =$10;
	WIA_DETECT_FEED                =$20;
	WIA_DETECT_DUP                 =$40;
	WIA_DETECT_FEED_AVAIL          =$80;
	WIA_DETECT_DUP_AVAIL           =$100;

	// WIA_DPS_DOCUMENT_HANDLING_STATUS flags
	WIA_FEED_READY                 =$01;
	WIA_FLAT_READY                 =$02;
	WIA_DUP_READY                  =$04;
	WIA_FLAT_COVER_UP              =$08;
	WIA_PATH_COVER_UP              =$10;
	WIA_PAPER_JAM                  =$20;


type


   WIA_DATA_CALLBACK_HEADER = record
   	lSize:integer;
     	guidFormatID:TGUID;
   	lBufferSize:integer;
     	lPageCount:integer;
   end;
   PWIA_DATA_CALLBACK_HEADER=^WIA_DATA_CALLBACK_HEADER;

   IWiaItem=interface;

   TIEWGetPage=function(header:PWIA_DATA_CALLBACK_HEADER; data:pointer; datalen:integer):boolean of object;

	IWiaDataCallback = interface (IUnknown)
   	['{a558a866-a5b0-11d2-a08f-00c04f72dc3c}']
      function BandedDataCallback(lMessage:integer; lStatus:integer; lPercentComplete:integer; lOffset:integer; lLength:integer; lReserved:integer; lResLength:integer; pbBuffer:pbyte):HRESULT; stdcall;
   end;

	WIA_DATA_TRANSFER_INFO=record
   	ulSize:integer;
    	ulSection:integer;
    	ulBufferSize:integer;
    	bDoubleBuffer:longbool;
    	ulReserved1:integer;
    	ulReserved2:integer;
    	ulReserved3:integer;
   end;
   PWIA_DATA_TRANSFER_INFO=^WIA_DATA_TRANSFER_INFO;

   TIEWiaOnProgress=function(percentage:integer):boolean of object;

   TWiaDataCallBack = class(TInterfacedObject, IWiaDataCallBack)
   	header:WIA_DATA_CALLBACK_HEADER;
      data:pbyte;
      datalen:integer;
      OnGetPage:TIEWGetPage;
      OnProgress:TIEWiaOnProgress;
      WaitingData:boolean;
   	function BandedDataCallback(lMessage:integer; lStatus:integer; lPercentComplete:integer; lOffset:integer; lLength:integer; lReserved:integer; lResLength:integer; pbBuffer:pbyte):HRESULT; stdcall;
		constructor Create;
      destructor Destroy; override;
   end;
   PWiaDataCallBAck = ^TWiaDataCallBack;

   IWiaDataTransfer = interface (IUnknown)
   	['{a6cef998-a5b0-11d2-a08f-00c04f72dc3c}']
      function idtGetData:HRESULT; stdcall; // NOT STILL IMPLEMENTED
      function idtGetBandedData(pWiaDataTransInfo:PWIA_DATA_TRANSFER_INFO; pIWiaDataCallback:IWiaDataCallback):HRESULT; stdcall;
      function idtQueryGetData:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function idtEnumWIA_FORMAT_INFO:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function idtGetExtendedTransferInfo:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   end;

   IEnumWiaItem = interface (IUnknown)
   	['{5e8383fc-3391-11d2-9a33-00c04fa36145}']
      function Next(celt:integer; out ppIWiaItem:IWiaItem; var pceltFetched:integer ):HRESULT; stdcall;
      function Skip:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function Reset:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function Clone:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function GetCount:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   end;

   TIWiaItemArray = array [0..0] of IUnknown;	// IUnknown instead IWiaItem because this crashes C++Builder
   PIWiaItemArray = ^TIWiaItemArray;

   IWiaItem = interface (IUnknown)
   	['{4db1ad10-3391-11d2-9a33-00c04fa36145}']
   	function GetItemType(var pItemType:integer):HRESULT; stdcall;
   	function AnalyzeItem(lFlags:integer):HRESULT; stdcall;
   	function EnumChildItems(out ppIEnumWiaItem:IEnumWiaItem):HRESULT; stdcall;
   	function DeleteItem:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   	function CreateChildItem:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   	function EnumRegisterEventInfo:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   	function FindItemByName:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   	function DeviceDlg( hwndParent:HWND; lFlags:integer; lIntent:integer; out plItemCount:integer; out ppIWiaItem:PIWiaItemArray):HRESULT; stdcall;
   	function DeviceCommand(lFlags:integer; pCmdGUID:PGUID; var pIWiaItem:IWiaItem):HRESULT; stdcall;
   	function GetRootItem:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   	function EnumDeviceCapabilities:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   	function DumpItemData:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   	function DumpDrvItemData:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   	function DumpTreeItemData:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   	function Diagnostic:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   end;

   IWiaPropertyStorage = interface (IUnknown)
   	['{98B5E8A0-29CC-491a-AAC0-E6DB4FDCCEB6}']
      function ReadMultiple(cpspec:integer; rgpspec:pointer; rgpropvar:pointer):HRESULT; stdcall;
      function WriteMultiple(cpspec:integer; rgpspec:pointer; rgpropvar:pointer; propidNameFirst:integer):HRESULT; stdcall;
      function DeleteMultiple:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function ReadPropertyNames(cpropid:integer; rgpspec:pointer; var name:PAnsiChar):HRESULT; stdcall;
      function WritePropertyNames:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function DeletePropertyNames:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function Commit:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function Revert:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function Enum:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function SetTimes:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function SetClass:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function Stat:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function GetPropertyAttributes(cpspec:integer; rgpspec:pointer; var rgflags:integer; rgpropvar:pointer):HRESULT; stdcall;
      function GetCount:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function GetPropertyStream:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function SetPropertyStream:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   end;

	IEnumWIA_DEV_INFO = interface (IUnknown)
		['{5e38b83c-8cf1-11d1-bf92-0060081ed811}']
      function Next(celt:integer; out rgelt:IWiaPropertyStorage; var pceltFetched:integer):HRESULT; stdcall;
      function Skip:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
		function Reset:HRESULT; stdcall;
      function Clone:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function GetCount(var celt:integer):HRESULT; stdcall;
   end;

   PIEnumWIA_DEV_INFO=^IEnumWIA_DEV_INFO;
   PPIEnumWIA_DEV_INFO=^PIEnumWIA_DEV_INFO;

   IWiaDevMgr = interface (IUnknown)
   	['{5eb2502a-8cf1-11d1-bf92-0060081ed811}']
      function EnumDeviceInfo( lFlag:integer; out ppIEnum:IEnumWIA_DEV_INFO ):HRESULT; stdcall;
      function CreateDevice(bstrDeviceID:pwchar; out ppWiaItemRoot:IWiaItem):HRESULT; stdcall;
      function SelectDeviceDlg:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function SelectDeviceDlgID(hwndParent:HWND; lDeviceType:integer; lFlags:integer; var pbstrDeviceID:pwchar):HRESULT; stdcall;
		function GetImageDlg:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function RegisterEventCallbackProgram:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function RegisterEventCallbackInterface:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function RegisterEventCallbackCLSID:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
      function AddDeviceDlg:HRESULT; stdcall;	// NOT STILL IMPLEMENTED
   end;
   IID_IWiaDevMgr=IWiaDevMgr;


   TIEWiaDeviceInfo=class
      Name:string;
      ID:string;
      DeviceType:(iewScanner, iewDigitalCamera, iewStreamingVideo);
      DriverVersion:string;
      PortName:string;
      ServerName:string;
      Vendor:string;
   end;

   TIEWiaItemType=set of (
      witFree,
      witImage,
      witFile,
      witFolder,
      witRoot,
      witAnalyze,
      witAudio,
      witDevice,
      witDeleted,
      witDisconnected,
      witHPanorama,
      witVPanorama,
      witBurst,
      witStorage,
      witTransfer,
      witGenerated,
      witHasAttachments,
      witVideo,
      witTwainCapabilityPassThrough,
      witRemoved,
      witMask
   );


   TIEWiaItem=class
   	This:IWiaItem;
   	Children:TList;
      ItemType:TIEWiaItemType;
      constructor Create;
      destructor Destroy; override;
   end;

   TIEWProcessingInfo=record
   	DPIX:integer;
      DPIY:integer;
   end;

   TIEWiaAttrib=set of (iewaRead, iewaWrite, iewaSyncRequired, iewaNone, iewaRange, iewaList, iewaFlag, iewaCacheable);

   variantarray=array [0..MaxInt div 32] of variant;
   pvariantarray=^variantarray;

   TIEWiaValues=class
   	private
      	fValues:pvariantarray;
      	function GetValues(idx:integer):variant;
   	public
      	max:variant;
         min:variant;
         count:integer;
         normal:variant;
         step:variant;
         constructor Create;
         destructor Destroy; override;
         property values[idx:integer]:variant read GetValues;
   end;

   TIEWia=class
      private
         fIWiaDevMgr:IWiaDevMgr;
         fDevicesInfo:TList;	// list of TIEWiaDeviceInfo objects
         fRoot:TIEWiaItem;	// the root IWiaItem (encapsulated in TIEWiaItem)
         fCtrlParent:TComponent;
         fMultiCallBack:TIEMultiCallBack;
         fOnProgress:TIEWiaOnProgress;
         procedure FillDevices;
         procedure FillItemChildren(parent:TIEWiaItem);
         function GetDevicesInfo(idx:integer):TIEWiaDeviceInfo;
         function GetDevicesInfoCount:integer;
         procedure EmptyDeviceInfo;
         function GetRoot:TIEWiaItem;
         function GetPage(header:PWIA_DATA_CALLBACK_HEADER; data:pointer; datalen:integer):boolean;
         procedure ConnectToDefault;
         function GetDefaultItem(var item:TIEWiaItem):boolean;
      public
         ProcessingBitmap:TIEBitmap;
         ProcessingInfo:TIEWProcessingInfo;
         constructor Create(parent:TComponent);
         destructor Destroy; override;
         property DevicesInfo[idx:integer]:TIEWiaDeviceInfo read GetDevicesInfo;
         property DevicesInfoCount:integer read GetDevicesInfoCount;
         function ConnectToUsingDialog:boolean;
         property Device:TIEWiaItem read GetRoot;
         {$ifdef IESUPPORTDEFPARAMS}
         function ConnectTo(idx:integer=0):boolean;
         function ShowAcquireDialog(SystemDialog:boolean=false):boolean;
         function Transfer( item:TIEWiaItem=nil; MultiPage:boolean=false ):boolean;
         {$else}
         function ConnectTo(idx:integer):boolean;
         function ShowAcquireDialog(SystemDialog:boolean):boolean;
         function Transfer( item:TIEWiaItem; MultiPage:boolean ):boolean;
         {$endif}
         property OnProgress:TIEWiaOnProgress read fOnProgress write fOnProgress;
         property OnGetPage:TIEMultiCallBack read fMultiCallBack write fMultiCallBack;
         // raw properties read/write
         function GetDeviceProperty(PropId:dword):Variant;
         function SetDeviceProperty(PropId:dword; val:Variant):boolean;
         function GetItemProperty( PropId:dword; item:TIEWiaItem ):Variant;
         function SetItemProperty( PropId:dword; val:Variant; item:TIEWiaItem ):boolean;
         procedure GetItemPropertyAttrib( PropId:dword; item:TIEWiaItem; var attrib:TIEWiaAttrib; var values:TIEWiaValues );
   end;

var
	IEOleInitialized:boolean;


implementation

uses imageenproc,bmpfilt,imageenio,jpegfilt;


const
	CLSID_WiaDevMgr:TGUID=     '{A1F4E726-8CF1-11D1-BF92-0060081ED811}';

   WIA_CMD_TAKE_PICTURE:TGUID='{af933cac-acad-11d2-a093-00c04f72dc3c}';
	WIA_CMD_CHANGE_DOCUMENT:TGUID='{04e725b0-acae-11d2-a093-00c04f72dc3c}';
	WIA_CMD_UNLOAD_DOCUMENT:TGUID='{1f3b3d8e-acae-11d2-a093-00c04f72dc3c}';


   NULLGUID:TGUID = '{00000000-0000-0000-0000-000000000000}';
   CLSCTX_LOCAL_SERVER      = 4;
   CLSCTX_REMOTE_SERVER     = $10;
	CLSCTX_INPROC_HANDLER    = 2;
	CLSCTX_INPROC_SERVER     = 1;

   WIA_DEVINFO_ENUM_LOCAL   = $00000010;

   PRSPEC_LPWSTR = 0;
	PRSPEC_PROPID = 1;

 	WIA_SELECT_DEVICE_NODEFAULT          = $00000001;
   WIA_INTENT_NONE              = $00000000;
   WIA_DEVICE_DIALOG_USE_COMMON_UI      = $00000004;


type

   TVarType = Word;
   TOleBool = WordBool;
   PShortInt=^ShortInt;
   TShortIntArray=array [0..Maxint div 16] of ShortInt;
   PShortIntArray=^TShortIntArray;
   POleBool = ^TOleBool;
   TOleBoolArray=array [0..Maxint div 16] of TOleBool;
   POleBoolArray=^TOleBoolArray;
   TLongIntArray=array [0..Maxint div 16] of LongInt;
   PLongIntArray=^TLongIntArray;
   TULongArray=array [0..MaxInt div 16] of ULong;
   PULongArray=^TULongArray;
   TLargeIntegerArray=array [0..Maxint div 16] of TLargeInteger;
   PLargeIntegerArray=^TLargeIntegerArray;

   TOleDate = Double;
   POleDate = ^TOleDate;
   TOleDateArray = array [0..maxint div 16] of TOleDate;
   POleDateArray = ^TOleDateArray;
   PCLSID = PGUID;
   PBStr = ^TBStr;
   PLPSTR = ^LPSTR;
   PLPWSTR = ^LPWSTR;

   LPWSTRArray=array [0..maxint div 16] of LPWSTR;
	PLPWSTRArray=^LPWSTRArray;

   LPSTRArray=array [0..maxint div 16] of LPSTR;
   PLPSTRArray=^LPSTRArray;

   TBStr = PWideChar;

   TBStrArray=array [0..maxint div 16] of TBStr;
	PBStrArray=^TBStrArray;


   PROPSPEC = packed record
   	ulKind: ULONG;
    	case Integer of
      	0: (propid: dword);
      	1: (lpwstr: PWideChar);
  	end;

  	LARGE_INTEGER = record
   	case Integer of
    		0: (
    			LowPart: DWORD;
      		HighPart: Longint);
    		1: (
      		QuadPart: int64);
  	end;

   ULARGE_INTEGER = record
   	case Integer of
    		0: (
      		LowPart: DWORD;
      		HighPart: DWORD);
    		1: (
      		QuadPart: int64);
  	end;

	TULargeInteger = ULARGE_INTEGER;

   PULargeInteger = ^TULargeInteger;
   TULargeIntegerArray=array [0..maxint div 16] of TULargeInteger;
	PULargeIntegerArray=^TULargeIntegerArray;
   PPropVariant = ^TPropVariant;

	TCurrencyArray=array [0..maxint div 16] of Currency;
   PCurrencyArray=^TCurrencyArray;

   TFileTimeArray=array [0..maxint div 16] of TFileTime;
   PFileTimeArray=^TFileTimeArray;

   TBLOB = record
      cbSize: Longint;
      pBlobData: Pointer;
   end;
   PClipData = ^TClipData;
   TCLIPDATA = record
      cbSize: Longint;
      ulClipFmt: Longint;
      pClipData: Pointer;
   end;
   TClipDataArray=array [0..maxint div 16] of TClipData;
   PClipDataArray=^TClipDataArray;

   TGUIDArray=array [0..maxint div 32] of TGUID;
   PGUIDArray=^TGUIDArray;

   TCAUB = packed record
      cElems: ULONG;
      pElems: PBytearray;
   end;
   TCAI = packed record
      cElems: ULONG;
      pElems: PShortIntarray;
   end;
   TCAUI = packed record
      cElems: ULONG;
      pElems: PWordarray;
   end;
   TCABOOL = packed record
      cElems: ULONG;
      pElems: POleBoolarray;
   end;
   TCAL = packed record
      cElems: ULONG;
      pElems: PLongintarray;
   end;
   TCAUL = packed record
      cElems: ULONG;
      pElems: PULONGArray;
   end;
   TCAFLT = packed record
      cElems: ULONG;
      pElems: PSinglearray;
   end;
   TCASCODE = packed record
      cElems: ULONG;
      pElems: pintegerarray;
   end;
   TCAH = packed record
      cElems: ULONG;
      pElems: PLargeIntegerArray;
   end;
   TCAUH = packed record
      cElems: ULONG;
      pElems: PULargeIntegerArray;
   end;
   TCADBL = packed record
      cElems: ULONG;
      pElems: PDoubleArray;
   end;
   TCACY = packed record
      cElems: ULONG;
      pElems: PCurrencyArray;
   end;
   TCADATE = packed record
      cElems: ULONG;
      pElems: POleDateArray;
   end;
   TCAFILETIME = packed record
      cElems: ULONG;
      pElems: PFileTimeArray;
   end;
   TCACLSID = packed record
      cElems: ULONG;
      pElems: PGUIDArray;
   end;
   TCACLIPDATA = packed record
      cElems: ULONG;
      pElems: PClipDataArray;
   end;
   TCABSTR = packed record
      cElems: ULONG;
      pElems: PBSTRArray;
   end;
   TCALPSTR = packed record
      cElems: ULONG;
      pElems: PLPSTRArray;
   end;
   TCALPWSTR = packed record
      cElems: ULONG;
      pElems: PLPWSTRArray;
   end;

   TCAPROPVARIANT = packed record
      cElems: ULONG;
      pElems: PPropVariant;
   end;

   PROPVARIANT = packed record
      vt: TVarType;
      wReserved1: Word;
      wReserved2: Word;
      wReserved3: Word;
      case Integer of
         0: (bVal: Byte);
         1: (iVal: SmallInt);
         2: (uiVal: Word);
         3: (boolVal: TOleBool);
         4: (obool: TOleBool);	// obool instead of bool, because C++Builder uses bool as keyword
         5: (lVal: Longint);
         6: (ulVal: Cardinal);
         7: (fltVal: Single);
         8: (scode: integer);
         9: (hVal: LARGE_INTEGER);
         10: (uhVal: ULARGE_INTEGER);
         11: (dblVal: Double);
         12: (cyVal: Currency);
         13: (date: TOleDate);
         14: (filetime: TFileTime);
         15: (puuid: PGUID);
         16: (blob: TBlob);
         17: (pclipdata: PClipData);
         18: (pStream: Pointer);
         19: (pStorage: Pointer);
         20: (bstrVal: TBStr);
         21: (pszVal: PAnsiChar);
         22: (pwszVal: PWideChar);
         23: (caub: TCAUB);
         24: (cai: TCAI);
         25: (caui: TCAUI);
         26: (cabool: TCABOOL);
         27: (cal: TCAL);
         28: (caul: TCAUL);
         29: (caflt: TCAFLT);
         30: (cascode: TCASCODE);
         31: (cah: TCAH);
         32: (cauh: TCAUH);
         33: (cadbl: TCADBL);
         34: (cacy: TCACY);
         35: (cadate: TCADATE);
         36: (cafiletime: TCAFILETIME);
         37: (cauuid: TCACLSID);
         38: (caclipdata: TCACLIPDATA);
         39: (cabstr: TCABSTR);
         40: (calpstr: TCALPSTR);
         41: (calpwstr: TCALPWSTR );
         42: (capropvar: TCAPROPVARIANT);
   end;
   TPropVariant=PROPVARIANT;

	STGMEDIUM = record
      tymed: Longint;
      case Integer of
         0: (hBitmap: HBitmap; unkForRelease: pointer);
         1: (hMetaFilePict: THandle);
         2: (hEnhMetaFile: THandle);
         3: (hGlobal: HGlobal);
         4: (lpszFileName: PWideChar);
         5: (stm: pointer);
         6: (stg: pointer);
	end;
   PSTGMEDIUM=^STGMEDIUM;


const
  VT_EMPTY           = 0;   { [V]   [P]  nothing                     }
  VT_NULL            = 1;   { [V]        SQL style Null              }
  VT_I2              = 2;   { [V][T][P]  2 byte signed int           }
  VT_I4              = 3;   { [V][T][P]  4 byte signed int           }
  VT_R4              = 4;   { [V][T][P]  4 byte real                 }
  VT_R8              = 5;   { [V][T][P]  8 byte real                 }
  VT_CY              = 6;   { [V][T][P]  currency                    }
  VT_DATE            = 7;   { [V][T][P]  date                        }
  VT_BSTR            = 8;   { [V][T][P]  binary string               }
  VT_DISPATCH        = 9;   { [V][T]     IDispatch FAR*              }
  VT_ERROR           = 10;  { [V][T]     SCODE                       }
  VT_BOOL            = 11;  { [V][T][P]  True=-1, False=0            }
  VT_VARIANT         = 12;  { [V][T][P]  VARIANT FAR*                }
  VT_UNKNOWN         = 13;  { [V][T]     IUnknown FAR*               }
  VT_DECIMAL         = 14;  { [V][T]   [S]  16 byte fixed point      }
  VT_I1              = 16;  {    [T]     signed char                 }
  VT_UI1             = 17;  {    [T]     unsigned char               }
  VT_UI2             = 18;  {    [T]     unsigned short              }
  VT_UI4             = 19;  {    [T]     unsigned long               }
  VT_I8              = 20;  {    [T][P]  signed 64-bit int           }
  VT_UI8             = 21;  {    [T]     unsigned 64-bit int         }
  VT_INT             = 22;  {    [T]     signed machine int          }
  VT_UINT            = 23;  {    [T]     unsigned machine int        }
  VT_VOID            = 24;  {    [T]     C style void                }
  VT_HRESULT         = 25;  {    [T]                                 }
  VT_PTR             = 26;  {    [T]     pointer type                }
  VT_SAFEARRAY       = 27;  {    [T]     (use VT_ARRAY in VARIANT)   }
  VT_CARRAY          = 28;  {    [T]     C style array               }
  VT_USERDEFINED     = 29;  {    [T]     user defined type          }
  VT_LPSTR           = 30;  {    [T][P]  null terminated string      }
  VT_LPWSTR          = 31;  {    [T][P]  wide null terminated string }
  VT_FILETIME        = 64;  {       [P]  FILETIME                    }
  VT_BLOB            = 65;  {       [P]  Length prefixed bytes       }
  VT_STREAM          = 66;  {       [P]  Name of the stream follows  }
  VT_STORAGE         = 67;  {       [P]  Name of the storage follows }
  VT_STREAMED_OBJECT = 68;  {       [P]  Stream contains an object   }
  VT_STORED_OBJECT   = 69;  {       [P]  Storage contains an object  }
  VT_BLOB_OBJECT     = 70;  {       [P]  Blob contains an object     }
  VT_CF              = 71;  {       [P]  Clipboard format            }
  VT_CLSID           = 72;  {       [P]  A Class ID                  }
  VT_VECTOR        = $1000; {       [P]  simple counted array        }
  VT_ARRAY         = $2000; { [V]        SAFEARRAY*                  }
  VT_BYREF         = $4000; { [V]                                    }
  VT_RESERVED      = $8000;
  VT_ILLEGAL       = $ffff;
  VT_ILLEGALMASKED = $0fff;
  VT_TYPEMASK      = $0fff;

const
	ole32    = 'ole32.dll';

function CoCreateInstance(const clsid: TGUID; unkOuter: IUnknown; dwClsContext: Longint; const iid: TGUID; out pv): HResult; stdcall; external ole32 name 'CoCreateInstance';
function OleInitialize(pwReserved: Pointer): HResult; stdcall; external ole32 name 'OleInitialize';
procedure OleUninitialize; stdcall; external ole32 name 'OleUninitialize';
procedure CoTaskMemFree(pv:pointer); stdcall; external ole32 name 'CoTaskMemFree';
//procedure ReleaseStgMedium(pmedium:pointer); stdcall; external ole32 name 'ReleaseStgMedium';
function FreePropVariantArray(cVariants:ULONG; rgvars:PPROPVARIANT):HRESULT; stdcall; external ole32 name 'FreePropVariantArray';


constructor TIEWia.Create(parent:TComponent);
begin
	inherited Create;
   if not IEOleInitialized then
   	OleInitialize(nil);
   fCtrlParent:=parent;
   fMultiCallBack:=nil;
   fOnProgress:=nil;
   ProcessingBitmap:=nil;
   fDevicesInfo:=TList.Create;
   fRoot:=nil;
	fIWiaDevMgr:=nil;
	CoCreateInstance(CLSID_WiaDevMgr,nil,CLSCTX_LOCAL_SERVER,IID_IWiaDevMgr,fIWiaDevMgr);
end;

destructor TIEWia.Destroy;
begin
   fIWiaDevMgr:=nil;
   EmptyDeviceInfo;
   fDevicesInfo.free;
   if assigned(fRoot) then
   	fRoot.Free;
	inherited;
end;

procedure TIEWia.EmptyDeviceInfo;
begin
	while fDevicesInfo.Count>0 do begin
   	TIEWiaDeviceInfo(fDevicesInfo[0]).free;
      fDevicesInfo.Delete(0);
   end;
end;

function GET_STIDEVICE_TYPE(dwDevType:dword):integer;
begin
	result:=HIWORD(dwDevType);
end;

function GET_STIDEVICE_SUBTYPE(dwDevType:dword):integer;
begin
	result:=LOWORD(dwDevType);
end;

procedure TIEWia.FillDevices;
const
	PN=7;
var
	pIEnumWIA_DEV_INFO:IEnumWIA_DEV_INFO;
   pIWiaPropStg:IWiaPropertyStorage;
   hr:HRESULT;
   ulFetched:integer;
   vPropSpec:array [0..PN-1] of PROPSPEC;
   vPropVar:array [0..PN-1] of PROPVARIANT;
   inf:TIEWiaDeviceInfo;
begin
	if fIWiaDevMgr=nil then exit;
   hr := fIWiaDevMgr.EnumDeviceInfo(WIA_DEVINFO_ENUM_LOCAL,pIEnumWIA_DEV_INFO);
	if hr<>0 then exit;
   hr := pIEnumWIA_DEV_INFO.Reset;
   if hr<>0 then exit;
	EmptyDeviceInfo;
   while true do begin
   	hr := pIEnumWIA_DEV_INFO.Next(1,pIWiaPropStg,ulFetched);
      if (hr=0) and (ulFetched=1) then begin
      	fillchar(vPropVar[0],sizeof(PROPVARIANT)*PN,0);
         vPropSpec[0].ulKind := PRSPEC_PROPID;
         vPropSpec[0].propid := WIA_DIP_DEV_ID;
         vPropSpec[1].ulKind := PRSPEC_PROPID;
         vPropSpec[1].propid := WIA_DIP_DEV_NAME;
         vPropSpec[2].ulKind := PRSPEC_PROPID;
         vPropSpec[2].propid := WIA_DIP_DEV_TYPE;
         vPropSpec[3].ulKind := PRSPEC_PROPID;
         vPropSpec[3].propid := WIA_DIP_DRIVER_VERSION;
         vPropSpec[4].ulKind := PRSPEC_PROPID;
         vPropSpec[4].propid := WIA_DIP_PORT_NAME;
         vPropSpec[5].ulKind := PRSPEC_PROPID;
         vPropSpec[5].propid := WIA_DIP_SERVER_NAME;
         vPropSpec[6].ulKind := PRSPEC_PROPID;
         vPropSpec[6].propid := WIA_DIP_VEND_DESC;
         hr := pIWiaPropStg.ReadMultiple(PN, @vPropSpec[0], @vPropVar[0]);
			if hr=S_OK then begin
         	inf:=TIEWiaDeviceInfo.Create;
            inf.Name:=vPropVar[1].bstrVal;
            inf.ID:=vPropVar[0].bstrVal;
            case vPropVar[2].lVal and $FFFF of
				   StiDeviceTypeScanner: inf.DeviceType:=iewScanner;
				   StiDeviceTypeDigitalCamera: inf.DeviceType:=iewDigitalCamera;
				   StiDeviceTypeStreamingVideo: inf.DeviceType:=iewStreamingVideo;
            end;
            inf.DriverVersion:=vPropVar[3].bstrVal;
            inf.PortName:=vPropVar[4].bstrVal;
            inf.ServerName:=vPropVar[5].bstrVal;
            inf.Vendor:=vPropVar[6].bstrVal;
            fDevicesInfo.Add(inf);
         end;
         FreePropVariantArray(PN,@vPropVar[0]);
			pIWiaPropStg:=nil;
      end else
      	break;
   end;
end;

// if not connected, connect to first device
function TIEWia.GetDeviceProperty(PropId:dword):Variant;
begin
   if fRoot=nil then
      ConnectTo(0);
	result:=GetItemProperty( PropId, fRoot );
end;

// if not connected, connect to first device
function TIEWia.SetDeviceProperty(PropId:dword; val:Variant):boolean;
begin
   if fRoot=nil then
      ConnectTo(0);
	result:=SetItemProperty(PropId,val,fRoot);
end;

function TIEWia.GetDevicesInfo(idx:integer):TIEWiaDeviceInfo;
begin
	if fDevicesInfo.Count=0 then
   	FillDevices;
   if idx<fDevicesInfo.Count then
	   result:=fDevicesInfo[idx]
   else
   	result:=nil;
end;

procedure TIEWia.ConnectToDefault;
begin
   if fRoot=nil then
      ConnectTo(0);
end;

// if not connected, connect to first device
function TIEWia.GetDevicesInfoCount:integer;
begin
	ConnectToDefault;
	if fDevicesInfo.Count=0 then
   	FillDevices;
   result:=fDevicesInfo.Count;
end;

function TIEWia.ConnectTo(idx:integer):boolean;
var
   hr:HRESULT;
   pw:pwchar;
   dinfo:TIEWiaDeviceInfo;
begin
	result:=false;
   if fIWiaDevMgr=nil then exit;
	if assigned(fRoot) then
   	fRoot.Free;
   fRoot:=nil;
   dinfo:=DevicesInfo[idx];
   if dinfo<>nil then begin
      getmem(pw,256);
      StringToWideChar(dinfo.ID,pw,256);	// calling DevicesInfo fills it
      fRoot:=TIEWiaItem.Create;
      hr := fIWiaDevMgr.CreateDevice(pw,fRoot.this);
      freemem(pw);
      if hr=S_OK then begin
         result:=true;
         FillItemChildren(fRoot);
      end else begin
         fRoot.Free;
         fRoot:=nil;
      end;
   end;
end;

function TIEWia.ConnectToUsingDialog:boolean;
var
   hr:HRESULT;
   pw:pwchar;
begin
	result:=false;
   if fIWiaDevMgr=nil then exit;
	if assigned(fRoot) then
   	fRoot.Free;
   fRoot:=nil;
   hr := fIWiaDevMgr.SelectDeviceDlgID(IEFindHandle(fCtrlParent),StiDeviceTypeDefault,WIA_SELECT_DEVICE_NODEFAULT,pw);
	if hr<>S_OK then exit;
   fRoot:=TIEWiaItem.Create;
	hr := fIWiaDevMgr.CreateDevice(pw,fRoot.this);
   if hr=S_OK then begin
   	FillItemChildren(fRoot);
   	result:=true;
   end else begin
   	fRoot.Free;
      fRoot:=nil;
   end;
end;

function BuildWiaItemType(lType:integer):TIEWiaItemType;
begin
	result:=[];
   if (lType and WiaItemTypeFree)<>0 then result:=result+[witFree];
   if (lType and WiaItemTypeImage)<>0 then result:=result+[witImage];
   if (lType and WiaItemTypeFile)<>0 then result:=result+[witFile];
   if (lType and WiaItemTypeFolder)<>0 then result:=result+[witFolder];
   if (lType and WiaItemTypeRoot)<>0 then result:=result+[witRoot];
   if (lType and WiaItemTypeAnalyze)<>0 then result:=result+[witAnalyze];
   if (lType and WiaItemTypeAudio)<>0 then result:=result+[witAudio];
   if (lType and WiaItemTypeDevice)<>0 then result:=result+[witDevice];
   if (lType and WiaItemTypeDeleted)<>0 then result:=result+[witDeleted];
   if (lType and WiaItemTypeDisconnected)<>0 then result:=result+[witDisconnected];
   if (lType and WiaItemTypeHPanorama)<>0 then result:=result+[witHPanorama];
   if (lType and WiaItemTypeVPanorama)<>0 then result:=result+[witVPanorama];
   if (lType and WiaItemTypeBurst)<>0 then result:=result+[witBurst];
   if (lType and WiaItemTypeStorage)<>0 then result:=result+[witStorage];
   if (lType and WiaItemTypeTransfer)<>0 then result:=result+[witTransfer];
   if (lType and WiaItemTypeGenerated)<>0 then result:=result+[witGenerated];
   if (lType and WiaItemTypeHasAttachments)<>0 then result:=result+[witHasAttachments];
   if (lType and WiaItemTypeVideo)<>0 then result:=result+[witVideo];
   if (lType and WiaItemTypeTwainCapabilityPassThrough)<>0 then result:=result+[witTwainCapabilityPassThrough];
   if (lType and WiaItemTypeRemoved)<>0 then result:=result+[witRemoved];
   if (lType and WiaItemTypeMask)<>0 then result:=result+[witMask];
end;

// if not connected, connect to first device
// this free and refill al children of fRoot
function TIEWia.ShowAcquireDialog(SystemDialog:boolean):boolean;
var
   hr:HRESULT;
	items:PIWiaItemArray;
   itemsCount:integer;
   i,flags:integer;
   iewi:TIEWiaItem;
   lType:integer;
begin
	result:=false;
   if fIWiaDevMgr=nil then exit;
   ConnectToDefault;
   if fRoot=nil then exit;
	// free fRoot children
   while fRoot.Children.Count>0 do begin
      TIEWiaItem(fRoot.Children[0]).Free;
      fRoot.Children.Delete(0);
   end;
	//
   flags:=0;
   if SystemDialog then
   	flags:=flags or WIA_DEVICE_DIALOG_USE_COMMON_UI;
   hr := fRoot.This.DeviceDlg(IEFindHandle(fCtrlParent),flags,WIA_INTENT_NONE,itemsCount,items);
   if hr<>S_OK then exit;
   for i:=0 to itemsCount-1 do begin
   	iewi:=TIEWiaItem.Create;
      items[i].QueryInterface( IWiaItem ,iewi.This);
      fRoot.Children.Add(iewi);
      iewi.This.GetItemType(lType);
      iewi.ItemType:=BuildWiaItemType(lType);
      if (lType and WiaItemTypeFolder)<>0 then
   		// this is a folder
         FillItemChildren(iewi);
   end;
   CoTaskMemFree(items);
   result:=true;
end;

constructor TIEWiaItem.Create;
begin
	inherited;
   This:=nil;
   Children:=TList.Create;
   ItemType:=[];
end;

destructor TIEWiaItem.Destroy;
begin
	This:=nil;	// free the old object
   while Children.Count>0 do begin
   	TIEWiaItem(Children[0]).Free;
      Children.Delete(0);
   end;
   Children.Free;
	inherited;
end;

procedure TIEWia.FillItemChildren(parent:TIEWiaItem);
var
	hr:HRESULT;
   enum:IEnumWiaItem;
   iewi:TIEWiaItem;
   wi:IWiaItem;
   fetched,lType:integer;
begin
	if assigned(parent.This) then begin
   	// get item type of the parent (useful only if the parent is the root)
   	parent.This.GetItemType(lType);
      parent.ItemType:=BuildWiaItemType(lType);
      //
   	hr := parent.This.EnumChildItems(enum);
      if hr<>S_OK then exit;
      while enum.Next(1,wi,fetched)=S_OK do begin
			iewi:=TIEWiaItem.Create;
         iewi.This:=wi;
         parent.Children.Add(iewi);
         wi.GetItemType(lType);
         iewi.ItemType:=BuildWiaItemType(lType);
         if (lType and WiaItemTypeFolder)<>0 then
         	// this is a folder
            FillItemChildren(iewi);
      end;
      enum:=nil;
   end;
end;

function TIEWia.GetRoot:TIEWiaItem;
begin
	result:=fRoot;
end;

function GetFirstImageItem( Current:TIEWiaItem ):TIEWiaItem;
var
	i:integer;
begin
	result:=nil;
   if Current=nil then exit;
	if witImage in Current.ItemType then
   	result:=Current
   else if witFolder in Current.ItemType then
   	for i:=0 to Current.Children.Count-1 do begin
         result:=GetFirstImageItem(TIEWiaItem(Current.Children[i]));
         if result<>nil then
         	exit;	// found one
      end;
end;

(*
procedure ConvertGUIDToPROPVARIANT(gg:TGUID; outvar:PPROPVARIANT);
begin
	zeromemory(outvar,sizeof(PROPVARIANT));
   outvar.vt:=VT_CLSID;
	outvar.puuid:=
end;
*)

function ConvertPROPVARIANTGUID_ToString(invar:PPROPVARIANT):string;
begin
	result:=IEConvertGUIDToString( invar^.puuid );
end;

{$OPTIMIZATION OFF}
// this allows to get unsupported values by Variant (as GUID)
function PropVariantToVariant(vv:PPROPVARIANT):Variant;
var
	xv:variant;
begin
	if vv^.vt=VT_CLSID then begin
		result:=ConvertPROPVARIANTGUID_ToString(vv);
   end else begin
      copymemory(@TVarData(xv),vv,sizeof(PROPVARIANT));
      result:=xv;
      zeromemory(@TVarData(xv),sizeof(PROPVARIANT));
   end;
end;

// this allows to get unsupported values by Variant (as GUID)
procedure VariantToPropVariant(invar:Variant; outvar:PPROPVARIANT);
var
	xv:variant;
   IsString:boolean;
   IsStringGuid:boolean;
   ss:string;
   gg:PGUID;
begin
	IsString:= (TVarData(invar).VType and varString)<>0;
   IsStringGuid:= false;
   if IsString then begin
   	// check if it is a string guid
      ss:=invar;
      IsStringGuid:= (length(ss)=39) and (ss[10]='-') and (ss[15]='-') and (ss[20]='-') and (ss[25]='-') and (ss[1]='{') and (ss[38]='}');
   end;
	if IsStringGuid then begin
   	getmem(gg,sizeof(TGUID));
      IEConvertStringToGUID(invar,gg);
      zeromemory(outvar,sizeof(PROPVARIANT));
      outvar^.vt:=VT_CLSID;
      outvar^.puuid:=gg;
   end else begin
      xv:=invar;
      copymemory(outvar,@TVarData(xv),sizeof(PROPVARIANT));
      zeromemory(@TVarData(xv),sizeof(PROPVARIANT));
   end;
end;

// use this only with PROPVARIANTs created using VariantTopropVariant
procedure FreeCreatedPropVariant(invar:PPROPVARIANT);
var
	xv:variant;
begin
	copymemory(@TVarData(xv),invar,sizeof(PROPVARIANT));
   xv:=0;	// this frees allocated data
   zeromemory(invar,sizeof(PROPVARIANT));
   zeromemory(@TVarData(xv),sizeof(PROPVARIANT));
end;
{$OPTIMIZATION ON}

// if not connected, connect to first device
// if item is nil, search one automatically
function TIEWia.GetItemProperty( PropId:dword; item:TIEWiaItem ):Variant;
var
	hr:HRESULT;
   pIWiaPropStg:IWiaPropertyStorage;
   vPropSpec:PROPSPEC;
   vPropVar:PROPVARIANT;
begin
	pIWiaPropStg:=nil;
	ConnectToDefault;
   if not GetDefaultItem(item) then
   	exit;
	hr := item.This.QueryInterface(IWiaPropertyStorage,pIWiaPropStg);
   if hr<>S_OK then exit;
   fillchar(vPropVar,sizeof(PROPVARIANT),0);
   vPropSpec.ulKind := PRSPEC_PROPID;
   vPropSpec.propid := PropID;
   pIWiaPropStg.ReadMultiple(1, @vPropSpec, @vPropVar);
   result:=PropVariantToVariant(@vPropVar);
   FreePropVariantArray(1,@vPropVar);
end;

constructor TIEWiaValues.Create;
begin
   max:=0;
   min:=0;
   count:=0;
   normal:=0;
   step:=0;
	fValues:=nil;
end;

destructor TIEWiaValues.Destroy;
var
	i:integer;
begin
	if fValues<>nil then begin
   	for i:=0 to count-1 do
      	fValues[i]:=0;
   	freemem(fValues);
   end;
end;

function TIEWiaValues.GetValues(idx:integer):variant;
begin
	result:=fValues[idx];
end;

procedure TIEWia.GetItemPropertyAttrib( PropId:dword; item:TIEWiaItem; var attrib:TIEWiaAttrib; var values:TIEWiaValues );
var
	hr:HRESULT;
   pIWiaPropStg:IWiaPropertyStorage;
   vPropSpec:PROPSPEC;
   vPropVar:PROPVARIANT;
   i,flags:integer;
begin
	values:=TIEWiaValues.Create;
	pIWiaPropStg:=nil;
	ConnectToDefault;
   if not GetDefaultItem(item) then
   	exit;
	hr := item.This.QueryInterface(IWiaPropertyStorage,pIWiaPropStg);
   if hr<>S_OK then exit;
   fillchar(vPropVar,sizeof(PROPVARIANT),0);
   vPropSpec.ulKind := PRSPEC_PROPID;
   vPropSpec.propid := PropID;
   try
   pIWiaPropStg.GetPropertyAttributes(1,@vPropSpec, flags,@vPropVar);
   attrib:=[];
	if (flags and WIA_PROP_CACHEABLE)<>0 then attrib:=attrib+ [iewaCacheable];
   if (flags and WIA_PROP_FLAG)<>0 then attrib:=attrib+ [iewaFlag];
   if (flags and WIA_PROP_LIST)<>0 then attrib:=attrib+ [iewaList];
   if (flags and WIA_PROP_NONE)<>0 then attrib:=attrib+ [iewaNone];
   if (flags and WIA_PROP_RANGE)<>0 then attrib:=attrib+ [iewaRange];
   if (flags and WIA_PROP_READ)<>0 then attrib:=attrib+ [iewaRead];
   if (flags and WIA_PROP_SYNC_REQUIRED)<>0 then attrib:=attrib+ [iewaSyncRequired];
   if (flags and WIA_PROP_WRITE)<>0 then attrib:=attrib+ [iewaWrite];
   if (iewaRange in attrib) and ((vPropVar.vt and VT_VECTOR)<>0) and ((vPropVar.vt and VT_UI4)<>0) then begin
      // range (integers)
      if vPropVar.caul.pElems<>nil then begin
         if WIA_RANGE_MAX<vPropVar.caul.cElems then values.max := integer(vPropVar.caul.pElems[WIA_RANGE_MAX]);
         if WIA_RANGE_MIN<vPropVar.caul.cElems then values.min := integer(vPropVar.caul.pElems[WIA_RANGE_MIN]);
         if WIA_RANGE_NOM<vPropVar.caul.cElems then values.normal := integer(vPropVar.caul.pElems[WIA_RANGE_NOM]);
         if WIA_RANGE_STEP<vPropVar.caul.cElems then values.step := integer(vPropVar.caul.pElems[WIA_RANGE_STEP]);
      end;
   end else if (iewaList in attrib) and ((vPropVar.vt and VT_VECTOR)<>0) and ((vPropVar.vt and VT_UI4)<>0) then begin
      // list (integers)
      if vPropVar.caul.pElems<>nil then begin
         values.count := integer(vPropVar.caul.pElems[WIA_LIST_COUNT]);
         values.normal := integer(vPropVar.caul.pElems[WIA_LIST_NOM]);
         getmem(values.fValues,sizeof(variant)*values.count);
         for i:=WIA_LIST_VALUES to WIA_LIST_VALUES+values.count-1 do
         	values.fValues[i-WIA_LIST_VALUES] := integer(vPropVar.caul.pElems[i]);
      end;
   end else if (iewaList in attrib) and ((vPropVar.vt and VT_VECTOR)<>0) and ((vPropVar.vt and VT_CLSID)<>0) then begin
   	// list (GUIDs)
      if vPropVar.cauuid.pElems<>nil then begin
      	values.count := vPropVar.cauuid.cElems;
         values.normal := 0;
			getmem(values.fValues,sizeof(variant)*values.count);
         for i:=0 to values.count-1 do
         	values.fValues[i] := IEConvertGUIDToString( @vPropVar.cauuid.pElems[i] );
      end;
   end else if (iewaFlag in attrib) and ((vPropVar.vt and VT_VECTOR)<>0) and ((vPropVar.vt and VT_UI4)<>0) then begin
      // flag (integers), supported only nominal value
      if vPropVar.caul.pElems<>nil then
         values.normal := integer(vPropVar.caul.pElems[WIA_FLAG_NOM]);
   end;
   except
   end;
end;

function SetItemPropertyEx(PropId:dword; val:Variant; item:IWiaItem):boolean;
var
	hr:HRESULT;
   pIWiaPropStg:IWiaPropertyStorage;
   vPropSpec:PROPSPEC;
   vPropVar:PROPVARIANT;
begin
	result:=false;
	pIWiaPropStg:=nil;
	hr := item.QueryInterface(IWiaPropertyStorage,pIWiaPropStg);
   if hr<>S_OK then exit;
   fillchar(vPropVar,sizeof(PROPVARIANT),0);
   vPropSpec.ulKind := PRSPEC_PROPID;
   vPropSpec.propid := PropID;
   VariantToPropVariant(val,@vPropVar);
   hr:=pIWiaPropStg.WriteMultiple(1, @vPropSpec, @vPropVar,0);
	FreeCreatedPropVariant(@vPropVar);
   result:= hr=S_OK;
end;

// if not connected, connect to first device
// if item is nil, search one automatically
function TIEWia.SetItemProperty( PropId:dword; val:Variant; item:TIEWiaItem):boolean;
begin
	result:=false;
	ConnectToDefault;
   if not GetDefaultItem(item) then
   	exit;
   result:=SetItemPropertyEx(PropId,val,item.This);
end;

// return a valid item on if item=nil, otherwise return item
// return false if no items are available
function TIEWia.GetDefaultItem(var item:TIEWiaItem):boolean;
begin
	result:=true;
   if item=nil then begin
   	// search for an image item
      item:=GetFirstImageItem(fRoot);
      if item=nil then
      	result:=false;
   end;
end;

// if not connected, connect to first device
// if item is nil, search one automatically
function TIEWia.Transfer( item:TIEWiaItem; MultiPage:boolean ):boolean;
var
	transf:IWiaDataTransfer;
   hr:HRESULT;
   callback:TWiaDataCallBack;
   trinfo:WIA_DATA_TRANSFER_INFO;
   xitem,witem:IWiaItem;
begin
	result:=false;
   if fIWiaDevMgr=nil then exit;
	ConnectToDefault;
   if not GetDefaultItem(item) then
      exit;
   if MultiPage then begin
   	if not SetItemProperty(WIA_IPA_TYMED,WIA_TYMED_MULTIPAGE_CALLBACK,item) then
			SetItemProperty(WIA_IPA_TYMED,WIA_TYMED_CALLBACK,item);
   end;
   witem:=item.This;
   xitem:=nil;
   fRoot.This.DeviceCommand(0,@WIA_CMD_TAKE_PICTURE,xitem);	// if a new item is requested put it in witem, otherwise witem is unassigned (tehn =item.This)
	if xitem<>nil then begin
   	witem:=xitem;
      xitem:=nil;
   end;
   //
   SetItemPropertyEx(WIA_IPA_FORMAT, IEConvertGUIDToString(@WiaImgFmt_MEMORYBMP) ,witem);
	//
	hr := witem.QueryInterface(IWiaDataTransfer,transf);
   if hr<>S_OK then exit;
	callback:=TWiaDataCallBack.Create;
   callback.OnGetPage:=GetPage;
   callback.OnProgress:=fOnProgress;
   fillchar(trinfo,sizeof(trinfo),0);
   trinfo.ulSize:=sizeof(WIA_DATA_TRANSFER_INFO);
   hr := transf.idtGetBandedData(@trinfo,callback);	// callback.Destroy is called by idtGetBandedData
   if item.This<>witem then
   	witem:=nil;
   result:= hr=S_OK;
end;

function TIEWia.GetPage(header:PWIA_DATA_CALLBACK_HEADER; data:pointer; datalen:integer):boolean;
var
	iemem:TIEMemStream;
   pr:TProgressRec;
   aborting:boolean;
   tmpparams:TIOParamsVals;
   callbackParams:TIOParamsVals;
   procedure AssignIO(dest,source:TIOParamsVals);
   begin
      dest.DpiX:=source.DpiX;
      dest.DpiY:=source.DpiY;
      dest.BitsPerSample:=source.BitsPerSample;
      dest.SamplesPerPixel:=source.SamplesPerPixel;
      dest.Width:=source.Width;
      dest.Height:=source.Height;
   end;
begin
	iemem:=TIEMemStream.Create(data,datalen);
   pr.fOnProgress:=nil;
   pr.Sender:=nil;
   pr.Aborting:=@aborting;
   aborting:=false;
   tmpparams:=TIOParamsVals.Create(nil);
	if comparemem(@header.guidFormatID,@WiaImgFmt_MEMORYBMP,sizeof(TGuid)) then begin
   	// memory BMP
      BMPReadStream(iemem, ProcessingBitmap, 0, tmpparams, pr, false,true);
   end else	if comparemem(@header.guidFormatID,@WiaImgFmt_BMP,sizeof(TGuid)) then begin
   	// BMP
		BMPReadStream(iemem, ProcessingBitmap, 0, tmpparams, pr, false,false);
   end else	if comparemem(@header.guidFormatID,@WiaImgFmt_JPEG,sizeof(TGuid)) then begin
   	// JPEG
		ReadJpegStream(iemem, nil, ProcessingBitmap, tmpparams, pr, false,false);
   end;
   if assigned(fMultiCallBack) then begin
   	fMultiCallBack(ProcessingBitmap,TObject(callbackParams));
      AssignIO(callbackParams,tmpparams);
   end;
   ProcessingInfo.DPIX:=tmpparams.DpiX;
   ProcessingInfo.DPIY:=tmpparams.DpiY;
   if fCtrlParent is TImageEnIO then
   	AssignIO((fCtrlParent as TImageEnIO).Params , tmpparams);
   tmpparams.free;
   iemem.free;
	result:=true;
end;

constructor TWiaDataCallBack.Create;
begin
	data:=nil;
   datalen:=0;
   WaitingData:=false;
   OnProgress:=nil;
   OnGetPage:=nil;
end;

destructor TWiaDataCallBack.Destroy;
begin
	if data<>nil then
   	freemem(data);
	inherited;
end;

function TWiaDataCallBack.BandedDataCallback(lMessage:integer; lStatus:integer; lPercentComplete:integer; lOffset:integer; lLength:integer; lReserved:integer; lResLength:integer; pbBuffer:pbyte):HRESULT;
var
   ptr:pbyte;
   //
   procedure GetPage;
   begin
      if WaitingData and assigned(OnGetPage) then
         if not OnGetPage(@header,data,datalen) then
            result:=S_FALSE;
      WaitingData:=false;
   end;
   //
begin
	result:=S_OK;
   case lMessage of
   	IT_MSG_DATA:
      	begin
         	reallocmem(data,datalen+lLength);
            ptr:=data; inc(ptr,datalen);
            copymemory(ptr,pbBuffer,lLength);
            inc(datalen,lLength);
         end;
      IT_MSG_DATA_HEADER:
      	begin
            copymemory(@header,pbBuffer,sizeof(WIA_DATA_CALLBACK_HEADER));
            WaitingData:=true;
         end;
      IT_MSG_FILE_PREVIEW_DATA: ;
      IT_MSG_FILE_PREVIEW_DATA_HEADER: ;
      IT_MSG_NEW_PAGE:
      	begin
         	GetPage;
         end;
      IT_MSG_STATUS: ;
      IT_MSG_TERMINATION:
      	begin
         	GetPage;
         end;
   end;
   if assigned(OnProgress) then
   	if OnProgress(lPercentComplete) then
      	result:=S_OK
      else
      	result:=S_FALSE;
end;


initialization
	begin
      IEOleInitialized:=false;
   end;

finalization
	begin
   	if IEOleInitialized then
	   	OleUninitialize;
      IEOleInitialized:=false;
   end;

{$else} 	// IEINCLUDEWIA
implementation
{$endif}

end.
