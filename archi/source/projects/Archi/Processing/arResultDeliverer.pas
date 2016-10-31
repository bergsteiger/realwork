unit arResultDeliverer;

// ������: "w:\archi\source\projects\Archi\Processing\arResultDeliverer.pas"
// ���������: "SimpleClass"
// ������� ������: "TarResultDeliverer" MUID: (545C749003C2)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , l3Base
 {$If NOT Defined(Nemesis)}
 , CsCommon
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces
 {$IfEnd} // NOT Defined(Nemesis)
 , arResultDeliveryInterfaces
 {$If NOT Defined(Nemesis)}
 , ncsTrafficCounter
 {$IfEnd} // NOT Defined(Nemesis)
 , arClientFilesDeliverer
 {$If NOT Defined(Nemesis)}
 , CsDataPipe
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TarResultDeliverer = class(Tl3ThreadContainer)
  private
   f_RequestCounter: Integer;
   {$If NOT Defined(DeliveryByDataPipe)}
   f_Transporter: IncsClientTransporter;
   {$IfEnd} // NOT Defined(DeliveryByDataPipe)
   f_Listener: Pointer;
    {* Weak IarResultDelivererListner }
   f_Counter: IncsTrafficCounter;
   {$If Defined(DeliveryByDataPipe)}
   f_TotalSize: Int64;
   {$IfEnd} // Defined(DeliveryByDataPipe)
   {$If Defined(DeliveryByDataPipe)}
   f_ClientID: TCsClientId;
   {$IfEnd} // Defined(DeliveryByDataPipe)
   {$If Defined(DeliveryByDataPipe)}
   f_Deliverer: TarClientFilesDeliverer;
   {$IfEnd} // Defined(DeliveryByDataPipe)
   f_ServerHost: AnsiString;
   f_ServerPort: Integer;
  private
   {$If NOT Defined(DeliveryByDataPipe)}
   function ReceiveTaskResultByTransporter(const aTaskID: AnsiString): Boolean;
   {$IfEnd} // NOT Defined(DeliveryByDataPipe)
   {$If NOT Defined(DeliveryByDataPipe)}
   procedure DoExecuteByTransporter;
   {$IfEnd} // NOT Defined(DeliveryByDataPipe)
   {$If Defined(DeliveryByDataPipe)}
   procedure DoExecuteByDataPipe;
   {$IfEnd} // Defined(DeliveryByDataPipe)
   {$If Defined(DeliveryByDataPipe)}
   procedure pipe_CheckDelivery(aPipe: TCsDataPipe);
   {$IfEnd} // Defined(DeliveryByDataPipe)
  protected
   function pm_GetClientID: TCsClientId;
   procedure pm_SetClientID(aValue: TCsClientId);
   function pm_GetListener: IarResultDelivererListner; virtual;
   procedure DoExecute; override;
    {* �������� ��������� ����. ��� ���������� � �������� }
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   constructor Create(const aWeakListener: IarResultDelivererListner); reintroduce;
   procedure TerminateProcess;
   procedure RequestDelivery;
   function CanRequestDelivery: Boolean;
   function HasReadyToDeliveryData: Boolean;
  protected
   property Listener: IarResultDelivererListner
    read pm_GetListener;
  public
   property ClientID: TCsClientId
    read pm_GetClientID
    write pm_SetClientID;
   property ServerHost: AnsiString
    read f_ServerHost
    write f_ServerHost;
   property ServerPort: Integer
    read f_ServerPort
    write f_ServerPort;
 end;//TarResultDeliverer
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(Nemesis)}
 , csIdIOHandlerAbstractAdapter
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsFileTransferReg
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsGetReadyToDeliveryTasksReply
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsGetReadyToDeliveryTasks
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsMessage
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsCompatibilityClientTransporter
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsQueryTypes
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsProfile
 {$IfEnd} // NOT Defined(Nemesis)
 , l3StopWatch
 , l3Utils
 , evdNcsTypes
 {$If NOT Defined(Nemesis)}
 , ncsCorrectFolder
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsDeliveryResult
 {$IfEnd} // NOT Defined(Nemesis)
 , Windows
 , Messages
 , l3Interlocked
 {$If NOT Defined(Nemesis)}
 , ncsSynchroCompatibilityClientTransporter
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsQueryRequester
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsConst
 {$IfEnd} // NOT Defined(Nemesis)
 , Classes
 , arOneTaskDeliverer
 //#UC START# *545C749003C2impl_uses*
 //#UC END# *545C749003C2impl_uses*
