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
{*                  OVCCMDP1.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcCmdP1;
  {-Form and list that allows re-ordering of its contents}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Graphics, Forms, Controls,
  Buttons, StdCtrls, ExtCtrls;

type
  TOvcfrmScanOrder = class(TForm)
    lbCommands: TListBox;
    btnUp: TBitBtn;
    bntDown: TBitBtn;
    btnOk: TBitBtn;
    Bevel1: TBevel;
    pnlCmdTables: TPanel;
    btnCancel: TBitBtn;
    procedure btnUpClick(Sender: TObject);
    procedure bntDownClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


procedure TOvcfrmScanOrder.btnUpClick(Sender: TObject);
var
  I : Integer;
begin
  I := lbCommands.ItemIndex;

  if I > 0 then begin
    lbCommands.Items.Exchange(I-1, I);
    lbCommands.ItemIndex := I-1;
  end;
end;

procedure TOvcfrmScanOrder.bntDownClick(Sender: TObject);
var
  I : Integer;
begin
  I := lbCommands.ItemIndex;

  if (I > -1) and (I < lbCommands.Items.Count - 1) then begin
    lbCommands.Items.Exchange(I, I+1);
    lbCommands.ItemIndex := I+1;
  end;
end;

end.
