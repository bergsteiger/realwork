{
  $Project$
  $Workfile$
  $Revision: 1.2 $
  $DateUTC$
  $Id: IdStream.pas,v 1.2 2013/05/24 13:30:18 lulin Exp $

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log: IdStream.pas,v $
  Revision 1.2  2013/05/24 13:30:18  lulin
  - заливаем исходники XE4.

}

unit IdStream;

interface

{$I IdCompilerDefines.inc}

uses
{$IFDEF DOTNET}
  IdStreamNET
{$ELSE}
  IdStreamVCL
{$ENDIF};

type
{$IFDEF DOTNET}
  TIdStreamHelper = TIdStreamHelperNET;
{$ELSE}
  TIdStreamHelper = TIdStreamHelperVCL;
{$ENDIF}

implementation

end.

