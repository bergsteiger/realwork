{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{   Copyright (c) 2002, Elizabeth Krivonos,          }
{                       Alexander Hramov             }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

11/10/2002

  fixed problems with incorrect showing column information

*)

unit frmGridColProp;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  buttons,
  ElSpin,
  Forms,
  Dialogs,
  ComCtrls,
  StdCtrls,
  ExtCtrls,
  Math,
  DB,
  ElDBTree,
  ElDBTreeGrids,
  ElDBConst,
  ElTree,
  ElHeader,
  ElVCLUtils,
  ElTreeComboBox,
  ElXPThemedControl,
  ElUxTheme,
  ElTmSchema,
  {$ifdef VCL_6_USED}
  DesignEditors,
  DesignConst,
  DesignIntf,
  {$else}
  DsgnIntf,
  {$endif}
  ElTreeGrids,
  ElACtrls,
  ElEdits,
  ElBtnCtl,
  ElPopBtn,
  ElCLabel,
  ElLabel,
  ElPanel,
  HTMLLbx
  ;


type


  TElColumnsDefsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
  end;

  PDataRec = ^TDataRec;
  TDataRec = record
    ComboIdx : integer;
    DataField : string;
  end;

  TColumnDefs = class(TForm)
    Panel1: TElPanel;
    Panel2: TElPanel;
    NLabel1: TElLabel;
    NLabel2: TElLabel;
    Edit1: TElSpinEdit;
    Panel4: TElPanel;
    Button1: TElPopupButton;
    Button2: TElPopupButton;
    Button3: TElPopupButton;
    Button4: TElPopupButton;
    Tree: TElTreeStringGrid;
    InplaceCombo: TElTreeInplaceComboBox;
    DataSetCB: TElAdvancedComboBox;
    procedure FormShow(Sender: TObject);
    procedure DataSetCBChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure TreeItemDeletion(Sender: TObject;
      Item: TElTreeItem);
    procedure TreeItemDraw(Sender: TObject; Item: TElTreeItem;
      Surface: TCanvas; R: TRect; SectionIndex: Integer);
    procedure TreeClick(Sender: TObject);
    procedure InplaceComboBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure InplaceComboAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
  private
    oldvalue : integer;
  public
    AComp : TComponent;
    DStylesDefs : TElStylesDefs;
    DStylesDefsItem : TElStylesDefsItem;
    procedure SetValue;
    procedure GetValue;
  end;

{$ifdef VCL_6_USED}
var
{$else}
const
{$endif}
  ColumnDefs: TColumnDefs = nil;


implementation

{$R *.DFM}
type
  THackElStylesDefsItem = class(TElStylesDefsItem);

procedure TElColumnsDefsProperty.Edit;
begin
    if ColumnDefs = nil then
      ColumnDefs := TColumnDefs.Create(Application);
    with ColumnDefs do
    begin
        AComp := TComponent(GetComponent(0));
        DStylesDefs := TCustomElDBTree(GetComponent(0)).StylesDefs;
        if DStylesDefs.Count > 0 then
          begin
            ShowModal;
          end
        else ShowMessage (SNoSetInstall);
    end;
end;

function TElColumnsDefsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TColumnDefs.FormShow(Sender: TObject);
var i : integer;
begin
  DataSetCB.Clear;
      for i:=0 to DStylesDefs.Count-1 do
          if not (THackElStylesDefsItem(DStylesDefs[i]).FInDesign) then
            if DataSetCB.Items.IndexOf(THackElStylesDefsItem(DStylesDefs[i]).DataSetName) = -1 then
              DataSetCB.Items.Add(THackElStylesDefsItem(DStylesDefs[i]).DataSetName);
  i := (DStylesDefs.Tree as TElDBTreeStringGrid).ColCount;
  oldvalue := 1;
  Edit1.Value := i;
  Edit1Change(self);
  GetValue;
end;

procedure TColumnDefs.DataSetCBChange(Sender: TObject);
var i  : integer;
begin
  DStylesDefsItem := nil;
  for i := 0 to DStylesDefs.Count-1 do
    if THackElStylesDefsItem(DStylesDefs[i]).DataSetName = DataSetCB.Text then DStylesDefsItem := DStylesDefs[i];
  for i := 1 to Tree.Items.Count-1 do
    begin
      Tree.Items[i].ColumnText.Clear;
      PDataRec(Tree.Items[i].Data).ComboIdx :=0;
      PDataRec(Tree.Items[i].Data).DataField := 'empty column or defined by user';
    end;
end;

procedure TColumnDefs.Edit1Change(Sender: TObject);
var i : integer;
    TI : TElTreeItem;
    CS : TElCellStyle;
    PData : PDataRec;

