{$IfNDef F1Test_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1Test.imp.pas"
// ���������: "Impurity"
// ������� ������: "F1Test" MUID: (4DA3190C022C)
// ��� ����: "_F1Test_"

{$Define F1Test_imp}

{$If NOT Defined(NoScripts)}
 _F1Test_ = class(_F1Test_Parent_)
 end;//_F1Test_

{$Else NOT Defined(NoScripts)}

_F1Test_ = _F1Test_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else F1Test_imp}

{$IfNDef F1Test_imp_impl}

{$Define F1Test_imp_impl}

{$If NOT Defined(NoScripts)}
{$IfEnd} // NOT Defined(NoScripts)
{$EndIf F1Test_imp_impl}

{$EndIf F1Test_imp}

