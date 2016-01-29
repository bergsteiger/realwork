{
  $Project$
  $Workfile$
  $Revision: 1.2 $
  $DateUTC$
  $Id: IdSASLPlain.pas,v 1.2 2013/05/24 13:30:16 lulin Exp $

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log: IdSASLPlain.pas,v $
  Revision 1.2  2013/05/24 13:30:16  lulin
  - �������� ��������� XE4.

}
{
  Rev 1.1    1/25/2004 2:17:52 PM  JPMugaas
  Should work better.  Removed one GPF in S/Key.

  Rev 1.0    11/13/2002 08:00:36 AM  JPMugaas

  PLAIN mechanism 
  This is of type TIdSASLUserPass because it needs a username/password,
  additionally it has a LoginAs property - this is the "effective username"
  after connecting, which could be different as your "real" username
  (eg. root logging in as someone else on a unix system)
}

unit IdSASLPlain;

interface

{$i IdCompilerDefines.inc}

uses
  IdSASL,
  IdSASLUserPass;

type
  TIdSASLPlain = class(TIdSASLUserPass)
  protected
    FLoginAs: String;
  public
    function IsReadyToStart: Boolean; override;
    class function ServiceName: TIdSASLServiceName; override;
    function StartAuthenticate(const AChallenge, AHost, AProtocolName : string) : String; override;
  published
    property LoginAs : String read FLoginAs write FLoginAs;
  end;

implementation

{ TIdSASLPlain }

function TIdSASLPlain.IsReadyToStart: Boolean;
begin
  Result := inherited IsReadyToStart;
  if not Result then begin
    Result := (LoginAs <> '');
  end;
end;

class function TIdSASLPlain.ServiceName: TIdSASLServiceName;
begin
  Result := 'PLAIN';  {Do not translate}
end;

function TIdSASLPlain.StartAuthenticate(const AChallenge, AHost, AProtocolName : string): String;
var
  LUser, LUserAs: string;
begin
  LUser := GetUsername;
  LUserAs := LoginAs;
  if LUser = '' then begin
    LUser := LUserAs;
  end;
  Result := LUserAs+#0+LUser+#0+GetPassword;  {Do not translate}
end;

end.
