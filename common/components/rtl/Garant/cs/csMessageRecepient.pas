unit csMessageRecepient;

interface

uses
  Classes,
  l3Base,
  l3ProtoObject,
  CsCommon,
  ddClientMessageSortableList,
  csClientMessageRequest,
  csDataPipe
  ;

type
 TcsMessageRecepient = class(Tl3ProtoObject)
 private
  f_ClientID: TcsClientID;
  f_Messages: TddClientMessageSortableList;
  f_TryCount: Integer;
  f_InIO : Integer;
(*  function pm_GetCount: Integer;*)
  function pm_GetHaveMessages: Boolean;
(*  function pm_GetMessages(Index: Integer): TddClientMessage;*)

 protected
  procedure Cleanup; override;

 public
  constructor Create; reintroduce;
  constructor Make(aClientID: TCsClientId);
  procedure AddMessage(aMessage: TddClientMessage);
  procedure ClearMessages;
  procedure LoadFromStream(aStream: TStream);
(*  procedure Messages2Log;*)
  procedure SaveToStream(aStream: TStream);
  procedure WriteMessages(aDataPipe: TcsDataPipe);
  property ClientID: TcsClientID read f_ClientID write f_ClientID;
  //property Count: Integer read pm_GetCount;
  property HaveMessages: Boolean read pm_GetHaveMessages;
  property Messages: TddClientMessageSortableList read f_Messages;
  //property Messages[Index: Integer]: TddClientMessage read pm_GetMessages;
  property TryCount: Integer read f_TryCount write f_TryCount;
 end;
 
implementation

uses
  SysUtils,
  dt_UserConst,
  TypInfo,
  CsNotification,
  l3Memory
  ;

constructor TcsMessageRecepient.Create;
begin
 f_InIO := 0;
 inherited Create;
 f_Messages := TddClientMessageSortableList.Create;
end;

constructor TcsMessageRecepient.Make(aClientID: TCsClientId);
begin
 Create;
 f_ClientID := aClientID;
end;

procedure TcsMessageRecepient.AddMessage(aMessage: TddClientMessage);
begin
 Assert(f_InIO = 0);
 if f_Messages.Count = 0 then
  f_TryCount := 0;
// aMessage.UserID := ClientID;
 f_Messages.Add(aMessage);
end;

procedure TcsMessageRecepient.Cleanup;
begin
 l3Free(f_Messages);
 inherited;
end;

procedure TcsMessageRecepient.ClearMessages;
begin
 Assert(f_InIO = 0);
 f_Messages.Clear;
 f_TryCount := 0;
// l3System.Stack2Log('ќщищен список сообщений');
end;

procedure TcsMessageRecepient.LoadFromStream(aStream: TStream);
var
 l_Count, i: Integer;
 l_Message: TddClientMessage;
begin
 ClearMessages;
 Inc(f_InIO);
 try
  with aStream do
  begin
   if (Size-Position) >= 2*SizeOf(l_Count) then
   begin
    Read(f_ClientID, SizeOf(f_ClientID));
    Read(l_Count, SizeOf(l_Count));
    if (l_Count < 10000) then
    begin
     f_Messages.Lock;
     try
      for i:= 0 to Pred(l_Count) do
      begin
       l_Message := TddClientMessage.Create(ClientID, aStream, true);
       try
        f_Messages.Add(l_Message);
       finally
        FreeAndNil(l_Message);
       end;//try..finally
      end;//for i
     finally
      f_Messages.Unlock;
     end;//try..finally
    end;//l_Count < 10000
   end; // (Size-Position) >= SizeOf(l_Count)
  end; // with aStream
 finally
  Dec(f_InIO);
 end;//try..finally
end;

(*procedure TcsMessageRecepient.Messages2Log;
var
 i: Integer;
begin
 for i:= 0 to f_Messages.Hi do
  with f_Messages.Items[i] do
   l3System.Msg2Log(' %s (Data: %d, Text: "%s")', [GetEnumName(TypeInfo(TCsNotificationType), ord(NotifyType)), Data, Text]);
end;*)

(*function TcsMessageRecepient.pm_GetCount: Integer;
begin
 Result := f_Messages.Count;
end;*)

function TcsMessageRecepient.pm_GetHaveMessages: Boolean;
begin
 Result := f_Messages.Count > 0;
end;

(*function TcsMessageRecepient.pm_GetMessages(Index: Integer): TddClientMessage;
begin
 Result := f_Messages.Items[Index];
end;*)

procedure TcsMessageRecepient.SaveToStream(aStream: TStream);

 function DoIt(anItem: TddClientMessage): Boolean;
 begin
  Result := true;
  anItem.SaveTo(aStream, True);
 end;

var
 l_Count{, i}: Integer;
begin
 Assert(f_InIO = 0);
 Inc(f_InIO);
 try
  with aStream do
  begin
   Write(f_ClientID, SizeOf(f_ClientID));
   l_Count := f_Messages.Count;
   Write(l_Count, SizeOf(l_Count));
   f_Messages.ForEachF(L2DdClientMessageIteratorForEachFAction(@DoIt));
(*   for i:= 0 to f_Messages.Hi do
   begin
    Assert(i <= f_Messages.Hi);
    f_Messages.Items[i].SaveTo(aStream, True);
   end;//for i*)
  end; // with aStream
 finally
  Dec(f_InIO);
 end;//try..finally
end;

procedure TcsMessageRecepient.WriteMessages(aDataPipe: TcsDataPipe);
var
 //i: Integer;
 l_Stream: TStream;
begin
 l_Stream := Tl3memoryStream.Create;
 try
  SaveToStream(l_Stream);
  ClearMessages;
  l_Stream.Seek(0, 0);
  aDataPipe.WriteStream(l_Stream, l_Stream.Size);
 finally
  l3Free(l_Stream);
 end;
 
 f_TryCount := 0;
end;

end.