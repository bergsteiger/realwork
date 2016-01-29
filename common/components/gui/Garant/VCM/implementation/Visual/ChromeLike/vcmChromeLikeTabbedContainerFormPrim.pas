unit vcmChromeLikeTabbedContainerFormPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmChromeLikeTabbedContainerFormPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::TvcmChromeLikeTabbedContainerFormPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  vcmInterfaces,
  vcmGlassForm
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
type
 TvcmChromeLikeTabbedContainerFormPrim = class(TvcmGlassForm, IvcmSizeableForm)
 protected
 // realized methods
   function pm_GetCanChangeSize: Boolean;
   function pm_GetCanBeMaximized: Boolean;
 end;//TvcmChromeLikeTabbedContainerFormPrim
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class TvcmChromeLikeTabbedContainerFormPrim

function TvcmChromeLikeTabbedContainerFormPrim.pm_GetCanChangeSize: Boolean;
//#UC START# *53C65D8F0393_53C65E480231get_var*
//#UC END# *53C65D8F0393_53C65E480231get_var*
begin
//#UC START# *53C65D8F0393_53C65E480231get_impl*
 Result := True;
//#UC END# *53C65D8F0393_53C65E480231get_impl*
end;//TvcmChromeLikeTabbedContainerFormPrim.pm_GetCanChangeSize

function TvcmChromeLikeTabbedContainerFormPrim.pm_GetCanBeMaximized: Boolean;
//#UC START# *53C65E120031_53C65E480231get_var*
//#UC END# *53C65E120031_53C65E480231get_var*
begin
//#UC START# *53C65E120031_53C65E480231get_impl*
 Result := True;
//#UC END# *53C65E120031_53C65E480231get_impl*
end;//TvcmChromeLikeTabbedContainerFormPrim.pm_GetCanBeMaximized

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TvcmChromeLikeTabbedContainerFormPrim
 TtfwClassRef.Register(TvcmChromeLikeTabbedContainerFormPrim);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM AND not NoVGScene

end.