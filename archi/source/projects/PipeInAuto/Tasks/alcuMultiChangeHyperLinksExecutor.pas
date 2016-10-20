unit alcuMultiChangeHyperLinksExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuMultiChangeHyperLinksExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMultiChangeHyperLinksExecutor" MUID: (5804B4A5013A)

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
 TalcuMultiChangeHyperLinksExecutor = class(TalcuDocTransferRequestExecutor)
  protected
   procedure DoExecute(const aContext: TncsExecuteContext); override;
 end;//TalcuMultiChangeHyperLinksExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , l3StopWatch
 , l3Base
 , l3Types
 , SysUtils
 {$If NOT Defined(Nemesis)}
 , csMultiChangeHyperLinks
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiChangeHyperLinksReply
 {$IfEnd} // NOT Defined(Nemesis)
 , alcuMultiChangeHyperLinksRequest
 //#UC START# *5804B4A5013Aimpl_uses*
 //#UC END# *5804B4A5013Aimpl_uses*
;

procedure TalcuMultiChangeHyperLinksExecutor.DoExecute(const aContext: TncsExecuteContext);
//#UC START# *57D2A771002F_5804B4A5013A_var*
var
 l_Message: TcsMultiChangeHyperLinks;
 l_Reply: TcsMultiChangeHyperLinksReply;
 l_Task: TalcuMultiChangeHyperLinksRequest;
 l_Counter: Tl3StopWatch;
//#UC END# *57D2A771002F_5804B4A5013A_var*
begin
//#UC START# *57D2A771002F_5804B4A5013A_impl*
 l_Counter.Reset;
 l_Counter.Start;
 l_Message := aContext.rMessage as TcsMultiChangeHyperLinks;
 l_Reply := TcsMultiChangeHyperLinksReply.Create(l_Message);
 try
  l_Reply.IsSuccess := False;
  l_Reply.ErrorMessage := '';
  try
   l_Reply.IsSuccess := False;
   l_Task := TalcuMultiChangeHyperLinksRequest.Create(l_Message.UserID);
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
 l3System.Msg2Log('Remote multi change hyperlinks wait - %s', [FormatFloat('#,##0 ms', l_Counter.Time * 1000)], l3_msgLevel10);
//#UC END# *57D2A771002F_5804B4A5013A_impl*
end;//TalcuMultiChangeHyperLinksExecutor.DoExecute
{$IfEnd} // Defined(ServerTasks)

end.
