unit nsUseDocumentSubPanelOperationEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\nsUseDocumentSubPanelOperationEvent.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsCounterEvent
 , LoggingUnit
;

type
 TnsUseDocumentSubPanelOperationEvent = class(TnsCounterEvent)
  protected
   function EventID: TLogEvent; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsUseDocumentSubPanelOperationEvent;
    {* Метод получения экземпляра синглетона TnsUseDocumentSubPanelOperationEvent }
 end;//TnsUseDocumentSubPanelOperationEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsUseDocumentSubPanelOperationEvent: TnsUseDocumentSubPanelOperationEvent = nil;
 {* Экземпляр синглетона TnsUseDocumentSubPanelOperationEvent }

procedure TnsUseDocumentSubPanelOperationEventFree;
 {* Метод освобождения экземпляра синглетона TnsUseDocumentSubPanelOperationEvent }
begin
 l3Free(g_TnsUseDocumentSubPanelOperationEvent);
end;//TnsUseDocumentSubPanelOperationEventFree

class function TnsUseDocumentSubPanelOperationEvent.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
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

class function TnsUseDocumentSubPanelOperationEvent.Instance: TnsUseDocumentSubPanelOperationEvent;
 {* Метод получения экземпляра синглетона TnsUseDocumentSubPanelOperationEvent }
begin
 if (g_TnsUseDocumentSubPanelOperationEvent = nil) then
 begin
  l3System.AddExitProc(TnsUseDocumentSubPanelOperationEventFree);
  g_TnsUseDocumentSubPanelOperationEvent := Create;
 end;
 Result := g_TnsUseDocumentSubPanelOperationEvent;
end;//TnsUseDocumentSubPanelOperationEvent.Instance
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
