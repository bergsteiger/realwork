{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcmemopr;

interface
{$I dc.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dcedit, StdCtrls, dccommon, dcSystem, dcdreamlib, dcConsts, ExtCtrls, dcmemo;

type
  TMemoPrintForm = class(TForm)
    gbxPrintDestination: TGroupBox;
    gbxOptions: TGroupBox;
    lblFileName: TLabel;
    PrintSelCheck: TCheckBox;
    HeaderCheck: TCheckBox;
    LineNumbersCheck: TCheckBox;
    SyntaxPrintCheck: TCheckBox;
    WrapLinesCheck: TCheckBox;
    UseColorCheck: TCheckBox;
    LeftMarginEdit: TEdit;
    lblLeftMargin: TLabel;
    PrinterSetup: TPrinterSetupDialog;
    ShowPrintProgress: TCheckBox;
    SetupBut: TButton;
    OkBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    procedure SetupButClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PrintSelCheckChange(Sender: TObject);
    procedure OkButClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    POptions: TDCPrintOptions;
  end;

var
  MemoPrintForm: TMemoPrintForm;

implementation

{$R *.DFM}

procedure TMemoPrintForm.SetupButClick(Sender: TObject);
begin
  PrinterSetup.Execute;
end;

procedure TMemoPrintForm.FormCreate(Sender: TObject);
begin
  {$IFNDEF CLX}
  SetFormFont(Self);
  {$ENDIF}
  Caption:=SPrintFormCaption;
  gbxPrintDestination.Caption:=SPrintDestCaption;
  PrintSelCheck.Caption:=SPrintSelectedBlock;
  gbxOptions.Caption:=SOptionsCaption;

  HeaderCheck.Caption:=SHeaderPage;
  LineNumbersCheck.Caption:=SLineNumber;
  SyntaxPrintCheck.Caption:=SSyntaxPrint;

  UseColorCheck.Caption:=SUseColor;
  ShowPrintProgress.Caption:=SShowPrintProgress;
  WrapLinesCheck.Caption:=SWrapLines;
  lblLeftMargin.Caption:=SLeftMargin;

  SetupBut.Caption:=SSetupButton;
  if not boolShowHelpButton then
    SetupBut.Left := OkBut.Left;
  {$IFNDEF CLX}
  UpdateStandardButtons(OkBut, CancelBut, HelpBut);
  {$ENDIF}
end;

procedure TMemoPrintForm.PrintSelCheckChange(Sender: TObject);
begin
  If PrintSelCheck.Checked Then
    Caption:=SPrintFormCaptionSelection
  Else
    Caption:=SPrintFormCaption
end;

procedure TMemoPrintForm.OkButClick(Sender: TObject);
begin
  POptions := [];
  if PrintSelCheck.Checked then
    Include(POptions, poPrintSel);
  if HeaderCheck.Checked then
    Include(POptions, poPrintHeader);
  if LineNumbersCheck.Checked then
    Include(POptions, poLineNumbers);
  if SyntaxPrintCheck.Checked then
    Include(POptions, poPrintSyntax);
  if UseColorCheck.Checked then
    Include(POptions, poInColor);
  if ShowPrintProgress.Checked then
    Include(POptions, poShowProgress);
  if WrapLinesCheck.Checked then
    Include(POptions, poWrapLines);
end;

procedure TMemoPrintForm.FormShow(Sender: TObject);
begin
  //PrintSelCheck.Checked := poPrintSel in POptions;
  HeaderCheck.Checked := poPrintHeader in POptions;
  LineNumbersCheck.Checked := poLineNumbers in POptions;
  SyntaxPrintCheck.Checked := poPrintSyntax in POptions;
  UseColorCheck.Checked := poInColor in POptions;
  ShowPrintProgress.Checked := poShowProgress in POptions;
  WrapLinesCheck.Checked := poWrapLines in POptions;
end;

end.
