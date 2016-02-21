unit NOT_FINISHED_OvcBase;
 {* base class for Orpheus components. Provides controller access. }

// Модуль: "w:\common\components\rtl\external\Orpheus\NOT_FINISHED_OvcBase.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\rtl\external\Orpheus\OVC.INC}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , OvcController
;

type
 TOvcBase = class(TCustomControl)
  {* base class for Orpheus components. Provides controller access. }
  public
   Controller: TOvcController;
    {* Контроллер команд. }
 end;//TOvcBase

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TOvcBase);
 {* Регистрация TOvcBase }
{$IfEnd} // NOT Defined(NoScripts)

end.
