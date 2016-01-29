unit DataLoader;

{ $Id: DataLoader.pas,v 1.5 2015/07/02 11:41:02 lukyanets Exp $ }
// $Log: DataLoader.pas,v $
// Revision 1.5  2015/07/02 11:41:02  lukyanets
// Описываем словари
//
// Revision 1.4  2015/04/01 11:54:36  lukyanets
// Изолируем утилиты
//
// Revision 1.3  2014/10/16 10:41:37  lukyanets
// Более контролируемо создаем конфиги
//
// Revision 1.2  2004/12/23 11:47:18  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.1  2004/07/23 13:05:22  step
// утилита занесена в CVS
//

interface

uses
 Contnrs, Classes,
 Ht_Dll, Ht_Const,
 Dt_Serv, l3IniFile;

type
 TDest = packed record
             Doc,
             Sub: LongWord;
            end;
 TDestArray = array[0..(MaxInt div SizeOf(TDest) - 1)] of TDest;
 PDestArray = ^TDestArray;

 THLinkRec = packed record
              Id,
              SourDoc: LongWord;
              Dest: TDest;
             end;
 PHLinkRec = ^THLinkRec;

 TDestPair = class(TObject)
  OldDestImp,
  NewDestImp: TDest;
  OldDestRealDoc: LongWord;
  IsUsed: Boolean;
  constructor Create(aOldDestImp, aNewDestImp: TDest);
 end;

 TRecalcData = class(TObject)
 private
  f_Data: TObjectList;
  f_ChangedDocs: TList;
  procedure Init(aDataFile: string);
  procedure ConvertOldIds;
  function GetItem(Index: Integer): TDestPair;
  procedure SortItems;
 public
  constructor Create;
  destructor Destroy; override;
  procedure OldDestsToSab(var aValues: Sab);
  function RecalcDest(var aDest: TDest): Boolean;
  function UsedItemsAmount: Integer;
  procedure ShowInfo;
  procedure WriteWrongDataToFile;
  procedure WriteChangedDocsToFile;
  procedure AddToChangedDocs(aDocId: LongWord);
  property Items[Index: Integer]: TDestPair read GetItem;
 end;

 TDbTool = class(TObject)
 public
  constructor Create(const aArchiIni: string);
  destructor Destroy; override;
 end;

 THLinksLoader = class(TDbTool)
 public
  procedure RecalcHLinks(const aHlinkDataFile: string);
 end;

 TDatesLoader = class(TDbTool)
 private
  procedure LoadDatesToStream(const aDatesDataFile: string; aStream: TStream);
 public
  procedure AddDates(const aDatesDataFile: string);
 end;

 TUpdateTableSub = class(TDbTool)
 public
  procedure Update;
 end;

implementation

uses
 SysUtils, Dialogs, Math, Controls, Forms, Windows,
 l3Base, l3Date,
 STDateSt,
 ncsDefaultProviderHolder,
 daTypes,
 Dt_Types, Dt_Hyper, Dt_Renum, Dt_Const, Dt_Link, Dt_Dict;

const
 c_WrongDataFileName = 'wrong_hlinks.txt';
 c_ChangedDocsFileName = 'ChangedDocs.txt';

{ THLinksLoader }

procedure TDatesLoader.AddDates(const aDatesDataFile: string);
var
 l_TransactId: TRID;
 l_SavedCursor: TCursor;
 l_Data: TMemoryStream;
begin
 l_SavedCursor := Screen.Cursor;
 Screen.Cursor := crHourGlass;
 try
  l_Data := TMemoryStream.Create;
  LoadDatesToStream(aDatesDataFile, l_Data);

  try
   htSetTransTimeOut(15*60); // 15 минут
   try
    LinkServer.Family := CurrentFamily;
    DictServer.Family := CurrentFamily;
    GlobalHtServer.StartTransaction([LinkServer.Links[da_dlDateNums],
                                     DictServer.GroupTbl[da_dlDateNums],
                                     GlobalHtServer.FreeTbl[CurrentFamily]],
                                    l_TransactId);
    try
     DictServer.AddBatchToGroupDict(da_dlDateNums, l_Data);

     GlobalHtServer.CommitTransaction(l_TransactId);
    except
     GlobalHtServer.RollbackTransaction(l_TransactId);
     raise;
    end;
   finally
    htSetTransTimeOut(MaxTrsTime);
   end;
  finally
   FreeAndNil(l_Data);
  end;
 finally
  Screen.Cursor := l_SavedCursor;
 end;
end;

