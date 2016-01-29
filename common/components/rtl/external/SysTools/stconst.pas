{*********************************************************}
{*                   STCONST.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFDEF WIN32}
  {$R STCONST.R32}
{$ELSE}
  {$R STCONST.R16}
{$ENDIF}

unit StConst;
  {-Resource constants for SysTools}

{$Include l3XE.inc}

interface

{$ifNDef XE}
uses
  SysUtils, StSrMgr;
{$EndIf}

{$I STCONST.INC}

const
  StVersionStr = '3.01';

{$ifNDef XE}
var
  SysToolStr : TStStringResource;
{$Endif XE}

implementation

{$ifNDef XE}
procedure FreeSysToolStr; far;
begin
  SysToolStr.Free;
end;


initialization
  SysToolStr := TStStringResource.Create(HInstance, 'SYSTOOLS_STRINGS_ENGLISH');

{$IFDEF Win32}
finalization
  FreeSysToolStr;
{$ELSE}
  AddExitProc(FreeSysToolStr);
{$ENDIF}
{$Endif XE}

end.
