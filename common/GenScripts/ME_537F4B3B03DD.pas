unit CsClientInfo;

// Модуль: "w:\common\components\rtl\Garant\cs\CsClientInfo.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsObject
 , CsCommon
;

type
 TCsClientInfo = class(TCsObject)
  public
   ClientId: TCsClientId;
   LoginName: AnsiString;
   ListenIp: TCsIp;
   ListenPort: TCsPort;
   UID: LongInt;
   LastPing: TDateTime;
 end;//TCsClientInfo
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
