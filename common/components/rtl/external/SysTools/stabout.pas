{*********************************************************}
{*                   STABOUT.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$I+} {I/O Checking On}
{$H+} {Huge strings}

unit StAbout;

interface

{$IFNDEF WIN32}
  !! Error: This unit cannot be compiled with Delphi 1
{$ENDIF}

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Forms, Classes, Controls, Graphics, ShellApi,
  StBase, StShBase;

type
  TStCustomShellAbout = class(TStShellComponent)
  protected {private}
{$Z+}
    FAdditionalText : string;
    FCaption        : string;
    FIcon           : TIcon;
    FTitleText      : string;
    { Private declarations }
  protected
    { Protected declarations }

    procedure SetIcon(Value : TIcon);

{$Z-}
    property AdditionalText : string
      read FAdditionalText
      write FAdditionalText;

    property Caption : string
      read FCaption
      write FCaption;

    property Icon : TIcon
      read FIcon
      write SetIcon;

    property TitleText : string
      read FTitleText
      write FTitleText;

  public
    { Public declarations }
{$Z+}
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
{$Z-}
    function Execute : Boolean;
  published
    { Published declarations }
  end;

  TStShellAbout = class(TStCustomShellAbout)
  published
    property AdditionalText;
    property Caption;
    property Icon;
    property TitleText;
  end;

implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  IniFiles,
  SysUtils,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}

constructor TStCustomShellAbout.Create(AOwner : TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);
  FIcon := TIcon.Create;
end;

destructor TStCustomShellAbout.Destroy;
begin
  { Free the Icon. }
  FIcon.Free;
  inherited Destroy;
end;

function TStCustomShellAbout.Execute : Boolean;
var
  IconHandle   : Integer;
  ParentHandle : Integer;
  Text         : string;
begin
  Text := FCaption;
  if (Length(FTitleText) <> 0) then
    Text := Text + '#' + FTitleText;
  { If the icon has been assigned then pass the Icon's Handle. }
  { If the icon has not been assigned then pass 0. }
  if Assigned(FIcon) then
    IconHandle := FIcon.Handle
  else
    IconHandle := 0;

  { Get a handle to the owning window. }
  if Owner is TWinControl then
    ParentHandle := (Owner as TWinControl).Handle
  else if Owner is TApplication then
    ParentHandle := (Owner as TApplication).Handle
  else
    ParentHandle := 0;

  { Show the dialog. }
  Result := Boolean(ShellAbout(
    ParentHandle,
    PChar(Text),
    PChar(AdditionalText),
    IconHandle));
end;

procedure TStCustomShellAbout.SetIcon(Value : TIcon);
begin
  { If the icon has not yet been created, then create it. }
  if not Assigned(FIcon) then
    FIcon := TIcon.Create;

  { Assign the new value. }
  FIcon.Assign(Value);
end;


end.