unit CsReply;

{ $Id: CsReply.pas,v 1.40 2015/06/16 12:31:59 lukyanets Exp $ }

// $Log: CsReply.pas,v $
// Revision 1.40  2015/06/16 12:31:59  lukyanets
// ����� Indy 10
//
// Revision 1.39  2015/06/05 11:50:09  lukyanets
// ��������� ������� ��� �������� ����
//
// Revision 1.38  2015/03/30 11:16:01  lukyanets
// ��������� ���������� � ������
//
// Revision 1.37  2015/03/25 11:07:13  lukyanets
// �������� ���������
//
// Revision 1.36  2015/03/23 14:50:27  lukyanets
// �������� ��������� �� � �������
//
// Revision 1.35  2015/03/20 14:38:15  lukyanets
// ��������� ��������� ��������� � �������
//
// Revision 1.34  2014/10/24 12:17:42  lukyanets
// Cleanup
//
// Revision 1.33  2014/09/19 11:22:24  lukyanets
// {RequestLink:565273246} - ��������� ������
//
// Revision 1.32  2014/09/19 07:41:41  lukyanets
// {RequestLink:565273246} - ���������� ���������
//
// Revision 1.31  2014/09/12 12:26:58  lukyanets
// �� ������� �� ���������� ����.
//
// Revision 1.30  2014/09/09 07:48:53  lukyanets
// ���������� ����������� ������
//
// Revision 1.29  2014/09/09 07:23:36  lukyanets
// ���������� ����������� ������
//
// Revision 1.28  2014/07/08 07:02:12  lukyanets
// {Requestlink:552022662}. ������ ����
//
// Revision 1.27  2014/07/07 14:40:03  lulin
// - ������ ���� ������������������ �������� ��������.
//
// Revision 1.26  2014/06/09 17:27:15  lulin
// - �������������� "����" ��� ����������� Action'��.
//
// Revision 1.25  2014/06/09 14:00:27  lulin
// - ������ ����������� "�������� �������� �������" � ����������.
//
// Revision 1.24  2014/06/04 12:26:08  lulin
// - ������ ��� ������������ ������� ��������� �������� ������ ����.
//
// Revision 1.23  2014/06/03 16:43:58  lulin
// - ������ ��� ������������ ������� ��������� �������� ������ ����.
//
// Revision 1.22  2014/06/03 16:09:56  lulin
// - ������ ��� ������������ ������� ��������� �������� ������ ����.
//
// Revision 1.21  2014/06/03 15:34:50  lulin
// - ������ ��� ������������ ������� ��������� �������� ������ ����.
//
// Revision 1.20  2014/05/29 13:09:59  lulin
// - ������ ���.
//
// Revision 1.19  2014/05/23 15:37:18  lulin
// {RequestLink:537249703}
//
// Revision 1.18  2014/05/21 13:57:35  lulin
// - ������ ���.
//
// Revision 1.17  2012/02/24 09:15:25  narry
// ������ ���������� �����
// ����� � ��� ����������
//
// Revision 1.16  2011/12/08 12:32:12  narry
// ������������ �� ��� ������� ������� (304874341)
//
// Revision 1.15  2011/04/22 11:48:38  narry
// ������� ������ (262636461)
//
// Revision 1.14  2010/05/17 08:34:02  narry
// - �� ������� � ��� ������ _KeepAlive
//
// Revision 1.13  2010/02/26 09:45:25  narry
// - ������ �� ���������� �����
//
// Revision 1.12  2009/07/22 08:20:23  narry
// - ����� ��������� _KeepAlive
// - cleanup
//
// Revision 1.11  2008/10/01 07:45:40  narry
// - �������� ���� � ������� ����������
//
// Revision 1.10  2008/07/14 07:47:53  narry
// - ��������� ����� � ���� � ������� (������ ���, ������� � �������)
//
// Revision 1.9  2008/03/21 17:32:22  narry
// - ����� ��� ����������� ����� � ������
//
// Revision 1.8  2006/10/12 11:30:40  narry
// - ����� � ��� �������������� ����������
//
// Revision 1.7  2006/09/21 11:47:59  narry
// - ������������ ������� ��������� �� ������� �������
//
// Revision 1.6  2006/09/01 13:55:01  narry
// - ��� ����������� ������� � ������� ����������� ������ ������� � �������
//
// Revision 1.5  2006/08/24 08:48:46  narry
// - �����������: ���������� ��������� ������ ������
//
// Revision 1.4  2006/08/03 13:22:01  narry
// - ���������� ������ ��������� � ������� �� �� �� ����������
//
// Revision 1.3  2006/03/16 15:50:16  narry
// - ��� ���� ����� � ������� ������-�������
//
// Revision 1.2  2006/03/10 09:29:12  voba
// - enh. ����� CsFree etc.
//
// Revision 1.1  2006/02/08 17:24:29  step
// ���������� �������� ���������� �� �������-�������� � ��������� ��������
//

