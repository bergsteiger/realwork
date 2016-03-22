unit vcmMenuManagerUtils;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuManagerUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmMenuManagerUtils" MUID: (52AB0A3703E2)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure RequestClearPopup(aPopup: TPopupMenu);
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 , vcmMessages
;

procedure RequestClearPopup(aPopup: TPopupMenu);
//#UC START# *52AB0A580216_52AB0A3703E2_var*
//#UC END# *52AB0A580216_52AB0A3703E2_var*
begin
//#UC START# *52AB0A580216_52AB0A3703E2_impl*
 if (Application.MainForm <> nil) then
  PostMessage(Application.MainForm.Handle, vcm_msgClearPopup, 0, LParam(aPopup));
//#UC END# *52AB0A580216_52AB0A3703E2_impl*
end;//RequestClearPopup
{$IfEnd} // NOT Defined(NoVCM)

end.
