unit csMessageManager;

{ $Id: csMessageManager.pas,v 1.55 2014/08/22 12:54:45 lukyanets Exp $ }

// $Log: csMessageManager.pas,v $
// Revision 1.55  2014/08/22 12:54:45  lukyanets
// {Requestlink:563199760}. ��������� ������� ������
//
// Revision 1.54  2014/07/30 12:53:25  lukyanets
// Rage check error
//
// Revision 1.53  2014/07/29 10:02:24  lukyanets
// ������������ �� ��� ���
//
// Revision 1.52  2014/07/21 09:26:56  lulin
// - ��������� ������.
//
// Revision 1.51  2014/07/08 07:02:12  lukyanets
// {Requestlink:552022662}. ������ ����
//
// Revision 1.50  2014/06/19 13:49:03  lulin
// - ������ ���������������� ������ �������������.
//
// Revision 1.49  2014/06/19 13:31:41  lulin
// - ������ ���������������� ������ �������������.
//
// Revision 1.48  2014/06/19 12:49:46  lulin
// - ������ ���������������� ������ �������������.
//
// Revision 1.47  2014/06/09 17:27:15  lulin
// - �������������� "����" ��� ����������� Action'��.
//
// Revision 1.46  2014/06/06 13:14:14  lulin
// - ������ ���.
//
// Revision 1.45  2014/06/05 16:41:28  lulin
// - ������� �������� ��� ����������, ������� � ��� ������� �� �������������.
//
// Revision 1.44  2014/06/05 16:16:59  lulin
// - �� ������� ���������� ���������, � ��� � ��� �������� �� ������.
// - ������������ ������ � ����� ���������.
//
// Revision 1.43  2014/06/05 13:45:07  lulin
// - ������ ���.
//
// Revision 1.42  2014/06/02 10:55:34  lulin
// - �������� �����.
//
// Revision 1.41  2014/05/30 11:28:51  lulin
// - ������� "�����" �� ����.
//
// Revision 1.40  2014/05/30 10:36:53  lulin
// - ����������� �� ������ ����������� ������ ����������.
//
// Revision 1.39  2014/05/28 14:42:26  lulin
// - ������� � AV ��� ������ �������� ����������� �������������.
//
// Revision 1.38  2014/05/21 13:57:35  lulin
// - ������ ���.
//
// Revision 1.37  2014/02/12 16:47:11  lulin
// - ���������� �������� ������.
//
// Revision 1.36  2014/02/12 12:35:25  lulin
// - ���������� ������ �������.
//
// Revision 1.35  2014/02/11 13:40:10  lulin
// - ����������� �����.
//
// Revision 1.34  2013/12/11 10:40:40  fireton
// - ������ ���������
//
// Revision 1.33  2013/04/19 13:09:32  lulin
// - ���������.
//
// Revision 1.32  2013/02/06 10:05:47  narry
// ����������
//
// Revision 1.31  2013/01/21 11:15:31  fireton
// - [$362978911]
//
// Revision 1.30  2011/04/22 11:48:38  narry
// ������� ������ (262636461)
//
// Revision 1.29  2010/02/24 10:30:50  narry
// - �������� ����������� �������� �� �����
//
// Revision 1.28  2009/07/22 08:20:23  narry
// - ����� ��������� _KeepAlive
// - cleanup
//
// Revision 1.27  2009/04/13 07:10:24  narry
// - ����������
//
// Revision 1.26  2009/03/13 15:15:30  narry
// - ��������� ����� �������� ��������� ������������
//
// Revision 1.25  2008/03/20 09:48:27  lulin
// - cleanup.
//
// Revision 1.24  2008/02/21 18:37:19  lulin
// - ������� �������� ��������.
//
// Revision 1.23  2008/02/21 18:13:23  lulin
// - ����������� �� �������� �����.
//
// Revision 1.22  2008/02/07 14:44:35  lulin
// - ����� _Tl3LongintList �������� � ����������� ������.
//
// Revision 1.21  2008/02/05 09:57:57  lulin
// - �������� ������� ������� � ��������� ����� � ��������� �� �� ������.
//
// Revision 1.20  2008/02/01 15:14:42  lulin
// - ����������� �� �������� ��������������� �������.
//
// Revision 1.19  2007/08/14 12:25:41  narry
// - ������� ����� �������������� ���������
//
// Revision 1.18  2007/05/07 07:32:02  narry
// - range check
//
// Revision 1.17  2006/12/01 15:03:49  narry
// - ������ � range check
//
// Revision 1.16  2006/11/29 08:34:47  narry
// - ������ � range check
//
// Revision 1.15  2006/11/28 11:19:25  narry
// - ������: ���������� ���� ��� ��������� ��������� �� �������
//
// Revision 1.14  2006/11/27 15:57:40  narry
// - range check
//
// Revision 1.13  2006/09/26 12:10:17  narry
// - ������ ������ ��������� � ���
//
// Revision 1.12  2006/09/21 09:59:51  narry
// no message
//
// Revision 1.11  2006/09/15 06:50:55  narry
// - ������� ������ ����������� ����� �������� � ��������
//
// Revision 1.10  2006/09/14 08:11:25  narry
// - ������ � ����������� ������ ��������� ���������
//
// Revision 1.9  2006/09/07 09:51:16  narry
// no message
//
// Revision 1.8  2006/08/24 08:49:11  narry
// no message
//
// Revision 1.7  2006/08/02 12:57:14  narry
// - ������
//
// Revision 1.6  2006/08/02 12:18:46  narry
// - ������� ��� ��������� � �������
//
// Revision 1.5  2006/06/26 13:17:04  lulin
// - ������ �����������, �������� �������� �� �����.
//
// Revision 1.3  2006/06/07 14:11:15  narry
// - �����������: ����� ���� ��������� ������� � �������
//
// Revision 1.2  2006/06/05 15:00:09  narry
// - ����������
//
// Revision 1.1  2006/06/05 14:51:01  narry
// - ����� ������: ������� �������� �����������
//

