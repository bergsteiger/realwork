unit afwControl;
 {* Базовый класс для управляющих элементов }

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwControl.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , afwBaseControl
;

type
 TafwControl = class(TafwBaseControl)
  {* Базовый класс для управляющих элементов }
 end;//TafwControl

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TafwControl);
 {* Регистрация TafwControl }
{$IfEnd} // NOT Defined(NoScripts)

end.
