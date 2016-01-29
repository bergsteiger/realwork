unit HLinkRestorer;

{ $Id: HLinkRestorer.pas,v 1.25 2015/04/10 08:27:15 lukyanets Exp $ }
// $Log: HLinkRestorer.pas,v $
// Revision 1.25  2015/04/10 08:27:15  lukyanets
// Убираем отмершее
//
// Revision 1.24  2015/04/07 13:57:34  lukyanets
// Изолируем события
//
// Revision 1.23  2015/04/07 07:35:56  lukyanets
// Изолируем HT
//
// Revision 1.22  2015/04/06 08:46:12  lukyanets
// Изолируем Lock сервера
//
// Revision 1.21  2015/04/01 11:54:37  lukyanets
// Изолируем утилиты
//
// Revision 1.20  2014/10/16 10:41:38  lukyanets
// Более контролируемо создаем конфиги
//
// Revision 1.19  2006/01/10 08:42:20  lulin
// - не компилировался Эверест.
//
// Revision 1.18  2005/07/25 13:06:53  lulin
// - исправлено имя класса компонента для записи EVD.
//
// Revision 1.17  2005/05/17 09:32:33  lulin
// - cleanup.
//
// Revision 1.16  2004/12/23 11:47:17  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.15  2004/10/18 11:44:04  step
// рефакторинг
//
// Revision 1.14  2004/10/15 18:25:36  step
// Ссылка НЕ добавляется в таблицу HLINKS, если в этой таблице имеется ОДНА ссылка с такими же LinkId, DocID
//
// Revision 1.13  2004/10/13 12:43:56  step
// добавлен показ сообщений в RemoveBadDocs
//
// Revision 1.12  2004/10/08 16:53:09  step
// уточнение расположения файлов
//
// Revision 1.11  2004/10/04 16:07:45  step
// bug fix
//
// Revision 1.10  2004/10/04 15:58:06  step
// добавлена возможность удаления из хранилища документов-фантомов
//
// Revision 1.9  2004/09/30 09:20:22  step
// показ количества найденных документов-фантомов
//
// Revision 1.8  2004/09/30 09:05:02  step
// учтены номера справок при проверке правильности номеров документов
//
// Revision 1.7  2004/09/29 18:04:12  step
// bug fix
//
// Revision 1.6  2004/09/29 16:49:56  step
// добавлена проверка номеров документов
//
// Revision 1.5  2004/09/28 14:05:19  step
// учтено наличие нулевых HLINK.ID
//
// Revision 1.4  2004/09/27 14:56:35  step
// почистил код
//
// Revision 1.3  2004/09/27 12:26:01  lulin
// - GetDocument заменил на SingleFile.
//
// Revision 1.2  2004/09/27 11:53:06  lulin
// - добавлены забытые inherited вызовы.
// - убраны лишние вызовы Clear.
//
// Revision 1.1  2004/09/27 11:31:24  step
// проект переписан
//

interface

uses
 Classes, Dt_HLinksFilter, l3Base, l3Types, Forms, daInterfaces;

