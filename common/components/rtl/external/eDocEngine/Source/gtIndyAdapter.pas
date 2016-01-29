{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2012 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }
{$I gtDefines.inc}
{$I gtDocDefines.inc}
unit gtIndyAdapter;

interface

uses
  Classes, StrUtils, SysUtils, gtCstDocEng,
  IdComponent, IdTCPConnection,
  IdTCPClient, IdMessageClient,
  IdSMTP, IdBaseComponent, IdMessage, {$IFDEF Indy1000Up} IdAttachmentfile,
  IdExplicitTLSClientServerBase, IdSMTPBase, IdReplySMTP, {$ENDIF}
  IdSSLOpenSSL, IdGlobal;

type
  TgtIndyAdapter = class(TgtEmailAdapter)
  Private
    function GetAddressString(AText: String): String;
  protected
    procedure SendMail; override;
  public
    property OnEmailConnected;
    property OnEmailDisConnected;
    // property OnEmailStatus;
    property OnEmailSuccess;
  end;

implementation

{ TgtIndyAdapter }
function TgtIndyAdapter.GetAddressString(AText: String): String;
begin
  if Length(AText) = 0 then
  begin
    Result := '';
    exit;
  end;
  Result := Trim(AText);
  Result := StringReplace(Result, CR + LF, ';', [rfReplaceAll]);
  if (Result <> '') and (Result[Length(Result)] = ';') then
    System.Delete(Result, Length(Result), 1);
end;

procedure TgtIndyAdapter.SendMail;
var
  LEMailSettings: TgtEMailSettings;
  IdMessage: TIdMessage;
  IdSMTP: TIdSMTP;
  I: Integer;
{$IFDEF Indy1000Up}
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
{$ENDIF}
{$IFDEF Indy900Up}
  IdSSLIOHandlerSocket1: TIdSSLIOHandlerSocket;
{$ENDIF}
begin
  LEMailSettings := EmailSettings.Clone;
{$IFDEF Indy1000Up}
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
{$ENDIF}
{$IFDEF Indy900Up}
  IdSSLIOHandlerSocket1 := TIdSSLIOHandlerSocket.Create(nil);
{$ENDIF}
  IdMessage := TIdMessage.Create(nil);
  IdSMTP := TIdSMTP.Create(nil);
  with IdMessage do
    try
{$IFDEF Indy1000Up}
      SSLHandler.MaxLineAction := maException;
      SSLHandler.SSLOptions.Method := sslvTLSv1;
      SSLHandler.SSLOptions.Mode := sslmUnassigned;
      SSLHandler.SSLOptions.VerifyMode := [];
      SSLHandler.SSLOptions.VerifyDepth := 0;
      IdSMTP.IOHandler := SSLHandler;
{$ENDIF}
{$IFDEF Indy900Up}
      with IdSSLIOHandlerSocket1 do
      begin
        SSLOptions.Method := sslvSSLv23;
        SSLOptions.Mode := sslmUnassigned;
        SSLOptions.VerifyMode := [];
        SSLOptions.VerifyDepth := 0;
        IdSMTP.IOHandler := IdSSLIOHandlerSocket1;
      end;
{$ENDIF}
      { Assign user event handlers to E-Mail component. }
{$IFDEF Indy900Up}
{$IFNDEF Indy1000Up}
      IdSMTP.OnConnected := OnEmailConnected;
{$ENDIF}
{$ENDIF}
      IdSMTP.OnDisconnected := OnEmailDisConnected;
      // IdSMTP.OnStatus := OnEmailStatus;
      IdSMTP.Port := LEMailSettings.Port;
      IdSMTP.Host := LEMailSettings.Host;
{$IFNDEF Indy1000Up}
{$IFNDEF Indy900Up}
      IdSMTP.UserID := LEMailSettings.UserID;
{$ELSE}
      IdSMTP.UserName := LEMailSettings.UserID;
{$ENDIF}
{$ELSE}
      IdSMTP.UserName := LEMailSettings.UserID;
{$ENDIF}
      IdSMTP.Password := LEMailSettings.Password;
{$IFDEF Indy1000Up}
      IdSMTP.PipeLine := False;
      if (LEMailSettings.AuthenticationRequired) then
      begin
{$IFDEF Indy1025Up}
        IdSMTP.AuthType := SatDefault;
{$ELSE}
        IdSMTP.AuthType := SatDefault;
{$ENDIF}
        IdSMTP.UseEhlo := True;
      end
      else
      begin
{$IFDEF Indy1025Up}
        IdSMTP.AuthType := SatNone;
{$ELSE}
        IdSMTP.AuthType := SatNone;
{$ENDIF}
        IdSMTP.UseEhlo := False;
      end;
{$ELSE}
      if (LEMailSettings.AuthenticationRequired) then
        IdSMTP.AuthenticationType := atLogin
      else
        IdSMTP.AuthenticationType := atNone;
{$ENDIF}
      for I := 0 to LEMailSettings.Attachments.Count - 1 do
{$IFDEF Indy1000Up}
        TIDAttachmentfile.Create(MessageParts, LEMailSettings.Attachments[I]);
{$ELSE}
        TIDAttachment.Create(MessageParts, LEMailSettings.Attachments[I]);
{$ENDIF}
      Body.Assign(LEMailSettings.Body);
      Date := LEMailSettings.Date;
      From.Name := LEMailSettings.FromName;
      From.Address := LEMailSettings.FromAddress;
      ReplyTo.EMailAddresses := LEMailSettings.ReplyTo;
      Subject := LEMailSettings.Subject;
      Recipients.EMailAddresses :=
        GetAddressString(LEMailSettings.RecipientList.Text);
      CCList.EMailAddresses := GetAddressString(LEMailSettings.CCList.Text);
      BCCList.EMailAddresses := GetAddressString(LEMailSettings.BCCList.Text);
      ReceiptRecipient.Text := LEMailSettings.ReceiptRecipient;
{$IFDEF Indy1000Up}
      IdSMTP.UseTLS := utUseExplicitTLS;
{$ENDIF}
      IdSMTP.Connect;
      IdSMTP.Send(IdMessage);
    finally
      IdSMTP.DisConnect;
      IdSMTP.Free;
{$IFDEF Indy1000Up}
      SSLHandler.Free;
{$ENDIF}
{$IFDEF Indy900Up}
      IdSSLIOHandlerSocket1.Free;
{$ENDIF}
      Free;
    end;
  LEMailSettings.Free;
end;

end.
