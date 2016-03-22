unit NOT_FINISHED_d_GetContents;

// Модуль: "w:\archi\source\projects\Archi\Dlg\NOT_FINISHED_d_GetContents.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "d_GetContents" MUID: (4ECB874E0247)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , BottomBtnDlg
;

type
 TContentsEditDlg = class(TBottomBtnDlg)
 end;//TContentsEditDlg

procedure RequestContents;
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
;

procedure RequestContents;
//#UC START# *4ECB87E20367_4ECB874E0247_var*
//#UC END# *4ECB87E20367_4ECB874E0247_var*
begin
//#UC START# *4ECB87E20367_4ECB874E0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ECB87E20367_4ECB874E0247_impl*
end;//RequestContents
{$IfEnd} // Defined(AppClientSide)

end.