type

 TShowAmountEvent = procedure (aAmount: Integer) of object;

 TSubRec = class(Tl3Base)
 public
  DocId,
  SubId: LongWord;
  RealFlag: Byte;
  Name: string;
  constructor Create(aDocId, aSubId: LongInt; aRealFlag: Byte; aName: PChar); reintroduce;
  function  Compare(const aCompareData: Tl3CompareData;
                    aSortIndex: Tl3SortIndex): Long; override; // для сортировки только по номерам документов
 end;

 TSubKey = class(Tl3Base)
 public
  DocId,
  SubId: Longint;
  constructor Create(aDocId, aSubId: Longint); reintroduce;
  function  Compare(const aCompareData: Tl3CompareData;
                    aSortIndex: Tl3SortIndex): Long; override;
 end;

 TSubs = class(Tl3Base, ISubsProcessor)
 private
  f_AppDir: string;
  f_TableValues: Tl3ObjectRefList;
  f_NewValues: Tl3ObjectRefList;
  f_Used: array of ByteBool;
  f_TmpSubKey: TSubKey;
  f_OnShowAmount: TShowAmountEvent;
 protected
  procedure LoadTableValues;
  procedure ClearTableValues;
 public
  constructor Create(const aAppDir: string); reintroduce;
  procedure Cleanup; override;
  procedure CheckSub(aDocId, aSubId: LongWord; aRealFlag: Byte; aName: PChar);
  procedure ISubsProcessor.Process = CheckSub;
  function WrongTableValuesAmount: Integer;
  function NewValuesAmount: Integer;
  procedure DeleteWrongValuesFromTable;
  procedure AddNewValuesToTable;
  procedure SaveDocNumsToFile;
  property OnShowAmount: TShowAmountEvent read f_OnShowAmount write f_OnShowAmount;
 end;

 THLinkRec = class(Tl3Base)
 public
  LinkId,
  DocId,
  DestDocId,
  DestSubId: LongWord;
  constructor Create(aLinkId, aDocId, aDestDocId, aDestSubId: LongWord); reintroduce;
  function  Compare(const aCompareData: Tl3CompareData;
                    aSortIndex: Tl3SortIndex): Long; override; // для сортировки только по номерам документов
 end;

 THLinkKey = class(Tl3Base) // только первые два поля - LinkId, DocId
 public
  LinkId,
  DocId: Longint;
  Amount: Longint; // кол-во ссылок с одинаковыми полями LinkId, DocId
  constructor Create(aLinkId, aDocId: Longint; aAmount: Longint); reintroduce;
  function  Compare(const aCompareData: Tl3CompareData;
                    aSortIndex: Tl3SortIndex): Long; override;
 end;

 THLinks = class(Tl3Base, IHLinksProcessor)
 private
  f_AppDir: string;
  f_TableKeys: Tl3ObjectRefList;
  f_NewValues: Tl3ObjectRefList;
  f_TmpHLinkKey: THLinkKey;
  f_OnShowAmount: TShowAmountEvent;
 protected
  procedure LoadTableKeys;
  procedure ClearTableValues;
  procedure RepairLinkIds; // заменяет в списке NewValue нулевые LinkId на новые, взятые из табл. Free
 public
  constructor Create(const aAppDir: string); reintroduce;
  procedure Cleanup; override;
  procedure CheckHLink(aLinkId, aDocId, aDestDocId, aDestSubId: LongWord);
  procedure IHLinksProcessor.Process = CheckHLink;
  function NewValuesAmount: Integer;
  procedure DeleteWrongValuesFromTable;
  procedure AddNewValuesToTable;
  procedure SaveDocNumsToFile;
  property OnShowAmount: TShowAmountEvent read f_OnShowAmount write f_OnShowAmount;
 end;

 TDocIds = class(Tl3Base, IDocIdAuditor)
 private
  f_AppDir: string;
  f_Ids: Tl3LongintList;
  f_BadIds: Tl3LongintList;
  f_SaveDir: string;
  procedure LoadIds;
 public
  constructor Create(const aAppDir: string); reintroduce;
  procedure Cleanup; override;
  function IsValid(aFileId: Longint): Boolean;
  procedure SaveBadIdsToFile; // Ids, которые имеются в хранилище, но отсутствуют в таблице FILE
  function MarkAndDownloadBadDocs(const aSaveDir: string): Boolean; // помечает плохие документы как удаленные и вываливает их в файлы EVD
  function BadIdsAmount: Integer;
 end;

 THLinkRestorer = class(Tl3Base)
 private
  f_Form: TForm;
  f_AppDir: string;
  f_DocIdAuditor: TDocIds;
  procedure ShowInfo(aStr: string);
 public
  constructor Create(aForm: TForm; aAppDir: string); reintroduce;
  procedure Cleanup; override;
  procedure Execute;
  function RemoveBadDocs(const aSaveDir: string): Boolean;
 end;

implementation

uses
 ncsDefaultProviderHolder,
 k2Reader, k2TagGen, k2Types, k2Base,
 evEvdRd, evdWriter, evTxtrd, evEditorWindow, evTypes, k2DocumentGenerator, evIntf,
 daDataProvider,
 Dt_Types, Dt_Serv, Dt_Query, Dt_Doc, Dt_Hyper, Dt_Free, Dt_Containers,
 l3IniFile,
 l3Filer, l3FileUtils,
 m3DB, 
 Math, Dialogs, SysUtils,
 m3StorageInterfaces, m3DBInterfaces,
 Main;

const
 EOL = #13#10;

{ THLinkRestorer }

constructor THLinkRestorer.Create(aForm: TForm; aAppDir: string);
begin
 inherited Create;

 f_Form := aForm;
 f_AppDir := aAppDir;
 if not (f_Form is TMainForm) then
  raise Exception.Create('Ошибка в коде');

 InitStationAndServerConfig(ConcatDirName(aAppDir, 'Archi.Ini'));
 TncsDefaultProviderHolder.CreateProvider;

 f_DocIdAuditor := TDocIds.Create(aAppDir);