{$Include csDefine.inc}

interface

{$If defined(AppServerSide) AND not defined(Nemesis)}

uses
  CsServer, CsDataPipe, csNotification, csCommon,
  csRequestTask,
  l3Base, l3Types,
  SyncObjs, IdGlobal,
  Classes,
  l3ObjectRefList,
  ddServerTask,
  ddClientMessageList,
  csClientMessageRequest,
  csMessageRecepient,
  csMessageRecepientList,
  l3ProtoObject,
  dt_Types
  ;

type
 TcsMessageManager = class(Tl3ProtoObject)
 private
  f_CS: TCriticalSection;
  f_CSServer: TcsServer;
  f_FileName: AnsiString;
  f_LogMessages: Boolean;
  f_maxTryCount: Integer;
  f_NotifyList: TcsMessageRecepientList;
  function FindRecipient(aClientID: TCsClientId): TcsMessageRecepient;
  procedure MarkRecepientAsDead(aRecepient: TcsMessageRecepient);
  procedure pm_SetCSServer(const Value: TcsServer);
  procedure _SendOne(aClientID: TUserID; aMessage: TddClientMessage);
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aFileName: AnsiString); reintroduce;
  procedure cs_GetMyMessagesReply(aPipe: TCSDataPipe);
  function GetRecepient(aClientID: TCsClientId): TcsMessageRecepient;
  procedure DropAllMessagesForUser(aRecepient: TCsClientId);
  procedure LoadMessages;
  procedure ProcessList;
  procedure SaveMessages;
  procedure SendMessage(aClientID: TCsClientId; aMessage: TddClientMessage; ExcludeID : Integer = -1);
  procedure SendNotify(aClientId: TCsClientId; aType: TCsNotificationType; aNumber: Integer; const aText: AnsiString;
      ExcludeID: Integer = -1);
  procedure SendTextMessage(aClientID: TCsClientId; aMessage: AnsiString; aPriority: Integer = 0);
  property CSServer: TcsServer read f_CSServer write pm_SetCSServer;
  property maxTryCount: Integer read f_maxTryCount write f_maxTryCount;
 published
  property LogMessages: Boolean read f_LogMessages write f_LogMessages;
 end;
{$IfEnd defined(AppServerSide) AND not defined(Nemesis)}

implementation

{$If defined(AppServerSide) AND not defined(Nemesis)}

uses
 csQueryTypes, CsNotifier,
 l3Stream, l3Memory,
dt_UserConst,
 SysUtils,
 dtUserIDList
 , TypInfo;

constructor TcsMessageManager.Create(const aFileName: AnsiString);
begin
 inherited Create;
 f_CS := TCriticalSection.Create;
 f_NotifyList := TcsMessageRecepientList.Create;
 f_FileName := aFileName;
 f_MaxTryCount := 120;
 LogMessages:= False;
 LoadMessages;
end;

procedure TcsMessageManager.Cleanup;
begin
 SaveMessages;
 l3Free(f_NotifyList);
 l3Free(f_CS);
 inherited;
end;

procedure TcsMessageManager.cs_GetMyMessagesReply(aPipe: TCSDataPipe);
var
 l_ClientID: TcsClientID;
 l_Recepient: TcsMessageRecepient;
