unit dd_lcDossierMaker;
{ Создание справки для постановлений судов }

{ $Id: dd_lcDossierMaker.pas,v 1.35 2016/09/16 13:49:56 fireton Exp $ }
// $Log: dd_lcDossierMaker.pas,v $
// Revision 1.35  2016/09/16 13:49:56  fireton
// - переведим на Tl3String чтобы избежать проблем с памятью, если много участников
//
// Revision 1.34  2015/11/26 09:05:21  lukyanets
// КОнстанты переехали
//
// Revision 1.33  2015/07/02 11:41:28  lukyanets
// Описываем словари
//
// Revision 1.32  2014/08/28 11:31:34  fireton
// - неверное присваивание списка разрешённых источников
//
// Revision 1.31  2014/06/26 11:15:11  fireton
// - логируем подключение справок к ААС (потом можно убрать)
//
// Revision 1.30  2014/04/17 13:04:46  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.29  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.28  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.27  2013/10/18 16:01:26  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.26  2013/04/15 05:59:22  narry
// Не собиралось
//
// Revision 1.25  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.24  2013/02/15 12:22:00  narry
// Импортируются повторные документы (430743967)
//
// Revision 1.23  2012/02/28 07:03:01  narry
// Объединить два диапазона в один (342330845)
//
// Revision 1.22  2011/11/14 12:51:40  narry
// В справке остались Ключевые темы (297714202)
//
// Revision 1.21  2011/09/14 12:31:11  narry
// Форматирование текста - дополнение (283613953)
//
// Revision 1.20  2011/06/02 13:18:47  narry
// no message
//
// Revision 1.19  2011/04/11 10:25:01  narry
// Названия для ФАС (259885290)
//
// Revision 1.18  2011/04/05 08:59:01  narry
// 259885188 Справка для ФАС  (уточнение)
//
// Revision 1.17  2011/04/01 12:15:54  narry
// 259885188 Справка для ФАС
//

interface

uses
 evdBufferedFilter,
 k2Interfaces,
 ddLawCaseXMLReader,
 dt_Types, SysUtils, dd_lcBaseFilter, l3Types, l3Base, k2Types, l3LongintList,

 k2Base,

 l3FieldSortRecList, k2TagGen, Dt_TblCache, l3Interfaces; 

type
 PDocInfoRec = ^TDocInfoRec;
 TDocInfoRec = packed record
  DocCode: TNumberStr;
  DocID: TDocID;
 end;

 TlcDossierMaker = class(Tdd_lcBaseFilter)
 private
  f_CaseCode: AnsiString;
  f_OnNewDocument: TlcNewDocumentEvent;
  f_Code: AnsiString;
  f_CodeType: TDNType;
  f_Creditor: Tl3String;
  f_CurDoc: TDocInfoRec;
  f_Plaintiff: Tl3String;
  f_Defendant: Tl3String;
  f_DocList: Tl3FieldSortRecList;
  f_Dolzhnik: Tl3String;
  f_DossierID: TDocID;
  f_ExtID: TDocID;
  f_Field: AnsiString;
  f_Interested: Tl3String;
  f_LinkAdded: Boolean;
  f_Name: AnsiString;
  f_Participant: Il3CString;
  f_ParticipantType: Integer;
  f_RelGenerator: Tk2TagGenerator;
  f_Source: AnsiString;
  f_SourcesList: Tl3LongintList;
  f_Thirds: Tl3String;
  f_ThirdSide: Tl3String;
  f_Type: AnsiString;
  f_TypesList: Tl3LongintList;
  f_Zayavitel: Tl3String;
  procedure AddBelongs;
  procedure AddParticipant(var theParticipant: Tl3String; aNewParticipant: Tl3WString);
  procedure AddPrefix;
  procedure CheckDossier;
  procedure GenerateAACDossier;
  procedure GenerateFACDossier;
  procedure GenerateVACDossier;
  //function MakeName: AnsiString;
  procedure ModifyCase(aDossierID: TDocID);
  procedure pm_SetSources(const Value: AnsiString);
  procedure pm_SetSourcesList(const Value: Tl3LongintList);
  procedure pm_SetTypes(const Value: AnsiString);
  procedure Str2List(const aStr: AnsiString; aList: Tl3LongintList);
 protected
  procedure Cleanup; override;
    {internal methods}
  procedure CloseStream(NeedUndo: Boolean); override;
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure DoCloseStructure(NeedUndo: Boolean); override;
  procedure DoStartChild(TypeID: Tk2Type); override;
    {internal methods}
  procedure OpenStream; override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  property RelGenerator: Tk2TagGenerator read f_RelGenerator write f_RelGenerator;
  property Sources: AnsiString write pm_SetSources;
  property SourcesList: Tl3LongintList read f_SourcesList write pm_SetSourcesList;
  property Types: AnsiString write pm_SetTypes;
  property OnNewDocument: TlcNewDocumentEvent read f_OnNewDocument write
      f_OnNewDocument;
 end;


