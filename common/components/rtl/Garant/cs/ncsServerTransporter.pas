unit ncsServerTransporter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/ncsServerTransporter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsServerTransporter
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
  csIdIOHandlerAbstractAdapter,
  ncsTransporter,
  ncsMessageInterfaces,
  ncsMessage,
  Windows,
  CsCommon
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsServerTransporter = class(TncsTransporter, IncsServerTransporter)
 protected
 // realized methods
   procedure ProcessMessages(IsMainSocket: Boolean);
   procedure Terminate(WaitForTermination: Boolean = True);
   function Get_Terminated: Boolean;
   procedure HandShake; override;
     {* ��������� ������ HandShake }
   function HandShakeKind: TncsSocketKind; override;
   procedure RegisterSendBackHandler(aHandler: TcsIdIOHandlerAbstractAdapter);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure TransportStarted; override;
     {* ��������� ������ TransportStarted }
 public
 // public methods
   constructor Create(anIOHandler: TcsIdIOHandlerAbstractAdapter;
     const aSessionID: AnsiString); reintroduce;
   class function IntMake(anIOHandler: TcsIdIOHandlerAbstractAdapter;
     const aSessionID: AnsiString): IncsServerTransporter; reintroduce;
     {* ��������� ������� TncsServerTransporter.IntMake }
   class function Make(anIOHandler: TcsIdIOHandlerAbstractAdapter;
     out IsMainSocket: Boolean): IncsServerTransporter;
 end;//TncsServerTransporter
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  SysUtils,
  ncsServerTransporterPtrPool
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsServerTransporter

constructor TncsServerTransporter.Create(anIOHandler: TcsIdIOHandlerAbstractAdapter;
  const aSessionID: AnsiString);
//#UC START# *5465A67802C1_544A0A21036B_var*
//#UC END# *5465A67802C1_544A0A21036B_var*
begin
//#UC START# *5465A67802C1_544A0A21036B_impl*
 inherited Create;
 IOHandlers[ncs_skReceive] := anIOHandler;
 intSessionID := aSessionID;
 TncsServerTransporterPtrPool.Instance.Register(Self);
//#UC END# *5465A67802C1_544A0A21036B_impl*
end;//TncsServerTransporter.Create

class function TncsServerTransporter.IntMake(anIOHandler: TcsIdIOHandlerAbstractAdapter;
  const aSessionID: AnsiString): IncsServerTransporter;
var
 l_Inst : TncsServerTransporter;
