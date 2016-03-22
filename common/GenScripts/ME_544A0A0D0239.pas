unit ncsClientTransporter;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsClientTransporter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsClientTransporter" MUID: (544A0A0D0239)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsTransporter
 , ncsMessageInterfaces
 , idComponent
 , ncsTCPClient
;

type
 TncsClientArray = array [TncsSocketKind] of TncsTCPClient;

 TncsClientTransporter = class(TncsTransporter, IncsClientTransporter)
  private
   f_TCPClients: TncsClientArray;
  private
   procedure TransportConnected;
   procedure SendTransportStatus(ASender: TObject;
    const AStatus: TIdStatus;
    const AStatusText: AnsiString);
   procedure ReceiveTransportStatus(ASender: TObject;
    const AStatus: TIdStatus;
    const AStatusText: AnsiString);
  protected
   procedure BeforeSendHandshake; virtual;
   procedure BeforeReceiveHandshake; virtual;
   procedure Connect(const aServerHost: AnsiString;
    aServerPort: Integer;
    const aSessionID: AnsiString);
   procedure Disconnect(Immidiate: Boolean = False);
    {* Immidiate = True - отрубить сразу
Immidiate = False - дождаться завершения обмена послав ncsDisconnect и дождавшись ответа }
   procedure HandShake; override;
   function HandShakeKind: TncsSocketKind; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   constructor Create; reintroduce;
   class function Make: IncsClientTransporter; reintroduce;
 end;//TncsClientTransporter
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , IdException
 , csIdIOHandlerAdapter
 , csIdIOHandlerAbstractAdapter
 , ncsMessage
;

const
 {* В миллисек }
 c_ClientConnectTimeout = 10 * 1000;
 c_ClientReadTimeout = {$IFDEF CsDebug} 1000 * 1000 {$ELSE} 10 * 1000 {$ENDIF};

procedure TncsClientTransporter.TransportConnected;
//#UC START# *54522FCE0023_544A0A0D0239_var*
var
 l_IOHandler: TcsIdIOHandlerAbstractAdapter;
//#UC END# *54522FCE0023_544A0A0D0239_var*
begin
//#UC START# *54522FCE0023_544A0A0D0239_impl*
 if Get_Connected then
  Exit;

 l_IOHandler := TcsidIOHandlerAdapter.Create(f_TcpClients[ncs_skSend].IOHandler);
 try
  IOHandlers[ncs_skSend] := l_IOHandler;
 finally
  FreeAndNil(l_IOHandler)
 end;
 StartProcessing;
//#UC END# *54522FCE0023_544A0A0D0239_impl*
end;//TncsClientTransporter.TransportConnected

procedure TncsClientTransporter.SendTransportStatus(ASender: TObject;
 const AStatus: TIdStatus;
 const AStatusText: AnsiString);
//#UC START# *545B400202AF_544A0A0D0239_var*
//#UC END# *545B400202AF_544A0A0D0239_var*
begin
//#UC START# *545B400202AF_544A0A0D0239_impl*
 case aStatus of
  hsConnected: TransportConnected;
  hsDisconnected: StopProcessing(False);
 end;
//#UC END# *545B400202AF_544A0A0D0239_impl*
end;//TncsClientTransporter.SendTransportStatus

constructor TncsClientTransporter.Create;
//#UC START# *5465A71E02F2_544A0A0D0239_var*
//#UC END# *5465A71E02F2_544A0A0D0239_var*
begin
//#UC START# *5465A71E02F2_544A0A0D0239_impl*
 inherited Create;
//#UC END# *5465A71E02F2_544A0A0D0239_impl*
end;//TncsClientTransporter.Create

class function TncsClientTransporter.Make: IncsClientTransporter;
var
 l_Inst : TncsClientTransporter;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TncsClientTransporter.Make

procedure TncsClientTransporter.ReceiveTransportStatus(ASender: TObject;
 const AStatus: TIdStatus;
 const AStatusText: AnsiString);
