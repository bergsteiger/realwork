unit ddDoc2Rtf;

{ $Id: ddDoc2Rtf.pas,v 1.11 2015/04/28 11:08:28 lulin Exp $ }

// $Log: ddDoc2Rtf.pas,v $
// Revision 1.11  2015/04/28 11:08:28  lulin
// - рефакторим.
//
// Revision 1.10  2015/04/13 10:25:18  lulin
// - пытаемся собрать библиотеку.
//
// Revision 1.9  2015/03/26 14:32:47  lukyanets
// Отучаем даилог логина от знания про HT
//
// Revision 1.8  2014/12/15 09:55:47  fireton
// - новая версия конвертеров
//
// Revision 1.7  2014/02/18 12:17:05  fireton
// - изменился код лицензии
//
// Revision 1.6  2013/08/26 14:11:53  lulin
// - пытаемся собрать тестовое приложение.
//
// Revision 1.5  2013/07/09 06:16:32  fireton
// - более корректно обрабатываем ошибки
//
// Revision 1.4  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.3  2012/10/05 11:01:39  fireton
// - новая версия библиотеки
//
// Revision 1.2  2012/10/02 10:39:38  fireton
// - bug fix: не выдаём окно с ошибкой
//
// Revision 1.1  2012/09/04 09:40:24  fireton
// - динамическая загрузка конвертеров DOC и DOCX
//

interface

{$Include ddDefine.inc}

{$IfNDef NoZIP}
uses
 Windows,
 Classes;

function IsDocConvertAvailable: Boolean;
function IsDocxConvertAvailable: Boolean;

// возвращают блок в глобальной памяти или 0, если неудача
function ConvertDocFromStream(const aStream: TStream): THandle;
function ConvertDocxFromStream(const aStream: TStream): THandle;
{$EndIf NoZIP}

implementation

{$IfNDef NoZIP}
uses
 SysUtils,
 l3Memory;

{$Include wrs.pas}
{$Include drs.pas}

const
 cWrsDllName = 'WRS6.DLL';
 cDrsDllName = 'DRS32.DLL';

var
 WrsNewSession         : function(): LongInt; stdcall;
 WrsEndSession         : function(id: LongInt) : LongInt; stdcall;
 WrsGetLastMessage     : function(id: LongInt; message: PAnsiChar; DebugMsg: PAnsiChar): Integer; stdcall;
 WrsResetLastMessage   : function (id: LongInt) : LongBool; stdcall;
 WrsSetFlags           : function (Id: LongInt; SetReset:LongBool; flags: LongInt): LongInt; stdcall;
 WrsConvertFile        : function (id: LongInt; InFile, OutFile: PAnsiChar) : LongInt; stdcall;
 WrsConvertBuffer      : function (id: LongInt; InData: PAnsiChar; InSize: LongInt; var OutSize: LongInt) : THandle; stdcall;
 WrsConvertFileToBuffer: function (id: LongInt; InFile: PAnsiChar; var OutSize: LongInt) : THandle; stdcall;
 WrsHandleToStr        : function (buf: PAnsiChar; BufLen: LongInt; hMem: THandle): LongBool; stdcall;
 WrsSetLicenseKey      : function (LicKey: PAnsiChar) : LongInt; stdcall;

 DrsNewSession      : function (): LongInt; stdcall;
 DrsEndSession      : function (id: LongInt) : LongInt; stdcall;
 DrsGetLastMessage  : function (id: LongInt; message: PAnsiChar; DebugMsg: PAnsiChar): Integer; stdcall;
 DrsResetLastMessage: function (id: LongInt) : LongBool; stdcall;
 DrsSetFlags        : function (Id: LongInt; SetReset:LongBool; flags: LongInt): LongInt; stdcall;
 DrsConvertFile     : function (id: LongInt; InFile, OutFile: PAnsiChar) : LongInt; stdcall;
 DrsConvertBuffer   : function (id: LongInt; InData: PAnsiChar; InSize: LongInt; var OutSize: LongInt) : THandle; stdcall;
 DrsHandleToStr     : function (buf: PAnsiChar; BufLen: LongInt; hMem: THandle): LongBool; stdcall;
 DrsSetPaperSize    : function (id: LongInt; PaperSize,PaperWidth,PaperHeight: LongInt) : LongBool; stdcall;
 DrsSetPaperOrient  : function (id: LongInt; orient: LongInt) : LongBool; stdcall;
 DrsSetPageMaring   : function (id: LongInt; MargLeft,MargRight,MargTop,MargBot: LongInt) : LongBool; stdcall;
 DrsSetDownloadDir  : function (id: LongInt; DownloadDir: PAnsiChar): LongBool; stdcall;
 DrsSetLicenseInfo  : function (LicKey, LicNbr, CompanyName: PAnsiChar) : LongInt; stdcall;
 DrsGetLicenseStatus: function () : LongInt; stdcall;
 DrsSetInServer     : function (InServer: LongBool) : LongBool; stdcall;

 g_IsWrsTriedLoad: Boolean = False;
 g_WrsHandle     : HMODULE = 0;

 g_IsDrsTriedLoad: Boolean = False;
 g_DrsHandle     : HMODULE = 0;

