{$IfNDef LoadUnits_imp}

// Модуль: "w:\common\components\gui\Garant\Daily\LoadUnits.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "LoadUnits" MUID: (509B4CC20221)
// Имя типа: "_LoadUnits_"

{$Define LoadUnits_imp}

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(InsiderTest)}
 _LoadUnits_ = class(_LoadUnits_Parent_)
 end;//_LoadUnits_

{$Else Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(InsiderTest)}

_LoadUnits_ = _LoadUnits_Parent_;

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(InsiderTest)
{$Else LoadUnits_imp}

{$IfNDef LoadUnits_imp_impl}

{$Define LoadUnits_imp_impl}

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(InsiderTest)}
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(InsiderTest)
{$EndIf LoadUnits_imp_impl}

{$EndIf LoadUnits_imp}

