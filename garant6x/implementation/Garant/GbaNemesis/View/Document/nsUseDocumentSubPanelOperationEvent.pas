unit nsUseDocumentSubPanelOperationEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/nsUseDocumentSubPanelOperationEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Работа с документом и списком документов::Document::View::Document::TnsUseDocumentSubPanelOperationEvent
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
  nsCounterEvent,
  LoggingUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsUseDocumentSubPanelOperationEvent = class(TnsCounterEvent)
 protected
 // realized methods
   function EventID: TLogEvent; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsUseDocumentSubPanelOperationEvent;
    {- возвращает экземпляр синглетона. }
 end;//TnsUseDocumentSubPanelOperationEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class TnsUseDocumentSubPanelOperationEvent

var g_TnsUseDocumentSubPanelOperationEvent : TnsUseDocumentSubPanelOperationEvent = nil;

procedure TnsUseDocumentSubPanelOperationEventFree;
begin
 l3Free(g_TnsUseDocumentSubPanelOperationEvent);
end;

class function TnsUseDocumentSubPanelOperationEvent.Instance: TnsUseDocumentSubPanelOperationEvent;
begin
 if (g_TnsUseDocumentSubPanelOperationEvent = nil) then
 begin
  l3System.AddExitProc(TnsUseDocumentSubPanelOperationEventFree);
  g_TnsUseDocumentSubPanelOperationEvent := Create;
 end;
 Result := g_TnsUseDocumentSubPanelOperationEvent;
end;


class function TnsUseDocumentSubPanelOperationEvent.Exists: Boolean;
 {-}
begin
 Result := g_TnsUseDocumentSubPanelOperationEvent <> nil;
end;//TnsUseDocumentSubPanelOperationEvent.Exists

function TnsUseDocumentSubPanelOperationEvent.EventID: TLogEvent;
//#UC START# *4B13A26203DB_4B13AFDF013A_var*
//#UC END# *4B13A26203DB_4B13AFDF013A_var*
begin
//#UC START# *4B13A26203DB_4B13AFDF013A_impl*
 Result := LE_USE_SUB_PANEL_DOCUMENT_OPERATION;
//#UC END# *4B13A26203DB_4B13AFDF013A_impl*
end;//TnsUseDocumentSubPanelOperationEvent.EventID

{$IfEnd} //not Admin AND not Monitorings

end.