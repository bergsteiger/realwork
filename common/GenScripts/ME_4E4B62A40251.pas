unit NOT_FINISHED_BottomBtnDlg;

// Модуль: "w:\archi\source\projects\Archi\MetaForms\NOT_FINISHED_BottomBtnDlg.pas"
// Стереотип: "SimpleClass"

{$Include arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , BtnDlg
;

type
 TBottomBtnDlg = class(TBtnDlg)
 end;//TBottomBtnDlg
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppClientSide)

end.
