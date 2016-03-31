{$IfNDef ucpHAFMacroReplacerFactory_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Presentation\ucpHAFMacroReplacerFactory.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "ucpHAFMacroReplacerFactory" MUID: (4F546FD3028F)
// Имя типа: "_ucpHAFMacroReplacerFactory_"

{$Define ucpHAFMacroReplacerFactory_imp}

 _deDocInfoProvider_Parent_ = _ucpHAFMacroReplacerFactory_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Presentation\deDocInfoProvider.imp.pas}
 _ucpHAFMacroReplacerFactory_ = class(_deDocInfoProvider_{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , IucpHAFMacroReplacerFactory
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 )
  protected
   {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
   function MakeHAFMacroReplacer: IafwHAFMacroReplacer;
   {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 end;//_ucpHAFMacroReplacerFactory_

{$Else ucpHAFMacroReplacerFactory_imp}

{$IfNDef ucpHAFMacroReplacerFactory_imp_impl}

{$Define ucpHAFMacroReplacerFactory_imp_impl}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Presentation\deDocInfoProvider.imp.pas}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
function _ucpHAFMacroReplacerFactory_.MakeHAFMacroReplacer: IafwHAFMacroReplacer;
//#UC START# *4AE56DE80093_4F546FD3028F_var*
//#UC END# *4AE56DE80093_4F546FD3028F_var*
begin
//#UC START# *4AE56DE80093_4F546FD3028F_impl*
 Result := TnsDocInfoHAFMacroReplacer.Make(nil, Self.pm_GetDocInfo);
//#UC END# *4AE56DE80093_4F546FD3028F_impl*
end;//_ucpHAFMacroReplacerFactory_.MakeHAFMacroReplacer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf ucpHAFMacroReplacerFactory_imp_impl}

{$EndIf ucpHAFMacroReplacerFactory_imp}