//#UC START# *5491684203A6_544A0A0D0239_var*
//#UC END# *5491684203A6_544A0A0D0239_var*
begin
//#UC START# *5491684203A6_544A0A0D0239_impl*
 case aStatus of
  hsDisconnected: StopProcessing(False);
 end;
//#UC END# *5491684203A6_544A0A0D0239_impl*
end;//TncsClientTransporter.ReceiveTransportStatus

procedure TncsClientTransporter.BeforeSendHandshake;
//#UC START# *549279980264_544A0A0D0239_var*
//#UC END# *549279980264_544A0A0D0239_var*
begin
//#UC START# *549279980264_544A0A0D0239_impl*
// Do nothing
//#UC END# *549279980264_544A0A0D0239_impl*
end;//TncsClientTransporter.BeforeSendHandshake

procedure TncsClientTransporter.BeforeReceiveHandshake;
//#UC START# *549279B300D5_544A0A0D0239_var*
//#UC END# *549279B300D5_544A0A0D0239_var*
begin
//#UC START# *549279B300D5_544A0A0D0239_impl*
// Do nothing
//#UC END# *549279B300D5_544A0A0D0239_impl*
end;//TncsClientTransporter.BeforeReceiveHandshake

procedure TncsClientTransporter.Connect(const aServerHost: AnsiString;
 aServerPort: Integer;
 const aSessionID: AnsiString);
//#UC START# *544A1FD802E9_544A0A0D0239_var*
//#UC END# *544A1FD802E9_544A0A0D0239_var*
begin
//#UC START# *544A1FD802E9_544A0A0D0239_impl*
 if Get_Connected then
  Exit;

 IntSessionID := aSessionID;
 f_TcpClients[ncs_skSend].Host := aServerHost;
 f_TcpClients[ncs_skSend].Port := aServerPort;

 f_TcpClients[ncs_skReceive].Host := aServerHost;
 f_TcpClients[ncs_skReceive].Port := aServerPort;

 try
  f_TcpClients[ncs_skSend].Connect;
 except
  on E: EidException do
   l3System.Exception2Log(E);
 end;
//#UC END# *544A1FD802E9_544A0A0D0239_impl*
end;//TncsClientTransporter.Connect

procedure TncsClientTransporter.Disconnect(Immidiate: Boolean = False);
 {* Immidiate = True - отрубить сразу
Immidiate = False - дождаться завершения обмена послав ncsDisconnect и дождавшись ответа }
//#UC START# *544A1FF00062_544A0A0D0239_var*
var
 l_Message: TncsDisconnect;
 l_Reply: TncsMessage;
//#UC END# *544A1FF00062_544A0A0D0239_var*
begin
//#UC START# *544A1FF00062_544A0A0D0239_impl*
 if not Get_Connected then
  Exit;

 if not Immidiate then
 begin
  l_Message := TncsDisconnect.Create;
  try
   Send(l_Message);
   l_Reply := nil;
   WaitForReply(l_Message, l_Reply);
   if not (l_Reply is TncsDisconnectReply) then
    l3System.Msg2Log('Invalid csDisconnectReply');
   FreeAndNil(l_Reply);
  finally
   FreeAndNil(l_Message);
  end;
 end;

 StopProcessing(True);

 f_TcpClients[ncs_skSend].IOHandler.WriteBufferClose;
 f_TcpClients[ncs_skSend].Disconnect(True);

 f_TcpClients[ncs_skReceive].IOHandler.WriteBufferClose;
 f_TcpClients[ncs_skReceive].Disconnect(True);

 IntSessionID := '';
//#UC END# *544A1FF00062_544A0A0D0239_impl*
end;//TncsClientTransporter.Disconnect

procedure TncsClientTransporter.HandShake;
//#UC START# *5477033C03D0_544A0A0D0239_var*
var
 l_ID: Integer;
 l_IOHandler: TcsIdIOHandlerAbstractAdapter;
