unit NOT_FINISHED_D_WizChangeDoc;

// Модуль: "w:\archi\source\projects\Archi\Dlg\NOT_FINISHED_D_WizChangeDoc.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "D_WizChangeDoc" MUID: (4E4B61CC0291)

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
 //#UC START# *4E4B61CC0291impl_uses*
 //#UC END# *4E4B61CC0291impl_uses*
;
{$IfEnd} // Defined(AppClientSide)

end.