implementation

uses
 daTypes, daSchemeConsts,
 dt_AttrSchema,
 TextPara_Const, k2Tags, Document_Const, evdStyles, HyperLink_Const,
 evTextParaTools, SegmentsLayer_Const, evdTypes, Address_Const, ddUtils,
 NumAndDate_Const, logRecord_Const, l3Date, DateUtils, DictItem_Const,
 Participant_Const, dtIntf, DT_Sab, DT_Query, 
 rxStrUtils, DT_Serv, DT_Const, DT_Doc, DT_Link, DT_LinkServ, DT_DictConst,
 DT_Dict, DT_Renum, Math, StrUtils, l3LingLib, l3String, dd_lcSourceUtils, dd_lcUtils,
  l3_String;

constructor TlcDossierMaker.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_Plaintiff := Tl3String.Create;
 f_Defendant := Tl3String.Create;
 f_ThirdSide := Tl3String.Create;
 f_Interested := Tl3String.Create;
 f_Creditor := Tl3String.Create;
 f_Dolzhnik := Tl3String.Create;
 f_Zayavitel := Tl3String.Create;
 f_Thirds := Tl3String.Create;
end;

procedure TlcDossierMaker.AddBelongs;
var
 l_Belongs: AnsiString;
begin
  l_Belongs:= Source2Base(f_Source);
  if l_Belongs <> '' then
  begin
   Generator.StartTag(k2_tiGroups);
   try
    Generator.StartChild(k2_typDictItem);
    try
     Generator.AddStringAtom(k2_tiShortName, l_Belongs);
    finally
     Generator.Finish;
    end;
   finally
     Generator.Finish;
   end;
   Generator.StartTag(k2_tiAccGroups);
   try
    Generator.StartChild(k2_typDictItem);
    try
     Generator.AddStringAtom(k2_tiShortName, 'APPEL');
    finally
     Generator.Finish;
    end;
   finally
    Generator.Finish;
   end;
  end// l_Belongs <> ''
end;

procedure TlcDossierMaker.AddParticipant(var theParticipant: Tl3String; aNewParticipant: Tl3WString);
begin
 if not theParticipant.Empty then
  theParticipant.Append(l3PCharLen(', '));
 theParticipant.Append(aNewParticipant);
end;


procedure TlcDossierMaker.AddPrefix;
begin
  Generator.StartTag(k2_tiPrefix);
  try
   Generator.StartChild(k2_typDictItem);
   try
    Generator.AddStringAtom(k2_tiName, 'Судебная практика');
   finally
    Generator.Finish;
   end;
  finally
   Generator.Finish;
  end;
end;

procedure TlcDossierMaker.CheckDossier;
var
 l_Index: Integer;
 l_ID: TDictID;
begin
 if Source2DossierType(f_Source) = lc_dtAAC then
 begin
  l_ID:= DictServer(CurrentFamily).Dict[da_dlSources].FindIDByFullPath(l3PCharLen(f_Source));
  if l_ID = cUndefDictID then
   ErrorReaction('Неизвестный Исх. орган "%s"', [f_Source])
  else
  if (f_DocList <> nil) and (SourcesList.IndexOf(l_ID) <> -1) then
  begin
   if f_DocList.FindRecord(f_CurDoc, l_Index) then
   begin
    f_CurDoc.DocID:= PDocInfoRec(f_DocList.Itemslot(l_Index))^.DocID;
    l3System.Msg2Log('Для дела %s найдена справка %d', [f_CaseCode, f_CurDoc.DocID]);
   end;
  end
  else
   ErrorReaction('Неразрешенный Исх. орган "%s"', [f_Source])
 end; // Source2DossierType(f_Source) = lc_dtAAC