end;

procedure THLinkRestorer.Execute;
var
 l_HLinksFilter: THLinksFilter;
 l_Fake: Tk2FakeGenerator;
 l_Subs: TSubs;
 l_HLinks: THLinks;

 l_NewHLinksAmount,
 l_NewSubsAmount,
 l_WrongSubsAmount,
 l_BadDocIdsAmount: Integer;

 l_BadDocsDir: string;

begin
 with f_Form as TMainForm do
 begin
  l_BadDocsDir := BadDocsDirEdit.Text;
  if not DirectoryExists(l_BadDocsDir) then
  begin
   MessageDlg('Указан неправильный путь к папке, для сохранения "потерянных" документов.',
              mtError, [mbOK], 0);
   Exit;
  end;

  labStartedTime.Caption := DateTimeToStr(Now);
  ShowInfo('Выполняется захват БД.');
  if not GlobalDataProvider.LockAll then
  begin
   ShowInfo('Не удалось залочить БД.');
   MessageDlg('Не удалось залочить БД.', mtError, [mbOK], 0);
  end
  else
  begin
   ShowInfo('Выполняется чтение данных из таблицы FILE.');
   try
    HLServer.Family := CurrentFamily;
    ShowInfo('Выполняется обновление таблицы SUB.');
    HLServer.HLinkTbl.UpdateTbl;

    ShowInfo('Выполняется обновление таблицы HLINK.');
    HLServer.SubTbl.UpdateTbl;

    ShowInfo('Выполняется чтение данных из таблицы SUB.');
    l_Subs := TSubs.Create(f_AppDir);
    try
     l_Subs.OnShowAmount := ShowSubsAmount;

     ShowInfo('Выполняется чтение данных из таблицы HLINK.');

     l_HLinks := THLinks.Create(f_AppDir);
     try
      l_HLinks.OnShowAmount := ShowHlinksAmount;

      l_Fake := Tk2FakeGenerator.Create;
      try
       l_HLinksFilter := THLinksFilter.Create(l_Subs, l_HLinks, f_DocIdAuditor);
       try
        l_HLinksFilter.Generator := l_Fake;

        ShowInfo('Выполняется поиск потерянных гиперссылок.');
        dtGetDB(CurrentFamily,
                Yield,
                FileMeter.ProgressProc_ev,
                FilesMeter.ProgressProc_ev).AllFiles.Iterate(l_HLinksFilter);
       finally
        l3Free(l_HLinksFilter);
       end;
      finally
       l3Free(l_Fake);
      end;

      // запомним статистику для показа в финальном сообщении
      l_NewHLinksAmount   := l_HLinks.NewValuesAmount;

      l_NewSubsAmount     := l_Subs.NewValuesAmount;
      l_WrongSubsAmount   := l_Subs.WrongTableValuesAmount;
      l_BadDocIdsAmount   := f_DocIdAuditor.BadIdsAmount;

      //ShowInfo('Выполняется удаление лишних записей из таблицы SUB.');
      //l_Subs.DeleteWrongValuesFromTable;

      l_Subs.ClearTableValues; // немного освободим память

      ShowInfo('Выполняется восстановление записей в таблице SUB.');
      l_Subs.AddNewValuesToTable;

      ShowInfo('Создается файл с номерами документов, которым были добавлены SUBы.');
      l_Subs.SaveDocNumsToFile;

      //ShowInfo('Выполняется удаление лишних записей из таблицы HLINK.');
      //l_HLinks.DeleteWrongValuesFromTable;

      l_HLinks.ClearTableValues; // немного освободим память

      ShowInfo('Выполняется восстановление записей в таблице HLINK.');
      l_HLinks.AddNewValuesToTable;

      ShowInfo('Создается файл с номерами документов, которым были добавлены HLINKи.');
      l_HLinks.SaveDocNumsToFile;

      ShowInfo('Выполняется освобождение использованных ресурсов.');
     finally
      l3Free(l_HLinks);
     end;
    finally
     l3Free(l_Subs);
    end;

    ShowInfo('Выполняется заключительное обновление таблицы SUB.');
    HLServer.HLinkTbl.UpdateTbl;

    ShowInfo('Выполняется заключительное обновление таблицы HLINK.');
    HLServer.SubTbl.UpdateTbl;

    ShowInfo('Создается файл с номерами документов, которые отсутствуют в таблице FILE.');
    f_DocIdAuditor.SaveBadIdsToFile;
   finally
    GlobalDataProvider.UnLockAll;
   end;

   ShowInfo('Поиск и восстановление гиперссылок успешно выполнены.');
   labFinishedTime.Caption := DateTimeToStr(Now);

   MessageDlg('Поиск и восстановление гиперссылок успешно выполнены.' + EOL + EOL +
              'Добавлено записей в табл. HLINK: ' + IntToStr(l_NewHLinksAmount) + EOL +
              'Добавлено записей в табл. SUB: ' + IntToStr(l_NewSubsAmount) + EOL +
              'Найдено неиспользованных записей в табл. SUB: ' + IntToStr(l_WrongSubsAmount) + EOL +
              'Найдено документов-фантомов: ' + IntToStr(l_BadDocIdsAmount),
              mtInformation, [mbOK], 0);
  end;
 end; // with
