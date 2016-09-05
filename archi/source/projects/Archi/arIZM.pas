unit arIZM;

{ $Id: arIZM.pas,v 1.29 2016/06/16 05:38:41 lukyanets Exp $ }

// $Log: arIZM.pas,v $
// Revision 1.29  2016/06/16 05:38:41  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.28  2015/11/25 14:01:28  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.27  2015/11/10 15:07:22  voba
// - Неправильно вычисляли ИЗМ
//
// Revision 1.26  2015/07/07 14:59:57  voba
// -bf
//
// Revision 1.25  2015/07/02 11:41:00  lukyanets
// Описываем словари
//
// Revision 1.24  2015/07/02 07:34:40  lukyanets
// Описываем словари
//
// Revision 1.23  2015/03/24 13:50:10  voba
// - k:565011059
//
// Revision 1.22  2015/03/13 12:00:14  voba
// - локальное автосохранение документов
//
// Revision 1.21  2014/04/17 13:09:06  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.20  2014/02/18 10:23:02  voba
//  k:236721575 (Атрибуты в EVD)
//
// Revision 1.19  2014/02/14 15:33:17  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.18  2013/02/19 13:22:49  voba
// - K:358358627
//
// Revision 1.17  2013/02/18 13:43:56  voba
// - K:358358627
//
// Revision 1.16  2011/06/10 13:12:10  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TdaFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.15  2010/09/24 12:15:31  voba
// - k : 235046326
//
// Revision 1.14  2010/01/20 15:46:27  fireton
// - переделал набор процедур по простановке IZM в глобальный объект
//   (чтобы не читать настройки по сто раз)
//
// Revision 1.13  2010/01/20 12:29:57  fireton
// - bugfix: надо было эскейпить строку номера документа
//
// Revision 1.12  2010/01/20 11:20:08  fireton
// - "обновление электронной версии" в бераторах
//
// Revision 1.11  2009/07/22 11:29:13  narry
// - изменение доступа к DictServer
//
// Revision 1.10  2009/06/23 07:35:15  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.9  2009/04/23 12:06:26  fireton
// - [$145099295]. Изменил условие проставления IZM.
//
// Revision 1.8  2009/04/22 14:38:18  lulin
// - сборка Архивариуса в HEAD.
//
// Revision 1.7  2009/04/21 09:05:01  voba
// - refact. module
//
// Revision 1.6  2009/04/13 08:55:50  narry
// - разделение определения типов и реализации
//
// Revision 1.5  2009/04/01 13:24:52  fireton
// - [$77758589]. Перенес настройку подстрок для поиска в названии документа в base.ini
//
// Revision 1.4  2009/03/06 12:21:17  voba
// - доточили логику по уточнениям Украинского
//
// Revision 1.3  2009/03/05 12:00:47  fireton
// - еще одна строка для распознания в заголовке
//
// Revision 1.2  2009/03/04 14:05:41  fireton
// - простановка !IZM в выборке
//
// Revision 1.1  2009/03/03 08:44:41  fireton
// - макросы установки типа "Изменяющий документ"  (K 77758589)
//

interface
uses
 l3Base,
 dt_Types,
 dt_AttrSchema,
 dtIntf,
 dt_Sab,
 DocIntf;

type
 TarIZMChecker = class(Tl3Base)
 private
  //f_AuthorityActs: TDictID;
  f_DossierType: TDictID;
  f_BeratorType: TDictID;
  f_IzmDopType: TDictID;
  f_NamePattern: string;
  procedure CalcNamePattern;
  function CheckoutForIZMPrim(aDocID: TDocID): Boolean;    overload;
  function CheckoutForIZMPrim(aDoc: TarDocument): Boolean; overload;
  procedure SetIZM(aDocID: TDocID);
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  //function  CheckoutForIZM(aDoc: TarDocument): Boolean; overload;
  function  CheckoutForIZM(const aDoc: TarDocument): Boolean; overload;
  function  CheckoutForIZM(aDocID: TDocID): Boolean; overload;
  procedure CheckoutForIZM(const aDocSab : ISab); overload;
  function  CheckoutForIZM(const aDocSab : ISab; out theDocIdsForIZM : ISab): Integer; overload;
  {* - саб содержит ВЫБОРКУ, а не список ID документов }
 end;

function GetIZMChecker: TarIZMChecker;