;

function TarResultDeliverer.pm_GetClientID: TCsClientId;
//#UC START# *545C74C40316_545C749003C2get_var*
//#UC END# *545C74C40316_545C749003C2get_var*
begin
//#UC START# *545C74C40316_545C749003C2get_impl*
{$IFDEF DeliveryByDataPipe}
 Result := f_ClientID;
{$ELSE DeliveryByDataPipe}
 Result := f_Transporter.ClientID;
{$ENDIF DeliveryByDataPipe}
//#UC END# *545C74C40316_545C749003C2get_impl*
end;//TarResultDeliverer.pm_GetClientID

procedure TarResultDeliverer.pm_SetClientID(aValue: TCsClientId);
//#UC START# *545C74C40316_545C749003C2set_var*
//#UC END# *545C74C40316_545C749003C2set_var*
begin
//#UC START# *545C74C40316_545C749003C2set_impl*
{$IFDEF DeliveryByDataPipe}
 f_ClientID := aValue;
{$ELSE DeliveryByDataPipe}
 f_Transporter.ClientID := aValue;
{$ENDIF DeliveryByDataPipe}
//#UC END# *545C74C40316_545C749003C2set_impl*
end;//TarResultDeliverer.pm_SetClientID

function TarResultDeliverer.pm_GetListener: IarResultDelivererListner;
//#UC START# *549AA07C02A4_545C749003C2get_var*
//#UC END# *549AA07C02A4_545C749003C2get_var*
begin
//#UC START# *549AA07C02A4_545C749003C2get_impl*
 Result := IarResultDelivererListner(f_Listener);
//#UC END# *549AA07C02A4_545C749003C2get_impl*
end;//TarResultDeliverer.pm_GetListener

{$If NOT Defined(DeliveryByDataPipe)}
function TarResultDeliverer.ReceiveTaskResultByTransporter(const aTaskID: AnsiString): Boolean;
//#UC START# *5465FDD1009D_545C749003C2_var*
var
 l_Deliverer: TarOneTaskDeliverer;
 l_Folder: AnsiString;
 l_Message: TncsCorrectFolder;
 l_ResultMsg: TncsDeliveryResult;
 l_TryCount: Integer;
 l_Watch: Tl3STopWatch;
 l_ReceiveTime: Double;
 l_WriteTime: Double;
const
 cMaxTryCount = 10;
 cTryDelay = 1000;
