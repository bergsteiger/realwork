unit dd_lcDossierDecorator;
{ Добавляет в справку информацию о хронологии рассмотрения дела }
{ $Id: dd_lcDossierDecorator.pas,v 1.26 2015/11/26 09:05:21 lukyanets Exp $ }

// $Log: dd_lcDossierDecorator.pas,v $
// Revision 1.26  2015/11/26 09:05:21  lukyanets
// КОнстанты переехали
//
// Revision 1.25  2015/07/02 11:41:28  lukyanets
// Описываем словари
//
// Revision 1.24  2014/12/01 12:00:48  fireton
// - если блок для хронологии уже есть, помещаем хронологию туда (К 578895135)
//
// Revision 1.23  2014/11/18 13:04:58  fireton
// - заключаем хронологию в блок
//
// Revision 1.22  2014/10/22 07:17:56  fireton
// - меняем логику построения хронологии
//
// Revision 1.21  2014/05/08 11:48:16  fireton
// - избавляемся от диапазонов в экспорте
//
// Revision 1.19  2014/04/29 14:06:17  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.18  2014/04/18 05:41:52  fireton
// - ISab переехал в dtIntf
//
// Revision 1.17  2014/03/05 07:30:45  fireton
// - не собиралось
//
// Revision 1.16  2013/10/25 03:28:50  fireton
// - переделки под изменения в k2
//
// Revision 1.15  2013/09/16 11:27:24  fireton
// - падения при экспорте справок
//
// Revision 1.14  2013/07/24 13:38:33  fireton
// - убираем дубли от Президиума ВАС (K 425037320)
//
// Revision 1.13  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.12  2013/02/15 12:22:00  narry
// Импортируются повторные документы (430743967)
//
// Revision 1.11  2013/02/13 07:41:55  narry
// Обновление
//
// Revision 1.10  2013/02/04 08:41:27  narry
// Более жесткое условие фильтра размноженных номеров
//
// Revision 1.9  2012/05/22 04:51:33  narry
// Уточнение фильтрации "размноженных" номеров
//
// Revision 1.8  2012/04/12 10:20:05  narry
// Хронология дела в апелляциях - разные варианты номера дела (356072199)
//
// Revision 1.7  2012/04/06 10:11:37  narry
// Не заполнялась информация "Хронология дела"
//
// Revision 1.6  2011/09/13 05:27:37  narry
// Размноженные номера размножают хронологию (265410470)
//


interface

uses
 k2Interfaces, l3LongintList, k2TagFilter, l3Types, k2Types, DT_Types, k2Prim,
 k2Base, k2TagGen, l3FieldSortRecList, DT_Renum;

type
 TlcDossierDecorator = class(Tk2TagFilter)
 private
  f_AlreadyDecorated: Boolean;
  f_CaseCode: AnsiString;
  f_CodeType: TDNType;
  f_CurBlockHandle: Integer;
  f_DocID: TDocID;
  f_DocList: Tl3FieldSortRecList;
  f_ExDocID: Integer;
  f_ExportMode: Boolean;
  f_NeedDecorate: Boolean;
  f_NeedEmptyPara: Boolean;
  f_Renum: TReNumTbl;
  procedure ClearParameters;
  procedure DeBracketSource(var aSource: AnsiString);
  procedure DecorateDossier(aNeedBlock: Boolean = True);
  function IsDossierRelated: Boolean;
 protected
        {-}
  procedure CloseStream(NeedUndo: Boolean); override;
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure DoCloseStructure(NeedUndo: Boolean); override;
  procedure DoStartChild(TypeID: Tk2Type); override;
    {internal methods}
  procedure OpenStream; override;
 public
    // public methods
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
        {* - создает экземпляр класа и цепляет его к генератору. }
  class function SetTo(var theGenerator: Ik2TagGenerator; aCaseCode: AnsiString):
      Ik2TagGenerator; overload;
      {-}
  procedure StartTag(TagID: Long); override;
 end;

implementation

