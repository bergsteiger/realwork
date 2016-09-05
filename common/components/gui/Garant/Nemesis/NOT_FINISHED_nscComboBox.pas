unit NOT_FINISHED_nscComboBox;

// Модуль: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nscComboBox.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscComboBox" MUID: (4AC63691012B)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , vtComboTree
;

type
 TnscEdit = class;

 TnscEditWithoutPlusMinusShortcut = class;

 TnscComboBoxWithPwdChar = class;

 TnscComboBox = class(TvtComboTree)
 end;//TnscComboBox

 TnscEdit = class(TnscComboBox)
 end;//TnscEdit

 TnscEditWithoutPlusMinusShortcut = class(TnscEdit)
 end;//TnscEditWithoutPlusMinusShortcut

 TnscComboBoxWithPwdChar = class(TnscEdit)
 end;//TnscComboBoxWithPwdChar
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4AC63691012Bimpl_uses*
 //#UC END# *4AC63691012Bimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscComboBox);
 {* Регистрация TnscComboBox }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscEdit);
 {* Регистрация TnscEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscEditWithoutPlusMinusShortcut);
 {* Регистрация TnscEditWithoutPlusMinusShortcut }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
 {* Регистрация TnscComboBoxWithPwdChar }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