//#UC END# *5465FDD1009D_545C749003C2_var*
begin
//#UC START# *5465FDD1009D_545C749003C2_impl*
 l_ReceiveTime := 0;
 l_WriteTime := 0;
{$IFNDEF AQTIME_PROFILE}
 l_Watch.Reset;
 l_Watch.Start;
{$ENDIF AQTIME_PROFILE}
 try
  Result := False;
{$IFNDEF AQTIME_PROFILE}
  Listener.CheckTaskExistence(aTaskID);
{$ENDIF AQTIME_PROFILE}
  l_ResultMsg := TncsDeliveryResult.Create;
  try
   l_ResultMsg.TaskID := aTaskID;

   l_Deliverer := TarOneTaskDeliverer.Create(f_Transporter, aTaskID);
   try
    l_TryCount := 0;
    repeat
     l_ResultMsg.ResultKind := l_Deliverer.Execute;
     l_ReceiveTime := l_ReceiveTime + l_Deliverer.ReceiveTime;
     l_WriteTime := l_WriteTime + l_Deliverer.WriteTime;
     inc(l_TryCount);
     if (l_ResultMsg.ResultKind = ncs_rkRetry) and (l_TryCount < cMaxTryCount) then
     begin
{$IFNDEF AQTIME_PROFILE}
      l3System.Msg2Log('�� ������� �������� ��������, ������� ����� %d', [l_TryCount + 1]);
      Sleep(cTryDelay);
{$ENDIF AQTIME_PROFILE}
     end;
    until (l_ResultMsg.ResultKind <> ncs_rkRetry) or (l_TryCount = cMaxTryCount);
    case l_ResultMsg.ResultKind of
     ncs_rkOk:
      begin
{$IFNDEF AQTIME_PROFILE}
       Listener.RequestSendMessage(Format('���������� �������� �������� � ����� %s', [l_Deliverer.TargetFolder]));
{$ENDIF AQTIME_PROFILE}
       Result := True;
      end;
{$IFNDEF AQTIME_PROFILE}
     ncs_rkFail:
      begin
       if f_Transporter.Processing then
        Listener.RequestSendMessage(Format('�� ������� ��������� ���������� �������� � ����� %s', [l_Deliverer.TargetFolder]));
       Result := False;
      end;
     ncs_rkRetry:
      begin
       l_Folder := l_Deliverer.TargetFolder;
       if Listener.RequestNewFolder(l_Folder) then
       begin
        l_Message := TncsCorrectFolder.Create;
        try
         l_Message.TaskID := aTaskID;
         l_Message.NewFolder := l_Folder;
         f_Transporter.Send(l_Message);
        finally
         FreeAndNil(l_Message);
        end;
        Listener.ChangeResultFolder(aTaskID, l_Folder);
        RequestDelivery;
       end
       else
       begin
        l_ResultMsg.ResultKind := ncs_rkFail;
        Listener.RequestSendMessage(Format('�� ������� ��������� ���������� �������� � ����� %s', [l_Deliverer.TargetFolder]));
       end;
       Result := True;
      end;
     ncs_rkEmpty:
      begin
       Listener.RequestSendMessage('���������� �������� �� �������. ��� �������������� ��������� ��������� �������');
       Result := True;
      end;
     else
      Assert(False);
{$ENDIF AQTIME_PROFILE}
    end;
    if f_Transporter.Processing then
     f_Transporter.Send(l_ResultMsg);
   finally
    FreeAndNil(l_Deliverer);
   end;
  finally
   FreeAndNil(l_ResultMsg);
  end;
 finally
{$IFNDEF AQTIME_PROFILE}
  l_Watch.Stop;
{$ENDIF AQTIME_PROFILE}
 end;
{$IFNDEF AQTIME_PROFILE}
 l3System.Msg2Log('�������� ������ %s ��������� - ����� ����� %s ms', [aTaskID, FormatFloat('#,##0.000', l_Watch.Time * 1000)]);
 l3System.Msg2Log('  - ����� %s kb', [FormatFloat('#,##0', f_Counter.BytesProcessed / 1024)]);
 l3System.Msg2Log('  - �����+������ %s ms', [FormatFloat('#,##0.000', l_ReceiveTime * 1000)]);
 l3System.Msg2Log('  - �������� ������+������ %s kb/s', [FormatFloat('#,##0.000', f_Counter.BytesProcessed / 1024 / l_ReceiveTime)]);
 l3System.Msg2Log('  - ������ %s ms', [FormatFloat('#,##0.000', l_WriteTime * 1000)]);
 l3System.Msg2Log('  - �������� ������ %s kb/s', [FormatFloat('#,##0.000', f_Counter.BytesProcessed / 1024 / l_WriteTime)], 5);
{$ENDIF AQTIME_PROFILE}
//#UC END# *5465FDD1009D_545C749003C2_impl*
end;//TarResultDeliverer.ReceiveTaskResultByTransporter
{$IfEnd} // NOT Defined(DeliveryByDataPipe)

constructor TarResultDeliverer.Create(const aWeakListener: IarResultDelivererListner);
//#UC START# *546AF1220010_545C749003C2_var*
//#UC END# *546AF1220010_545C749003C2_var*
begin
//#UC START# *546AF1220010_545C749003C2_impl*
 inherited Create;
 f_Listener := Pointer(aWeakListener);
