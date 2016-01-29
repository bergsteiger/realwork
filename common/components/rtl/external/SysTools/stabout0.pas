{*********************************************************}
{*                  STABOUT0.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

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

unit StAbout0;

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DsgnIntf, ExtCtrls, StConst;

type
  TStAboutForm = class(TForm)
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

  TStVersionProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes;
      override;
    procedure Edit;
      override;
  end;

implementation

{$R *.DFM}


{*** TEsVersionProperty ***}

function TStVersionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

procedure TStVersionProperty.Edit;
begin
  with TStAboutForm.Create(Application) do begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;


{*** TStAboutForm ***}

procedure TStAboutForm.btnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TStAboutForm.FormCreate(Sender: TObject);
begin
  Top := (Screen.Height - Height) div 3;
  Left := (Screen.Width - Width) div 2;
  lblVersion.Caption := 'Version ' + StVersionStr;
end;

end.
