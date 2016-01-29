unit liEngine;

interface

uses
 l3Types,
 l3Interfaces,
 l3Base,
 l3DatLst,
 l3Filer
 ;

const
 cLastColumn = 'X';

type
 TListRow = array['A'..cLastColumn] of Il3CString;

 TListImporter = class(Tl3Base)
 private
  f_FileName: string;
  f_Header: TListRow;
  f_OnProgress: Tl3ProgressProc;
  procedure LoadRow(aFiler: Tl3CustomFiler; var theRow: TListRow);
  function pm_GetHeader(Index: Char): Il3CString;
  function GetRowString(const aRow: TListRow): Il3CString;
 protected
 public
  constructor Create(aFileName: string);
  procedure Process;
  function ProcessRow(var aRow: TListRow): Boolean;
  property FileName: string read f_FileName write f_FileName;
  property Header[Index: Char]: Il3CString read pm_GetHeader;
  property OnProgress: Tl3ProgressProc read f_OnProgress write f_OnProgress;
 end;


implementation
uses
 Classes,
 l3Date,
 l3String,
 l3Tree_TLB,
 l3Nodes,
 l3TreeInterfaces,
 l3DateSt,
 l3FileUtils,

 SysUtils,
 StrUtils,
 JclStrings,

 daTypes,

 DT_Types,
 DT_Const,
 DT_Serv,
 DT_Doc,
 Dt_ReNum,
 Dt_Free,
 DT_Dict,
 dt_TblCacheDef,
 DT_LinkServ,
 DT_DocImages,
 DT_TblCache,
 dt_AttrSchema,
 DT_DictConst,
 DT_Record;

constructor TListImporter.Create(aFileName: string);
begin
 inherited Create;
 f_FileName := aFileName;
end;

procedure TListImporter.LoadRow(aFiler: Tl3CustomFiler; var theRow: TListRow);
var
 l_SrcString: Tl3WString;
 C: Char;
 l_Offset: Integer;
 l_WordEnd: Integer;

begin
 l_SrcString := l3Trim(aFiler.ReadLn);
 Finalize(theRow);
 if not l3IsNil(l_SrcString) then
 begin
  C := 'A';
  l_Offset  := 0;
  l_WordEnd := 0;
  while l_WordEnd < l_SrcString.SLen do
  begin
   if l_SrcString.S[l_WordEnd] = ';' then
   begin
    if l_WordEnd > l_Offset then
     theRow[C] := l3CStr(l3Trim(l3PCharLen(l_SrcString.S + l_Offset, l_WordEnd - l_Offset, l_SrcString.SCodePage)));
    Inc(C);
    if C > cLastColumn then
     Break;
    l_Offset := l_WordEnd + 1;
   end;
   Inc(l_WordEnd);
  end;
 end; 
end;

function TListImporter.pm_GetHeader(Index: Char): Il3CString;
begin
 Result := f_Header[Index];
end;

procedure TListImporter.Process;
var
 I: Integer;
 l_Row: TListRow;
 l_Dest, l_Src: Tl3DOSFiler;
 l_TempFName: string;
begin
 l_Src := Tl3DOSFiler.Make(f_FileName, l3_fmRead);
 try
  l_Src.Indicator.NeedProgressProc := True;
  l_Src.Indicator.OnProgressProc := f_OnProgress;
  l_Src.Open;
  LoadRow(l_Src, f_Header);
  l_TempFName := ChangeFileExt(f_FileName, '.processed.csv');
  l_Dest := Tl3DOSFiler.Make(l_TempFName, l3_fmWrite);
  try
   l_Dest.Open;
   l_Dest.WriteLn(GetRowString(f_Header).AsWStr);
   while not l_Src.EOF do
   begin
    LoadRow(l_Src, l_Row);
    ProcessRow(l_Row);
    l_Dest.WriteLn(GetRowString(l_Row).AsWStr);
   end;
  finally
   l3Free(l_Dest);
  end;
 finally
   l3Free(l_Src);;
 end;
 RenameFileSafe(l_TempFName, f_FileName);
end;

