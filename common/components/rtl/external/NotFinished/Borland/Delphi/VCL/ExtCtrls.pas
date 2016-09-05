unit ExtCtrls;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\ExtCtrls.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ExtCtrls" MUID: (48C7C95C0221)

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Controls
;

type
 TTimer = class
 end;//TTimer

 TPaintBox = class
 end;//TPaintBox

 TCustomPanel = class(TCustomControl)
 end;//TCustomPanel

 TPanel = class(TCustomPanel)
 end;//TPanel

 TRadioGroup = class
 end;//TRadioGroup

 TPanelBevel = TBevelCut;

 TImage = class
 end;//TImage

 TBevel = class
 end;//TBevel
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , PanelProcessingPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , RadioGroupWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *48C7C95C0221impl_uses*
 //#UC END# *48C7C95C0221impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomPanel);
 {* Регистрация TCustomPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPanel);
 {* Регистрация TPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
