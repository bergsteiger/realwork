{$IfNDef VCMWord_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "VCMWord" MUID: (4DB94A660083)
// Имя типа: "_VCMWord_"

{$Define VCMWord_imp}

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 _VCMWord_ = {abstract} class(_VCMWord_Parent_)
 end;//_VCMWord_

{$Else NOT Defined(NoScripts) AND NOT Defined(NoVCM)}

_VCMWord_ = _VCMWord_Parent_;

{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
{$Else VCMWord_imp}

{$IfNDef VCMWord_imp_impl}

{$Define VCMWord_imp_impl}

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
{$EndIf VCMWord_imp_impl}

{$EndIf VCMWord_imp}

