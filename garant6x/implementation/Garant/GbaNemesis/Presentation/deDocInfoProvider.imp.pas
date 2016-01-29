{$IfNDef deDocInfoProvider_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Presentation"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Presentation/deDocInfoProvider.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Aspects::CommonForCompareEditionsAndChangesBetweenEditions::Presentation::HAF::deDocInfoProvider
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define deDocInfoProvider_imp}
 _deDocInfoProvider_ = {mixin} class(_deDocInfoProvider_Parent_)
 protected
 // realized methods
   {$If not defined(Admin) AND not defined(Monitorings)}
   function pm_GetDocInfo: IdeDocInfo;
   {$IfEnd} //not Admin AND not Monitorings
 protected
 // protected methods
   function DocumentForDocInfoProvider: IDocument; virtual; abstract;
 end;//_deDocInfoProvider_

{$Else deDocInfoProvider_imp}

// start class _deDocInfoProvider_

{$If not defined(Admin) AND not defined(Monitorings)}
function _deDocInfoProvider_.pm_GetDocInfo: IdeDocInfo;
//#UC START# *4DF9D63B0360_4F54899502EAget_var*
//#UC END# *4DF9D63B0360_4F54899502EAget_var*
begin
//#UC START# *4DF9D63B0360_4F54899502EAget_impl*
 Result := TdeDocInfo.Make(DocumentForDocInfoProvider);
//#UC END# *4DF9D63B0360_4F54899502EAget_impl*
end;//_deDocInfoProvider_.pm_GetDocInfo
{$IfEnd} //not Admin AND not Monitorings

{$EndIf deDocInfoProvider_imp}
