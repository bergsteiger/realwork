{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFDEF Win32}
{$H+} {Long strings}
{$ENDIF}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCTBPE2.PAS 2.17                    *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTBPE2;
  {-Property editor for the data-aware table component}

{$I l3Define.inc }

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  SysUtils, Messages, Classes, Graphics, Controls, 
  {$IfDef Delphi6}
  DesignIntf,
  DesignEditors,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  TypInfo,
  Forms, Dialogs, StdCtrls, OvcBase, OvcEf, OvcPb, OvcNf, Buttons, ExtCtrls,
  OvcTCmmn, OvcTCell, OvcTbCls, OvcTable, OvcSf, OvcSc, OvcHelp;

type
  TColEditor = class(TForm)
    ctlColNumber: TOvcSimpleField;
    ctlDefaultCell: TComboBox;
    ctlHidden: TCheckBox;
    ctlWidth: TOvcSimpleField;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    DoneButton: TBitBtn;
    HelpButton: TBitBtn;
    ApplyButton: TBitBtn;
    DefaultController: TOvcController;
    OvcSpinner1: TOvcSpinner;
    OvcSpinner2: TOvcSpinner;
    procedure ctlColNumberExit(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DoneButtonClick(Sender: TObject);
    procedure ctlColNumberChange(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
  private
    { Private declarations }
    FCols : TOvcTableColumns;
    FColNum : TColNum;
    CurCellIndex : integer;
    Cells     : TStringList;

  protected
    procedure GetCells;
    procedure RefreshColData;
    procedure SetColNum(C : TColNum);

    procedure AddCellComponentName(const S : string);

  public
    { Public declarations }
    Editor : TObject;
    procedure SetCols(CS : TOvcTableColumns);

    property Cols : TOvcTableColumns
       read FCols
       write SetCols;

    property ColNum : TColNum
       read FColNum
       write SetColNum;

  end;

  {-A table column property editor}
  TOvcTableColumnProperty = class(TClassProperty)
    public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
    end;


implementation

{$R *.DFM}



{===TOvcTableColumnProperty==========================================}
procedure TOvcTableColumnProperty.Edit;
  var
    ColEditor : TColEditor;
  begin
    ColEditor := TColEditor.Create(Application);
    try
      ColEditor.Editor := Self;
      ColEditor.SetCols(TOvcTableColumns(GetOrdValue));
      ColEditor.ShowModal;
      Designer.Modified;
      finally
      ColEditor.Free;
    end;{try..finally}
  end;
{--------}
function TOvcTableColumnProperty.GetAttributes: TPropertyAttributes;
  begin
    Result := [paMultiSelect, paDialog, paReadOnly];
  end;
{====================================================================}


{===TColEditor=======================================================}
procedure TColEditor.AddCellComponentName(const S : string);
  begin
    Cells.Add(S);
  end;
{--------}
procedure TColEditor.ApplyButtonClick(Sender: TObject);
  begin
    with FCols[ColNum] do
      begin
        Hidden := ctlHidden.Checked;
        FCols[ColNum].Width := ctlWidth.AsInteger;
        if (ctlDefaultCell.ItemIndex <> CurCellIndex) then
          begin
            CurCellIndex := ctlDefaultCell.ItemIndex;
            FCols[FColNum].DefaultCell := TOvcBaseTableCell(Cells.Objects[CurCellIndex]);
          end;
      end;
  end;
{--------}
procedure TColEditor.ctlColNumberExit(Sender: TObject);
  begin
    ApplyButtonClick(Self);
    ColNum := ctlColNumber.AsInteger;
  end;
{--------}
procedure TColEditor.DoneButtonClick(Sender: TObject);
  begin
    ApplyButtonClick(Self);
    Cells.Free;
  end;
{--------}
procedure TColEditor.FormShow(Sender: TObject);
  begin
    if not Assigned(Cells) then
      begin
        Cells := TStringList.Create;
        GetCells;
      end;
    RefreshColData;
  end;
{--------}
procedure TColEditor.GetCells;
  var
    {$IFDEF Win32}
    {$IfDef Delphi6}
    Designer : IDesigner;                                          {!!.D4}
    {$Else  Delphi6}
    {$IFDEF VERSION4}                                                  {!!.D4}
    Designer : IFormDesigner;                                          {!!.D4}
    {$ELSE}                                                            {!!.D4}
    Designer : TFormDesigner;
    {$ENDIF}                                                           {!!.D4}
    {$EndIf Delphi6}
    TI   : PTypeInfo;
    {$ELSE}
    Form : TForm;
    i    : integer;
    {$ENDIF}
    Index: Integer;
    C    : TComponent;
    Cell : TOvcBaseTableCell absolute C;
  begin
    Cells.Sorted := true;
    Cells.AddObject('(None)', nil);
    {$IFDEF Win32}
    TI := TOvcBaseTableCell.ClassInfo;
    if (Editor is TClassProperty) then
      Designer := TClassProperty(Editor).Designer
    else {the editor is a TDefaultEditor}
      Designer := TDefaultEditor(Editor).Designer;
    Designer.GetComponentNames(GetTypeData(TI), AddCellComponentName);
    for Index := 1 to pred(Cells.Count) do
      Cells.Objects[Index] := Designer.GetComponent(Cells[Index]);
    {$ELSE}
    Form := GetParentForm(FCols.Table);
    with Form do
      for i := 0 to pred(ComponentCount) do
        begin
          C := Components[i];
          if (C is TOvcBaseTableCell) then
            begin
              Index := Cells.Add(Cell.Name);
              Cells.Objects[Index] := Cell;
            end;
        end;
    {$ENDIF}
    ctlDefaultCell.Items := Cells;
  end;
{--------}
procedure TColEditor.RefreshColData;
  begin
    CurCellIndex := Cells.IndexOfObject(FCols[ColNum].DefaultCell);

    ctlColNumber.RangeHi := IntToStr(pred(FCols.Count));

    ctlHidden.Checked := FCols[ColNum].Hidden;
    ctlWidth.AsInteger := FCols[ColNum].Width;
    ctlDefaultCell.ItemIndex := CurCellIndex;
  end;
{--------}
procedure TColEditor.SetColNum(C : TColNum);
  begin
    if (FColNum <> C) then
      begin
        FColNum := C;
        ctlColNumber.AsInteger := C;
        RefreshColData;
      end;
  end;
{--------}
procedure TColEditor.SetCols(CS : TOvcTableColumns);
  begin
    if Assigned(FCols) then
      FCols.Free;
    FCols := CS;
    FColNum := 0;
  end;
{--------}
procedure TColEditor.SpeedButton1Click(Sender: TObject);
  begin
    ApplyButtonClick(Self);
    if (ColNum > 0) then
      ColNum := ColNum - 1;
  end;
{--------}
procedure TColEditor.SpeedButton2Click(Sender: TObject);
  begin
    ApplyButtonClick(Self);
    if (ColNum < pred(FCols.Count)) then
      ColNum := ColNum + 1;
  end;
{--------}
procedure TColEditor.SpeedButton3Click(Sender: TObject);
  begin
    ApplyButtonClick(Self);
    ColNum := 0;
  end;
{--------}
procedure TColEditor.SpeedButton4Click(Sender: TObject);
  begin
    ApplyButtonClick(Self);
    ColNum := pred(FCols.Count);
  end;
{--------}
procedure TColEditor.SpeedButton5Click(Sender: TObject);
  var
    C : TOvcTableColumn;
  begin
    C := TOvcTableColumn.Create(FCols.Table);
    FCols.Insert(FColNum, C);
    RefreshColData;
  end;
{--------}
procedure TColEditor.SpeedButton6Click(Sender: TObject);
  begin
    if (FCols.Count > 1) then
      begin
        FCols.Delete(FColNum);
        if (FColNum = FCols.Count) then
             ColNum := pred(FColNum)
        else RefreshColData;
      end;
  end;
{====================================================================}


procedure TColEditor.ctlColNumberChange(Sender: TObject);
begin
  ApplyButtonClick(Self);
  ColNum := ctlColNumber.AsInteger;
end;

procedure TColEditor.HelpButtonClick(Sender: TObject);
begin
  ShowHelpContext(hcColumnsEditor);
end;

end.