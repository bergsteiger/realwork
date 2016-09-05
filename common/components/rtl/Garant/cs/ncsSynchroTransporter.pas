unit ncsSynchroTransporter;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsSynchroTransporter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsSynchroTransporter" MUID: (54E333CD0130)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessageInterfaces
 , CsCommon
 , csIdIOHandlerAbstractAdapter
 , ncsMessage
 , Windows
;

type
 TncsSynchroTransporter = class(Tl3ProtoObject, IncsTransporter)
  private
   f_ClientID: TCsClientId;
   f_Connected: Boolean;
   f_IntSessionID: AnsiString;
   f_IOHandler: TcsIdIOHandlerAbstractAdapter;
  protected
   procedure pm_SetIOHandler(aValue: TcsIdIOHandlerAbstractAdapter); virtual;
   procedure SetConnected(aValue: Boolean);
   procedure StartProcessing;
   procedure StopProcessing;
   procedure HandShake; virtual; abstract;
   procedure TransportStarted; virtual;
   procedure ProcessMessage(aMessage: TncsMessage);
   procedure Send(aMessage: TncsMessage);
   function WaitForReply(aMessage: TncsMessage;
    var theReply: TncsMessage;
    aTimeOut: LongWord = Windows.INFINITE): Boolean;
   function Get_Connected: Boolean;
   function Get_ClientID: TCsClientId;
   procedure Set_ClientID(aValue: TCsClientId);
   function Get_Processing: Boolean;
   function Get_SessionID: AnsiString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure ClearFields; override;
  protected
   property IntSessionID: AnsiString
    read f_IntSessionID
    write f_IntSessionID;
   property IOHandler: TcsIdIOHandlerAbstractAdapter
    read f_IOHandler
    write pm_SetIOHandler;
 end;//TncsSynchroTransporter
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , Classes
 , l3TempMemoryStream
 , ncsProfile
 , SysUtils
 , ncsMessageFactory
 , evdNcsTypes
 , l3Base
 , ncsMessageExecutorFactory
 , DateUtils
 //#UC START# *54E333CD0130impl_uses*
 //#UC END# *54E333CD0130impl_uses*
;

procedure TncsSynchroTransporter.pm_SetIOHandler(aValue: TcsIdIOHandlerAbstractAdapter);
//#UC START# *54E334830061_54E333CD0130set_var*
//#UC END# *54E334830061_54E333CD0130set_var*
begin
//#UC START# *54E334830061_54E333CD0130set_impl*
 aValue.SetRefTo(f_IOHandler);
//#UC END# *54E334830061_54E333CD0130set_impl*
end;//TncsSynchroTransporter.pm_SetIOHandler

procedure TncsSynchroTransporter.SetConnected(aValue: Boolean);
//#UC START# *54E334CD02E9_54E333CD0130_var*
//#UC END# *54E334CD02E9_54E333CD0130_var*
begin
//#UC START# *54E334CD02E9_54E333CD0130_impl*
 f_Connected := aValue;
//#UC END# *54E334CD02E9_54E333CD0130_impl*
end;//TncsSynchroTransporter.SetConnected

procedure TncsSynchroTransporter.StartProcessing;
//#UC START# *54E334F5028C_54E333CD0130_var*
//#UC END# *54E334F5028C_54E333CD0130_var*
begin
//#UC START# *54E334F5028C_54E333CD0130_impl*
 Assert(IOHandler <> nil);

 SetConnected(True);

 IOHandler.WriteBufferOpen(-1);
 HandShake;

 TransportStarted;
//#UC END# *54E334F5028C_54E333CD0130_impl*
end;//TncsSynchroTransporter.StartProcessing

procedure TncsSynchroTransporter.StopProcessing;
//#UC START# *54E3350B01CD_54E333CD0130_var*
//#UC END# *54E3350B01CD_54E333CD0130_var*
begin
//#UC START# *54E3350B01CD_54E333CD0130_impl*
  if Assigned(IOHandler) then
   IOHandler.WriteBufferClose;

  SetConnected(False);
  IOHandler := nil;
//#UC END# *54E3350B01CD_54E333CD0130_impl*
end;//TncsSynchroTransporter.StopProcessing

procedure TncsSynchroTransporter.TransportStarted;
//#UC START# *54E335560020_54E333CD0130_var*
//#UC END# *54E335560020_54E333CD0130_var*
begin
//#UC START# *54E335560020_54E333CD0130_impl*
 // Do nothing