end;

procedure TlcDossierMaker.Cleanup;
begin
 FreeAndNil(f_SourcesList);
 FreeAndNil(f_Plaintiff);
 FreeAndNil(f_Defendant);
 FreeAndNil(f_ThirdSide);
 FreeAndNil(f_Interested);
 FreeAndNil(f_Creditor);
 FreeAndNil(f_Dolzhnik);
 FreeAndNil(f_Zayavitel);
 FreeAndNil(f_Thirds);
 inherited;
end;

procedure TlcDossierMaker.CloseStream(NeedUndo: Boolean);
begin
 l3Free(f_DocList);
 inherited;
end;

procedure TlcDossierMaker.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) then
  case AtomIndex of
   k2_tiExternalHandle: f_ExtID:= Value.AsInteger;
   k2_tiRelExternalHandle:
   begin
    f_DossierID:= Value.AsInteger;
    l3System.Msg2Log('Номер справки %d приехал от документа!', [f_DossierID]);
   end;
   k2_tiName: f_Name:= {DeBracketStr}(Value.AsString.AsString);
  end
 else
 if CurrentType.IsKindOf(k2_typNumAndDate) then// выдергиваем номера документа
 begin
  case AtomIndex of
   k2_tiType: f_CodeType:= TDNType(Value.AsInteger);
   k2_tiNumber:
    case f_CodeType of
     dnPublish: f_Code:= Value.AsString.AsString;
     dnLawCaseNum:
      begin
       f_CaseCode:= Value.AsString.AsString;
       l3Move(f_CaseCode[1], f_CurDoc.DocCode, Min(Length(f_CaseCode), SizeOf(TNumberStr)));
       CheckDossier;
      end;
    end;
  end; // case
 end
 else
 if CurrentType.IsKindOf(k2_typParticipant) then // накапливаем инфу про участников
 begin
(*                     ptPlaintiff, // Истец
                       ptDefendant, // Ответчик
                       ptThirdSide, // Третье лицо
                       ptInterested,// Заинтересованные лица
                       ptCreditor,  // Кредитор
                       ptDolzhnik,  // Должник
                       ptInoy,      // Иной уполн. орган
                       ptArbitrazh, // Арбитражный управляющий
                       ptZayavitel, // Заявитель
                       ptPristav,   // Судебный пристав-исполнитель
                       ptProkuratura);// Прокуратура *)
  case AtomIndex of
   k2_tiType:
    begin
     f_ParticipantType:= Value.AsInteger;
     if not l3IsNil(f_Participant) then
      case f_ParticipantType of
       Ord(ptPlaintiff):  AddParticipant(f_Plaintiff,  f_Participant.AsWStr);
       Ord(ptDefendant):  AddParticipant(f_Defendant,  f_Participant.AsWStr);
       Ord(ptThirdSide):  AddParticipant(f_ThirdSide,  f_Participant.AsWStr);
       Ord(ptInterested): AddParticipant(f_Interested, f_Participant.AsWStr);
       Ord(ptCreditor):   AddParticipant(f_Creditor,   f_Participant.AsWStr);
       Ord(ptDolzhnik):   AddParticipant(f_Dolzhnik,   f_Participant.AsWStr);
       Ord(ptZayavitel):  AddParticipant(f_Zayavitel,  f_Participant.AsWStr);
      else
       AddParticipant(f_Thirds, f_Participant.AsWStr);
      end;
    end;
   k2_tiName:
    case f_ParticipantType of
     -1 : f_Participant := l3CStr(Value.AsString.AsWStr);
     Ord(ptPlaintiff):  AddParticipant(f_Plaintiff,  Value.AsString.AsWStr);
     Ord(ptDefendant):  AddParticipant(f_Defendant,  Value.AsString.AsWStr);
     Ord(ptThirdSide):  AddParticipant(f_ThirdSide,  Value.AsString.AsWStr);
     Ord(ptInterested): AddParticipant(f_Interested, Value.AsString.AsWStr);
     Ord(ptCreditor):   AddParticipant(f_Creditor,   Value.AsString.AsWStr);
     Ord(ptDolzhnik):   AddParticipant(f_Dolzhnik,   Value.AsString.AsWStr);
     Ord(ptZayavitel):  AddParticipant(f_Zayavitel,  Value.AsString.AsWStr);
    else
     AddParticipant(f_Thirds, Value.AsString.AsWStr);
    end;
  end; // case
 end
 else
 if CurrentType.IsKindOf(k2_typDictItem) and (TopObject[1].isProp) and (AtomIndex = k2_tiName) then
  if (TopObject[1].AsProp.TagIndex = k2_tiSources) then
   f_Source:= Trim(Value.AsString.AsString)
  else
  if (TopObject[1].AsProp.TagIndex = k2_tiTypes) then
   f_Type:= Value.AsString.AsString;
 inherited;
