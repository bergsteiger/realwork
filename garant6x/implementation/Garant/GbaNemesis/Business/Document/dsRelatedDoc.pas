unit dsRelatedDoc;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsRelatedDoc.pas"
// Начат: 08.12.2008 19:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::DocumentAndList::TdsRelatedDoc
//
// Справка
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
 TdsRelatedDoc = {vac} class(TdsChildDocument)
  {* Справка }
 protected
 // overridden protected methods
   function DoGetPreviewCaleeArea: TafwPreviewCaleeArea; override;
 end;//TdsRelatedDoc
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsRelatedDoc

function TdsRelatedDoc.DoGetPreviewCaleeArea: TafwPreviewCaleeArea;
//#UC START# *49589999029F_495898900070_var*
//#UC END# *49589999029F_495898900070_var*
begin
//#UC START# *49589999029F_495898900070_impl*
 Result := afw_pcaReference;
//#UC END# *49589999029F_495898900070_impl*
end;//TdsRelatedDoc.DoGetPreviewCaleeArea

{$IfEnd} //not Admin AND not Monitorings

end.