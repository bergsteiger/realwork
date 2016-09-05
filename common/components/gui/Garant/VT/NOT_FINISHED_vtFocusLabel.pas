unit NOT_FINISHED_vtFocusLabel;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtFocusLabel.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtFocusLabel" MUID: (4A9B9BC00258)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , afwTextControl
;

type
 TvtFocusLabel = class(TafwTextControl)
  protected
   function NeedUnderLine: Boolean; virtual;
   function AllowClickByKeyBoard: Boolean; virtual;
   function AllowTranslateReturn: Boolean; virtual;
 end;//TvtFocusLabel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4A9B9BC00258impl_uses*
 //#UC END# *4A9B9BC00258impl_uses*
;

function TvtFocusLabel.NeedUnderLine: Boolean;
//#UC START# *4B61371503B9_4A9B9BC00258_var*
//#UC END# *4B61371503B9_4A9B9BC00258_var*
begin
//#UC START# *4B61371503B9_4A9B9BC00258_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B61371503B9_4A9B9BC00258_impl*
end;//TvtFocusLabel.NeedUnderLine

function TvtFocusLabel.AllowClickByKeyBoard: Boolean;
//#UC START# *4C03EAA20362_4A9B9BC00258_var*
//#UC END# *4C03EAA20362_4A9B9BC00258_var*
begin
//#UC START# *4C03EAA20362_4A9B9BC00258_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C03EAA20362_4A9B9BC00258_impl*
end;//TvtFocusLabel.AllowClickByKeyBoard

function TvtFocusLabel.AllowTranslateReturn: Boolean;
//#UC START# *4C03EAB40015_4A9B9BC00258_var*
//#UC END# *4C03EAB40015_4A9B9BC00258_var*
begin
//#UC START# *4C03EAB40015_4A9B9BC00258_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C03EAB40015_4A9B9BC00258_impl*
end;//TvtFocusLabel.AllowTranslateReturn

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtFocusLabel);
 {* Регистрация TvtFocusLabel }
{$IfEnd} // NOT Defined(NoScripts)

end.
