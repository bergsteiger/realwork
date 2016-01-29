unit vcmLocalizationManager;

interface

uses
 Classes,
 SysUtils,

 l3Base,
 l3ProtoObject,

 vcmExternalInterfaces,
 vcmContentSimpleReader
 ;

type
 EFileNotFound = class(Exception);
 EDuplicateName = class(Exception);
 EEmptyTerm = class(Exception);
 EEmptySource = class(Exception);
 ESourceFileNotFound = class(Exception);

 TnsLocalizationManagerMode = (mmMerge, mmLoad, mmDiff, mmTranslate);

 TOnTextDifferenceEvent = procedure (Sender: TObject; const aName, anOldText,
  aNewText, anOldTranslated: String; var aNewTranslated: String;
  var IsSameText: Boolean) of object;

 TnsLocalizationManager = class(Tl3ProtoObject, IvcmResources)
 private
  f_Data: TStringList;
  f_Mode: TnsLocalizationManagerMode;
  f_InitialLoad: Boolean;
  f_LastName: String;
  f_OnTextDifferenceEvent: TOnTextDifferenceEvent;
  f_SourceFile: String;
  f_TargetFile: String;
 private
  procedure Define(const aName   : String;
                   const aRus    : String;
                   const anAlien : String);
    {-}
 private
  procedure WriteResult(const aFileName: String);
    {-}
 protected
  function IsSameText(const aName, anOldText, aNewText, anOldTranslated: String; var aNewTranslated: String): Boolean;
    {-}
  procedure Cleanup;
   override;
    {-}
 public
  constructor Create(const aSourceFile, aTargetFile: String;
   aMode: TnsLocalizationManagerMode; anOnTextDifferenceEvent: TOnTextDifferenceEvent = nil);
   reintroduce;
    {-}
  procedure Execute;
    {-}
  property OnTextDifferenceEvent: TOnTextDifferenceEvent
      read f_OnTextDifferenceEvent
     write f_OnTextDifferenceEvent;
 end;

implementation

uses
 Windows,

 l3Interfaces,

 vcmContentConst
 ;

type
 TnsLocalizationManagerRecord = class(Tl3ProtoObject)
 public
  f_Original: String;
  f_Translated: String;
  f_Processed: Boolean;
 end;

{ TnsLocalizationManager }

procedure TnsLocalizationManager.Cleanup;
var
 l_Idx: Integer;
begin
 for l_idx := 0 to f_Data.Count-1 do
  f_Data.Objects[l_Idx].Free;
 l3Free(f_Data);
end;

constructor TnsLocalizationManager.Create(const aSourceFile, aTargetFile: String;
 aMode: TnsLocalizationManagerMode; anOnTextDifferenceEvent: TOnTextDifferenceEvent);
begin
 inherited Create;
 f_SourceFile := aSourceFile;
 f_TargetFile := aTargetFile;
 f_Mode := aMode;
 f_Data := TStringList.Create;
 f_Data.Sorted := True;
 f_OnTextDifferenceEvent := anOnTextDifferenceEvent;
end;

procedure TnsLocalizationManager.Define(const aName, aRus,
  anAlien: String);
var
 l_Idx: Integer;
 l_Str: String;

 function lp_AddRecord(aName, anOriginal, aTranslated: String): Integer;
 var
  l_Data: TnsLocalizationManagerRecord;
 begin
  l_Data := TnsLocalizationManagerRecord.Create;
  l_Data.f_Original := anOriginal;
  l_Data.f_Translated := aTranslated;
  l_Data.f_Processed := False;
  Result := f_Data.AddObject(aName, l_Data);
 end;

 function lpAdjustTrim(const anOriginal, aTranslated: String): String;
 var
  l_Cnt: Integer;
  l_Length: Integer;
 begin
  if aTranslated<>'' then
  begin
   l_Cnt := 1;
   l_Length := Length(anOriginal);
   while (l_Cnt <= l_Length) and (anOriginal[l_Cnt] = ' ') do Inc(l_Cnt);
   while (l_Length > 0) and (anOriginal[l_Length] = ' ') do Dec(l_Length);
   Result := Copy(anOriginal,1,l_Cnt-1) + Trim(aTranslated) + Copy(anOriginal,l_Length+1,MaxInt);
  end
  else
   Result := '';
 end;

begin
 if aName = '' then
  raise EEmptyTerm.Create(f_LastName);
 f_LastName := aName;
 l_Idx := f_Data.IndexOf(aName);
 if f_InitialLoad then
 begin
  if l_Idx<>-1 then
   raise EDuplicateName.Create(aName);
  lp_AddRecord(aName, aRus, anAlien);
 end
 else
 begin
  case f_Mode of
   mmLoad, mmMerge:
    begin
     if l_Idx = -1 then
      l_Idx := lp_AddRecord(aName, aRus, '');
     with TnsLocalizationManagerRecord(f_Data.Objects[l_Idx]) do
     begin
      f_Processed := true;
      l_Str := f_Translated;
      if (aRus <> f_Original) and not IsSameText(aName,f_Original,aRus,f_Translated,l_Str) then
       f_Translated := ''
      else
       if aRus <> f_Original then
        f_Translated := lpAdjustTrim(aRus,l_Str);
      f_Original := aRus;
     end;
    end;
   mmTranslate:
    if l_idx <> -1 then
     with TnsLocalizationManagerRecord(f_Data.Objects[l_Idx]) do
     begin
      f_Processed := True;
      l_Str := anAlien;
      if (aRus <> f_Original) and not IsSameText(aName,aRus,f_Original,f_Translated,l_Str) then
       f_Translated := ''
      else
       f_Translated := lpAdjustTrim(f_Original,l_Str);
     end;
  end;
 end;
