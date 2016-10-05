unit alcuMultiClearAttributesExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuMultiClearAttributesExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMultiClearAttributesExecutor" MUID: (57EBC0C00362)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuDocTransferRequestExecutor
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuMultiClearAttributesExecutor = class(TalcuDocTransferRequestExecutor)
  protected
   procedure DoExecute(const aContext: TncsExecuteContext); override;
 end;//TalcuMultiClearAttributesExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , l3Types
 , l3Base
 , l3StopWatch
 , daInterfaces
 {$If NOT Defined(Nemesis)}
 , csMultiClearAttributes
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiClearAttributesReply
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , alcuMultiClearAttributesRequest
 //#UC START# *57EBC0C00362impl_uses*
 //#UC END# *57EBC0C00362impl_uses*
;

procedure TalcuMultiClearAttributesExecutor.DoExecute(const aContext: TncsExecuteContext);
//#UC START# *57D2A771002F_57EBC0C00362_var*
var
 l_Message: TcsMultiClearAttributes;
 l_Reply: TcsMultiClearAttributesReply;
 l_Task: TalcuMultiClearAttributesRequest;
 l_Counter: Tl3StopWatch;
//#UC END# *57D2A771002F_57EBC0C00362_var*
begin
//#UC START# *57D2A771002F_57EBC0C00362_impl*
 l_Counter.Reset;
 l_Counter.Start;
 l_Message := aContext.rMessage as TcsMultiClearAttributes;
 l_Reply := TcsMultiClearAttributesReply.Create(l_Message);
 try
  l_Reply.IsSuccess := False;
  l_Reply.ErrorMessage := '';
  try
   l_Reply.IsSuccess := False;
   l_Task := TalcuMultiClearAttributesRequest.Create(usServerService);
   try
    l_Task.Message := l_Message;
    l_Task.Reply := l_Reply;
    IncomingList.Push(l_Task);
    SpeedupRequest;
    l_Task.WaitForReady;
   finally
    FreeAndNil(l_Task);
   end;
  finally
   aContext.rTransporter.Send(l_Reply);
  end;
 finally
  FreeAndNil(l_Reply);
 end;
 l_Counter.Stop;
 l3System.Msg2Log('Remote multiclear attributes - %s', [FormatFloat('#,##0 ms', l_Counter.Time * 1000)], l3_msgLevel10);
//#UC END# *57D2A771002F_57EBC0C00362_impl*
end;//TalcuMultiClearAttributesExecutor.DoExecute
{$IfEnd} // Defined(ServerTasks)

end.
