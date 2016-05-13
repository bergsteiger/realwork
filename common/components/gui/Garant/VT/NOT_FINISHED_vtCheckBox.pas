unit NOT_FINISHED_vtCheckBox;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtCheckBox.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtCheckBox" MUID: (5179419B01DA)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , eeCheckBox
;

type
 _vtUnicodeButtonControl_Parent_ = TeeCheckBox;
 {$Include w:\common\components\gui\Garant\VT\vtUnicodeButtonControl.imp.pas}
 TvtCheckBox = class(_vtUnicodeButtonControl_)
 end;//TvtCheckBox

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$Include w:\common\components\gui\Garant\VT\vtUnicodeButtonControl.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCheckBox);
 {* Регистрация TvtCheckBox }
{$IfEnd} // NOT Defined(NoScripts)

end.