procedure LoadWrs;
begin
 g_IsWrsTriedLoad := True;
 g_WrsHandle := LoadLibrary(cWrsDllName);
 if g_WrsHandle = 0 then
  Exit;
 @WrsNewSession          := GetProcAddress(g_WrsHandle, 'WrsNewSession');
 @WrsEndSession          := GetProcAddress(g_WrsHandle, 'WrsEndSession');
 @WrsGetLastMessage      := GetProcAddress(g_WrsHandle, 'WrsGetLastMessage');
 @WrsResetLastMessage    := GetProcAddress(g_WrsHandle, 'WrsResetLastMessage');
 @WrsSetFlags            := GetProcAddress(g_WrsHandle, 'WrsSetFlags');
 @WrsConvertFile         := GetProcAddress(g_WrsHandle, 'WrsConvertFile');
 @WrsConvertBuffer       := GetProcAddress(g_WrsHandle, 'WrsConvertBuffer');
 @WrsConvertFileToBuffer := GetProcAddress(g_WrsHandle, 'WrsConvertFileToBuffer');
 @WrsHandleToStr         := GetProcAddress(g_WrsHandle, 'WrsHandleToStr');
 @WrsSetLicenseKey       := GetProcAddress(g_WrsHandle, 'WrsSetLicenseKey');
 WrsSetLicenseKey('Y3370-92N40-MS861-36118');
end;

procedure LoadDrs;
begin
 g_IsDrsTriedLoad := True;
 g_DrsHandle := LoadLibrary(cDrsDllName);
 if g_DrsHandle = 0 then
  Exit;
 @DrsNewSession      := GetProcAddress(g_DrsHandle, 'DrsNewSession');
 @DrsEndSession      := GetProcAddress(g_DrsHandle, 'DrsEndSession');
 @DrsGetLastMessage  := GetProcAddress(g_DrsHandle, 'DrsGetLastMessage');
 @DrsResetLastMessage:= GetProcAddress(g_DrsHandle, 'DrsResetLastMessage');
 @DrsSetFlags        := GetProcAddress(g_DrsHandle, 'DrsSetFlags');
 @DrsConvertFile     := GetProcAddress(g_DrsHandle, 'DrsConvertFile');
 @DrsConvertBuffer   := GetProcAddress(g_DrsHandle, 'DrsConvertBuffer');
 @DrsHandleToStr     := GetProcAddress(g_DrsHandle, 'DrsHandleToStr');
 @DrsSetPaperSize    := GetProcAddress(g_DrsHandle, 'DrsSetPaperSize');
 @DrsSetPaperOrient  := GetProcAddress(g_DrsHandle, 'DrsSetPaperOrient');
 @DrsSetPageMaring   := GetProcAddress(g_DrsHandle, 'DrsSetPageMaring');
 @DrsSetDownloadDir  := GetProcAddress(g_DrsHandle, 'DrsSetDownloadDir');
 @DrsSetLicenseInfo  := GetProcAddress(g_DrsHandle, 'DrsSetLicenseInfo');
 @DrsGetLicenseStatus:= GetProcAddress(g_DrsHandle, 'DrsGetLicenseStatus');
 @DrsSetInServer     := GetProcAddress(g_DrsHandle, 'DrsSetInServer');
 Assert(DrsSetLicenseInfo('7RMD0-PQ260-85BC1-36118', 'srab36118-1', 'Garant') = 0, 'Ошибка лицензирования DRS32');
end;

function IsDocConvertAvailable: Boolean;
begin
 if not g_IsWrsTriedLoad then
  LoadWrs;
 Result := g_WrsHandle <> 0;
end;

function IsDocxConvertAvailable: Boolean;
begin
 if not g_IsDrsTriedLoad then
  LoadDrs;
 Result := g_DrsHandle <> 0;
end;

function ConvertDocFromStream(const aStream: TStream): THandle;
var
 l_Mem: Tl3SizedMemoryPool;
 l_OutSize: Integer;
 l_Session: Integer;
 l_Size: Integer;
begin
 Result := 0;
 if IsDocConvertAvailable then
 begin
  l_Mem := Tl3SizedMemoryPool.Create;
  try
   l_Size := aStream.Size;
   l_Mem.Size := l_Size;
   aStream.Seek(0, soFromBeginning);
   aStream.Read(l_Mem.AsPointer^, l_Size);
   l_Session := WrsNewSession;
   if l_Session <> 0 then
   try
    WrsSetFlags(l_Session, True, WRFLAG_RETURN_WRMSG_ID);
    WrsSetFlags(0, True, WRFLAG_RETURN_WRMSG_ID);
    try
     Result := WrsConvertBuffer(l_Session, l_Mem.AsPointer, l_Size, l_OutSize);
    except
     Result := 0;
    end;
   finally
    WrsEndSession(l_Session);
   end;
  finally
   FreeAndNil(l_Mem);
  end;
 end;
end;

function ConvertDocxFromStream(const aStream: TStream): THandle;
var
 l_Mem: Tl3SizedMemoryPool;
 l_OutSize: Integer;
 l_Session: Integer;
 l_Size: Integer;
begin
 Result := 0;
 if IsDocxConvertAvailable then
 begin
  l_Mem := Tl3SizedMemoryPool.Create;
  try
   l_Size := aStream.Size;
   l_Mem.Size := l_Size;
   aStream.Seek(0, soFromBeginning);
   aStream.Read(l_Mem.AsPointer^, l_Size);
   l_Session := DrsNewSession;
   if l_Session <> 0 then
   try
    DrsSetFlags(l_Session, True, DRFLAG_RETURN_MSG_ID);
    DrsSetFlags(0, True, DRFLAG_RETURN_MSG_ID);
    try
     Result := DrsConvertBuffer(l_Session, l_Mem.AsPointer, l_Size, l_OutSize);
    except
     Result := 0;
    end;
   finally
    DrsEndSession(l_Session);
   end;
  finally
   FreeAndNil(l_Mem);
  end;
 end;
end;
{$EndIf  NoZIP}

end.