function TListImporter.ProcessRow(var aRow: TListRow): Boolean;
var
 l_DocID: TDocID;
 l_RealDocID: TDocID;
 l_IsNewDoc: Boolean;
 l_Free: TFreeTbl;
 l_FileTbl: TFileTbl;
 l_FullName: Tl3WString;
 l_Rec: TdtRecord;
 l_DNCache : TCacheDiffAttrData;
 l_Filename: string;
 l_SourceIDs: array[0..1] of TDictID;
 l_Type: Byte;
 l_AbsNum: Integer;
 l_StartDate, l_EndDate: TStDate;

 procedure AddToX(const aStr: string);
 begin
  if not l3IsNil(aRow['X']) then
   aRow['X'] := l3Cat(aRow['X'], ', ');
  aRow['X'] := l3Cat(aRow['X'], aStr);
 end;

 procedure GetDN(aDNType: TDNType; aNumCol, aDateCol: Char);
 var
  l_Date: TStDate;
  l_Num : Tl3String;
 begin
  if (not l3IsNil(aRow[aNumCol])) or (not l3IsNil(aRow[aDateCol])) then
  begin
   l_Num := nil;
   l3Set(l_Num, aRow[aNumCol]);
   try
    if not l3IsNil(aRow[aDateCol]) then
    begin
     l_Date := DateTimeToStDate(l3Date.StrToDateDef(l3PCharLen2String(aRow[aDateCol].AsWStr), BadDateTime));
     if l_Date = BadDate then
     begin
      AddToX('Некорректая дата (столбец "'+aDateCol+'")');
      Exit;
     end;
    end;
    l_DNCache.AddRecord([l_RealDocID,
                         l_Date,
                         l_Num,
                         Ord(aDNType),
                         Tl3String(nil),
                         0]);
   finally
    l3Free(l_Num);
   end;
  end;
 end;

 procedure AddLinkToDict(aDict: TdaDictionaryType; aCol: Char);
 var
  l_DictRoot: TDictRootNode;
  l_Node    : Il3Node;
  l_HNode: Il3HandleNode;
  l_LinkData: TSublinkDataRec;

  function IterDict(const CurNode : Il3Node): Boolean;
  begin
   Result := AnsiContainsText(l3Str(CurNode.Text), l3Str(aRow[aCol])); /// НЕХОРОШО!
  end;

 begin
  if not l3IsNil(aRow[aCol]) then
  begin
   l_DictRoot := DictServer(CurrentFamily).DictRootNode[aDict].Use;
   try
    l_Node := l3IterateSubTreeF(l_DictRoot, l3L2NA(@IterDict), imCheckResult or imLeavesOnly);
    if l_Node <> nil then
    begin
     if l3IOk(l_Node.QueryInterface(Il3HandleNode,l_HNode)) then
     begin
      l_LinkData.DictID := l_HNode.Handle;
      l_LinkData.SubID  := 0;
      LinkServer(CurrentFamily).Links[aDict].AddNode(l_RealDocID, l_LinkData);
     end;
    end
    else
     AddToX('Некорректное значение в столбце "' + l3Str(Header[aCol]) + '"');
   finally
    l3Free(l_DictRoot);
   end;
  end;
 end;

