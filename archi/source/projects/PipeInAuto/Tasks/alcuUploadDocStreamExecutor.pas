unit alcuUploadDocStreamExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuUploadDocStreamExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuUploadDocStreamExecutor" MUID: (57D6592F0210)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuDocTransferRequestExecutor
 {$If NOT Defined(Nemesis)}
 , dt_IFltr
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ddServerTaskList
 {$IfEnd} // NOT Defined(Nemesis)
 , alcuImmidiateRequestInterfaces
;

type
 TalcuUploadDocStreamExecutor = class(TalcuDocTransferRequestExecutor)
  private
   f_OnEraseNotify: TdtOnEraseAttrRecords;
  protected
   procedure DoExecute(const aContext: TncsExecuteContext); override;
  public
   constructor Create(aList: TddServerTaskList;
    aProc: TalcuSpeedupRequestProc;
    aEraseNotify: TdtOnEraseAttrRecords); reintroduce;
   class function Make(aList: TddServerTaskList;
    aProc: TalcuSpeedupRequestProc;
    aEraseNotify: TdtOnEraseAttrRecords): IncsExecutor; reintroduce;
 end;//TalcuUploadDocStreamExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , SysUtils
 , daInterfaces
 {$If NOT Defined(Nemesis)}
 , csUploadDocStream
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csUploadDocStreamReply
 {$IfEnd} // NOT Defined(Nemesis)
 , alcuUploadDocRequest
 , l3Types
 , l3Base
 , l3StopWatch
 //#UC START# *57D6592F0210impl_uses*
 //#UC END# *57D6592F0210impl_uses*
;

constructor TalcuUploadDocStreamExecutor.Create(aList: TddServerTaskList;
 aProc: TalcuSpeedupRequestProc;
 aEraseNotify: TdtOnEraseAttrRecords);
//#UC START# *57D69430002E_57D6592F0210_var*
//#UC END# *57D69430002E_57D6592F0210_var*
begin
//#UC START# *57D69430002E_57D6592F0210_impl*
 inherited Create(aList, aProc);
 f_OnEraseNotify := aEraseNotify;
//#UC END# *57D69430002E_57D6592F0210_impl*
end;//TalcuUploadDocStreamExecutor.Create

class function TalcuUploadDocStreamExecutor.Make(aList: TddServerTaskList;
 aProc: TalcuSpeedupRequestProc;
 aEraseNotify: TdtOnEraseAttrRecords): IncsExecutor;
var
 l_Inst : TalcuUploadDocStreamExecutor;
begin
 l_Inst := Create(aList, aProc, aEraseNotify);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TalcuUploadDocStreamExecutor.Make

procedure TalcuUploadDocStreamExecutor.DoExecute(const aContext: TncsExecuteContext);
//#UC START# *57D2A771002F_57D6592F0210_var*
var
 l_Message: TcsUploadDocStream;
 l_Reply: TcsUploadDocStreamReply;
 l_Task: TalcuUploadDocRequest;
 l_Counter: Tl3StopWatch;
//#UC END# *57D2A771002F_57D6592F0210_var*
begin
//#UC START# *57D2A771002F_57D6592F0210_impl*
 l_Counter.Reset;
 l_Counter.Start;
 l_Message := aContext.rMessage as TcsUploadDocStream;
 l_Reply := TcsUploadDocStreamReply.Create(l_Message);
 try
  l_Reply.IsSuccess := False;
  l_Reply.ErrorMessage := '';
  try
   l_Reply.IsSuccess := False;
   l_Task := TalcuUploadDocRequest.Create(l_Message.UserID);
   try
    l_Task.Message := l_Message;
    l_Task.Reply := l_Reply;
    l_Task.OnEraseNotify := f_OnEraseNotify;
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
 l3System.Msg2Log('Remote receive document - %s', [FormatFloat('#,##0 ms', l_Counter.Time * 1000)], l3_msgLevel10);
//#UC END# *57D2A771002F_57D6592F0210_impl*
end;//TalcuUploadDocStreamExecutor.DoExecute
{$IfEnd} // Defined(ServerTasks)

end.
