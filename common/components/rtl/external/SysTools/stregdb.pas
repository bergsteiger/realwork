{*********************************************************}
{*                   STREGDB.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{$IFDEF Win32}
  {$IFNDEF VER93}
    {$R STREGDB.R32}
  {$ENDIF}
{$ELSE}
  {$R STREGDB.R16}
{$ENDIF}

unit StRegDb;

interface

uses
  Classes;

procedure Register;

implementation

uses
  StBase,
  StDbBarC,
  StDbPNBC;

procedure Register;
begin
  RegisterComponents('SysTools', [TStDbBarCode, TStDbPNBarCode]);
end;

end.