//#UC END# *5477033C03D0_544A0A0D0239_var*
begin
//#UC START# *5477033C03D0_544A0A0D0239_impl*
 BeforeSendHandshake;
 IOHandlers[ncs_skSend].WriteInteger(Ord(ncs_skSend));
 IOHandlers[ncs_skSend].WriteLn(IntSessionID);
 IOHandlers[ncs_skSend].WriteBufferFlush;
 l_ID := IOHandlers[ncs_skSend].ReadInteger;
 Assert(l_ID = 104);
 try
  f_TcpClients[ncs_skReceive].Connect;
  l_IOHandler := TcsidIOHandlerAdapter.Create(f_TcpClients[ncs_skReceive].IOHandler);
  try
   IOHandlers[ncs_skReceive] := l_IOHandler;
  finally
   FreeAndNil(l_IOHandler)
  end;
  IOHandlers[ncs_skReceive].WriteBufferOpen(-1);

  BeforeReceiveHandshake;
  IOHandlers[ncs_skReceive].WriteInteger(Ord(ncs_skReceive));
  IOHandlers[ncs_skReceive].WriteLn(IntSessionID);
  IOHandlers[ncs_skReceive].WriteBufferFlush;
  l_ID := IOHandlers[ncs_skReceive].ReadInteger;
  Assert(l_ID = 104);

  IOHandlers[ncs_skSend].WriteInteger(105);
  IOHandlers[ncs_skSend].WriteBufferFlush;
  l_ID := IOHandlers[ncs_skSend].ReadInteger;
  Assert(l_ID = 106);

  IOHandlers[ncs_skReceive].WriteInteger(105);
  IOHandlers[ncs_skReceive].WriteBufferFlush;

 except
  on E: EidException do
   l3System.Exception2Log(E);
 end;
//#UC END# *5477033C03D0_544A0A0D0239_impl*
end;//TncsClientTransporter.HandShake

function TncsClientTransporter.HandShakeKind: TncsSocketKind;
//#UC START# *549175C4030A_544A0A0D0239_var*
//#UC END# *549175C4030A_544A0A0D0239_var*
begin
//#UC START# *549175C4030A_544A0A0D0239_impl*
 Result := ncs_skSend;
//#UC END# *549175C4030A_544A0A0D0239_impl*
end;//TncsClientTransporter.HandShakeKind

procedure TncsClientTransporter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_544A0A0D0239_var*
//#UC END# *479731C50290_544A0A0D0239_var*
begin
//#UC START# *479731C50290_544A0A0D0239_impl*
 Disconnect;
 FreeAndNil(f_TcpClients[ncs_skSend]);
 FreeAndNil(f_TcpClients[ncs_skReceive]);
 inherited;
//#UC END# *479731C50290_544A0A0D0239_impl*
end;//TncsClientTransporter.Cleanup

procedure TncsClientTransporter.InitFields;
//#UC START# *47A042E100E2_544A0A0D0239_var*
//#UC END# *47A042E100E2_544A0A0D0239_var*
begin
//#UC START# *47A042E100E2_544A0A0D0239_impl*
 inherited;
 f_TcpClients[ncs_skSend] := TncsTcpClient.Create(nil);
 f_TcpClients[ncs_skSend].ConnectTimeout := c_ClientConnectTimeout;
 f_TcpClients[ncs_skSend].ReadTimeout := c_ClientReadTimeout;
 f_TcpClients[ncs_skSend].OnStatus := SendTransportStatus;

 f_TcpClients[ncs_skReceive] := TncsTcpClient.Create(nil);
 f_TcpClients[ncs_skReceive].ConnectTimeout := c_ClientConnectTimeout;
 f_TcpClients[ncs_skReceive].ReadTimeout := c_ClientReadTimeout;
 f_TcpClients[ncs_skReceive].OnStatus := ReceiveTransportStatus;

//#UC END# *47A042E100E2_544A0A0D0239_impl*
end;//TncsClientTransporter.InitFields

procedure TncsClientTransporter.ClearFields;
begin
 Finalize(f_TCPClients);
 inherited;
end;//TncsClientTransporter.ClearFields
{$IfEnd} // NOT Defined(Nemesis)

end.
