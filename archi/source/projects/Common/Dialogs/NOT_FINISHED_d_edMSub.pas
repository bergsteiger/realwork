unit NOT_FINISHED_d_edMSub;

// ������: "w:\archi\source\projects\Common\Dialogs\NOT_FINISHED_d_edMSub.pas"
// ���������: "UtilityPack"
// ������� ������: "d_edMSub" MUID: (4DFB50900299)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
;

type
 TNewSubDlg = class
  {* ������ �������������� ����. }
 end;//TNewSubDlg

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TNewSubDlgWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4DFB50900299impl_uses*
 //#UC END# *4DFB50900299impl_uses*
;

end.
