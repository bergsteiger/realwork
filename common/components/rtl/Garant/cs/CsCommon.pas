unit CsCommon;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/CsCommon.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Core::CsCommon
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  IdGlobal,
  daTypes,
  daDataProviderParams
  ;

type
 TCsPort = IdGlobal.TIdPort;

 TCsClientId = daTypes.TdaUserID;

 TCsIp = System.AnsiString;
  {* заменить на ченить поприличней }

 TcsError = System.Integer;

 TcsLoginExDataEvent = procedure (out aDataParams: TdaDataProviderParams;
  out TheFlags: TdaBaseFlags) of object;

 TcsUserConnectKind = (
   cs_uckRegular // Коннект с обычными правами
 , cs_uckDeveloper // Коннект на залоченную базу и пр.
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

 TcsGetIsBaseLockedEvent = procedure (out theIsLocked: Boolean) of object;
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.