unit CsCommon;

interface

uses
 l3IntfUses
 , IdGlobal
 , daTypes
 , daDataProviderParams
;

type
 TCsPort = TIdPort;
 
 TCsClientId = TdaUserID;
 
 TCsIp = AnsiString;
  {* заменить на ченить поприличней }
 
 TcsError = Integer;
 
 TcsLoginExDataEvent = procedure(out aDataParams: TdaDataProviderParams;
  out TheFlags: TdaBaseFlags) of object;
 
 TcsUserConnectKind = (
  cs_uckRegular
   {*  оннект с обычными правами }
  , cs_uckDeveloper
   {*  оннект на залоченную базу и пр. }
  , cs_uckRequireAdminRights
 );//TcsUserConnectKind
 
 TcsConnectResult = (
  cs_crOk
  , cs_crNetworkError
  , cs_crUserParamsWrong
  , cs_crDuplicateClient
  , cs_crDeadClient
  , cs_crBaseLocked
  , cs_crInsufficientRights
 );//TcsConnectResult
 
 TcsGetIsBaseLockedEvent = procedure(out theIsLocked: Boolean) of object;
 
implementation

uses
 l3ImplUses
;

end.