//#UC END# *546AF1220010_545C749003C2_impl*
end;//TarResultDeliverer.Create

{$If NOT Defined(DeliveryByDataPipe)}
procedure TarResultDeliverer.DoExecuteByTransporter;
//#UC START# *580DC1050078_545C749003C2_var*
var
 l_OldValue: Integer;
 l_TaskListMsg: TncsGetReadyToDeliveryTasks;
 l_Reply: TncsMessage;
 l_TaskListReply: TncsGetReadyToDeliveryTasksReply;
 l_IDX: Integer;
 l_Watch: Tl3StopWatch;
 l_TotalSize: Int64;


 l_Connect: Tl3StopWatch;
 l_GetList: Tl3StopWatch;
 l_Disconnect: Tl3StopWatch;
//#UC END# *580DC1050078_545C749003C2_var*
begin
//#UC START# *580DC1050078_545C749003C2_impl*
{$IFNDEF AQTIME_PROFILE}
 l_Watch.Reset;
 l_Connect.Reset;
 l_GetList.Reset;
 l_Disconnect.Reset;


 g_SaveMessage.ReSet;
 g_LoadMessage.ReSet;
 g_SendMessage.ReSet;
 g_ReveiveMessage.ReSet;
 g_WaitFile.ReSet;
 g_ReceivePartFile.ReSet;
 g_SaveControl.ReSet;
 g_WriteFile.ReSet;
{$ENDIF AQTIME_PROFILE}

 l_TotalSize := 0;
 try
{$IFNDEF AQTIME_PROFILE}
  l_Watch.Start;
{$ENDIF AQTIME_PROFILE}
  try
{$IFNDEF AQTIME_PROFILE}
   l3System.Msg2Log('������ �������� ����������� ��������');
{$ENDIF AQTIME_PROFILE}
   l_OldValue := f_RequestCounter;
{$IFNDEF AQTIME_PROFILE}
 l_Connect.Start;
{$ENDIF AQTIME_PROFILE}
   f_Transporter.Connect(ServerHost, ServerPort, l3CreateStringGUID);
{$IFNDEF AQTIME_PROFILE}
 l_Connect.Stop;
{$ENDIF AQTIME_PROFILE}
   try
    if not f_Transporter.Connected then
    begin
     l3InterlockedExchange(f_RequestCounter, 0);
{$IFNDEF AQTIME_PROFILE}
     l3System.Msg2Log('����� ����� �� ������ ��������');
{$ENDIF AQTIME_PROFILE}
     Exit;
    end;
    // ���������� ��������
    l_TaskListReply := nil;
    try
     l_Reply := nil;
     l_TaskListMsg := TncsGetReadyToDeliveryTasks.Create;
     try
      l_TaskListMsg.UserID := ClientID;
      f_Transporter.Send(l_TaskListMsg);

