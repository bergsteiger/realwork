{$IfNDef afwImpurity_imp}

// ������: "w:\common\components\rtl\Garant\ScriptEngine\afwImpurity.imp.pas"
// ���������: "Impurity"
// ������� ������: "afwImpurity" MUID: (5093D47602BF)
// ��� ����: "_afwImpurity_"

{$Define afwImpurity_imp}

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 _afwImpurity_ = class(_afwImpurity_Parent_)
 end;//_afwImpurity_

{$Else NOT Defined(NoScripts) AND NOT Defined(NoVCL)}

_afwImpurity_ = _afwImpurity_Parent_;

{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
{$Else afwImpurity_imp}

{$IfNDef afwImpurity_imp_impl}

{$Define afwImpurity_imp_impl}

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
{$EndIf afwImpurity_imp_impl}

{$EndIf afwImpurity_imp}

