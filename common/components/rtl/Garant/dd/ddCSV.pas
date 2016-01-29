unit ddCSV;

{ $Id: ddCSV.pas,v 1.15 2014/02/18 13:34:33 lulin Exp $ }

// $Log: ddCSV.pas,v $
// Revision 1.15  2014/02/18 13:34:33  lulin
// - избавляемся от ненужного списка.
//
// Revision 1.14  2013/12/06 06:07:08  fireton
// - TddCSV.AsWString
//
// Revision 1.13  2013/10/29 11:34:47  fireton
// - оптимизации
//
// Revision 1.12  2013/04/11 17:14:58  lulin
// - отлаживаем под XE3.
//
// Revision 1.11  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.10  2011/05/18 18:01:14  lulin
// {RequestLink:266409354}.
//
// Revision 1.9  2011/04/04 06:42:56  fireton
// - "умный" CSV с секциями (поддерживает изменения значений)
//
// Revision 1.8  2011/03/29 11:41:22  fireton
// - промежуточный коммит
//
// Revision 1.7  2011/02/07 13:05:48  fireton
// - Filename
//
// Revision 1.6  2010/09/23 11:29:26  fireton
// - не открывался файлер
//
// Revision 1.5  2010/09/15 10:06:32  fireton
// - объект для загрузки csv  с секциями
//
// Revision 1.4  2010/07/20 13:28:57  fireton
// - переделка читалки CSV под filer
//
// Revision 1.3  2010/02/10 14:47:51  fireton
// - [$190677802]
//
// Revision 1.2  2009/06/22 14:47:54  fireton
// - bugfix: не читался последний столбец
//
// Revision 1.1  2009/06/01 11:28:34  fireton
// - [$146377261]
//

interface
uses
 Classes,

 l3Base,
 l3Interfaces,
 l3BaseStream,
 l3Filer,
 l3StringList,
 l3ProtoPersistentRefList
 ;

const
 cMaxValues = 50;

type
 TddCSVRowList = class(Tl3ProtoPersistentRefList)
 private
  f_ColCount: Integer;
 protected
 public
  constructor Create(aColCount: Integer);
  function AddRow: Integer;
  property ColCount: Integer read f_ColCount;
 end;

 TddCSV = class(Tl3Base)
 private
  f_CodePage: Integer;
  f_Rows: TddCSVRowList;
  function pm_GetColCount: Integer;
  function pm_GetRowCount: Integer;
  function pm_GetValue(aRow, aColumn: Integer): Il3CString;
  procedure pm_SetValue(aRow, aColumn: Integer; const Value: Il3CString);
 protected
  procedure Cleanup; override;
 public
  constructor Create(aColCount: Integer);
  function AsString(const aRow, aColumn: Integer; aCodePage: Integer = CP_ANSI): AnsiString;
  function AsWString(const aRow, aColumn: Integer): Tl3WString;
  function AsInteger(const aRow, aColumn: Integer): Integer;
  procedure Load(aFileName: AnsiString); overload;
  procedure Load(aStream: TStream); overload;
  procedure Load(aFiler: Tl3CustomFiler); overload;
  property CodePage: Integer read f_CodePage write f_CodePage;
  property ColCount: Integer read pm_GetColCount;
  property RowCount: Integer read pm_GetRowCount;
  property Value[aRow, aColumn: Integer]: Il3CString read pm_GetValue write pm_SetValue;
 end;

 TddSectionedCSVLoader = class(Tl3Base)
 private
  f_CanBeChanged: Boolean;
  f_FileChanged: Boolean;
  f_LineChanged: Boolean;
  f_SrcCache: Tl3StringList;
  f_Filer : Tl3CustomFiler;
  f_NewFileName: AnsiString;
  f_NewVersionFiler: Tl3CustomFiler;
  f_PrevLine: Il3CString;
  f_SectName: Il3CString;
  f_Values: array[0..cMaxValues-1] of Il3CString;
  f_ValuesCount: Integer;
  function ExtractSectionName(const aStr: Tl3WString): Boolean;
  procedure FlushChangedLine;
  procedure FlushLine;
  procedure FlushUnchangedLine;
  procedure FlushUnchangedSrcCache;
  function pm_GetFileName: AnsiString;
  function pm_GetInProcess: Boolean;
  function pm_GetValues(Index: Integer): Il3CString;
  function pm_GetValuesW(aIndex: Integer): Tl3WString;
  procedure pm_SetCanBeChanged(const Value: Boolean);
  procedure pm_SetValues(Index: Integer; const Value: Il3CString);
  function ReadLine: Tl3WString;
 protected
  procedure Cleanup; override;
  procedure DispatchSection; virtual; abstract;
  function NextLine: Boolean;
  procedure SkipSection;
  property InProcess: Boolean read pm_GetInProcess;
  property SectName: Il3CString read f_SectName write f_SectName;
  property Values[Index: Integer]: Il3CString read pm_GetValues write pm_SetValues;
  property ValuesCount: Integer read f_ValuesCount;
 public
  constructor Create(const aFileName: AnsiString; aCanBeChanged: Boolean = False);
  procedure Process;
  property CanBeChanged: Boolean read f_CanBeChanged write pm_SetCanBeChanged;
  property FileName: AnsiString read pm_GetFileName;
  property ValuesW[aIndex: Integer]: Tl3WString read pm_GetValuesW;
 end;

