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

unit iekdef;

{$R-}
{$Q-}


{$I ie.inc}

interface

(*$ifdef IEDELPHI*)
//** DELPHI
implementation
(*$endif*)
(*$ifdef IEKYLIX*)

uses QGraphics,SyncObjs;

//** KYLIX
const
	pf24bit=pf32bit;
	INVALID_HANDLE_VALUE=$FFFFFFFF;
   BI_RGB = 0;
   BI_RLE8 = 1;
   BI_RLE4 = 2;
   BI_BITFIELDS = 3;

   VK_LBUTTON=0;

   FW_BOLD = 700;
   LANG_GREEK = $08;

type
	//pbyte=^byte;
   Bool=boolean;
	dword=cardinal;
   pword=^word;
   pinteger=^integer;

   TRGBQUAD=packed record
   	rgbBlue,rgbGreen,rgbRed,rgbReserved:byte;
   end;

   TBGRQUAD=packed record
      rgbBlue,rgbGreen,rgbRed,rgbReserved:byte;
   end;

   TLOGFONT=packed record
   	lfHeight:longint;
      lfWidth:longint;
      lfEscapement:longint;
      lfOrientation:longint;
      lfWeight:longint;
      lfItalic:byte;
      lfUnderline:byte;
      lfStrikeOut:byte;
      lfCharSet:byte;
      lfOutPrevision:byte;
      lfClipPrecision:byte;
      lfQuality:byte;
      lfPitchAnFamily:byte;
      lfFaceName:array [0..31] of AnsiChar;
   end;

   PLogFont=^TLOGFONT;

   TBGRQUADARRAY256=array [0..255] of TBGRQUAD;
   PBGRQUADARRAY256=^TBGRQUADARRAY256;

   //TByteArray=array [0..Maxint div 16] of byte;
   //PByteArray=^TByteArray;

   UInt=dword;

   HDRAWDIB=integer;

   TRTLCriticalSection=TCriticalSection;

   PBitmapCoreHeader = ^TBitmapCoreHeader;
   tagBITMAPCOREHEADER = packed record
     bcSize: DWORD;
     bcWidth: Word;
     bcHeight: Word;
     bcPlanes: Word;
     bcBitCount: Word;
   end;
   TBitmapCoreHeader = tagBITMAPCOREHEADER;
   BITMAPCOREHEADER = tagBITMAPCOREHEADER;


function HiByte(w:word):byte;
function LoByte(w:word):byte;
procedure CopyMemory(Destination: Pointer; Source: Pointer; Length: DWORD);
procedure FillMemory(Destination: Pointer; Length: DWORD; Fill: Byte);
procedure ZeroMemory(Destination: Pointer; Length: DWORD);
function AllocMem(Size:integer):pointer;
procedure GetTempPath(maxsz:integer; temppath:PAnsiChar);
procedure GetTempFileName(path:PAnsiChar;nm:string;d:integer;tmpfile:PAnsiChar);
procedure ExpandBGR2BGRA(row:pbyte; width:integer);

// critical sections
procedure InitializeCriticalSection(var CS:TRTLCriticalSection);
procedure DeleteCriticalSection(var CS:TRTLCriticalSection);
procedure EnterCriticalSection(var CS:TRTLCriticalSection);
procedure LeaveCriticalSection(var CS:TRTLCriticalSection);

// threads
function GetCurrentThreadId:integer;

// others
procedure OutputDebugString(ss:string);
function IEDirectoryExists(const Name: string): Boolean;
function GetAsyncKeyState(key:integer):integer;


implementation

uses SysUtils, libc;

function HiByte(w:word):byte;
begin
	result:=w shr 8;
end;

function LoByte(w:word):byte;
begin
	result:=w and $FF;
end;

procedure CopyMemory(Destination: Pointer; Source: Pointer; Length: DWORD);
begin
	move(pbyte(source)^,pbyte(destination)^,Length);
end;

procedure FillMemory(Destination: Pointer; Length: DWORD; Fill: Byte);
begin
	fillchar(pbyte(Destination)^,Length,Fill);
end;

procedure ZeroMemory(Destination: Pointer; Length: DWORD);
begin
	fillchar(pbyte(Destination)^,Length,0);
end;

function AllocMem(Size:integer):pointer;
begin
	getmem(result,Size);
   fillchar(pbyte(result)^,Size,0);
end;

procedure GetTempPath(maxsz:integer; temppath:PAnsiChar);
begin
	StrPCopy(temppath,'/tmp');
end;

procedure GetTempFileName(path:PAnsiChar;nm:string;d:integer;tmpfile:PAnsiChar);
begin
	tmpnam(tmpfile);
end;

procedure ExpandBGR2BGRA(row:pbyte; width:integer);
var
	buf,tmp,src:pbyte;
   q:integer;
   r,g,b:byte;
begin
	getmem(buf,width*4);
   tmp:=buf;
   src:=row;
   for q:=0 to width-1 do begin
   	b:=row^; inc(row);
		g:=row^; inc(row);
      r:=row^; inc(row);
      tmp^:=r; inc(tmp);
      tmp^:=g; inc(tmp);
      tmp^:=b; inc(tmp);
      tmp^:=0; inc(tmp);
   end;
   move(buf^,src^,width*4);
   freemem(buf);
end;

procedure InitializeCriticalSection(var CS:TRTLCriticalSection);
begin
	CS:=TRTLCriticalSection.Create;
end;

procedure DeleteCriticalSection(var CS:TRTLCriticalSection);
begin
	CS.free;
end;

procedure EnterCriticalSection(var CS:TRTLCriticalSection);
begin
	CS.Acquire;
end;

procedure LeaveCriticalSection(var CS:TRTLCriticalSection);
begin
	CS.Release;
end;

function GetCurrentThreadId:integer;
begin
	//result:=getpid;
   result:=pthread_self;
end;

// not implemented
procedure OutputDebugString(ss:string);
begin
end;

function IEDirectoryExists(const Name: string): Boolean;
begin
	result:=DirectoryExists(Name);
end;

// not implemented
function GetAsyncKeyState(key:integer):integer;
begin
	result:=0;
end;

(*$endif*)

end.