//#UC END# *54E335560020_54E333CD0130_impl*
end;//TncsSynchroTransporter.TransportStarted

procedure TncsSynchroTransporter.ProcessMessage(aMessage: TncsMessage);
//#UC START# *54E45D5E01D9_54E333CD0130_var*
var
 l_Executor: IncsExecutor;
 l_FakeReply: TncsMessage;
//#UC END# *54E45D5E01D9_54E333CD0130_var*
begin
//#UC START# *54E45D5E01D9_54E333CD0130_impl*
 l_Executor := TncsMessageExecutorFactory.Instance.MakeExecutor(aMessage);
 if Assigned(l_Executor) then
 begin
   try
    l_Executor.Execute(TncsExecuteContext_C(aMessage, Self))
   except
    on E: Exception do
    begin
     l3System.Msg2Log('Исключение при обработке сообщения %s', [aMessage.TaggedData.TagType.AsString]);
     l3System.Exception2Log(E);
     if aMessage.Kind = ncs_mkMessage then
     begin
      l_FakeReply := TncsInvalidMessage.Create;
      try
       l_FakeReply.Kind := ncs_mkReply;
       l_FakeReply.MessageID := aMessage.MessageID;
       Send(l_FakeReply);
      finally
       FreeAndNil(l_FakeReply);
      end;
     end;
     raise;
    end;
   end;
 end
 else
  l3System.Msg2Log('Не удалось найти Executor для %s', [aMessage.TaggedData.TagType.AsString]);
//#UC END# *54E45D5E01D9_54E333CD0130_impl*
end;//TncsSynchroTransporter.ProcessMessage

procedure TncsSynchroTransporter.Send(aMessage: TncsMessage);
//#UC START# *5464B4E900DA_54E333CD0130_var*
var
 l_Stream: TStream;
//#UC END# *5464B4E900DA_54E333CD0130_var*
begin
//#UC START# *5464B4E900DA_54E333CD0130_impl*
 Assert(Get_Connected);
 g_SendMessage.Start;
 try
  l_Stream := Tl3TempMemoryStream.Create;
  try
   g_SaveMessage.Start;
   try
    aMessage.SaveToEVD(l_Stream, nil);
   finally
    g_SaveMessage.Stop;
   end;
   l_Stream.Seek(0, soFromBeginning);
   IOHandler.WriteStream(l_Stream, l_Stream.Size);
   g_SaveControl.Start;
   try
    IOHandler.WriteBufferFlush;
   finally
    g_SaveControl.Stop;
   end;
  finally
   FreeAndNil(l_Stream);
  end;
 finally
  g_SendMessage.Stop;
 end;
//#UC END# *5464B4E900DA_54E333CD0130_impl*
end;//TncsSynchroTransporter.Send

function TncsSynchroTransporter.WaitForReply(aMessage: TncsMessage;
 var theReply: TncsMessage;
 aTimeOut: LongWord = Windows.INFINITE): Boolean;
//#UC START# *5464B52F02D5_54E333CD0130_var*
const
   { ThreadTimeouts }
  c_ReadTimeout = 300;
var
 l_Stream: TStream;
{$IFDEF ncsSniffMessage}
 l_Stream2: TStream;
 l_Str: AnsiString;
{$ENDIF ncsSniffMessage}
 l_Message: TncsMessage;
 l_InvalidReply: TncsInvalidMessage;
 l_StartTime: TDateTime;
