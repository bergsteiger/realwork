{$IfNDef DTTypesUser_imp}

// Модуль: "w:\archi\source\projects\ImportExportTest\DTTypesUser.imp.pas"
// Стереотип: "Impurity"

{$Define DTTypesUser_imp}

{$If Defined(nsTest)}
 _DTTypesUser_ = {abstract} class(_DTTypesUser_Parent_)
 end;//_DTTypesUser_

{$Else Defined(nsTest)}

_DTTypesUser_ = _DTTypesUser_Parent_;

{$IfEnd} // Defined(nsTest)
{$Else DTTypesUser_imp}

{$IfNDef DTTypesUser_imp_impl}

{$Define DTTypesUser_imp_impl}

{$If Defined(nsTest)}
{$IfEnd} // Defined(nsTest)
{$EndIf DTTypesUser_imp_impl}

{$EndIf DTTypesUser_imp}