end;

procedure TlcDossierMaker.DoCloseStructure(NeedUndo: Boolean);
var
 l_Generate: Boolean;
begin
 l_Generate:= CurrentType.IsKindOf(k2_typDocument) and (f_DossierID <> -1);
 if CurrentType.IsKindOf(k2_typParticipant) then
 begin
  f_ParticipantType:= -1;
  f_Participant := nil;
 end; // CurrentType.IsKindOf(k2_typParticipant)
 inherited;

 if l_Generate then
  case Source2DossierType(f_Source) of
   lc_dtAAC: GenerateAACDossier;
   lc_dtVAC: GenerateVACDossier;
   lc_dtFAC: GenerateFACDossier;
   lc_dtFirst: {GenerateFACDossier};
  end;

end;

procedure TlcDossierMaker.DoStartChild(TypeID: Tk2Type);
var
 i, l_ID: Integer;
begin
 if TypeID.IsKindOf(k2_typTextPara) then
  if not f_LinkAdded then
  begin
   if f_CurDoc.DocID = 0 then // Нужно создать новую справку
   begin
    if Assigned(f_OnNewDocument) then
    begin
     //l3System.Msg2Log('Получение нового номера справки для %s', [Source2Alias(f_Source)]);
     if Source2DossierType(f_Source) <> lc_dtFirst then
     begin
      l3System.Msg2Log('Получение нового номера справки для %s', [Source2Alias(f_Source)]);
      f_OnNewDocument(f_DossierID, Source2Alias(f_Source));
      l3System.Msg2Log('Номер справки получен: %d', [f_DossierID]);
      if f_DossierID <> -1 then
      begin
       ModifyCase(f_DossierID);
       l_ID:= DictServer(CurrentFamily).Dict[da_dlSources].FindIDByFullPath(l3PCharLen(f_Source));
       if (f_DocList <> nil) and (l_ID <> cUndefDictID) and (SourcesList.IndexOf(l_ID) <> -1) then
       begin
        f_CurDoc.DocID:= f_DossierID;
        f_DocList.Add(f_CurDoc);
       end; // f_DocList <> nil
      end; // f_DossierID <> cUndefDocID
     end; // Source2DossierType(f_Source) <> lc_dtFirst
    end // Assigned(f_OnNewDocument)
   end // f_CurDoc.DocID = 0
   else
   begin
    //l3System.Msg2Log('Номер справки уже есть');
    ModifyCase(f_CurDoc.DocID); // Добавить номер существующей
   end;
  end; // not f_LinkAdded and l_Decorate
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  f_Source:= '';
  f_Plaintiff.Clear;
  f_Defendant.Clear;
  f_Thirds.Clear;
  f_Creditor.Clear;
  f_Dolzhnik.Clear;
  f_Field:= '';
  f_Interested.Clear;
  f_Participant := nil;
  f_Source:= '';
  f_Thirds.Clear;
  f_ThirdSide.Clear;
  f_Zayavitel.Clear;
  f_DossierID:= -1;
  f_Code:= '';
  l3FillChar(f_CurDoc.DocCode, SizeOf(f_CurDoc.DocCode), 32);
  f_CurDoc.DocID:= 0;
  f_LinkAdded:= False;
  f_ExtID:= 0;
  f_Name:= '';
  f_Type:= '';
 end
 else
 if CurrentType.IsKindOf(k2_typParticipant) then
  f_ParticipantType:= -1;
end;

