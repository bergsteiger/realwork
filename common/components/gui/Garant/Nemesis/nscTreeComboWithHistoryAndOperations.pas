unit nscTreeComboWithHistoryAndOperations;

// ������: "w:\common\components\gui\Garant\Nemesis\nscTreeComboWithHistoryAndOperations.pas"
// ���������: "GuiControl"
// ������� ������: "TnscTreeComboWithHistoryAndOperations" MUID: (4CF4D14700AE)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , nscTreeComboWithHistory
;

type
 TnscTreeComboWithHistoryAndOperations = class(TnscTreeComboWithHistory)
 end;//TnscTreeComboWithHistoryAndOperations
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4CF4D14700AEimpl_uses*
 //#UC END# *4CF4D14700AEimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscTreeComboWithHistoryAndOperations);
 {* ����������� TnscTreeComboWithHistoryAndOperations }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