{$I CsDefine.inc}

interface

{$IfDef AppServerSide}
uses
 Contnrs,
 IdContext, IdIOHandler,
 CsObject, CsCommon, CsConst, CsServer,
 CsReplyProceduresPrim,
 CsQueryTypes
 ;

type
 TCsReply = class(TCsObject)
 private
  f_ClientId: TCsClientId;
  f_Context: TIdContext;
  f_ReplyProcedures: TCsReplyProceduresPrim;
  f_Server: TCsServer;
  function IOHandler: TIdIOHandler;
  procedure OnClientIpQuery;
  procedure OnClientReLogin;
  procedure OnClientLoginEx;
  procedure OnClientLogout;
  procedure OnGetProtocolVersion;
  procedure OnKeepAlive;
  function ProcessInternalQuery(aQueryId: TCsQueryId): Boolean;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aServer: TCsServer;
                     aContext: TIdContext;
                     aReplyProcedures: TCsReplyProceduresPrim); reintroduce;
  procedure Run(aLogMessages: Boolean);
  property ClientId: TCsClientId read f_ClientId;
  property Context: TIdContext read f_Context;
  property Server: TCsServer read f_Server;
 end;
{$EndIf AppServerSide}

implementation

{$IfDef AppServerSide}
uses
 Classes,
 SysUtils,
 l3Base,
 l3TempMemoryStream,

 IdGlobal,

 daTypes,
 daDataProviderParams,

 htDataProviderParams,

 CsErrors,
 CsDataPipePrim,
 CsDataPipe,
 CsEventsProcessor,
 csNotification,
 csNotifier,
 CsActiveClients,
 dt_UserConst,
 TypInfo,
 CsProcWithId,
 csReplyTool{,
 csLoopBack}
 ;

constructor TCsReply.Create(aServer: TCsServer;
                                    aContext: TIdContext;
                                    aReplyProcedures: TCsReplyProceduresPrim);
begin
 inherited Create;
 Assert(aServer <> nil);
 Assert(aContext <> nil);
 f_Server := aServer;
 f_Context := aContext;
 f_Context.Connection.IOHandler.MaxLineLength := c_MaxDataStringLength;
 f_Context.Connection.IOHandler.MaxLineAction := maException;
 f_ReplyProcedures := aReplyProcedures;
 f_ClientId := c_WrongClientId; // ���� �� ��������
end;

{ TCsReply }

procedure TCsReply.Cleanup;
begin
 f_Server := nil;
 f_ReplyProcedures := nil;
 inherited;
end;

function TCsReply.IOHandler: TIdIOHandler;
begin
 Result := f_Context.Connection.IOHandler;
end;

procedure TCsReply.OnClientIpQuery;
var
 l_ClientIp: TCsIp;
begin
 l_ClientIp := f_Context.Binding.PeerIP;
 IOHandler.WriteLn(l_ClientIp);
end;

procedure TCsReply.OnClientReLogin;
var
 l_LoginName: string;
 l_Password: string;
 l_ListenIp: TCsIp;
 l_ListenPort: TCsPort;
 l_ClientId: TCsClientId;
 l_ConnectKind: TcsUserConnectKind;
 l_ConnectResult: TcsConnectResult;
begin
 // ������
 l_LoginName := IOHandler.ReadLn;
 l_Password := IOHandler.ReadLn;
 l_ListenIp := IOHandler.ReadLn;
 l_ListenPort := IOHandler.ReadInt32;
 l_ConnectKind := TcsUserConnectKind(IOHandler.ReadInt32);
 l_ConnectResult := cs_crOk;
 // ����������

 // ��� �������� ���������� ���� �� ����� - �� � ��� ��� �� ����
(* if (l_ConnectKind <> cs_uckDeveloper) and f_Server.IsBaseLocked then
 begin
  l_ConnectResult := cs_crBaseLocked;
  l_ClientId := 0;
 end
 else*)
  l_ClientId := f_Server.ActiveClients.Login(l_LoginName,
                                             l_Password,
                                             l_ConnectKind = cs_uckRequireAdminRights,
                                             l_ListenIp,
                                             l_ListenPort,
                                             l_ConnectResult);

 // ��������
 IOHandler.Write(l_ClientId);
 IOHandler.Write(Integer(Ord(l_ConnectResult)));
 // �����������
 if not IsWrongUser(l_ClientID) then
 begin
  f_Server.EventsProcessor.ProcessEvent(c_ClientLogedInEvent, Integer(l_ClientId));
  f_Server.Notifier.SendNotify(c_AllClients, ntUserLogin, Integer(l_ClientID), '');
 end;
end;

