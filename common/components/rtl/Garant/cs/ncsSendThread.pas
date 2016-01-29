unit ncsSendThread;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsSendThread.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsSendThread
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
  ncsMessage,
  ncsTransporterIOThread
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsSendThread = class(TncsTransporterIOThread)
 private
 // private methods
   procedure Send(aMessage: TncsMessage);
 protected
 // overridden protected methods
   procedure DoExecute; override;
     {* основная процедура нити. Для перекрытия в потомках }
 end;//TncsSendThread
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3TempMemoryStream,
  Classes,
  SysUtils,
  ncsProfile
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsSendThread

procedure TncsSendThread.Send(aMessage: TncsMessage);
//#UC START# *545201B70046_5450E9A0034A_var*
var
 l_Stream: TStream;
//#UC END# *545201B70046_5450E9A0034A_var*
begin
//#UC START# *545201B70046_5450E9A0034A_impl*
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
//#UC END# *545201B70046_5450E9A0034A_impl*
end;//TncsSendThread.Send

procedure TncsSendThread.DoExecute;
//#UC START# *4911B69E037D_5450E9A0034A_var*
var
 l_Message: TncsMessage;
//#UC END# *4911B69E037D_5450E9A0034A_var*
begin
//#UC START# *4911B69E037D_5450E9A0034A_impl*
 try
  l_Message := nil;
  Assert(IOHandler <> nil);
  while not TerminatedConnection do
  begin
   Queue.WaitForMessage;
   if TerminatedConnection then
    Exit;
   while Queue.ExtractMessage(l_Message) do
   try
    if TerminatedConnection then
     Exit;
    Send(l_Message);
   finally
    FreeAndNil(l_Message);
   end;
  end;
 finally
  ReleaseIOHandler;
 end;
//#UC END# *4911B69E037D_5450E9A0034A_impl*
end;//TncsSendThread.DoExecute

{$IfEnd} //not Nemesis

end.