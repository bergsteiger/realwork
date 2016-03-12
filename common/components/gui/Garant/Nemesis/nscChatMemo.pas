unit nscChatMemo;
 {* Мемо-поле для чата F1 }

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscChatMemo.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , nscCustomChatMemo
;

type
 //#UC START# *4A8A8739017Dci*
 //#UC END# *4A8A8739017Dci*
 //#UC START# *4A8A8739017Dcit*
 //#UC END# *4A8A8739017Dcit*
 TnscChatMemo = class(TnscCustomChatMemo)
  {* Мемо-поле для чата F1 }
 //#UC START# *4A8A8739017Dpubl*
  published
    property PopupMenu;
 //#UC END# *4A8A8739017Dpubl*
 end;//TnscChatMemo
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

//#UC START# *4A8A8739017Dimpl*
//#UC END# *4A8A8739017Dimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscChatMemo);
 {* Регистрация TnscChatMemo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