implementation
uses
 SysUtils,
 StrUtils,

 l3String,
 l3RegEx,

 k2Tags,
 Base_CFG,

 daTypes,
 daSchemeConsts,

 DT_Const,
 DT_Doc,
 DT_Dict,
 DT_Link, DT_LinkServ, Dt_aTbl,
 dt_Record,
 dt_DictConst,
 DocAttrIntf,
 DocAttrToolsIntf;

var
 g_IZMChecker : TarIZMChecker = nil;

function GetIZMChecker: TarIZMChecker;
begin
 if g_IZMChecker = nil then
  g_IZMChecker := TarIZMChecker.Create;
 Result := g_IZMChecker;
end;

procedure TarIZMChecker.CalcNamePattern;
var
 l_PatternCount: Integer;
 I: Integer;
begin
 l_PatternCount := BaseConfig.MagicNumber['IZM','NamePatternCount'];
 if l_PatternCount > 0 then
 begin
  for I := 1 to l_PatternCount do
  begin
   if I = 1 then
    f_NamePattern := '\_+('
   else
    f_NamePattern := f_NamePattern + ')|(';
   f_NamePattern := f_NamePattern + BaseConfig.MagicString['IZM', Format('NamePattern%d', [I])];
  end;
  f_NamePattern := f_NamePattern + ')';
 end
 else
  f_NamePattern := '';
end;

procedure TarIZMChecker.SetIZM(aDocID: TDocID);
var
 l_UT   : Byte;
 lDocRec : TdtRecord;
begin
 lDocRec := InitRecord(DocumentServer(CurrentFamily).FileTbl);
 if lDocRec.FindByUniq(fId_Fld, aDocID) then
 begin
  lDocRec.Get(True{hold});
  try
   l_UT := Byte(utIzm);
   lDocRec.FillField(fUserType_Fld, [l_UT]);
   lDocRec.Update;
  finally
   lDocRec.Unlock;
  end;
 end;
end;


function TarIZMChecker.CheckoutForIZMPrim(aDoc: TarDocument): Boolean;
var
 l_RExp    : Tl3RegularSearch;
 l_NumStr  : string;
 l_TmpPos  : Tl3MatchPosition;
 lFullName : AnsiString;
 I         : Integer;
 l_Str     : string;

begin
 Result := False;

 // если IZM уже стоит или редакция не действует, то и делать ничего не надо
 if not (aDoc.UserType in [utNone,utDoc]) then
  Exit;

 lFullName := l3Str(aDoc.Name);

 with (aDoc.Attribute[atTypes] as IDictAttributeTool) do
 begin
  // Проверяем тип "Изменения и дополнения"
  if f_IzmDopType > 0 then
  begin
   if (GetIndexByHandle(f_IzmDopType) >= 0) then
   begin
    Result := True;
    Exit;
   end;
  end;

  // Проверяем тип "Бераторы"
  if f_BeratorType > 0 then
  begin
    if (GetIndexByHandle(f_BeratorType) >= 0) then
   begin
    if AnsiContainsText(lFullName, 'обновление тома') or
       AnsiContainsText(lFullName, 'обновление электронной версии') then
    begin
     Result := True;
     Exit;
    end;
   end;
  end;

 // Проверяем тип "Досье на проект закона"
  if f_DossierType > 0 then
  begin
   if (GetIndexByHandle(f_DossierType) >= 0) then
   begin
    Result := True;
    Exit;
   end;
  end;
 end;//with (aDoc.Attribute[atTypes] as IDictAttributeTool) do


 l_NumStr := '';
 with aDoc.Attribute[atDateNums] as IListDocAttribute do
 for I := 0 to pred(Count) do
 begin
  l_Str := l3Str(Child[I].PCharLenA[k2_tiNumber]);
  if l_Str <> '' then
  begin
   if l_NumStr <> '' then
    l_NumStr := l_NumStr + '|';
   l_NumStr := l_NumStr + '(' + ConvertStrToRegular(l_Str) + ')';
  end;
 end;
 if l_NumStr <> '' then
 begin
  l_RExp := Tl3RegularSearch.Create;
  try
   l_RExp.IgnoreCase := True;
   try
    l_RExp.SearchPattern := Format('(%s)%s', [l_NumStr, f_NamePattern]);
    //l3System.Str2Log(Format('dbg GetNamePattern = (%s)%s', [l_NumStr, f_NamePattern]));
    //l3System.Str2Log(Format('dbg lFullName = (%s)', [lFullName]));
    if l_RExp.SearchInString(PAnsiChar(lFullName), 0, Length(lFullName), l_TmpPos) then
    begin
     //l3System.Str2Log(Format('dbg l_RExp.SearchInString found at %d-%d', [l_TmpPos.StartPos, l_TmpPos.EndPos]));
     Result := True;
     Exit;
    end;
   except
    l3System.Str2Log(Format('GetNamePattern = (%s)%s', [l_NumStr, f_NamePattern]));
    raise;
   end;
  finally
   l3Free(l_RExp);
  end; // try..finally
 end; // if l_NumStr <> ''
