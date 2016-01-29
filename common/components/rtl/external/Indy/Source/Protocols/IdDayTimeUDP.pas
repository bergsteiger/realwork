{
  $Project$
  $Workfile$
  $Revision: 1.3 $
  $DateUTC$
  $Id: IdDayTimeUDP.pas,v 1.3 2015/06/16 12:31:45 lukyanets Exp $

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log: IdDayTimeUDP.pas,v $
  Revision 1.3  2015/06/16 12:31:45  lukyanets
  Новый Indy 10

}
{
  Rev 1.1    1/21/2004 2:12:42 PM  JPMugaas
  InitComponent

  Rev 1.0    11/14/2002 02:17:14 PM  JPMugaas
}

unit IdDayTimeUDP;

interface
{$i IdCompilerDefines.inc}
uses
  IdAssignedNumbers, IdUDPBase, IdUDPClient;

type
  TIdDayTimeUDP = class(TIdUDPClient)
  protected
    Function GetDayTimeStr : String;
    procedure InitComponent; override;
  public
    Property DayTimeStr : String read GetDayTimeStr;
  published
    property Port default IdPORT_DAYTIME;
  end;

implementation

{ TIdDayTimeUDP }

procedure TIdDayTimeUDP.InitComponent;
begin
  inherited InitComponent;
  Port := IdPORT_DAYTIME;
end;

function TIdDayTimeUDP.GetDayTimeStr: String;
begin
  //The string can be anything - The RFC says the server should discard packets
  Send(' ');    {Do not Localize}
  Result := ReceiveString;
end;

end.
