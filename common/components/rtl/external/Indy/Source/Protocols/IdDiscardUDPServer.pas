{
  $Project$
  $Workfile$
  $Revision: 1.3 $
  $DateUTC$
  $Id: IdDiscardUDPServer.pas,v 1.3 2015/06/16 12:31:45 lukyanets Exp $

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log: IdDiscardUDPServer.pas,v $
  Revision 1.3  2015/06/16 12:31:45  lukyanets
  Новый Indy 10

}
{
  Rev 1.1    1/21/2004 2:12:48 PM  JPMugaas
  InitComponent

  Rev 1.0    11/14/2002 02:18:14 PM  JPMugaas
}

unit IdDiscardUDPServer;

interface
{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers, IdSocketHandle, IdUDPBase, IdUDPServer;

type
   TIdDiscardUDPServer = class(TIdUDPServer)
   protected
     procedure InitComponent; override;
   published
     property DefaultPort default IdPORT_DISCARD;
   end;

implementation

{ TIdDiscardUDPServer }

procedure TIdDiscardUDPServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_DISCARD;
end;

end.