end;

function TarIZMChecker.CheckoutForIZMPrim(aDocID: TDocID): Boolean;
var
 //l_Temp    : Integer;
 //l_DictID  : TDictID;
 l_Sab     : ISab;
 l_DocRec  : TdtRecord;
 l_RExp    : Tl3RegularSearch;
 l_NumStr  : string;
 l_Stub    : TdtRecAccessProc;
 l_TmpPos  : Tl3MatchPosition;

 lFullName : AnsiString;

 function l_NumIterator(aNum: PNumberStr): Boolean;
 var
  l_Str: string;
 begin
  Result := True;
  l_Str := l3ArrayToString(aNum^, cDNNumberLen);
  if l_Str <> '' then
  begin
   if l_NumStr <> '' then
    l_NumStr := l_NumStr + '|';
   l_NumStr := l_NumStr + '(' + ConvertStrToRegular(l_Str) + ')';
  end;
 end;

begin
 Result := False;

 // получаем карточку документа
 l_DocRec := InitRecord(DocumentServer(CurrentFamily).FileTbl);

 if not l_DocRec.FindByUniq(fId_Fld, aDocID) then
  Exit;

 // если IZM уже стоит или редакция не действует, то и делать ничего не надо
 if not (TUserType(l_DocRec.GetIntField(fUserType_Fld)) in [utNone,utDoc]) then
  Exit;

 lFullName := l_DocRec.GetStrField(fFName_Fld);

 // Проверяем тип "Изменения и дополнения"
 if f_IzmDopType > 0 then
 begin
  //l_DictID := l_Temp;
  l_Sab := MakeSab(LinkServer(CurrentFamily).Links[da_dlTypes]);
  l_Sab.Select(lnkDocIDFld, aDocID);
  l_Sab.SubSelect(lnkDictIDFld, f_IzmDopType);
  if l_Sab.Count > 0 then
  begin
   Result := True;
   Exit;
  end;
 end;

 // Проверяем тип "Бераторы"
 if f_BeratorType > 0 then
 begin
  //l_DictID := l_Temp;
  l_Sab := MakeSab(LinkServer(CurrentFamily).Links[da_dlTypes]);
  l_Sab.Select(lnkDocIDFld, aDocID);
  l_Sab.SubSelect(lnkDictIDFld, f_BeratorType);
  if l_Sab.Count > 0 then
  begin
   if AnsiContainsText(lFullName, 'обновление тома') or
      AnsiContainsText(lFullName, 'обновление электронной версии') then
   begin
    Result := True;
    Exit;
   end;
  end;
 end;

// Проверяем тип "Досье на проект закона"
 if f_DossierType > 0 then
 begin
  //l_DictID := l_Temp;
  l_Sab := MakeSab(LinkServer(CurrentFamily).Links[da_dlTypes]);
  l_Sab.Select(lnkDocIDFld, aDocID);
  l_Sab.SubSelect(lnkDictIDFld, f_DossierType);
  if l_Sab.Count > 0 then
  begin
   Result := False;
   Exit;
  end;
 end;