begin
  if Edit1.Value < 1 then Edit1.Value := 1;
  if oldvalue < Edit1.Value then
    begin
      for i := oldvalue to Edit1.Value - 1 do
        begin
          New(PData);
          PData^.ComboIdx := 0;
          PData^.DataField := 'empty column or defined by user';
          TI := Tree.Items.AddLastItem(nil);
          TI.Data := PData;
          TI.Text := 'Column'+IntToStr(TI.Index+1);
          TI.UseStyles := true;
          CS := TI.AddStyle;
          CS.OwnerProps := true;
          CS.Style := elhsOwnerDraw;
          CS.CellType := sftEnum;
          CS := TI.AddStyle;
          CS.OwnerProps := true;
          CS.Style := elhsOwnerDraw;
        end;
    end
  else
    begin
      for i := oldvalue downto Edit1.Value do
        begin
          Tree.Items.Delete(Tree.Items[i]);
        end;
    end;
  oldvalue := Edit1.value;
end;

procedure TColumnDefs.Button1Click(Sender: TObject);
begin
  if (AComp is TElDBTreeStringGrid) then
    if Assigned((AComp as TElDBTreeStringGrid).DataSource.DataSet) then
    begin
      (AComp as TElDBTreeStringGrid).ColCount := Edit1.Value;
      SetValue;
      (AComp as TElDBTreeStringGrid).RebuildTree(true);
    end
    else
      ShowMessage(SNoDSetInstall);
  Close;
end;

procedure TColumnDefs.SetValue;
var
  i,j : integer;
  s : string;
begin
  for j := 0 to DStylesDefs.Count - 1 do
  begin
    DStylesDefs[j].DataFields.Clear;
    if THackElStylesDefsItem(DStylesDefs[j]).DataSetName = DataSetCB.Text then
    begin
      for i := 1 to Edit1.Value - 1 do
      begin
        THackElStylesDefsItem(DStylesDefs[j]).FHasColumn := True;
        s := PDataRec(Tree.Items[i].Data).DataField;
        DStylesDefs[j].DataFields.Add(s);
        if s <> 'empty column or defined by user' then
          begin
          {$IFDEF D_4_UP}
            if THackElStylesDefsItem(DStylesDefs[j]).FDataLink.DataSet.DefaultFields then
            begin
              (DStylesDefs.Tree as TElDBTreeStringGrid).HeaderSections[i].Text := THackElStylesDefsItem(DStylesDefs[j]).FDataLink.DataSet.FieldDefList.Find(s).DisplayName;
            end
            else
            begin
              (DStylesDefs.Tree as TElDBTreeStringGrid).HeaderSections[i].Text := THackElStylesDefsItem(DStylesDefs[j]).FDataLink.DataSet.FindField(s).DisplayLabel;
            end;
          {$ELSE}
            (DStylesDefs.Tree as TElDBTreeStringGrid).HeaderSections[i].Text := THackElStylesDefsItem(DStylesDefs[j]).FDataLink.DataSet.FindField(s).DisplayLabel;
          {$ENDIF}
//            (DStylesDefs.Tree as TElDBTreeStringGrid).HeaderSections[i].Text := s;
            (DStylesDefs.Tree as TElDBTreeStringGrid).HeaderSections[i].AutoSize := (DStylesDefs.Tree as TElDBTreeStringGrid).AutoResizeColumns;
          end
        else
          (DStylesDefs.Tree as TElDBTreeStringGrid).HeaderSections[i].Text := '';
      end;
    end;
  end;
  if (DStylesDefs.Tree as TElDBTreeStringGrid).AutoResizeColumns then
    if Assigned((DStylesDefs.Tree as TElDBTreeStringGrid).Items.RootItem[0]) then
      (DStylesDefs.Tree as TElDBTreeStringGrid).Items.RootItem[0].TreeView.AutoSizeAllColumns;
end;

procedure TColumnDefs.Button2Click(Sender: TObject);
begin
  if (AComp is TElDBTreeStringGrid) then
    begin
      (AComp as TElDBTreeStringGrid).ColCount := Edit1.Value;
      SetValue;
      (AComp as TElDBTreeStringGrid).RebuildTree(true);
    end;
end;