procedure TlcDossierMaker.GenerateAACDossier;

 procedure AddOneParticipant(const aParticipant: Tl3String; const aPrefix: AnsiString);
 begin
  if not aParticipant.Empty then
  begin
   aParticipant.Insert(l3PCharLen(aPrefix), 0);
   Generator.StartChild(k2_typTextPara);
   try
    Generator.AddStringAtom(k2_tiText, aParticipant.AsWStr);
   finally
    Generator.Finish;
   end;
  end;
 end;

begin
 Generator.StartChild(k2_typDocument);
 try
  l3System.Msg2Log('Генерируем ААС справку с номером %d', [f_DossierID]);
  Generator.AddIntegerAtom(k2_tiExternalHandle, f_DossierID);
  Generator.AddIntegerAtom(k2_tiType, Ord(dtRelText));
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saColorSelection);
   Generator.AddStringAtom(k2_tiText, 'Номер дела в первой инстанции: '+ f_CaseCode);
  finally
   Generator.Finish;
  end;
  Generator.StartChild(k2_typTextPara);
  Generator.Finish;

  AddOneParticipant(f_Zayavitel, 'Заявитель: ');
  AddOneParticipant(f_Plaintiff, 'Истец: ');
  AddOneParticipant(f_Defendant, 'Ответчик: ');
  AddOneParticipant(f_Dolzhnik,  'Должник: ');
  AddOneParticipant(f_Creditor,  'Кредитор: ');
  AddOneParticipant(f_Interested, 'Заинтересованное лицо: ');
  AddOneParticipant(f_ThirdSide, 'Третье лицо: ');
  AddOneParticipant(f_Thirds, 'Иные лица: ');
 finally
  Generator.Finish;
 end;
end;

procedure TlcDossierMaker.GenerateFACDossier;
begin
 Generator.StartChild(k2_typDocument);
 try
  Generator.AddIntegerAtom(k2_tiExternalHandle, f_DossierID);
  Generator.AddIntegerAtom(k2_tiType, Ord(dtRelText));

  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalNote);
   Generator.AddStringAtom(k2_tiText, f_Name);
  finally
   Generator.Finish;
  end;

  Generator.StartChild(k2_typTextPara);
  Generator.Finish;
  (*
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalNote);
   Generator.AddStringAtom(k2_tiText, Format('Текст %s представлен %s по договору об информационно-правовом сотрудничестве.',
                                              [AnsiLowerCase(mlmaRusDeclensionStr(f_Type, rdRodit)),
                                               mlmaRusDeclensionStr(DeBracketStr(f_Source), rdTvorit)]));
  finally
   Generator.Finish;
  end;
  *)
 finally
  Generator.Finish;
 end;
end;

procedure TlcDossierMaker.GenerateVACDossier;
begin
 Generator.StartChild(k2_typDocument);
 try
  Generator.AddIntegerAtom(k2_tiExternalHandle, f_DossierID);
  Generator.AddIntegerAtom(k2_tiType, Ord(dtRelText));

  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalNote);
   Generator.AddStringAtom(k2_tiText, f_Name);
  finally
   Generator.Finish;
  end;

  Generator.StartChild(k2_typTextPara);
  Generator.Finish;

  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalNote);
   Generator.AddStringAtom(k2_tiText, Format('Текст %s официально опубликован не был', [AnsiLowerCase(mlmaRusDeclensionStr(f_Type, rdRodit))]));
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

(*
function TlcDossierMaker.MakeName: AnsiString;
begin
 // Информация о судебном деле № <CASECODE>. Истец: <Plaintiff>. Ответчик: <Defendant>.
 Result := Format('Информация о судебном деле N %s.', [f_CaseCode]);
 if f_Zayavitel <> '' then
  Result:= Result + Format(' Заявитель: %s.', [f_Zayavitel]);
 if f_Plaintiff <> '' then
  Result:= Result + Format(' Истец: %s.', [f_Plaintiff]);
 if f_Defendant <> '' then
  Result:= Result + Format(' Ответчик: %s.', [f_Defendant]);
 if f_Dolzhnik <> '' then
  Result:= Result + Format(' Должник: %s.', [f_Dolzhnik]);
end;
*)