end;

procedure THLinkRestorer.Cleanup;
begin
 l3Free(f_DocIdAuditor);

 TncsDefaultProviderHolder.DestroyProvider;
 DoneConfigs;

 inherited;
end;

function THLinkRestorer.RemoveBadDocs(const aSaveDir: string): Boolean;
begin
 ShowInfo('Выполняется извлечение их хранилища документов, которые отсутствуют в таблице FILE.');
 Result := f_DocIdAuditor.MarkAndDownloadBadDocs(aSaveDir);
 if Result then
  ShowInfo('Документы-фантомы успешно слиты.')
 else
  ShowInfo('Сбой при сливе документов-фантомов');
end;

procedure THLinkRestorer.ShowInfo(aStr: string);
begin
 with f_Form as TMainForm do
 begin
  labInfo.Caption := aStr;
  Yield(nil);
 end;
end;

{ TSubs }

procedure TSubs.AddNewValuesToTable;
var
 I: Integer;
 l_SubRec: TSubRec;
 l_Name: PChar;
begin
 HLServer.SubTbl.StartCaching;
 try
  for I := 0 to f_NewValues.Count - 1 do
  begin
   l_SubRec := TSubRec(f_NewValues.Items[I]);

   HLServer.SubTbl.ClearFullRec;
   HLServer.SubTbl.PutToFullRec(subDID_fld, l_SubRec.DocId);
   HLServer.SubTbl.PutToFullRec(subSID_fld, l_SubRec.SubId);
   HLServer.SubTbl.PutToFullRec(subRFlag_fld, l_SubRec.RealFlag);
   l_Name := PChar(l_SubRec.Name);
   HLServer.SubTbl.PutToFullRec(subName_fld, l_Name);
   HLServer.SubTbl.AddFRec;
  end;
 finally
  HLServer.SubTbl.StopCaching;
 end;
end;

procedure TSubs.SaveDocNumsToFile;
var
 l_CurDoc: Longword;
 I: Integer;
 l_FileStream: TFileStream;
 l_DocNum: string;
 l_EOL: string;
begin
 f_NewValues.Sorted := True; // сортируем по номерам документов

 l_EOL := EOL;
 l_FileStream := TFileStream.Create(ConcatDirName(f_AppDir, 'DocsWithAddedSubs.txt'), fmCreate);
 try
  l_CurDoc := 0;
  for I := 0 to f_NewValues.Count - 1 do
   if TSubRec(f_NewValues.Items[I]).DocId <> l_CurDoc then
   begin
    l_CurDoc := TSubRec(f_NewValues.Items[I]).DocId;
    l_DocNum := IntToStr(l_CurDoc);
    l_FileStream.Write(l_DocNum[1], Length(l_DocNum));
    l_FileStream.Write(l_EOL[1], Length(l_EOL));
   end;
 finally
  l_FileStream.Free;
 end;
end;

procedure TSubs.CheckSub(aDocId, aSubId: LongWord; aRealFlag: Byte;
                         aName: PChar);
var
 l_FoundIndex: Integer;
 l_SubRec: TSubRec;
begin
 f_TmpSubKey.DocId := aDocId;
 f_TmpSubKey.SubId := aSubId;
 if f_TableValues.Find(f_TmpSubKey, l_FoundIndex) then
  f_Used[l_FoundIndex] := True
 else
 begin
  // заносим в список новых
  l_SubRec := TSubRec.Create(aDocId, aSubId, aRealFlag, aName);
  f_NewValues.Add(l_SubRec);
  l3Free(l_SubRec);
 end;

 if Assigned(f_OnShowAmount) then
  f_OnShowAmount(NewValuesAmount);