implementation
uses
 l3Types,
 l3Chars,
 l3String,
 l3Stream,
 l3StringListPrim,

 SysUtils,
 StrUtils;

constructor TddCSVRowList.Create(aColCount: Integer);
begin
 inherited Create;
 f_ColCount := aColCount;
end;

function TddCSVRowList.AddRow: Integer;
var
 l_Row: Tl3StringList;
begin
 l_Row := Tl3StringList.Make;
 try
  l_Row.Count := f_ColCount;
  Result := Add(l_Row);
 finally
  FreeAndNil(l_Row);
 end;
end;

constructor TddCSV.Create(aColCount: Integer);
begin
 inherited Create;
 f_Rows := TddCSVRowList.Create(aColCount);
 f_CodePage := CP_DefaultValue;
end;

function TddCSV.AsInteger(const aRow, aColumn: Integer): Integer;
begin
 Result := l3StrToIntDef(Value[aRow, aColumn].AsWStr, 0);
end;

function TddCSV.AsString(const aRow, aColumn: Integer; aCodePage: Integer = CP_ANSI): AnsiString;
begin
 Result := l3Str(Value[aRow, aColumn], aCodePage);
end;

function TddCSV.AsWString(const aRow, aColumn: Integer): Tl3WString;
var
 l_IStr: Il3CString;
begin
 l_IStr := Value[aRow, aColumn];
 if l_IStr <> nil then
  Result := l_IStr.AsWStr
 else
  Result := cc_EmptyStr; 
end;

procedure TddCSV.Cleanup;
begin
 l3Free(f_Rows);
 inherited;
end;

procedure TddCSV.Load(aFileName: AnsiString);
var
 l_FS: Tl3FileStream;
begin
 l_FS := Tl3FileStream.Create(aFileName, l3_fmRead);
 try
  Load(l_FS);
 finally
  l3Free(l_FS);
 end;
end;

procedure TddCSV.Load(aStream: TStream);
var
 l_Filer: Tl3CustomFiler;
begin
 l_Filer := Tl3CustomFiler.Create;
 try
  l_Filer.Stream := aStream;
  Load(l_Filer)
 finally
  FreeAndNil(l_Filer);
 end;
end;

procedure TddCSV.Load(aFiler: Tl3CustomFiler);
var
 l_Str: AnsiString;
 l_Pos: Integer;
 l_CurColumn: Integer;
 l_Row: Integer;
 l_Substr: AnsiString;
 l_NewPos: Integer;
