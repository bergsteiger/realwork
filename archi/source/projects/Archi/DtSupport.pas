unit DtSupport;

interface
 uses
  daTypes,
  DT_Const, DT_Types, DT_Serv,  
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
  ltmpLoginName : String;
  ltmpActFlag   : Byte;
  lUserName     : String;
 begin
  GlobalDataProvider.UserManager.GetUserInfo(GlobalDataProvider.UserID, lUserName, ltmpLoginName, ltmpActFlag);
  Result := lUserName;
 end;

function dsStagesAccessMask: TTblMask;
begin
 Result := AccessServer[CurrentFamily, agStages];
end;



end.
