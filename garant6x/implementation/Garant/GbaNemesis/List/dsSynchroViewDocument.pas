unit dsSynchroViewDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "List"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/List/dsSynchroViewDocument.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Работа с документом и списком документов::WorkWithList::List::List::TdsSynchroViewDocument
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
  nevTools
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsSynchroViewDocument = {vac} class(TdsDocument)
 protected
 // overridden protected methods
   function MakeContainer: InevDocumentContainer; override;
     {* Конструирует контейнер документа }
 end;//TdsSynchroViewDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsAACDocumentSynchroViewContainer,
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsSynchroViewDocument

function TdsSynchroViewDocument.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_5024E60F00A6_var*
//#UC END# *4C6AB38800F3_5024E60F00A6_var*
begin
//#UC START# *4C6AB38800F3_5024E60F00A6_impl*
 Case DocInfo.DocType of
  DT_ACTUAL_ANALYTICS,
  DT_ACTUAL_ANALYTICS_CONTENTS:
   Result := TnsAACDocumentSynchroViewContainer.Make(DocInfo);
  else
   Result := inherited MakeContainer;
 end;//Case DocInfo.DocType
//#UC END# *4C6AB38800F3_5024E60F00A6_impl*
end;//TdsSynchroViewDocument.MakeContainer

{$IfEnd} //not Admin AND not Monitorings

end.