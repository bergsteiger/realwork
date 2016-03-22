{$IfNDef FormUnits_imp}

// Модуль: "w:\common\components\gui\Garant\Daily\FormUnits.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "FormUnits" MUID: (509A43E800C8)
// Имя типа: "_FormUnits_"

{$Define FormUnits_imp}

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(InsiderTest)}
 _FormUnits_ = class(_FormUnits_Parent_)
 end;//_FormUnits_

{$Else Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(InsiderTest)}

_FormUnits_ = _FormUnits_Parent_;

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(InsiderTest)
{$Else FormUnits_imp}

{$IfNDef FormUnits_imp_impl}

{$Define FormUnits_imp_impl}

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(InsiderTest)}
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(InsiderTest)
{$EndIf FormUnits_imp_impl}

{$EndIf FormUnits_imp}

