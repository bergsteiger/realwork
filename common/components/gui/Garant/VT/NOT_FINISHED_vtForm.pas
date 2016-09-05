unit NOT_FINISHED_vtForm;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtForm.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vtForm" MUID: (4F0C23870303)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , l3Forms
;

type
 TvtForm = class(Tl3Form)
 end;//TvtForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4F0C23870303impl_uses*
 //#UC END# *4F0C23870303impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtForm);
 {* Регистрация TvtForm }
{$IfEnd} // NOT Defined(NoScripts)

end.
