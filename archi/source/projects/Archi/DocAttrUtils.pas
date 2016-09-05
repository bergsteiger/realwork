unit DocAttrUtils;

{ $Id: DocAttrUtils.pas,v 1.29 2016/08/11 11:37:08 lukyanets Exp $ }
{$I arDefine.inc}
interface
 Uses
  SysUtils, Classes, Graphics,
  ResShop, StrShop, IniShop,
  DocAttrIntf,
  k2Interfaces,
  l3DatLst,
  l3Types,

  DT_Const,
  DT_Types,
  dt_AttrSchema,
  DT_Serv,
  DT_Dict,
  DT_Link,
  DT_Doc,
  DT_Active,
  DT_Alarm,
  dt_DictTypes,
  l3Date,
  l3Nodes,
  l3Tree_TLB,
  StDateSt,
  DocAttrTypes,

  l3Variant
  ;

 function GetAttrName(aAttrID : TdtAttribute) : AnsiString;
 function GenDocIDsString(aRec : TDocIDsRec) : string;

 function  GenStDateString(aStDate : TStDate) : AnsiString;
 function  GenDateDiapasonString(aDateBounds : Tl3DateBounds) : AnsiString;

 procedure GenDateNumString(aItem : Tl3Tag);
 procedure GenCorrectString(aItem : Tl3Tag; aPublInStr : Tl3PCharLen);
 procedure GenPublInString (aItem : Tl3Tag);
 procedure GenActiveIntervalString(aItem : Tl3Tag);
 procedure GenAlarmString(aItem : Tl3Tag);
 procedure GenDoc2DocString(aItem : Tl3Tag);
 procedure GenLogString(aItem : Tl3Tag);
 procedure GenLogString_forGroupEdit(aItem : Tl3Tag);

 function  AttrListToDescriptorString(aList : IListDocAttribute; aSeparator : ShortString): AnsiString;
 procedure GetDNTypeList(aLst : TStrings);
 //function GetLogJrnlName(aAction : TLogActionType) : AnsiString;

 procedure LoadAttrList(aAttrSet : TdtAttributeSet; aList : Tl3StringDataList);
  {- load list of Name of Attr}

 procedure SetSelectOfAttrList(aList : Tl3StringDataList; aSelAttrSet : TdtAttributeSet);
 function  GetSelectOfAttrList(aList : Tl3StringDataList): TdtAttributeSet;
 procedure SaveSelectOfAttrList(const aItemID : AnsiString; aSelAttrSet : TdtAttributeSet);
 //function  LoadSelectOfAttrList(aItemID : AnsiString) : TdtAttributeSet;

 procedure GetHiddenAttr(aList : Tl3StringDataList);
 procedure SetHiddenAttr(aList : Tl3StringDataList);
 procedure LoadHiddenAttr;
 procedure SaveHiddenAttr;
 procedure GetUserAttrList(aList : Tl3StringDataList);

resourcestring
 rsCorSourcesDefItem = '[Получено по рассылке]';

implementation

uses
  l3Base,
  l3String,
  l3DateSt,
  l3Bits,
  l3MinMax,
  l3IniFile,
  l3TreeInterfaces,
  DictsSup,
  k2Tags,
  Com_Cnst,
  daTypes,
  daSchemeConsts,
  daDataProvider,
  dt_DictConst,
  dt_LinkServ;

function GenStDateString(aStDate : TStDate) : AnsiString;
var
 D1, M1, Y1 : Integer;
begin
 StDateToDMY(aStDate, D1, M1, Y1);
 Result := Format('%d/%d/%d', [D1, M1, Y1]);
end;

function GenDateDiapasonString(aDateBounds : Tl3DateBounds) : AnsiString;
var
 D1, M1, Y1 : Integer;
begin
 Result := '';
 with aDateBounds do
 begin
  if (Low = maxActiveDate) and (High = maxActiveDate) then
   Result := ' будет действовать'
  else
  If (Low = minActiveDate) and (High = minActiveDate) then
   Result := ' уже не действует'
  else
  if (Low <> BlankDate) and (Low <> maxActiveDate) and (Low <> minActiveDate) then
  begin
   StDateToDMY(Low, D1, M1, Y1);
   Result := Result + Format(' c %d/%d/%d', [D1, M1, Y1]);
  end;

  if (High <> BlankDate) and (High <> maxActiveDate) and (High <> minActiveDate) then
  begin
   StDateToDMY(High, D1, M1, Y1);
   Result := Result + Format(' по %d/%d/%d', [D1, M1, Y1]);
  end;
 end;
