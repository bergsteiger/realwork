{$IfNDef ucpHAFMacroReplacerFactory_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Presentation"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Presentation/ucpHAFMacroReplacerFactory.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Aspects::CommonForCompareEditionsAndChangesBetweenEditions::Presentation::HAF::ucpHAFMacroReplacerFactory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define ucpHAFMacroReplacerFactory_imp}
 _deDocInfoProvider_Parent_ = _ucpHAFMacroReplacerFactory_Parent_;
 {$Include ..\Presentation\deDocInfoProvider.imp.pas}
 _ucpHAFMacroReplacerFactory_ = {mixin} class(_deDocInfoProvider_ {$If not defined(Admin) AND not defined(Monitorings)}, IucpHAFMacroReplacerFactory{$IfEnd} //not Admin AND not Monitorings
 )
 protected
 // realized methods
   {$If not defined(Admin) AND not defined(Monitorings)}
   function MakeHAFMacroReplacer: IafwHAFMacroReplacer;
   {$IfEnd} //not Admin AND not Monitorings
 end;//_ucpHAFMacroReplacerFactory_

{$Else ucpHAFMacroReplacerFactory_imp}

{$Include ..\Presentation\deDocInfoProvider.imp.pas}

// start class _ucpHAFMacroReplacerFactory_

{$If not defined(Admin) AND not defined(Monitorings)}
function _ucpHAFMacroReplacerFactory_.MakeHAFMacroReplacer: IafwHAFMacroReplacer;
//#UC START# *4AE56DE80093_4F546FD3028F_var*
//#UC END# *4AE56DE80093_4F546FD3028F_var*
begin
//#UC START# *4AE56DE80093_4F546FD3028F_impl*
 Result := TnsDocInfoHAFMacroReplacer.Make(nil, Self.pm_GetDocInfo);
//#UC END# *4AE56DE80093_4F546FD3028F_impl*
end;//_ucpHAFMacroReplacerFactory_.MakeHAFMacroReplacer
{$IfEnd} //not Admin AND not Monitorings

{$EndIf ucpHAFMacroReplacerFactory_imp}