uses
 SysUtils,
 DecorTextPara_Const,
 Address_Const,
 HyperLink_Const,
 SegmentsLayer_Const,
 k2Tags,
 evdStyles, evdTypes,
 daTypes,
 daSchemeConsts,
 dt_Const, dt_AttrSchema, dt_DictConst,
 dt_Sab,
 dt_serv,
 dt_Doc,
 dt_Dict,
 dtIntf,
 dt_LinkServ, dt_Link,
 l3Date, l3DateSt, l3LingLib, Math, l3String, l3Variant, TextPara_Const,
 Block_Const, NumAndDate_Const, Document_Const, l3Base, l3Interfaces, vtDebug,
  l3LongintListPrim, DictRec_Const, StrUtils, dd_lcUtils, HT_Const;

type
 PIDDateRec = ^TIDDateRec;
 TIDDateRec = record
  DocID: TDocID;
  DocDate: TstDate;
  DocCode: TNumberStr;
 end;

const
 c_ChronoBlockHandle = 548548;

constructor TlcDossierDecorator.Create(anOwner: Tk2TagGeneratorOwner = nil);
  {override;}
  {-}
begin
 inherited;
 f_ExportMode:= True;
end;

procedure TlcDossierDecorator.ClearParameters;
begin
 if f_ExportMode then
 begin
  f_CaseCode:= '';
  f_DocID:= 0;
  f_NeedDecorate:= False;
  f_AlreadyDecorated := False;
  f_CurBlockHandle := 0;
  f_CodeType:= dnDoc;
 end;
end;

procedure TlcDossierDecorator.CloseStream(NeedUndo: Boolean);
begin
 FreeAndNil(f_DocList); 
 inherited;
end;

procedure TlcDossierDecorator.DeBracketSource(var aSource: AnsiString);
var
 l_Pos: Integer;
begin
 // Удалить из строки все, что находится между ()
 l_Pos:= Pos('(', aSource);
 if l_Pos > 0 then
  Delete(aSource, l_Pos, Pos(')', aSource)-l_Pos+1);
end;

procedure TlcDossierDecorator.DecorateDossier(aNeedBlock: Boolean = True);
const
 lCaseCodeType : TDNType = dnLawCaseNum;
 lDNDocType : TDNType = dnPublish;
