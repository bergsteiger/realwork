{$IfNDef kwSendInputSupportUses_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwSendInputSupportUses.imp.pas"
// Стереотип: "Impurity"

{$Define kwSendInputSupportUses_imp}

{$If NOT Defined(NoScripts)}
 _kwSendInputSupportUses_ = {abstract} class(_kwSendInputSupportUses_Parent_)
 end;//_kwSendInputSupportUses_

{$Else NOT Defined(NoScripts)}

_kwSendInputSupportUses_ = _kwSendInputSupportUses_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else kwSendInputSupportUses_imp}

{$IfNDef kwSendInputSupportUses_imp_impl}

{$Define kwSendInputSupportUses_imp_impl}

{$If NOT Defined(NoScripts)}
{$IfEnd} // NOT Defined(NoScripts)
{$EndIf kwSendInputSupportUses_imp_impl}

{$EndIf kwSendInputSupportUses_imp}

