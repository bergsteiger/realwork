{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCHELP.PAS 2.17                     *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcHelp;
  {-Help index definitions}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  IniFiles, SysUtils,
  OvcData;

const
  {$IFDEF Win32}
    {$IFDEF VER93}
      HelpFileName = 'ORPHBCB.HLP';
    {$ELSE}
      HelpFileName = 'ORPH32.HLP';
    {$ENDIF}
  {$ELSE}
  HelpFileName = 'ORPH16.HLP';
  {$ENDIF}

  {help offset}
  hcBase                = 5000;

  {help context id's}
  hcCommandProcessor    = hcBase +  0; {command processor property editor}
  hcEntryFieldRange     = hcBase + 10; {entry field range property editor}
  hcSimpleFieldMask     = hcBase + 20; {simple field mask property editor}
  hcPictureFieldMask    = hcBase + 30; {picture field mask property editor}
  hcNumericFieldMask    = hcBase + 40; {numeric field mask property editor}
  hcNotebookPage        = hcBase + 50; {notebook page property editor}
  hcNotebookPageInfo    = hcNotebookPage; {notebook page info property editor}
  hcTransfer            = hcBase + 70; {transfer component editor}
  hcArrayEditorRange    = hcEntryFieldRange; {array editor range property editor}
  hcRowsEditor          = hcBase + 80; {table rows property editor}
  hcColumnsEditor       = hcBase + 90; {table columns property editor}
  hcDbColumnsEditor     = hcBase + 100; {data aware table columns property editor}


procedure ShowHelpContext(HC : LongInt);
  {-display help}

implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}

procedure ShowHelpContext(HC : LongInt);
var
  S   : string;
  Ini : TIniFile;
  Buf : array[0..255] of AnsiChar;
begin
  S := '';
  {build help file path}
  Ini := TIniFile.Create('MULTIHLP.INI');
  try
    S := Ini.ReadString('Index Path', HelpFileName, '');
  finally
    Ini.Free;
  end;

  if S > '' then begin
    if S[Length(S)] <> '\' then
      S := S + '\' + HelpFileName
    else
      S := S + HelpFileName;
  end else
    S := HelpFileName;

  StrPCopy(Buf, S);
  WinHelp(0, Buf, HELP_CONTEXT, HC);
end;


end.