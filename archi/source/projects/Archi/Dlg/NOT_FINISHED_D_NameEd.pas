unit NOT_FINISHED_D_NameEd;

// ������: "w:\archi\source\projects\Archi\Dlg\NOT_FINISHED_D_NameEd.pas"
// ���������: "UtilityPack"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , BottomBtnDlg
;

type
 TNameEditDlg = class(TBottomBtnDlg)
 end;//TNameEditDlg
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppClientSide)

end.
