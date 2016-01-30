{$IfNDef PrintRowCompare_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\EditorUsers\PrintRowCompare.imp.pas"
// Стереотип: "Impurity"

{$Define PrintRowCompare_imp}

{$If NOT Defined(NoScripts)}
 _PrintRowCompare_ = class(_PrintRowCompare_Parent_)
 end;//_PrintRowCompare_

{$Else NOT Defined(NoScripts)}

_PrintRowCompare_ = _PrintRowCompare_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else PrintRowCompare_imp}

{$IfNDef PrintRowCompare_imp_impl}

{$Define PrintRowCompare_imp_impl}

{$If NOT Defined(NoScripts)}
{$IfEnd} // NOT Defined(NoScripts)
{$EndIf PrintRowCompare_imp_impl}

{$EndIf PrintRowCompare_imp}

