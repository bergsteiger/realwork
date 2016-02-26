unit NOT_FINISHED_D_WizChangeDoc;

// Модуль: "w:\archi\source\projects\Archi\Dlg\NOT_FINISHED_D_WizChangeDoc.pas"
// Стереотип: "UtilityPack"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , BottomBtnDlg
;

type
 TChangeDocWizardDlg = class(TBottomBtnDlg)
 end;//TChangeDocWizardDlg
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppClientSide)

end.
