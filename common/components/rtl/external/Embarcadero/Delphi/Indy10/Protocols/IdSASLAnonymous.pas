{
  $Project$
  $Workfile$
  $Revision: 1.2 $
  $DateUTC$
  $Id: IdSASLAnonymous.pas,v 1.2 2013/05/24 13:30:16 lulin Exp $

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log: IdSASLAnonymous.pas,v $
  Revision 1.2  2013/05/24 13:30:16  lulin
  - �������� ��������� XE4.

}
{
  Rev 1.1    1/21/2004 4:03:08 PM  JPMugaas
  InitComponent

  Rev 1.0    11/13/2002 08:00:12 AM  JPMugaas

  5-20-2002 - Started this unit.
}

unit IdSASLAnonymous;

interface

{$i IdCompilerDefines.inc}

uses
  IdSASL, IdTCPConnection;

{
Implements RFC 2245
Anonymous SASL Mechanism
Oxymoron if you ask me :-).
}

type
  TIdSASLAnonymous = class(TIdSASL)
  protected
    FTraceInfo : String;
    procedure InitComponent; override;
  public
    function IsReadyToStart: Boolean; override;
    class function ServiceName: TIdSASLServiceName; override;
    function StartAuthenticate(const AChallenge, AHost, AProtocolName : String): String; override;
  published
    property TraceInfo : String read FTraceInfo write FTraceInfo;
  end;

implementation

{ TIdSASLAnonymous }

procedure TIdSASLAnonymous.InitComponent;
begin
  inherited;
  FSecurityLevel := 0;   //broadcast on the evening news and post to every
                         // newsgroup for good measure
end;

function TIdSASLAnonymous.IsReadyToStart: Boolean;
begin
  Result := (TraceInfo <> '');
end;

class function TIdSASLAnonymous.ServiceName: TIdSASLServiceName;
begin
  Result := 'ANONYMOUS';   {Do not translate}
end;

function TIdSASLAnonymous.StartAuthenticate(const AChallenge, AHost, AProtocolName: String): String;
begin
  Result := TraceInfo;
end;

end.