begin
 while not aFiler.EOF do
 begin
  l_Str :=  l3PCharLen2String(l3Trim(aFiler.ReadLn));
  if l_Str <> '' then
  begin
   l_Row := f_Rows.AddRow;
   l_Pos := 1;
   l_CurColumn := 0;
   l_NewPos := PosEx(';', l_Str, l_Pos);
   while l_NewPos > 0 do
   begin
    l_Substr := Copy(l_Str, l_Pos, l_NewPos-l_Pos);
    Value[l_Row, l_CurColumn] := l3CStr(l3PCharLen(l_Substr, f_CodePage));
    Inc(l_CurColumn);
    if l_CurColumn = ColCount then
     Break;
    l_Pos := l_NewPos + 1;
    l_NewPos := PosEx(';', l_Str, l_Pos);
   end;
   if l_CurColumn < ColCount then
   begin
    if l_NewPos > 0 then
     l_Substr := Trim(Copy(l_Str, l_Pos, l_NewPos-l_Pos))
    else
     l_Substr := Trim(Copy(l_Str, l_Pos, MaxInt));
    if l_SubStr <> '' then
     Value[l_Row, l_CurColumn] := l3CStr(l3PCharLen(l_Substr, f_CodePage));
   end;
  end;
 end;
end;

function TddCSV.pm_GetColCount: Integer;
begin
 Result := f_Rows.ColCount;
end;

function TddCSV.pm_GetRowCount: Integer;
begin
 Result := f_Rows.Count;
end;

function TddCSV.pm_GetValue(aRow, aColumn: Integer): Il3CString;
begin
 Result := Tl3StringList(f_Rows[aRow]).ItemC[aColumn];
end;

procedure TddCSV.pm_SetValue(aRow, aColumn: Integer; const Value: Il3CString);
begin
 Tl3StringList(f_Rows[aRow]).ItemC[aColumn] := Value;
end;

constructor TddSectionedCSVLoader.Create(const aFileName: AnsiString; aCanBeChanged: Boolean = False);
begin
 inherited Create;
 f_Filer := Tl3DOSFiler.Make(aFileName);
 f_CanBeChanged := aCanBeChanged;
end;

procedure TddSectionedCSVLoader.Cleanup;
begin
 FreeAndNil(f_Filer);
 inherited;
end;

function TddSectionedCSVLoader.ExtractSectionName(const aStr: Tl3WString): Boolean;
var
 l_Pos: Integer;
begin
 Result := False;
 if (aStr.SLen > 0) and (aStr.S[0] = '[') then
 begin
  l_Pos := ev_lpCharIndex(']', aStr);
  if l_Pos > 1 then // по крайней мере, имя содержит одну букву...
  begin
   f_SectName := l3CStr(l3Copy(aStr, 1, l_Pos - 1));
   Result := True;
  end;
 end;
end;

procedure TddSectionedCSVLoader.FlushChangedLine;
var
 l_Str : Il3CString;
 I: Integer;
begin
 l_Str := l3CStr(ValuesW[0]);
 for I := 1 to f_ValuesCount - 1 do
 begin
  l_Str := l3Cat(l_Str, ';');
  l_Str := l3Cat(l_Str, ValuesW[I]);
 end;
 f_NewVersionFiler.WriteLn(l_Str.AsWStr);
end;

procedure TddSectionedCSVLoader.FlushLine;
begin
 if f_LineChanged then
  FlushChangedLine
 else
  FlushUnchangedLine;
end;

procedure TddSectionedCSVLoader.FlushUnchangedLine;
begin
 f_NewVersionFiler.WriteLn(f_PrevLine.AsWStr);
end;

procedure TddSectionedCSVLoader.FlushUnchangedSrcCache;
var
 I: Integer;
begin
 for I := 0 to f_SrcCache.Hi do
  f_NewVersionFiler.WriteLn(f_SrcCache.ItemW[I]);
end;

function TddSectionedCSVLoader.NextLine: Boolean;
var
 l_Str   : Tl3WString;
 l_NewStr: Tl3WString;
 l_Pos: Integer;
 I: Integer;

 procedure DropValues;
 var
  I: Integer;
 begin
  for I := 0 to f_ValuesCount-1 do
   f_Values[I] := nil; // зануляем данные предыдущей строки
  f_ValuesCount := 0;
 end;

