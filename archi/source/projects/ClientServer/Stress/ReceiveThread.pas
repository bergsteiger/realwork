unit ReceiveThread;

interface

uses
 ncsMessageQueue, l3Base;

type 
 TReceiveThread = class(Tl3ThreadContainer)
 private
  f_Queue : TncsMessageQueue;
 protected
   procedure DoExecute; override;
 protected
   procedure Cleanup; override;
 public
   constructor Create(anQueue: TncsMessageQueue);
 end;

implementation

uses
 SysUtils, ncsMessage, Classes, l3TempMemoryStream, ncsMessageFactory;

{ TReceiveThread }

procedure TReceiveThread.Cleanup;
begin
  FreeAndNil(f_Queue);
  inherited;
end;

constructor TReceiveThread.Create(anQueue: TncsMessageQueue);
begin
 inherited Create;
 anQueue.SetRefTo(F_Queue);
end;

procedure TReceiveThread.DoExecute;
var
 l_Message: TncsMessage;
 l_Message2: TncsMessage;
 l_Stream2: TStream;
begin
 l_Message := nil;
 while f_Queue.Processing do
 begin
  f_Queue.WaitForMessage;
  if f_Queue.ExtractMessage(l_Message) then
  begin
   l_Stream2 := Tl3TempMemoryStream.Create;
   try
    l_Message.SaveToEVD(l_Stream2, nil);
    l_Stream2.Seek(0, soBeginning);
    l_Message2 := TncsMessageFactory.MakeFromEVD(l_Stream2);
    try
    finally
     FreeAndNil(l_Message2);
    end;
   finally
    FreeAndNil(l_Stream2);
   end;
   FreeAndNil(l_Message);
  end;
 end;
end;

end.
