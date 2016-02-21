unit alcuSendTaskExecutor;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuSendTaskExecutor.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuExecutorWithIncomingTaskList
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ddServerTaskList
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuSendTaskExecutor = class(TalcuExecutorWithIncomingTaskList{$If NOT Defined(Nemesis)}
 , IncsExecutor
 {$IfEnd} // NOT Defined(Nemesis)
 )
  private
   f_RootTaskFolder: AnsiString;
  protected
   {$If NOT Defined(Nemesis)}
   procedure Execute(const aContext: TncsExecuteContext);
   {$IfEnd} // NOT Defined(Nemesis)
  public
   constructor Create(aList: TddServerTaskList;
    const aRootTaskFolder: AnsiString); reintroduce;
   class function Make(aList: TddServerTaskList;
    const aRootTaskFolder: AnsiString): IncsExecutor; reintroduce;
 end;//TalcuSendTaskExecutor
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsSendTask
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsSendTaskReply
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Base
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Memory
 , Classes
 , alcuTaskFileTransferServices
;

constructor TalcuSendTaskExecutor.Create(aList: TddServerTaskList;
 const aRootTaskFolder: AnsiString);
//#UC START# *5485919200F1_54856BFA003E_var*
//#UC END# *5485919200F1_54856BFA003E_var*
begin
//#UC START# *5485919200F1_54856BFA003E_impl*
 inherited Create(aList);
 f_RootTaskFolder := aRootTaskFolder;
//#UC END# *5485919200F1_54856BFA003E_impl*
end;//TalcuSendTaskExecutor.Create

class function TalcuSendTaskExecutor.Make(aList: TddServerTaskList;
 const aRootTaskFolder: AnsiString): IncsExecutor;
var
 l_Inst : TalcuSendTaskExecutor;
begin
 l_Inst := Create(aList, aRootTaskFolder);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TalcuSendTaskExecutor.Make

{$If NOT Defined(Nemesis)}
procedure TalcuSendTaskExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_54856BFA003E_var*
var
 l_Message: TncsSendTask;
 l_Task: TddTaskItem;
 l_Reply: TncsSendTaskReply;
 l_Stream: TStream;
 l_Service: IcsFileTransferServices;
 l_CanAdd: Boolean;
//#UC END# *54607DDC0159_54856BFA003E_var*
begin
//#UC START# *54607DDC0159_54856BFA003E_impl*
 l_Message := aContext.rMessage as TncsSendTask;
 l_Reply := TncsSendTaskReply.Create(l_Message);
 try
  l_Reply.IsSuccess := False;
  l_Stream := Tl3MemoryStream.Make;
  try
   l_Message.Data.CopyTo(l_Stream, l_Message.Data.Size);
   l_Stream.Seek(0, soBeginning);
   l_Task := TddTaskItem.MakeFromEVD(l_Stream, f_RootTaskFolder, True);
   try
    if Assigned(l_Task) and (l_Task is TddProcessTask) then
    begin
     If TddProcessTask(l_Task).HasFilesToTransfer then
     begin
      l_Service := TalcuTaskFileTransferServices.Make(aContext.rTransporter, TddProcessTask(l_Task).TaskID);
      try
       l_CanAdd := TddProcessTask(l_Task).TransferFiles(l_Service);
      finally
       l_Service := nil;
      end;
     end
     else
      l_CanAdd := True;
     if l_CanAdd then
     begin
      IncomingList.Push(TddProcessTask(l_Task));
      l_Reply.IsSuccess := True;
     end; 
    end
    else
     l3System.Msg2Log('Неизвестная задача');
   finally
    FreeAndNil(l_Task);
   end;
  finally
   FreeAndNil(l_Stream);
  end;
  aContext.rTransporter.Send(l_Reply);
 finally
  FreeAndNil(l_Reply);
 end;
//#UC END# *54607DDC0159_54856BFA003E_impl*
end;//TalcuSendTaskExecutor.Execute
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
