unit ncsSynchroClientTransporter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/ncsSynchroClientTransporter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsSynchroClientTransporter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  ncsTCPClient,
  idComponent,
  ncsMessageInterfaces,
  ncsSynchroTransporter,
  ncsMessage,
  Windows,
  CsCommon
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsSynchroClientTransporter = class(TncsSynchroTransporter, IncsClientTransporter)
 private
 // private fields
   f_TCPClient : TncsTCPClient;
 private
 // private methods
   procedure TransportStatus(ASender: TObject;
     const AStatus: TIdStatus;
     const AStatusText: AnsiString);
   procedure TransportConnected;
     {* ��������� ������ TransportConnected }
 protected
 // realized methods
   procedure Connect(const aServerHost: AnsiString;
    aServerPort: Integer;
    const aSessionID: AnsiString);
   procedure Disconnect(Immidiate: Boolean = False);
     {* Immidiate = True - �������� �����
Immidiate = False - ��������� ���������� ������ ������ ncsDisconnect � ���������� ������ }
   procedure HandShake; override;
     {* ��������� ������ HandShake }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure InitFields; override;
 protected
 // protected methods
   procedure BeforeHandshake; virtual;
     {* ��������� ������ BeforeHandshake }
 public
 // public methods
   constructor Create; reintroduce;
     {* ��������� ������ Create }
   class function Make: IncsClientTransporter; reintroduce;
     {* ��������� ������� TncsSynchroClientTransporter.Make }
 end;//TncsSynchroClientTransporter
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csIdIOHandlerAdapter,
  csIdIOHandlerAbstractAdapter,
  l3Base,
  IdException,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsSynchroClientTransporter

procedure TncsSynchroClientTransporter.TransportStatus(ASender: TObject;
  const AStatus: TIdStatus;
  const AStatusText: AnsiString);
//#UC START# *54E33B3A02CB_54E339B500F7_var*
//#UC END# *54E33B3A02CB_54E339B500F7_var*
begin
//#UC START# *54E33B3A02CB_54E339B500F7_impl*
 case aStatus of
  hsConnected: TransportConnected;
  hsDisconnected: StopProcessing;
 end;
//#UC END# *54E33B3A02CB_54E339B500F7_impl*
end;//TncsSynchroClientTransporter.TransportStatus

procedure TncsSynchroClientTransporter.TransportConnected;
//#UC START# *54E33B5E0245_54E339B500F7_var*
var
 l_IOHandler: TcsIdIOHandlerAbstractAdapter;
//#UC END# *54E33B5E0245_54E339B500F7_var*
begin
//#UC START# *54E33B5E0245_54E339B500F7_impl*
 if Get_Connected then
  Exit;

 l_IOHandler := TcsidIOHandlerAdapter.Create(f_TcpClient.IOHandler);
 try
  IOHandler := l_IOHandler;
 finally
  FreeAndNil(l_IOHandler)
 end;
 StartProcessing;
//#UC END# *54E33B5E0245_54E339B500F7_impl*
end;//TncsSynchroClientTransporter.TransportConnected

constructor TncsSynchroClientTransporter.Create;
//#UC START# *54E33A870172_54E339B500F7_var*
//#UC END# *54E33A870172_54E339B500F7_var*
begin
//#UC START# *54E33A870172_54E339B500F7_impl*
 inherited Create;
//#UC END# *54E33A870172_54E339B500F7_impl*
end;//TncsSynchroClientTransporter.Create

class function TncsSynchroClientTransporter.Make: IncsClientTransporter;
var
 l_Inst : TncsSynchroClientTransporter;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TncsSynchroClientTransporter.BeforeHandshake;
//#UC START# *54E33EA40163_54E339B500F7_var*
//#UC END# *54E33EA40163_54E339B500F7_var*
begin
//#UC START# *54E33EA40163_54E339B500F7_impl*
// Do nothing
//#UC END# *54E33EA40163_54E339B500F7_impl*
end;//TncsSynchroClientTransporter.BeforeHandshake

procedure TncsSynchroClientTransporter.Connect(const aServerHost: AnsiString;
  aServerPort: Integer;
  const aSessionID: AnsiString);
//#UC START# *544A1FD802E9_54E339B500F7_var*
//#UC END# *544A1FD802E9_54E339B500F7_var*
begin
//#UC START# *544A1FD802E9_54E339B500F7_impl*
 if Get_Connected then
  Exit;

 IntSessionID := aSessionID;
 f_TcpClient.Host := aServerHost;
 f_TcpClient.Port := aServerPort;

 try
  f_TcpClient.Connect;
 except
  on E: EidException do
   l3System.Exception2Log(E);
 end;
//#UC END# *544A1FD802E9_54E339B500F7_impl*
end;//TncsSynchroClientTransporter.Connect

procedure TncsSynchroClientTransporter.Disconnect(Immidiate: Boolean = False);
//#UC START# *544A1FF00062_54E339B500F7_var*
var
 l_Message: TncsDisconnect;
 l_Reply: TncsMessage;
//#UC END# *544A1FF00062_54E339B500F7_var*
begin
//#UC START# *544A1FF00062_54E339B500F7_impl*
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

 StopProcessing;

 f_TcpClient.IOHandler.WriteBufferClose;
 f_TcpClient.Disconnect(True);

 IntSessionID := '';
//#UC END# *544A1FF00062_54E339B500F7_impl*
end;//TncsSynchroClientTransporter.Disconnect

procedure TncsSynchroClientTransporter.HandShake;
//#UC START# *54E3353000D8_54E339B500F7_var*
var
 l_ID: Integer;
 l_IOHandler: TcsIdIOHandlerAbstractAdapter;
//#UC END# *54E3353000D8_54E339B500F7_var*
begin
//#UC START# *54E3353000D8_54E339B500F7_impl*
 BeforeHandshake;
 IOHandler.WriteLn(IntSessionID);
 IOHandler.WriteBufferFlush;
 l_ID := IOHandler.ReadInteger;
 Assert(l_ID = 104);
//#UC END# *54E3353000D8_54E339B500F7_impl*
end;//TncsSynchroClientTransporter.HandShake

procedure TncsSynchroClientTransporter.Cleanup;
//#UC START# *479731C50290_54E339B500F7_var*
//#UC END# *479731C50290_54E339B500F7_var*
begin
//#UC START# *479731C50290_54E339B500F7_impl*
 Disconnect;
 FreeAndNil(f_TcpClient);
 inherited;
//#UC END# *479731C50290_54E339B500F7_impl*
end;//TncsSynchroClientTransporter.Cleanup

procedure TncsSynchroClientTransporter.InitFields;
//#UC START# *47A042E100E2_54E339B500F7_var*
const
   { � �������� }
  c_ClientConnectTimeout = 10 * 1000;
  c_ClientReadTimeout = {$IFDEF CsDebug} 1000 * 1000 {$ELSE} 10 * 1000 {$ENDIF};
//#UC END# *47A042E100E2_54E339B500F7_var*
begin
//#UC START# *47A042E100E2_54E339B500F7_impl*
 inherited;
 f_TcpClient := TncsTcpClient.Create(nil);
 f_TcpClient.ConnectTimeout := c_ClientConnectTimeout;
 f_TcpClient.ReadTimeout := c_ClientReadTimeout;
 f_TcpClient.OnStatus := TransportStatus;
//#UC END# *47A042E100E2_54E339B500F7_impl*
end;//TncsSynchroClientTransporter.InitFields

{$IfEnd} //not Nemesis

end.