procedure TlcDossierMaker.ModifyCase(aDossierID: TDocID);
begin
 // Добавить в исходный документ ссылку на досье
 f_LinkAdded:= True;
 Generator.AddIntegerAtom(k2_tiRelExternalHandle, aDossierID);
 l3System.Msg2Log('Добавляем справку %d к документу', [aDossierID]);
end;

procedure TlcDossierMaker.OpenStream;
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

 l_Q: TdtDictQuery;
 l_List: Tl3LongintList;
const
 cCaseCodeType : TDNType = dnLawCaseNum;
 cDocTypeDossier : TUserType = utDossier;
begin
 inherited;
 //lSab := MakeEmptySab(MakePhoto(GlobalHtServer.GetTblObjectEx(CurrentFamily, Ord(ftFile))));
 //lSab.SelectAll;

 // Найдем доки с Source из f_SourcesList
 l_Q := TdtDictQuery.Create(da_dlSources, f_SourcesList, False, True {WithSubTree});
 lSab:= l_Q.GetDocIdList;
 l3Free(l_Q);

 lFileSab := MakeSabCopy(lSab);
 lFileSab.RecordsByKey;

 // внешние номера для справок
 lRenumSab := MakeSabCopy(lSab);
 lRenumSab.ValuesOfKey(fRelated_fld);
 lRenumSab.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily).Attribute[atRenum]);
 lRenumSab.RecordsByKey;

 // Для найденных доков найдем список CaseCode
 lSab.ValuesOfKey(fId_Fld);
 lSab.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily).Attribute[atDateNums]);
 lSab.ValuesOfKey(lnkDictIDFld);
 lSab.TransferToPhoto(dnIDFld, DictServer(CurrentFamily).GroupTbl[da_dlDateNums]);
 lSab.RecordsByKey;
 lSab.SubSelect(dnTypFld, cCaseCodeType);

 // список записей Link для найденного списка CaseCode
 lSabLnk := MakeSabCopy(lSab);
 lSabLnk.ValuesOfKey(dnIDFld);
 lSabLnk.TransferToPhoto(lnkDictIDFld, LinkServer(CurrentFamily).Attribute[atDateNums]);
 lSabLnk.RecordsByKey;

 // объединяем Link-Dict что бы получить DocID-CaseCode
 lJoinDict_Link := MakeJoinSab(lSabLnk, lnkDictIDFld,
                               lSab, dnIDFld);

 // объединяем Renum-File что бы получить связь внутренний ID Дока - внешний ID справки
 lJoinFile_Renum := MakeJoinSab(lRenumSab, rnRealID_fld,
                                lFileSab, fRelated_fld);
 // объединяем File-Link
 lJoinFile_Link := MakeJoinSab(lFileSab, fID_fld,
                               lSabLnk, lnkDocIDFld);
 //объединяем Renum-File - File-Link
 lJoinRenum_Link := MakeJoinSab(lJoinFile_Renum, lJoinFile_Link, True);
 // объединяем Renum-File-Link - Link-Dict
 lJoinSabSum := MakeJoinSab(lJoinRenum_Link, lJoinDict_Link, True);


 lJoinSabSum.SortJoin([JFRec(lSab.Table, dnNumFld)]);

 f_DocList := dtMakeRecListByJoinSab(lJoinSabSum, [JFRec(lSab.Table, dnNumFld),
                                                   JFRec(lRenumSab.Table, rnImportID_fld)], [1]);
end;






procedure TlcDossierMaker.pm_SetSources(const Value: AnsiString);
begin
 Str2List(Value, f_SourcesList);
end;

procedure TlcDossierMaker.pm_SetSourcesList(const Value: Tl3LongintList);
begin
 Value.SetRefTo(f_SourcesList);
 ExpandDictIDList(da_dlSources, f_SourcesList);
end;

procedure TlcDossierMaker.pm_SetTypes(const Value: AnsiString);
begin
 Str2List(Value, f_TypesList);
end;

procedure TlcDossierMaker.Str2List(const aStr: AnsiString; aList: Tl3LongintList);
var
 i: Integer;
 l_ID: Integer;
begin
 aList.Clear;
 for i:= 1 to WordCount(aStr, [';',',']) do
 begin
  l_ID:= StrToIntDef(ExtractWord(i, aStr, [';',',']), 0);
  if l_ID > 0 then
   aList.Add(l_ID);
 end;

end;

end.
