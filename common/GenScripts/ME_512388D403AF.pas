unit NOT_FINISHED_nscLister;

// ������: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nscLister.pas"
// ���������: "GuiControl"
// ������� ������: "TnscLister" MUID: (512388D403AF)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TnscLister = class
 end;//TnscLister
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscLister);
 {* ����������� TnscLister }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
