unit moToolbarMenu;
 {* Настройка системы }

// Модуль: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\moToolbarMenu.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "ToolbarMenu" MUID: (4C8E34280227)
// Имя типа: "Tmo_ToolbarMenu"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimToolbarMenu_Module
;

type
 Tmo_ToolbarMenu = {final} class(TPrimToolbarMenuModule)
  {* Настройка системы }
 end;//Tmo_ToolbarMenu
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
