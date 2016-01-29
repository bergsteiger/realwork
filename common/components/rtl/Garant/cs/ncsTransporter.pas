unit ncsTransporter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsTransporter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsTransporter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  CsCommon,
  csIdIOHandlerAbstractAdapter,
  ncsMessageQueue,
  ncsSendThread,
  ncsReceiveThread,
  ncsProcessThread,
  ncsMessageInterfaces,
  ncsReplyWaiter,
  SyncObjs,
  ncsMessage,
  Windows
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsIOHandlerArray = array [TncsSocketKind] of TcsIdIOHandlerAbstractAdapter;

 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 TncsTransporter = class(_l3CriticalSectionHolder_, IncsTransporter)
 private
 // private fields
   f_Connected : Boolean;
   f_ClientID : TCsClientId;
   f_IOHandlers : TncsIOHandlerArray;
   f_SendQueue : TncsMessageQueue;
    {* Поле для свойства SendQueue}
   f_ReceiveQueue : TncsMessageQueue;
    {* Поле для свойства ReceiveQueue}
   f_SendThread : TncsSendThread;
    {* Поле для свойства SendThread}
   f_ReceiveThread : TncsReceiveThread;
    {* Поле для свойства ReceiveThread}
   f_ProcessThread : TncsProcessThread;
    {* Поле для свойства ProcessThread}
   f_ReplyWaiter : TncsReplyWaiter;
    {* Поле для свойства ReplyWaiter}
   f_IntSessionID : AnsiString;
    {* Поле для свойства IntSessionID}
 protected
 // property methods
   function pm_GetIOHandlers(SocketKind: TncsSocketKind): TcsIdIOHandlerAbstractAdapter;
   procedure pm_SetIOHandlers(SocketKind: TncsSocketKind; aValue: TcsIdIOHandlerAbstractAdapter);
 protected
 // realized methods
   procedure Send(aMessage: TncsMessage);
   function WaitForReply(aMessage: TncsMessage;
    var theReply: TncsMessage;
    aTimeOut: LongWord = INFINITE): Boolean;
   function Get_Connected: Boolean;
   function Get_ClientID: TCsClientId;
   procedure Set_ClientID(aValue: TCsClientId);
   function Get_Processing: Boolean;
   function Get_SessionID: AnsiString;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 protected
 // protected methods
   procedure SetConnected(aValue: Boolean);
   procedure StartProcessing;
     {* Сигнатура метода StartProcessing }
   procedure StopProcessing(WaitForThreads: Boolean);
   procedure HandShake; virtual; abstract;
     {* Сигнатура метода HandShake }
   function HandShakeKind: TncsSocketKind; virtual; abstract;
   procedure TransportStarted; virtual;
     {* Сигнатура метода TransportStarted }
 protected
 // protected properties
   property SendQueue: TncsMessageQueue
     read f_SendQueue;
   property ReceiveQueue: TncsMessageQueue
     read f_ReceiveQueue;
   property SendThread: TncsSendThread
     read f_SendThread;
   property IOHandlers[SocketKind: TncsSocketKind]: TcsIdIOHandlerAbstractAdapter
     read pm_GetIOHandlers
     write pm_SetIOHandlers;
   property ReceiveThread: TncsReceiveThread
     read f_ReceiveThread;
   property ProcessThread: TncsProcessThread
     read f_ProcessThread;
   property ReplyWaiter: TncsReplyWaiter
     read f_ReplyWaiter;
   property IntSessionID: AnsiString
     read f_IntSessionID
     write f_IntSessionID;
 end;//TncsTransporter
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Utils,
  SysUtils,
  evdNcsTypes
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

// start class TncsTransporter

procedure TncsTransporter.SetConnected(aValue: Boolean);
//#UC START# *54533B010030_544A09EE005F_var*
//#UC END# *54533B010030_544A09EE005F_var*
begin
//#UC START# *54533B010030_544A09EE005F_impl*
 f_Connected := aValue;
//#UC END# *54533B010030_544A09EE005F_impl*
end;//TncsTransporter.SetConnected

