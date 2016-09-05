{$IfNDef seCriticalSectionHolderPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolderPrim.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "seCriticalSectionHolderPrim" MUID: (57C55713006C)
// Имя типа: "_seCriticalSectionHolderPrim_"

{$Define seCriticalSectionHolderPrim_imp}

 //#UC START# *57C55713006Cci*
 {$IfNDef seThreadSafe}
  {$Define l3CriticalSectionHolder_Off}
 {$EndIf  seThreadSafe}
 //#UC END# *57C55713006Cci*
 _l3CriticalSectionHolder_Parent_ = _seCriticalSectionHolderPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 //#UC START# *57C55713006Ccit*
 //#UC END# *57C55713006Ccit*
 _seCriticalSectionHolderPrim_ = {abstract} class(_l3CriticalSectionHolder_)
 //#UC START# *57C55713006Cpubl*
 //#UC END# *57C55713006Cpubl*
 end;//_seCriticalSectionHolderPrim_

{$Else seCriticalSectionHolderPrim_imp}

{$IfNDef seCriticalSectionHolderPrim_imp_impl}

{$Define seCriticalSectionHolderPrim_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

//#UC START# *57C55713006Cimpl*
//#UC END# *57C55713006Cimpl*

{$EndIf seCriticalSectionHolderPrim_imp_impl}

{$EndIf seCriticalSectionHolderPrim_imp}