end;

const
 cDNNameArr : array[TDNType] of AnsiString = (
   'dnDoc не используется',        {dnDoc        }
   'Издан',                        {dnPublish    }
   'Регистрация в МЮ',             {dnMU         }
   'Принят ГД',                    {dnGD         }
   'Принят СФ',                    {dnSF         }
   'Дата изменяющего документа',   {dnChangerDate}
   'Номер судебного дела',         {dnLawCaseNum }
   'Номер для поиска'              {dnAddNum     }
  );

function GetDNTypeName(aDNType : TDNType) : AnsiString;
begin
 Result := cDNNameArr[aDNType];
end;

procedure GenDateNumString(aItem : Tl3Tag);
var
 lDNType : TDNType;
 lDate   : TstDate;
 lExtDocID : TDocID;
begin
 with (aItem.cAtom(k2_tiName).AsObject As Tl3String) do
 begin
  Clear;
  lDNType := TDNType(aItem.IntA[k2_tiType]);
  lDate := aItem.IntA[k2_tiStart];
  if (lDNType = dnMU) and (lDate = BlankDate) and (aItem.PCharLenA[k2_tiNumber].SLen = 0) then
   AsString := 'В регистрации Минюстом отказано'
  else
  begin
   AsString := GetDNTypeName(lDNType);
   if (lDate <> BlankDate) then
   begin
    Append(l3PCharLen(' '));
    Append(l3PCharLen(GenStDateString(lDate)));
   end;

   if (lDNType = dnChangerDate) then
   begin
    with aItem.Attr[k2_tiLinkAddress] do
     if IsValid and (IntA[k2_tiDocID] > 0) then
     begin
      if (lDate <> BlankDate) then
       Append(l3PCharLen(','));
      Append(l3PCharLen(' ID:'));
      lExtDocID := LinkServer(CurrentFamily).Renum.GetExtDocID(IntA[k2_tiDocID]);
      Append(l3PCharLen(format('%d.%d', [lExtDocID, IntA[k2_tiSubID]])));
     end
   end
   else
    if aItem.PCharLenA[k2_tiNumber].SLen > 0 then
    begin
     if (lDate <> BlankDate) then
       Append(l3PCharLen(','));
    Append(l3PCharLen(' №'));
    Append(aItem.PCharLenA[k2_tiNumber]);
   end;
  end;

  if aItem.PCharLenA[k2_tiComment].SLen > 0 then
  begin
  Append(l3PCharLen(' ('));
  Append(aItem.PCharLenA[k2_tiComment]);
  Append(l3PCharLen(')'));
  end;
 end;
end;


