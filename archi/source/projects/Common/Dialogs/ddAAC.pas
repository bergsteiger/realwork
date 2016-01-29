unit ddAAC;

{$Include ddDefine.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, vtGroupBox, vtLabel,
  OvcBase, afwControlPrim, afwBaseControl, afwControl, nevControl,
  evEditorWindow, evCustomEditorWindowModelPart, evMultiSelectEditorWindow,
  evCustomEditor, evEditorWithOperations, evCustomMemo,
  vtDateEdit, evEdit, Grids, vtCtrls, evAACMaker, ActnList, Mask, vtCombo,
  evCustomEdit, evCustomEditorWindowPrim, evCustomEditorModelPart, evEditor;

type
 TMyStringGrid = class(TStringGrid)
 protected
  function CreateEditor: TInplaceEdit; override;
  function GetEditStyle(ACol, ARow: Longint): TEditStyle; override;
 public
  property InplaceEditor;
 end;

  TddAACForm = class(TForm)
    BtnPanel: TPanel;
    vtDateGroupBox: TvtGroupBox;
    vtListGroupBox: TvtGroupBox;
    NuberLabel: TvtLabel;
    NumberEdit: TevEdit;
    OkBTN: TBitBtn;
    CancelBTN: TBitBtn;
    TypePanel: TPanel;
    TypeLable: TvtLabel;
    vtLabel1: TvtLabel;
    vtGroupBox3: TvtGroupBox;
    vtDateLabel: TvtLabel;
    vtIzdanLabel: TvtLabel;
    IzdanNumberEdit: TevEdit;
    AddBitBtn: TBitBtn;
    DeleteBitBtn: TBitBtn;
    vtTypeCB: TvtComboBox;
    vtOrganCB: TvtComboBox;
    vtDateEdit: TvtDateEdit;
    ActionList1: TActionList;
    AddRow: TAction;
    DelRow: TAction;
    procedure AddRowUpdate(Sender: TObject);
    procedure AddRowExecute(Sender: TObject);
    procedure DelRowUpdate(Sender: TObject);
    procedure DelRowExecute(Sender: TObject);
    procedure OkBTNClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelBTNClick(Sender: TObject);
  private
    { Private declarations }
    f_AACMaker: TevAACMaker;
     {-}
    f_StringGrid: TMyStringGrid;
     {* - Таблица со значениями. }
    procedure InitListItems(ACol, ARow: Integer; Items: TStrings);
     {-}
    procedure OnResize(Sender: TObject);
     {-}
    procedure ReadAACData;
     {-}
    procedure InitGridControl;
     {-}
    procedure InitListControls;
     {-}
  public
    { Public declarations }
    class function Execute(const anEditor: TevEditor): Boolean;
     {-}
  end;

implementation

uses
 l3Base;

{$R *.dfm}

const
 cnIDColName = 0;
 cnIDColType = 1;
 cnColCount = cnIDColType + 1;
 cnStartRowCount = 10;

var
 g_ACCForm: TddAACForm;

{ TddAACForm }

procedure TddAACForm.InitGridControl;
begin
 f_StringGrid := TMyStringGrid.Create(Self);
 f_StringGrid.Align := alClient;
 f_StringGrid.ColCount := cnColCount;
 f_StringGrid.RowCount := cnStartRowCount;
 f_StringGrid.FixedCols := 0;
 f_StringGrid.Cells[cnIDColName, 0] := 'Название';
 f_StringGrid.Cells[cnIDColType, 0] := 'Тип';
 f_StringGrid.Options := f_StringGrid.Options + [goEditing, goColSizing];
 f_StringGrid.OnResize := OnResize;
 vtListGroupBox.InsertControl(f_StringGrid);
end;

procedure TddAACForm.InitListControls;
var
 l_DefIndex: Integer;
begin
 f_AACMaker.InitList(vtTypeCB.Items, aacTypeDoc, l_DefIndex);
 vtTypeCB.ItemIndex := l_DefIndex;
 f_AACMaker.InitList(vtOrganCB.Items, aacOrgan, l_DefIndex);
 vtOrganCB.ItemIndex := l_DefIndex;
 IzdanNumberEdit.TextSource.ReadOnly := False;
 NumberEdit.TextSource.ReadOnly := False;
 ReadAACData;
end;

procedure TddAACForm.InitListItems(ACol, ARow: Integer; Items: TStrings);
var
 l_DefIndex: Integer;
begin
 if (ACol = cnIDColType) and (ARow > 0) then
  f_AACMaker.InitList(Items, aacParticipants, l_DefIndex);
end;

procedure TddAACForm.ReadAACData;
var
 i          : Integer;
 l_FLC      : Integer;
 l_NewCount : Integer;
begin
 with f_AACMaker do
 begin
  if DocType <> '' then
   vtTypeCB.ItemIndex := vtTypeCB.Items.IndexOf(DocType);
  if Court <> '' then
   vtOrganCB.ItemIndex := vtOrganCB.Items.IndexOf(Court);
  if Trunc(DocDate) <> Trunc(Date) then
   vtDateEdit.Date := f_AACMaker.DocDate;
  if Number <> '' then
   IzdanNumberEdit.Text := Number;
  if LawCaseNumber <> '' then
   NumberEdit.Text := LawCaseNumber;
  if PartNames.Count > 0 then // PartNames.Count
  begin
   l_FLC := f_StringGrid.FixedRows;
   l_NewCount := PartNames.Count + l_FLC + 1;
   if l_NewCount > cnStartRowCount then
    f_StringGrid.RowCount := l_NewCount;
   for i := 0 to PartNames.Count - 1 do
   begin
    f_StringGrid.Cells[cnIDColName, i + l_FLC] := PartNames[i];
    f_StringGrid.Cells[cnIDColType, i + l_FLC] := PartTypes[i];
   end; //for i := 1 to aGrid.RowCount - 1 do
  end;
 end; // with f_AACMaker do
end;

procedure TddAACForm.OnResize(Sender: TObject);
var
 l_Part  : Integer;
 l_Width : Integer;
begin
 l_Width := f_StringGrid.ClientRect.Right - f_StringGrid.ClientRect.Left - f_StringGrid.GridLineWidth;
 l_Part := l_Width div 3;
 f_StringGrid.ColWidths[cnIDColType] := l_Part;
 f_StringGrid.ColWidths[cnIDColName] := l_Width - l_Part;
end;

class function TddAACForm.Execute(const anEditor: TevEditor): Boolean;
begin
 Result := False;
 Assert(g_ACCForm = nil);
 g_ACCForm := TddAACForm.Create(Application);
 with g_ACCForm do
 begin
  f_AACMaker := TevAACMaker.Create;
  Result := f_AACMaker.InitData(anEditor);
  FormStyle := fsStayOnTop;
  InitGridControl;
  InitListControls;
  Show;
 end; // with l_AACForm do
end;

{ TMyStringGrid }

function TMyStringGrid.CreateEditor: TInplaceEdit;
begin
 Result := TInplaceEditList.Create(Self);
 (Result as TInplaceEditList).OnGetPickListitems:= (Owner as TddAACForm).InitListItems;
end;

function TMyStringGrid.GetEditStyle(ACol, ARow: Integer): TEditStyle;
begin
 if ACol = 1 then
  Result := esPickList
 else
  Result := esSimple;
end;

procedure TddAACForm.AddRowUpdate(Sender: TObject);
begin
 (Sender as TAction).Enabled := f_StringGrid.Focused or AddBitBtn.Focused or DeleteBitBtn.Focused;
end;

procedure TddAACForm.AddRowExecute(Sender: TObject);
begin
 f_StringGrid.RowCount := f_StringGrid.RowCount + 1;
end;

procedure TddAACForm.DelRowUpdate(Sender: TObject);
begin
 (Sender as TAction).Enabled := (f_StringGrid.Focused or AddBitBtn.Focused or DeleteBitBtn.Focused) and (f_StringGrid.RowCount > 2);
end;

procedure TddAACForm.DelRowExecute(Sender: TObject);
begin
 f_StringGrid.RowCount := f_StringGrid.RowCount - 1;
end;

procedure TddAACForm.OkBTNClick(Sender: TObject);
var
 i: Integer;
begin
 with f_AACMaker do
 begin
  DocType := vtTypeCB.Text;
  Court := vtOrganCB.Text;
  DocDate := vtDateEdit.Date;
  Number := IzdanNumberEdit.Text;
  LawCaseNumber := NumberEdit.Text;
  PartTypes.Clear;
  PartNames.Clear;
  for i := 1 to f_StringGrid.RowCount - 1 do
   if (f_StringGrid.Cells[cnIDColName, i] <> '') and (f_StringGrid.Cells[cnIDColType, i] <> '') then
   begin
    PartTypes.Add(f_StringGrid.Cells[cnIDColType, i]);
    PartNames.Add(f_StringGrid.Cells[cnIDColName, i]);
   end; // if (f_StringGrid.Cells[cnIDColName, i] <> '') and (f_StringGrid.Cells[cnIDColType, i] <> '') then
  CheckAndApply; 
 end; //for i := 1 to aGrid.RowCount - 1 do
 Close;
end;

procedure TddAACForm.FormDestroy(Sender: TObject);
begin
 l3Free(f_AACMaker);
 g_ACCForm := nil;
end;

procedure TddAACForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TddAACForm.CancelBTNClick(Sender: TObject);
begin
 Close;
end;

end.
