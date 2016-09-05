unit NOT_FINISHED_eeShortCutEdit;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\NOT_FINISHED_eeShortCutEdit.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TeeShortCutEdit" MUID: (549067A702BE)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TeeShortCutEdit = class
 end;//TeeShortCutEdit
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *549067A702BEimpl_uses*
 //#UC END# *549067A702BEimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeShortCutEdit);
 {* Регистрация TeeShortCutEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