end;

procedure TSubs.Cleanup;
begin
 l3Free(f_TableValues);

 l3Free(f_NewValues);

 l3Free(f_TmpSubKey);
 
 f_Used := nil;
 inherited;
end;

procedure TSubs.ClearTableValues;
begin
 f_TableValues.Clear;
 f_Used := nil;
end;

constructor TSubs.Create(const aAppDir: string);
begin
 inherited Create;
 f_AppDir := aAppDir;
 f_TableValues := Tl3ObjectRefList.Make;
 f_NewValues := Tl3ObjectRefList.Make;
 f_TmpSubKey := TSubKey.Create(0, 0);

 LoadTableValues;
end;

procedure TSubs.DeleteWrongValuesFromTable;
begin

end;

procedure TSubs.LoadTableValues;
var
 l_Query: TSelectionQuery;
 l_SubKey: TSubKey;
begin
 f_TableValues.Clear;

 HLServer.Family := CurrentFamily;
 l_Query := TSelectionQuery.Create(HLServer.SubTbl);
 try
  l_Query.SortedBy([subDID_fld, subSID_fld]);
  l_Query.Open([subDID_fld, subSID_fld]);
  while not l_Query.Eof do
  begin
   l_SubKey := TSubKey.Create(l_Query.FieldAsLongWord[subDID_fld],
                              l_Query.FieldAsLongWord[subSID_fld]);
   f_TableValues.Add(l_SubKey);
   l3Free(l_SubKey);

   l_Query.Next;
  end;
  l_Query.Close;
 finally
  l3Free(l_Query);
 end;

 f_TableValues.Sorted := True;

 SetLength(f_Used, f_TableValues.Count);
 FillChar(f_Used[0], Length(f_Used), 0);
end;

function TSubs.NewValuesAmount: Integer;
begin
 Result := f_NewValues.Count;
end;

function TSubs.WrongTableValuesAmount: Integer;
var
 I: Integer;
begin
 Result := 0;
 for I := 0 to Length(f_Used) - 1 do
  if not f_Used[I] then
   Inc(Result);
end;

{ TSubKey }

function TSubKey.Compare(const aCompareData: Tl3CompareData;
  aSortIndex: Tl3SortIndex): Long;
begin
 if (aCompareData.CompareType = l3_ctObject) and (aCompareData.AsObject is TSubKey) then
 begin
  Result := CompareValue(Self.DocId, TSubKey(aCompareData.AsObject).DocId);
  if Result = 0 then
   Result := CompareValue(Self.SubId, TSubKey(aCompareData.AsObject).SubId);
 end
 else
  Result := inherited Compare(aCompareData, aSortIndex);
end;

constructor TSubKey.Create(aDocId, aSubId: Longint);
begin
 inherited Create;
 DocId := aDocId;
 SubId := aSubId;
end;

{ TSubRec }

function TSubRec.Compare(const aCompareData: Tl3CompareData;
  aSortIndex: Tl3SortIndex): Long;
begin
 if (aCompareData.CompareType = l3_ctObject) and (aCompareData.AsObject is TSubRec) then
  Result := CompareValue(Self.DocId, TSubRec(aCompareData.AsObject).DocId)
 else
  Result := inherited Compare(aCompareData, aSortIndex);
end;

constructor TSubRec.Create(aDocId, aSubId: Integer; aRealFlag: Byte;
  aName: PChar);
begin
 DocId := aDocId;
 SubId := aSubId;
 RealFlag := aRealFlag;
 Name := aName;
end;

{ THLinkRec }

function THLinkRec.Compare(const aCompareData: Tl3CompareData;
  aSortIndex: Tl3SortIndex): Long;
begin
 if (aCompareData.CompareType = l3_ctObject) and (aCompareData.AsObject is THLinkRec) then
  Result := CompareValue(Self.DocId, THLinkRec(aCompareData.AsObject).DocId)
 else
  Result := inherited Compare(aCompareData, aSortIndex);
end;

constructor THLinkRec.Create(aLinkId, aDocId, aDestDocId, aDestSubId: LongWord);
begin
 inherited Create;
 LinkId := aLinkId;
 DocId := aDocId;
 DestDocId := aDestDocId;
 DestSubId := aDestSubId;
