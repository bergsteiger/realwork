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
    {* Поле для свойства ClientId }
  public
   LoginName: AnsiString;
   ListenIp: TCsIp;
   ListenPort: TCsPort;
   UID: LongInt;
   LastPing: TDateTime;
  protected
   procedure pm_SetClientId(aValue: TCsClientId); virtual;
  public
   property ClientId: TCsClientId
    read f_ClientId
    write pm_SetClientId;
 end;//TCsClientInfo
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
;

procedure TCsClientInfo.pm_SetClientId(aValue: TCsClientId);
//#UC START# *537F4B9A00F1_537F4B3B03DDset_var*
//#UC END# *537F4B9A00F1_537F4B3B03DDset_var*
begin
//#UC START# *537F4B9A00F1_537F4B3B03DDset_impl*
 f_ClientId := aValue;
 if aValue = 0 then
   l3System.Stack2Log('Strange User = 0');
//#UC END# *537F4B9A00F1_537F4B3B03DDset_impl*
end;//TCsClientInfo.pm_SetClientId
{$IfEnd} // NOT Defined(Nemesis)

end.
