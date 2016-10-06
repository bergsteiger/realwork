unit alcuMultiOperationExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuMultiOperationExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMultiOperationExecutor" MUID: (57EE6E97018D)

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
 TalcuMultiOperationExecutor = class(TalcuDocTransferRequestExecutor)
  protected
   procedure DoExecute(const aContext: TncsExecuteContext); override;
 end;//TalcuMultiOperationExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , l3StopWatch
 , l3Base
 , l3Types
 {$If NOT Defined(Nemesis)}
 , csMultiOperation
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiOperationReply
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , daInterfaces
 , alcuMultiOperationRequest
 , TypInfo
 , l3MarshalledTypes
 //#UC START# *57EE6E97018Dimpl_uses*
 //#UC END# *57EE6E97018Dimpl_uses*
;

procedure TalcuMultiOperationExecutor.DoExecute(const aContext: TncsExecuteContext);
//#UC START# *57D2A771002F_57EE6E97018D_var*
var
 l_Message: TcsMultiOperation;
 l_Reply: TcsMultiOperationReply;
 l_Task: TalcuMultiOperationRequest;
 l_Counter: Tl3StopWatch;
//#UC END# *57D2A771002F_57EE6E97018D_var*
begin
//#UC START# *57D2A771002F_57EE6E97018D_impl*
 l_Counter.Reset;
 l_Counter.Start;
 l_Message := aContext.rMessage as TcsMultiOperation;
 l_Reply := TcsMultiOperationReply.Create(l_Message);
 try
  l_Reply.IsSuccess := False;
  l_Reply.ErrorMessage := '';
  try
   l_Reply.IsSuccess := False;
   l_Task := TalcuMultiOperationRequest.Create(l_Message.UserID);
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
 l3System.Msg2Log('Remote multioperation (%s) wait - %s', [GetEnumName(TypeInfo(TarMultiOperation), Ord(l_Message.Operation)), FormatFloat('#,##0 ms', l_Counter.Time * 1000)], l3_msgLevel10);
//#UC END# *57D2A771002F_57EE6E97018D_impl*
end;//TalcuMultiOperationExecutor.DoExecute
{$IfEnd} // Defined(ServerTasks)

end.
