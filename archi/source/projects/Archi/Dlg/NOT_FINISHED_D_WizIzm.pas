unit NOT_FINISHED_D_WizIzm;

// Модуль: "w:\archi\source\projects\Archi\Dlg\NOT_FINISHED_D_WizIzm.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "D_WizIzm" MUID: (4E4B61FC00CF)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

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
 //#UC START# *4E4B61FC00CFimpl_uses*
 //#UC END# *4E4B61FC00CFimpl_uses*
;
{$IfEnd} // Defined(AppClientSide)

end.