function fn_RecalcDest(gRecNo  : LongInt;
                       fpRecord: Pointer;
                       fpUser  : Pointer):Boolean; pascal;
var
 l_RecalcData: TRecalcData absolute fpUser;
begin
 Result := l_RecalcData.RecalcDest(PHLinkRec(fpRecord)^.Dest);
 if Result then // сохраним номер измененного документа
  l_RecalcData.AddToChangedDocs(PHLinkRec(fpRecord)^.SourDoc);
end;

procedure TDatesLoader.LoadDatesToStream(const aDatesDataFile: string;
                                        aStream: TStream);
const
 c_WrongValue = MaxInt;
var
 l_Strings: TStringList;
 l_Words: TStringList;
 I: Integer;
 l_Rec: TDNDictRecEx;
 l_Date: string;
 l_RecId: Integer; // специально не LongWord
begin
 aStream.Size := 0;

 // Num
 FillChar(l_Rec.Num, SizeOf(l_Rec.Num), Ord(' ')); // 20 пробелов
 // Typ
 l_Rec.Typ := 5;
 // Comment
 FillChar(l_Rec.Comment, SizeOf(l_Rec.Comment), Ord(' ')); // 70 пробелов

 l_Strings := TStringList.Create;
 l_Words := TStringList.Create;
 try
  l_Strings.LoadFromFile(aDatesDataFile);
  l_Words.Capacity := 2;

  for I := 0 to l_Strings.Count - 1 do
  begin
   l_Words.Clear;
   ExtractStrings([' '], [' '], PChar(l_Strings[I]), l_Words);

   if l_Words.Count <> 2 then
    Continue;

   // Id
   l_RecId := StrToIntDef(l_Words[0], c_WrongValue);
   if (l_RecId = c_WrongValue) then
    Continue;
   // Import --> Real
   l_RecId := GlobalHtServer.ReNumTbl[CurrentFamily].ConvertToRealNumber(l_RecId);
   if l_RecId = -1 then
    Continue;
   l_Rec.ID := LongWord(l_RecId);


   // Date
   l_Date := l_Words[1];
   l_Rec.Date := StDateToDemon(DateStringToStDate('dd/mm/yyyy', l_Date, 0));

   if (l_Rec.Date = 0) then
    Continue;

   aStream.Write(l_Rec, SizeOf(l_Rec));
  end; // for
 finally
  l_Words.Free;
  l_Strings.Free;
 end;
end;

procedure THLinksLoader.RecalcHLinks(const aHlinkDataFile: string);
const
 c_WrongValue: Integer = MaxInt;
 c_DestKeyFieldNum = 6;
var
 l_TransactId: TRID;
 l_OldDests: Sab;
 l_Recs: Sab;
 l_SavedCursor: TCursor;
 l_RecalcData: TRecalcData;
begin
 FillChar(l_Recs, SizeOf(l_Recs), 0);
 FillChar(l_OldDests, SizeOf(l_OldDests), 0);

 l_SavedCursor := Screen.Cursor;
 Screen.Cursor := crHourGlass;
 try
  l_RecalcData := TRecalcData.Create;
  try
   HLServer.Family := CurrentFamily;
   HLServer.HLinkTbl.RefreshSrchList;

   htSetTransTimeOut(15*60); // 15 минут
   try
    GlobalHtServer.StartTransaction([GlobalHtServer.ReNumTbl[CurrentFamily],
                                     HLServer.HLinkTbl,
                                     GlobalHtServer.FreeTbl[CurrentFamily]],
                                    l_TransactId);
    try
     l_RecalcData.Init(aHlinkDataFile);

     htCreateEmptySAB(@HLServer.HLinkTbl.fSrchList,
                      l_OldDests,
                      HLServer.HLinkTbl.TblH,
                      c_DestKeyFieldNum,
                      RES_VALUE);
     try
      l_RecalcData.OldDestsToSab(l_OldDests);
      htRecordsByKey(l_Recs, l_OldDests);
      try
       htHoldResults(l_Recs);
       try
        htModifyRecords(l_Recs, @fn_RecalcDest, nil, l_RecalcData, False);
       finally
        htReleaseResults(l_Recs);
       end;
      finally
       htClearResults(l_Recs);
      end;
     finally
      htClearResults(l_OldDests);
     end;
     GlobalHtServer.CommitTransaction(l_TransactId);
    except
     GlobalHtServer.RollbackTransaction(l_TransactId);
     raise;
    end;
   finally
    htSetTransTimeOut(MaxTrsTime);
   end;
   l_RecalcData.ShowInfo;
  finally
   l3Free(l_RecalcData);
  end;
 finally
  Screen.Cursor := l_SavedCursor;
 end;
