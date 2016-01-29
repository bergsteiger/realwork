{
  $Project$
  $Workfile$
  $Revision: 1.2 $
  $DateUTC$
  $Id: IdHashElf.pas,v 1.2 2013/05/24 13:30:16 lulin Exp $

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log: IdHashElf.pas,v $
  Revision 1.2  2013/05/24 13:30:16  lulin
  - �������� ��������� XE4.

}
{
  Rev 1.1    2003-10-16 11:22:42  HHellstr�m
  Fixed for dotNET

  Rev 1.0    11/13/2002 07:53:32 AM  JPMugaas
}

unit IdHashElf;

interface
{$i IdCompilerDefines.inc}

uses
  IdHash;

type
  TIdHashElf = class(TIdHash32)
  public
    procedure HashStart(var VRunningHash : LongWord); override;
    procedure HashByte(var VRunningHash : LongWord; const AByte : Byte); override;
  end;

implementation

{ TIdHashElf }

procedure TIdHashElf.HashStart(var VRunningHash: LongWord);
begin
  VRunningHash := 0;
end;

procedure TIdHashElf.HashByte(var VRunningHash: LongWord; const AByte: Byte);
var
  LTemp: LongWord;
begin
  VRunningHash := (VRunningHash shl 4) + AByte;
  LTemp := VRunningHash and $F0000000;
  if LTemp <> 0 then begin
    VRunningHash := VRunningHash xor (LTemp shr 24);
  end;
  VRunningHash := VRunningHash and (not LTemp);
end;

end.

