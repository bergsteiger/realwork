unit NOT_FINISHED_vtSpinEdit;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtSpinEdit.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtSpinEdit" MUID: (4C52C0600246)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
;

type
 TvtSpinEdit = class
 end;//TvtSpinEdit

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SpinEditWordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtSpinEdit);
 {* Регистрация TvtSpinEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
