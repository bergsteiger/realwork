unit CsClientInfo;

// Модуль: "w:\common\components\rtl\Garant\cs\CsClientInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TCsClientInfo" MUID: (537F4B3B03DD)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsObject
 , CsCommon
;

type
 TCsClientInfo = class(TCsObject)
  private
   f_ClientId: TCsClientId;
  public
   LoginName: AnsiString;
   ListenIp: TCsIp;
   ListenPort: TCsPort;
   UID: LongInt;
   LastPing: TDateTime;
  public
   property ClientId: TCsClientId
    read f_ClientId
    write f_ClientId;
 end;//TCsClientInfo
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
