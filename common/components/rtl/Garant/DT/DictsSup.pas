unit DictsSup;

{ $Id: DictsSup.pas,v 1.23 2016/01/14 11:44:40 lukyanets Exp $ }

interface
 Uses
  SysUtils, Classes, Graphics,
  k2Interfaces,
  l3DatLst,

  daTypes,

  DT_Const,
  DT_Types,
  dt_AttrSchema,
  DT_Serv,
  DT_Dict,
  DT_Link,
  DT_Doc,
  DT_User,
  DT_Active,
  DT_Alarm,
  dt_DictTypes,
  l3Date,
  StDateSt;

 function GetAttrName(aAttrID : TdtAttribute) : AnsiString;
 function GetDictName(aDictID : TdaDictionaryType) : AnsiString;
 //function GetAttrType(aAttrID : TdtAttribute) : TAttrType;
 function GetDictNameLength(aAttrID : TdaDictionaryType) : integer;
 function GetAssGroupName(piAssGroupID : integer) : AnsiString;
 function GetAssMaskStr(aMask : Longint) : AnsiString;
 function GetAttrStructSize(aAttrID : TdtAttribute) : Integer;
 function GetAttrLogType(aAttrID : TdtAttribute; out aLogAction : TLogActionType) : Boolean;

 function GenIssueString(var aRec : TPublishedDictRec) : AnsiString;

 //function GetDNTypeName(aDNType : TDNType) : AnsiString;
 //procedure GetDNTypeList(aLst : TStrings);
 function GetLogJrnlName(aAction : TLogActionType): AnsiString;

 //function GenDateDiapasonString(aDateBounds : Tl3DateBounds) : AnsiString;

 //procedure GetDictItemBitmap(aAttrID : TdtAttribute; var ItemBMP: TBitmap);
 //procedure GetDictBitmap(aAttrID : TdtAttribute; var ItemBMP : TBitmap);
 function  GetDictItemImageIndex(aDictID : TdaDictionaryType) : integer;
 function  GetDictImageIndex(aDictID : TdaDictionaryType) : integer;

 function  AttributeIDToJournalAction(aAttrID : TdtAttribute) : TLogActionType;
 function  DictIDToJournalAction(aAttrID : TdaDictionaryType) : TLogActionType;

 function IsLegalAttr(aDocType : TDocType; aAttrID : TdtAttribute) : Boolean;

 function MakeDateNumRec(aDate : TStDate; const aNum : AnsiString; aTyp : TDNType; aLDocID  : TDocID = 0; aLSubID  : TSubID = 0) : TDNDictRec;
 function MakeActiveIntervalRec(aStart, aFinish  : TStDate; const aComment : AnsiString = '') : TActiveIntervalRec;


function GetDictExtParams(aAttrID : TdaDictionaryType) : TDictExtParams;
function GetDictExtNeedFillParams(aAttrID : TdaDictionaryType) : TDictExtParams;

resourcestring
 rsCorSourcesDefItem = '[Получено по рассылке]';

implementation

uses
  l3Base,
  l3String,
  l3DateSt,
  l3Bits,
  l3IniFile,

  daInterfaces,

  k2Tags,
  Com_Cnst,
  ResShop,
  dt_DictConst,
  dt_LinkServ;

function IsLegalAttr(aDocType : TDocType; aAttrID : TdtAttribute) : Boolean;
begin
 Case aDocType of
  DT_Types.dtText    : Result := aAttrID in GlMainAttrSet + GlSubAttrSet;
  DT_Types.dtObject  : Result := aAttrID in GlMainAttrSetForObject;
  else                 Result := False;
 end;
end;

function GenIssueString(var aRec : TPublishedDictRec) : AnsiString;
var
// D1, M1, Y1,
// D2, M2, Y2 : Integer;
 CStr       : AnsiString;
begin
 Result := '';
 with aRec do
  begin
   (*
   try
    If Sour > 0 then
     Result := DictServer.DictTbl[da_dlCorSources].GetNameStr(Sour);
   except
   end;
   *)

   if SDate <> BlankDate then
    Result := Result + MakeHRDateIntervalStr(SDate, EDate);
    (*
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
   *)

   CStr := l3ArrayToString(Num, SizeOf(Num));
   if Length(CStr) > 0 then Result := Result + Format(' №%S', [CStr]);

   CStr := l3ArrayToString(Comment, SizeOf(Comment));
   If Length(CStr) > 0 then Result := Result + ' (' + CStr + ')';
  end;
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
 CheckGroup(acgAccGroup,  'Группы документов');
 Result := l_Res;
 //If piAssGroupID = romDocGroup then Result := 'Группы документов';
end;

function GetLogJrnlName(aAction : TLogActionType) : AnsiString;
begin
 case aAction of
  //acRevision,
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
  acScriptHadled_AddPublInfo : Result := 'Обработка скриптом "Информация об опубликовании"';
  else                Result := '?';
 end;
