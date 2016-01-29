unit IDocSpc;

{$Include l3Define.inc}

{ $Id: IDocSpc.pas,v 1.118 2015/04/06 09:38:27 lukyanets Exp $ }

{.$I evDefine.inc}

interface                      
 Uses
  SysUtils, Windows,
  l3Types,
  l3Base,
  l3Date,
  evTypes,
  evCustomEditor,
  DT_Types, DT_Query, DT_IndexSupport,
  D_TxSrch, CustEditWin, EditWin;

 type
  TSrchByTextProc = function (const aSrchStr : AnsiString): TdtQuery;

  IDocSpecial = class(Tl3Base)
   private
    fDocWnd : TCustomEditorWindow;
    function cbfGetSelectStr(Sender : TObject; Var B: PAnsiChar; Var L: Long;
                             Var CharSet: Smallint;
                             Data : Pointer) : Boolean;

    procedure SetVLControlPrim;
    //procedure SetAnoncedPrim;
    procedure SelectTextAction(aActionProc : TSrchByTextProc);

   public
    constructor Create(aDocWnd : TCustomEditorWindow); reintroduce;
    procedure   SetAbolished;
    procedure   SetVChanged;
    procedure   SetAnonced;
    procedure   SetVLControl;
    procedure   SetMoJNotReg;

    procedure   ParseSelectTextAndSearch;
    procedure   SearchBySelectText(aIndexKind : TIndexType);
    procedure   AnalyseTextForParam(const aAnalizeStr : AnsiString = '');
    procedure   ShowDocInfo;
    procedure   FindTNVED;
    function    cnvDate2Text(Sender : TObject; Var B: PAnsiChar; Var L: Long;
                             Var CharSet: Smallint;
                             Data : Pointer) : Boolean;
    //function    EraseSpecialParaWithHyperlinks(aHLDocID: TDocID; aParaStyleID: Integer): Boolean;
    function    ReplaceHyperLinks(aSearchHLDocID: TDocID; aReplaceHLDocID: TDocID): Boolean;
    //function    ReplaceHyperLinksInStyle(aSearchHLDocID: TDocID;
    //                                          aReplaceHLDocID: TDocID;
    //                                          aParaStyleID: Integer): Boolean;

  end;

 Type
  PPointer = ^Pointer;
  PPChar   = ^PAnsiChar;

 function GetNumberFromStr(aStr : AnsiString) : Longint;
 //function GetNearSaturday : TStDate;

implementation

{$INCLUDE ProjectDefine.inc}

