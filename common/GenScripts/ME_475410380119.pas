unit NOT_FINISHED_OvcBase;
 {* base class for Orpheus components. Provides controller access. }

// ������: "w:\common\components\rtl\external\Orpheus\NOT_FINISHED_OvcBase.pas"
// ���������: "GuiControl"
// ������� ������: "TOvcBase" MUID: (475410380119)

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
 TOvcBase = class({$If NOT Defined(NoVCL)}
 TCustomControl
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* base class for Orpheus components. Provides controller access. }
  public
   Controller: TOvcController;
    {* ���������� ������. }
 end;//TOvcBase

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCL)}
initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TOvcBase);
 {* ����������� TOvcBase }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
