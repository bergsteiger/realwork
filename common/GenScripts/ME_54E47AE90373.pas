unit ncsSynchroServerTransporter;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsSynchroServerTransporter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsSynchroServerTransporter" MUID: (54E47AE90373)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsSynchroTransporter
 , ncsMessageInterfaces
 , csIdIOHandlerAbstractAdapter
;

type
 TncsSynchroServerTransporter = class(TncsSynchroTransporter, IncsServerTransporter)
  protected
   procedure ProcessMessages(IsMainSocket: Boolean);
   procedure Terminate(WaitForTermination: Boolean = True);
   function Get_Terminated: Boolean;
   procedure RegisterSendBackHandler(aHandler: TcsIdIOHandlerAbstractAdapter);
   procedure HandShake; override;
  public
   constructor Create(anIOHandler: TcsIdIOHandlerAbstractAdapter;
    const aSessionID: AnsiString); reintroduce;
   class function IntMake(anIOHandler: TcsIdIOHandlerAbstractAdapter;
    const aSessionID: AnsiString): IncsServerTransporter; reintroduce;
   class function Make(anIOHandler: TcsIdIOHandlerAbstractAdapter): IncsServerTransporter;
 end;//TncsSynchroServerTransporter
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , ncsProfile
 , Classes
 , l3TempMemoryStream
 , ncsMessage
 , ncsMessageFactory
 , l3Base
;

constructor TncsSynchroServerTransporter.Create(anIOHandler: TcsIdIOHandlerAbstractAdapter;
 const aSessionID: AnsiString);
//#UC START# *54E591B50054_54E47AE90373_var*
//#UC END# *54E591B50054_54E47AE90373_var*
begin
//#UC START# *54E591B50054_54E47AE90373_impl*
 inherited Create;
 IOHandler := anIOHandler;
 intSessionID := aSessionID;
//#UC END# *54E591B50054_54E47AE90373_impl*
end;//TncsSynchroServerTransporter.Create

class function TncsSynchroServerTransporter.IntMake(anIOHandler: TcsIdIOHandlerAbstractAdapter;
 const aSessionID: AnsiString): IncsServerTransporter;
var
 l_Inst : TncsSynchroServerTransporter;
begin
 l_Inst := Create(anIOHandler, aSessionID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TncsSynchroServerTransporter.IntMake

class function TncsSynchroServerTransporter.Make(anIOHandler: TcsIdIOHandlerAbstractAdapter): IncsServerTransporter;
//#UC START# *54E5920A003C_54E47AE90373_var*
var
 l_SessionID: AnsiString;
//#UC END# *54E5920A003C_54E47AE90373_var*
begin
//#UC START# *54E5920A003C_54E47AE90373_impl*
 l_SessionID := anIOHandler.ReadLn;
 Result := IntMake(anIOHandler, l_SessionID);
 anIOHandler.WriteInteger(104);
 anIOHandler.WriteBufferFlush;
//#UC END# *54E5920A003C_54E47AE90373_impl*
end;//TncsSynchroServerTransporter.Make

procedure TncsSynchroServerTransporter.ProcessMessages(IsMainSocket: Boolean);
//#UC START# *545335BF0283_54E47AE90373_var*
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
 l_Reply: TncsDisconnectReply;
//#UC END# *545335BF0283_54E47AE90373_var*
begin
//#UC START# *545335BF0283_54E47AE90373_impl*
 StartProcessing;
 try
   while Get_Connected do
    begin
     if IOHandler.WaitForReadData(c_ReadTimeout) then
     begin
      if not Get_Connected then
       Exit;
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
          if l_Message is TncsDisconnect then
          begin
            l_Reply := TncsDisconnectReply.Create(l_Message);
            try
             Send(l_Reply);
            finally
             FreeAndNil(l_Reply);
            end;
            Exit;
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
     end
     else
     begin
      if not Get_Connected then
       Exit;
      Sleep(0);
     end;
    end;
 finally
   StopProcessing;
 end;
//#UC END# *545335BF0283_54E47AE90373_impl*
end;//TncsSynchroServerTransporter.ProcessMessages

procedure TncsSynchroServerTransporter.Terminate(WaitForTermination: Boolean = True);
//#UC START# *5459D46D01FE_54E47AE90373_var*
//#UC END# *5459D46D01FE_54E47AE90373_var*
begin
//#UC START# *5459D46D01FE_54E47AE90373_impl*
 StopProcessing;
//#UC END# *5459D46D01FE_54E47AE90373_impl*
end;//TncsSynchroServerTransporter.Terminate

function TncsSynchroServerTransporter.Get_Terminated: Boolean;
//#UC START# *5459E3150030_54E47AE90373get_var*
//#UC END# *5459E3150030_54E47AE90373get_var*
begin
//#UC START# *5459E3150030_54E47AE90373get_impl*
 Result := (IOHandler = nil) or not IOHandler.Connected;
//#UC END# *5459E3150030_54E47AE90373get_impl*
end;//TncsSynchroServerTransporter.Get_Terminated

procedure TncsSynchroServerTransporter.RegisterSendBackHandler(aHandler: TcsIdIOHandlerAbstractAdapter);
//#UC START# *549180E701E0_54E47AE90373_var*
//#UC END# *549180E701E0_54E47AE90373_var*
begin
//#UC START# *549180E701E0_54E47AE90373_impl*
// Do nothing
//#UC END# *549180E701E0_54E47AE90373_impl*
end;//TncsSynchroServerTransporter.RegisterSendBackHandler

procedure TncsSynchroServerTransporter.HandShake;
//#UC START# *54E3353000D8_54E47AE90373_var*
//#UC END# *54E3353000D8_54E47AE90373_var*
begin
//#UC START# *54E3353000D8_54E47AE90373_impl*
// Do nothing;
// !!! Needs to be implemented !!!
//#UC END# *54E3353000D8_54E47AE90373_impl*
end;//TncsSynchroServerTransporter.HandShake
{$IfEnd} // NOT Defined(Nemesis)

end.
