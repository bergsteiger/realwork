unit NOT_FINISHED_D_WizIzm;

// ������: "w:\archi\source\projects\Archi\Dlg\NOT_FINISHED_D_WizIzm.pas"
// ���������: "UtilityPack"

{$Include arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , TabBBtnDlg
;

type
 TIzmWizardDlg = class(TTabBBtnDlg)
 end;//TIzmWizardDlg
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppClientSide)

end.
