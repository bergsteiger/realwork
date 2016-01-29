unit ddMOSReader;

interface

uses
  ddCSV, k2Reader, l3ProtoObject, k2TagGen, l3Stream, ddProgressObj;



type
 TOnFileNameEvent = procedure (const aFileName: String) of object;

 TddMOSReader = class(Tl3ProtoObject)
 private
  f_Body: Tl3NamedTextStream;
  f_CurItemID: string;
  f_Generator: Tk2TagGenerator;
  f_Header: TddCSV;
  f_OnFileNameEvent: TOnFileNameEvent;
  f_Progressor: TddProgressObject;
  procedure CloseHeaderFile;
  procedure CloseBodyFile;
  procedure FinishDoc;
  function OpenBodyFile(const theTextFileName: String): Boolean;
  function OpenHeaderFile(const theHeaderFileName: String): Boolean;
  procedure pm_SetProgressor(const Value: TddProgressObject);
  procedure StartDoc;
 public
  procedure Execute(const aHeaderFileName, aTextFileName: String);
  procedure LoadDocText(const aTextFileName: String);
  procedure WriteDateNum(const aDate, aNum: String);
  property Generator: Tk2TagGenerator read f_Generator write f_Generator;
  property Progressor: TddProgressObject read f_Progressor write pm_SetProgressor;
  property OnFileNameEvent: TOnFileNameEvent read f_OnFileNameEvent write
      f_OnFileNameEvent;
 end;

implementation
Uses
 l3Chars, k2Tags, document_Const, NumAndDate_Const, l3Date, DT_Types,
 l3String, SysUtils, l3Types, l3Memory, StrUtils, ddHTML_R;

const
 colCount    = 7;
 colItemID   = 0;
 colDocID    = 1;
 colDocNum   = 2;
 colDocDate  = 3;
 colSource   = 4;
 colPartName = 5;
 colPartType = 6;

procedure TddMOSReader.CloseHeaderFile;
begin
 FreeAndNil(f_Header);
end;

procedure TddMOSReader.CloseBodyFile;
begin
 FreeAndNil(f_Body);
end;

procedure TddMOSReader.Execute(const aHeaderFileName, aTextFileName: String);
var
 i: Integer;
 l_Date: String;
 l_Num: String;
 l_DateOld: String;
 l_NumOld: String;
begin
 if OpenBodyFile(aTextFileName) and OpenHeaderFile(aHeaderFileName) then
 try
  f_CurItemID:= '';
  l_DateOld:= '';
  l_NumOld:= '';
  if Progressor <> nil then
   Progressor.Start(f_Header.RowCount);

  Generator.Start;
  try
   for i:= 0 to Pred(f_Header.RowCount) do
   begin
    if f_Header.AsString(i, colItemID) <> f_CurItemID then
    begin
     if f_CurItemID <> '' then
     begin

      StartDoc;
      WriteDateNum(l_DateOld, l_NumOld);
      LoadDocText(aTextFileName);
      FinishDoc;
     end;
     f_CurItemID:= f_Header.AsString(i, colItemID);
    end
    else
    begin
     l_Date:= f_Header.asString(i, colDocDate);
     if not l3AllCharsInCharSet(PAnsiChar(l_Date), Length(l_date), cc_Digits) then
      l_Date:= f_Header.asString(i, Succ(colDocDate));
     l_Num:= f_Header.asString(i, colDocNum);
     if (l_Date <> l_DateOld) or (l_Num <> l_NumOld) then
     begin
      l_DateOld:= l_Date;
      l_NumOld:= l_Num;
     end;
    end;
    if Progressor <> nil then
     Progressor.ProcessUpdate(i);
   end; // for i
   StartDoc;
   WriteDateNum(l_DateOld, l_NumOld);
   LoadDocText(aTextFileName);
   FinishDoc;
   if Progressor <> nil then
    Progressor.Stop;
  finally
   Generator.Finish;
  end;
 finally
  CloseBodyFile;
  CloseHeaderFile;
 end;
end;

procedure TddMOSReader.FinishDoc;
begin
 if Generator <> nil then
  Generator.Finish;
end;

procedure TddMOSReader.LoadDocText(const aTextFileName: String);
var
 l_St: AnsiString;
 l_Stream: Tl3MemoryStream;
 l_Gen: Tk2TagGenerator;
begin
 // TODO -cMM: TddMOSReader.LoadDocText default body inserted
 // Нужно прочитать из файла строки от <html> до </html> и передать их ридер
 l_Stream:= Tl3MemoryStream.Create;
 try
  while f_Body.Position <> f_Body.Size do
  begin
   l_St:= f_Body.GetLine;
   if l_St <> '' then
    l_Stream.Write(l_St[1], Length(l_St));
   if AnsiContainsText(l_St, '</html>') then
    break;
  end; // while
  l_Stream.Seek(0,0);
  l_Gen:= nil;
  TddHTMLReader.SetTo(l_Gen, l_Stream);
  try
   TddHTMLReader(l_Gen).Generator:= Generator;
   TddHTMLReader(l_Gen).Execute;
  finally
   FreeAndNil(l_Gen);
  end;
 finally
  FreeAndNil(l_Stream);
 end;
end;

function TddMOSReader.OpenBodyFile(const theTextFileName: String): Boolean;
begin
 Result := False;
 f_Body:= Tl3NamedTextStream.Create(theTextFileName, l3_fmRead);
 Result:= True;
end;

function TddMOSReader.OpenHeaderFile(const theHeaderFileName: String): Boolean;
begin
 Result := False;
 f_Header:= TddCSV.Create(colCount);
 f_Header.CodePage:= cp_ANSI;
 f_Header.Load(theHeaderFileName);
 Result:= f_Header.RowCount > 0;
end;

procedure TddMOSReader.pm_SetProgressor(const Value: TddProgressObject);
begin
 f_Progressor := Value;
end;

procedure TddMOSReader.StartDoc;
begin
 if Generator <> nil then
 begin
  if Assigned(f_OnFileNameEvent) then
   f_OnFileNameEvent(f_CurItemID);
  Generator.StartChild(k2_idDocument);
  Generator.AddStringatom(k2_tiComment, f_CurItemID);
 end;
end;

procedure TddMOSReader.WriteDateNum(const aDate, aNum: String);
begin
 if Generator <> nil then
 begin
  Generator.StartTag(k2_tiNumANDDates);
  try
   Generator.StartChild(k2_idNumAndDate);
   try
    Generator.AddIntegerAtom(k2_tiType, ord(dnPublish));
    try
     Generator.AddIntegerAtom(k2_tiStart, DateTimeToDtDate(StrToDateFmt('YYYYMMDD', aDate)));
    except
    
    end;
    Generator.AddStringAtom(k2_tiNumber, aNum);
   finally
    Generator.Finish;
   end;
  finally
   Generator.Finish(False);
  end;
 end;
end;

end.
