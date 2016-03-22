unit DtSupport;

interface
 uses
  daTypes,
  DT_Const, DT_Types, DT_Serv,  DT_User,
  dt_AttrSchema;

 const
  { - special access group index}
  agNotIncluded = 1;
  agIncluded    = 2;
  agDictions    = 3;
  agStages      = 4;

  { - access right for dict (bit number) }
  agDictOrdinary = 0;
  agDictClass    = 1;
//  agDictNewClass_Deprecated = 2;
  agDictKW       = 3;
  agPublished    = 4;

 function dsStagesAccessMask: TTblMask;

 function GlobalCoord( aFamily : TFamilyID;
                       aDoc    : TDocID;
                       aSub    : TSubID) : TGlobalCoordinateRec; overload;

 function GlobalCoord(aDoc    : TDocID;
                      aSub    : TSubID) : TGlobalCoordinateRec;  overload;

 function dsGetCurrentUserName : String;

 function dsIsAllowEditDict(aDictID : TdaDictionaryType) : Boolean;

implementation
Uses
 l3Bits,
 daDataProvider,
 daSchemeConsts,
 dt_Acces;

function dsIsAllowEditDict(aDictID : TdaDictionaryType) : Boolean;
var
 l_Mask: Longint;
begin
 l_Mask:= AccessServer[CurrentFamily, agDictions] xor AccessServer.NonEditableDicts;

  case aDictID of
  da_dlClasses :
   Result := l3TestBit(l_Mask, agDictClass);
  da_dlKeyWords :
   Result := l3TestBit(l_Mask, agDictKW);
  da_dlCorSources,
  da_dlPublisheds :
   Result := l3TestBit(l_Mask, agPublished);
  else
   Result := l3TestBit(l_Mask, agDictOrdinary);
 end;
end;

function dsGetCurrentUserName : String;
 var
  ltmpLoginName : ShortString;
  ltmpActFlag   : Byte;
  lUserName     : ShortString;
 begin
  UserManager.GetUserInfo(GlobalDataProvider.UserID, lUserName, ltmpLoginName, ltmpActFlag);
  Result := lUserName;
 end;

function GlobalCoord( aFamily : TFamilyID;
                      aDoc    : TDocID;
                      aSub    : TSubID) : TGlobalCoordinateRec;
begin
 with Result do
 begin
  Family := aFamily;
  Doc    := aDoc;
  Sub    := aSub;
 end;
end;

function GlobalCoord(aDoc    : TDocID;
                     aSub    : TSubID) : TGlobalCoordinateRec;
begin
 Result := GlobalCoord(0, aDoc, aSub);
end;

function dsStagesAccessMask: TTblMask;
begin
 Result := AccessServer[CurrentFamily, agStages];
end;



end.