var
 lSab : ISab;
 lSabLnk, lCCSab : ISab;
 lJoinSab : IJoinSab;
 lRAProcStub : TdtRecAccessProc;
 l_Last: Tl3Tag;
 l_First: AnsiString;
 l_CaseCode: TNumberStr;
 l_LastAddedDocID: TDocID;
 l_CurrentDocID: TDocID;
 l_CurrentDate: AnsiString;
 l_CurrentType: AnsiString;
 l_CurrentSource: AnsiString;
 l_CurrentCode: AnsiString;

 procedure GenerateChronoItem(aExtDocID: TDocID; const aDate, aType, aSource, aCode: AnsiString);
 var
  l_Text: AnsiString;
 begin
  Generator.StartChild(k2_typDecorTextPara);
  Generator.Finish;
  l_Text:= Format('%s %s %s N %s', [aDate, aType, aSource, aCode]);

  Generator.StartChild(k2_typDecorTextPara);
  try
   Generator.StartTag(k2_tiSegments);
   try
    Generator.StartChild(k2_typSegmentsLayer);
    try
     Generator.AddIntegerAtom(k2_tiHandle, Ord(ev_slHyperlinks));

      Generator.StartChild(k2_typHyperlink);
      try
       Generator.AddIntegerAtom(k2_tiFinish, Length(l_Text));
       Generator.StartChild(k2_typAddress);
       try
        Generator.AddIntegerAtom(k2_tiDocID, aExtDocID);
       finally
        Generator.Finish;
       end; // idAddress
      finally
       Generator.Finish;
      end; // idHyperlink
    finally
     Generator.Finish;
    end; // idSegmentsLayer
   finally
    Generator.Finish;
   end;
   Generator.AddStringAtom(k2_tiText, l_Text);
  finally
   Generator.Finish;
  end;
 end;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  //l_Text: AnsiString;
  l_Para: Tl3Tag;
  l_Segments: Tl3Tag;
  l_HL: Tl3Tag;
  l_SL: Tl3Tag;
  l_A: Tl3Tag;
  l_Date, l_Type, l_Source, l_Code: AnsiString;
  l_DocID: TDocID;
  l_IsHighSrc: Boolean;
  l_IsNumStartsVAS: Boolean;
  l_IsPrezidiumSrc: Boolean;

  function GetParam(aAttrType: TdtAttribute; aDictType: TdaDictionaryType; aFldNum: SmallInt) : AnsiString;
  var
   lSab : ISab;
   l_Result: AnsiString;
   lStub : TdtRecAccessProc;

   function ExtractStr(aItemPtr : Pointer): Boolean;
   var
    l_Len: Integer;
   begin
    Result:= False;
    l_Len:= IfThen(aFldNUm = dtNameFld, 200, 50);
    l_Result:= l3ArrayToString(aItemPtr^, l_Len);
   end; // ExtractStr

  begin
   lSab := MakeSab(LinkServer(CurrentFamily).Attribute[aAttrType]);
   lSab.Select(lnkDocIDFld, PIDDateRec(aItemPtr)^.DocID);
   lSab.ValuesOfKey(lnkDictIDFld);
   lSab.TransferToPhoto(dnIDFld, DictServer(CurrentFamily).DictTbl[aDictType]);
   lSab.RecordsByKey;
   lStub := L2RecAccessProc(@ExtractStr);
   try
    lSab.IterateRecords(lStub, [aFldNum]);
   finally
    FreeRecAccessProc(lStub);
   end;
   Result:= l_Result;
  end; // GetParam

 begin
  // У нас обрабатывается список документов, которые должны быть добавлены в хронологию.
  // При этом в списке на каждый документ может содержаться несколько записей, главным образом из-за того,
  // что для одного документа может быть указано несколько номеров, под которыми он издан.
  // Смысл обработки в том, чтобы выбрать из списка "красивый" номер для каждого документа, но не допустить
  // того, что какой-то док не попадёт в хронологию вовсе.
  Result := True;
  if (PIDDateRec(aItemPtr)^.DocDate <> 0) and (PIDDateRec(aItemPtr)^.DocID > 0) then
  begin
   l_DocID := PIDDateRec(aItemPtr)^.DocID;
   if (l_DocID = l_LastAddedDocID) then // Мы этот док уже добавили в хронологию
    Exit;
   l_Date := l3DateToStr(PIDDateRec(aItemPtr)^.DocDate);
   l_Type := GetParam(atTypes, da_dlTypes, dtNameFld);
   l_Source := GetParam(atSources, da_dlSources, dtNameFld);
   l_Code := Trim(String(PIDDateRec(aItemPtr)^.DocCode));

   if (l_CurrentDocID <> l_DocID) and (l_CurrentDocID <> 0) then
   begin
    // Если мы начали обрабатывать следующий док в списке, а предыдущий не попал в хронологию, то
    // надо вставить предыдущий (вероятно, он не попал из-за условий "попадания" - "ВАС" или "не ВАС") - см. ниже
    if (l_CurrentDocID <> l_LastAddedDocID) then
     GenerateChronoItem(f_Renum.GetExtDocID(l_CurrentDocID), l_CurrentDate, l_CurrentType,
         l_CurrentSource, l_CurrentCode);
    l_LastAddedDocID := l_CurrentDocID;
    l_CurrentDocID := 0;
   end;

   if (l_Source <> '') and (l_Type <> '') and (l_Code <> '') then
   begin
    l_First:= l_Source[1];
    l_First:= UpperCase(l_First);
    l_Source:= mlmaRusDeclensionStr(l_Source, rdRodit);
    l_Source[1]:= l_First[1];
    DeBracketSource(l_Source);

    if l_CurrentDocID = 0 then
    begin
     // текущий док ещё не запомнен, запоминаем
     l_CurrentDocID := l_DocID;
     l_CurrentDate := l_Date;
     l_CurrentType := l_Type;
     l_CurrentSource := l_Source;
     l_CurrentCode := l_Code;
    end;

    l_IsHighSrc := AnsiStartsText('Высшего', l_Source);
    l_IsPrezidiumSrc := AnsiStartsText('Президиума ВАС', l_Source);
    l_IsNumStartsVAS := AnsiStartsText('ВАС-', l_Code);

    if not (l_IsHighSrc or l_IsPrezidiumSrc) or
       (l_IsHighSrc and l_IsNumStartsVAS) or
       (l_IsPrezidiumSrc and not l_IsNumStartsVAS) then
    begin
     GenerateChronoItem(f_Renum.GetExtDocID(l_DocID), l_Date, l_Type, l_Source, l_Code);
     l_LastAddedDocID := l_DocID;
    end;
   end // (l_Source <> '') and (l_Date <> '') and (l_Type <> '') and (l_Code <> '')
  end // PIDDateRec(aItemPtr)^.DocID <> l_DocID
 end; // lRecAccessProc

