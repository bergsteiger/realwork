{$IfNDef ScrollSupport_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\EditorUsers\ScrollSupport.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "ScrollSupport" MUID: (4CE2958803D0)
// Имя типа: "_ScrollSupport_"

{$Define ScrollSupport_imp}

{$If NOT Defined(NoScripts)}
 _ScrollSupport_ = class(_ScrollSupport_Parent_)
 end;//_ScrollSupport_

{$Else NOT Defined(NoScripts)}

_ScrollSupport_ = _ScrollSupport_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else ScrollSupport_imp}

{$IfNDef ScrollSupport_imp_impl}

{$Define ScrollSupport_imp_impl}

{$If NOT Defined(NoScripts)}
{$IfEnd} // NOT Defined(NoScripts)
{$EndIf ScrollSupport_imp_impl}

{$EndIf ScrollSupport_imp}

