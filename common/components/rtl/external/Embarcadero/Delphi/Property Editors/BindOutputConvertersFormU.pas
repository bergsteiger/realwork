{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindOutputConvertersFormU;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ActnList, Data.Bind.Components,
  System.Generics.Collections, System.Bindings.Outputs, DesignIntf,
  System.Actions;

type

  TBindOutputConvertersForm = class(TForm)
    HelpBtn: TButton;
    OKBtn: TButton;
    CancelBtn: TButton;
    ActionList1: TActionList;
    AcceptAction: TAction;
    ListView1: TListView;
    CheckBoxSelectAll: TCheckBox;
    ActionSelectAll: TAction;
    procedure HelpBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DataBindingListCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure DataBindingListDblClick(Sender: TObject);
    procedure AcceptActionUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListView1Click(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure actnSelectAllUpdate(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure ListView1InfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: string);
  private
    FSortColumn: Integer;
    FDictionary: TDictionary<Pointer, TConverterDescription>;
    FBindArtifacts: TBindArtifacts;
    FArtifactDictionary: TDictionary<string,
      TBindArtifactItem>;
    FModified: Boolean;
    FUpdateAllChecked: Boolean;
    FAllChecked: Boolean;
    FAllUnchecked: Boolean;
    FChecking: Boolean;
    FDesignerIntf: IDesigner;
    function AddArtifact(AArtifact: TConverterDescription): TListItem;
    procedure AddArtifacts(AUpdateColumns: Boolean);
    function GetRegKey: string;
    procedure SetBindArtifacts(const Value: TBindArtifacts);
    procedure Modified;
    procedure CheckAllItems(ACheck: Boolean);
    procedure UpdateAllChecked;
    function GetAllChecked: Boolean;
    function GetAllUnChecked: Boolean;
    procedure SelectAllItems;
    procedure LoadSizes;
    procedure SaveSizes;
    procedure SetDesigner(const Value: IDesigner);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ApplyChanges;
    property BindArtifacts: TBindArtifacts read FBindArtifacts write SetBindArtifacts;
    property DesignerIntf: IDesigner read FDesignerIntf write SetDesigner;
  end;

implementation

{$R *.dfm}

uses DsnConst, System.Win.Registry;

procedure TBindOutputConvertersForm.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TBindOutputConvertersForm.ListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
//
  if Change = ctState then
  begin
    FUpdateAllChecked := True;
    Modified;
  end;
end;

procedure TBindOutputConvertersForm.ListView1Click(Sender: TObject);
begin
//
end;

procedure TBindOutputConvertersForm.ListView1InfoTip(Sender: TObject;
  Item: TListItem; var InfoTip: string);
var
  LConverter: TConverterDescription;
begin
  if Item <> nil then
  begin
    if not FDictionary.ContainsKey(Item.Data) then
    begin
      Assert(False);
    end;
    LConverter := FDictionary[Item.Data];
    if LConverter.Description <> '' then
      InfoTip := LConverter.Description
    else
      InfoTip := LConverter.DisplayName;
  end;
end;

procedure TBindOutputConvertersForm.Modified;
begin
  FModified := True;
end;


function TBindOutputConvertersForm.AddArtifact(AArtifact: TConverterDescription): TListItem;
  function FrameworkName(AFrameworkClass: TPersistentClass): string;
  begin
    if (AFrameworkClass = nil) or TComponent.InheritsFrom(AFrameworkClass) then
      Result := ''
    else
    begin
      if TControl.InheritsFrom(AFrameworkClass) then
        Result := 'VCL'  // Do not localize
      else
        Result := 'FMX'  // Do not localize
    end;
  end;
var
  LItem: TListItem;
  LCaption: string;
  I: Integer;
  LBindArtifactItem: TBindArtifactItem;
  LHaveItem: Boolean;
begin
  LItem := ListView1.Items.Add;
  with LItem do
  begin
    LHaveItem := FArtifactDictionary.TryGetValue(AArtifact.ID, LBindArtifactItem);
    Caption := AArtifact.ID;
    for I := 1 to ListView1.Columns.Count  - 1 do
    begin
      case I of
        1: LCaption := AArtifact.UnitName;
        2: LCaption := FrameworkName(AArtifact.FrameWorkClass);
      else
        LCaption := '';
      end;

      LItem.SubItems.Add(LCaption);
    end;
    if LHaveItem then
      LItem.Checked := LBindArtifactItem.State = TBindArtifactState.eaInclude
    else
      LItem.Checked := AArtifact.DefaultEnabled;
  end;
  Result := LItem;
end;

procedure TBindOutputConvertersForm.AddArtifacts(AUpdateColumns: Boolean);
var
  LConverter: TConverterDescription;
  LCounter: Integer;
  LItem: TListItem;
  LKeys: TList<string>;
begin
  LCounter := 0;
  LKeys := TList<string>.Create;
  try
    ListView1.Items.BeginUpdate;
    try
      ListView1.Items.Clear;
      FDictionary.Clear;
      for LConverter in TValueRefConverterFactory.GetConverterDescriptions do
      begin
        // Converters with the same ID are considered part of the same set (e.g.; FloatToStr ID is for extended and single converters)
        if not LKeys.Contains(LConverter.ID) then
        begin
          LItem := AddArtifact(LConverter);
          LItem.Data := Pointer(LCounter);
          FDictionary.Add(LItem.Data, LConverter);
          Inc(LCounter);
          LKeys.Add(LConverter.ID);
        end;
      end;
    finally
      ListView1.Items.EndUpdate;
      FUpdateAllChecked := True;
    end;
  finally
    LKeys.Free;
  end;
end;

procedure TBindOutputConvertersForm.ApplyChanges;
var
  LListItem: TListItem;
  LConverter: TConverterDescription;
  LBindArtifact: TBindArtifactItem;
  LHaveItems: Boolean;
  LChecked: Boolean;
begin
  for LListItem in ListView1.Items do
  begin
    if not FDictionary.ContainsKey(LListItem.Data) then
    begin
      Assert(False);
      continue;
    end;
    LConverter := FDictionary[LListItem.Data];
    LChecked := LListItem.Checked;
    LHaveItems := FArtifactDictionary.TryGetValue(LConverter.ID, LBindArtifact);
    if (not LHaveItems) then
    begin
      if LChecked <> LConverter.DefaultEnabled then
      begin
        LBindArtifact := TBindArtifactItem(FBindArtifacts.Add);
        LBindArtifact.ID := LConverter.ID;
        if LChecked then
          LBindArtifact.State := TBindArtifactState.eaInclude
        else
          LBindArtifact.State := TBindArtifactState.eaExclude
      end;
    end
    else
    begin
      if LChecked then
      begin
        if LConverter.DefaultEnabled then
        begin
          //if this is defaultEnabled, remove the item instead of marking the state
          FBindArtifacts.Delete(LBindArtifact.Index);
          FArtifactDictionary.Remove(LConverter.ID);
        end
        else
          LBindArtifact.State := TBindArtifactState.eaInclude
      end
      else
        LBindArtifact.State := TBindArtifactState.eaExclude
    end;
  end;
end;


constructor TBindOutputConvertersForm.Create(AOwner: TComponent);
begin
  inherited;
  FDictionary := TDictionary<Pointer, TConverterDescription>.Create;
  FArtifactDictionary := TDictionary<string,
      TBindArtifactItem>.Create;
end;

const
  sWidth = 'Width';
  sHeight = 'Height';

procedure TBindOutputConvertersForm.LoadSizes;
var
  LIndex: Integer;
  LSubKey: string;
begin
  LSubKey := TBindOutputConvertersForm.ClassName;
  with TRegIniFile.Create(GetRegKey) do
  try
    Width := ReadInteger(LSubKey, sWidth, Width);
    Height := ReadInteger(LSubKey, sHeight, Height);
    for LIndex := 0 to ListView1.Columns.Count - 1 do
      with ListView1.Columns.Items[LIndex] do
        Width := ReadInteger(LSubKey, sWidth+IntToStr(LIndex), Width);
  finally
    Free;
  end;
end;

procedure TBindOutputConvertersForm.SaveSizes;
var
  LIndex: Integer;
  LSubKey: string;
begin
  LSubKey := TBindOutputConvertersForm.ClassName;
  with TRegIniFile.Create(GetRegKey) do
  try
    EraseSection(LSubKey);
    WriteInteger(LSubKey, sWidth, Width);
    WriteInteger(LSubKey, sHeight, Height);
    for LIndex := 0 to ListView1.Columns.Count - 1 do
      with ListView1.Columns.Items[LIndex] do
        WriteInteger(LSubKey, sWidth+IntToStr(LIndex), Width);
  finally
    Free;
  end;
end;

function TBindOutputConvertersForm.GetRegKey: string;
begin
  Result := DesignerIntf.GetBaseRegKey + '\' + sIniEditorsName + '\Output Converter Editor';
end;

procedure TBindOutputConvertersForm.SetBindArtifacts(
  const Value: TBindArtifacts);
var
  LItem: TCollectionItem;
  LBindArtifactItem: TBindArtifactItem;
begin
  FBindArtifacts := Value;
  FArtifactDictionary.Clear;
  if FBindArtifacts <> nil then
    for LItem in FBindArtifacts do
    begin
      LBindArtifactItem := TBindArtifactItem(LItem);
      FArtifactDictionary.Add(LBindArtifactItem.ID, LBindArtifactItem);
    end;

  ListView1.Clear;
  AddArtifacts(True);
  FUpdateAllChecked := True;

end;

procedure TBindOutputConvertersForm.SetDesigner(const Value: IDesigner);
begin
  FDesignerIntf := Value;
  if FDesignerIntf <> nil then
    LoadSizes;
end;

procedure TBindOutputConvertersForm.FormShow(Sender: TObject);
begin
  ListView1.SetFocus;
end;

procedure TBindOutputConvertersForm.DataBindingListCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if Abs(FSortColumn) = 1 then
    Compare := FSortColumn * AnsiCompareText(Item1.Caption, Item2.Caption) else
    Compare := FSortColumn * AnsiCompareText(Item1.SubItems[0], Item2.SubItems[0]);
end;

procedure TBindOutputConvertersForm.DataBindingListDblClick(Sender: TObject);
begin
//  if OKBtn.Enabled then OKBtn.Click;
end;

destructor TBindOutputConvertersForm.Destroy;
begin
  FDictionary.Free;
  FArtifactDictionary.Free;
  inherited;
end;

procedure TBindOutputConvertersForm.AcceptActionUpdate(Sender: TObject);
begin
  AcceptAction.Enabled := FModified;
end;

procedure TBindOutputConvertersForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DesignerIntf <> nil then
    SaveSizes;
end;

procedure TBindOutputConvertersForm.UpdateAllChecked;
var
  I: Integer;
begin
  if FUpdateAllChecked then
  begin
    FUpdateAllChecked := False;
    FAllChecked := True;
    FAllUnchecked := True;
    for I := 0 to ListView1.Items.Count - 1 do
    begin
      if not ListView1.Items[I].Checked then
        FAllChecked := False
      else
        FAllUnchecked := False
    end;
    if FAllChecked and FAllUnchecked then
      FAllChecked := False;
  end;
end;

procedure TBindOutputConvertersForm.CheckAllItems(ACheck: Boolean);
var
  I: Integer;
begin
  for I := 0 to ListView1.Items.Count - 1 do
  begin
    ListView1.Items[I].Checked := ACheck;
  end;
end;

function TBindOutputConvertersForm.GetAllChecked: Boolean;
begin
  UpdateAllChecked;
  Result := FAllChecked;
end;

function TBindOutputConvertersForm.GetAllUnChecked: Boolean;
begin
  UpdateAllChecked;
  Result := FAllUnChecked;
end;

procedure TBindOutputConvertersForm.actnSelectAllUpdate(Sender: TObject);
begin
  if FChecking then
    Exit;
  FChecking := True;
  try
    if GetAllChecked then
      CheckBoxSelectAll.State := TCheckBoxState.cbChecked
    else if GetAllUnchecked then
      CheckBoxSelectAll.State := TCheckBoxState.cbUnchecked
    else
      CheckBoxSelectAll.State := TCheckBoxState.cbGrayed;
  finally
    FChecking := False;
  end;
end;

procedure TBindOutputConvertersForm.actSelectAllExecute(Sender: TObject);
begin
  SelectAllItems;
end;

procedure TBindOutputConvertersForm.SelectAllItems;
begin
  if FChecking then
    Exit;
  if GetAllChecked then
    //CheckAll(TCheckState.csUnCheckedNormal)
    CheckAllItems(False)
  else if GetAllUnchecked then
    //CheckAll(TCheckState.csCheckedNormal)
    CheckAllItems(True)
  else
    //CheckAll(TCheckState.csUnCheckedNormal);
    CheckAllItems(False);
end;

end.