begin
 if IsDossierRelated then
 begin
  // Нужно построить список документов, у которых CaseCode = aDocument.CaseCode, отсортировать его по !DATE
  // поиск с одинаковым кейскодом
  lSab := MakeSab(DictServer(CurrentFamily).GroupTbl[da_dlDateNums]);
  lSab.Select(dnTypFld, lCaseCodeType);
  l3FillChar(l_CaseCode, SizeOf(l_CaseCode), 32);
  l3Move(f_CaseCode[1], l_CaseCode, Length(f_CaseCode));
  lSab.SubSelect(dnNumFld, l_CaseCode[1]{, WILDCASE});
  lSab.ValuesOfKey(dnIDFld);
  lSab.TransferToPhoto(lnkDictIDFld, LinkServer(CurrentFamily).Attribute[atDateNums]);
  lSab.ValuesOfKey(lnkDocIDFld);

  (*
  //поиск с одинаковой справкой
  lSab := MakeEmptySab(MakePhoto(GlobalHtServer.GetTblObjectEx(CurrentFamily, Ord(ftFile))));
  lSab.Select(fRelated_fld, f_DocID);
  lSab.ValuesOfKey(fId_Fld);

  lSab.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily).Attribute[atDateNums]);
  *)

  lSab.RecordsByKey;
  lSabLnk := MakeSabCopy(lSab);

  lSab.ValuesOfKey(lnkDictIDFld);
  lSab.TransferToPhoto(dnIDFld, DictServer(CurrentFamily).GroupTbl[da_dlDateNums]);
  lSab.RecordsByKey;
  lSab.SubSelect(dnTypFld, lDNDocType);
  (*
  // игнорируем записи у которых code=casecode
  lCCSab := MakeEmptySab(lSab);
  lCCSab.Select(dnTypFld, lCaseCodeType);
  lCCSab.ValuesOfKey(dnNumFld);
  lCCSab.RecordsByKey;
  lSab.SubtractSab(lCCSab);
  *)

  lJoinSab := MakeJoinSab(lSab, dnIDFld,
                          lSabLnk, lnkDictIDFld);
  lJoinSab.Distinct(lJoinSab.TranslateFieldNumber([JFRec(lSabLnk.Table, lnkDocIDFld),
                                                   JFRec(lSab.Table, dnNumFld)]));
  //lList := dtMakeRecListByJoinSab(lJoinSab, [JFRec(lSabLnk.Table, lnkDocIDFld)], []);
  lJoinSab.SortJoin([JFRec(lSab.Table, -dnDateFld), JFRec(lSabLnk.Table, lnkDocIDFld), JFRec(lSab.Table, dnNumFld)]);
  if lJoinSab.Count > 0 then
  begin
   if aNeedBlock then
    Generator.StartChild(k2_typBlock);
   try
    if aNeedBlock then
     Generator.AddIntegerAtom(k2_tiHandle, c_ChronoBlockHandle);
    if f_NeedEmptyPara then
    begin
     Generator.StartChild(k2_typDecorTextPara);
     Generator.Finish;
    end;
    Generator.StartChild(k2_typDecorTextPara);
    try
     Generator.AddIntegerAtom(k2_tiStyle, ev_saColorSelection);
     Generator.AddStringAtom(k2_tiText, 'Хронология рассмотрения дела:')
    finally
     Generator.Finish;
    end;
    lRAProcStub := L2RecAccessProc(@lRecAccessProc);
    try
     l_LastAddedDocID := 0;
     l_CurrentDocID := 0;
     lJoinSab.IterateJoinRecords(lRAProcStub, [JFRec(lSabLnk.Table, lnkDocIDFld), JFRec(lSab.Table, dnDateFld), JFRec(lSab.Table, dnNumFld)]);
     if (l_CurrentDocID <> 0) and (l_CurrentDocID <> l_LastAddedDocID) then
     begin
      // Если последний док не попал в хронологию, то надо его туда поместить
      GenerateChronoItem(f_Renum.GetExtDocID(l_CurrentDocID), l_CurrentDate, l_CurrentType,
           l_CurrentSource, l_CurrentCode);
     end;
    finally
     FreeRecAccessProc(lRAProcStub);
    end;
   finally
    if aNeedBlock then
     Generator.Finish;
   end;
  end;
  f_AlreadyDecorated := True;
 end; // f_CaseCode <> ''
