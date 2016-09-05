unit alcuDownloadDocStreamExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuDownloadDocStreamExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuDownloadDocStreamExecutor" MUID: (57C00B9700F2)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuExecutorWithIncomingTaskList
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces
 {$IfEnd} // NOT Defined(Nemesis)
 , alcuImmidiateRequestInterfaces
 {$If NOT Defined(Nemesis)}
 , ddServerTaskList
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuDownloadDocStreamExecutor = class(TalcuExecutorWithIncomingTaskList{$If NOT Defined(Nemesis)}
 , IncsExecutor
 {$IfEnd} // NOT Defined(Nemesis)
 )
  private
   f_RequestImmidiateProcessProc: TalcuSpeedupRequestProc;
  protected
   {$If NOT Defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} // NOT Defined(Nemesis)
  public
   constructor Create(aList: TddServerTaskList;
    aProc: TalcuSpeedupRequestProc); reintroduce;
   class function Make(aList: TddServerTaskList;
    aProc: TalcuSpeedupRequestProc): IncsExecutor; reintroduce;
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

constructor TalcuDownloadDocStreamExecutor.Create(aList: TddServerTaskList;
 aProc: TalcuSpeedupRequestProc);
//#UC START# *57C00BDA02BA_57C00B9700F2_var*
//#UC END# *57C00BDA02BA_57C00B9700F2_var*
begin
//#UC START# *57C00BDA02BA_57C00B9700F2_impl*
 inherited Create(aList);
 f_RequestImmidiateProcessProc := aProc;
//#UC END# *57C00BDA02BA_57C00B9700F2_impl*
end;//TalcuDownloadDocStreamExecutor.Create

class function TalcuDownloadDocStreamExecutor.Make(aList: TddServerTaskList;
 aProc: TalcuSpeedupRequestProc): IncsExecutor;
var
 l_Inst : TalcuDownloadDocStreamExecutor;
begin
 l_Inst := Create(aList, aProc);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TalcuDownloadDocStreamExecutor.Make

{$If NOT Defined(Nemesis)}
procedure TalcuDownloadDocStreamExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_57C00B9700F2_var*
var
 l_Message: TcsDownloadDocStream;
 l_Reply: TcsDownloadDocStreamReply;
 l_Task: TalcuDownloadDocRequest;
 l_Counter: Tl3StopWatch;
//#UC END# *54607DDC0159_57C00B9700F2_var*
begin
//#UC START# *54607DDC0159_57C00B9700F2_impl*
 l_Counter.Reset;
 l_Counter.Start;
 l_Message := aContext.rMessage as TcsDownloadDocStream;
 l_Reply := TcsDownloadDocStreamReply.Create(l_Message);
 try
  l_Reply.IsSuccess := False;
  l_Reply.ErrorMessage := '';
  try
   l_Reply.IsSuccess := False;
   l_Task := TalcuDownloadDocRequest.Create(usServerService);
   try
    l_Task.Message := l_Message;
    l_Task.Reply := l_Reply;
    IncomingList.Push(l_Task);
    if Assigned(f_RequestImmidiateProcessProc) then
     f_RequestImmidiateProcessProc;
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
//#UC END# *54607DDC0159_57C00B9700F2_impl*
end;//TalcuDownloadDocStreamExecutor.Execute
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
