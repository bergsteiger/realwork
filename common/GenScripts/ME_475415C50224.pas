unit NOT_FINISHED_OvcController;
 {* ���������� ������. }

// ������: "w:\common\components\rtl\external\Orpheus\NOT_FINISHED_OvcController.pas"
// ���������: "SimpleClass"
// ������� ������: "TOvcController" MUID: (475415C50224)

{$Include w:\common\components\rtl\external\Orpheus\OVC.INC}

interface

uses
 l3IntfUses
 , l3InterfacedComponent
;

type
 TOvcController = class(Tl3InterfacedComponent)
  {* ���������� ������. }
 end;//TOvcController

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TOvcController);
 {* ����������� TOvcController }
{$IfEnd} // NOT Defined(NoScripts)

end.
