unit moToolbarMenu;
 {* ��������� ������� }

// ������: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\moToolbarMenu.pas"
// ���������: "VCMFormsPack"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimToolbarMenu_Module
;

type
 Tmo_ToolbarMenu = {final} class(TPrimToolbarMenuModule)
  {* ��������� ������� }
 end;//Tmo_ToolbarMenu
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
