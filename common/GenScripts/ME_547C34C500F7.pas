unit nscMessagesReg;

// Модуль: "w:\common\components\rtl\Garant\cs\nscMessagesReg.pas"
// Стереотип: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
;

procedure ncsServerRegister;
procedure ncsClientRegister;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ncsMessageFactory
 , ncsMessage
;

procedure ncsServerRegister;
//#UC START# *547C34E902C1_547C34C500F7_var*
//#UC END# *547C34E902C1_547C34C500F7_var*
begin
//#UC START# *547C34E902C1_547C34C500F7_impl*
 TncsMessageFactory.Instance.Register(TncsDIsconnect);
//#UC END# *547C34E902C1_547C34C500F7_impl*
end;//ncsServerRegister

procedure ncsClientRegister;
//#UC START# *547C350000AA_547C34C500F7_var*
//#UC END# *547C350000AA_547C34C500F7_var*
begin
//#UC START# *547C350000AA_547C34C500F7_impl*
 TncsMessageFactory.Instance.Register(TncsDIsconnectReply);
//#UC END# *547C350000AA_547C34C500F7_impl*
end;//ncsClientRegister
{$IfEnd} // NOT Defined(Nemesis)

end.
