unit NOT_FINISHED_d_edMSub;

// ������: "w:\archi\source\projects\Common\Dialogs\NOT_FINISHED_d_edMSub.pas"
// ���������: "UtilityPack"

{$Include arCommon.inc}

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
;

end.
