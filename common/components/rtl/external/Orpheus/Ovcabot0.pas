{*********************************************************}
{*                  OVCABOT0.PAS 2.17                    *}
{*      Copyright (c) 1995-98 TurboPower Software Co     *}
{*                 All rights reserved.                  *}
{*********************************************************}

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

unit OvcAbot0;

{$I l3Define.inc }

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  {$IfDef Delphi6}
  DesignIntf,
  DesignEditors,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  ExtCtrls, OvcVer;

type
  TOvcAboutForm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    lblVersion: TLabel;
    btnOK: TButton;
    Bevel1: TBevel;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TOvcVersionProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes;
      override;
    procedure Edit;
      override;
  end;

implementation

{$R *.DFM}


{*** TOrVersionProperty ***}

function TOvcVersionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

procedure TOvcVersionProperty.Edit;
begin
  with TOvcAboutForm.Create(Application) do begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;


{*** TEsAboutForm ***}

procedure TOvcAboutForm.btnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TOvcAboutForm.FormCreate(Sender: TObject);
begin
  Top := (Screen.Height - Height) div 3;
  Left := (Screen.Width - Width) div 2;
  lblVersion.Caption := 'Version ' + OvcVersionStr;
end;

end.
