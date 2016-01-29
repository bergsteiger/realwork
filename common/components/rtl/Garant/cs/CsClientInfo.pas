unit CsClientInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/CsClientInfo.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Clients::TCsClientInfo
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
  CsObject,
  CsCommon
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TCsClientInfo = class(TCsObject)
 public
 // public fields
   ClientId : TCsClientId;
   LoginName : AnsiString;
   ListenIp : TCsIp;
   ListenPort : TCsPort;
   UID : LongInt;
   LastPing : TDateTime;
 end;//TCsClientInfo
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}


{$IfEnd} //not Nemesis
end.