{$IFNDEF AQTIME_PROFILE}
 l_GetList.Start;
{$ENDIF AQTIME_PROFILE}
      if f_Transporter.WaitForReply(l_TaskListMsg, l_Reply) then
      begin
{$IFNDEF AQTIME_PROFILE}
 l_GetList.Stop;
{$ENDIF AQTIME_PROFILE}
       l_TaskListReply := l_Reply as TncsGetReadyToDeliveryTasksReply;
       for l_IDX := 0 to l_TaskListReply.TasksIDList.Count - 1 do
       begin
        if not f_Transporter.Processing then
         Exit;
        f_Counter.Reset;
        if not ReceiveTaskResultByTransporter(l_TaskListReply.TasksIDList[l_IDX]) then
         Exit;
        l_TotalSize := l_TotalSize + f_Counter.BytesProcessed;
       end;
       l3InterlockedExchangeAdd(f_RequestCounter, -l_OldValue);
      end
      else
{$IFNDEF AQTIME_PROFILE}
 l_GetList.Stop;
{$ENDIF AQTIME_PROFILE}
     finally
      FreeAndNil(l_TaskListMsg);
     end;
    finally
     FreeAndNil(l_TaskListReply);
    end;
   finally
{$IFNDEF AQTIME_PROFILE}
 l_Disconnect.Start;
{$ENDIF AQTIME_PROFILE}
    f_Transporter.Disconnect;
{$IFNDEF AQTIME_PROFILE}
 l_Disconnect.Stop;
{$ENDIF AQTIME_PROFILE}
   end;
  finally
{$IFNDEF AQTIME_PROFILE}
   l_Watch.Stop;
{$ENDIF AQTIME_PROFILE}
  end;
{$IFNDEF AQTIME_PROFILE}
  l3System.Msg2Log('�������� ��������� - ����� ����� %s ms', [FormatFloat('#,##0.000', l_Watch.Time * 1000)]);
  if l_TotalSize > 0 then
  begin
   l3System.Msg2Log('    - ���������� %s ms', [FormatFloat('#,##0.000', l_Connect.Time * 1000)], 11);
   l3System.Msg2Log('    - ��������� ������ ����� %s ms', [FormatFloat('#,##0.000', l_GetList.Time * 1000)], 11);
   l3System.Msg2Log('    - ���������� %s ms', [FormatFloat('#,##0.000', l_Disconnect.Time * 1000)], 11);
   l3System.Msg2Log('  - ����� ����� %s kb', [FormatFloat('#,##0', l_TotalSize / 1024)]);
   l3System.Msg2Log('  - ����� �������� %s kb/s', [FormatFloat('#,##0.000', l_TotalSize / 1024 / l_Watch.Time)]);
   l3System.Msg2Log('SAVE MESSAGE = %s', [FormatFloat('#,##0.000', g_SaveMessage.Time * 1000)], 11);
   l3System.Msg2Log('SEND MESSAGE = %s', [FormatFloat('#,##0.000', g_SendMessage.Time * 1000)], 11);
   l3System.Msg2Log('LOAD MESSAGE = %s', [FormatFloat('#,##0.000', g_LoadMessage.Time * 1000)], 11);
   l3System.Msg2Log('RECEIVE MESSAGE = %s', [FormatFloat('#,##0.000', g_ReveiveMessage.Time * 1000)], 11);
   l3System.Msg2Log('WAIT FILE = %s', [FormatFloat('#,##0.000', g_WaitFile.Time * 1000)], 11);
   l3System.Msg2Log('RECEIVE FILE = %s', [FormatFloat('#,##0.000', g_ReceivePartFile.Time * 1000)], 11);
   l3System.Msg2Log('WRITE FILE = %s', [FormatFloat('#,##0.000', g_WriteFile.Time * 1000)], 11);
   l3System.Msg2Log('WRITE CONTROL = %s', [FormatFloat('#,##0.000', g_SaveControl.Time * 1000)], 11);
   l3System.Msg2Log('TOTAL = %s', [FormatFloat('#,##0.000', l_Watch.Time * 1000)], 11);
  end;
  l3System.Msg2Log('�������� ����������� �������� ������� ���������');
{$ENDIF AQTIME_PROFILE}
 except
  on E: Exception do
  begin
   l3InterlockedExchange(f_RequestCounter, 0);
{$IFNDEF AQTIME_PROFILE}
   l3System.Msg2Log('�������� ����������� �������� ����������� � �������');
   l3System.Exception2Log(E);
{$ENDIF AQTIME_PROFILE}
   raise;
  end;
 end;
//#UC END# *580DC1050078_545C749003C2_impl*
end;//TarResultDeliverer.DoExecuteByTransporter
{$IfEnd} // NOT Defined(DeliveryByDataPipe)

{$If Defined(DeliveryByDataPipe)}
procedure TarResultDeliverer.DoExecuteByDataPipe;
//#UC START# *580DC11F0204_545C749003C2_var*
var
 l_Watch: Tl3StopWatch;
 l_QueryRequester: TcsQueryRequester;