end; // DecorateDossier

procedure TlcDossierDecorator.DoAddAtomEx(AtomIndex: Long; const Value:
    Tk2Variant);
  //virtual;
  {-}
begin
 if CurrentType.IsKindOf(k2_typNumAndDate) then// выдергиваем номера документа
 begin
  case AtomIndex of
   k2_tiType: f_CodeType:= TDNType(Value.AsInteger);
   k2_tiNumber:
    if (f_CodeType = dnLawCaseNum) and (f_CaseCode = '') then
    begin
     f_CaseCode:= Value.AsString.AsString;
     if (((Value.AsString as Tl3String).CodePage = cp_OEM){ or ((Value.AsString as Tl3String).CodePage = cp_OEMLite)}) then
      f_CaseCode:= l3OEM2ANSI(f_CaseCode);
    end;
  end; // case
 end
 else
 if CurrentType.IsKindOf(k2_typTextPara) and (AtomIndex = k2_tiText) then
  f_NeedEmptyPara:= True
 else
 if CurrentType.IsKindOf(k2_typBlock) and (AtomIndex = k2_tiHandle) then
  f_CurBlockHandle := Value.AsInteger
 else
 if CurrentType.IsKindOf(k2_typDocument) then
  case AtomIndex of
   k2_tiType : f_NeedDecorate:= Value.AsInteger = Ord(dtRelText);
   k2_tiInternalHandle: f_DocID:= Value.AsInteger;
   k2_tiExternalHandle: f_ExDocID:= Value.AsInteger;
  end;
 inherited;
end;

procedure TlcDossierDecorator.DoCloseStructure(NeedUndo: Boolean);
  //virtual;
  {-вызывается на закрывающуюся скобку}
begin
 if (not f_AlreadyDecorated) and f_NeedDecorate then
 begin
  if CurrentType.IsKindOf(k2_typBlock) and (f_CurBlockHandle = c_ChronoBlockHandle) then
   DecorateDossier(False) // нашли блок уже готовый, туда добавляем хронологию
  else
  if CurrentType.IsKindOf(k2_typDocument) then
   DecorateDossier; // документ закончился... добавляем блок с хронологией
 end;
 inherited;
end;

procedure TlcDossierDecorator.DoStartChild(TypeID: Tk2Type);
begin
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
  ClearParameters
 else
 if CurrentType.IsKindOf(k2_typTextPara) then
  f_NeedEmptyPara:= False;
end;

function TlcDossierDecorator.IsDossierRelated: Boolean;
type
 l_TRec = packed record
  ID: TDocID;
  Num: TNumberStr;
 end;
var
 l_Idx: Integer;
 l_rec: l_TRec;
begin
 l_Rec.ID:= f_ExDocID;
 Result := f_DocList.FindRecord(l_Rec, l_Idx) and (f_CaseCode <> '');
end;

procedure TlcDossierDecorator.OpenStream;
var
 lSab      : ISab;
 lSabLnk   : ISab;
 lRenumSab : ISab;
 lFileSab  : ISab;

 lJoinFile_Renum   : IJoinSab;
 lJoinFile_Link  : IJoinSab;
 lJoinDict_Link,
 lJoinRenum_Link,
 lJoinSab    : IJoinSab;
 lJoinSab2   : IJoinSab;
 lJoinSabSum : IJoinSab;
 lTimerGlobal: Cardinal;
 //lTimer      : Cardinal;
const
 cCaseCodeType : TDNType = dnLawCaseNum;
 cDocTypeDossier : TUserType = utDossier;