//#UC END# *5464B52F02D5_54E333CD0130_var*
begin
//#UC START# *5464B52F02D5_54E333CD0130_impl*
 Result := False;
 l_StartTime := Now;
 while f_Connected do
  begin
   if (aTimeOut <> INFINITE) and (MillisecondsBetween(Now, l_StartTime) > aTimeOut) then
    Exit;
   if IOHandler.WaitForReadData(c_ReadTimeout) then
   begin
    l_Stream := Tl3TempMemoryStream.Create;
    try
     IOHandler.ReadStream(l_Stream);
     g_ReveiveMessage.Start;
     try
      l_Stream.Seek(0, soFromBeginning);
{$IFDEF ncsSniffMessage}
      l_Stream2 := TFileStream.Create(ParamStr(0)+'.msg', fmOpenWrite);
      try
       l_Stream2.Seek(0, soEnd);
       l_Str := Format('*** %s ***'#13#10, [FormatDateTime('dd.mm.yyyy hh:nn:ss.zzz', Now)]);
       l_Stream2.Write(l_Str[1], Length(l_Str));
       l_STream2.CopyFrom(l_Stream, 0);
       l_Stream.Seek(0, soBeginning);
       l_Str := '*** ! ***'#13#10;
       l_Stream2.Write(l_Str[1], Length(l_Str));
      finally
       FreeAndNil(l_STream2);
      end;
{$ENDIF ncsSniffMessage}

      g_LoadMessage.Start;
      try
       l_Message := TncsMessageFactory.MakeFromEVD(l_Stream);
      finally
       g_LoadMessage.Stop;
      end;
      try
       if Assigned(l_Message) then
       begin
        if l_Message.Kind = ncs_mkReply then
        begin
          Assert(l_Message.MessageID = aMessage.MessageID);
          if l_Message is TncsInvalidMessage then
            Exit
          else
          begin
            Result := True;
            l_Message.SetRefTo(theReply);
            Exit;
          end;
        end
        else
          ProcessMessage(l_Message);
       end
       else
        l3System.Msg2Log('Не удалось разобрать ncsMessage!!');
      finally
       FreeAndNil(l_Message);
      end;
     finally
      g_ReveiveMessage.Stop;
     end;
    finally
     FreeAndNil(l_Stream);
    end;
   end;
  end;
// !!! Needs to be implemented !!!
//#UC END# *5464B52F02D5_54E333CD0130_impl*
end;//TncsSynchroTransporter.WaitForReply

function TncsSynchroTransporter.Get_Connected: Boolean;
//#UC START# *5465AB2B00CA_54E333CD0130get_var*
//#UC END# *5465AB2B00CA_54E333CD0130get_var*
begin
//#UC START# *5465AB2B00CA_54E333CD0130get_impl*
 Result := f_Connected;
//#UC END# *5465AB2B00CA_54E333CD0130get_impl*
end;//TncsSynchroTransporter.Get_Connected

function TncsSynchroTransporter.Get_ClientID: TCsClientId;
//#UC START# *546608F101DE_54E333CD0130get_var*
//#UC END# *546608F101DE_54E333CD0130get_var*
begin
//#UC START# *546608F101DE_54E333CD0130get_impl*
 Result := f_ClientID;
//#UC END# *546608F101DE_54E333CD0130get_impl*
end;//TncsSynchroTransporter.Get_ClientID

procedure TncsSynchroTransporter.Set_ClientID(aValue: TCsClientId);
//#UC START# *546608F101DE_54E333CD0130set_var*
//#UC END# *546608F101DE_54E333CD0130set_var*
begin
//#UC START# *546608F101DE_54E333CD0130set_impl*
 f_ClientID := aValue;
//#UC END# *546608F101DE_54E333CD0130set_impl*
end;//TncsSynchroTransporter.Set_ClientID

function TncsSynchroTransporter.Get_Processing: Boolean;
//#UC START# *5486B96A0025_54E333CD0130get_var*
//#UC END# *5486B96A0025_54E333CD0130get_var*
begin
//#UC START# *5486B96A0025_54E333CD0130get_impl*
 Result := f_Connected;
//#UC END# *5486B96A0025_54E333CD0130get_impl*
end;//TncsSynchroTransporter.Get_Processing

function TncsSynchroTransporter.Get_SessionID: AnsiString;
//#UC START# *548FEF4F002E_54E333CD0130get_var*
//#UC END# *548FEF4F002E_54E333CD0130get_var*
begin
//#UC START# *548FEF4F002E_54E333CD0130get_impl*
 Result := IntSessionID;
//#UC END# *548FEF4F002E_54E333CD0130get_impl*
end;//TncsSynchroTransporter.Get_SessionID

procedure TncsSynchroTransporter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54E333CD0130_var*
//#UC END# *479731C50290_54E333CD0130_var*
begin
//#UC START# *479731C50290_54E333CD0130_impl*
 StopProcessing;

 IOHandler := nil;
 inherited;
//#UC END# *479731C50290_54E333CD0130_impl*
end;//TncsSynchroTransporter.Cleanup

procedure TncsSynchroTransporter.InitFields;
//#UC START# *47A042E100E2_54E333CD0130_var*
//#UC END# *47A042E100E2_54E333CD0130_var*
begin
//#UC START# *47A042E100E2_54E333CD0130_impl*
 inherited;
// !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_54E333CD0130_impl*
end;//TncsSynchroTransporter.InitFields

procedure TncsSynchroTransporter.ClearFields;
begin
 IntSessionID := '';
 inherited;
end;//TncsSynchroTransporter.ClearFields
{$IfEnd} // NOT Defined(Nemesis)

end.
