unit alcuDownloadDocStreamExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuDownloadDocStreamExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuDownloadDocStreamExecutor" MUID: (57C00B9700F2)

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
 TalcuDownloadDocStreamExecutor = class(TalcuDocTransferRequestExecutor)
  protected
   procedure DoExecute(const aContext: TncsExecuteContext); override;
 end;//TalcuDownloadDocStreamExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuDownloadDocRequest
 {$If NOT Defined(Nemesis)}
 , csDownloadDocStream
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csDownloadDocStreamReply
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , daInterfaces
 , l3Base
 , l3StopWatch
 , l3Types
 //#UC START# *57C00B9700F2impl_uses*
 //#UC END# *57C00B9700F2impl_uses*
;

procedure TalcuDownloadDocStreamExecutor.DoExecute(const aContext: TncsExecuteContext);
//#UC START# *57D2A771002F_57C00B9700F2_var*
var
 l_Message: TcsDownloadDocStream;
 l_Reply: TcsDownloadDocStreamReply;
 l_Task: TalcuDownloadDocRequest;
 l_Counter: Tl3StopWatch;
//#UC END# *57D2A771002F_57C00B9700F2_var*
begin
//#UC START# *57D2A771002F_57C00B9700F2_impl*
 l_Counter.Reset;
 l_Counter.Start;
 l_Message := aContext.rMessage as TcsDownloadDocStream;
 l_Reply := TcsDownloadDocStreamReply.Create(l_Message);
 try
  l_Reply.IsSuccess := False;
  l_Reply.ErrorMessage := '';
  try
   l_Reply.IsSuccess := False;
   l_Task := TalcuDownloadDocRequest.Create(l_Message.UserID);
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
 l3System.Msg2Log('Remote send document - %s', [FormatFloat('#,##0 ms', l_Counter.Time * 1000)], l3_msgLevel10);
//#UC END# *57D2A771002F_57C00B9700F2_impl*
end;//TalcuDownloadDocStreamExecutor.DoExecute
{$IfEnd} // Defined(ServerTasks)

end.
