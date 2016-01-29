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
  {* �������� �� ������ ����������� }
 
 TcsError = Integer;
 
 TcsLoginExDataEvent = procedure(out aDataParams: TdaDataProviderParams;
  out TheFlags: TdaBaseFlags) of object;
 
 TcsUserConnectKind = (
  cs_uckRegular
   {* ������� � �������� ������� }
  , cs_uckDeveloper
   {* ������� �� ���������� ���� � ��. }
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
