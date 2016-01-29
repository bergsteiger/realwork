unit tmvRecord;

interface

uses
 Classes,

 l3Interfaces,
 l3CacheableBase,
 l3Stream,

 tmvInterfaces
 ;

type
 TtmvRecord = class(Tl3CacheableBase, ItmvRecord, ItmvRecordInfo)
 private
  f_Caption: Il3CString;
  f_Frequency: Il3CString;
  f_Info: String[c_tvmMaxInfoLength];
  f_MistakeKind: TtmvRecordKind;
  f_Context: Il3CString;
  f_MistakeOffset: Int64;
  f_InfoOffset: int64;
  f_StartOffset: Int64;
  f_EndOffset: Int64;
  f_RecordIndex: Cardinal;
  f_KindModified: Boolean;
  f_InfoModified: Boolean;
    function pm_GetMistakeOffset: Int64;
 protected
  //ItmvRecord
  function pm_GetCaption: Il3CString;
    {-}
  function pm_GetFrequency: Il3CString;
    {-}
  function pm_GetMistakeKind: TtmvRecordKind;
  procedure pm_SetMistakeKind(aValue: TtmvRecordKind);
    {-}
  function pm_GetContext: Il3CString;
    {-}
  function pm_GetModified: Boolean;
    {-}
  function pm_GetInfo: String;
  procedure pm_SetInfo(const aValue: String);
    {-}
  function pm_CanWriteInfo: Boolean;
    {-}
  //ItmvRecordInfo
  function pm_GetStartOffset: Int64;
    {-}
  function pm_GetRecordIndex: Cardinal;
    {-}
  function pm_GetEndOffset: Int64;
    {-}
  procedure SaveData(const aStream: TStream);
    {-}
 private
  procedure CheckEOF(const aFile: Tl3TextStream);
    {-}
 protected
  procedure Cleanup;
   override;
    {-}
 public
  constructor Create(const aFile: Tl3TextStream; anIndex: Cardinal);
   reintroduce;
    {-}
  constructor CreateFake(const aMessage: String);
    {-}
  class function MakeFake(const aMessage: String): ItmvRecord;
    {-}
  class function Make(const aFile: Tl3TextStream; anIndex: Cardinal): ItmvRecord;
   reintroduce;
    {-}
 end;//TtmvRecord

implementation

uses
 SysUtils,
 Windows,
 Math,

 l3Base,
 l3String
 ;

const
 cInfoValidForRecordKind = [rkHumanMistake, rkScanerMistake, rkNewRegularWord, rkVariant];

{ TtmvRecord }

procedure TtmvRecord.CheckEOF(const aFile: Tl3TextStream);
begin
 if aFile.IsEof then
  raise EtvmEndOfFile.Create('');
end;

procedure TtmvRecord.Cleanup;
begin
 f_Caption := nil;
 f_Frequency := nil;
 f_Context := nil;
 f_Info := '';
 inherited Cleanup;
end;

constructor TtmvRecord.Create(const aFile: Tl3TextStream;
  anIndex: Cardinal);
var
 l_String: String;
 l_Offset: Int64;

 procedure lp_ReadOneString(out aString: String; out aOffset: Int64);
 begin
  repeat
   CheckEOF(aFile);
   aOffset := aFile.Position;
   aString := aFile.GetLine;
  until aString <> '';
 end;

 procedure lp_ReadUntilDelimiter(out aString: String);
 var
  l_String: String;
 begin
  aString := '';
  repeat
   CheckEOF(aFile);
   l_String := aFile.GetLine;
   if l_String <> '#' then
   begin
    if aString <> '' then
     aString := aString + #13#10;
    aString := aString + l_String;
   end;
  until l_String = '#';
 end;

begin
 inherited Create;
 f_RecordIndex := anIndex;
 lp_ReadOneString(l_String, f_StartOffset);
 f_Caption := l3CStr(l3PCharLen(l_String, c_tvmCodePage));
 lp_ReadOneString(l_String, l_Offset);
 f_Frequency := l3CStr(l3PCharLen(l_String, c_tvmCodePage));
 lp_ReadOneString(l_String, f_MistakeOffset);
 if not (StrToInt(l_String) in [0..7]) then
  raise Exception.Create('Invalid file format');
 f_MistakeKind := TtmvRecordKind(StrToInt(l_String));
 lp_ReadOneString(l_String, f_InfoOffset);
 OemToChar(PChar(l_String), PChar(l_String));
 if (Length(l_String) <> c_tvmMaxInfoLength + 1) or (l_String[1] <> '=') then
  raise Exception.Create('Invalid file format');
 System.Delete(l_String, 1, 1);
 f_Info := TrimRight(l_String);
 lp_ReadUntilDelimiter(l_String);
 lp_ReadUntilDelimiter(l_String);
 f_Context := l3CStr(l3PCharLen(l_String, c_tvmCodePage));
 f_EndOffset := aFile.Position;