uses
  StrUtils,
  Dialogs, vtDialogs, Forms, Controls, StdCtrls,
  //l3Date,
  StrShop, IniShop, l3DateSt,
  l3MinMax, l3DatLst, l3Chars, l3String,
  l3Interfaces, l3Languages,
  evExcept, evOp, evOpProc, evIntf, evSearch, evInternalInterfaces, evdStyles,
  evEditor,
  k2Base, k2Tags,
  //m4DBTools,
  daDataProvider,
  DT_Const, dt_AttrSchema, DT_Link, DT_Dict, DT_Active, DT_Doc, DT_SrchQueries,
  D_GetAbo, D_DocInf,
  arSearch,
  SrchWin,
  DictsSup, evFacadTextSource, evFacadeCursor,//evFacade,
  DocIntf, DocAttrIntf, DocAttrToolsIntf
  , Dt_Alarm, dt_DictTypes, dt_DictConst,

  nevBase
  ;

 type
  TButtonControlHack = class(TButtonControl)
  public
   property ClicksDisabled;
  end;

 {
 function GetNearSaturday : TStDate;
  begin
   Result := CurrentDate + 7 - Ord(l3Date.DayOfWeek(CurrentDate)) - 1;
   If Result = CurrentDate then Result := CurrentDate + 7; //если сегодня суббота то возвращаем следущую
  end;
 }

 (*
  //вариант, который берет только первое число ло точки "4.1.1" = 4
 function GetNumberFromStr(aStr : AnsiString) : Longint;
   {Ищет число в строке. Используется при простановке номера Sub'a}
  var
    IB,IE : Integer;
  begin
   IB:=1;
   Result := -1;
   While (IB <= Length(aStr)) and not (aStr[IB] in cc_Digits) do Inc(IB);
   If (IB > Length(aStr)) then Exit;
   IE := Succ(IB);
   While (IE <= Length(aStr)) and (aStr[IE] in cc_Digits) do Inc(IE);
   try
    Result := StrToInt(Copy(aStr,IB,IE-IB));
   except
   end;
  end;
 *)

 //вариант, который берет все цифры "4.1.1" = 411
 function GetNumberFromStr(aStr : AnsiString) : Longint;
   {Ищет число в строке. Используется при простановке номера Sub'a}
  var
    lStr : ShortString;
    I    : Integer;
  begin
   lStr := '';
   Result := 0;
   for I := 1 to Length(aStr) do
   begin
    if aStr[I] in cc_Digits then
     lStr := lStr + aStr[I]
    else
     if aStr[I] <> '.'
      then  Break;
   end;
   TryStrToInt(lStr, Result);
  end;

 constructor IDocSpecial.Create(aDocWnd : TCustomEditorWindow);
  begin
   Inherited Create;
   fDocWnd := aDocWnd;
  end;

 procedure IDocSpecial.SetAbolished;
  var
   S      : AnsiString;
   S1, S2 : AnsiString;
   Pack   : InevOp;
   VLControlLog : Boolean;
   lWarnID : Integer;
   l_DefaultStyleID : Long;

   lActIntRec : TActiveIntervalRec;
   lInd       : Integer;
   lStartDate : TSTDate;
   lExpDate   : TSTDate;
   l_AlarmRec : TAlarmRec;

  begin
   with fDocWnd as TDocEditorWindow do
   begin
    with (Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool) do
    begin
     if not HasDocThisLogRec(acIncluded) then
     begin
      If vtMessageDlg(l3CStr(@sidNotIncludedWarning), mtWarning,
                                    [mbYes, mbNo], 0, mbNo, mbNo) <> mrYes then
      Exit;
     end;

     if HasDocThisLogRec(acAbolished) then
     begin
      vtMessageDlg(l3CStr(@sidEWJurUnpower), mtWarning);
      Exit;
     end;
    end;

    with TGetAbolishDataDlg.Create(fDocWnd) do
     try
      if Showmodal = mrOK then
      begin
       VLControlLog := lstNameStr.Current = 8;
       S := lstNameStr.Items[lstNameStr.Current];

       If VLControlLog then
         SetVLControlPrim
       else
       begin
          {Записать в ЮЖ утратил силу с текущей датой}
          {---GlobalHTServer.LogBook[FDocFam].PutLogRecSet(DocID, acNoAction);}

        //Active
        with (Document.AttrManager.GetDocAttribute(atActiveIntervals) as IActiveIntervalsAttributeTool) do
        begin
         lInd := GetLastIntervalIndex;

         if (lstNameStr.Current in [18..21]) then
         begin
          if lInd >= 0 then
           Delete(lInd);
          AddRec(maxActiveDate, maxActiveDate);
         end
         else
         begin
          If edtExpDate.IsEmpty then
          lExpDate := minActiveDate
         else
          lExpDate := Pred(edtExpDate.StDate);

          if lInd >= 0 then
           CloseInterval(lInd, lExpDate)
          else
           AddRec(minActiveDate, lExpDate);
         end
        end;

       {!Abolished}
        if not (lstNameStr.Current in [18..21]) then
         (Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool)
           .AddAction(acAbolished, DateTimeToStDate(IniRec.NextVersionDate));

        //Document.DocData.AddLogRec(acAbolished, DateTimeToStDate(IniRec.NextVersionDate));

        S2 := ANSIUpperCase(S) + #0;

        //S  := ' (' + ANSIUpperCase(S) + ')';
        S  := ' (' + S + ')';

        //FullName
        If StrPos(FullNameMEdit.Buffer.S, @S2[1]) = nil then
        begin
         FullNameMEdit.GoToBottom;
         FullNameMEdit.InsertBuf(l3PCharLen(S));
        end;

        //warning
        case lstNameStr.Current of
         0..3   : lWarnID := 2;   //утратил силу
         4..7   : lWarnID := 3;   //прекратил действие
         // 8 снято с контроля
         // 9 подписан Президентом РФ
         11,17  : lWarnID := 19;  //не действует, не применяется
         12..15 : lWarnID := 31;  //отменен
         16     : lWarnID := 12;  //действие приостановлено
         18..21 : lWarnID := 4;   //не вступил в силу
         else     lWarnID := 0;
        end;

        if lWarnID > 0 then
         with (Document.AttrManager.GetDocAttribute(atWarnings) as IDictAttributeTool) do
         begin
          DeleteAll;
          AddRec(lWarnID);
         end;

        // устанавливаем аларм для "не вступил в силу"
        if (lstNameStr.Current in [18..21]) then
        begin
         {with l_AlarmRec do
         begin
          RecID := 0;
          Start := DateTimeToStDate(vtGetNearestDayOfWeek(Monday, False));
          l3StringToArray(Comment, 1000, 'проверить публикацию');
         end;}
         (Document.AttrManager.GetDocAttribute(atAlarms) as IAlarmAttributeTool).AddRec(DateTimeToStDate(vtGetNearestDayOfWeek(Monday, False)),
                                                                                        l3PCharLen('проверить публикацию'));
        end;

        //in Spr
        if ((Document.Spravka <> nil) and Document.Spravka.TextSource.Document.IsValid)
           or
          (IsNewDoc and (cbUserType.ItemIndex in [0,1])) and not (lstNameStr.Current in [18..21]) then
        with SprTextEditor.DocEditor do
        begin
         Pack := StartOp(ev_ocUser+100);
         try
          GoToBottom;  //MoveLeafCursor(ev_ocBottomRight);
          InsertBuf(cc_EOLStr);
          evInsertFrom(SprTextEditor.DocEditor, memoTextStr.TextSource);
         finally
          Pack := nil; {FinishOp;}
         end;
        end;
       end; //VLControlLog

       //in Doc
       if (evGetNettoCharCount(memoTextStr.TextSource) > 0) and not (lstNameStr.Current in [18..21]) then
       begin
        with DocTextEditor.DocEditor do
        begin
         Pack := StartOp(ev_ocUser+100);
         try
          GotoTop;
          try
           repeat
            with CurText do
             if (l3RTrimLen(S, SLen) <> 0) then break;
           until not MoveLeafCursor(ev_ocParaDown, true);

           if MoveLeafCursor(ev_ocParaDown, True) and
              (TextPara.Style.ID <> ev_saChangesInfo) then
            MoveLeafCursor(ev_ocParaUp, True);

           MoveLeafCursor(ev_ocParaEnd);
           InsertBuf(cc_EOLStr);
          except
          end;
          InsertBuf(cc_EOLStr);
          l_DefaultStyleID := TextSource.Processor.DefaultStyle;
          try
           TextSource.Processor.DefaultStyle := ev_saTxtComment;
           evInsertFrom(DocTextEditor.DocEditor, memoTextStr.TextSource);
          finally
           TextSource.Processor.DefaultStyle := l_DefaultStyleID;
          end;
         finally
          Pack := nil; {FinishOp;}
         end;
        end;
       end;

      end;

     finally
      Free;
     end;
    end;
  end;

procedure IDocSpecial.SetMoJNotReg;
 var
  S      : AnsiString;
  S1, S2 : AnsiString;
  lCurItemList : Tl3StringDataList;
  lInd         : Integer;
  lRec         : TDNDictRec;
  lWarnID      : integer;

 begin
  With fDocWnd as TDocEditorWindow do
  begin
   if not (Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool).HasDocThisLogRec(acIncluded) then
   begin
    If vtMessageDlg(l3CStr(@sidNotIncludedWarning), mtWarning,
                                  [mbYes, mbNo], 0, mbNo, mbNo) <> mrYes then
     Exit;
   end;

   if (Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool).HasDocThisLogRec(acAbolished) then
   begin
    vtMessageDlg(l3CStr(@sidEWJurUnpower), mtWarning);
    Exit;
   end;

   {!Abolished}
   (Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool).HasDocThisLogRec(acAbolished,DateTimeToStDate(IniRec.NextVersionDate));

   S  := ' (не действует)';
   S2 := ANSIUpperCase(S) + #0;

   If StrPos(FullNameMEdit.Buffer.S, @S2[1]) = nil then
   begin
    FullNameMEdit.GoToBottom;
    FullNameMEdit.InsertBuf(l3PCharLen(S));
   end;

   {MojnotReg}
   l3FillChar(lRec, SizeOf(lRec));
   lRec.ID := cUndefDictID;
   lRec.Typ := dnMU;
   (Document.AttrManager.GetDocAttribute(atDateNums) as IDateNumDocAttributeTool).AddRec(dnMU, 0, cc_UnAssignedStr);

   lWarnID := 6;
   (Document.AttrManager.GetDocAttribute(atWarnings) as IDictAttributeTool).AddRec(lWarnID);
  end;
 end;

procedure IDocSpecial.SetVChanged;
const
 lWarnNum : Integer = 12;
begin
 With fDocWnd.Document.AttrManager do
 begin
  with (GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool) do
   if not HasDocThisLogRec(acIncluded) then
   begin
    if vtMessageDlg(l3CStr(@sidNotIncludedWarning), mtWarning,
                                 [mbYes, mbNo], 0, mbNo, mbNo) <> mrYes then
     Exit;
   end
   else
    AddLogRecOnce(acChanged,
                  DateTimeToStDate(IniRec.NextVersionDate),
                  DateTimeToStDate(IniRec.NextVersionDate));

  with GetDocAttribute(atWarnings) as IListDocAttribute do
   if (Count > 0) and (Handle[0] = lWarnNum) then
    Delete(0);
 end;
end;

procedure IDocSpecial.SetVLControl;
 begin
  With fDocWnd as TDocEditorWindow do
  begin
   if not (Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool).HasDocThisLogRec(acIncluded) then
    begin
     If vtMessageDlg(l3CStr(@sidNotIncludedWarning), mtWarning,
                                   [mbYes, mbNo], 0, mbNo, mbNo) <> mrYes then
      Exit;
    end;
  end;

  SetVLControlPrim;
 end;

procedure IDocSpecial.SetVLControlPrim;
begin
 (fDocWnd.Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool).AddLogRecOnce(acLControl, 0, DateTimeToStDate(IniRec.NextVersionDate));
end;

procedure IDocSpecial.SetAnonced;
begin
 (fDocWnd.Document.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool).AddLogRecOnce(acAnonced, 0, DateTimeToStDate(IniRec.NextVersionDate));
end;

function IDocSpecial.cbfGetSelectStr(Sender : TObject; Var B: PAnsiChar; Var L: Long;
                             Var CharSet: Smallint;
                             Data : Pointer) : Boolean;
 begin
  PString(Data)^ := l3ArrayToString(B[0], L);
  if (CharSet = CP_OEM) or (CharSet = CP_OEMLite) then
   OemToCharBuff(@PString(Data)^[1], @PString(Data)^[1], L);
  Result := False;
 end;

procedure IDocSpecial.SelectTextAction(aActionProc : TSrchByTextProc);
var
 AnalizeStr : AnsiString;//PAnsiChar;
 SavePersBlock : Boolean;
 SaveReadOnly  : Boolean;
 l_Query : TdtQuery;

begin
 With fDocWnd do
 begin
  if CurEditor.Selection.Collapsed then
  begin
   AnalizeStr := CurEditor.Range.AsString;
  end
  else
  begin
   AnalizeStr := ''; //Nil;
   if CurEditor.Selection <> nil then
    SavePersBlock := CurEditor.Selection.Persistent
   else
    SavePersBlock := False;
   SaveReadOnly  := CurEditor.ReadOnly;

   with CurEditor do
   begin
    if Selection <> nil then
    Selection.Persistent := True;
    ReadOnly := False;
    TextBufConvert(cbfGetSelectStr, @AnalizeStr);  {GetSelectBlockString}
    if Selection <> nil then 
    Selection.Persistent := SavePersBlock;
    ReadOnly := SaveReadOnly;
   end;
  end;

  if Length(AnalizeStr) = 0 then Exit;
  l_Query := nil;
  try
   try
    Screen.Cursor:=crHourGlass;
    l_Query := aActionProc(AnalizeStr);
    if (l_Query <> nil) and (not l_Query.IsEmpty) then
     With TSearchWin.Create(Application.MainForm) do
     begin
      Family := DocFamily;
      DocList.Query := l_Query;
     end
    else
    begin
     {aSrchServ.Free;}
     ShowMessage(sidNoSuchDoc);
    end;
   finally
    Screen.Cursor := crDefault;
   end;
  finally
   l3Free(l_Query);
  end;
 end;
end;

procedure IDocSpecial.ParseSelectTextAndSearch;
 function lSrchFunc(const aSrchStr : AnsiString): TdtQuery;
 begin
  Result := SQText2Query(aSrchStr);
 end;

var
 lAction : Tl3FreeAction;

begin
 lAction := L3LocalStub(@lSrchFunc);
 try
  SelectTextAction(TSrchByTextProc(lAction));
 finally
  l3FreeFA(lAction);
 end;
end;

procedure IDocSpecial.SearchBySelectText(aIndexKind : TIndexType);
 function lSrchProc(const aSrchStr : AnsiString): TdtQuery;
 var
  l_Q : TdtQuery;
 begin
  l_Q := TdtTextQuery.Create(aSrchStr, aIndexKind);
  if (aIndexKind = itDictEntry) then
  begin
   // здесь раньше был вот такой код:
   //if (lSrchServRef <> nil) and (aIndexKind = itDictEntry) then
   // lSrchServRef.DocTypeFilter := lSrchServRef.DocTypeFilter + [dtDictEntry];
   //
   // необходимо понять, как это проверить и что вообще с этим делать, т.к. сейчас
   // фильтры реализуются с помощью дополнительной query и не знают про умолчания
  end;
  Result := l_Q;
 end;

var
 lAction : Tl3FreeAction;

begin
 lAction := L3LocalStub(@lSrchProc);
 try
  SelectTextAction(TSrchByTextProc(lAction));
 finally
  l3FreeFA(lAction);
 end;
end;

procedure IDocSpecial.AnalyseTextForParam(const aAnalizeStr : AnsiString = '');

 function AnalyseOne(var aStr : Tl3PCharLen) : Boolean;
 var
  lStr : AnsiString;
 begin
  Result := False;
  lStr := l3PCharLen2String(aStr, GlobalDataProvider.BaseLanguage[(fDocWnd as TDocEditorWindow).DocFamily].AnsiCodePage); // копируем с коррекцией кодировки
  l3ReplaceNonReadable(PAnsiChar(lStr), Length(lStr));
  Trim(lStr);
  fDocWnd.Document.Analyse(lStr);
 end;

var
 lStr : AnsiString;
begin
 with fDocWnd as TDocEditorWindow do
 begin
  Screen.Cursor := crHourGlass;
  try
   //Document.SaveAttributes(0);

   if (aAnalizeStr = '') and evCursorInSel(CurEditor) then
   begin
    CurEditor.SelectWholeParas;
    CurEditor.TextBufConvertF(evL2CB(@AnalyseOne));
   end
   else
   begin
    if aAnalizeStr <> '' then
     lStr := aAnalizeStr
    else
     if CurEditor.CurText.SLen > 0 then
     begin
      lStr := l3PCharLen2String(CurEditor.CurText, GlobalDataProvider.BaseLanguage[DocFamily].AnsiCodePage);
      with CurEditor.TextPara.Style do
       if ID <> ev_saTxtHeader1 then ID := ev_saTxtHeader1;
     end
     else
      Exit;

    fDocWnd.Document.Analyse(lStr);  // собственно, анализ
    if not Assigned(FullNameMEdit.Buffer.S) or (FullNameMEdit.Buffer.S[0] = #0) then
    begin
     l3ReplaceNonReadable(PAnsiChar(lStr), Length(lStr));
     Trim(lStr);

     evGetUndoBuffer(FullNameMEdit.TextSource).Disabled := true;
     try
      FullNameMEdit.Buffer := l3PCharLen(lStr, GlobalDataProvider.BaseLanguage[DocFamily].AnsiCodePage);
     finally
      evGetUndoBuffer(FullNameMEdit.TextSource).Disabled := false;
     end;
     FullNameMEdit.Modified := True;
    end;

   end;

   with Document do
    if ((Spravka <> nil) and not Spravka.TextSource.Document.IsValid)
       or
       (IsNewDoc and (cbUserType.ItemIndex in [0,1])) then
     LoadSpr
    else
     if ((Spravka <> nil) and Spravka.TextSource.Document.IsValid and (evGetNettoCharCount(Spravka.TextSource) = 0)) then
      GenerateSpr;

  finally
   Screen.Cursor := Cursor;
  end;
 end;
end;

procedure IDocSpecial.ShowDocInfo;
 begin
  With fDocWnd do
   begin
    With TShowDocInfoDlg.Create(fDocWnd) do
     try
      lblDocSize.Caption :=
       Format(lblDocSize.Caption, [evGetNettoCharCount(CurEditor.TextSource)]);
      ShowModal;
     finally
      Free;
     end;
   end;
 end;

procedure IDocSpecial.FindTNVED;
 Var
  Searcher : TarHLinkTNVEDSearcher;
  Replacer : TarHLinkTNVEDReplacer;
  SFlags   : TevSearchOptionSet;
 begin
  SFlags := [{ev_soGlobal,} ev_soConfirm, ev_soReplaceAll];
  Searcher := TarHLinkTNVEDSearcher.Create(fDocWnd);
  Try
   Replacer := TarHLinkTNVEDReplacer.Create(fDocWnd);
   Try
    {Replacer.Editor := FEditor;}
    Searcher.Options := SFlags;
    Replacer.Options := SFlags;
    //Replacer.OnFinishReplace := fDocWnd.RefReplacerFinishReplace;
    try
    fDocWnd.CurEditor.Find(Searcher, Replacer, SFlags);
    except
     on EevSearchFailed do
      vtMessageDlg(l3CStr(Searcher.NotFoundMessage), mtWarning);
    end;{try..finally}
   finally
    l3Free(Replacer);
   end;
  finally
   l3Free(Searcher);
  end;
 end;

Function IDocSpecial.cnvDate2Text(Sender : TObject; Var B: PAnsiChar; Var L: Long;
                             Var CharSet: Smallint;
                             Data : Pointer) : Boolean;
 Var
  I, TI   : Integer;
  {D, M ,Y : Integer;}
  S       : String[4];
  ResStr  : String[30];

 Procedure GetNumeric;
  begin
   {SkipSpace;}
   While (I <= L) and Not (B[I] in ['0'..'9']) do Inc(I);
   If (I > L) then Abort;

   S:='';
   While (I <= L) and (B[I] in ['0'..'9']) do
    begin
     S:=S+B[I];
     Inc(I);
    end;
   If (I > L) then Abort;
  end;

 begin
  Try
   I:=0;
   GetNumeric;
   ResStr:=S+' ';
   GetNumeric;
   TI:=StrToInt(S);
   If TI > 12 then Abort;
   ResStr:=ResStr+GetMonthNameR(TI)+' ';
   Try
    GetNumeric;
    S := IntToStr(ExpandYear(StrToInt(S)));
    ResStr:=ResStr + S + ' г.';
   except
   end;
   PShortString(Data)^:=ANSILowerCase(ResStr);
   B:=PAnsiChar(Data)+1;
   L:=Length(ResStr);
  except
   B:=Nil;
  end;
  Result:=True;
 end;

function IDocSpecial.ReplaceHyperLinks(aSearchHLDocID: TDocID; aReplaceHLDocID: TDocID): Boolean;
var
 lSrchEngine : TTextSearchDlg;
begin
 lSrchEngine := TTextSearchDlg.Create(nil);
 try
  lSrchEngine.ReplaceReferences((fDocWnd as TDocEditorWindow).DocTextEditor.DocEditor, aSearchHLDocID, aReplaceHLDocID);
 finally
  lSrchEngine.Free;
 end;
end;
(*
type
 TidsHyperlinkSearcher = class(TevHyperlinkSearcher)
 private
  f_StyleID: Integer;
 protected
 public
  function DoCheckText(const aPara : Tk2AtomR;
                       aText       : Tl3CustomString;
                       const aSel  : TevPair;
                       out theSel : TevPair): Bool;
   override;
 public
  property StyleID: Integer
   read f_StyleID
   write f_StyleID;
 end;

 TidsDeleteParaReplacer = class(TevBaseReplacer)
 private
 protected
  function  ReplaceFunc(const Container : InevOp;
                        Block           : TevBlock): Bool; override;
 public
 end;

{ TddHyperlinkSearcher }

function TidsHyperlinkSearcher.DoCheckText(const aPara : Tk2AtomR;
                                           aText       : Tl3CustomString;
                                           const aSel  : TevPair;
                                           out theSel  : TevPair): Bool;
begin
 Result:= false;
 if inherited DoCheckText(aPara, aText, aSel, theSel) then
 begin
  with aPara.rAtom(k2_tiStyle) do
   if IsValid and (AsLong = f_StyleID) then
   begin
    theSel.rStart := 0;
    theSel.rFinish := aText.Len;
    Result := true;
   end;
 end;//inherited DoCheckText
end;

{ TidsHyperlinkReplacer }

function TidsDeleteParaReplacer.ReplaceFunc(const Container: InevOp; Block: TevBlock): Bool;
var
 l_Block  : TevBlock;
 l_Block1 : TevBlock;
begin
//  В текущей реализации удаляется только текст абзаца.
 Block.GetSolidBottomChildBlock(l_Block);
 try
  l_Block.GetParentBlock(l_Block1);
  try
   evDeleteBlock(l_Block1, Container);
  finally
   l3Free(l_Block1);
  end;//try..finally
 finally
  l3Free(l_Block);
 end;//try..finally
// evDeleteBlock(Block, Container);
 Result := True; //IevOpInsertString(Block).DoIt(nil, Container, true, [misfDirect]);
end;

function IDocSpecial.EraseSpecialParaWithHyperlinks(aHLDocID: TDocID; aParaStyleID: Integer): Boolean;
var
 l_HLSearcher: TidsHyperlinkSearcher;
 l_HLReplacer: TidsDeleteParaReplacer;
 l_A: TevAddress;
begin
 l_HLSearcher:= TidsHyperlinkSearcher.Create(nil);
 try
  l_HLSearcher.Options:= l_HLSearcher.Options+[ev_soReplace, ev_soReplaceAll];
  l_A.DocID:= aHLDocID;
  l_A.SubID:= -1;
  l_HLSearcher.SearchHyperAddress:= l_A;
  l_HLSearcher.StyleID:= aParaStyleID;
  l_HLReplacer:= TidsDeleteParaReplacer.Create(nil);
  try
   l_HLReplacer.Options:= l_HLSearcher.Options;
   try
    (fDocWnd as TDocEditorWindow).DocEditor.Find(l_HLSearcher, l_HLReplacer, l_HLSearcher.Options);
    Result:= True;
   except
    Result:= False;
   end;
  finally
   l3Free(l_HLReplacer);
  end;
 finally
  l3Free(l_HLSearcher);
 end;
end;


function IDocSpecial.ReplaceHyperLinksInStyle(aSearchHLDocID: TDocID;
                                              aReplaceHLDocID: TDocID;
                                              aParaStyleID: Integer): Boolean;
var
 l_HLSearcher: TidsHyperlinkSearcher;
 l_HLReplacer: TidsDeleteParaReplacer;
begin

 Abort; //!

 l_HLSearcher:= TidsHyperlinkSearcher.Create(nil);
 try
  l_HLSearcher.Options:= l_HLSearcher.Options+[ev_soReplace, ev_soReplaceAll];
  l_HLSearcher.SearchHyperAddress:= TevAddress_C(aSearchHLDocID, -1);
  l_HLSearcher.StyleID:= aParaStyleID;

  l_HLReplacer:= TidsDeleteParaReplacer.Create(nil);
  try
   l_HLReplacer.Options:= l_HLSearcher.Options;
   try
    (fDocWnd as TDocEditorWindow).DocEditor.Find(l_HLSearcher, l_HLReplacer, l_HLSearcher.Options);
    Result:= True;
   except
    Result:= False;
   end;
  finally
   l3Free(l_HLReplacer);
  end;
 finally
  l3Free(l_HLSearcher);
 end;
end;
*)


end.