begin
 l_Inst := Create(anIOHandler, aSessionID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

class function TncsServerTransporter.Make(anIOHandler: TcsIdIOHandlerAbstractAdapter;
  out IsMainSocket: Boolean): IncsServerTransporter;
//#UC START# *549195670058_544A0A21036B_var*
var
 l_Kind: TncsSocketKind;
 l_SessionID: AnsiString;
 l_ID: Integer;
//#UC END# *549195670058_544A0A21036B_var*
begin
//#UC START# *549195670058_544A0A21036B_impl*
 l_Kind := TncsSocketKind(anIOHandler.ReadInteger);
 l_SessionID := anIOHandler.ReadLn;
 case l_Kind of
  ncs_skSend:
   begin
    Result := IntMake(anIOHandler, l_SessionID);
    anIOHandler.WriteInteger(104);
    anIOHandler.WriteBufferFlush;
    IsMainSocket := True;
   end;
  ncs_skReceive:
   begin
    Result := TncsServerTransporterPtrPool.Instance.FindTransporter(l_SessionID);
    Assert(Assigned(Result));
    Result.RegisterSendBackHandler(anIOHandler);
    anIOHandler.WriteInteger(104);
    anIOHandler.WriteBufferFlush;
    IsMainSocket := False;
   end;
 end;
 l_ID := anIOHandler.ReadInteger;
 Assert(l_ID = 105);
//#UC END# *549195670058_544A0A21036B_impl*
end;//TncsServerTransporter.Make

procedure TncsServerTransporter.ProcessMessages(IsMainSocket: Boolean);
//#UC START# *545335BF0283_544A0A21036B_var*
//#UC END# *545335BF0283_544A0A21036B_var*
begin
//#UC START# *545335BF0283_544A0A21036B_impl*
 if IsMainSocket then
  StartProcessing;
 try
  ReceiveThread.WaitFor;
 finally
  if IsMainSocket then
   StopProcessing(True)
  else
   while Get_Connected do
    {wait};  
 end;
//#UC END# *545335BF0283_544A0A21036B_impl*
end;//TncsServerTransporter.ProcessMessages

procedure TncsServerTransporter.Terminate(WaitForTermination: Boolean = True);
//#UC START# *5459D46D01FE_544A0A21036B_var*
//#UC END# *5459D46D01FE_544A0A21036B_var*
begin
//#UC START# *5459D46D01FE_544A0A21036B_impl*
 StopProcessing(True);
//#UC END# *5459D46D01FE_544A0A21036B_impl*
end;//TncsServerTransporter.Terminate

function TncsServerTransporter.Get_Terminated: Boolean;
//#UC START# *5459E3150030_544A0A21036Bget_var*
//#UC END# *5459E3150030_544A0A21036Bget_var*
begin
//#UC START# *5459E3150030_544A0A21036Bget_impl*
 Result := (IOHandlers[ncs_skReceive] = nil) or not IOHandlers[ncs_skReceive].Connected or
   (ReceiveThread = nil) or ReceiveThread.Terminated or
   (SendThread = nil) or SendThread.Terminated;
//#UC END# *5459E3150030_544A0A21036Bget_impl*
end;//TncsServerTransporter.Get_Terminated

procedure TncsServerTransporter.HandShake;
//#UC START# *5477033C03D0_544A0A21036B_var*
//#UC END# *5477033C03D0_544A0A21036B_var*
begin
//#UC START# *5477033C03D0_544A0A21036B_impl*
// Do nothing;
//#UC END# *5477033C03D0_544A0A21036B_impl*
end;//TncsServerTransporter.HandShake

function TncsServerTransporter.HandShakeKind: TncsSocketKind;
//#UC START# *549175C4030A_544A0A21036B_var*
//#UC END# *549175C4030A_544A0A21036B_var*
begin
//#UC START# *549175C4030A_544A0A21036B_impl*
 Result := ncs_skReceive;
//#UC END# *549175C4030A_544A0A21036B_impl*
end;//TncsServerTransporter.HandShakeKind

procedure TncsServerTransporter.RegisterSendBackHandler(aHandler: TcsIdIOHandlerAbstractAdapter);
//#UC START# *549180E701E0_544A0A21036B_var*
//#UC END# *549180E701E0_544A0A21036B_var*
begin
//#UC START# *549180E701E0_544A0A21036B_impl*
 IOHandlers[ncs_skSend] := aHandler;
//#UC END# *549180E701E0_544A0A21036B_impl*
end;//TncsServerTransporter.RegisterSendBackHandler

procedure TncsServerTransporter.Cleanup;
//#UC START# *479731C50290_544A0A21036B_var*
//#UC END# *479731C50290_544A0A21036B_var*
begin
//#UC START# *479731C50290_544A0A21036B_impl*
 TncsServerTransporterPtrPool.Instance.UnRegister(Self);
 inherited;
//#UC END# *479731C50290_544A0A21036B_impl*
end;//TncsServerTransporter.Cleanup

procedure TncsServerTransporter.TransportStarted;
//#UC START# *5492C5F703AA_544A0A21036B_var*
//#UC END# *5492C5F703AA_544A0A21036B_var*
begin
//#UC START# *5492C5F703AA_544A0A21036B_impl*
 IOHandlers[HandShakeKind].WriteInteger(106);
 IOHandlers[HandShakeKind].WriteBufferFlush;
//#UC END# *5492C5F703AA_544A0A21036B_impl*
end;//TncsServerTransporter.TransportStarted

{$IfEnd} //not Nemesis

end.