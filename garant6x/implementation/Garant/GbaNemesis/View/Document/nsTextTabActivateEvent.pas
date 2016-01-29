unit nsTextTabActivateEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/nsTextTabActivateEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Работа с документом и списком документов::Document::View::Document::TnsTextTabActivateEvent
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
  DocumentUnit,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsTextTabActivateKind = (
   ttakRelated
 , ttakAnnotation
 );//TnsTextTabActivateKind

 TnsTextTabActivateEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument;
    aKind: TnsTextTabActivateKind);
 end;//TnsTextTabActivateEvent
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

// start class TnsTextTabActivateEvent

class procedure TnsTextTabActivateEvent.Log(const aDoc: IDocument;
  aKind: TnsTextTabActivateKind);
//#UC START# *4B0E700600BA_4B0E6F160372_var*
var
 l_Data: InsLogEventData;
const
  cMap: array [TnsTextTabActivateKind] of TLogEvent = (LE_OPEN_RELATED, LE_OPEN_ANNOTATION);
//#UC END# *4B0E700600BA_4B0E6F160372_var*
begin
//#UC START# *4B0E700600BA_4B0E6F160372_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(cMap[aKind], l_Data);
//#UC END# *4B0E700600BA_4B0E6F160372_impl*
end;//TnsTextTabActivateEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.