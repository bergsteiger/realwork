{
  $Project$
  $Workfile$
  $Revision: 1.3 $
  $DateUTC$
  $Id: IdGlobalCore.pas,v 1.3 2015/06/16 12:31:36 lukyanets Exp $

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log: IdGlobalCore.pas,v $
  Revision 1.3  2015/06/16 12:31:36  lukyanets
  Новый Indy 10

}
{
  Rev 1.2    8/16/2004 1:08:46 PM  JPMugaas
  Failed to compile in some IDE's.

  Rev 1.1    2004.08.13 21:46:20  czhower
  Fix for .NET

  Rev 1.0    2004.08.13 10:54:58  czhower
  Initial checkin
}

unit IdGlobalCore;

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal;

const
  {$IFDEF UNIX}
  tpListener = tpNormal;
  {$ELSE}
  tpListener = tpHighest;
  {$ENDIF}

implementation

end.
