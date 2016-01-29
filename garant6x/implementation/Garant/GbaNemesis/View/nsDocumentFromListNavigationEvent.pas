unit nsDocumentFromListNavigationEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsDocumentFromListNavigationEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Работа с документом и списком документов::Document::View::CommonForDocumentAndFlash::TnsDocumentFromListNavigationEvent
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
  DynamicDocListUnit,
  DocumentUnit,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDocumentFromListNavigationEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(aNext: Boolean;
    const aList: IDynList;
    const aDoc: IDocument);
 end;//TnsDocumentFromListNavigationEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsDocumentFromListNavigationEvent

class procedure TnsDocumentFromListNavigationEvent.Log(aNext: Boolean;
  const aList: IDynList;
  const aDoc: IDocument);
//#UC START# *4B16583901B5_4B1658140144_var*
var
 l_Data: InsLogEventData;
const
 c_Event: array [Boolean] of TLogEvent = (
  LE_PREV_DOCUMENT,
  LE_NEXT_DOCUMENT
 );//c_Event
//#UC END# *4B16583901B5_4B1658140144_var*
begin
//#UC START# *4B16583901B5_4B1658140144_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(c_Event[aNext], l_Data);
//#UC END# *4B16583901B5_4B1658140144_impl*
end;//TnsDocumentFromListNavigationEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.