procedure TncsTransporter.StartProcessing;
//#UC START# *5459C7E00125_544A09EE005F_var*
//#UC END# *5459C7E00125_544A09EE005F_var*
begin
//#UC START# *5459C7E00125_544A09EE005F_impl*
 Lock;
 try
  Assert(IOHandlers[HandShakeKind] <> nil);

  SetConnected(True);

  IOHandlers[HandShakeKind].WriteBufferOpen(-1);
  HandShake;

  Assert(SendThread.Suspended);
  Assert(ReceiveThread.Suspended);

  SendQueue.Processing := True;
  ReceiveQueue.Processing := True;
  SendThread.IOHandler := IOHandlers[ncs_skSend];
  SendThread.Suspended := False;
  ReceiveThread.IOHandler := IOHandlers[ncs_skReceive];
  ReceiveThread.Suspended := False;
  ProcessThread.Suspended := False;
  TransportStarted;
 finally
  Unlock;
 end;
//#UC END# *5459C7E00125_544A09EE005F_impl*
end;//TncsTransporter.StartProcessing

procedure TncsTransporter.StopProcessing(WaitForThreads: Boolean);
//#UC START# *5459C803038D_544A09EE005F_var*
//#UC END# *5459C803038D_544A09EE005F_var*
begin
//#UC START# *5459C803038D_544A09EE005F_impl*
 Lock;
 Try
  SendQueue.Processing := False;
  ReceiveQueue.Processing := False;
  f_ReplyWaiter.Clear;

  if WaitForThreads then
  begin
   ReceiveThread.WaitFor;
   SendThread.WaitFor;
   ProcessThread.WaitFor;
  end;

  if Assigned(IOHandlers[ncs_skSend]) then
  begin
   IOHandlers[ncs_skSend].WriteBufferClose;
   IOHandlers[ncs_skSend].InputBufferClear;
  end;

  if Assigned(IOHandlers[ncs_skReceive]) then
  begin
   IOHandlers[ncs_skReceive].WriteBufferClose;
   IOHandlers[ncs_skReceive].InputBufferClear;
  end;

  SetConnected(False);
  IOHandlers[ncs_skSend] := nil;
  IOHandlers[ncs_skReceive] := nil;
 finally
  Unlock;
 end;
//#UC END# *5459C803038D_544A09EE005F_impl*
end;//TncsTransporter.StopProcessing

procedure TncsTransporter.TransportStarted;
//#UC START# *5492C5F703AA_544A09EE005F_var*
//#UC END# *5492C5F703AA_544A09EE005F_var*
begin
//#UC START# *5492C5F703AA_544A09EE005F_impl*
 // Do nothing
//#UC END# *5492C5F703AA_544A09EE005F_impl*
end;//TncsTransporter.TransportStarted

function TncsTransporter.pm_GetIOHandlers(SocketKind: TncsSocketKind): TcsIdIOHandlerAbstractAdapter;
//#UC START# *545225640060_544A09EE005Fget_var*
//#UC END# *545225640060_544A09EE005Fget_var*
begin
//#UC START# *545225640060_544A09EE005Fget_impl*
 Result := f_IOHandlers[SocketKind];
//#UC END# *545225640060_544A09EE005Fget_impl*
end;//TncsTransporter.pm_GetIOHandlers

procedure TncsTransporter.pm_SetIOHandlers(SocketKind: TncsSocketKind; aValue: TcsIdIOHandlerAbstractAdapter);
//#UC START# *545225640060_544A09EE005Fset_var*
//#UC END# *545225640060_544A09EE005Fset_var*
begin
//#UC START# *545225640060_544A09EE005Fset_impl*
 aValue.SetRefTo(f_IOHandlers[SocketKind]);
//#UC END# *545225640060_544A09EE005Fset_impl*
end;//TncsTransporter.pm_SetIOHandlers

procedure TncsTransporter.Send(aMessage: TncsMessage);
//#UC START# *5464B4E900DA_544A09EE005F_var*
//#UC END# *5464B4E900DA_544A09EE005F_var*
begin
//#UC START# *5464B4E900DA_544A09EE005F_impl*
 if aMessage.Kind = ncs_mkMessage then
  f_ReplyWaiter.SubmitMessage(aMessage);
 f_SendQueue.Push(aMessage);
//#UC END# *5464B4E900DA_544A09EE005F_impl*
end;//TncsTransporter.Send

function TncsTransporter.WaitForReply(aMessage: TncsMessage;
  var theReply: TncsMessage;
  aTimeOut: LongWord = INFINITE): Boolean;
