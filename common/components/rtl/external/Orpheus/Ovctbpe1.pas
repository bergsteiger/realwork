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
{*                  OVCTBPE1.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTBPE1;
  {-Property editor for the table component}

{$I l3Define.inc }

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Graphics, Controls, 
  {$IfDef Delphi6}
  DesignIntf,
  DesignEditors,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  Messages, SysUtils,
  Forms, Dialogs, StdCtrls, OvcBase, OvcEf, OvcPb, OvcNf, Buttons, ExtCtrls,
  OvcTCmmn, OvcTable, OvcTbRws, OvcSf, OvcSc, OvcHelp;

type
  TOvcRowEditor = class(TForm)
    ctlHidden: TCheckBox;
    ctlUseDefHeight: TRadioButton;
    ctlUseCustHeight: TRadioButton;
    DoneButton: TBitBtn;
    HelpButton: TBitBtn;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Reset: TBitBtn;
    ctlHeight: TOvcSimpleField;
    ctlDefaultHeight: TOvcSimpleField;
    ctlRowLimit: TOvcSimpleField;
    ctlRowNumber: TOvcSimpleField;
    ApplyButton: TBitBtn;
    DefaultController: TOvcController;
    OvcSpinner1: TOvcSpinner;
    OvcSpinner2: TOvcSpinner;
    OvcSpinner3: TOvcSpinner;
    OvcSpinner4: TOvcSpinner;
    procedure ctlUseDefHeightClick(Sender: TObject);
    procedure ctlUseCustHeightClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure ctlRowNumberExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ResetClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure DoneButtonClick(Sender: TObject);
    procedure ctlRowNumberChange(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
  private
    { Private declarations }
    FRows : TOvcTableRows;
    FRowNum : TRowNum;
    CurDefHt  : boolean;

  protected
    procedure RefreshRowData;
    procedure SetRowNum(R : TRowNum);

  public
    { Public declarations }
    procedure SetRows(RS : TOvcTableRows);

    property Rows : TOvcTableRows
       read FRows
       write SetRows;

    property RowNum : TRowNum
       read FRowNum
       write SetRowNum;

  end;

  {-A table row property editor}
  TOvcTableRowProperty = class(TClassProperty)
    public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
    end;


implementation

{$R *.DFM}



{===TOvcTableRowProperty=============================================}
procedure TOvcTableRowProperty.Edit;
  var
    RowEditor : TOvcRowEditor;
  begin
    RowEditor := TOvcRowEditor.Create(Application);
    try
      RowEditor.SetRows(TOvcTableRows(GetOrdValue));
      RowEditor.ShowModal;
      Designer.Modified;
    finally
      RowEditor.Free;
    end;{try..finally}
  end;
{--------}
function TOvcTableRowProperty.GetAttributes: TPropertyAttributes;
  begin
    Result := [paMultiSelect, paDialog, paReadOnly];
  end;
{====================================================================}


{===TRowEditor=======================================================}
procedure TOvcRowEditor.ApplyButtonClick(Sender: TObject);
  var
    RS : TRowStyle;
  begin
    FRows.Limit := ctlRowLimit.AsInteger;
    if FRowNum >= FRows.Limit then
      RowNum := pred(FRows.Limit);
    FRows.DefaultHeight := ctlDefaultHeight.AsInteger;
    with RS do
      begin
        if ctlUseDefHeight.Checked then
          Height := ctlDefaultHeight.AsInteger
        else
          begin
            Height := ctlHeight.AsInteger;
            if (Height = FRows.DefaultHeight) then
              ctlUseDefHeight.Checked := true;
          end;
        Hidden := ctlHidden.Checked;
        FRows[RowNum] := RS;
      end;
  end;
{--------}
procedure TOvcRowEditor.ctlRowNumberExit(Sender: TObject);
  begin
    RowNum := ctlRowNumber.AsInteger;
  end;
{--------}
procedure TOvcRowEditor.ctlUseCustHeightClick(Sender: TObject);
  begin
    CurDefHt := false;
    ctlHeight.Enabled := true;
  end;
{--------}
procedure TOvcRowEditor.ctlUseDefHeightClick(Sender: TObject);
  begin
    CurDefHt := true;
    ctlHeight.AsInteger := FRows.DefaultHeight;
    ctlHeight.Enabled := false;
  end;
{--------}
procedure TOvcRowEditor.FormShow(Sender: TObject);
  begin
    ctlDefaultHeight.AsInteger := FRows.DefaultHeight;
    ctlRowLimit.AsInteger := FRows.Limit;
    RefreshRowData;
  end;
{--------}
procedure TOvcRowEditor.RefreshRowData;
  begin
    CurDefHt := FRows.Height[RowNum] = FRows.DefaultHeight;

    ctlRowNumber.RangeHi := IntToStr(pred(FRows.Limit));

    ctlHidden.Checked := FRows.Hidden[RowNum];
    ctlHeight.AsInteger := FRows.Height[RowNum];
    if CurDefHt then
      begin
        ctlUseDefHeight.Checked := true;
        ctlHeight.Enabled := false;
      end
    else
      begin
        ctlUseCustHeight.Checked := true;
        ctlHeight.Enabled := true;
      end;

    ctlRowLimit.AsInteger := FRows.Limit;                       {!!.01}
  end;
{--------}
procedure TOvcRowEditor.ResetClick(Sender: TObject);
  begin
    FRows.Clear;
    ctlDefaultHeight.AsInteger := FRows.DefaultHeight;
    RefreshRowData;
  end;
{--------}
procedure TOvcRowEditor.SetRowNum(R : TRowNum);
  begin
    if (FRowNum <> R) then
      begin
        FRowNum := R;
        ctlRowNumber.AsInteger := R;
        RefreshRowData;
      end;
  end;
{--------}
procedure TOvcRowEditor.SetRows(RS : TOvcTableRows);
  begin
    if Assigned(FRows) then
      FRows.Free;
    FRows := RS;
    FRowNum := 0;
    CurDefHt := FRows.Height[RowNum] = FRows.DefaultHeight;
  end;
{--------}
procedure TOvcRowEditor.SpeedButton1Click(Sender: TObject);
  begin
    ApplyButtonClick(Self);
    if (RowNum > 0) then
      RowNum := RowNum - 1;
  end;
{--------}
procedure TOvcRowEditor.SpeedButton2Click(Sender: TObject);
  begin
    ApplyButtonClick(Self);
    if (RowNum < pred(FRows.Limit)) then
      RowNum := RowNum + 1;
  end;
{--------}
procedure TOvcRowEditor.SpeedButton3Click(Sender: TObject);
  begin
    ApplyButtonClick(Self);
    RowNum := 0;
  end;
{--------}
procedure TOvcRowEditor.SpeedButton4Click(Sender: TObject);
  begin
    ApplyButtonClick(Self);
    RowNum := pred(FRows.Limit);
  end;
{--------}
procedure TOvcRowEditor.SpeedButton5Click(Sender: TObject);
  var
    RS : TRowStyle;
  begin
    RS.Hidden := false;
    RS.Height := FRows.DefaultHeight;
    FRows.Insert(FRowNum, RS);
    RefreshRowData;
  end;
{--------}
procedure TOvcRowEditor.SpeedButton6Click(Sender: TObject);
  begin
    FRows.Delete(FRowNum);
    RefreshRowData;
  end;
{====================================================================}

procedure TOvcRowEditor.DoneButtonClick(Sender: TObject);
begin
  ApplyButtonClick(Self);
end;

procedure TOvcRowEditor.ctlRowNumberChange(Sender: TObject);
begin
  ApplyButtonClick(Self);
  RowNum := ctlRowNumber.AsInteger;
end;

procedure TOvcRowEditor.HelpButtonClick(Sender: TObject);
begin
  ShowHelpContext(hcRowsEditor);
end;

end.