end;

{ THLinkKey }

function THLinkKey.Compare(const aCompareData: Tl3CompareData;
  aSortIndex: Tl3SortIndex): Long;
begin
 if (aCompareData.CompareType = l3_ctObject) and (aCompareData.AsObject is THLinkKey) then
 begin
  Result := CompareValue(Self.LinkId, THLinkKey(aCompareData.AsObject).LinkId);
  if Result = 0 then
   Result := CompareValue(Self.DocId, THLinkKey(aCompareData.AsObject).DocId);
 end
 else
  Result := inherited Compare(aCompareData, aSortIndex);
end;

constructor THLinkKey.Create(aLinkId, aDocId: Longint; aAmount: Longint);
begin
 inherited Create;
 LinkId := aLinkId;
 DocId := aDocId;
 Amount := aAmount;
end;

{ THLinks }

procedure THLinks.AddNewValuesToTable;
var
 I: Integer;
 l_HLinkRec: THLinkRec;
begin
 RepairLinkIds;

 HLServer.HLinkTbl.StartCaching;
 try
  for I := 0 to f_NewValues.Count - 1 do
  begin
   l_HLinkRec := THLinkRec(f_NewValues.Items[I]);

   HLServer.HLinkTbl.ClearFullRec;
   HLServer.HLinkTbl.PutToFullRec(hlID_fld, l_HLinkRec.LinkId);
   HLServer.HLinkTbl.PutToFullRec(hlSourD_fld, l_HLinkRec.DocId);
   HLServer.HLinkTbl.PutToFullRec(hlDestD_fld, l_HLinkRec.DestDocId);
   HLServer.HLinkTbl.PutToFullRec(hlDestS_fld, l_HLinkRec.DestSubId);
   HLServer.HLinkTbl.AddFRec;
  end;
 finally
  HLServer.HLinkTbl.StopCaching;
 end;
end;

procedure THLinks.CheckHLink(aLinkId, aDocId, aDestDocId, aDestSubId: LongWord);
var
 l_FoundIndex: Integer;
 l_HLinkRec: THLinkRec;
begin
 if aLinkId <> 0 then
 begin
  f_TmpHLinkKey.LinkId := aLinkId;
  f_TmpHLinkKey.DocId := aDocId;

  if f_TableKeys.Find(f_TmpHLinkKey, l_FoundIndex) then
   if THLinkKey(f_TableKeys.Items[l_FoundIndex]).Amount = 1 then
    Exit;
 end;

 l_HLinkRec := THLinkRec.Create(aLinkId, aDocId, aDestDocId, aDestSubId);
 f_NewValues.Add(l_HLinkRec);
 l3Free(l_HLinkRec);

 if Assigned(f_OnShowAmount) then
  f_OnShowAmount(NewValuesAmount);
end;

procedure THLinks.Cleanup;
begin
 f_TableKeys.Clear;
 l3Free(f_TableKeys);

 f_NewValues.Clear;
 l3Free(f_NewValues);
 
 l3Free(f_TmpHLinkKey);

 inherited;
end;

procedure THLinks.ClearTableValues;
begin
 f_TableKeys.Clear;
end;

constructor THLinks.Create(const aAppDir: string);
begin
 inherited Create;
 f_AppDir := aAppDir;
 f_TableKeys := Tl3ObjectRefList.Make;
 f_NewValues := Tl3ObjectRefList.Make;
 f_TmpHLinkKey := THLinkKey.Create(0, 0, 0);

 LoadTableKeys;
end;

procedure THLinks.DeleteWrongValuesFromTable;
begin

end;

procedure THLinks.LoadTableKeys;
var
 l_Query: TSelectionQuery;
 l_Cur_LinkId,
 l_Cur_DocID: Longint;
 l_Prev_LinkId,
 l_Prev_DocID: Longint;
 l_Amount: Integer;

 procedure LoadKey(aLinkId, aDocID: Longint; aAmount: Longint);
 var
  l_HLinkKey: THLinkKey;
 begin
  if (aLinkId = 0) or (aDocID = 0) or (aAmount = 0) then
   Exit;
  l_HLinkKey := THLinkKey.Create(aLinkId, aDocID, aAmount);
  f_TableKeys.Add(l_HLinkKey);
  l3Free(l_HLinkKey);
 end;
