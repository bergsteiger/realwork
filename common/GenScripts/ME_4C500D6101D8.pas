{$IfNDef CursorMover_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "CursorMover" MUID: (4C500D6101D8)
// Имя типа: "_CursorMover_"

{$Define CursorMover_imp}

{$If NOT Defined(NoScripts)}
 _CursorMover_ = class(_CursorMover_Parent_)
  {* Примесь упрощающая навигацию по редактору при помощи управления курсором }
 end;//_CursorMover_

{$Else NOT Defined(NoScripts)}

_CursorMover_ = _CursorMover_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else CursorMover_imp}

{$IfNDef CursorMover_imp_impl}

{$Define CursorMover_imp_impl}

{$If NOT Defined(NoScripts)}
{$IfEnd} // NOT Defined(NoScripts)
{$EndIf CursorMover_imp_impl}

{$EndIf CursorMover_imp}

