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
{*                  OVCNBKP1.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcNbkP1;
  {-Property editor for the notebook component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, SysUtils, ExtCtrls,
  OvcHelp;

type
  TOvcfrmTabPageInfo = class(TForm)
    edPageName: TEdit;
    edPageHint: TEdit;
    edPageContext: TEdit;
    cbPageEnabled: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    btnHelp: TBitBtn;
    procedure OKClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);

  protected
    function GetPageContext : THelpContext;
    function GetPageEnabled : Boolean;
    function GetPageHint : string;
    function GetPageName : string;
    procedure SetPageContext(Value : THelpContext);
    procedure SetPageEnabled(Value : Boolean);
    procedure SetPageHint(const Value : string);
    procedure SetPageName(const Value : string);

  public
    property PageContext : THelpContext
      read GetPageContext
      write SetPageContext;

    property PageEnabled : Boolean
      read GetPageEnabled
      write SetPageEnabled;

    property PageHint : string
      read GetPageHint
      write SetPageHint;

    property PageName : string
      read GetPageName
      write SetPageName;
  end;

implementation

{$R *.DFM}


function TOvcfrmTabPageInfo.GetPageContext : THelpContext;
begin
  Result := StrToInt(edPageContext.Text);
end;

function TOvcfrmTabPageInfo.GetPageEnabled : Boolean;
begin
  Result := cbPageEnabled.Checked;
end;

function TOvcfrmTabPageInfo.GetPageHint : string;
begin
  Result := edPageHint.Text;
end;

function TOvcfrmTabPageInfo.GetPageName : string;
begin
  Result := edPageName.Text;
end;

procedure TOvcfrmTabPageInfo.SetPageContext(Value : THelpContext);
begin
  edPageContext.Text := IntToStr(Value);
  edPageContext.SelectAll;
end;

procedure TOvcfrmTabPageInfo.SetPageEnabled(Value : Boolean);
begin
  cbPageEnabled.Checked := Value;
end;

procedure TOvcfrmTabPageInfo.SetPageHint(const Value : string);
begin
  edPageHint.Text := Value;
  edPageHint.SelectAll;
end;

procedure TOvcfrmTabPageInfo.SetPageName(const Value : string);
begin
  edPageName.Text := Value;
  edPageName.SelectAll;
end;

procedure TOvcfrmTabPageInfo.OKClick(Sender: TObject);
begin
  try
    StrToInt(edPageContext.Text); {see if it converts without error}
  except
    ModalResult := 0;
    ActiveControl := edPageContext;
    edPageContext.SelectAll;
    raise;
  end;
end;

procedure TOvcfrmTabPageInfo.btnHelpClick(Sender: TObject);
begin
  ShowHelpContext(hcNotebookPageInfo);
end;

end.
