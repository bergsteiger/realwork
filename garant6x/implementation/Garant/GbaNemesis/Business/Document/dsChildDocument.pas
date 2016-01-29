unit dsChildDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsChildDocument.pas"
// Начат: 08.12.2008 19:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::DocumentAndList::TdsChildDocument
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
  dsDocument,
  afwInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsChildDocument = {vac} class(TdsDocument)
 protected
 // overridden protected methods
   function DoMakeHAFMacroReplacer: IafwHAFMacroReplacer; override;
 end;//TdsChildDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsDocInfoHAFMacroReplacer,
  nsChildDocInfoHAFMacroReplacer,
  WorkWithDocumentInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsChildDocument

function TdsChildDocument.DoMakeHAFMacroReplacer: IafwHAFMacroReplacer;
//#UC START# *49589C6203A6_4958980300D5_var*
//#UC END# *49589C6203A6_4958980300D5_var*
begin
//#UC START# *49589C6203A6_4958980300D5_impl*
 Result := TnsChildDocInfoHAFMacroReplacer.Make(TnsDocInfoHAFMacroReplacer.Make(nil, ucc_BaseDocument.DocInfo), DocInfo)
//#UC END# *49589C6203A6_4958980300D5_impl*
end;//TdsChildDocument.DoMakeHAFMacroReplacer

{$IfEnd} //not Admin AND not Monitorings

end.