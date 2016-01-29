unit tmvController;

interface

uses
 l3Interfaces,
 l3Base,
 l3Stream,

 tmvInterfaces,
 tmvRecordOffsetsList
 ;

type
 TtmvController = class(Tl3Base, ItmvController)
 private
  f_Prev: ItmvRecord;
  f_Current: ItmvRecord;
  f_Next: ItmvRecord;
  f_PositionFileName: string;
  f_File: Tl3TextStream;
  f_Offsets: TtmvRecordOffsetsList;
  f_ProgressCaption: Il3CString;
 private
  procedure NextMakeRecord;
    {-}
  procedure SaveCurrent;
    {-}
  procedure CheckOffset(const aInfo: ItmvRecordInfo);
    {-}
  function CalcProgress: Il3CString;
    {-}
 protected
  //ItmvController
  function pm_GetCurrent: ItmvRecord;
    {-}
  function pm_GetProgressCaption: Il3CString;
    {-}
  procedure Prev;
    {-}
  procedure Next;
    {-}
  function CanPrev: Boolean;
    {-}
  function CanNext: Boolean;
    {-}
 protected
  procedure Cleanup;
   override;
    {-}
 public
  constructor Create(const aDataFileName, aPositionFileName: string);
   reintroduce;
    {-}
  class function Make(const aDataFileName, aPositionFileName: string): ItmvController;
    {-}
 end;//TtmvController

implementation

uses
 Classes,
 SysUtils,

 l3Types,
 l3String,

 afwInterfaces,
 afwLongProcessVisualizer,

 tmvRecord,
 tmvRecordOffsets
 ;

{ TtmvController }

function TtmvController.CanNext: Boolean;
begin
 Result := Assigned(f_Next) and Assigned(f_File);
end;

function TtmvController.CanPrev: Boolean;
begin
 Result := Assigned(f_Prev) and Assigned(f_File);
end;

procedure TtmvController.CheckOffset(const aInfo: ItmvRecordInfo);
begin
 with aInfo do
  if RecordIndex = f_Offsets.Count then
   f_Offsets.Add(TtmvRecordOffsets.Make(StartOffSet, EndOffset));
end;

procedure TtmvController.Cleanup;
var
 l_File: Tl3TextStream;
 l_String: String;
begin
 If Assigned(f_Current.Caption) then
 begin
  SaveCurrent;
  l_File := Tl3TextStream.Create(f_PositionFileName, l3_fmCreateReadWrite);
  try
   l_String := f_Current.Caption.AsWStr.S;
   SetLength(l_String, f_Current.Caption.AsWStr.SLen);
   l_File.PutLine(l_String);
  finally
   l3Free(l_File);
  end;
 end;
 f_Prev := nil;
 f_Current := nil;
 f_Next := nil;
 l3Free(f_File);
 l3Free(f_Offsets);
 f_ProgressCaption := nil;
 inherited Cleanup;
end;

constructor TtmvController.Create(const aDataFileName,
  aPositionFileName: string);
var
 l_File: Tl3TextStream;
 l_String: String;
 l_PChar: Il3CString;
 l_Visualizer: IafwLongProcessVisualizer;  
begin
 inherited Create;
 f_Offsets := TtmvRecordOffsetsList.Make;
 try
  if not FileExists(aDataFileName) then
   raise EFOpenError.CreateFmt('File %s not found',[aDataFileName]);
  f_File := Tl3TextStream.Create(aDataFileName, l3_fmExclusiveReadWrite);
  f_File.Seek(0, soBeginning);
  f_Current := TtmvRecord.Make(f_File, 0);
  CheckOffset(f_Current as ItmvRecordInfo);
  NextMakeRecord;
  f_PositionFileName := aPositionFileName;
  if FileExists(f_PositionFileName) then
  begin
   l_Visualizer := TafwLongProcessVisualizer.Make(l3CStr('Поиск последнего просмотренного слова'));
   try
    l_File := Tl3TextStream.Create(f_PositionFileName, l3_fmRead);
    try
     l_String := l_File.GetLine;
     if l_String <> '' then
     begin
      l_PChar := l3CStr(l3PCharLen(l_String, c_tvmCodePage));
      while not l3Same(l_PChar, f_Current.Caption) and CanNext do
       Next;
      if not l3Same(l_PChar, f_Current.Caption) then
      begin
       f_Prev := nil;
       f_File.Seek(0, soBeginning);
       f_Current := TtmvRecord.Make(f_File, 0);
       NextMakeRecord;
      end;
     end;
    finally
     l3Free(l_File);
    end;
   finally
    l_Visualizer := nil;
   end;
  end;
 except
  l3Free(f_File);
  f_Current := TtmvRecord.MakeFake('Файл данных не найден или поврежден - '+aDataFileName);
 end;
end;

class function TtmvController.Make(const aDataFileName,
  aPositionFileName: string): ItmvController;
var
 l_Instance: TtmvController;
begin
 l_Instance := TtmvController.Create(aDataFileName, aPositionFileName);
 try
  Result := l_Instance;
 finally
  l3Free(l_Instance);
 end;
end;

procedure TtmvController.Next;
begin
 SaveCurrent;
 f_Prev := f_Current;
 f_Current := f_Next;
 f_ProgressCaption := nil;
 NextMakeRecord;
end;

procedure TtmvController.NextMakeRecord;
var
 l_Info: ItmvRecordInfo;
begin
 Supports(f_Current, ItmvRecordInfo, l_Info);
 Assert(Assigned(l_Info));
 f_File.Seek(l_Info.EndOffset, soBeginning);
 try
  f_Next := TtmvRecord.Make(f_File, l_Info.RecordIndex + 1);
  CheckOffset(f_Next as ItmvRecordInfo);
 except
  on EtvmEndOfFile do
   f_Next := nil;
 end;
end;

function TtmvController.pm_GetCurrent: ItmvRecord;
begin
 Result := f_Current;
end;

function TtmvController.pm_GetProgressCaption: Il3CString;
begin
 if f_ProgressCaption = nil then
  f_ProgressCaption := CalcProgress;
 Result := f_ProgressCaption;
end;

procedure TtmvController.Prev;
var
 l_Info: ItmvRecordInfo;
begin
 SaveCurrent;
 f_Next := f_Current;
 f_Current := f_Prev;
 Supports(f_Current, ItmvRecordInfo, l_Info);
 f_ProgressCaption := nil;
 if l_Info.RecordIndex = 0 then
  f_Prev := nil
 else
 begin
  f_File.Seek(f_Offsets.Items[l_Info.RecordIndex - 1].StartOffset, soBeginning);
  f_Prev := TtmvRecord.Make(f_File, l_Info.RecordIndex - 1);
 end; 
end;

procedure TtmvController.SaveCurrent;
var
 l_Info: ItmvRecordInfo;
begin
 if f_Current.Modified then
 begin
  Supports(f_Current, ItmvRecordInfo, l_Info);
  l_Info.SaveData(f_File);
 end;
end;

function TtmvController.CalcProgress: Il3CString;
var
 l_Progress: Single;
begin
 if Assigned(f_File) then
 begin
  l_Progress := (f_Current as ItmvRecordInfo).EndOffset/f_File.Size*100;
  if not CanNext then
   l_Progress := 100
  else
   if l_Progress > 99.99 then
    l_Progress := 99.99;
  Result := l3CStr(Format('Обработано %f %%',[l_Progress]));
 end;
end;

end.