end;

constructor TtmvRecord.CreateFake(const aMessage: String);
begin
 inherited Create;
 f_Context := l3CStr(l3PCharLen(aMessage));
end;

class function TtmvRecord.Make(const aFile: Tl3TextStream;
  anIndex: Cardinal): ItmvRecord;
var
 l_Instance: TtmvRecord;
begin
 l_Instance := TtmvRecord.Create(aFile, anIndex);
 try
  Result := l_Instance;
 finally
  l3Free(l_Instance);
 end;
end;

class function TtmvRecord.MakeFake(const aMessage: String): ItmvRecord;
var
 l_Instance: TtmvRecord;
begin
 l_Instance := TtmvRecord.CreateFake(aMessage);
 try
  Result := l_Instance;
 finally
  l3Free(l_Instance);
 end;
end;

function TtmvRecord.pm_GetCaption: Il3CString;
begin
 Result := f_Caption;
end;

function TtmvRecord.pm_GetContext: Il3CString;
begin
 Result := f_Context;
end;

function TtmvRecord.pm_GetFrequency: Il3CString;
begin
 Result := f_Frequency;
end;

function TtmvRecord.pm_GetMistakeOffset: Int64;
begin
 Result := f_MistakeOffset;
end;

function TtmvRecord.pm_GetStartOffset: Int64;
begin
 Result := f_StartOffset;
end;

function TtmvRecord.pm_GetRecordIndex: Cardinal;
begin
 Result := f_RecordIndex;
end;

function TtmvRecord.pm_GetModified: Boolean;
begin
 Result := f_KindModified or f_InfoModified;
end;

function TtmvRecord.pm_GetEndOffset: Int64;
begin
 Result := f_EndOffset;
end;

function TtmvRecord.pm_CanWriteInfo: Boolean;
begin
 Result := f_MistakeKind in cInfoValidForRecordKind;
end;

function TtmvRecord.pm_GetInfo: String;
begin
 Result := f_Info;
end;

function TtmvRecord.pm_GetMistakeKind: TtmvRecordKind;
begin
 Result := f_MistakeKind;
end;

procedure TtmvRecord.pm_SetInfo(const aValue: String);
begin
 if aValue <> f_Info then
 begin
  f_Info := aValue;
  f_InfoModified := True;
 end;
end;

procedure TtmvRecord.pm_SetMistakeKind(aValue: TtmvRecordKind);
var
 l_OldCanWriteInfo: Boolean;
begin
 if aValue <> f_MistakeKind then
 begin
  l_OldCanWriteInfo := pm_CanWriteInfo;
  f_MistakeKind := aValue;
  f_KindModified := True;
  if pm_CanWriteInfo xor l_OldCanWriteInfo then
   f_InfoModified := true;
 end;
end;

procedure TtmvRecord.SaveData(const aStream: TStream);
var
 l_String: String;
const
 cMap: array [TtmvRecordKind] of Char = ('0', '1', '2', '3', '4', '5', '6', '7');
begin
 if f_KindModified then
 begin
  aStream.Seek(f_MistakeOffset, soBeginning);
  aStream.WriteBuffer(cMap[f_MistakeKind], SizeOf(Byte));
  f_KindModified := False;
 end;
 if f_InfoModified then
 begin
  l_String := '='+StringOfChar(' ',c_tvmMaxInfoLength);
  if pm_CanWriteInfo then
   l3Move(f_Info[1], l_String[2], Min(Length(f_info), c_tvmMaxInfoLength))
  else
   f_Info := '';
  CharToOEM(PChar(l_String), PChar(l_String));
  aStream.Seek(f_InfoOffset, soBeginning);
  aStream.WriteBuffer(l_String[1], c_tvmMaxInfoLength + 1);
  f_InfoModified := False
 end;
end;

end.