//#UC START# *5464B52F02D5_544A09EE005F_var*
//#UC END# *5464B52F02D5_544A09EE005F_var*
begin
//#UC START# *5464B52F02D5_544A09EE005F_impl*
 Result := f_ReplyWaiter.WaitForReply(aMessage, theReply, aTimeOut);
//#UC END# *5464B52F02D5_544A09EE005F_impl*
end;//TncsTransporter.WaitForReply

function TncsTransporter.Get_Connected: Boolean;
//#UC START# *5465AB2B00CA_544A09EE005Fget_var*
//#UC END# *5465AB2B00CA_544A09EE005Fget_var*
begin
//#UC START# *5465AB2B00CA_544A09EE005Fget_impl*
 Result := f_Connected;
//#UC END# *5465AB2B00CA_544A09EE005Fget_impl*
end;//TncsTransporter.Get_Connected

function TncsTransporter.Get_ClientID: TCsClientId;
//#UC START# *546608F101DE_544A09EE005Fget_var*
//#UC END# *546608F101DE_544A09EE005Fget_var*
begin
//#UC START# *546608F101DE_544A09EE005Fget_impl*
 Result := f_ClientID;
//#UC END# *546608F101DE_544A09EE005Fget_impl*
end;//TncsTransporter.Get_ClientID

procedure TncsTransporter.Set_ClientID(aValue: TCsClientId);
//#UC START# *546608F101DE_544A09EE005Fset_var*
//#UC END# *546608F101DE_544A09EE005Fset_var*
begin
//#UC START# *546608F101DE_544A09EE005Fset_impl*
 f_ClientID := aValue;
//#UC END# *546608F101DE_544A09EE005Fset_impl*
end;//TncsTransporter.Set_ClientID

function TncsTransporter.Get_Processing: Boolean;
//#UC START# *5486B96A0025_544A09EE005Fget_var*
//#UC END# *5486B96A0025_544A09EE005Fget_var*
begin
//#UC START# *5486B96A0025_544A09EE005Fget_impl*
 Result := f_Connected and f_SendQueue.Processing and f_ReceiveQueue.Processing;
 if Result and Assigned(f_SendThread.IOHandler) then
  Result := f_SendThread.IOHandler.Connected;
//#UC END# *5486B96A0025_544A09EE005Fget_impl*
end;//TncsTransporter.Get_Processing

function TncsTransporter.Get_SessionID: AnsiString;
//#UC START# *548FEF4F002E_544A09EE005Fget_var*
//#UC END# *548FEF4F002E_544A09EE005Fget_var*
begin
//#UC START# *548FEF4F002E_544A09EE005Fget_impl*
 Result := IntSessionID;
//#UC END# *548FEF4F002E_544A09EE005Fget_impl*
end;//TncsTransporter.Get_SessionID

procedure TncsTransporter.Cleanup;
//#UC START# *479731C50290_544A09EE005F_var*
//#UC END# *479731C50290_544A09EE005F_var*
begin
//#UC START# *479731C50290_544A09EE005F_impl*
 StopProcessing(True);

 FreeAndNil(f_SendThread);
 FreeAndNil(f_SendQueue);

 FreeAndNil(f_ReceiveThread);
 FreeAndNil(f_ProcessThread);
 FreeAndNil(f_ReceiveQueue);

 IOHandlers[ncs_skSend] := nil;
 IOHandlers[ncs_skReceive] := nil;
 FreeAndNil(f_ReplyWaiter);
 inherited;
//#UC END# *479731C50290_544A09EE005F_impl*
end;//TncsTransporter.Cleanup

procedure TncsTransporter.InitFields;
//#UC START# *47A042E100E2_544A09EE005F_var*
//#UC END# *47A042E100E2_544A09EE005F_var*
begin
//#UC START# *47A042E100E2_544A09EE005F_impl*
 inherited;
 f_ReplyWaiter := TncsReplyWaiter.Create;

 f_SendQueue := TncsMessageQueue.Create;
 f_SendThread := TncsSendThread.Create(f_SendQueue);

 f_ReceiveQueue := TncsMessageQueue.Create;
 f_ReceiveThread := TncsReceiveThread.Create(f_ReceiveQueue);
 f_ProcessThread := TncsProcessThread.Create(f_ReceiveQueue, Self, f_ReplyWaiter);
//#UC END# *47A042E100E2_544A09EE005F_impl*
end;//TncsTransporter.InitFields

{$IfEnd} //not Nemesis

end.