end;

function TnsLocalizationManager.IsSameText(const aName, anOldText,
  aNewText, anOldTranslated: String; var aNewTranslated: String): Boolean;
begin
 Result := False;
 if Assigned(f_OnTextDifferenceEvent) then
  f_OnTextDifferenceEvent(Self, aName, anOldText, aNewText, anOldTranslated, aNewTranslated, Result);
end;

procedure TnsLocalizationManager.Execute;
var
 l_Reader: Il3Reader;
 l_DataFileName: String;
 l_Files: TStringList;
 l_SourcePath: String;
 l_IDX: Integer;
begin
 if not FileExists(f_SourceFile) then
  raise EFileNotFound.Create(f_SourceFile);
 case f_Mode of
  mmMerge,
  mmLoad,
  mmTranslate: l_DataFileName := f_TargetFile;
  mmDiff: l_DataFileName := f_SourceFile;
 end;
 if f_Mode = mmMerge then
 begin
  l_SourcePath := ExtractFilePath(f_SourceFile);
  l_Files := TSTringList.Create;
  try
   l_Files.LoadFromFile(f_SourceFile);
   if l_Files.Count = 0 then
    raise EEmptySource.Create('');
   for l_IDX := 0 to l_Files.Count - 1 do
    if l_Files[l_IDX] <> '' then
    begin
     l_Files[l_IDX] := l_SourcePath + l_Files[l_IDX];
     if not FileExists(l_Files[l_IDX]) then
      raise ESourceFileNotFound.Create(l_Files[l_IDX]);
    end;
   for l_IDX := 0 to l_Files.Count - 1 do
    if l_Files[l_IDX] <> '' then
    begin
     l_Reader := TvcmContentSimpleReader.Make(l_Files[l_IDX], self);
     try
      f_LastName := '';
      l_Reader.Execute;
     finally
      l_Reader := nil;
     end;
    end;
  finally
   l_Files.Free;
  end;
 end
 else
 begin
  if FileExists(l_DataFileName) then
  begin
   f_InitialLoad := True;
   l_Reader := TvcmContentSimpleReader.Make(l_DataFileName, self);
   try
    f_LastName := '';
    l_Reader.Execute;
   finally
    f_InitialLoad := False;
    l_Reader := nil;
   end;
  end;
  if f_Mode in [mmLoad, mmTranslate] then
  begin
   l_Reader := TvcmContentSimpleReader.Make(f_SourceFile, self);
   try
    f_LastName := '';
    l_Reader.Execute;
   finally
    l_Reader := nil;
   end;
  end;
 end;
 WriteResult(f_TargetFile);
end;

procedure TnsLocalizationManager.WriteResult(const aFileName: String);
var
 l_Text: System.Text;

 procedure lp_ExportData(aName: String; aData: TnsLocalizationManagerRecord);
 begin
  WriteLn(l_Text,c_vcmOpenKey+aName+c_vcmCloseKey);
  WriteLn(l_Text,aData.f_Original);
  WriteLn(l_Text,c_vcmValueEnd);
  WriteLn(l_Text,aData.f_Translated);
  WriteLn(l_Text,c_vcmValueEnd);
 end;

var
 l_NewExt: String;
 l_Data: TnsLocalizationManagerRecord;
 l_Idx: Integer;
begin
 if FileExists(aFileName) then
 begin
  l_NewExt := ExtractFileExt(aFileName);
  System.Insert('~',l_NewExt,2);
  l_NewExt := Copy(l_NewExt,1,4);
  CopyFile(PChar(aFileName),PChar(ChangeFileExt(aFileName,l_NewExt)),False);
 end;
 AssignFile(l_Text, aFileName);
 ReWrite(l_Text);
 try
  for l_Idx := 0 to f_Data.Count - 1 do
  begin
   l_Data := TnsLocalizationManagerRecord(f_Data.Objects[l_Idx]);
   case f_Mode of
    mmLoad:
     if l_Data.f_Processed then
      lp_ExportData(f_Data[l_Idx],l_Data);
    mmTranslate, mmMerge:
     lp_ExportData(f_Data[l_Idx],l_Data);
    mmDiff:
     if l_Data.f_Translated = '' then
      lp_ExportData(f_Data[l_Idx],l_Data);
   end;
  end;
 finally
  CloseFIle(l_Text);
 end;
end;

end.
