unit NOT_FINISHED_TabBBtnDlg;

// ������: "w:\archi\source\projects\Archi\MetaForms\NOT_FINISHED_TabBBtnDlg.pas"
// ���������: "SimpleClass"

{$Include arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , BtnDlg
;

type
 TTabBBtnDlg = class(TBtnDlg)
 end;//TTabBBtnDlg
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppClientSide)

end.