end;

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
  da_dlSources     : Result := 195;
  da_dlTypes       : Result := 56;
  da_dlClasses     : Result := 95;
  da_dlNewClasses_Deprecated  :
     Assert(False, 'Deprecated dlNewClasses');
  //Result := 95;
  da_dlPrefixes    : Result := 79;
  da_dlKeyWords    : Result := 99;
  da_dlBases       : Result := 79;
  //aidDateNums    : Result := 0;
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

function GetDictImageIndex(aDictID : TdaDictionaryType) : integer;
begin
 case aDictID of
  da_dlSources     : Result := picDicPublisher;
  da_dlTypes       : Result := picDicDocType;
  da_dlClasses     : Result := picDicTree;
  da_dlNewClasses_Deprecated  :
     Assert(False, 'Deprecated dlNewClasses');
  da_dlPrefixes    : Result := picDicTree;
  da_dlKeyWords    : Result := picDicKey;
  da_dlBases       : Result := picDicDocGroup;
  da_dlDateNums    : Result := -1;
  da_dlWarnings    : Result := picDicWarning;
  da_dlCorrects    : Result := picSrcCheck;
  da_dlCorSources  : Result := picPublishSrc;
  da_dlTerritories : Result := picTerritory;
  da_dlTextInsert  : Result := picTextInsert;
  else             Result := picDicTree;
 end;
end;
{
procedure GetDictBitmap(aAttrID : TdtAttribute; var ItemBMP : TBitmap);
begin
 ItemBMP := GetDocBMP(GetDictImageIndex(aAttrID));
end;

procedure GetDictItemBitmap(aAttrID : TdtAttribute; var ItemBMP: TBitmap);
begin
 ItemBMP := GetDocBMP(GetDictItemImageIndex(aAttrID));
end;
}

function GetDictItemImageIndex(aDictID : TdaDictionaryType) : integer;
begin
 case aDictID of
   da_dlTypes       : Result := picBlueBall;
   da_dlClasses     : Result := picDiamond;
   da_dlPrefixes    : Result := picDiamond;
   da_dlKeyWords    : Result := picKey;
   da_dlWarnings    : Result := picWarning;
   da_dlCorrects    : Result := picSrcCheck;
   da_dlCorSources  : Result := picPublishSrc;
   else             Result := picDiamond;
  end;
end;

function  AttributeIDToJournalAction(aAttrID : TdtAttribute) : TLogActionType;
begin
 case aAttrID of
  atClasses,
  atPrefixes    : Result := acClassWork;
  atKeyWords    : Result := acKWWork;
 else
  Result := acAttrWork;
 end;
end;

function  DictIDToJournalAction(aAttrID : TdaDictionaryType) : TLogActionType;
begin
 case aAttrID of
  da_dlClasses,
  da_dlPrefixes    : Result := acClassWork;
  da_dlKeyWords    : Result := acKWWork;
 else
  Result := acAttrWork;
 end;
end;

function MakeActiveIntervalRec(aStart, aFinish  : TStDate; const aComment : AnsiString = '') : TActiveIntervalRec;
begin
 with Result do
 begin
  RecID := 0;
  Typ := 0;

  if aStart > 0 then
   Start := aStart
  else
   Start := minActiveDate;

  if aFinish > 0 then
   Finish := aFinish
  else
   Finish := maxActiveDate;

  l3StringToArray(Comment, SizeOf(Comment), aComment);
 end;
end;

function MakeDateNumRec(aDate : TStDate; const aNum : AnsiString; aTyp : TDNType; aLDocID  : TDocID = 0; aLSubID  : TSubID = 0) : TDNDictRec;
begin
 with Result do
 begin
  ID := cUndefDictID;
  Date := aDate;
  Typ  := aTyp;
  LDocID := aLDocID;
  {$IF c_DocBaseVersion > 133}
  LSubID  := aLSubID;
  {$IFEND}

  l3StringToArray(Num, SizeOf(Num), aNum);
 end;
end;

function GetDictExtParams(aAttrID : TdaDictionaryType) : TDictExtParams;
begin
 Result := [];
 if aAttrID in GlAttrWithCodeSet then
  Result := Result + [depCode];

 if aAttrID in GlAttrWithPrivateSet then
  Result := Result + [depPrivate];

 if (aAttrID in GlAttrWithNonPeriodicSet) {and (GlobalDataProvider.AdminRights)} then
  Result := Result + [depNonPeriodic];

 if (aAttrID in GlAttrWithIDEdit) then
  Result := Result + [depID]; 
end;

function GetDictExtNeedFillParams(aAttrID : TdaDictionaryType) : TDictExtParams;
begin
 Result := [];
 if aAttrID in GlAttrCodeNeedFillSet then
  Result := Result + [depCode];
 {if aAttrID in GlAttrWithPrivateSet then
  Result := Result + [depPrivate];
 }
end;

end.
