{$IfNDef F1WordsUser_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1WordsUser.imp.pas"
// Стереотип: "Impurity"

{$Define F1WordsUser_imp}

{$If NOT Defined(NoScripts)}
 _F1WordsUser_ = {abstract} class(_F1WordsUser_Parent_)
 end;//_F1WordsUser_

{$Else NOT Defined(NoScripts)}

_F1WordsUser_ = _F1WordsUser_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else F1WordsUser_imp}

{$IfNDef F1WordsUser_imp_impl}

{$Define F1WordsUser_imp_impl}

{$If NOT Defined(NoScripts)}
{$IfEnd} // NOT Defined(NoScripts)
{$EndIf F1WordsUser_imp_impl}

{$EndIf F1WordsUser_imp}

