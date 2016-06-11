{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSLoginDlg;

{$P+,H+,X+}

interface

uses Datasnap.DSClientRest;

function LoginDialog(ASender: TObject; var ALoginProperties: TDSRestLoginProperties;
  ATestConnectionMethod: TTestConnectionMethod): Boolean;

implementation

uses System.Classes, System.SysUtils;

function LoginDialog(ASender: TObject; var ALoginProperties: TDSRestLoginProperties; ATestConnectionMethod: TTestConnectionMethod): Boolean;
var
  LUserName, LPassword: string;
  LTestConnectionMethod: TTestConnectionMethod;
begin
  LTestConnectionMethod := ATestConnectionMethod;
  Result := TLoginCredentialService.GetLoginCredentials('',
    function(const Username, Password, Domain: string): Boolean
    begin
      Result := True;
      LUserName := Username;
      LPassword := Password;
      if Assigned(LTestConnectionMethod) then
        LTestConnectionMethod;
    end);
  if Result then
  begin
    ALoginProperties.UserName := LUserName;
    ALoginProperties.Password := LPassword;
  end;
end;

initialization
  if not Assigned(Datasnap.DSClientRest.DSRestLoginDialogProc) then
    Datasnap.DSClientRest.DSRestLoginDialogProc := LoginDialog;
end.
