unit m3SplittedFileStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3SplittedFileStream.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::Streams::Tm3SplittedFileStream
//
// Файловый поток порезанный на куски
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3Interfaces,
  l3ProtoDataContainer,
  m3BaseStream,
  m3FileStream,
  l3Types,
  l3Memory,
  l3Core,
  l3Except,
  Classes,
  m3StorageInterfaces
  ;

type
 Tm3InnerFileStream = class(Tm3FileStream)
 end;//Tm3InnerFileStream

 _ItemType_ = Tm3InnerFileStream;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 _l3OpenArray_Parent_ = _l3UncomparabeObjectRefList_;
{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
 Tm3InnerFileStreamList = class(_l3OpenArray_)
 end;//Tm3InnerFileStreamList

const
  { Constants }
 m3_cInfoFileNameExt = '.cnt';

type
 Tm3SplittedFileStream = class(Tm3BaseStream)
  {* Файловый поток порезанный на куски }
 private
 // private fields
   f_SharedMode : Cardinal;
   f_Distribution : Cardinal;
   f_Flags : Cardinal;
   f_Name : WideString;
   f_OpenedStreams : Tm3InnerFileStreamList;
   f_Position : Int64;
   f_Access : Cardinal;
   f_SizeLimit : Int64;
   f_Ext : AnsiString;
   f_AnsiName : AnsiString;
   f_InfoStream : Tm3FileStream;
   f_FilesCount : Integer;
    {* Поле для свойства FilesCount}
 private
 // private methods
   function FileByPos(aPos: Int64;
     var theFileOffset: Int64): Tm3InnerFileStream;
   function FileNameByIndex(anIndex: Integer): AnsiString;
   function FileIndexByPos(aPos: Int64): Integer;
   function NormalizePartSize(aPos: Int64;
     aSize: Integer): Integer;
   function CheckInfoStream(aNeedCreate: Boolean): Boolean;
 protected
 // property methods
   function pm_GetFilesCount: Integer;
   procedure pm_SetFilesCount(aValue: Integer);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure DoRead(aBuff: Pointer;
     aSize: Integer;
     var theResult: Integer;
     var theReturn: hResult); override;
   procedure DoWrite(aBuff: Pointer;
     aSize: Integer;
     var theResult: Integer;
     var theReturn: hResult); override;
   procedure DoSeek(anOffset: Int64;
     anOrigin: TSeekOrigin;
     var theResult: Int64;
     var theReturn: hResult); override;
   procedure DoSetSize(aSize: Int64;
     var theReturn: hResult); override;
   procedure LockRegion(anOffset: Int64;
     aSize: Int64;
     aLockType: Integer;
     var theReturn: hResult); override;
   procedure UnlockRegion(anOffset: Int64;
     aSize: Int64;
     aLockType: Integer;
     var theReturn: hResult); override;
   procedure Stat(var theStatStg: TStatStg;
     aStatFlag: Integer;
     var theReturn: hResult); override;
   function DoGetPosition: Int64; override;
   function DoGetSize: Int64; override;
   function DoGetLocksSupported: Integer; override;
   function DoGetName: WideString; override;
 public
 // overridden public methods
   procedure Commit(aFlags: Integer;
     var theReturn: hResult); override;
 public
 // public methods
   constructor Create(const aName: WideString;
     anAccess: Cardinal;
     aSharedMode: Cardinal;
     aDistribution: Cardinal;
     aFlags: Cardinal); reintroduce;
   class function Make(const aName: WideString;
     anAccess: Cardinal;
     aSharedMode: Cardinal;
     aDistribution: Cardinal;
     aFlags: Cardinal): IStream; reintroduce;
     {* Сигнатура фабрики Tm3SplittedFileStream.Make }
   class function NormalizeFileName(const aFileName: AnsiString): AnsiString;
   class procedure SetDefaultSizeLimit(aValue: Cardinal);
 protected
 // protected properties
   property FilesCount: Integer
     read pm_GetFilesCount
     write pm_SetFilesCount;
 end;//Tm3SplittedFileStream

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils,
  Windows,
  ActiveX,
  l3String,
  l3FileUtils,
  m2COMLib,
  l3Stream,
  ComObj
  ;

var
   g_DefaultSizeLimit : Cardinal = 0;

// start class Tm3SplittedFileStream

function Tm3SplittedFileStream.FileByPos(aPos: Int64;
  var theFileOffset: Int64): Tm3InnerFileStream;
//#UC START# *4FA3AF4E0094_4FA278B00247_var*
var
 l_Index : Integer;
 l_Count : Integer;
//#UC END# *4FA3AF4E0094_4FA278B00247_var*
begin
//#UC START# *4FA3AF4E0094_4FA278B00247_impl*
 l_Index := FileIndexByPos(aPos);
 theFileOffset := l_Index * f_SizeLimit;
 Result := f_OpenedStreams[l_Index].Use;
 if (Result = nil) then
 begin
  Result := Tm3InnerFileStream.Create(FileNameByIndex(l_Index),
                                      f_Access,
                                      f_SharedMode,
                                      f_Distribution,
                                      f_Flags);
  l_Count := f_OpenedStreams.Count;
  f_OpenedStreams[l_Index] := Result;
  if (f_OpenedStreams.Count <> l_Count) then
   FilesCount := f_OpenedStreams.Count;
 end;//Result = nil
//#UC END# *4FA3AF4E0094_4FA278B00247_impl*
end;//Tm3SplittedFileStream.FileByPos

function Tm3SplittedFileStream.FileNameByIndex(anIndex: Integer): AnsiString;
//#UC START# *4FA3B62102E6_4FA278B00247_var*
//#UC END# *4FA3B62102E6_4FA278B00247_var*
begin
//#UC START# *4FA3B62102E6_4FA278B00247_impl*
 Result := NormalizeFileName(f_AnsiName) + '.' + Format('%.4x', [anIndex]){IntToStr(anIndex)} + f_Ext;
//#UC END# *4FA3B62102E6_4FA278B00247_impl*
end;//Tm3SplittedFileStream.FileNameByIndex

function Tm3SplittedFileStream.FileIndexByPos(aPos: Int64): Integer;
//#UC START# *4FA3BFAE01B0_4FA278B00247_var*
//#UC END# *4FA3BFAE01B0_4FA278B00247_var*
begin
//#UC START# *4FA3BFAE01B0_4FA278B00247_impl*
 Result := aPos div f_SizeLimit;
//#UC END# *4FA3BFAE01B0_4FA278B00247_impl*
end;//Tm3SplittedFileStream.FileIndexByPos

function Tm3SplittedFileStream.NormalizePartSize(aPos: Int64;
  aSize: Integer): Integer;
//#UC START# *4FA4EF94004A_4FA278B00247_var*
//#UC END# *4FA4EF94004A_4FA278B00247_var*
begin
//#UC START# *4FA4EF94004A_4FA278B00247_impl*
 if (aPos + aSize > f_SizeLimit) then
  Result := (f_SizeLimit - aPos)
 else
  Result := aSize;
//#UC END# *4FA4EF94004A_4FA278B00247_impl*
end;//Tm3SplittedFileStream.NormalizePartSize

function Tm3SplittedFileStream.CheckInfoStream(aNeedCreate: Boolean): Boolean;
//#UC START# *4FA52DFA0143_4FA278B00247_var*
var
 l_Name : AnsiString;
//#UC END# *4FA52DFA0143_4FA278B00247_var*
begin
//#UC START# *4FA52DFA0143_4FA278B00247_impl*
 Result := true;
 if (f_InfoStream = nil) then
 begin
  l_Name := NormalizeFileName(f_AnsiName) + m3_cInfoFileNameExt + f_Ext;
  if not aNeedCreate OR Self.ReadOnly then
   if not FileExists(l_Name) then
   begin
    Result := false;
    Exit;
   end;//not FileExists(l_Name)
  f_InfoStream := Tm3FileStream.Create(l_Name,
                                       f_Access,
                                       f_SharedMode,
                                       f_Distribution,
                                       f_Flags);
 end;//f_InfoStream = nil
//#UC END# *4FA52DFA0143_4FA278B00247_impl*
end;//Tm3SplittedFileStream.CheckInfoStream

constructor Tm3SplittedFileStream.Create(const aName: WideString;
  anAccess: Cardinal;
  aSharedMode: Cardinal;
  aDistribution: Cardinal;
  aFlags: Cardinal);
//#UC START# *4FA27BC90091_4FA278B00247_var*

 function lGetAccess(const AAccess: Cardinal): Integer;
 begin//lGetAccess
  if ((AAccess and (GENERIC_READ or GENERIC_WRITE)) =
       (GENERIC_READ or GENERIC_WRITE)) then
   Result := STGM_READWRITE
  else
  begin
   if ((AAccess and GENERIC_WRITE) <> 0) then
    Result := STGM_WRITE
   else
    Result := STGM_READ;
  end;//((AAccess and (GENERIC_READ or GENERIC_WRITE)) =..
 end;//lGetAccess

var 
 l_S   : Tm3InnerFileStream;
 l_Ofs : Int64;
 l_FirstFileSize : Int64;
 l_FilesCount : Integer;
//#UC END# *4FA27BC90091_4FA278B00247_var*
begin
//#UC START# *4FA27BC90091_4FA278B00247_impl*
 f_FilesCount := -1;
 inherited Create(lGetAccess(anAccess));
 f_SizeLimit := g_DefaultSizeLimit;
 if (f_SizeLimit = 0) then
 begin
  f_SizeLimit := 2 * 1024 * 1024;
  f_SizeLimit := f_SizeLimit * 1024;
 end;//f_SizeLimit = 0
 f_Position := 0;
 f_Name := aName;
 f_Access := anAccess;
 f_SharedMode := aSharedMode;
 f_Distribution := aDistribution;
 f_Flags := aFlags;
 f_AnsiName := l3Str(f_Name);
 f_Ext := ExtractFileExt(f_AnsiName);
 f_OpenedStreams := Tm3InnerFileStreamList.Create;
 l_FilesCount := FilesCount;
 f_OpenedStreams.Count := l_FilesCount;
 if (l_FilesCount > 0) then
 begin
  l_S := FileByPos(f_Position, l_Ofs);
  try
   if (l_S <> nil) then
   begin
    l_FirstFileSize := m2COMGetSize(l_S);
    if (l_FirstFileSize > f_SizeLimit) then
     raise Exception.CreateFmt('Размер файла %d больше размера куска %d', [l_FirstFileSize, f_SizeLimit]);
    if (l_FirstFileSize < f_SizeLimit) then
     if (l_FilesCount > 1) then
      raise Exception.CreateFmt('Размер файла %d меньше размера куска %d', [l_FirstFileSize, f_SizeLimit]);
   end;//l_S <> nil
  finally
   FreeAndNil(l_S);
  end;//try..finally
 end;//l_FilesCount > 0
(* f_RealStream := Tm3InnerFileStream.Create(aName,
                                           anAccess,
                                           aSharedMode,
                                           aDistribution,
                                           aFlags);*)
//#UC END# *4FA27BC90091_4FA278B00247_impl*
end;//Tm3SplittedFileStream.Create

class function Tm3SplittedFileStream.Make(const aName: WideString;
  anAccess: Cardinal;
  aSharedMode: Cardinal;
  aDistribution: Cardinal;
  aFlags: Cardinal): IStream;
var
 l_Inst : Tm3SplittedFileStream;
begin
 l_Inst := Create(aName, anAccess, aSharedMode, aDistribution, aFlags);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

class function Tm3SplittedFileStream.NormalizeFileName(const aFileName: AnsiString): AnsiString;
//#UC START# *4FBB8E7F0101_4FA278B00247_var*
//#UC END# *4FBB8E7F0101_4FA278B00247_var*
begin
//#UC START# *4FBB8E7F0101_4FA278B00247_impl*
 Result := ChangeFileExt(aFileName, '');
//#UC END# *4FBB8E7F0101_4FA278B00247_impl*
end;//Tm3SplittedFileStream.NormalizeFileName

class procedure Tm3SplittedFileStream.SetDefaultSizeLimit(aValue: Cardinal);
//#UC START# *540F18CB01AF_4FA278B00247_var*
//#UC END# *540F18CB01AF_4FA278B00247_var*
begin
//#UC START# *540F18CB01AF_4FA278B00247_impl*
 g_DefaultSizeLimit := aValue;
//#UC END# *540F18CB01AF_4FA278B00247_impl*
end;//Tm3SplittedFileStream.SetDefaultSizeLimit{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}
{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

// start class Tm3InnerFileStreamList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4FA3D66401BD_var*
//#UC END# *47B2C42A0163_4FA3D66401BD_var*
begin
//#UC START# *47B2C42A0163_4FA3D66401BD_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4FA3D66401BD_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4FA3D66401BD_var*
//#UC END# *47B99D4503A2_4FA3D66401BD_var*
begin
//#UC START# *47B99D4503A2_4FA3D66401BD_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4FA3D66401BD_impl*
end;//CompareExistingItems

type _Instance_R_ = Tm3InnerFileStreamList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}


{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}

// start class Tm3SplittedFileStream

function Tm3SplittedFileStream.pm_GetFilesCount: Integer;
//#UC START# *4FA3CE4C03CB_4FA278B00247get_var*
const
 cMaxTry = 10;
var
 l_TryCount : Integer;
//#UC END# *4FA3CE4C03CB_4FA278B00247get_var*
begin
//#UC START# *4FA3CE4C03CB_4FA278B00247get_impl*
 if (f_FilesCount >= 0) then
 begin
  Result := f_FilesCount;
  Exit;
 end;//f_FilesCount >= 0
 if CheckInfoStream(false) then
 begin
  Assert(f_InfoStream <> nil);
  m2COMTimeLock(f_InfoStream, 0, SizeOf(Result));
  try
   l_TryCount := 0;
   while (l_TryCount < cMaxTry) do
   begin
    Inc(l_TryCount);
    m2COMSetPosition(0, f_InfoStream);
    try
     if (m2COMReadBuffer(f_InfoStream, Result, SizeOf(Result)) <> SizeOf(Result)) then
      raise Exception.CreateFmt('Ошибка при чтении числа файлов из %s', [NormalizeFileName(f_AnsiName) + m3_cInfoFileNameExt + f_Ext]);
    except
     if (l_TryCount < cMaxTry) then
     begin
      l3System.Msg2Log('Попытка чтения FilesCount номер ' + IntToStr(l_TryCount));
      continue;
     end//l_TryCount < cMaxTry
     else
      raise;
    end;//try..except
    break;
   end;//while l_TryCount < cMaxTry
  finally
   m2COMTimeUnlock(f_InfoStream, 0, SizeOf(Result));
  end;//try..finally
 end//CheckInfoStream(false)
 else
  Result := 0;
 if (f_SharedMode = 0) OR (f_SharedMode = FILE_SHARE_READ) then
  f_FilesCount := Result;
//#UC END# *4FA3CE4C03CB_4FA278B00247get_impl*
end;//Tm3SplittedFileStream.pm_GetFilesCount

procedure Tm3SplittedFileStream.pm_SetFilesCount(aValue: Integer);
//#UC START# *4FA3CE4C03CB_4FA278B00247set_var*
//#UC END# *4FA3CE4C03CB_4FA278B00247set_var*
begin
//#UC START# *4FA3CE4C03CB_4FA278B00247set_impl*
 if (aValue <= FilesCount) then
  // - по идее - размер файла уменьшаться не может, а значит и количество кусков - тоже
  //   ну и заодним пытаемся защититься от конфликта при многопользовательском доступе
  Exit;
 if Self.ReadOnly then
  Exit; 
 CheckInfoStream(true);
 Assert(f_InfoStream <> nil);
 m2COMTimeLock(f_InfoStream, 0, SizeOf(aValue));
 try
  m2COMSetPosition(0, f_InfoStream);
  if (m2COMWriteBuffer(f_InfoStream, aValue, SizeOf(aValue)) <> SizeOf(aValue)) then
   raise Exception.CreateFmt('Ошибка при записи числа файлов в %s', [NormalizeFileName(f_AnsiName) + m3_cInfoFileNameExt + f_Ext]);
 finally
  m2COMTimeUnlock(f_InfoStream, 0, SizeOf(aValue));
 end;//try..finally
 if (f_SharedMode = 0) OR (f_SharedMode = FILE_SHARE_READ) then
  f_FilesCount := aValue
 else
  f_FilesCount := -1; 
//#UC END# *4FA3CE4C03CB_4FA278B00247set_impl*
end;//Tm3SplittedFileStream.pm_SetFilesCount

procedure Tm3SplittedFileStream.Cleanup;
//#UC START# *479731C50290_4FA278B00247_var*
//#UC END# *479731C50290_4FA278B00247_var*
begin
//#UC START# *479731C50290_4FA278B00247_impl*
 FreeAndNil(f_OpenedStreams);
 FreeAndNil(f_InfoStream);
 inherited;
//#UC END# *479731C50290_4FA278B00247_impl*
end;//Tm3SplittedFileStream.Cleanup

procedure Tm3SplittedFileStream.DoRead(aBuff: Pointer;
  aSize: Integer;
  var theResult: Integer;
  var theReturn: hResult);
//#UC START# *4FA27CF501C4_4FA278B00247_var*
var
 l_Pos : Int64;
 l_NewPos : Int64;
 l_S   : Tm3InnerFileStream;
 l_Ofs : Int64;
 l_Read : Integer;
//#UC END# *4FA27CF501C4_4FA278B00247_var*
begin
//#UC START# *4FA27CF501C4_4FA278B00247_impl*
 if not SUCCEEDED(theReturn) then
 begin
  Assert(false);
  Exit;
 end;//not SUCCEEDED(theReturn)
 theResult := 0;
 while (aSize > 0) do
 begin
  l_S := FileByPos(f_Position, l_Ofs);
  try
   l_Read := 0;
   l_Pos := f_Position - l_Ofs;
   l_S.DoSeek(l_Pos, soBeginning, l_NewPos, theReturn);
   OleCheck(theReturn);
   Assert(l_Pos = l_NewPos);
   //m2ComSetPosition(l_Pos, l_S);
   l_S.DoRead(aBuff, NormalizePartSize(l_Pos, aSize), l_Read, theReturn);
   OleCheck(theReturn);
   if (l_Read = 0) then
    break; 
   Inc(PAnsiChar(aBuff), l_Read);
   Dec(aSize, l_Read);
   Inc(theResult, l_Read);
   Inc(f_Position, l_Read);
  finally
   FreeAndNil(l_S);
  end;//try..finally
 end;//while (aSize > 0)
 //f_RealStream.Read(aBuff, aSize, theResult, theReturn);
//#UC END# *4FA27CF501C4_4FA278B00247_impl*
end;//Tm3SplittedFileStream.DoRead

procedure Tm3SplittedFileStream.DoWrite(aBuff: Pointer;
  aSize: Integer;
  var theResult: Integer;
  var theReturn: hResult);
//#UC START# *4FA27D310344_4FA278B00247_var*
var
 l_Pos : Int64;
 l_NewPos : Int64;
 l_S   : Tm3InnerFileStream;
 l_Ofs : Int64;
 l_Written : Integer;
 l_Size : Int64;
 l_NewSize : Int64;
 l_Res : hResult;
//#UC END# *4FA27D310344_4FA278B00247_var*
begin
//#UC START# *4FA27D310344_4FA278B00247_impl*
 if not SUCCEEDED(theReturn) then
 begin
  Assert(false);
  Exit;
 end;//not SUCCEEDED(theReturn)
 theResult := 0;
 while (aSize > 0) do
 begin
  l_S := FileByPos(f_Position, l_Ofs);
  try
   l_Written := 0;
   l_Pos := f_Position - l_Ofs;
   l_S.DoSeek(l_Pos, soBeginning, l_NewPos, theReturn);
   OleCheck(theReturn);
   Assert(l_Pos = l_NewPos);
   //m2ComSetPosition(l_Pos, l_S);
   l_Size := l_S.DoGetSize;
   l_S.DoWrite(aBuff, NormalizePartSize(l_Pos, aSize), l_Written, theReturn);
   OleCheck(theReturn);
   if (l_Written = 0) then
   begin
    Assert(false);
    break;
   end;//l_Written = 0
   l_NewSize := l_S.DoGetSize;
   if (l_Size < l_NewSize) then
   begin
    if (l_Size mod 1024 = 0) OR
       (l_NewSize mod 1024 = 0) OR
       (l_NewSize mod 1000 = 0) then
    begin
     l_Res := S_Ok;
     l_S.Commit(STGC_DEFAULT, l_Res);
     if (l_Res <> S_Ok) then
      raise Exception.CreateFmt('Не смогли сбросить содержимое файла %s на диск', [FileNameByIndex(FileIndexByPos(f_Position))]);
    end;//l_Size mod 1000 = 0
   end;//l_Size <> l_S.Size
   Inc(PAnsiChar(aBuff), l_Written);
   Dec(aSize, l_Written);
   Inc(theResult, l_Written);
   Inc(f_Position, l_Written);
  finally
   FreeAndNil(l_S);
  end;//try..finally
 end;//while (aSize > 0)
 //f_RealStream.Write(aBuff, aSize, theResult, theReturn);
//#UC END# *4FA27D310344_4FA278B00247_impl*
end;//Tm3SplittedFileStream.DoWrite

procedure Tm3SplittedFileStream.DoSeek(anOffset: Int64;
  anOrigin: TSeekOrigin;
  var theResult: Int64;
  var theReturn: hResult);
//#UC START# *4FA27D5302C5_4FA278B00247_var*
(*var
 l_S : Tm3InnerFileStream;
 l_Ofs : Int64;
 l_Pos : Int64;*)
//#UC END# *4FA27D5302C5_4FA278B00247_var*
begin
//#UC START# *4FA27D5302C5_4FA278B00247_impl*
 if not SUCCEEDED(theReturn) then
 begin
  Assert(false);
  Exit;
 end;//not SUCCEEDED(theReturn)
 Case anOrigin of
  soBeginning:
   f_Position := anOffset;
  soCurrent:
   f_Position := f_Position + anOffset;
  soEnd:
  begin
   Assert(anOffset <= 0);
   f_Position := {f_Position + }DoGetSize + anOffset;
(*   if (anOffset = 0) then
   begin
    l_S := FileByPos(f_Position, l_Ofs);
    try
     Assert(l_S <> nil);
     l_Pos := l_Ofs + m2COMSeek(l_S, 0, STREAM_SEEK_END);
     Assert(l_Pos >= f_Position);
     f_Position := l_Pos;
    finally
     FreeAndNil(l_S);
    end;//try..finally
   end;//anOffset = 0*)
  end;//soEnd
  else
   raise Exception.Create('Неверный Origin для Seek');
 end;//Case anOrigin
 Assert(f_Position >= 0);
 theResult := f_Position;
 //Assert(f_Position <= Pm_GetSize);
 //f_RealStream.Seek(anOffset, anOrigin, theResult, theReturn);
//#UC END# *4FA27D5302C5_4FA278B00247_impl*
end;//Tm3SplittedFileStream.DoSeek

procedure Tm3SplittedFileStream.DoSetSize(aSize: Int64;
  var theReturn: hResult);
//#UC START# *4FA27DCD02B4_4FA278B00247_var*
//#UC END# *4FA27DCD02B4_4FA278B00247_var*
begin
//#UC START# *4FA27DCD02B4_4FA278B00247_impl*
 if not SUCCEEDED(theReturn) then
 begin
  Assert(false);
  Exit;
 end;//not SUCCEEDED(theReturn)
 Assert(false, 'По идее - не надо изменять напрямую размер такого потока. Всплывёт - будем разбираться');
 //f_RealStream.SetSize(aSize, theReturn);
//#UC END# *4FA27DCD02B4_4FA278B00247_impl*
end;//Tm3SplittedFileStream.DoSetSize

procedure Tm3SplittedFileStream.LockRegion(anOffset: Int64;
  aSize: Int64;
  aLockType: Integer;
  var theReturn: hResult);
//#UC START# *4FA27E100218_4FA278B00247_var*
var
 l_Pos : Int64;
 l_S   : Tm3InnerFileStream;
 l_Ofs : Int64;
 l_FileIndexOfBegin : Integer;
 l_FileIndexOfEnd : Integer;
 l_SizeToLock     : Int64;
//#UC END# *4FA27E100218_4FA278B00247_var*
begin
//#UC START# *4FA27E100218_4FA278B00247_impl*
 if not SUCCEEDED(theReturn) then
 begin
  Assert(false);
  Exit;
 end;//not SUCCEEDED(theReturn)
 if (f_SharedMode = 0) OR (f_SharedMode = FILE_SHARE_READ) then
  Exit;
 l_Pos := {f_Position + }anOffset;
 l_FileIndexOfBegin := FileIndexByPos(l_Pos);
 l_FileIndexOfEnd := FileIndexByPos(l_Pos + aSize);
 //Assert(l_FileIndexOfBegin = l_FileIndexOfEnd, 'Залочка попала на границу файлов');
 if (l_FileIndexOfBegin <> l_FileIndexOfEnd) then
 begin
  l_S := FileByPos(l_Pos, l_Ofs);
  try
   l_SizeToLock := {m2COMGetSize(l_S)}f_SizeLimit - (anOffset - l_Ofs);
   l_S.LockRegion(anOffset - l_Ofs, l_SizeToLock, aLockType, theReturn);
  finally
   FreeAndNil(l_S);
  end;//try..finally
  OleCheck(theReturn);
  l_S := FileByPos(l_Pos + aSize, l_Ofs);
  try
   l_S.LockRegion(0, aSize - l_SizeToLock, aLockType, theReturn);
  finally
   FreeAndNil(l_S);
  end;//try..finally
 end//l_FileIndexOfBegin <> l_FileIndexOfEnd
 else
 begin
  l_S := FileByPos(l_Pos, l_Ofs);
  try
   l_S.LockRegion(anOffset - l_Ofs, aSize, aLockType, theReturn);
  finally
   FreeAndNil(l_S);
  end;//try..finally
 end;//l_FileIndexOfBegin <> l_FileIndexOfEnd
 //f_RealStream.LockRegion(anOffset, aSize, aLockType, theReturn);
//#UC END# *4FA27E100218_4FA278B00247_impl*
end;//Tm3SplittedFileStream.LockRegion

procedure Tm3SplittedFileStream.UnlockRegion(anOffset: Int64;
  aSize: Int64;
  aLockType: Integer;
  var theReturn: hResult);
//#UC START# *4FA27E4C0342_4FA278B00247_var*
var
 l_Pos : Int64;
 l_S   : Tm3InnerFileStream;
 l_Ofs : Int64;
 l_FileIndexOfBegin : Integer;
 l_FileIndexOfEnd : Integer;
 l_SizeToLock     : Int64;
//#UC END# *4FA27E4C0342_4FA278B00247_var*
begin
//#UC START# *4FA27E4C0342_4FA278B00247_impl*
 if not SUCCEEDED(theReturn) then
 begin
  Assert(false);
  Exit;
 end;//not SUCCEEDED(theReturn)
 if (f_SharedMode = 0) OR (f_SharedMode = FILE_SHARE_READ) then
  Exit;
 l_Pos := {f_Position + }anOffset;
 l_FileIndexOfBegin := FileIndexByPos(l_Pos);
 l_FileIndexOfEnd := FileIndexByPos(l_Pos + aSize);
 //Assert(l_FileIndexOfBegin = l_FileIndexOfEnd, 'Залочка попала на границу файлов');
 if (l_FileIndexOfBegin <> l_FileIndexOfEnd) then
 begin
  l_S := FileByPos(l_Pos, l_Ofs);
  try
   l_SizeToLock := {m2COMGetSize(l_S)}f_SizeLimit - (anOffset - l_Ofs);
   l_S.UnlockRegion(anOffset - l_Ofs, l_SizeToLock, aLockType, theReturn);
  finally
   FreeAndNil(l_S);
  end;//try..finally
  OleCheck(theReturn);
  l_S := FileByPos(l_Pos + aSize, l_Ofs);
  try
   l_S.UnlockRegion(0, aSize - l_SizeToLock, aLockType, theReturn);
  finally
   FreeAndNil(l_S);
  end;//try..finally
 end//l_FileIndexOfBegin <> l_FileIndexOfEnd
 else
 begin
  l_S := FileByPos(l_Pos, l_Ofs);
  try
   l_S.UnlockRegion(anOffset - l_Ofs, aSize, aLockType, theReturn);
  finally
   FreeAndNil(l_S);
  end;//try..finally
 end;//l_FileIndexOfBegin <> l_FileIndexOfEnd
 //f_RealStream.UnlockRegion(anOffset, aSize, aLockType, theReturn);
//#UC END# *4FA27E4C0342_4FA278B00247_impl*
end;//Tm3SplittedFileStream.UnlockRegion

procedure Tm3SplittedFileStream.Stat(var theStatStg: TStatStg;
  aStatFlag: Integer;
  var theReturn: hResult);
//#UC START# *4FA27E6A001B_4FA278B00247_var*
//#UC END# *4FA27E6A001B_4FA278B00247_var*
begin
//#UC START# *4FA27E6A001B_4FA278B00247_impl*
 inherited;
 //f_RealStream.Stat(theStatStg, aStatFlag, theReturn);
//#UC END# *4FA27E6A001B_4FA278B00247_impl*
end;//Tm3SplittedFileStream.Stat

function Tm3SplittedFileStream.DoGetPosition: Int64;
//#UC START# *4FA280090314_4FA278B00247_var*
//#UC END# *4FA280090314_4FA278B00247_var*
begin
//#UC START# *4FA280090314_4FA278B00247_impl*
 Result := f_Position;
 //Result := f_RealStream.Pm_GetPosition;
//#UC END# *4FA280090314_4FA278B00247_impl*
end;//Tm3SplittedFileStream.DoGetPosition

function Tm3SplittedFileStream.DoGetSize: Int64;
//#UC START# *4FA2802E0231_4FA278B00247_var*
var
 l_C : Integer;
 //l_Res : hResult;
 l_S : Tm3InnerFileStream;
 l_Ofs : Int64;
//#UC END# *4FA2802E0231_4FA278B00247_var*
begin
//#UC START# *4FA2802E0231_4FA278B00247_impl*
 l_C := Max(f_OpenedStreams.Count, FilesCount) - 1;
 if (l_C < 0) then
  Result := 0
 else
 begin
  l_S := FileByPos(l_C * f_SizeLimit, l_Ofs);
  try
   Assert(l_S <> nil);
   Result := l_Ofs + m2COMSeek(l_S, 0, STREAM_SEEK_END);
   //Assert(l_Pos >= f_Position);
   //f_Position := l_Pos;
  finally
   FreeAndNil(l_S);
  end;//try..finally

(*  l_S := f_OpenedStreams[l_C];
  if (l_S <> nil) then
  begin
   l_Res := S_Ok;
   //l_S.Commit(STGC_DEFAULT, l_Res);
   if (l_Res <> S_Ok) then
    raise Exception.CreateFmt('Не смогли сбросить содержимое файла %s на диск', [FileNameByIndex(l_C)]);
   Result := l_S.pm_GetSize;
   //Result := Max(Result, l3FileUtils.GetFileSize(FileNameByIndex(l_C)));
  end//f_OpenedStreams[l_C] <> nil
  else
   Result := l3FileUtils.GetFileSize(FileNameByIndex(l_C));
  if (l_C > 0) then
   Result := Result + (l_C{ - 1}) * f_SizeLimit;*)
 end;//l_C < 0
 //Result := f_RealStream.Pm_GetSize;
//#UC END# *4FA2802E0231_4FA278B00247_impl*
end;//Tm3SplittedFileStream.DoGetSize

function Tm3SplittedFileStream.DoGetLocksSupported: Integer;
//#UC START# *4FA2805002E3_4FA278B00247_var*
//#UC END# *4FA2805002E3_4FA278B00247_var*
begin
//#UC START# *4FA2805002E3_4FA278B00247_impl*
 if (f_SharedMode = 0) OR (f_SharedMode = FILE_SHARE_READ) then
  Result := 0
 else
  Result := LOCK_EXCLUSIVE;
 //Result := f_RealStream.Pm_GetLocksSupported;
//#UC END# *4FA2805002E3_4FA278B00247_impl*
end;//Tm3SplittedFileStream.DoGetLocksSupported

procedure Tm3SplittedFileStream.Commit(aFlags: Integer;
  var theReturn: hResult);
//#UC START# *4FA280DB0288_4FA278B00247_var*
var
 l_Index : Integer;
 l_S     : Tm3InnerFileStream;
//#UC END# *4FA280DB0288_4FA278B00247_var*
begin
//#UC START# *4FA280DB0288_4FA278B00247_impl*
 if not SUCCEEDED(theReturn) then
 begin
  Assert(false);
  Exit;
 end;//not SUCCEEDED(theReturn)
 if Self.ReadOnly then
  Exit; 
 if (f_OpenedStreams <> nil) then
 begin
  for l_Index := 0 to Pred(f_OpenedStreams.Count) do
  begin
   l_S := f_OpenedStreams.Items[l_Index].Use;
   try
    if (l_S <> nil) then
    begin
     l_S.Commit(aFlags, theReturn);
     if not SUCCEEDED(theReturn) then
      Exit;
    end;//l_S <> nil
   finally
    FreeAndNil(l_S);
   end;//try..finally
  end;//for l_Index
 end;//f_OpenedStreams <> nil
 //f_RealStream.Commit(aFlags, theReturn);
//#UC END# *4FA280DB0288_4FA278B00247_impl*
end;//Tm3SplittedFileStream.Commit

function Tm3SplittedFileStream.DoGetName: WideString;
//#UC START# *5412FB880320_4FA278B00247_var*
//#UC END# *5412FB880320_4FA278B00247_var*
begin
//#UC START# *5412FB880320_4FA278B00247_impl*
 Result := f_Name;
//#UC END# *5412FB880320_4FA278B00247_impl*
end;//Tm3SplittedFileStream.DoGetName

end.