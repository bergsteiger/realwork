{$IfNDef SystemWord_imp}

// ������: "w:\common\components\rtl\Garant\ScriptEngine\SystemWord.imp.pas"
// ���������: "Impurity"
// ������� ������: "SystemWord" MUID: (4DB95922039B)
// ��� ����: "_SystemWord_"

{$Define SystemWord_imp}

{$If NOT Defined(NoScripts)}
 _SystemWord_ = {abstract} class(_SystemWord_Parent_)
 end;//_SystemWord_

{$Else NOT Defined(NoScripts)}

_SystemWord_ = _SystemWord_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else SystemWord_imp}

{$IfNDef SystemWord_imp_impl}

{$Define SystemWord_imp_impl}

{$If NOT Defined(NoScripts)}
{$IfEnd} // NOT Defined(NoScripts)
{$EndIf SystemWord_imp_impl}

{$EndIf SystemWord_imp}