begin
 f_CS.Acquire;
 try
  l_ClientID := TcsClientID(aPipe.ReadCardinal);
  l_Recepient:= GetRecepient(l_ClientID);
  if LogMessages then
  begin
   l3System.Msg2Log('�������� %d ���������:', [l_Recepient.Messages.Count]);
//   l_Recepient.Messages2Log;
  end; // LogMessages
  l_Recepient.WriteMessages(aPipe);
 finally
  f_CS.Leave;
 end;
end;

function TcsMessageManager.FindRecipient(aClientID: TCsClientId): TcsMessageRecepient;

 function DoIt(anItem: TcsMessageRecepient): Boolean;
 begin
  Result := true;
  if (anItem.ClientID = aClientID) then
  begin
   FindRecipient := anItem;
   Result := false;
  end;
 end;

(*var
 i: Integer;*)
begin
 Result := nil;
 f_NotifyList.ForEachF(L2CsMessageRecepientIteratorForEachFAction(@DoIt));
(* for i := 0 to f_NotifyList.Hi do
 begin
  if f_NotifyList.Items[i].ClientID = aClientID then
  begin
   Result := f_NotifyList.Items[i];
   break;
  end;
 end;*)
end;

function TcsMessageManager.GetRecepient(aClientID: TCsClientId): TcsMessageRecepient;
var
 l_MR: TcsMessageRecepient;
begin
 Result := FindRecipient(aClientID);
 if Result = nil then
 begin
  l_MR:= TcsMessageRecepient.make(aClientID);
  try
   Result := f_NotifyList.Add(l_MR);
  finally
   l3Free(l_MR);
  end;
 end;
end;

procedure TcsMessageManager.LoadMessages;
var
 l_Count, i: Integer;
 l_Stream: TStream;
 l_Mr: TcsMessageRecepient;
begin
 if FileExists(f_FileName) then
 begin
  f_NotifyList.Clear;
  l_Stream := Tl3FileStream.Create(f_FileName, l3_fmRead);
  try
   if l_Stream.Size > SizeOf(Integer) then
   begin
    l_Stream.ReadBuffer(l_Count, SizeOf(Integer));
    for i:= 0 to Pred(l_Count) do
    begin
     l_MR := TcsMessageRecepient.Create;
     try
      l_MR.LoadFromStream(l_Stream);
      if l_MR.HaveMessages then
       f_NotifyList.Add(l_MR);
     finally
      l3Free(l_MR);
     end;
    end; // for i
   end; // l_Stream.Size > SizeOf(Integer)
  finally
   l3Free(l_Stream);
  end; // try..finally
 end; // FileExists(f_FileName)
end;

procedure TcsMessageManager.MarkRecepientAsDead(aRecepient: TcsMessageRecepient);
begin
 // ���� ���������� ��� ��������� ��� ������� �������������, ����� ����� ����� ��������� ���-������ ��������
 // ���������� � ��� �������������� ���������
// l3System.Msg2Log('��������� ��������� ��� ������������ %d', [aRecepient.ClientID]);
(* aRecepient.Messages2Log;*)
 aRecepient.ClearMessages;
end;

procedure TcsMessageManager.DropAllMessagesForUser(aRecepient: TCsClientId);
var
 l_MR: TcsMessageRecepient;
begin
 l_MR := FindRecipient(aRecepient);
 if l_MR <> nil then
//  MarkRecepientAsDead(l_MR);
  l_MR.ClearMessages;
end;

procedure TcsMessageManager.pm_SetCSServer(const Value: TcsServer);
begin
 if f_CSServer <> Value then
 begin
  f_CSServer := Value;
  f_CSServer.RegisterReplyProcedure(qtGetMymessages, cs_GetMyMessagesReply);
 end; // f_CSServer <> Value
end;

procedure TcsMessageManager.ProcessList;

 function DoIt(anItem: TcsMessageRecepient): Boolean;
 begin
  Result := true;
  if anItem.HaveMessages then
  begin
   if CSServer.ActiveClients.IsLogged(anItem.ClientID) then
   begin
    if (anItem.TryCount < MaxTryCount) then
    begin
     CSServer.Notifier.SendNotify(anItem.ClientID, ntHaveNewMessages, anItem.Messages.Count, '');
     anItem.TryCount := anItem.TryCount + 1;
    end
    else // ��������� ������� ���� �����
     {MarkRecepientAsDead(anItem)}; // ������ �� ��������� �� ������� �������, �������� ��� "��������"
   end
   else
//    MarkRecepientAsDead(anItem); // ������ �����������, �������� ��� "��������"
    anItem.TryCount := 0;
  end;//anItem.HaveMessages
 end;