end;

{ TRecalcData }

constructor TRecalcData.Create;
begin
 f_Data := TObjectList.Create(True);
 f_ChangedDocs := TList.Create;
end;

destructor TRecalcData.Destroy;
begin
 f_ChangedDocs.Free;
 f_Data.Free;

 inherited;
end;

procedure TRecalcData.OldDestsToSab(var aValues: Sab);
const
 c_BufLen = 64 * 1024;
 c_BufSize = c_BufLen div SizeOf(TDest);
var
 l_Buf: Pointer;
 l_BufCount: Integer;
 I, J: Integer;
begin
 GetMem(l_Buf, c_BufLen);
 try
  htOpenResults(aValues, ROPEN_READ, nil, 0);
  try
   SortItems;
   for I := 0 to (f_Data.Count div c_BufSize) do
   begin
    l_BufCount := Min(c_BufSize, f_Data.Count - (I * c_BufSize));
    for J := 0 to l_BufCount - 1 do
    begin
     PDestArray(l_Buf)^[J].Doc := Items[I * l_BufCount + J].OldDestRealDoc;
     PDestArray(l_Buf)^[J].Sub := Items[I * l_BufCount + J].OldDestImp.Sub;
    end;

    htIncludeResultsBlock(aValues,
                          I * c_BufLen,
                          l_Buf,
                          l_BufCount * SizeOf(TDest));
   end; // for
  finally
   htCloseResults(aValues);
  end;
 finally
  FreeMem(l_Buf);
 end;
end;

procedure TRecalcData.Init(aDataFile: string);
const
 c_WrongValue = LongWord(MaxInt);
var
 l_Strings: TStringList;
 I: Integer;
 l_OldDest, l_NewDest: TDest;
 l_Words: TStringList;
begin
 l_Strings := TStringList.Create;
 l_Words := TStringList.Create;
 try
  l_Strings.LoadFromFile(aDataFile);
  l_Words.Capacity := 4;

  for I := 0 to l_Strings.Count - 1 do
  begin
   l_Words.Clear;
   ExtractStrings([' ', '.'], [' '], PChar(l_Strings[I]), l_Words);

   if l_Words.Count <> 4 then
    Continue;

   l_OldDest.Doc := StrToIntDef(l_Words[0], c_WrongValue);
   l_OldDest.Sub := StrToIntDef(l_Words[1], c_WrongValue);
   l_NewDest.Doc := StrToIntDef(l_Words[2], c_WrongValue);
   l_NewDest.Sub := StrToIntDef(l_Words[3], c_WrongValue);

   if (l_OldDest.Doc = c_WrongValue)
    or (l_OldDest.Sub = c_WrongValue)
    or (l_NewDest.Doc = c_WrongValue)
    or (l_NewDest.Sub = c_WrongValue)
   then
    Continue;

   f_Data.Add(TDestPair.Create(l_OldDest,l_NewDest ));
  end; // for
 finally
  l_Words.Free;
  l_Strings.Free;
 end;

 ConvertOldIds;
end;

function TRecalcData.RecalcDest(var aDest: TDest): Boolean;
var
 I: Integer;
 l_Doc: Integer;
begin
 Result := False;
 for I := 0 to f_Data.Count - 1 do
  if (Items[I].OldDestRealDoc = aDest.Doc)
   and (Items[I].OldDestImp.Sub = aDest.Sub) then
  begin
   Items[I].IsUsed := True;

   aDest := Items[I].NewDestImp;
   l_Doc := aDest.Doc;
   GlobalHtServer.ReNumTbl[CurrentFamily].GetRNumber(l_Doc);
   aDest.Doc := l_Doc;
   Result := True;
   Break;
  end;
end;

procedure TRecalcData.ConvertOldIds;
var
 I: Integer;
begin
 for I := 0 to f_Data.Count - 1 do
 begin
  Items[I].OldDestRealDoc :=
   GlobalHtServer.ReNumTbl[CurrentFamily].ConvertToRealNumber(
    Items[I].OldDestImp.Doc
   );
 end;
end;

function TRecalcData.GetItem(Index: Integer): TDestPair;
begin
 Result := TDestPair(f_Data[Index]);
end;

procedure TRecalcData.ShowInfo;
var
 l_UsedAmount: Integer;