procedure TColumnDefs.GetValue;
var i,j : integer;
begin
  for j := 0 to DStylesDefs.Count-1 do
  begin
    if DStylesDefs[j].DataFields.Count > 0 then
    begin
      DStylesDefsItem := DStylesDefs[j];
      DataSetCB.Text := THackElStylesDefsItem(DStylesDefsItem).DataSetName;
      DataSetCBChange(self);
      Edit1.Value := DStylesDefs[j].DataFields.Count + 1;
      for i := 1 to Edit1.Value - 1 do
      begin
        PDataRec(Tree.Items[i].Data).DataField := DStylesDefsItem.DataFields.Strings[i-1];
        if DStylesDefsItem.DataFields.Strings[i-1] <> 'empty column or defined by user' then
        begin
          if Assigned(THackElStylesDefsItem(DStylesDefsItem).FDataLink.DataSet.FindField(DStylesDefsItem.DataFields.Strings[i-1])) then
            PDataRec(Tree.Items[i].Data).ComboIdx := THackElStylesDefsItem(DStylesDefsItem).FDataLink.DataSet.FindField(DStylesDefsItem.DataFields.Strings[i-1]).FieldNo
          else
          begin
            PDataRec(Tree.Items[i].Data).ComboIdx := 0;
            DStylesDefsItem.DataFields.Strings[i-1] := 'empty column or defined by user';
            PDataRec(Tree.Items[i].Data).DataField := DStylesDefsItem.DataFields.Strings[i-1];
          end;
        end
        else PDataRec(Tree.Items[i].Data).ComboIdx := 0;
      end;
      Tree.Refresh;
      break;
    end;
  end;
end;

procedure TColumnDefs.Button3Click(Sender: TObject);
var i : integer;
begin
  DataSetCB.Clear;
      for i:=0 to DStylesDefs.Count-1 do
          if not THackElStylesDefsItem(DStylesDefs[i]).FInDesign then DataSetCB.Items.Add(THackElStylesDefsItem(DStylesDefs[i]).DataSetName);
  i := (DStylesDefs.Tree as TElDBTreeStringGrid).ColCount;
  Edit1.Value := i;
  Edit1Change(Self);
  GetValue;
end;

procedure TColumnDefs.Button4Click(Sender: TObject);
begin
  Close;
end;

procedure TColumnDefs.TreeItemDeletion(Sender: TObject;
  Item: TElTreeItem);
begin
  Dispose(Item.Data);
end;

procedure TColumnDefs.TreeItemDraw(Sender: TObject; Item: TElTreeItem;
  Surface: TCanvas; R: TRect; SectionIndex: Integer);
var
  ArrowColor: TColor;
begin
  Surface.Brush.Style := bsClear;
  if SectionIndex = 1 then
  begin
    Dec(R.Right, 20);
    DrawText(Surface.Handle, Pchar(PDataRec(Item.Data).DataField), -1, R, DT_LEFT or DT_SINGLELINE or DT_VCENTER);
    R.Left := R.Right;
    R.Right := R.Right + 20;
    if Item.Selected then
      ArrowColor := clHighlightText
    else
      ArrowColor := clWindowText;
    ElVCLUtils.DrawArrow(Surface, eadDown, R, ArrowColor, true);
  end;
end;

procedure TColumnDefs.TreeClick(Sender: TObject);
var HS : integer;
    Item : TElTreeItem;
    ItemPart: TSTItemPart;
    P       : TPoint;
begin
  GetCursorPos(P);
  P := Tree.ScreenToClient(P);
  Item := Tree.GetItemAt(P.x, P.Y, ItemPart, HS);
  if HS = 1 then
    if P.X > Tree.HeaderSections[HS].Right -10 then
      Tree.EditItem(Item, HS);
end;

procedure TColumnDefs.InplaceComboBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  comboBox : TElHTMLComboBox;
    i : integer;
begin
  ComboBox := InplaceCombo.Editor;
  Combobox.Items.Clear;
  Combobox.Items.Add('empty column or defined by user');
  if (DStylesDefsItem <> nil) and (THackElStylesDefsItem(DStylesDefsItem).FDataLink.DataSet <> nil) then
    for i := 0 to THackElStylesDefsItem(DStylesDefsItem).FDataLink.DataSet.FieldCount-1 do
      Combobox.Items.Add(THackElStylesDefsItem(DStylesDefsItem).FDataLink.DataSet.Fields[i].FieldName);
  ComboBox.Text := PDataRec(InplaceCombo.Item.Data).DataField;
  ComboBox.ItemIndex := PDataRec(InplaceCombo.Item.Data).ComboIdx;
  Combobox.Style := csDropDownList;
  InplaceCombo.ValueAsText := PDataRec(InplaceCombo.Item.Data).DataField;
end;

procedure TColumnDefs.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Tree.IsEditing then Tree.EndEdit(true);
end;

procedure TColumnDefs.InplaceComboAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
var comboBox : TElHTMLComboBox;//TElAdvancedCombobox;
begin
  ComboBox := InplaceCombo.Editor;
  if ComboBox.ItemIndex >= 0 then
    begin
      PDataRec(InplaceCombo.Item.Data).ComboIdx := ComboBox.ItemIndex;
      PDataRec(InplaceCombo.Item.Data).DataField := ComboBox.Items[ComboBox.ItemIndex];
      Accepted := true;
    end
  else
    Accepted := false;
end;

end.