//#UC END# *580DC11F0204_545C749003C2_var*
begin
//#UC START# *580DC11F0204_545C749003C2_impl*
{$IFNDEF AQTIME_PROFILE}
 l_Watch.Reset;
{$ENDIF AQTIME_PROFILE}
 f_TotalSize := 0;
 try
{$IFNDEF AQTIME_PROFILE}
  l_Watch.Start;
{$ENDIF AQTIME_PROFILE}
  try
{$IFNDEF AQTIME_PROFILE}
   l3System.Msg2Log('������ �������� ����������� ��������');
{$ENDIF AQTIME_PROFILE}
   l_QueryRequester := TcsQueryRequester.Create;
   try
    l_QueryRequester.ClientID := ClientID;
    l_QueryRequester.Write2Log := False;
    l_QueryRequester.Start(ServerHost, ServerPort);
    try
     Assert(False);
     if l_QueryRequester.Exec(qtRequestDelivery, pipe_CheckDelivery) <> cs_errOk then
     begin
      l3InterlockedExchange(f_RequestCounter, 0);
{$IFNDEF AQTIME_PROFILE}
      l3System.Msg2Log('����� ����� ��� ��������');
{$ENDIF AQTIME_PROFILE}
     end;
    finally
     l_QueryRequester.Stop;
    end;
   finally
    FreeAndNil(l_QueryRequester);
   end;
  finally
{$IFNDEF AQTIME_PROFILE}
   l_Watch.Stop;
{$ENDIF AQTIME_PROFILE}
  end;
{$IFNDEF AQTIME_PROFILE}
  l3System.Msg2Log('�������� ��������� - ����� ����� %s ms', [FormatFloat('#,##0.000', l_Watch.Time * 1000)]);
  if f_TotalSize > 0 then
  begin
   l3System.Msg2Log('  - ����� ����� %s kb', [FormatFloat('#,##0', f_TotalSize / 1024)]);
   l3System.Msg2Log('  - ����� �������� %s kb/s', [FormatFloat('#,##0.000', f_TotalSize / 1024 / l_Watch.Time)]);
  end;
  l3System.Msg2Log('�������� ����������� �������� ������� ���������');
{$ENDIF AQTIME_PROFILE}
 except
  on E: Exception do
  begin
   l3InterlockedExchange(f_RequestCounter, 0);
{$IFNDEF AQTIME_PROFILE}
   l3System.Msg2Log('�������� ����������� �������� ����������� � �������');
   l3System.Exception2Log(E);
{$ENDIF AQTIME_PROFILE}
   raise;
  end;
 end;
//#UC END# *580DC11F0204_545C749003C2_impl*
end;//TarResultDeliverer.DoExecuteByDataPipe
{$IfEnd} // Defined(DeliveryByDataPipe)

{$If Defined(DeliveryByDataPipe)}
procedure TarResultDeliverer.pipe_CheckDelivery(aPipe: TCsDataPipe);
//#UC START# *580DF5DF01F5_545C749003C2_var*
var
 l_OldValue: Integer;
//#UC END# *580DF5DF01F5_545C749003C2_var*
begin
//#UC START# *580DF5DF01F5_545C749003C2_impl*
 f_TotalSize := 0;
 f_Deliverer := TarClientFilesDeliverer.Create(aPipe, Listener, RequestDelivery);
 try
  if Terminated then
   f_Deliverer.TerminateProcess;
  l_OldValue := f_RequestCounter;
  f_TotalSize := f_Deliverer.CheckAndDelivery;
  if f_Deliverer.IsSuccess then
   l3InterlockedExchangeAdd(f_RequestCounter, -l_OldValue);
 finally
  FreeAndNil(f_Deliverer);
 end;
//#UC END# *580DF5DF01F5_545C749003C2_impl*
end;//TarResultDeliverer.pipe_CheckDelivery
{$IfEnd} // Defined(DeliveryByDataPipe)

procedure TarResultDeliverer.TerminateProcess;
//#UC START# *545C84E90055_545C749003C2_var*
//#UC END# *545C84E90055_545C749003C2_var*
begin
//#UC START# *545C84E90055_545C749003C2_impl*
 if not Suspended then
 begin
{$IFNDEF DeliveryByDataPipe}
  f_Transporter.Disconnect(True);
{$ELSE DeliveryByDataPipe}
  if Assigned(f_Deliverer) then
   f_Deliverer.TerminateProcess;
{$ENDIF DeliveryByDataPipe}
  Terminate;
 end; 