// Проверяем, проставлен ли нужный префикс (Акты органов власти)
 (*if (f_AuthorityActs > 0) and (f_NamePattern <> '') then
 begin
  //l_DictID := l_Temp;
  l_Sab := MakeSab(LinkServer(CurrentFamily).Links[da_dlPrefixes]);
  l_Sab.Select(lnkDocIDFld, aDocID);
  l_Sab.SubSelect(lnkDictIDFld, f_AuthorityActs);
  if l_Sab.Count > 0 then // да, нужный префикс проставлен
  begin
  *)
   // ищем даты и номера
   l_Sab := MakeSab(LinkServer(CurrentFamily).Links[da_dlDateNums]);
   l_Sab.Select(lnkDocIDFld, aDocID);
   if l_Sab.Count > 0 then
   begin
    l_Sab.ValuesOfKey(lnkDictIDFld);
    l_Sab.TransferToPhoto(dtIDFld, DictServer(CurrentFamily).DictTbl[da_dlDateNums]);
    l_Sab.RecordsByKey;
    l_NumStr := '';
    l_Stub := L2RecAccessProc(@l_NumIterator);
    try
     l_Sab.IterateRecords(l_Stub, [dnNumFld]);
    finally
     FreeRecAccessProc(l_Stub);
    end;
    if l_NumStr <> '' then
    begin
     l_RExp := Tl3RegularSearch.Create;
     try
      l_RExp.IgnoreCase := True;
      try
       l_RExp.SearchPattern := Format('(%s)%s', [l_NumStr, f_NamePattern]);
       //l3System.Str2Log(Format('dbg GetNamePattern = (%s)%s', [l_NumStr, f_NamePattern]));
       //l3System.Str2Log(Format('dbg lFullName = (%s)', [lFullName]));
       if l_RExp.SearchInString(PAnsiChar(lFullName), 0, Length(lFullName), l_TmpPos) then
       begin
        //l3System.Str2Log(Format('dbg l_RExp.SearchInString found at %d-%d', [l_TmpPos.StartPos, l_TmpPos.EndPos]));
        Result := True;
        Exit;
       end;
      except
       l3System.Str2Log(Format('GetNamePattern = (%s)%s', [l_NumStr, f_NamePattern]));
       raise;
      end;
     finally
      l3Free(l_RExp);
     end; // try..finally
    end; // if l_NumStr <> ''
   end; // if l_Sab.Count > 0
 // end; // if l_Sab.Count > 0
 //end; // if l_Temp > 0
end;


function TarIZMChecker.CheckoutForIZM(aDocID: TDocID): Boolean;
begin
 Result := CheckoutForIZMPrim(aDocID);
 if Result then
  SetIZM(aDocID);
end;

function  TarIZMChecker.CheckoutForIZM(const aDoc: TarDocument): Boolean;
begin
 Result := CheckoutForIZMPrim(aDoc);
 if Result then
  aDoc.UserType := utIzm;
end;

procedure TarIZMChecker.CheckoutForIZM(const aDocSab : ISab);
var
 lSab : ISab;
 l_UT   : TUserType;
begin
 l_UT := utIzm;
 if CheckoutForIZM(aDocSab, lSab) > 0 then
 begin
  lSab.RecordsByKey;
  lSab.ModifyRecs(fUserType_Fld, l_UT, true);
 end;
end;

function TarIZMChecker.CheckoutForIZM(const aDocSab : ISab; out theDocIdsForIZM : ISab): Integer;
var
 lCount: Integer;
 lTotalCount: Integer;
 lVSFiller   : IValueSetFiller;

 function lIterator(aPDocID : PDocID) : Boolean;
 begin
  Result := True;
  Inc(lTotalCount);
  if lTotalCount mod 50000 = 0 then
   l3System.Str2Log('trace - '+IntToStr(lTotalCount));
  try
   if CheckoutForIZMPrim(aPDocID^) then
   begin
    lVSFiller.AddValue(aPDocID^);
    l3System.Str2Log(IntToStr(aPDocID^));
    //SetIZM(aPDocID^); // проставляем !IZM
    Inc(lCount);
   end;
  except
   l3System.Str2Log('problem with topic #'+IntToStr(aPDocID^));
   //l3System.Str2Log(IntToStr(aPDocID^));
  end;
 end;

var
 lRAProcStub : TdtRecAccessProc;

begin
 if (aDocSab = nil) or (aDocSab.Count = 0) then
 begin
  Result := 0;
  Exit;
 end;

 l3System.Str2Log('CheckoutForIZM');
 if theDocIdsForIZM = nil then
  theDocIdsForIZM := MakeEmptySab(aDocSab);

 lVSFiller := theDocIdsForIZM.MakeValueSetFiller(fId_Fld);
 try
  lCount := 0;
  lTotalCount := 0;
  lRAProcStub := L2RecAccessProc(@lIterator);
  try
   aDocSab.IterateRecords(lRAProcStub, [fId_Fld]);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
  Result := lCount;
 finally
  lVSFiller := nil;
 end;
end;

constructor TarIZMChecker.Create;
begin
 inherited Create;
 f_IzmDopType := BaseConfig.MagicNumber['IZM','IzmDopType'];
 f_BeratorType := BaseConfig.MagicNumber['IZM','BeratorType'];
 f_DossierType := BaseConfig.MagicNumber['IZM','DossierType'];
 //f_AuthorityActs := BaseConfig.MagicNumber['IZM','AuthorityActs'];
 CalcNamePattern;
end;

procedure TarIZMChecker.Cleanup;
begin
 inherited;
end;

initialization

finalization
 l3Free(g_IZMChecker);
end.
