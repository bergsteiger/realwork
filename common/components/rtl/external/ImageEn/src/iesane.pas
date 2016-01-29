(*
Copyright (c) 1998-2003 by HiComponents. All rights reserved.

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

unit iesane;

{$R-}
{$Q-}


{$I ie.inc}

(*$ifdef IEKYLIX*)

interface

type SANE_Byte=byte;
type PSANE_Byte=^SANE_Byte;
type SANE_Word=integer;
type SANE_Bool=SANE_Word;
type SANE_Int=SANE_Word;
type PSANE_Int=^SANE_Int;
type SANE_Char=char;
type SANE_String=PAnsiChar;
type SANE_String_Const=PAnsiChar;
type SANE_Handle=pointer;
type SANE_Fixed=SANE_Word;

const SANE_CURRENT_MAJOR=1;

function SANE_VERSION_CODE(major, minor, build:SANE_Int):SANE_Int;

function SANE_VERSION_MAJOR(code:SANE_Int):SANE_Int;

function SANE_VERSION_MINOR(code:SANE_Int):SANE_Int;

function SANE_VERSION_BUILD(code:SANE_Int):SANE_Int;

const SANE_FALSE=0;
const SANE_TRUE=1;

const SANE_FIXED_SCALE_SHIFT=16;

function SANE_FIX(v:SANE_Int):SANE_Int;

function SANE_UNFIX(v:double):double;

type SANE_Status=(
    SANE_STATUS_GOOD = 0,	(* everything A-OK *)
    SANE_STATUS_UNSUPPORTED,	(* operation is not supported *)
    SANE_STATUS_CANCELLED,	(* operation was cancelled *)
    SANE_STATUS_DEVICE_BUSY,	(* device is busy; try again later *)
    SANE_STATUS_INVAL,		(* data is invalid (includes no dev at open) *)
    SANE_STATUS_EOF,		(* no more data available (end-of-file) *)
    SANE_STATUS_JAMMED,		(* document feeder jammed *)
    SANE_STATUS_NO_DOCS,	(* document feeder out of documents *)
    SANE_STATUS_COVER_OPEN,	(* scanner cover is open *)
    SANE_STATUS_IO_ERROR,	(* error during device I/O *)
    SANE_STATUS_NO_MEM,		(* out of memory *)
    SANE_STATUS_ACCESS_DENIED	(* access to resource has been denied *)
  );

type SANE_Value_Type=(
    SANE_TYPE_BOOL = 0,
    SANE_TYPE_INT,
    SANE_TYPE_FIXED,
    SANE_TYPE_STRING,
    SANE_TYPE_BUTTON,
    SANE_TYPE_GROUP
  );

type SANE_Unit=(
    SANE_UNIT_NONE = 0,		(* the value is unit-less (e.g., # of scans) *)
    SANE_UNIT_PIXEL,		(* value is number of pixels *)
    SANE_UNIT_BIT,		(* value is number of bits *)
    SANE_UNIT_MM,		(* value is millimeters *)
    SANE_UNIT_DPI,		(* value is resolution in dots/inch *)
    SANE_UNIT_PERCENT,		(* value is a percentage *)
    SANE_UNIT_MICROSECOND	(* value is micro seconds *)
  );

type SANE_Device=record
    name:SANE_String_Const;	(* unique device name *)
    vendor:SANE_String_Const;	(* device vendor string *)
    model:SANE_String_Const;	(* device model name *)
    xtype:SANE_String_Const;	(* device type (e.g., "flatbed scanner") *)
end;
PSANE_Device=^SANE_Device;
PPSANE_Device=^PSANE_Device;

const SANE_CAP_SOFT_SELECT	= (1 shl 0);
const SANE_CAP_HARD_SELECT	= (1 shl 1);
const SANE_CAP_SOFT_DETECT	= (1 shl 2);
const SANE_CAP_EMULATED		= (1 shl 3);
const SANE_CAP_AUTOMATIC	= (1 shl 4);
const SANE_CAP_INACTIVE		= (1 shl 5);
const SANE_CAP_ADVANCED		= (1 shl 6);
const SANE_CAP_ALWAYS_SETTABLE  = (1 shl 7);

function SANE_OPTION_IS_ACTIVE(cap:SANE_Int):boolean;

function SANE_OPTION_IS_SETTABLE(cap:SANE_Int):boolean;

const SANE_INFO_INEXACT				=(1 shl 0);
const SANE_INFO_RELOAD_OPTIONS	=(1 shl 1);
const SANE_INFO_RELOAD_PARAMS		=(1 shl 2);

type SANE_Constraint_Type=
  (
    SANE_CONSTRAINT_NONE = 0,
    SANE_CONSTRAINT_RANGE,
    SANE_CONSTRAINT_WORD_LIST,
    SANE_CONSTRAINT_STRING_LIST
  );

type SANE_Range=record
    min:SANE_Word;		(* minimum (element) value *)
    max:SANE_Word;		(* maximum (element) value *)
    quant:SANE_Word;		(* quantization value (0 if none) *)
end;

type SANE_Option_Descriptor=record
    name:SANE_String_Const;	(* name of this option (command-line name) *)
    title:SANE_String_Const;	(* title of this option (single-line) *)
    desc:SANE_String_Const;	(* description of this option (multi-line) *)
    xtype:SANE_Value_Type;	(* how are values interpreted? *)
    xunit:SANE_Unit;		(* what is the (physical) unit? *)
    size:SANE_Int;
    cap:SANE_Int;		(* capabilities *)
    constraint_type:SANE_Constraint_Type;
    (*
    union
      //{
	const SANE_String_Const *string_list;	// NULL-terminated list
	const SANE_Word *word_list;	// first element is list-length
	const SANE_Range *range;
      //}
      *)
    constraint:pointer;	// see above union
end;
PSANE_Option_Descriptor=^SANE_Option_Descriptor;

type SANE_Action=
  (
    SANE_ACTION_GET_VALUE = 0,
    SANE_ACTION_SET_VALUE,
    SANE_ACTION_SET_AUTO
  );

type SANE_Frame=
  (
    SANE_FRAME_GRAY,		(* band covering human visual range *)
    SANE_FRAME_RGB,		(* pixel-interleaved red/green/blue bands *)
    SANE_FRAME_RED,		(* red band only *)
    SANE_FRAME_GREEN,	(* green band only *)
    SANE_FRAME_BLUE		(* blue band only *)
  );

type SANE_Parameters=record
    format:SANE_Frame;
    last_frame:SANE_Bool;
    bytes_per_line:SANE_Int;
    pixels_per_line:SANE_Int;
    lines:SANE_Int;
    depth:SANE_Int;
end;

type SANE_Auth_Callback=procedure(resource:SANE_String_Const; username:SANE_Char; password:SANE_Char);

const SANELIB = 'libsane.so.1';

function sane_init (var version_code:SANE_Int; authorize:SANE_Auth_Callback):SANE_Status; cdecl; external SANELIB;
procedure sane_exit ; cdecl; external SANELIB;
function sane_get_devices (var device_list:PPSANE_Device; local_only:SANE_Bool):SANE_Status; cdecl; external SANELIB;
function sane_open (devicename:SANE_String_Const; var handle:SANE_Handle):SANE_Status; cdecl; external SANELIB;
procedure sane_close (handle:SANE_Handle); cdecl; external SANELIB;
function sane_get_option_descriptor (handle:SANE_Handle; option:SANE_Int):PSANE_Option_Descriptor; cdecl; external SANELIB;
function sane_control_option (handle:SANE_Handle ; option:SANE_Int ; action:SANE_Action ; value:pointer; info:PSANE_Int):SANE_Status; cdecl; external SANELIB;
function sane_get_parameters (handle:SANE_Handle ; var params:SANE_Parameters):SANE_Status; cdecl; external SANELIB;
function sane_start (handle:SANE_Handle):SANE_Status; cdecl; external SANELIB;
function sane_read (handle:SANE_Handle ; data:PSANE_Byte; max_length:SANE_Int ; var length:SANE_Int ):SANE_Status; cdecl; external SANELIB;
procedure sane_cancel (handle:SANE_Handle); cdecl; external SANELIB;
function sane_set_io_mode (handle:SANE_Handle; non_blocking:SANE_Bool):SANE_Status; cdecl; external SANELIB;
function sane_get_select_fd (handle:SANE_Handle; var fd:SANE_Int):SANE_Status; cdecl; external SANELIB;
function sane_strstatus (status:SANE_Status):SANE_String_Const; cdecl; external SANELIB;

// IE functions
function IESANE_GetOptionNumber(shandle:SANE_Handle; const name:string):integer;
function IESANE_SetIntOption(shandle:SANE_Handle; const name:string; value:SANE_Int):boolean;
function IESANE_GetIntOption(shandle:SANE_Handle; const name:string; var value:SANE_Int):boolean;
function IESANE_SetStrOption(shandle:SANE_Handle; const name:string; value:string):boolean;

implementation

function SANE_VERSION_CODE(major, minor, build:SANE_Int):SANE_Int;
begin
	result:= ( ((SANE_Word(major) and   $ff) shl 24)
   			or ((SANE_Word(minor) and   $ff) shl 16)
   			or ((SANE_Word(build) and $ffff) shl  0));
end;

function SANE_VERSION_MAJOR(code:SANE_Int):SANE_Int;
begin
	result:= (((SANE_Word(code)) shr 24) and   $ff);
end;

function SANE_VERSION_MINOR(code:SANE_Int):SANE_Int;
begin
	result:= (((SANE_Word(code)) shr 16) and   $ff);
end;

function SANE_VERSION_BUILD(code:SANE_Int):SANE_Int;
begin
	result:= (((SANE_Word(code)) shr  0) and $ffff);
end;

function SANE_FIX(v:SANE_Int):SANE_Int;
begin
	result:= (SANE_Word((v) * (1 shl SANE_FIXED_SCALE_SHIFT)));
end;

function SANE_UNFIX(v:double):double;
begin
	result:= (v / (1 shl SANE_FIXED_SCALE_SHIFT));
end;

function SANE_OPTION_IS_ACTIVE(cap:SANE_Int):boolean;
begin
	result:= (((cap) and SANE_CAP_INACTIVE) = 0);
end;

function SANE_OPTION_IS_SETTABLE(cap:SANE_Int):boolean;
begin
	result:= (((cap) and SANE_CAP_SOFT_SELECT) <> 0);
end;

// return -1 if not present
function IESANE_GetOptionNumber(shandle:SANE_Handle; const name:string):integer;
var
	od:PSANE_Option_Descriptor;
   pcount:SANE_Int;
begin
   sane_control_option(shandle,0,SANE_ACTION_GET_VALUE,@pcount,nil);
   for result:=0 to pcount-1 do begin
		od:=sane_get_option_descriptor(shandle,result);
      if od^.name=name then
      	EXIT;
   end;
   result:=-1;
end;

function IESANE_SetIntOption(shandle:SANE_Handle; const name:string; value:SANE_Int):boolean;
var
   st:SANE_Status;
   n:integer;
begin
	n:=IESANE_GetOptionNumber(shandle,name);
   if n>-1 then begin
		st:=sane_control_option(shandle,n,SANE_ACTION_SET_VALUE,@value,nil);
		result:= st=SANE_STATUS_GOOD;
   end else
   	result:=false;
end;

function IESANE_GetIntOption(shandle:SANE_Handle; const name:string; var value:SANE_Int):boolean;
var
	st:SANE_Status;
   n:integer;
begin
	n:=IESANE_GetOptionNumber(shandle,name);
   if n>-1 then begin
		st:=sane_control_option(shandle,n,SANE_ACTION_GET_VALUE,@value,nil);
		result:= st=SANE_STATUS_GOOD;
   end else
   	result:=false;
end;


function IESANE_SetStrOption(shandle:SANE_Handle; const name:string; value:string):boolean;
var
   st:SANE_Status;
   n:integer;
begin
	n:=IESANE_GetOptionNumber(shandle,name);
   if n>-1 then begin
		st:=sane_control_option(shandle,n,SANE_ACTION_SET_VALUE,PAnsiChar(value),nil);
		result:= st=SANE_STATUS_GOOD;
   end else
   	result:=false;
end;


(*$else*)

interface
implementation

(*$endif*)

end.