begin
 Result := True;
 try
  aRow['X'] := nil; // обнулим лог ошибок
  // надо ли вообще обрабатывать?
  if not l3IsNil(aRow['U']) then
  begin
   aRow['X'] := l3CStr('Строка пропущена');
   Exit;
  end;

  DocumentServer.Family := CurrentFamily;
  l_FileTbl := DocumentServer.FileTbl;

  // выясняем номер топика
  // сначала попробуем создать новый документ
  l_IsNewDoc  := False;
  l_DocID     := cUndefDocID;
  l_RealDocID := cUndefDocID;
  if not l3IsNil(aRow['S']) then
  begin
   l_DocID := l3StrToIntDef(aRow['S'].AsWStr, -1);
   if l_DocID = -1 then
   begin
    aRow['X'] := l3CStr('Ошибка в номере топика (S)');
    Result := False;
    Exit;
   end;
   // получаем внутренний id топика
   l_RealDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(l_DocID);
   // если такой документ уже есть, то отказать в обработке
   if (l_RealDocID <> cUndefDocID) and l_FileTbl.CheckDoc(l_RealDocID) then
   begin
    aRow['X'] := l3CStr('Повтор топика');
    Result := False;
    Exit;
   end;
   l_RealDocID := l_DocID;
   LinkServer(CurrentFamily).Renum.GetRNumber(l_RealDocID); // заводим связку Ext-Int
   l_IsNewDoc := True;
  end;

  // Новый документ создавать, возможно, не надо. Возможно, надо модифицировать существующий?
  if l_RealDocID = cUndefDocID then
  begin
   if not l3IsNil(aRow['T']) then
   begin
    l_DocID := l3StrToIntDef(aRow['T'].AsWStr, -1);
    if l_DocID = -1 then
    begin
     aRow['X'] := l3CStr('Ошибка в номере топика (T)');
     Result := False;
     Exit;
    end;
    // получаем внутренний id топика
    l_RealDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(l_DocID);
    // если такого документа нет, то отказать в обработке
    if (l_RealDocID = cUndefDocID) or (not l_FileTbl.CheckDoc(l_RealDocID)) then
    begin
     aRow['X'] := l3CStr('Нет топика');
     Result := False;
     Exit;
    end;
   end;
  end;

  // Номер топика явно не указан. Создаем документ с номером из диапазона.
  if l_RealDocID = cUndefDocID then
  begin
   l_Free := GlobalHtServer.FreeTbl[CurrentFamily];
   repeat
    l_DocID := l_Free.GetFree(ftnDocIDForLists); // если не получится, вылетим по эксепшену и поймаем его ниже
    l_RealDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(l_DocID);
   until (l_RealDocID = cUndefDocID) or (not l_FileTbl.CheckDoc(l_RealDocID));
   l_RealDocID := l_DocID;
   LinkServer(CurrentFamily).Renum.GetRNumber(l_RealDocID); // заводим связку Ext-Int
   l_IsNewDoc := True;
  end;

  if l_RealDocID = cUndefDocID then // на всякий случай
  begin
   aRow['X'] := l3CStr('Ошибка определения номера топика');
   Result := False;
   Exit;
  end;

  if l_IsNewDoc then // создаем новый документ
  begin
   l_Rec := InitRecord(l_FileTbl);
   l_Rec.FillField(fId_Fld, [l_RealDocID]);
   l_Type := Ord(dtText);
   l_Rec.FillField(fType_Fld, [l_Type]);
  end
  else // подгружаем данные о существующем
   l_FileTbl.CheckDoc(l_RealDocID, @l_Rec);

  // заполняем атрибуты документа значениями из реестра
  if not l3IsNil(aRow['E']) then
  begin
   l_Rec.FillField(fFName_Fld, [aRow['E']]);
  end;

  // для дальнейших операций нужно иметь актуальный документ
  l_Rec.Update;

  l_DNCache := TCacheDiffAttrData.Create(CurrentFamily, ctDateNum);
  try
   l_DNCache.CachingMode := cmAddOnly;
   GetDN(dnPublish, 'C', 'D');
   GetDN(dnMU,      'F', 'G');
   l_DNCache.CloseDoc(l_RealDocID);
  finally
   l3Free(l_DNCache);
  end;

  AddLinkToDict(da_dlTypes,   'A');
  AddLinkToDict(da_dlSources, 'B');

  // смотрим образ документа
  if not l3IsNil(aRow['Q']) then
  begin
   if DirectoryExists(l3Str(aRow['R'])) then
   begin
    l_Filename := ConcatDirName(l3Str(aRow['R']), l3Str(aRow['Q']));
    if FileExists(l_Filename) then
    begin
     if not l3IsNil(aRow['J']) then
      l_SourceIDs[0] := DictServer(CurrentFamily).Dict[da_dlCorSources].FindIDByFullPath(aRow['J'].AsWStr)
     else
      l_SourceIDs[0] := cUndefDictID;
     if l_SourceIDs[0] <> cUndefDictID then
     begin
      l_SourceIDs[1] := 0;
      l_StartDate := 0;
      l_EndDate := 0;
      l3StrToDateInterval(l3Str(aRow['L']), l_StartDate, l_EndDate);
      DocImageServer.Add(l_RealDocID,
                         l_Filename,
                         l_SourceIDs,
                         '',
                         l3Str(aRow['K']),
                         l_StartDate,
                         l_EndDate);//,
                         //True, True);
     end
     else
      AddToX('Не найден источник "' + l3Str(aRow['J']) + '"');
    end
    else
     AddToX('Не найден файл '+l_Filename);
   end
   else
    AddToX('Не найден каталог ' + l3Str(aRow['R']));
  end;
 except
  on E: Exception do
  begin
   AddToX(E.Message);
   Result := False;
  end;
 end;
end;

function TListImporter.GetRowString(const aRow: TListRow): Il3CString;
var
 C: Char;
begin
  Result := nil;
  for C := 'A' to 'X' do
  begin
   Result := l3Cat([Result, aRow[C]]);
   if C <> 'X' then
    Result := l3Cat(Result, ';');
  end;
end;

end.