procedure GenLogString(aItem : Tl3Tag);
begin
 with (aItem.cAtom(k2_tiName) As Tl3String) do
 begin
  Clear;
   //Append(l3PCharLen(GetLogJrnlName(TLogActionType(IntA[k2_tiAction]))));
   //if IntA[k2_tiStart] <> BadDate then
   Append(l3PCharLen(FormatDateTime(' dd.mm.yyyy', StDateToDateTime(DemonToStDate(aItem.IntA[k2_tiStart]))) + #9 +
                      StTimeToTimeString('hh:mm' {ShortTimeFormat}, Min(aItem.IntA[k2_tiTime], MaxTime), False) + #9 +
                      GetLogJrnlName(TLogActionType(aItem.IntA[k2_tiType])) {+format('#%d',[aItem.IntA[k2_tiType]])} + #9));

   with aItem.Attr[k2_tiUser] do
   if IsValid and (IntA[k2_tiHandle] <> 0) then
    Append(l3PCharLen(GlobalDataProvider.UserManager.GetUserDisplayName(TdaUserID(IntA[k2_tiHandle]))));
 end;
end;

procedure GenLogString_forGroupEdit(aItem : Tl3Tag);
begin
 with (aItem.cAtom(k2_tiName) As Tl3String) do
 begin
  Clear;
   //Append(l3PCharLen(GetLogJrnlName(TLogActionType(IntA[k2_tiAction]))));
   //if IntA[k2_tiStart] <> BadDate then
   Append(l3PCharLen(FormatDateTime(' dd.mm.yyyy', StDateToDateTime(DemonToStDate(aItem.IntA[k2_tiStart]))) + ' ' +
                      GetLogJrnlName(TLogActionType(aItem.IntA[k2_tiType]))));
 end;
end;

procedure GenCorrectString(aItem : Tl3Tag; aPublInStr : Tl3PCharLen);
var
 lDate   : TstDate;
begin
 with (aItem.cAtom(k2_tiName).AsObject As Tl3String) do
 begin
  Clear;
  lDate := aItem.IntA[k2_tiStart];
  if lDate <> BlankDate then
   Append(l3PCharLen(GenStDateString(lDate)));

  case TCorType(aItem.IntA[k2_tiType]) of
   ctFull   : Append(l3PCharLen(' документ вычитан'));
   ctChange : Append(l3PCharLen(' изменения вычитаны'));
  end;

  if aPublInStr.SLen > 0 then
  begin
   Append(l3PCharLen(' по '));
   Append(aPublInStr);
  end;

  with aItem.Attr[k2_tiUser] do
   if IsValid and (IntA[k2_tiHandle] <> 0) then
  begin
   Append(l3PCharLen(', корректор : '));
    Append(l3PCharLen(GlobalDataProvider.UserManager.GetUserDisplayName(TdaUserID(IntA[k2_tiHandle]))));
  end;

  if aItem.PCharLenA[k2_tiComment].SLen > 0 then
  begin
   Append(l3PCharLen(' ('));
   Append(aItem.PCharLenA[k2_tiComment]);
   Append(l3PCharLen(')'));
  end;
 end;
end;

(*
function GenCorrectString(var aRec : TCorrectDictRec; aPublInList : Tl3StringDataList) : AnsiString;
var
 D1, M1, Y1 : Integer;
 CStr       : AnsiString;
 lInd       : Integer;
begin
 Result := '';

 //TCorType        = (ctNone,ctFull,ctChange);
 with aRec do
 begin
  if Date <> BlankDate then
  begin
   StDateToDMY(Date, D1, M1, Y1);
   Result:= Format('%d/%d/%d', [D1, M1, Y1])
  end;

  case Typ of
   ctFull   : Result := Result + ' документ вычитан';
   ctChange : Result := Result + ' изменения вычитаны';
  end;

  if Sour <> 0 then
  begin
   lInd := aPublInList.IndexOfData(Sour, SizeOf(Sour), 0);
   if lInd >= 0 then
    Result := Result + ' по ' + aPublInList[lInd];
  end;

  if Author <> 0 then
   Result := Result + ', корректор : ' + UserManager.GetUserDisplayName(TdaUserID(Author));

  CStr := l3ArrayToString(Comment, SizeOf(Comment));
  if Length(CStr) > 0 then Result := Result + ' (' + CStr + ')';
 end;
end;
*)
(*
function GenIssueString(var aRec : TPublishedDictRec) : AnsiString;
var
 D1, M1, Y1,
 D2, M2, Y2 : Integer;
 CStr       : AnsiString;
begin
 Result := '';
 with aRec do
  begin
   {
   try
    If Sour > 0 then
     Result := DictServer.DictTbl[da_dlCorSources].GetNameStr(Sour);
   except
   end;
   }

   if SDate <> BlankDate then
    Result := Result + MakeHRDateIntervalStr(SDate, EDate);
    {
   begin
    StDateToDMY(SDate, D1, M1, Y1);
    if SDate = EDate then
     Result := Result + Format(' %d/%d/%d', [D1, M1, Y1])
    else
    begin
     StDateToDMY(EDate, D2, M2, Y2);
     if (Y1 = Y2) and (M1 = M2) and (D1 = 1) and (D2 = DaysInMonth(M1, Y1)) then
      Result := Result + Format(' %d/%d', [M1, Y1])
     else
      if (Y1 = Y2) and (M1 = 1) and (M2 = 12) and (D1 = 1) and (D2 = 31) then
       Result := Result + Format(' %d', [Y1])
      else
       Result := Result + Format(' %d/%d/%d-%d/%d/%d', [D1, M1, Y1, D2, M2, Y2]);
    end;
   end;
   }

   CStr := l3ArrayToString(Num, SizeOf(Num));
   if Length(CStr) > 0 then Result := Result + Format(' №%S', [CStr]);

   CStr := l3ArrayToString(Comment, SizeOf(Comment));
   If Length(CStr) > 0 then Result := Result + ' (' + CStr + ')';
  end;
end;
*)

procedure GenTreeDictName(aDictID   : TdaDictionaryType;
                          aName : Tl3String;
                          aItemID : Integer;
                          const aLevelSlash  : AnsiString = '\';
                          const aLevelIndent : AnsiString = '');

 function lFindNodeByHandle(const aRootNode: Il3Node;
                            aHandle: Integer;
                            aIterMode: Integer = 0;
                            const aFromNode: Il3Node = nil): Il3Node;

 function IterHandler(const aCurNode: Il3Node): Boolean;
 var
  l_HandleNode : Il3HandleNode;
  lExtNode : Il3ExtItemNode;
 begin
  try
   if not Supports(aCurNode, Il3ExtItemNode, lExtNode) and
      l3IOk(aCurNode.QueryInterface(Il3HandleNode, l_HandleNode)) then
    try
     Result := (aHandle = l_HandleNode.Handle);
    finally
     l_HandleNode := nil;
    end//try..finally
   else
    Result := False;
  except
   on E: Exception do
   begin
    Result := False;
    l3System.Exception2Log(E);
   end;
  end;
 end;

 begin
  Result := l3IterateSubTreeF(aRootNode, l3L2NA( @IterHandler), imCheckResult or aIterMode, aFromNode);
 end;

 var
  lRootNode : Il3Node;
  lNode     : Il3Node;
  //lDictID   : TdaDictionaryType;
  lLen      : Cardinal;
 begin
  //lDictID :=  AttrID2DLType(fAttrID);

  //with (aItem.cAtom(k2_tiName).AsObject As Tl3String) do
  //begin
   lRootNode := DictServer(CurrentFamily).DictRootNode[aDictID];
   lNode := lFindNodeByHandle(lRootNode, aItemID);
   lLen := l3GetFullPathLen(lRootNode, lNode, aLevelSlash, aLevelIndent);
   aName.Len := lLen;
   l3GetFullPath(lRootNode, lNode, aName.St, lLen, aLevelSlash, aLevelIndent);
  //end;
 end;

procedure GenPublInString(aItem : Tl3Tag); overload;
var
 D1, M1, Y1,
 D2, M2, Y2 : Integer;
 lNeedComma : boolean;
 lSDate     : TstDate;
 lFDate     : TstDate;

begin
 with (aItem.cAtom(k2_tiName).AsObject As Tl3String) do
 begin
  Clear;
  try
   with aItem.Attr[k2_tiSource] do
    if IsValid and (IntA[k2_tiHandle] > 0) then
     GenTreeDictName(da_dlCorSources, aItem.cAtom(k2_tiName).AsObject As Tl3String, IntA[k2_tiHandle])
     //Append(l3PCharLen(DictServer(CurrentFamily).DictTbl[da_dlCorSources].GetNameStr(IntA[k2_tiHandle])))
   else
    Append(l3PCharLen(rsCorSourcesDefItem));
  except
  end;

  if aItem.PCharLenA[k2_tiNumber].SLen > 0 then
  begin
   Append(l3PCharLen(' №'));
   Append(aItem.PCharLenA[k2_tiNumber]);
  end;

  lSDate := aItem.IntA[k2_tiStart];
  if lSDate <> BlankDate then
  begin
   StDateToDMY(lSDate, D1, M1, Y1);
   lFDate := aItem.IntA[k2_tiFinish];

   if lSDate = lFDate then
    Append(l3PCharLen(Format(', %d/%d/%d', [D1, M1, Y1])))
   else
   begin
    StDateToDMY(lFDate, D2, M2, Y2);
    if (Y1 = Y2) and (M1 = M2) and (D1 = 1) and (D2 = DaysInMonth(M1, Y1)) then
      Append(l3PCharLen(Format(', %d/%d', [M1, Y1])))
    else
     if (Y1 = Y2) and (M1 = 1) and (M2 = 12) and (D1 = 1) and (D2 = 31) then
      Append(l3PCharLen(Format(', %d', [Y1])))
     else
      Append(l3PCharLen(Format(', %d/%d/%d-%d/%d/%d', [D1, M1, Y1, D2, M2, Y2])));
   end;
  end;

  if aItem.PCharLenA[k2_tiComment].SLen > 0 then
  begin
   Append(l3PCharLen(' ('));
   Append(aItem.PCharLenA[k2_tiComment]);
   Append(l3PCharLen(')'));
  end;

  if aItem.PCharLenA[k2_tiPages].SLen > 0 then
  begin
   Append(l3PCharLen(', страницы: '));
   Append(aItem.PCharLenA[k2_tiPages]);
   lNeedComma := False;
  end
  else
   lNeedComma := True;

  if aItem.PCharLenA[k2_tiLinkComment].SLen > 0 then
  begin
   if lNeedComma then Append(l3PCharLen(','));
   Append(l3PCharLen(' ('));
   Append(aItem.PCharLenA[k2_tiLinkComment]);
   Append(l3PCharLen(')'));
  end;

 end;
end;
{
function GenPublInString(aRec : PPublishFullRec): AnsiString;
var
 D1, M1, Y1,
 D2, M2, Y2 : Integer;
 CStr       : AnsiString;
 lNeedComma : boolean;
begin
(* TPublishFullRec = packed record
                    ID      : Longword;
                    Sour    : TDictID;
                    SDate   : TStDate;
                    EDate   : TStDate;
                    Num     : array[1..10] of AnsiChar;

                    Pages   : array[1..128] of AnsiChar;
                    Coment  : array[1..255] of AnsiChar;*)


 Result := '';
 with aRec^ do
 begin
  try
   if Sour > 0 then
    Result := DictServer(CurrentFamily).DictTbl[da_dlCorSources].GetNameStr(Sour)
   else
    Result := rsCorSourcesDefItem;
  except
  end;

  CStr := l3ArrayToString(Num, SizeOf(Num));
  if Length(CStr) > 0 then Result := Result + Format(', №%S', [CStr]);

  if SDate <> BlankDate then
  begin
   StDateToDMY(SDate, D1, M1, Y1);
   If SDate = EDate then
    Result:= Result + Format(', %d/%d/%d', [D1, M1, Y1])
   else
   begin
    StDateToDMY(EDate, D2, M2, Y2);
    if (Y1 = Y2) and (M1 = M2) and (D1 = 1) and (D2 = DaysInMonth(M1, Y1)) then
     Result:= Result + Format(', %d/%d', [M1, Y1])
    else
     if (Y1 = Y2) and (M1 = 1) and (M2 = 12) and (D1 = 1) and (D2 = 31) then
      Result := Result + Format(', %d', [Y1])
     else
      Result := Result + Format(', %d/%d/%d-%d/%d/%d', [D1, M1, Y1, D2, M2, Y2]);
   end;
  end;

  CStr := l3ArrayToString(Comment, SizeOf(Comment));
  if Length(CStr) > 0 then Result := Result + ' (' + CStr + ')';

  CStr := l3ArrayToString(Pages, SizeOf(Pages));
  if Length(CStr) > 0 then
  begin
   Result := Result + ', страницы: ' + CStr;
   lNeedComma := False;
  end
  else
   lNeedComma := True;

  if (Flags and pinfClone) > 0 then
  begin
   Result := Result + ', клон';
   lNeedComma := False;
  end;

  CStr := l3ArrayToString(LinkComment, SizeOf(LinkComment));
  if Length(CStr) > 0 then
  begin
   if lNeedComma then Result := Result + ',';
   Result := Result + ' (' + CStr + ')';
  end;
 end;
end;
}
(*
function GetAssGroupName(piAssGroupID : integer) : AnsiString;
var
 l_Res: AnsiString;

 procedure CheckGroup(aMask: Integer; aName: AnsiString);
 begin
  if l3TestMask(piAssGroupID, aMask) then
  begin
   if l_Res <> '' then
    l_Res := l_Res + ', ';
   l_Res := l_Res + aName;
  end;
 end;

begin
 l_Res := '';

 CheckGroup(acgNameAttr,  'Атрибуты');
 CheckGroup(acgText,      'Текст и справка');
 CheckGroup(acgHyperLink, 'Гиперссылки');
 CheckGroup(acgBlock,     'Блоки');
 CheckGroup(acgSub,       'Метки');
 CheckGroup(acgKeyWord,   'Ключевые слова');
 CheckGroup(acgClass,     'Классы');
 CheckGroup(acgJurOp,     'Юридические операции');
 CheckGroup(acgAnno,      'Аннотация');
 CheckGroup(acgDocGroup,  'Группы документов');
 Result := l_Res;
 //If piAssGroupID = romDocGroup then Result := 'Группы документов';
end;


function GetAssMaskStr(aMask : Longint) : AnsiString;
var
 I : integer;
begin
 Result := '';
 I := 1;
 While aMask <> 0 do
 begin
  If (aMask and I) > 0 then
  begin
   If Result <> '' then Result := Result + ', ';
   Result := Result + GetAssGroupName(I);
   aMask := aMask and Not I;
  end;
  I := I shl 1;
 end;
end;
*)

procedure GetDNTypeList(aLst : TStrings);
var
 I : TDNType;
begin
 for I := Low(TDNType) to High(TDNType) do
  aLst.Add(GetDNTypeName(I));
end;

(*
function GetLogJrnlName(aAction : TLogActionType) : AnsiString;
begin
 case aAction of
  acRevision        : Result := 'Revision';
  acAttrWork        : Result := 'Атрибуты изменены';
  acTextWork        : Result := 'Текст изменен';
  acHLWork          : Result := 'Ссылки изменены';
  acKWWork          : Result := 'Ключевые слова изменены';
  acClassWork       : Result := 'Классификация изменена';
  acNew             : Result := 'Создан';
  acIncluded        : Result := 'Включен в базу';
  acChanged         : Result := 'Внесены юридические изменения';
  acAbolished       : Result := 'Утратил силу';
  acLControl        : Result := 'Снят с контроля';
  acAnonced         : Result := 'Анонсирован';
  acPublInWork      : Result := 'Информация об опубликовании изменена';
  acWasImported     : Result := 'Импортирован';
  acAnnoDate        : Result := 'Аннотация включена в базу';
  acAnnoWork        : Result := 'Аннотация изменена';
  acAnnoWasImported : Result := 'Аннотация импортирована';
  acAnnoWasDeleted  : Result := 'Аннотация удалена';
  acScriptHadled_AddPublInfo : Result := 'Обработан скриптом "Информация об опубликовании"';
  else                Result := '?';
 end;
end;
*)
function GetDictName(aDictID : TdaDictionaryType) : AnsiString;
begin
 Result := cDLPassports[aDictID].rName;
end;

function GetAttrName(aAttrID : TdtAttribute) : AnsiString;
begin
 Result := cAttrPassport[aAttrID].rName;
end;

function GetDictNameLength(aAttrID : TdaDictionaryType) : integer;
begin
 case aAttrID of
  da_dlSources     : Result := 95;
  da_dlTypes       : Result := 95;
  da_dlClasses     : Result := 95;
  da_dlNewClasses_Deprecated  : Result := 95;
  da_dlPrefixes    : Result := 79;
  da_dlKeyWords    : Result := 99;
  da_dlBases       : Result := 79;
  da_dlWarnings    : Result := 1000;
  da_dlCorrects    : Result := 79;
  da_dlCorSources  : Result := 100;
  da_dlTerritories : Result := 79;
  da_dlNorms       : Result := 19;
  da_dlAccGroups   : Result := 200;
  da_dlServiceInfo : Result := 100;
  da_dlTextInsert  : Result := 200;

  else             Result := 0;
 end;
end;

function GetAttrLogType(aAttrID : TdtAttribute; out aLogAction : TLogActionType) : Boolean;
begin
 Result := True;
 case aAttrID of
  atSources,
  atTypes,
  atDateNums,
  atWarnings,
  atAccGroups,
  atBases,
  atVerLink,
  atActiveIntervals,
  atAlarms,
  atServiceInfo     : aLogAction := acAttrWork;

  atClasses,
  atPrefixes,
  atTerritories,
  atNorms           : aLogAction := acClassWork;
  atAnnoClasses     : aLogAction := acAnnoWork;
  atKeyWords        : aLogAction := acKWWork;
  atPublisheds      : aLogAction := acPublInWork;

  atCorrects        : aLogAction := acAttrWork;
  else
   {aidTextInsert, aidJurOperation, aidDocIDs}
   Result := False;
 end;
end;

function GetAttrStructSize(aAttrID : TdtAttribute) : Integer;
begin
 case aAttrID of
  atRenum        : Result := SizeOf(TDocIDsRec);
  atDoc2DocLink  : Result := SizeOf(TDoc2DocRec);
 else              Result := SizeOf(TDictID);
 end;
end;

{function GenPaperWhereString(aPaperUser : TDictID; Const aPaperPlace    : AnsiString) : AnsiString;
begin
 Result := '';
 if aPaperUser = ArchivePlace then
  Result := 'В архиве : ' +  aPaperPlace
 else
  if aPaperUser <> 0 then
   Result := 'У пользователя : ' +  UserManager.GetUserDisplayName(TdaUserID(aPaperUser));
end;

function GenWarningString(aDictText, aUserText : AnsiString) : AnsiString;
}

{function GenWarningString(aDictText, aUserText : String) : string;

begin
 if aDictText <> '' then
 begin
  Result := aDictText;
  if aUserText <> '' then
   Result := Result + ' (' + aUserText + ')';
 end
 else
  Result := aUserText;
end;
}
procedure GenActiveIntervalString(aItem : Tl3Tag);
var
 lStr       : AnsiString;
 lSDate     : TstDate;
 lFDate     : TstDate;

begin
 with (aItem.cAtom(k2_tiName).AsObject As Tl3String) do
 begin
  Clear;
  lSDate := aItem.IntA[k2_tiStart];
  lFDate := aItem.IntA[k2_tiFinish];
  if aItem.IntA[k2_tiType] = actt_Unsure then // !NotSure
   Append(l3PCharLen('Период неуверенности' + GenDateDiapasonString(MakeDateBounds(lSDate, lFDate))))
  else
  if (lSDate = maxActiveDate) and (lFDate = maxActiveDate) then
   Append(l3PCharLen('Документ будет действовать (дата неизвестна)'))
  else
  if (lSDate = minActiveDate) and (lFDate = minActiveDate) then
   Append(l3PCharLen('Документ уже не действует (дата неизвестна)'))
  else
   Append(l3PCharLen('Документ действует' + GenDateDiapasonString(MakeDateBounds(lSDate, lFDate))));

  if aItem.PCharLenA[k2_tiComment].SLen > 0 then
  begin
   Append(l3PCharLen(' ('));
   Append(aItem.PCharLenA[k2_tiComment]);
   Append(l3PCharLen(')'));
  end;
 end;
end;


{function GenActiveIntervalString(aRec : TActiveIntervalRec) : AnsiString;
var
 lStr       : AnsiString;
begin
 with aRec do
 begin
  if Typ = actt_Unsure then // !NotSure
   Result := 'Период неуверенности' + GenDateDiapasonString(MakeDateBounds(Start, Finish))
  else
  if (Start = maxActiveDate) and (Finish = maxActiveDate) then
   Result := 'Документ будет действовать (дата неизвестна)'
  else
  If (Start = minActiveDate) and (Finish = minActiveDate) then
   Result := 'Документ уже не действует (дата неизвестна)'
  else
   Result := 'Документ действует' + GenDateDiapasonString(MakeDateBounds(Start, Finish));

  lStr := l3ArrayToString(Comment, SizeOf(Comment));
   If lStr <> '' then
    Result := Result + Format(' (%s)', [lStr]);
 end;
end;
 }
procedure GenAlarmString(aItem : Tl3Tag);
var
 D1, M1, Y1 : Integer;
// lStr       : AnsiString;
begin
 with (aItem.cAtom(k2_tiName) As Tl3String) do
 begin
  Clear;
  Append(l3PCharLen(GenStDateString(aItem.IntA[k2_tiStart])));

  if aItem.PCharLenA[k2_tiComment].SLen > 0 then
  begin
   Append(l3PCharLen(' "'));
   Append(aItem.PCharLenA[k2_tiComment]);
   Append(l3PCharLen('"'));
  end;
 end;
end;

const
 cDoc2DocLinkViewStr: array[dltChanged..dltStaled] of string =
  ('Документ %d изменен',
   'Документ %d утратил силу');

procedure GenDoc2DocString(aItem : Tl3Tag);
var
 lDocID : TDocID;
 lName : Tl3String;
begin
 lDocID := aItem.IntA[k2_tiDocID];
 lName := aItem.cAtom(k2_tiName).AsObject As Tl3String;
 lName.Clear;
 lName.Append(l3PCharLen(Format(cDoc2DocLinkViewStr[aItem.IntA[k2_tiType]], [lDocID])));
end;

function GenDocIDsString(aRec : TDocIDsRec) : AnsiString;
const
 cIDKindStrings : array [TIDKind] of AnsiString =
  ('Внешний ID', 'Внутренний ID', 'Внешний ID справки', 'Внутренний ID справки');
begin
 with aRec do
  Result := Format('%s = %d',[cIDKindStrings[rIDKind], rID]);
end;


function CutDictItemName(aName : PAnsiChar) : AnsiString;
var
 lPartName : PAnsiChar;
begin
 lPartName := StrRScan(aName, #13);
 if lPartName = nil then
  Result := AnsiString(aName)
 else
  Result := AnsiString(lPartName + 1);

 Result := Trim(Result);
end;

function AttrListToDescriptorString(aList : IListDocAttribute; aSeparator : ShortString): AnsiString;
var
 I : Integer;
begin
 Result := '';
 if aList = nil then Exit;
 if aList.Count > 5 then
  Result := format('%d выбранных элементов словаря', [aList.Count])
 else
  with aList do
   for I := 0 to Pred(Count) do
   begin
    If I > 0 then Result := Result + aSeparator;
    Result := Result + CutDictItemName(ViewString[I].S);
   end;
end;

procedure LoadAttrList(aAttrSet : TdtAttributeSet; aList : Tl3StringDataList);
var
 I : Integer;
begin
 with aList do
  begin
   DataSize := Sizeof(Integer);
   NeedAllocStr := True;
   for I := 0 to High(AttrIDOrder) do
    If AttrIDOrder[I] in aAttrSet then
     DataInt[Add(PAnsiChar(GetAttrName(AttrIDOrder[I])))] := ord(AttrIDOrder[I]);
  end;
end;

procedure SetSelectOfAttrList(aList : Tl3StringDataList; aSelAttrSet : TdtAttributeSet);
var
 I : Integer;
begin
 with aList do
  for I := 0 to Pred(Count) do
   Select[I] := {not}(TdtAttribute(DataInt[I]) in aSelAttrSet);
end;

function GetSelectOfAttrList(aList : Tl3StringDataList) : TdtAttributeSet;
var
 I : Integer;
begin
 Result := [];
 with aList do
  for I := 0 to Pred(Count) do
   If {not} Select[I]
    then Include(Result, TdtAttribute(DataInt[I]));
end;

procedure SaveSelectOfAttrList(const aItemID : AnsiString; aSelAttrSet : TdtAttributeSet);
begin
 UserConfig.Section := PrefSectName;
 UserConfig.WriteParamData(aItemID, @aSelAttrSet, SizeOf(aSelAttrSet));
end;

procedure GetUserAttrList(aList : Tl3StringDataList);
begin
 LoadAttrList(RealAttrSet, aList);
end;

procedure SetHiddenAttr(aList : Tl3StringDataList);
begin
 SetSelectOfAttrList(aList, RealAttrSet - HiddenAttr);
 //HiddenAttr := RealAttrSet - HiddenAttr;
end;

procedure GetHiddenAttr(aList : Tl3StringDataList);
begin
 HiddenAttr := RealAttrSet - GetSelectOfAttrList(aList);
end;

procedure LoadHiddenAttr;
type
 PDLType = ^TdaDictionaryType;
var
 I : TdaDictionaryType;
 lDLSet : TDLTypeSet;
begin
  UserConfig.Section := PrefSectName;
 try
  UserConfig.ReadParamData('HiddenAttr2', @HiddenAttr, SizeOf(TdtAttributeSet));
 except
  // [29.09.2010] Это все для совместимомости. Через несколько месяцев, после распространения можно грохнуть
  HiddenAttr := [];
  try
   UserConfig.ReadParamData('HiddenAttr', @lDLSet, SizeOf(TDLTypeSet));
   for I := Low(TdaDictionaryType) to High(TdaDictionaryType) do
    if (I in lDLSet) and (I in  [da_dlSources .. da_dlServiceInfo]) then
    try
     Include(HiddenAttr, DLType2AttrID(I));
    except
    end;

   if TdaDictionaryType(ord(da_dlServiceInfo) + 1) in lDLSet then
    Include(HiddenAttr, atDoc2DocLink);

   if TdaDictionaryType(ord(da_dlServiceInfo) + 2) in lDLSet then
    Include(HiddenAttr, atVerLink);

   if TdaDictionaryType(ord(da_dlServiceInfo) + 3) in lDLSet then
    Include(HiddenAttr, atActiveIntervals);

   if TdaDictionaryType(ord(da_dlServiceInfo) + 4) in lDLSet then
    Include(HiddenAttr, atAlarms);

   if TdaDictionaryType(ord(da_dlServiceInfo) + 6) in lDLSet then
    Include(HiddenAttr, atVersions);

 //aidPaperWhere      = ord(High(TdaDictionaryType)) + 4;
 //aidTextInsert      = ord(High(TdaDictionaryType)) + 5;
 //aidJurOperation    = ord(High(TdaDictionaryType)) + 6;
 //aidOrdOperation    = ord(High(TdaDictionaryType)) + 7;
 //aidStages          = ord(High(TdaDictionaryType)) + 8;
 //aidVersionsList    = ord(High(TdaDictionaryType)) + 9;
 //aidDocIDs          = ord(High(TdaDictionaryType)) + 10;

  except
  end;
 end;
end;

procedure SaveHiddenAttr;
begin
 SaveSelectOfAttrList('HiddenAttr2', HiddenAttr);
end;

end.