begin
 f_TableKeys.Clear;

 HLServer.Family := CurrentFamily;
 l_Query := TSelectionQuery.Create(HLServer.HLinkTbl);
 try
  l_Query.SortedBy([hlID_fld, hlSourD_fld]); // важно для подсчета кол-ва одинаковых
  l_Query.Open([hlID_fld, hlSourD_fld]);

  l_Prev_LinkId := 0;
  l_Prev_DocID  := 0;
  l_Amount := 0;
  while not l_Query.Eof do
  begin
   l_Cur_LinkId := l_Query.FieldAsLongWord[hlID_fld];
   l_Cur_DocID :=  l_Query.FieldAsLongWord[hlSourD_fld];

   if (l_Cur_LinkId = l_Prev_LinkId) and (l_Cur_DocID = l_Prev_DocID) then
    Inc(l_Amount)
   else
   begin
    LoadKey(l_Prev_LinkId, l_Prev_DocID, l_Amount);
    l_Prev_LinkId  := l_Cur_LinkId;
    l_Prev_DocID   := l_Cur_DocID;
    l_Amount := 1;
   end;

   l_Query.Next;
  end;// while
  LoadKey(l_Prev_LinkId, l_Prev_DocID, l_Amount);

  l_Query.Close;
 finally
  l3Free(l_Query);
 end;

 f_TableKeys.Sorted := True;
end;

function THLinks.NewValuesAmount: Integer;
begin
 Result := f_NewValues.Count;
end;

procedure THLinks.RepairLinkIds;
var
 I: Integer;
 l_Amount: Integer;
 l_FreeNums: TNumSet;
begin
 // скока нулевых
 l_Amount := 0;
 for I := 0 to f_NewValues.Count - 1 do
  if THLinkRec(f_NewValues.Items[I]).LinkId = 0 then
   Inc(l_Amount);

 if l_Amount = 0 then
  Exit;

 // запрос потребного количества
 l_FreeNums := TNumSet.Create;
 try
  GlobalHtServer.FreeTbl[CurrentFamily].GetFreeNums(HLServer.HLinkTbl.TblName,
                                                    l_Amount,
                                                    l_Amount,
                                                    l_FreeNums);
  // собственно repair
  for I := 0 to f_NewValues.Count - 1 do
   if THLinkRec(f_NewValues.Items[I]).LinkId = 0 then
    THLinkRec(f_NewValues.Items[I]).LinkId := l_FreeNums.Pick;

 finally
  l3Free(l_FreeNums);
 end;
end;

procedure THLinks.SaveDocNumsToFile;
var
 l_CurDoc: Longword;
 I: Integer;
 l_FileStream: TFileStream;
 l_DocNum: string;
 l_EOL: string;
begin
 f_NewValues.Sorted := True; // сортируем по номерам документов

 l_EOL := EOL;
 l_FileStream := TFileStream.Create(ConcatDirName(f_AppDir, 'DocsWithAddedHLinks.txt'), fmCreate);
 try
  l_CurDoc := 0;
  for I := 0 to f_NewValues.Count - 1 do
   if THLinkRec(f_NewValues.Items[I]).DocId <> l_CurDoc then
   begin
    l_CurDoc := THLinkRec(f_NewValues.Items[I]).DocId;
    l_DocNum := IntToStr(l_CurDoc);
    l_FileStream.Write(l_DocNum[1], Length(l_DocNum));
    l_FileStream.Write(l_EOL[1], Length(l_EOL));
   end;
 finally
  l_FileStream.Free;
 end;
end;

{ TDocIds }

function TDocIds.BadIdsAmount: Integer;
begin
 Result := 0;
 if f_BadIds <> nil then
  Result := f_BadIds.Count;
end;

procedure TDocIds.Cleanup;
begin
 l3Free(f_Ids);
 l3Free(f_BadIds);

 inherited;
end;

constructor TDocIds.Create(const aAppDir: string);
begin
 f_AppDir := aAppDir;
 f_Ids := Tl3LongintList.Create;
 f_BadIds := Tl3LongintList.Create;

 LoadIds;
end;

function TDocIds.IsValid(aFileId: Longint): Boolean;
var
 l_Index: Integer;
begin
 Result := f_Ids.Find(aFileId, l_Index);
 if not Result then
  f_BadIds.Add(aFileId);
end;

procedure TDocIds.LoadIds;
var
 l_Query: TSelectionQuery;
 l_References: Tl3LongintList;
 l_ReferenceId: Longint;
 l_Junk: Integer;
 I: Integer;
