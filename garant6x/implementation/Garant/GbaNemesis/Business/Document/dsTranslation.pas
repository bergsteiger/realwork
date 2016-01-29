unit dsTranslation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsTranslation.pas"
// Начат: 08.12.2008 19:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::DocumentAndList::TdsTranslation
//
// Перевод
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsChildDocument,
  afwInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsTranslation = {vac} class(TdsChildDocument)
  {* Перевод }
 protected
 // overridden protected methods
   function DoGetPreviewCaleeArea: TafwPreviewCaleeArea; override;
 end;//TdsTranslation
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsTranslation

function TdsTranslation.DoGetPreviewCaleeArea: TafwPreviewCaleeArea;
//#UC START# *49589999029F_4958986800FE_var*
//#UC END# *49589999029F_4958986800FE_var*
begin
//#UC START# *49589999029F_4958986800FE_impl*
 Result := afw_pcaTranslation;
//#UC END# *49589999029F_4958986800FE_impl*
end;//TdsTranslation.DoGetPreviewCaleeArea

{$IfEnd} //not Admin AND not Monitorings

end.