procedure TCsReply.OnClientLoginEx;
var
 l_LoginName: string;
 l_Password: string;
 l_ListenIp: TCsIp;
 l_ListenPort: TCsPort;
 l_ClientId: TCsClientId;
 l_DVer, l_AVer: Integer;
 l_ConnectKind: TcsUserConnectKind;
 l_ConnectResult: TcsConnectResult;
 l_DataParams: TdaDataProviderParams;
 l_Stream: TStream;
 l_BaseFlags: TdaBaseFlags;
begin
 // ������
 l_LoginName := IOHandler.ReadLn;
 l_Password := IOHandler.ReadLn;
 l_ListenIp := IOHandler.ReadLn;
 l_ListenPort := IOHandler.ReadInt32;
 l_ConnectKind := TcsUserConnectKind(IOHandler.ReadInt32);
 l_ConnectResult := cs_crOk;

 l_Stream := Tl3TempMemoryStream.Create;
 try

  // ����������
  if (l_ConnectKind <> cs_uckDeveloper) and f_Server.IsBaseLocked then
  begin
   l_ConnectResult := cs_crBaseLocked;
   l_ClientId := 0;
  end
  else
  begin
   l_ClientId := f_Server.ActiveClients.Login(l_LoginName,
                                              l_Password,
                                              l_ConnectKind = cs_uckRequireAdminRights,
                                              l_ListenIp,
                                              l_ListenPort,
                                              l_ConnectResult);
   l_DataParams := nil;

   if Assigned(f_Server.OnLoginExData) then
    f_Server.OnLoginExData(l_DataParams, l_BaseFlags);
   if Assigned(l_DataParams) then
    l_DataParams.SaveToEVD(l_Stream, nil)
   else
    l3System.Msg2Log('�� ��������� DataProviderParams');
  end;

  // ��������
  IOHandler.Write(l_ClientId);
  IOHandler.Write(Cardinal(Byte(l_BaseFlags)));
  l_Stream.Seek(0, soBeginning);
  IOHandler.Write(l_Stream, 0, True);
  l_Stream.Seek(0, soBeginning);
  IOHandler.Write(Integer(Ord(l_ConnectResult)));
 finally
  FreeAndNil(l_Stream);
 end;
 // �����������
 if not IsWrongUser(l_ClientID) then
 begin
  f_Server.EventsProcessor.ProcessEvent(c_ClientLogedInEvent, Integer(l_ClientId));
  f_Server.Notifier.SendNotify(c_AllClients, ntUserLogin, Integer(l_ClientID), '');
 end;
end;

procedure TCsReply.OnClientLogout;
begin
 f_Server.ActiveClients.Logout(ClientId);
 f_Server.EventsProcessor.ProcessEvent(c_ClientLogedOutEvent, Integer(ClientId));
 f_Server.Notifier.SendNotify(c_AllClients, ntUserLogout, Integer(ClientID), '');
end;

procedure TCsReply.OnGetProtocolVersion;
begin
 IOHandler.Write(Integer(c_CsVersion));
end;

procedure TCsReply.OnKeepAlive;
var
 l_Port: Integer;
 l_IP: String;
begin
 l_IP:= IOHandler.Readln;
 l_Port:= IOHandler.ReadInt32;
 if not f_Server.ActiveClients.IsLogged(ClientID) then
  f_Server.RequestLogin(l_IP, l_Port)
 else
  f_Server.ActiveClients.ClientInfoOf(ClientID).LastPing:= Now;
end;

function TCsReply.ProcessInternalQuery(aQueryId: TCsQueryId): Boolean;
begin
 Result := True;
 case aQueryId of
  qtClientIp:
   OnClientIpQuery;
  qtReLogin:
   OnClientReLogin;
  qtLoginEx:
   OnClientLoginEx;
  qtLogout:
   OnClientLogout;
  qtKeepAlive:
   OnKeepAlive;
  qtGetProtocolVersion:
   OnGetProtocolVersion;
  else
   Result := False;
 end;//case aQueryId
end;

procedure TCsReply.Run(aLogMessages: Boolean);
var
 l_Pipe: TCsDataPipe;
begin
 try
  IOHandler.WriteBufferOpen;
  try
   l_Pipe := TCsDataPipe.Create(IOHandler);
   try
    TCsReplyTool.ProcessQuery(l_Pipe, ProcessInternalQuery, f_ReplyProcedures, aLogMessages, f_ClientId);
   finally
    FreeAndNil(l_Pipe);
   end;//try..finally
  finally
   IOHandler.WriteBufferClose;
  end;//try..finally
 finally
  f_Context.Connection.Disconnect(False);
  f_Context.Connection.IOHandler.InputBuffer.Clear;
 end;//try..finally
end;
{$EndIf AppServerSide}

end.

