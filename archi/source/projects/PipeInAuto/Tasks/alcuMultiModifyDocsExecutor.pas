unit alcuMultiModifyDocsExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuMultiModifyDocsExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMultiModifyDocsExecutor" MUID: (57E4EEC200D1)

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
 TalcuMultiModifyDocsExecutor = class(TalcuDocTransferRequestExecutor)
  protected
   procedure DoExecute(const aContext: TncsExecuteContext); override;
 end;//TalcuMultiModifyDocsExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , l3StopWatch
 , l3Base
 , l3Types
 , SysUtils
 , daInterfaces
 , alcuMultiModifyDocsRequest
 {$If NOT Defined(Nemesis)}
 , csMultiModifyDocs
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiModifyDocsReply
 {$IfEnd} // NOT Defined(Nemesis)
 //#UC START# *57E4EEC200D1impl_uses*
 //#UC END# *57E4EEC200D1impl_uses*
;

procedure TalcuMultiModifyDocsExecutor.DoExecute(const aContext: TncsExecuteContext);
//#UC START# *57D2A771002F_57E4EEC200D1_var*
var
 l_Message: TcsMultiModifyDocs;
 l_Reply: TcsMultiModifyDocsReply;
 l_Task: TalcuMultiModifyDocsRequest;
 l_Counter: Tl3StopWatch;
//#UC END# *57D2A771002F_57E4EEC200D1_var*
begin
//#UC START# *57D2A771002F_57E4EEC200D1_impl*
 l_Counter.Reset;
 l_Counter.Start;
 l_Message := aContext.rMessage as TcsMultiModifyDocs;
 l_Reply := TcsMultiModifyDocsReply.Create(l_Message);
 try
  l_Reply.IsSuccess := False;
  l_Reply.ErrorMessage := '';
  try
   l_Reply.IsSuccess := False;
   l_Task := TalcuMultiModifyDocsRequest.Create(usServerService);
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
 l3System.Msg2Log('Remote multimodify documents - %s', [FormatFloat('#,##0 ms', l_Counter.Time * 1000)], l3_msgLevel10);
//#UC END# *57D2A771002F_57E4EEC200D1_impl*
end;//TalcuMultiModifyDocsExecutor.DoExecute
{$IfEnd} // Defined(ServerTasks)

end.