(*var
 i: Integer;
 l_MR: TcsMessageRecepient;*)
begin
 // ��������� ���� ��������, ������� �� �����������
 Assert(CSServer <> nil, '��� ������ ����� ��������� CSServer');
 f_NotifyList.ForEachF(L2CsMessageRecepientIteratorForEachFAction(@DoIt));
(* for i:= 0 to f_NotifyList.Hi do
 begin
  l_MR := f_NotifyList.Items[i];
  if l_MR.HaveMessages then
  begin
   if CSServer.ActiveClients.IsLogged(l_MR.ClientID) then
   begin
    if l_MR.TryCount < MaxTryCount then
    begin
     CSServer.Notifier.SendNotify(l_MR.ClientID, ntHaveNewMessages, l_MR.Count, '');
     l_MR.TryCount := l_MR.TryCount + 1;
    end
    else // ��������� ������� ���� �����
     {MarkRecepientAsDead(l_MR)}; // ������ �� ��������� �� ������� �������, �������� ��� "��������"
   end
   else
//    MarkRecepientAsDead(l_MR); // ������ �����������, �������� ��� "��������"
    l_MR.TryCount := 0;
  end; // l_MR.HaveMessages
 end; // for i*)
end;

procedure TcsMessageManager.SaveMessages;

var
 l_Stream: TStream;
 
 function DoIt(anItem: TcsMessageRecepient): Boolean;
 begin
  Result := true;
  anItem.SaveToStream(l_Stream);
 end;

var
 l_Count{, i}: Integer;
begin
  l_Stream := Tl3FileStream.Create(f_FileName, l3_fmExclusiveWrite);
  try
   l_Count:= f_NotifyList.Count;
   l_Stream.WriteBuffer(l_Count, SizeOf(Integer));
   f_NotifyList.ForEachF(L2CsMessageRecepientIteratorForEachFAction(@DoIt));
(*   for i:= 0 to Pred(l_Count) do
    f_NotifyList.Items[i].SaveToStream(l_Stream);*)
  finally
   l3Free(l_Stream);
  end;
end;

procedure TcsMessageManager.SendMessage(aClientID: TCsClientId; aMessage: TddClientMessage; ExcludeID : Integer = -1);
var
 i: Integer;
 l_List : TdtUserIDList;
begin
 Assert(Self <> nil);
 if CSServer = nil then
  Exit;
 f_CS.Acquire;
 try
  if aClientID = c_AllClients then
  begin
   l_List := TdtUserIDList.Make;
   try
    CSServer.ActiveClients.AllClientIds(l_List);
    for i:= 0 to l_List.Hi do
     if l_List.Items[i] <> ExcludeID then
      _SendOne(l_List.Items[i], aMessage);
   finally
    l3Free(l_List);
   end;
  end
  else
   _SendOne(aClientID, aMessage);
  SaveMessages; 
 finally
  f_CS.Leave;
 end;
end;

procedure TcsMessageManager.SendNotify(aClientId: TCsClientId; aType: TCsNotificationType; aNumber: Integer; const
    aText: AnsiString; ExcludeID: Integer = -1);
var
 l_Msg : TddClientMessage;
begin
 if (aClientID <> ExcludeID) then
 begin
  l_Msg := TddClientMessage.Create(aClientId, aNumber, aType, aText);
  try
   //l_Msg.Data := aNumber;
   //l_Msg.NotifyType := aType;
   //l_Msg.Text := aText;
   SendMessage(aClientID, l_Msg, ExcludeID);
  finally
   l3free(l_Msg);
  end;
 end;
end;

procedure TcsMessageManager._SendOne(aClientID: TUserID; aMessage: TddClientMessage);
var
 l_Recepient : TcsMessageRecepient;
begin
 // ��������� � ������ � ����������� ������������ ����� ���������, �������� ��� �����������
 l_Recepient := GetRecepient(aClientID);
 l_Recepient.AddMessage(aMessage);
 if LogMessages then
  l3System.Msg2Log('�������� ����������� %d ��� %s', [aClientID, GetEnumName(TypeInfo(TCsNotificationType), ord(aMessage.NotifyType))]);
 CSServer.Notifier.SendNotify(aClientID, ntHaveNewMessages, l_Recepient.Messages.Count, '');
end;

procedure TcsMessageManager.SendTextMessage(aClientID: TCsClientId; aMessage: AnsiString; aPriority: Integer = 0);
begin
 SendNotify(aClientID, ntInformation, aPriority, aMessage);
end;

{$IfEnd defined(AppServerSide) AND not defined(Nemesis)}

end.