begin
 Result := True;
 if not f_Filer.EOF then
 begin
  l_Str := ReadLine;
  DropValues;
  if ExtractSectionName(l_Str) then
  begin
   Result := False;
   Exit;
  end;
  if not l3IsNil(l_Str) then
  begin
   while true do
   begin
    l_Pos := ev_lpCharIndex(';', l_Str);
    l_NewStr := l_Str;
    if l_Pos >= 0 then
    begin
     l_NewStr.SLen := l_Pos;
     f_Values[f_ValuesCount] := Tl3ConstString.MakeI(l_NewStr);
     Inc(f_ValuesCount);
     l_Str := l3Copy(l_Str, l_Pos + 1, MaxInt);
     if f_ValuesCount = cMaxValues then
      Break;
    end
    else
    begin
     f_Values[f_ValuesCount] := Tl3ConstString.MakeI(l_NewStr);
     Inc(f_ValuesCount);
     Break;
    end;
   end;
  end;
 end
 else
 begin
  DropValues;
  Result := False;
 end;
end;

function TddSectionedCSVLoader.pm_GetFileName: AnsiString;
begin
 if Assigned(f_Filer) and (f_Filer is Tl3DOSFiler) then
  Result := Tl3DOSFiler(f_Filer).FileName
 else
  Result := '';
end;

function TddSectionedCSVLoader.pm_GetInProcess: Boolean;
begin
 Result := (f_Filer <> nil) and (f_Filer.Opened);
end;

function TddSectionedCSVLoader.pm_GetValues(Index: Integer): Il3CString;
begin
 Result := f_Values[Index];
end;

function TddSectionedCSVLoader.pm_GetValuesW(aIndex: Integer): Tl3WString;
begin
 if (aIndex > f_ValuesCount - 1) or (aIndex < 0) or (f_Values[aIndex] = nil) then
  Result := cc_EmptyStr
 else
  Result := f_Values[aIndex].AsWStr; 
end;

procedure TddSectionedCSVLoader.pm_SetCanBeChanged(const Value: Boolean);
begin
 Assert(not InProcess, 'TddSectionedCSVLoader: нельзя менять CanBeChanged в процессе обработки!');
 f_CanBeChanged := Value;
end;

procedure TddSectionedCSVLoader.pm_SetValues(Index: Integer; const Value: Il3CString);
begin
 if not f_FileChanged then
 begin
  f_NewFilename := ChangeFileExt(FileName, '.new');
  f_NewVersionFiler := Tl3DOSFiler.Make(f_NewFileName, l3_fmWrite);
  f_NewVersionFiler.Open;
  FlushUnchangedSrcCache;
  f_FileChanged := True;
 end;
 Assert(Index < cMaxValues - 1);
 if Index > f_ValuesCount - 1 then
  f_ValuesCount := Index + 1;
 f_Values[Index] := Value;
 f_LineChanged := True;
end;

procedure TddSectionedCSVLoader.Process;
var
 l_Str : Tl3WString;
 l_Name: Tl3WString;
 l_Pos: Integer;
begin
 if f_CanBeChanged then
  f_SrcCache := Tl3StringList.Make;
 try
  f_Filer.Open;
  try
   while not f_Filer.EOF do
   begin
    l_Str := ReadLine;
    if ExtractSectionName(l_Str) then
    begin
     while not f_Filer.EOF do
      DispatchSection;
    end;
   end;
  finally
   f_Filer.Close;
  end;
 finally
  if f_CanBeChanged then
  begin
   FreeAndNil(f_SrcCache);
   if f_FileChanged then
   begin
    FlushLine;
    FreeAndNil(f_NewVersionFiler);
    DeleteFile(FileName);
    RenameFile(f_NewFileName, FileName)
   end;
  end;
 end;
end;

function TddSectionedCSVLoader.ReadLine: Tl3WString;
var
 l_Str: Il3CString;
begin
 if f_CanBeChanged then
 begin
  l_Str := l3CStr(f_Filer.ReadLn);
  if f_FileChanged then
   FlushLine
  else
   f_SrcCache.Add(f_PrevLine);

  f_PrevLine := l_Str;
  Result := l_Str.AsWStr;
  f_LineChanged := False;                                                                     
 end
 else
  Result := f_Filer.ReadLn;
end;

procedure TddSectionedCSVLoader.SkipSection;
begin
 while NextLine do ;
end;

end.