begin
 f_Ids.Clear;
 f_BadIds.Clear;

 DocumentServer.Family := CurrentFamily;

 // номера документов
 l_Query := TSelectionQuery.Create(DocumentServer.FileTbl);
 try
  l_Query.SortedBy([fId_Fld]);
  l_Query.Open([fId_Fld]);
  while not l_Query.Eof do
  begin
   f_Ids.Add(l_Query.FieldAsLongWord[fId_Fld]);
   l_Query.Next;
  end;
  l_Query.Close;
 finally
  l3Free(l_Query);
 end;
 f_Ids.Sorted := True;

 // номера справок
 l_References := Tl3LongintList.Create;
 try
  l_Query := TSelectionQuery.Create(DocumentServer.FileTbl);
  try
   l_Query.SortedBy([fRelated_fld]);
   l_Query.Open([fRelated_fld]);
   while not l_Query.Eof do
   begin
    l_ReferenceId := l_Query.FieldAsLongWord[fRelated_fld];
    if not f_Ids.Find(l_ReferenceId, l_Junk) then
     l_References.Add(l_ReferenceId);
    l_Query.Next;
   end;
   l_Query.Close;
  finally
   l3Free(l_Query);
  end;

  // перенос набранных номеров справок в общий списочек
  f_Ids.Sorted := False;
  for I := 0 to l_References.Count - 1 do
   f_Ids.Add(l_References.Items[I]);
  f_Ids.Sorted := True;

 finally
  l3Free(l_References);
 end;
end;

function TDocIds.MarkAndDownloadBadDocs(const aSaveDir: string): Boolean;
var
 l_DocBase: Im3DB;
 l_Doc: Im3DbDocument;
 l_FileName: string;
 l_FileStreamAdapter: IStream;
 I: Integer;
 l_ReadToFile,
 l_WrittenToFile: Int64;
 l_NotCopiedDocs: TStringList;
 l_DocStream: IStream;
 l_WellCopied: Boolean;
begin
 f_SaveDir := aSaveDir;

 l_NotCopiedDocs := TStringList.Create;
 try
  l_DocBase := Tm3DB.Make(GlobalDataProvider.TextBase[CurrentFamily],
                          False);
  try
   l_DocBase.Start(m3_saReadWrite, m3_saReadWrite);
   try
    for I := 0 to f_BadIds.Count - 1 do
    begin
     l_Doc := l_DocBase.GetDocument(f_BadIds.Items[I]);
     try
      l_DocStream := l_Doc.Open;
      if l_DocStream <> nil then
      try
       l_FileName := ChangeFileExt(ConcatDirName(aSaveDir, IntToStr(l_Doc.ID)), '.EVD');
       l_FileStreamAdapter := TStreamAdapter.Create(TFileStream.Create(l_FileName, fmCreate),
                                                    soOwned);
       try
        l_WellCopied := l_DocStream.CopyTo(l_FileStreamAdapter,
                                           MaxInt,
                                           l_ReadToFile,
                                           l_WrittenToFile) = S_OK;
       finally
        l_FileStreamAdapter := nil;
       end;

       if l_WellCopied then
        l_Doc.Delete
       else
       begin
        DeleteFile(l_FileName);
        l_NotCopiedDocs.Add(IntToStr(l_Doc.ID));
       end;
      finally
       l_DocStream := nil;
      end;
     finally
      l_Doc := nil;
     end;
    end;
   finally
    l_DocBase.Finish;
   end;
  finally
   l_DocBase := nil;
  end;
  Result := l_NotCopiedDocs.Count = 0;
  if not Result then
   l_NotCopiedDocs.SaveToFile(ConcatDirName(f_AppDir, 'NotSavedBadDocs.txt'));
 finally
  l3Free(l_NotCopiedDocs);
 end;
end;

procedure TDocIds.SaveBadIdsToFile;
var
 I: Integer;
 l_FileStream: TFileStream;
 l_DocNum: string;
begin
 f_BadIds.Sorted := True;

 l_FileStream := TFileStream.Create(ConcatDirName(f_AppDir, 'WrongDocIds.txt'), fmCreate);
 try
  for I := 0 to f_BadIds.Count - 1 do
  begin
   l_DocNum := IntToStr(f_BadIds.Items[I]) + EOL;
   l_FileStream.Write(l_DocNum[1], Length(l_DocNum));
  end;
 finally
  l_FileStream.Free;
 end;
end;

end.