begin
 inherited;
 lTimerGlobal := dbgStartTimeCounter;
 l3System.Msg2Log('TlcDossierDecorator.OpenStream - начало подготовки данных', l3_msgLevel2);
 f_Renum:= LinkServer(CurrentFamily).Renum;
  //найдем все Документы
 lSab := MakeEmptySab(MakePhoto(GlobalHtServer.GetTblObjectEx(CurrentFamily, Ord(ftFile))));
 lSab.SelectAll;
 lFileSab := MakeSabCopy(lSab);

 lRenumSab := MakeSabCopy(lSab);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lRenumSab.ValuesOfKey', l3_msgLevel2);
 lRenumSab.ValuesOfKey(fRelated_fld);
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lSab.ValuesOfKey', l3_msgLevel2);
 lSab.ValuesOfKey(fId_Fld);
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lSab.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily).Attribute[atDateNums]);', l3_msgLevel2);
 lSab.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily).Attribute[atDateNums]);
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lSab.ValuesOfKey(lnkDictIDFld);', l3_msgLevel2);
 lSab.ValuesOfKey(lnkDictIDFld);
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lSab.TransferToPhoto(dnIDFld, DictServer(CurrentFamily).GroupTbl[da_dlDateNums]);', l3_msgLevel2);
 lSab.TransferToPhoto(dnIDFld, DictServer(CurrentFamily).GroupTbl[da_dlDateNums]);
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lSab.RecordsByKey', l3_msgLevel2);
 lSab.RecordsByKey;
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lSab.SubSelect(dnTypFld, cCaseCodeType);', l3_msgLevel2);
 lSab.SubSelect(dnTypFld, cCaseCodeType);
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 lSabLnk := MakeSabCopy(lSab);
 //l3System.Msg2Log('lSabLnk.ValuesOfKey(dnIDFld);', l3_msgLevel2);
 lSabLnk.ValuesOfKey(dnIDFld);
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lSabLnk.TransferToPhoto', l3_msgLevel2);
 lSabLnk.TransferToPhoto(lnkDictIDFld, LinkServer(CurrentFamily).Attribute[atDateNums]);
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lSabLnk.RecordsByKey', l3_msgLevel2);
 lSabLnk.RecordsByKey;
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lJoinDict_Link := MakeJoinSab', l3_msgLevel2);
 lJoinDict_Link := MakeJoinSab(lSabLnk, lnkDictIDFld,
                               lSab, dnIDFld);
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);


 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lRenumSab.TransferToPhoto(lnkDocIDFld', l3_msgLevel2);
 lRenumSab.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily).Attribute[atRenum]);
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lRenumSab.RecordsByKey', l3_msgLevel2);
 lRenumSab.RecordsByKey;
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('JoinSabs', l3_msgLevel2);
 lJoinFile_Renum := MakeJoinSab(lRenumSab, rnRealID_fld,
                                lFileSab, fRelated_fld);

 lJoinFile_Link := MakeJoinSab(lFileSab, fID_fld,
                               lSabLnk, lnkDocIDFld);




 lJoinRenum_Link := MakeJoinSab(lJoinFile_Renum, lJoinFile_Link, True);

 lJoinSabSum := MakeJoinSab(lJoinRenum_Link, lJoinDict_Link, True);
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('lJoinSabSum.SortJoin', l3_msgLevel2);
 lJoinSabSum.SortJoin([JFRec(lRenumSab.Table, rnImportID_fld)]);
 //l3System.Msg2Log('%s'#10#13, [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);

 //lTimer := dbgStartTimeCounter;
 //l3System.Msg2Log('dtMakeRecListByJoinSab - начало', l3_msgLevel2);
 f_DocList := dtMakeRecListByJoinSab(lJoinSabSum, [JFRec(lRenumSab.Table, rnImportID_fld),
                                                   JFRec(lSab.Table, dnNumFld)], [1]);
 //l3System.Msg2Log('dtMakeRecListByJoinSab %s', [dbgFinishTimeCounter(lTimer)], l3_msgLevel2);
 l3System.Msg2Log('TlcDossierDecorator: подготовка данных закончена %s', [dbgFinishTimeCounter(lTimerGlobal)], l3_msgLevel2);
end;

class function TlcDossierDecorator.SetTo(var theGenerator: Ik2TagGenerator;
    aCaseCode: AnsiString): Ik2TagGenerator;
var
 l_Filter : TlcDossierDecorator;
begin
 l_Filter := Create;
 try
  l_Filter.f_ExportMode:= False;
  l_Filter.f_CaseCode:= aCaseCode;
  l_Filter.Generator := theGenerator;
  theGenerator := l_Filter;
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

procedure TlcDossierDecorator.StartTag(TagID: Long);
begin
 inherited;
  If CurrentType.IsKindOf(k2_typDictRec) and
    (TopObject[0].isProp) then
  Begin
   If (TopObject[0].AsProp.TagIndex = k2_tiNumANDDates) then
    f_CaseCode:= '';
  end;
end;

end.
