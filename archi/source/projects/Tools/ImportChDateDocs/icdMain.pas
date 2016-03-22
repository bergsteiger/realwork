unit icdMain;

interface

{$I ProjectDefine.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, ToolEdit, l3Types;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    ProgressBar: TProgressBar;
    btnStart: TButton;
    feSource: TFilenameEdit;
    lblDisplay: TLabel;
    procedure btnStartClick(Sender: TObject);
  private
    procedure DoImportData(const aFileName: string);
    procedure ProgressProc(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
 l3Base,
 l3Interfaces,
 l3Const,
 l3Chars,
 l3Filer,
 l3String,
 l3Date,
 l3DateSt,

 daTypes,
 daSchemeConsts,

 HT_Const,

 dtIntf,
 DT_AttrSchema,
 DT_Const,
 DT_DictConst,
 DT_DictTypes,
 DT_Dict,
 DT_Types,
 DT_Sab,
 DT_Serv,
 DT_Link,
 DT_LinkServ,
 Dt_ReNum,
 Dt_Doc,
 Dt_TblCache,
 Dt_TblCacheDef,
 DT_Misc, l3FieldSortRecList, l3ProtoPtrRecListPrim;

type
 PicdImportRec = ^TicdImportRec;
 TicdImportRec = packed record
  rDocID : TDocID;
  rDate  : TStDate;
  rDictID: TDictID;
  rTargetDocID: TDocID;
  rTargetSubID: TSubID;
  rTargetExtDocID: TDocID;
 end;

 PicdSearchRec = ^TicdSearchRec;
 TicdSearchRec = packed record
  rDocID : TDocID;
  rDate  : TStDate;
  rDictID: TDictID;
  rLDocID: TDocID;
  rLSubID: TSubID;
 end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
 if FileExists(feSource.FileName) then
  DoImportData(feSource.FileName)
 else
  MessageDlg('Файл не найден!', mtError, [mbOk], 0);
end;

procedure TForm1.DoImportData(const aFileName: string);
var
 I: Integer;
 l_AddedCount: Integer;
 l_Compare: Integer;
 l_Filer: Tl3DOSFiler;
 l_DNType: TDNType;
 l_ByteDNType: Byte;
 l_Str: Tl3WString;
 l_ValidInput: Boolean;
 l_DTTbl, l_LnkTbl, l_RenumTbl, l_FileTbl: ITblInfo;
 l_Rec: TicdImportRec;
 l_RenumSab, l_RenumTSab, l_LinkSab, l_DNSab: ISab;
 l_ModifySab: ISab;
 l_MVF: IValueSetFiller;
 l_RLSab, l_DLSab, l_ResultSab: IJoinSab;
 l_HTStub: Pointer;
 l_ImportList: Tl3FieldSortRecList;
 l_ResultCur: ISabCursor;
 l_VF, l_TVF: IValueSetFiller;
 l_LIdx, l_SIdx : Integer;
 l_LRec: PicdImportRec;
 l_RenumMap: TImportIdToRealIdMap;
 l_SRec: PicdSearchRec;
 l_TRenumMap: TImportIdToRealIdMap;
 l_DNCache : TCacheDirectAddAttrData;
 l_IntDocID: LongWord;
 l_IntTargetDocID: TDocID;
 l_MissingCount: Integer;
 l_TempCount: Integer;

  function DoOneWord(const aStr : Tl3PCharLen; IsLast: Bool): Bool;
  var
   l_DT: TDateTime;
   l_Pos: Integer;
  begin
   Result := True;
   if l_Rec.rDocID = 0 then
   begin
    l_Rec.rDocID := l3StrToIntDef(aStr, -1);
    l_ValidInput := l_Rec.rDocID > 0;
    Result := l_ValidInput;
   end
   else
    if l_Rec.rDate = 0 then
    begin
     l_DT := StrToDateFmtDef('dd/mm/yyyy', l3PCharLen2String(aStr), 0);
     l_ValidInput := l_DT <> 0;
     Result := l_ValidInput;
     if l_ValidInput then
      l_Rec.rDate := DateTimeToStDate(l_DT);
    end
    else
     if l_Rec.rTargetExtDocID = 0 then
     begin
      l_Pos := ev_lpCharIndex('.', aStr);
      if l_Pos = l3NotFound then
      begin
       l_Rec.rTargetExtDocID := l3StrToIntDef(aStr, 0);
       l_Rec.rTargetSubID := 0;
      end
      else
      begin
       l_Rec.rTargetExtDocID := l3StrToIntDef(l3Copy(aStr, 0, l_Pos), 0);
       l_Rec.rTargetSubID := l3StrToIntDef(l3Copy(aStr, l_Pos+1), 0);
      end;
      l_ValidInput := l_Rec.rTargetExtDocID > 0;
      Result := False;
     end;
  end;

  procedure GetListRec(const aIdx: Integer);
  begin
   if aIdx < l_ImportList.Count then
    l_LRec := PicdImportRec(l_ImportList.ItemSlot(aIdx))
   else
    l_LRec := nil;
  end;

  function FindZeroDictIDRec(const aDocID: TDocID; const aDate: TStDate): Integer;
  var
   l_IRec: TicdImportRec;
  begin
   l_IRec.rDocID := aDocID;
   l_IRec.rDate := aDate;
   if l_ImportList.Find(l_IRec, Result) then
   begin
    GetListRec(Result);
    while (Result < l_ImportList.Count) and (l_LRec.rDocID = aDocID) and (l_LRec.rDate = aDate) do
    begin
     if l_LRec.rDictID = 0 then
      Exit;
     Inc(Result);
     GetListRec(Result);
    end;
   end;
   Result := -1;
  end;

  procedure GetSearchRec(const aIdx: Integer);
  begin
   if aIdx < l_ResultCur.Count then
    l_SRec := PicdSearchRec(l_ResultCur.GetItem(aIdx))
   else
    l_SRec := nil;
  end;

  function CompareRecs: Integer;
  begin
   if l_LRec.rDocID < l_SRec.rDocID then
    Result := -1
   else
   if l_LRec.rDocID > l_SRec.rDocID then
    Result := 1
   else
   if l_LRec.rDate < l_SRec.rDate then
    Result := -1
   else
   if l_LRec.rDate > l_SRec.rDate then
    Result := 1
   else
   if l_LRec.rTargetDocID < l_SRec.rLDocID then
    Result := -1
   else
   if l_LRec.rTargetDocID > l_SRec.rLDocID then
    Result := 1
   else
   if l_LRec.rTargetSubID < l_SRec.rLSubID then
    Result := -1
   else
   if l_LRec.rTargetSubID > l_SRec.rLSubID then
    Result := 1
   else
    Result := 0;
  end;

  function GetInternalTargetDocId(const aExtDocID: TDocID): LongWord;
  begin
   if not l_TRenumMap.Find(aExtDocID, Result) then
    Result := LinkServer(CurrentFamily).Renum.ConvertExternalDocNumberToInternal(aExtDocID);
  end;

  procedure ReportLRec(const aMsg: AnsiString);
  begin
   l3System.Msg2Log(aMsg + ' ' + 'Топик %d (%s %d.%d)',
      [l_LRec.rDocID, l3DateToStr(l_LRec.rDate, 'dd/mm/yyyy'), l_LRec.rTargetExtDocID, l_LRec.rTargetSubID]);
  end;


  function lModifyRec(gRecNo : LongInt; fpRecord : Pointer) : MFUNC_RET;
  var
   l_Idx: Integer;
   l_TDocID: LongWord;
  begin
   Result := MFUNC_SUCCESS;
   ProgressProc(piCurrent, l_SIdx);
   Inc(l_SIdx);
   with PDNDictRec(fpRecord)^ do
   begin
    l_Rec.rDictID := ID;
    if l_ImportList.FindRecord(l_Rec, l_Idx) then
    begin
     l_LRec := PicdImportRec(l_ImportList.ItemSlot(l_Idx));
     LDocID := l_LRec.rTargetDocID;
     LSubID := l_LRec.rTargetSubID;
     Inc(l_TempCount);
    end;
   end;
  end;


begin
 l_Filer := Tl3DOSFiler.Make(aFileName);
 try
  btnStart.Enabled := False;
  l_Filer.Open;
  l3System.Msg2Log('Загрузка файла %s...', [ExtractFileName(aFileName)]);
  l_DTTbl  := DictServer(CurrentFamily).DictTbl[da_dlDateNums];
  l_LnkTbl := LinkServer(CurrentFamily).Links[da_dlDateNums];
  l_RenumTbl := LinkServer(CurrentFamily).Renum;
  l_FileTbl := DocumentServer(CurrentFamily).FileTbl;
  l_DNType := dnChangerDate;
  l_ByteDNType := Ord(dnChangerDate);
  ProgressProc(piStart, l_Filer.Size, 'Загрузка данных');
  l_RenumSab := MakeSab(l_RenumTbl);
  l_RenumTSab := MakeSab(l_RenumTbl);
  l_VF := l_RenumSab.MakeValueSetFiller(rnImportID_fld);
  l_TVF := l_RenumTSab.MakeValueSetFiller(rnImportID_fld);
  l_ImportList := Tl3FieldSortRecList.Create(SizeOf(TicdImportRec),
   [SizeOf(TDocID), SizeOf(TStDate), SizeOf(TDictID), SizeOf(TDocID), SizeOf(TSubID)], []);
  l_ImportList.Sorted := False;
  try
   while not l_Filer.EOF do
   begin
    l_Str := l3Trim(l_Filer.Readln);
    ProgressProc(piCurrent, l_Filer.Pos);
    l3FillChar(l_Rec, SizeOf(TicdImportRec));
    l_ValidInput := True;
    l3ParseWordsExF(l_Str, l3L2WA(@DoOneWord), [';']);
    if l_ValidInput then
     l_ValidInput := (l_Rec.rDocID > 0) and (l_Rec.rDate > 0) and (l_Rec.rTargetExtDocID > 0);
    if l_ValidInput then
    begin
     l_TVF.AddValue(l_Rec.rTargetExtDocID);
     l_ImportList.Add(l_Rec);
     l_VF.AddValue(l_Rec.rDocID);
    end;
   end; // while
   l3System.Msg2Log('Загружено %d записей', [l_ImportList.Count]);
   l_VF := nil;
   l_TVF := nil;
   l_RenumTSab.RecordsByKey; // готовим список target-документов для быстрого поиска их внутренних номеров
   l_TRenumMap := TImportIdToRealIdMap.Create(l_RenumTSab);
   try
    l_RenumTSab := nil;

    // Переводим все DocID для загруженного списка на внутренние номера (иначе не будут искаться дубликаты)
    ProgressProc(piStart, l_ImportList.Count, 'Конвертируем номера документов');
    for I := 0 to Pred(l_ImportList.Count) do
    begin
     GetListRec(I);
     l_LRec.rTargetDocID := GetInternalTargetDocId(l_LRec.rTargetExtDocID);
     ProgressProc(piCurrent, I);
    end;
    l_ImportList.SortBy([1,2,4,5]);
    l_ImportList.Sorted := True;
    ProgressProc(piEnd, 0);

    l_RenumSab.RecordsByKey; // получили список документов
    // теперь с помощью нехитрых манипуляций оставляем в списке только реально существующие документы
    // потому что наличие номера в Renum не означает наличия документа в базе
    // а нам потом надо будет быстро проверять наличие дока в базе
    l_RenumSab.ValuesOfKey(rnRealID_fld);
    l_RenumSab.TransferToPhoto(fId_Fld, l_FileTbl);
    l_RenumSab.RecordsByKey;
    l_RenumSab.ValuesOfKey(fId_Fld);
    l_RenumSab.TransferToPhoto(rnRealID_fld, l_RenumTbl);
    l_RenumSab.RecordsByKey;

    l_RenumMap := TImportIdToRealIdMap.Create(l_RenumSab); // для проверки наличия доков в базе
    try
     l_LinkSab := MakeAllRecords(l_LnkTbl);
     l_RLSab := MakeJoinSab(l_RenumSab, rnRealID_fld, l_LinkSab, lnkDocIDFld);
     l_DNSab := MakeSab(l_DTTbl);
     l_DNSab.Select(dnTypFld, l_DNType);
     l_DLSab := MakeJoinSab(l_DNSab, dnIDFld, l_LinkSab, lnkDictIDFld);
 
     l_ResultSab := MakeJoinSab(l_RLSab, l_DLSab, True);
     l_RenumSab := nil;
     l_LinkSab := nil;
     l_DNSab := nil;
     l_RLSab := nil;
     l_DLSab := nil;
 
     l_ResultSab.SortJoin([JFRec(l_RenumTbl, rnImportID_fld),
                           JFRec(l_DTTbl, dnDateFld),
                           JFRec(l_DTTbl, dnLinkDocIDFld),
                           JFRec(l_DTTbl, dnLinkSubIDFld)]);

     l_ResultCur := l_ResultSab.MakeJoinSabCursor([JFRec(l_RenumTbl, rnImportID_fld),
                                                   JFRec(l_DTTbl, dnDateFld),
                                                   JFRec(l_DTTbl, dnIDFld),
                                                   JFRec(l_DTTbl, dnLinkDocIDFld),
                                                   JFRec(l_DTTbl, dnLinkSubIDFld)
                                                  ]);
 
     l_LIdx := 0;
     l_SIdx := 0;
     GetListRec(0);
     GetSearchRec(0);

     l_TempCount := 0;
     ProgressProc(piStart, l_ResultCur.Count, 'Поиск дубликатов');
     while (l_LIdx < l_ImportList.Count) and (l_SIdx < l_ResultCur.Count) do
     begin
      l_Compare := CompareRecs;
      if l_Compare = 0 then
      begin
       l_LRec.rDictID := cUndefDictID; // помечаем уже существующие в базе записи
       Inc(l_TempCount);
       Inc(l_LIdx);
       GetListRec(l_LIdx);
       Inc(l_SIdx);
       GetSearchRec(l_SIdx);
      end
      else
       if l_Compare < 0 then
       begin
        Inc(l_LIdx);
        GetListRec(l_LIdx);
       end
       else
       begin
        Inc(l_SIdx);
        GetSearchRec(l_SIdx);
       end;
      ProgressProc(piCurrent, l_SIdx);
     end;
     ProgressProc(piEnd, 0);
     l3System.Msg2Log('Дубликатов найдено: %d', [l_TempCount]);

     // ищем подходящие для изменения записи (у которых LDocID = 0)
     ProgressProc(piStart, l_ResultCur.Count, 'Поиск записей для изменения');
     l_DNSab := MakeSab(l_DTTbl);
     l_VF := l_DNSab.MakeValueSetFiller(dnIDFld);
     l_ImportList.SortBy([1,2]);
     l3FillChar(l_Rec, SizeOf(TicdImportRec)); // поле rDictID должно оставаться 0 (так мы определяем данные в списке, которые надо поместить в базу)
     l_ResultCur.SortJoin([JFRec(l_DTTbl, dnLinkDocIDFld)]);
     l_SIdx := 0;
     GetSearchRec(0);
     while (l_SIdx < l_ResultCur.Count) and (l_SRec.rLDocID = 0) do
     begin
      // нашли запись в датах/номерах, которую можно попытаться изменить
      l_LIdx := FindZeroDictIDRec(l_SRec.rDocID, l_SRec.rDate);
      if l_LIdx >= 0 then
      begin
       GetListRec(l_LIdx);
       l_LRec.rDictID := l_SRec.rDictID;
       l_VF.AddValue(l_SRec.rDictID);
      end;
      ProgressProc(piCurrent, l_SIdx);
      Inc(l_SIdx);
      GetSearchRec(l_SIdx);
     end;
     ProgressProc(piEnd, 0);

     // теперь меняем записи в базе
     l_VF := nil;
     l_DNSab.RecordsByKey;
     l_TempCount := 0;
     l_ImportList.SortBy([3]);
     if l_DNSab.Count > 0 then
     begin
      l3FillChar(l_Rec, SizeOf(TicdImportRec));
      l_SIdx := 0;
      ProgressProc(piStart, l_DNSab.Count, 'Запись значений в БД');
      l_HTStub := HTStub3(@lModifyRec);
      try
       l_DNSab.ModifyRecs(l_HTStub);
      finally
       HTStubFree(l_HTStub);
      end;
      ProgressProc(piEnd, 0);
     end;
     l_TempCount := l_DNSab.Count; // ОТЛАДОЧНО - потом убрать!
     l3System.Msg2Log('Атрибутов дополнено: %d', [l_TempCount]);

     // теперь создадим в базе записи, которым не нашлось места при изменении, т.е. новые
     ProgressProc(piStart, l_ImportList.Count, 'Создаём новые записи');
     DictServer(CurrentFamily).GroupTbl[da_dlDateNums].FreeNumsCacheSize := 100;
     l_LIdx := 0;
     GetListRec(0);
     l_DNCache := TCacheDirectAddAttrData.Create(CurrentFamily, ctDateNum);
     l_MissingCount := 0;
     l_AddedCount := 0;
     try
      while (l_LIdx < l_ImportList.Count) and (l_LRec.rDictID = 0) do // список отсортирован по rDictID, так что можем заложиться на это вот
      begin
       if l_RenumMap.Find(l_LRec.rDocID, l_IntDocID) then // если такой документ есть в базе...
       begin
        l_DNCache.AddRecord([l_IntDocID, l_LRec.rDate, '', l_ByteDNType, l_LRec.rTargetDocID, l_LRec.rTargetSubID]);
        ReportLRec('Добавлена запись:');
        Inc(l_AddedCount);
       end
       else
       begin
        Inc(l_MissingCount);
        ReportLRec('Документ отсутствует в базе:');
       end;
       Inc(l_LIdx);
       GetListRec(l_LIdx);
       ProgressProc(piCurrent, l_LIdx);
      end;
      l_DNCache.Save;
     finally
      FreeAndNil(l_DNCache);
     end;
     l3System.Msg2Log('Атрибутов добавлено: %d', [l_AddedCount]);
     l3System.Msg2Log('Записей пропущено: %d', [l_MissingCount]);
     ProgressProc(piEnd, 0);

    finally
     FreeAndNil(l_RenumMap);
    end;
   finally
    FreeAndNil(l_TRenumMap);
   end;
  finally
   FreeAndNil(l_ImportList);
  end;
  lblDisplay.Caption := 'Операция завершена успешно!';
  l3System.Msg2Log('Работа завершена');
 finally
  btnStart.Enabled := True;
  FreeAndNil(l_Filer);
 end;
end;

procedure TForm1.ProgressProc(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
begin
 case aState of
  piStart:
   begin
    ProgressBar.Position := 0;
    ProgressBar.Max := aValue;
    lblDisplay.Caption := aMsg;
   end;
  piCurrent: if ProgressBar.Position = aValue then
              Exit
             else
              ProgressBar.Position := aValue;
  piEnd    : ProgressBar.Position := ProgressBar.Max;
 end;
 Application.ProcessMessages;
end;

end.