//#UC END# *545C84E90055_545C749003C2_impl*
end;//TarResultDeliverer.TerminateProcess

procedure TarResultDeliverer.RequestDelivery;
//#UC START# *545C88760010_545C749003C2_var*
//#UC END# *545C88760010_545C749003C2_var*
begin
//#UC START# *545C88760010_545C749003C2_impl*
 l3InterlockedIncrement(f_RequestCounter);
 PostThreadMessage(MainThreadID, WM_NULL, 0, 0);
//#UC END# *545C88760010_545C749003C2_impl*
end;//TarResultDeliverer.RequestDelivery

function TarResultDeliverer.CanRequestDelivery: Boolean;
//#UC START# *545C888301CF_545C749003C2_var*
//#UC END# *545C888301CF_545C749003C2_var*
begin
//#UC START# *545C888301CF_545C749003C2_impl*
 Result := HasReadyToDeliveryData and Suspended;
//#UC END# *545C888301CF_545C749003C2_impl*
end;//TarResultDeliverer.CanRequestDelivery

function TarResultDeliverer.HasReadyToDeliveryData: Boolean;
//#UC START# *549BB1B501D5_545C749003C2_var*
//#UC END# *549BB1B501D5_545C749003C2_var*
begin
//#UC START# *549BB1B501D5_545C749003C2_impl*
 Result := (f_RequestCounter > 0);
//#UC END# *549BB1B501D5_545C749003C2_impl*
end;//TarResultDeliverer.HasReadyToDeliveryData

procedure TarResultDeliverer.DoExecute;
 {* �������� ��������� ����. ��� ���������� � �������� }
//#UC START# *4911B69E037D_545C749003C2_var*
//#UC END# *4911B69E037D_545C749003C2_var*
begin
//#UC START# *4911B69E037D_545C749003C2_impl*
{$IFDEF DeliveryByDataPipe}
 DoExecuteByDataPipe;
{$ELSE DeliveryByDataPipe}
 DoExecuteByTransporter;
{$ENDIF DeliveryByDataPipe}
//#UC END# *4911B69E037D_545C749003C2_impl*
end;//TarResultDeliverer.DoExecute

procedure TarResultDeliverer.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_545C749003C2_var*
//#UC END# *479731C50290_545C749003C2_var*
begin
//#UC START# *479731C50290_545C749003C2_impl*
{$IFNDEF DeliveryByDataPipe}
 f_Transporter.UnregisterHelper(f_Counter);
{$ENDIF DeliveryByDataPipe}
 f_Counter := nil;
 f_Listener := nil;
{$IFNDEF DeliveryByDataPipe}
 f_Transporter := nil;
{$ENDIF DeliveryByDataPipe}
 inherited;
//#UC END# *479731C50290_545C749003C2_impl*
end;//TarResultDeliverer.Cleanup

procedure TarResultDeliverer.InitFields;
//#UC START# *47A042E100E2_545C749003C2_var*
//#UC END# *47A042E100E2_545C749003C2_var*
begin
//#UC START# *47A042E100E2_545C749003C2_impl*
 inherited;
 f_Counter := TncsTrafficCounter.Make;
{$IFNDEF DeliveryByDataPipe}
{$IFDEF csSynchroTransport}
 f_Transporter := TncsSynchroCompatibilityClientTransporter.Make(qtalcuExportResultProcessing);
{$ELSE csSynchroTransport}
 f_Transporter := TncsCompatibilityClientTransporter.Make(qtalcuExportResultProcessing);
{$ENDIF csSynchroTransport}
 f_Transporter.RegisterHelper(f_Counter);
 ncsFileTransferReg.ncsClientRegister;
{$ENDIF DeliveryByDataPipe}
//#UC END# *47A042E100E2_545C749003C2_impl*
end;//TarResultDeliverer.InitFields

procedure TarResultDeliverer.ClearFields;
begin
 ServerHost := '';
 inherited;
end;//TarResultDeliverer.ClearFields
{$IfEnd} // Defined(AppClientSide)

end.