begin
 WriteChangedDocsToFile;
 
 l_UsedAmount := UsedItemsAmount;
 if f_Data.Count > l_UsedAmount then
 begin
  WriteWrongDataToFile;

  MessageDlg(SysUtils.Format('Всего записей  - %d штук.'#13#10'Из них использовано - %d.'#13#10#13#10 +
                             'Номера измененных документов выложены в файл %s.'#13#10 +
                             'Неиспользованные данные выложены в файл %s.',
                             [f_Data.Count, UsedItemsAmount, c_ChangedDocsFileName, c_WrongDataFileName]),
             mtInformation,
             [mbOK],
             0);
 end
 else
  MessageDlg(SysUtils.Format('Всего записей  - %d штук.'#13#10'Все из них использованы.'#13#10 +
                             'Номера измененных документов выложены в файл %s.',
                             [f_Data.Count, c_ChangedDocsFileName]),
             mtInformation,
             [mbOK],
             0);
end;

function TRecalcData.UsedItemsAmount: Integer;
var
 I: Integer;
begin
 Result := 0;
 for I := 0 to f_Data.Count - 1 do
  if Items[I].IsUsed then
   Inc(Result);
end;

procedure TRecalcData.WriteWrongDataToFile;
var
 l_FileStream: TFileStream;
 I: Integer;
 l_Rec: string;
begin
 l_FileStream := TFileStream.Create(c_WrongDataFileName, fmCreate);
 try
  for I := 0 to f_Data.Count - 1 do
   if not Items[I].IsUsed then
   begin
    l_Rec := Format('%d.%d %d.%d'#13#10, [Items[I].OldDestImp.Doc,
                                          Items[I].OldDestImp.Sub,
                                          Items[I].NewDestImp.Doc,
                                          Items[I].NewDestImp.Sub]);
    l_FileStream.Write(PChar(l_Rec)^, Length(l_Rec));
   end;
 finally
  l_FileStream.Free;
 end;
end;

function fn_SortItems(Item1, Item2: Pointer): Integer;
var
 l_Doc1, l_Doc2, l_Sub1, l_Sub2: Integer;
begin
 l_Doc1 := TDestPair(Item1).OldDestRealDoc;
 l_Doc2 := TDestPair(Item2).OldDestRealDoc;
 l_Sub1 := TDestPair(Item1).OldDestImp.Sub;
 l_Sub2 := TDestPair(Item2).OldDestImp.Sub;

 Result := l_Doc1 - l_Doc2;
 if Result = 0 then
  Result := l_Sub1 - l_Sub2;
end;

procedure TRecalcData.SortItems;
begin
 f_Data.Sort(fn_SortItems);
end;

procedure TRecalcData.AddToChangedDocs(aDocId: LongWord);
begin
 if f_ChangedDocs.IndexOf(Pointer(aDocId)) < 0 then
  f_ChangedDocs.Add(Pointer(aDocId));
end;

function fn_SortChangedDocs(Item1, Item2: Pointer): Integer;
var
 l_1, l_2: Integer;
begin
 l_1 := LongWord(Item1);
 l_2 := LongWord(Item2);
 Result := l_1 - l_2;
end;

procedure TRecalcData.WriteChangedDocsToFile;
var
 l_FileStream: TFileStream;
 I: Integer;
 l_Rec: string;
begin
 f_ChangedDocs.Sort(fn_SortChangedDocs);
 l_FileStream := TFileStream.Create(c_ChangedDocsFileName, fmCreate);
 try
  for I := 0 to f_ChangedDocs.Count - 1 do
  begin
   l_Rec := Format('%d'#13#10, [LongWord(f_ChangedDocs[I])]);
   l_FileStream.Write(PChar(l_Rec)^, Length(l_Rec));
  end;
 finally
  l_FileStream.Free;
 end;
end;

{ TDestPair }

constructor TDestPair.Create(aOldDestImp, aNewDestImp: TDest);
begin
 OldDestImp := aOldDestImp;
 NewDestImp := aNewDestImp;
 OldDestRealDoc := 0;
 IsUsed := False;
end;

{ TDbTool }

constructor TDbTool.Create(const aArchiIni: string);
begin
 InitStationAndServerConfig(aArchiIni);
 TncsDefaultProviderHolder.CreateProvider;
 CreateHt(False);
end;

destructor TDbTool.Destroy;
begin
 TncsDefaultProviderHolder.DestroyProvider;

 DoneConfigs;

 inherited;
end;

{ TUpdateTableSub }

procedure TUpdateTableSub.Update;
begin
 HLServer.Family := CurrentFamily;
 HLServer.SubTbl.UpdateTbl;
end;

end.

