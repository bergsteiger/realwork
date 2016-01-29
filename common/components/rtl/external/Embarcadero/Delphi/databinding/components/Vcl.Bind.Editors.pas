{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Vcl.Bind.Editors"'}    {Do not Localize}
unit Vcl.Bind.Editors;

interface

uses
  System.Classes, System.Bindings.EvalProtocol, Data.Bind.Components, Data.Bind.Editors, Vcl.StdCtrls, System.Bindings.ObjEval, Vcl.ComCtrls, Vcl.Grids,
  Vcl.Controls, Generics.Collections, System.Rtti, System.SysUtils, System.UITypes;

type
  TBindStateCheckBoxEditor = class(TBindCheckBoxEditor)
  private
    FCheckBox: TCheckBox;
  public
    constructor Create(ACheckBox: TCheckBox);
    function GetState: TBindCheckBoxState; override;
    procedure SetState(Value: TBindCheckBoxState); override;
    function GetAllowGrayed: Boolean; override;
    procedure SetAllowGrayed(Value: Boolean); override;
  end;

  TLookupKey = integer;

  TBaseListBoxItemEditorObject = class
  protected
    FIndex: Integer;
    function GetControlItems: TStrings; virtual; abstract;
    function GetControlItemIndex: Integer; virtual; abstract;
    procedure SetControlItemIndex(AIndex: Integer); virtual; abstract;
    procedure ControlClear; virtual; abstract;

    function GetLookupKey: TLookupKey;
  public
    property ControlItems: TStrings read GetControlItems;
    property ControlItemIndex: Integer read GetControlItemIndex write SetControlItemIndex;
  end;

  TListBoxItemEditorObject = class(TBaseListBoxItemEditorObject)
  private
    FListBox: TCustomListBox;
    function GetOwner: TCustomListBox;
    procedure SetText(const Value: string);
    function GetText: string;
  protected
    function GetControlItems: TStrings; override;
    function GetControlItemIndex: Integer; override;
    procedure SetControlItemIndex(AIndex: Integer); override;
    procedure ControlClear; override;
  public
    constructor Create(AListBox: TCustomListBox);
    property Text: string read GetText write SetText;
    property Owner: TCustomListBox read GetOwner;
  end;

  TComboBoxItemEditorObject = class(TBaseListBoxItemEditorObject)
  private
    FComboBox: TCustomComboBox;
    function GetOwner: TCustomComboBox;
    procedure SetText(const Value: string);
    function GetText: string;
  protected
    function GetControlItems: TStrings; override;
    function GetControlItemIndex: Integer; override;
    procedure SetControlItemIndex(AIndex: Integer); override;
    procedure ControlClear; override;
  public
    constructor Create(AComboBox: TCustomComboBox);
    property Text: string read GetText write SetText;
    property Owner: TCustomComboBox read GetOwner;
  end;

  TBindListLookupEditorImpl = class(TBindListLookupEditor)
  strict private
    FCurrentKey: TLookupKey;
    FLookupDictionary: TDictionary<TLookupKey, TValue>;
    function FindLookupValue(const AValue: TValue): TLookupKey;
    function SameValue(const AValue1, AValue2: TValue): Boolean;
  protected
    function NextKey: Integer;
    procedure ListCleared;
    procedure ItemRemoved(AListItem: TLookupKey);

    // List accessors
    function GetLookupKey(AListItemObject: TObject): TLookupKey; virtual; abstract;
    function GetSelected: TLookupKey; virtual; abstract;
    function ListCount: Integer; virtual; abstract;
    function GetListItem(I: Integer): TLookupKey; virtual; abstract;
    procedure SetSelected(ALookupKey: TLookupKey); virtual; abstract;
    { IBindListLookup }
    function GetLookupValue(const AScope: IScope): TValue; override;
    procedure SetLookupValue(const AScope: IScope; const AValue: TValue); override;
    function GetSelectedLookupValue: TValue; override;
    procedure SetSelectedLookupValue(const AValue: TValue); override;

  public
    destructor Destroy; override;
  end;

  TBaseBindListListBoxEditor = class(TBindListLookupEditorImpl)
  private
    FEditorObject: TBaseListBoxItemEditorObject;
    FUpdateCounter: Integer;
  protected
    function CreateItemsEditor(AControl: TControl): TBaseListBoxItemEditorObject; virtual; abstract;
    { IBindListLookup }
    function GetLookupKey(AListItemObject: TObject): TLookupKey; override;

    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    function AddItem(Select: Boolean = False): IScope; override;
    function InsertItem(Select: Boolean = False): IScope; override;
    function CanInsertItem: Boolean; override;
    function CurrentItem: IScope; override;
    function GetRowCount: Integer; override;
    function MoveNext: Boolean; override;
    procedure DeleteToEnd; override;
    procedure ClearList; override;
    function GetSelectedText: string; override;
    procedure SetSelectedText(const AValue: string); override;

    function CurrentIndex: Integer; override;
  public
    constructor Create(AControl: TControl);
    destructor Destroy; override;
  end;

  TBindListListBoxEditor = class(TBaseBindListListBoxEditor)
  private
    FListBox: TCustomListBox;
  protected
    function CreateItemsEditor(AControl: TControl): TBaseListBoxItemEditorObject; override;
    function GetSelected: TLookupKey; override;
    function ListCount: Integer; override;
    function GetListItem(I: Integer): TLookupKey; override;
    procedure SetSelected(ALookupKey: TLookupKey); override;
  public
    constructor Create(AListBox: TCustomListBox);
    destructor Destroy; override;
  end;

  TBindListComboBoxEditor = class(TBaseBindListListBoxEditor)
  private
    FListBox: TCustomComboBox;
  protected
    function CreateItemsEditor(AControl: TControl): TBaseListBoxItemEditorObject; override;
    { IBindListLookup }
    function GetSelected: TLookupKey; override;
    function ListCount: Integer; override;
    function GetListItem(I: Integer): TLookupKey; override;
    procedure SetSelected(ALookupKey: TLookupKey); override;
  public
    constructor Create(ACombobox: TCustomComboBox);
    destructor Destroy; override;
  end;

  TListViewItemEditorObject = class
  private
    FListView: TCustomListView;
    FItemIndex: Integer;
    function GetOwner: TCustomListView;
    procedure SetText(const Value: string);
    function GetText: string;
    function CurrentItem: TListItem;
    function GetCaption: string;
    function GetChecked: Boolean;
    function GetData: TCustomData;
    function GetFocused: Boolean;
    function GetGroupID: Integer;
    function GetImageIndex: TImageIndex;
    function GetIndent: Integer;
    function GetLeft: Integer;
    function GetOverlayIndex: TImageIndex;
    function GetSelected: Boolean;
    function GetStateIndex: TImageIndex;
    function GetSubItemImage(Index: Integer): Integer;
    function GetSubItems: TStrings;
    function GetTop: Integer;
    procedure SetCaption(const Value: string);
    procedure SetChecked(const Value: Boolean);
    procedure SetData(const Value: TCustomData);
    procedure SetFocused(const Value: Boolean);
    procedure SetGroupID(const Value: Integer);
    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetIndent(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetOverlayIndex(const Value: TImageIndex);
    procedure SetSelected(const Value: Boolean);
    procedure SetStateIndex(const Value: TImageIndex);
    procedure SetSubItemImage(Index: Integer; const Value: Integer);
    procedure SetSubItems(const Value: TStrings);
    procedure SetTop(const Value: Integer);
    function CheckRange: Boolean;
  public
    property Text: string read GetText write SetText;
    property Owner: TCustomListView read GetOwner;
    property Caption: string read GetCaption write SetCaption;
    property Checked: Boolean read GetChecked write SetChecked;
    property Data: TCustomData read GetData write SetData;
    property Focused: Boolean read GetFocused write SetFocused;
    property GroupID: Integer read GetGroupID write SetGroupID;
    property ImageIndex: TImageIndex read GetImageIndex write SetImageIndex;
    property Indent: Integer read GetIndent write SetIndent;
    property Left: Integer read GetLeft write SetLeft;
    property OverlayIndex: TImageIndex read GetOverlayIndex write SetOverlayIndex;
    property Selected: Boolean read GetSelected write SetSelected;
    property StateIndex: TImageIndex read GetStateIndex write SetStateIndex;
    property SubItems: TStrings read GetSubItems write SetSubItems;
    property SubItemImages[Index: Integer]: Integer read GetSubItemImage write SetSubItemImage;
    property Top: Integer read GetTop write SetTop;
  end;

  TListViewGroupEditorObject = class
  private
    FEditorObject: TListViewItemEditorObject;
    function GetFooter: string;
    function GetFooterAlign: TAlignment;
    function GetGroupID: Integer;
    function GetGroupObject: TListGroup;
    function GetHeader: string;
    function GetHeaderAlign: TAlignment;
    function GetOwner: TCustomListView;
    function GetState: TListGroupStateSet;
    function GetSubtitle: string;
    function GetTitleImage: TImageIndex;
    procedure SetFooter(const Value: string);
    procedure SetFooterAlign(const Value: TAlignment);
    procedure SetGroupID(const Value: Integer);
    procedure SetHeader(const Value: string);
    procedure SetHeaderAlign(const Value: TAlignment);
    procedure SetState(const Value: TListGroupStateSet);
    procedure SetSubtitle(const Value: string);
    procedure SetTitleImage(const Value: TImageIndex);
    function CheckGroup(out AGroup: TListGroup): Boolean;
  public
    constructor Create(AEditorObject: TListViewItemEditorObject);
    property GroupObject: TListGroup read GetGroupObject;
    property Owner: TCustomListView read GetOwner;
    property Header: string read GetHeader write SetHeader;
    property Footer: string read GetFooter write SetFooter;
    property GroupID: Integer read GetGroupID write SetGroupID;
    property State: TListGroupStateSet read GetState write SetState;
    property HeaderAlign: TAlignment read GetHeaderAlign write SetHeaderAlign;
    property FooterAlign: TAlignment read GetFooterAlign write SetFooterAlign;
    property Subtitle: string read GetSubtitle write SetSubtitle;

    property TitleImage: TImageIndex read GetTitleImage write SetTitleImage;
  end;

  TBindListListViewEditor = class(TBindListLookupEditorImpl, IBindFillControlMembers,
    IBindListGroupEditor)
  private
    FUpdateCounter: Integer;
    FEditorObject: TListViewItemEditorObject;
    FGroupEditorObject: TListViewGroupEditorObject;
  protected
    // List accessors
    function GetLookupKey(
      AListItemObject: TObject): TLookupKey; override;
    function GetSelected: TLookupKey; override;
    function ListCount: Integer; override;
    function GetListItem(I: Integer): TLookupKey; override;
    procedure SetSelected(ALookupKey: TLookupKey); override;
    { IBindFillControlMembers }
    procedure GetItemMemberNames(ANames: TStrings); override;
    function GetItemMemberNameExpression(const AName: string): string; override;
    procedure GetHeaderMemberNames(ANames: TStrings); override;
    function GetHeaderMemberNameExpression(const AName: string): string; override;
    function CurrentHeaderItem: IScope; override;
    function CurrentIndex: Integer; override;
    function CurrentObject: TObject; override;
  public
    constructor Create(AListView: TCustomListView);
    destructor Destroy; override;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    function AddItem(Select: Boolean): IScope; override;
    function AddHeader: IScope; override;
    function InsertItem(Select: Boolean): IScope; override;
    function CanInsertItem: Boolean; override;
    function CurrentItem: IScope; override;
    function GetRowCount: Integer; override;
    function MoveNext: Boolean; override;
    procedure DeleteToEnd; override;
    procedure ClearList; override;
    function GetSelectedText: string; override;
    procedure SetSelectedText(const AValue: string); override;
  end;

  TStringGridItemEditorObject = class
  private
    FStringGrid: TStringGrid;
    FIndex: Integer;
    function GetOwner: TStringGrid;
    function GetCells(ACol: Integer): string;
    procedure SetCells(ACol: Integer; const Value: string);
  public
    property Owner: TStringGrid read GetOwner;
    property Cells[ACol: Integer]: string read GetCells write SetCells;
  end;

  TBindListStringGridEditor = class(TBindGridEditor)
  private
    FUpdateCounter: Integer;
    FIsEmpty: Boolean;
    FEditorObject: TStringGridItemEditorObject;
    function IsEmpty: Boolean;
  protected
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    function AddItem(Select: Boolean): IScope; override;
    function CanInsertItem: Boolean; override;
    function InsertItem(Select: Boolean): IScope; override;
    function CurrentItem: IScope; override;
    function GetRowCount: Integer; override;
    function MoveNext: Boolean; override;
    procedure DeleteToEnd; override;
    procedure ClearList; override;
    function GetSelectedText: string; override;
    procedure SetSelectedText(const AValue: string); override;
    procedure GetColumnIndices(ANames: TStrings); override;
    procedure GetColumnNames(ANames: TStrings); override;
    function GetPositionGetter(var AGetter: string;
      var ABase: Integer): Boolean;  override;
    function GetPositionSetter(var ASetter: string;
      var ABase: Integer): Boolean;  override;
  public
    constructor Create(AGrid: TStringGrid);
    destructor Destroy; override;
  end;



implementation

uses System.Math, System.StrUtils,
  Vcl.ExtCtrls, Vcl.Mask;                                       

var
  GEditors: TEditors;

type
  TBindCheckBoxEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
  end;

  TBindListBoxEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
  end;

  TBindComboBoxEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
  end;


  TBindListViewEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
  end;


  TBindStringGridEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
  end;



{ TListBoxItemEditorObject }

procedure TListBoxItemEditorObject.ControlClear;
begin
  FListBox.Items.Clear;
end;

constructor TListBoxItemEditorObject.Create(AListBox: TCustomListBox);
begin
  FListBox := AListBox;
end;

function TListBoxItemEditorObject.GetControlItemIndex: Integer;
begin
  Result := FListBox.ItemIndex;
end;

function TListBoxItemEditorObject.GetControlItems: TStrings;
begin
  Result := FListBox.Items;
end;

function TListBoxItemEditorObject.GetOwner: TCustomListBox;
begin
  Result := FListBox;
end;

function TListBoxItemEditorObject.GetText: string;
begin
  Result := FListBox.Items[FIndex];

end;

procedure TListBoxItemEditorObject.SetControlItemIndex(AIndex: Integer);
begin
  FListBox.ItemIndex := AIndex;
end;

procedure TListBoxItemEditorObject.SetText(const Value: string);
begin
  FListBox.Items[FIndex] := Value;
end;

{ TComboBoxItemEditorObject }

procedure TComboBoxItemEditorObject.ControlClear;
begin
  FComboBox.Items.Clear;
end;

constructor TComboBoxItemEditorObject.Create(AComboBox: TCustomComboBox);
begin
  FComboBox := AComboBox;
end;

function TComboBoxItemEditorObject.GetControlItemIndex: Integer;
begin
  Result := FComboBox.ItemIndex;
end;

function TComboBoxItemEditorObject.GetControlItems: TStrings;
begin
  Result := FComboBox.Items;
end;

function TComboBoxItemEditorObject.GetOwner: TCustomComboBox;
begin
  Result := FComboBox;
end;

function TComboBoxItemEditorObject.GetText: string;
begin
  Result := FComboBox.Items[FIndex];

end;

procedure TComboBoxItemEditorObject.SetControlItemIndex(AIndex: Integer);
begin
  FComboBox.ItemIndex := AIndex;
end;

procedure TComboBoxItemEditorObject.SetText(const Value: string);
var
  FSaveItemIndex: Integer;
begin
  FSaveItemIndex := FComboBox.ItemIndex;
  FComboBox.Items[FIndex] := Value;
  FComboBox.ItemIndex := FSaveItemIndex;
end;

{ TBindListLookupEditorImpl }

function TBindListLookupEditorImpl.GetLookupValue(const AScope: IScope): TValue;
var
  LPlaceHolder: IPlaceHolder;
  LKey: TLookupKey;
begin
  if Supports(AScope, IPlaceholder, LPlaceHolder) then
    LKey := GetLookupKey(LPlaceHolder.Attachment)
  else
  begin
    Assert(False);
    LKey := 0;
  end;
  if LKey <> 0 then
    FLookupDictionary.TryGetValue(LKey, Result);
end;

procedure TBindListLookupEditorImpl.ListCleared;
begin
  if Assigned(FLookupDictionary) then
    FLookupDictionary.Clear;
end;

function TBindListLookupEditorImpl.NextKey: Integer;
begin
  FCurrentKey := FCurrentKey + 1;
  Result := FCurrentKey;
  Assert(Result <> 0); // Invalid key
end;

function TBindListLookupEditorImpl.GetSelectedLookupValue: TValue;
var
  LItem: TLookupKey;
begin
  LItem := GetSelected; // FListBox.Selected;
  if (LItem <> 0) and (FLookupDictionary <> nil) then
  begin
    if not FLookupDictionary.TryGetValue(LItem, Result) then
      Result := TValue.Empty;
  end
  else
    Result := TValue.Empty;
end;

procedure TBindListLookupEditorImpl.ItemRemoved(AListItem: TLookupKey);
begin
  if Assigned(FLookupDictionary) then
    if FLookupDictionary.ContainsKey(AListItem) then
      FLookupDictionary.Remove(AListItem);
end;

destructor TBindListLookupEditorImpl.Destroy;
begin
  FLookupDictionary.Free;
  inherited;
end;

procedure TBindListLookupEditorImpl.SetLookupValue(const AScope: IScope;
  const AValue: TValue);
var
  LPlaceHolder: IPlaceHolder;
  LKey: TLookupKey;
begin
  if Supports(AScope, IPlaceholder, LPlaceHolder) then
    LKey := GetLookupKey(LPlaceHolder.Attachment)
  else
  begin
    LKey := 0;
    Assert(False);
  end;
  if LKey <> 0 then
  begin
    if FLookupDictionary = nil then
      FLookupDictionary := TDictionary<TLookupKey,TValue>.Create;
    FLookupDictionary.AddOrSetValue(LKey, AValue);
  end;
end;

function TBindListLookupEditorImpl.SameValue(const AValue1, AValue2: TValue): Boolean;
begin
  Assert(not AValue1.IsArray);  // not supported
  Assert(not AValue2.IsArray);  // not supported
  if (AValue1.IsEmpty) or (AValue2.IsEmpty) then
    Result := AValue2.IsEmpty
  else if (AValue1.IsObject) or (AValue2.IsObject) then
    Result := AValue2.IsObject and (AValue1.AsObject = AValue2.AsObject)
  else
    Result := AValue1.ToString = AValue2.ToString;
end;

function TBindListLookupEditorImpl.FindLookupValue(const AValue: TValue): TLookupKey;
var
  I: Integer;
  LItem: TLookupKey;
  LValue: TValue;
begin
  Result := 0;
  if FLookupDictionary <> nil then
    for I := 0 to ListCount - 1 do //FListBox.Count - 1 do
    begin
      LItem := GetListItem(I); // FListBox.ListItems[I];
      if FLookupDictionary.TryGetValue(LItem, LValue) then
        if SameValue(LValue, AValue) then
          Exit(LItem);
    end;
end;

procedure TBindListLookupEditorImpl.SetSelectedLookupValue(const AValue: TValue);
var
  LItem: TLookupKey;
begin
  LItem := FindLookupValue(AValue);
  SetSelected(LItem);
end;

{ TBindListBoxItemsBoxEditor }

function TBaseBindListListBoxEditor.AddItem(Select: Boolean): IScope;
begin
  FEditorObject.FIndex := FEditorObject.ControlItems.AddObject('', TObject(NextKey));
  if Select then
    FEditorObject.ControlItemIndex := FEditorObject.FIndex;
  Result := WrapObject(FEditorObject);
end;

function TBaseBindListListBoxEditor.InsertItem(Select: Boolean): IScope;
begin
  if not CanInsertItem then
    Result := nil
  else
  begin
    FEditorObject.FIndex := FEditorObject.ControlItemIndex;
    FEditorObject.ControlItems.InsertObject(FEditorObject.FIndex, '', TObject(NextKey));
    if Select then
      FEditorObject.ControlItemIndex := FEditorObject.FIndex;
    Result := WrapObject(FEditorObject);
  end;
end;

function TBaseBindListListBoxEditor.CanInsertItem: Boolean;
begin
  Result := FEditorObject.ControlItemIndex <> -1;
end;

function TBaseBindListListBoxEditor.CurrentItem: IScope;
begin
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex := FEditorObject.ControlItemIndex;
  Result := WrapObject(FEditorObject);
end;

function TBaseBindListListBoxEditor.CurrentIndex: Integer;
begin
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex := FEditorObject.ControlItemIndex;
  Result := FEditorObject.FIndex;
end;

procedure TBaseBindListListBoxEditor.BeginUpdate;
begin
  Inc(FUpdateCounter);
  if FUpdateCounter = 1 then
    FEditorObject.FIndex := -1;

  FEditorObject.ControlItems.BeginUpdate;

end;

procedure TBaseBindListListBoxEditor.ClearList;
begin
  FEditorObject.ControlClear;
  FEditorObject.FIndex := -1;

end;

constructor TBaseBindListListBoxEditor.Create(AControl: TControl);
begin
  FEditorObject := CreateItemsEditor(AControl);
  FEditorObject.FIndex := -1;
end;

procedure TBaseBindListListBoxEditor.DeleteToEnd;
begin
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex := FEditorObject.ControlItemIndex;
  while FEditorObject.ControlItems.Count > Max(0, FEditorObject.FIndex) do
  begin
    ItemRemoved(Integer(FEditorObject.ControlItems.Objects[FEditorObject.ControlItems.Count-1]));
    FEditorObject.ControlItems.Delete(FEditorObject.ControlItems.Count-1);
  end;
  FEditorObject.FIndex := FEditorObject.ControlItems.Count - 1;
end;

destructor TBaseBindListListBoxEditor.Destroy;
begin
  FEditorObject.Free;
  inherited;
end;

procedure TBaseBindListListBoxEditor.EndUpdate;
begin
  FEditorObject.ControlItems.EndUpdate;
  Dec(FUpdateCounter);
  Assert(FUpdateCounter >= 0);
  if FUpdateCounter = 0 then
    FEditorObject.FIndex := -1;

end;

function TBaseBindListListBoxEditor.GetLookupKey(
  AListItemObject: TObject): TLookupKey;
begin
  if AListItemObject is TBaseListBoxItemEditorObject then
    Result := TBaseListBoxItemEditorObject(AListItemObject).GetLookupKey
  else
  begin
    Assert(False);
    Result := 0;
  end;
end;

function TBaseBindListListBoxEditor.GetRowCount: Integer;
begin
  Result := FEditorObject.ControlItems.Count;
end;

function TBaseBindListListBoxEditor.GetSelectedText: string;
begin
  Result := '';
  if FEditorObject.ControlItemIndex <> -1 then
    Result :=  FEditorObject.ControlItems[FEditorObject.ControlItemIndex];
end;

function TBaseBindListListBoxEditor.MoveNext: Boolean;
begin
  Assert(FUpdateCounter > 0);
  if FEditorObject.FIndex = -1 then
  begin
    FEditorObject.FIndex := FEditorObject.ControlItemIndex;
    if FEditorObject.FIndex < 0 then
      FEditorObject.FIndex := 0;
  end
  else
    FEditorObject.FIndex := FEditorObject.FIndex + 1;
  Result := (FEditorObject.FIndex >= 0) and (FEditorObject.FIndex < FEditorObject.ControlItems.Count);

end;

procedure TBaseBindListListBoxEditor.SetSelectedText(const AValue: string);
var
  I: Integer;
begin
  I := FEditorObject.ControlItems.IndexOf(AValue);
  FEditorObject.ControlItemIndex := I;
end;


{ TBindListListBoxEditor }


constructor TBindListListBoxEditor.Create(AListBox: TCustomListBox);
begin
  FListBox := AListBox;
  inherited Create(AListBox);
  GEditors.Add(FListBox, Self);
end;

function TBindListListBoxEditor.GetSelected: TLookupKey;
begin
  if FListBox.ItemIndex <> -1 then
    Result := Integer(FListBox.Items.Objects[FListBox.ItemIndex])
  else
    Result := 0;
end;

function TBindListListBoxEditor.ListCount: Integer;
begin
  Result := FListBox.Count;
end;

function TBindListListBoxEditor.GetListItem(I: Integer): TLookupKey;
begin
  if I < FListBox.Items.Count then
    Result := Integer(FListBox.Items.Objects[I])
  else
    Result := 0;
end;

procedure TBindListListBoxEditor.SetSelected(ALookupKey: TLookupKey);
var
  I: Integer;
begin
  if ALookupKey = 0 then
    FListBox.ItemIndex := -1
  else
  begin
    for I := 0 to FListBox.Items.Count do
      if Integer(FListBox.Items.Objects[I]) = ALookupKey then
      begin
        FListBox.ItemIndex := I;
        Exit;
      end;
    FListBox.ItemIndex := -1;
  end;
end;

{ TListViewItemEditorObject }

function TListViewItemEditorObject.CurrentItem: TListItem;
begin
  Assert(CheckRange);
  if CheckRange then
    Result := FListView.Items[FItemIndex]
  else
    Result := nil;
end;

function TListViewItemEditorObject.CheckRange: Boolean;
begin
  Result := (FItemIndex >= 0) and (FItemIndex < FListView.Items.Count);
end;

function TListViewItemEditorObject.GetCaption: string;
begin
  if CheckRange then
    Result := CurrentItem.Caption 
  else
    Result := ''

end;

function TListViewItemEditorObject.GetChecked: Boolean;
begin
  if CheckRange then
    Result := CurrentItem.Checked
  else
    Result := False
end;

function TListViewItemEditorObject.GetData: TCustomData;
begin
  if CheckRange then
    Result := CurrentItem.Data
  else
    Result := nil;
end;

function TListViewItemEditorObject.GetFocused: Boolean;
begin
  if CheckRange then
    Result := CurrentItem.Focused
  else
    Result := False;
end;

function TListViewItemEditorObject.GetGroupID: Integer;
begin
  if CheckRange then
    Result := CurrentItem.GroupID
  else
    Result := 0;
end;

function TListViewItemEditorObject.GetImageIndex: TImageIndex;
begin
  if CheckRange then
    Result := CurrentItem.ImageIndex 
  else
    Result := 0;
end;

function TListViewItemEditorObject.GetIndent: Integer;
begin
  if CheckRange then
    Result := CurrentItem.Indent
  else
    Result := 0;
end;

function TListViewItemEditorObject.GetLeft: Integer;
begin
  if CheckRange then
    Result := CurrentItem.Left
  else
    Result := 0;
end;

function TListViewItemEditorObject.GetOverlayIndex: TImageIndex;
begin
  if CheckRange then
    Result := CurrentItem.OverlayIndex
  else
    Result := 0;
end;

function TListViewItemEditorObject.GetOwner: TCustomListView;
begin
  Result := FListView;
end;

procedure TListViewItemEditorObject.SetCaption(const Value: string);
begin
  if CheckRange then
    CurrentItem.Caption := Value;
end;

procedure TListViewItemEditorObject.SetChecked(const Value: Boolean);
begin
  if CheckRange then
    CurrentItem.Checked := Value;
end;

procedure TListViewItemEditorObject.SetData(const Value: TCustomData);
begin
  if CheckRange then
    CurrentItem.Data := Value;
end;

procedure TListViewItemEditorObject.SetFocused(const Value: Boolean);
begin
  if CheckRange then
    CurrentItem.Focused := Value;
end;

procedure TListViewItemEditorObject.SetGroupID(const Value: Integer);
begin
  if CheckRange then
    CurrentItem.GroupID := Value;
end;

procedure TListViewItemEditorObject.SetImageIndex(const Value: TImageIndex);
begin
  if CheckRange then
    CurrentItem.ImageIndex := Value;
end;

procedure TListViewItemEditorObject.SetIndent(const Value: Integer);
begin
  if CheckRange then
    CurrentItem.Indent := Value;
end;

procedure TListViewItemEditorObject.SetLeft(const Value: Integer);
begin
  if CheckRange then
    CurrentItem.Left := Value;
end;

procedure TListViewItemEditorObject.SetOverlayIndex(const Value: TImageIndex);
begin
  if CheckRange then
    CurrentItem.OverlayIndex := Value;
end;

procedure TListViewItemEditorObject.SetSelected(const Value: Boolean);
begin
  if CheckRange then
    CurrentItem.Selected := Value;
end;

procedure TListViewItemEditorObject.SetStateIndex(const Value: TImageIndex);
begin
  if CheckRange then
    CurrentItem.StateIndex := Value;
end;

procedure TListViewItemEditorObject.SetSubItemImage(Index: Integer;
  const Value: Integer);
begin
  if CheckRange then
    CurrentItem.SubItemImages[Index] := Value;
end;

procedure TListViewItemEditorObject.SetSubItems(const Value: TStrings);
begin
  if CheckRange then
    CurrentItem.SubItems := Value;
end;

procedure TListViewItemEditorObject.SetText(const Value: string);
begin
  Caption := Value;
end;

function TListViewItemEditorObject.GetSelected: Boolean;
begin
  if CheckRange then
    Result := CurrentItem.Selected
  else
    Result := False;
end;

function TListViewItemEditorObject.GetStateIndex: TImageIndex;
begin
  if CheckRange then
    Result := CurrentItem.StateIndex
  else
    Result := 0;
end;

function TListViewItemEditorObject.GetSubItemImage(Index: Integer): Integer;
begin
  if CheckRange then
    Result := CurrentItem.SubItemImages[Index]
  else
    Result := 0;
end;

function TListViewItemEditorObject.GetSubItems: TStrings;
begin
  if CheckRange then
    Result := CurrentItem.SubItems
  else
    Result := nil;
end;

procedure TListViewItemEditorObject.SetTop(const Value: Integer);
begin
  if CheckRange then
    CurrentItem.Top := Value;
end;

function TListViewItemEditorObject.GetText: string;
begin
  Result := Caption;
end;


function TListViewItemEditorObject.GetTop: Integer;
begin
  if CheckRange then
    Result := CurrentItem.Top
  else
    Result := 0;
end;

{ TBindListStringGridEditor }

function TBindListStringGridEditor.AddItem(Select: Boolean): IScope;
begin
  if IsEmpty then
  begin
    // Assume first row is empty and use it
  end
  else
    FEditorObject.FStringGrid.RowCount := FEditorObject.FStringGrid.RowCount + 1;
  FIsEmpty := False;
  if FEditorObject.FStringGrid.RowCount < 2 then
    FEditorObject.FStringGrid.RowCount := 2;
  FEditorObject.FIndex := FEditorObject.FStringGrid.RowCount - 1;
  if Select then
    FEditorObject.FStringGrid.Row := FEditorObject.FIndex;
  Result := WrapObject(FEditorObject);
end;

function TBindListStringGridEditor.InsertItem(Select: Boolean): IScope;
begin
  // Not supported
  Exit(nil);
end;

function TBindListStringGridEditor.CanInsertItem: Boolean;
begin
  // Not supported
  Result := False;
end;

function TBindListStringGridEditor.CurrentItem: IScope;
begin
  if FEditorObject.FIndex = -1 then
  begin
    FEditorObject.FIndex := Max(1, FEditorObject.FStringGrid.Row);
  end;
  Result := WrapObject(FEditorObject);
end;

procedure TBindListStringGridEditor.BeginUpdate;
begin
  Inc(FUpdateCounter);
  if FUpdateCounter = 1 then
    FEditorObject.FIndex := -1;
end;

procedure TBindListStringGridEditor.ClearList;
var
  I: Integer;
begin
  FEditorObject.FIndex := -1;
  for I := 1 to FEditorObject.FStringGrid.RowCount - 1 do
    FEditorObject.FStringGrid.Rows[I].Clear;
  FEditorObject.FStringGrid.RowCount := FEditorObject.FStringGrid.FixedRows + 1;
  FIsEmpty := True;
end;

constructor TBindListStringGridEditor.Create(AGrid: TStringGrid);
begin
  FEditorObject := TStringGridItemEditorObject.Create;
  FEditorObject.FStringGrid := AGrid;
  FEditorObject.FIndex := -1;
end;

procedure TBindListStringGridEditor.DeleteToEnd;
var
  I: integer;
begin
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex := FEditorObject.FStringGrid.Row;
//  if FEditorObject.FIndex = FEditorObject.FStringGrid.FixedRows then
//    ClearList
//  else
  for I := FEditorObject.FIndex to FEditorObject.FStringGrid.RowCount - 1 do
    FEditorObject.FStringGrid.Rows[I].Clear;
  if FEditorObject.FIndex > FEditorObject.FStringGrid.FixedRows then
    FEditorObject.FStringGrid.RowCount := FEditorObject.FIndex;
end;

destructor TBindListStringGridEditor.Destroy;
begin
  FEditorObject.Free;
  inherited;
end;

procedure TBindListStringGridEditor.EndUpdate;
begin
  //FEditorObject.FListBox.Items.EndUpdate;
  Dec(FUpdateCounter);
  Assert(FUpdateCounter >= 0);
  if FUpdateCounter = 0 then
    FEditorObject.FIndex := -1;
end;

function TBindListStringGridEditor.IsEmpty: Boolean;
begin
  if FIsEmpty then
    Exit(True);
  // The following test is in case the editor is instantiated after the list has been filled
  if FEditorObject.FStringGrid.FixedRows > 0 then
    Result := (FEditorObject.FStringGrid.RowCount = FEditorObject.FStringGrid.FixedRows + 1)
      and (Trim(FEditorObject.FStringGrid.Rows[FEditorObject.FStringGrid.FixedRows].Text) = '')
  else
    if FEditorObject.FStringGrid.RowCount = 1 then
      Result := True
    else
    begin
      Result := (FEditorObject.FStringGrid.RowCount = 2)
        and (Trim(FEditorObject.FStringGrid.Rows[1].Text) = '')
    end;
end;

function TBindListStringGridEditor.GetRowCount: Integer;
begin
  if IsEmpty then
    Result := 0
  else
    Result := FEditorObject.FStringGrid.RowCount - FEditorObject.FStringGrid.FixedRows;
end;

function TBindListStringGridEditor.GetSelectedText: string;
begin
  Result := '';
  if FEditorObject.FStringGrid.Row >= FEditorObject.FStringGrid.FixedRows then
    if FEditorObject.FStringGrid.Col >= FEditorObject.FStringGrid.FixedCols then
      Result := FEditorObject.FStringGrid.Cells[FEditorObject.FStringGrid.Col, FEditorObject.FStringGrid.Row];
end;

function TBindListStringGridEditor.MoveNext: Boolean;
begin
  Assert(FUpdateCounter > 0);
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex :=  FEditorObject.FStringGrid.Row
  else
    FEditorObject.FIndex :=  FEditorObject.FIndex + 1;
  Result := FEditorObject.FIndex < FEditorObject.FStringGrid.RowCount;
end;

procedure TBindListStringGridEditor.SetSelectedText(const AValue: string);
begin
  if FEditorObject.FStringGrid.Row >= FEditorObject.FStringGrid.FixedRows then
    if FEditorObject.FStringGrid.Col >= FEditorObject.FStringGrid.FixedCols then
      FEditorObject.FStringGrid.Cells[FEditorObject.FStringGrid.Col, FEditorObject.FStringGrid.Row] := AValue;
end;

procedure TBindListStringGridEditor.GetColumnIndices(ANames: TStrings);
var
  I: Integer;
begin
  for I := 0 to FEditorObject.FStringGrid.ColCount - 1 do
    ANames.Add(IntToStr(I));
end;

procedure TBindListStringGridEditor.GetColumnNames(ANames: TStrings);
begin
  // no Names
end;

const
  sRow = 'Row';

function TBindListStringGridEditor.GetPositionGetter(
  var AGetter: string; var ABase: Integer): Boolean;
begin
  AGetter := sRow;
  ABase := 1;
  Exit(True);
end;

function TBindListStringGridEditor.GetPositionSetter(
  var ASetter: string; var ABase: Integer): Boolean;
begin
  ASetter := sRow;
  ABase := 1;
  Exit(True);
end;

{ TStringGridItemEditorObject }

function TStringGridItemEditorObject.GetOwner: TStringGrid;
begin
  Result := FStringGrid;
end;

function TStringGridItemEditorObject.GetCells(ACol: Integer): string;
begin
  Result := Self.FStringGrid.Cells[ACol, FIndex];
end;

procedure TStringGridItemEditorObject.SetCells(ACol: Integer;
  const Value: string);
begin
  Self.FStringGrid.Cells[ACol, FIndex] := Value;
end;

{ TBindListBoxEditorFactory }

constructor TBindListBoxEditorFactory.Create;
begin
  inherited;

end;

function TBindListBoxEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
var
  LEditor: IInterface;
begin
  if AObject is TComponent then
    if not GEditors.TryGetValue(TComponent(AObject), LEditor) then
      Result := TBindListListBoxEditor.Create(TCustomListBox(AObject))
    else
    begin
      Assert(LEditor is TBindListListBoxEditor);
      Result := LEditor as TBindListListBoxEditor;
    end;
end;

function TBindListBoxEditorFactory.Supports(AIntf: TGuid; AObject:
  TObject): Boolean;
begin
  Result := False;
  if  (AIntf = IBindListEditorCommon) or (AIntf = IBindListEditor) then
    if (AObject <> nil) and (AObject.InheritsFrom(TListBox)) then
      Result := True;
end;

{ TBindComboBoxEditorFactory }

constructor TBindComboBoxEditorFactory.Create;
begin
  inherited;

end;

function TBindComboBoxEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
var
  LEditor: IInterface;
begin
  if AObject is TComponent then
    if not GEditors.TryGetValue(TComponent(AObject), LEditor) then
      Result := TBindListComboBoxEditor.Create(TCustomComboBox(AObject))
    else
    begin
      Assert(LEditor is TBindListComboBoxEditor);
      Result := LEditor as TBindListComboBoxEditor;
    end;
end;

function TBindComboBoxEditorFactory.Supports(AIntf: TGuid; AObject:
  TObject): Boolean;
begin
  Result := False;
  if  (AIntf = IBindListEditorCommon) or (AIntf = IBindListEditor) then
    // Do not use TCustomComboBox because some are not fillable
    if (AObject <> nil) and (AObject.InheritsFrom(TComboBox)) then
      Result := True;
end;


{ TBindListListViewEditor }

type
  TCustomListViewHack = class(TCustomListView);

function TBindListListViewEditor.AddItem(Select: Boolean): IScope;
var
  I: Integer;
  LListItem: TListItem;
begin
  LListItem := FEditorObject.FListView.Items.Add;
  with TCustomListViewHack(FEditorObject.FListView) do
  begin
    if Groups.Count > 0 then
      LListItem.GroupID := Groups.Items[Groups.Count-1].GroupID;
  end;

  LListItem.Data := Pointer(NextKey);
  for I := 0 to TCustomListViewHack(FEditorObject.FListView).Columns.Count - 1 do
    LListItem.SubItems.Add('');

  FEditorObject.FItemIndex := LListItem.Index;
  if Select then
  begin
    FEditorObject.FListView.ItemIndex := FEditorObject.FItemIndex;
    LListItem.MakeVisible(False);
  end;
  Result := WrapObject(FEditorObject);
end;

function TBindListListViewEditor.AddHeader: IScope;
var
  LListGroup: TListGroup;
begin
  LListGroup := TCustomListViewHack(FEditorObject.FListView).Groups.Add;
  Result := WrapObject(LListGroup);
end;


function TBindListListViewEditor.CanInsertItem: Boolean;
begin
  Result := FEditorObject.FListView.ItemIndex <> -1;
end;

function TBindListListViewEditor.InsertItem(Select: Boolean): IScope;
var
  I: Integer;
  AListItem: TListItem;
begin
  if FEditorObject.FListView.ItemIndex = -1 then
    Exit(nil);

  AListItem := FEditorObject.FListView.Items.Insert(FEditorObject.FListView.ItemIndex);
  AListItem.Data := Pointer(NextKey);
  for I := 0 to TCustomListViewHack(FEditorObject.FListView).Columns.Count - 1 do
    AListItem.SubItems.Add('');

  FEditorObject.FItemIndex := AListItem.Index;
  if Select then
  begin
    FEditorObject.FListView.ItemIndex := FEditorObject.FItemIndex;
    AListItem.MakeVisible(False);
  end;

  Result := WrapObject(FEditorObject);
end;

function TBindListListViewEditor.CurrentItem: IScope;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FListView.ItemIndex;
   Result := WrapObject(FEditorObject);
end;

function TBindListListViewEditor.CurrentIndex: Integer;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FListView.ItemIndex;
   Result := FEditorObject.FItemIndex;
end;

function TBindListListViewEditor.CurrentObject: TObject;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FListView.ItemIndex;
   Result := FEditorObject.CurrentItem;
end;

function TBindListListViewEditor.CurrentHeaderItem: IScope;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FListView.ItemIndex;
   Result := WrapObject(FGroupEditorObject);
end;

procedure TBindListListViewEditor.BeginUpdate;
begin
  Inc(FUpdateCounter);
  if FUpdateCounter = 1 then
    FEditorObject.FItemIndex := -1;
  FEditorObject.FListView.Items.BeginUpdate;

end;

procedure TBindListListViewEditor.ClearList;
begin
  FEditorObject.FListView.Clear;
  TCustomListViewHack(FEditorObject.FListView).Groups.Clear;
  FEditorObject.FItemIndex := -1;

end;

constructor TBindListListViewEditor.Create(AListView: TCustomListView);
begin
  FEditorObject := TListViewItemEditorObject.Create;
  FEditorObject.FListView := AListView;
  FEditorObject.FItemIndex := -1;
  FGroupEditorObject := TListViewGroupEditorObject.Create(FEditorObject);
  GEditors.Add(AListView, Self);
end;

procedure TBindListListViewEditor.DeleteToEnd;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FListView.ItemIndex;
  while FEditorObject.FListView.Items.Count > Max(0, FEditorObject.FItemIndex) do
  begin
    ItemRemoved(Integer(FEditorObject.FListView.Items[FEditorObject.FListView.Items.Count-1].Data));
    FEditorObject.FListView.Items.Delete(FEditorObject.FListView.Items.Count-1);
  end;
  FEditorObject.FItemIndex := FEditorObject.FListView.Items.Count - 1;
end;

destructor TBindListListViewEditor.Destroy;
begin
  GEditors.Remove(FEditorObject.FListView);
  FGroupEditorObject.Free;
  FEditorObject.Free;
  inherited;
end;

procedure TBindListListViewEditor.EndUpdate;
begin
  Dec(FUpdateCounter);
  Assert(FUpdateCounter >= 0);
  if FUpdateCounter = 0 then
    FEditorObject.FItemIndex := -1;
  FEditorObject.FListView.Items.EndUpdate;

end;

function TBindListListViewEditor.GetRowCount: Integer;
begin
  Result := FEditorObject.FListView.Items.Count;
end;

function TBindListListViewEditor.GetSelectedText: string;
begin
  if FEditorObject.FListView.ItemIndex <> -1 then
    Result := FEditorObject.FListView.Items[FEditorObject.FListView.ItemIndex].Caption;
end;

function TBindListListViewEditor.MoveNext: Boolean;
begin
  Assert(FUpdateCounter > 0);
  if FEditorObject.FItemIndex = -1 then
  begin
    FEditorObject.FItemIndex := FEditorObject.FListView.ItemIndex;
    if FEditorObject.FItemIndex < 0 then
      FEditorObject.FItemIndex := 0;
  end
  else
    FEditorObject.FItemIndex := FEditorObject.FItemIndex + 1;
  Result := (FEditorObject.FItemIndex >= 0) and (FEditorObject.FItemIndex < FEditorObject.FListView.Items.Count);
end;

procedure TBindListListViewEditor.SetSelectedText(const AValue: string);
var
  LItem: TListItem;
begin
  LItem := FEditorObject.FListView.FindCaption(0, AValue, False, True, False);
  if LItem <> nil then
  begin
   FEditorObject.FListView.ItemIndex := LItem.Index;
   LItem.MakeVisible(False);
  end
  else
    FEditorObject.FListView.ItemIndex := -1;
end;

procedure TBindListListViewEditor.SetSelected(
  ALookupKey: TLookupKey);
var
  I: Integer;
begin
  if ALookupKey = 0 then
    FEditorObject.FListView.ItemIndex := -1
  else
  begin
    for I := 0 to FEditorObject.FListView.Items.Count do
      if Integer(FEditorObject.FListView.Items[I].Data) = ALookupKey then
      begin
        FEditorObject.FListView.ItemIndex := I;
        FEditorObject.FListView.Items[I].MakeVisible(False);
        Exit;
      end;
    FEditorObject.FListView.ItemIndex := -1;
  end;
end;

function TBindListListViewEditor.GetSelected: TLookupKey;
begin
  if FEditorObject.FListView.ItemIndex <> -1 then
    Result := Integer(FEditorObject.FListView.Items[ FEditorObject.FListView.ItemIndex].Data)
  else
    Result := 0;
end;

function TBindListListViewEditor.GetListItem(
  I: Integer): TLookupKey;
begin
  if I < FEditorObject.FListView.Items.Count then
    Result := Integer(FEditorObject.FListView.Items[I].Data)
  else
    Result := 0;
end;

function TBindListListViewEditor.GetLookupKey(
  AListItemObject: TObject): TLookupKey;
begin
  if AListItemObject is TListViewItemEditorObject then
    Result := Integer(TListViewItemEditorObject(AListItemObject).Data)
  else
  begin
    Assert(False);
    Result := 0;
  end;
end;

const
  sCaption = 'Caption';
  sFormatSubItemName = 'SubItems[%d]';
  sFormatSubItemExpression = 'SubItems.Strings[%d]';  // Default properties not supported by expression engine
  sHeader = 'Header';
  sSubtitle = 'Subtitle';
  sFooter = 'Footer';
type
  TListViewCracker = class(TCustomListView)

  end;
function TBindListListViewEditor.GetItemMemberNameExpression(
  const AName: string): string;
var
  I: Integer;
begin
  for I := 0 to TListViewCracker(FEditorObject.FListView).Columns.Count - 2 do
    if SameText(AName, Format(sFormatSubItemName, [I])) then
      Exit(Format(sFormatSubItemExpression, [I]));
  Result := AName;
end;

procedure TBindListListViewEditor.GetItemMemberNames(ANames: TStrings);
var
  I: Integer;
begin
  ANames.Add(sCaption);
  for I := 0 to TListViewCracker(FEditorObject.FListView).Columns.Count - 2 do
    ANames.Add(Format(sFormatSubItemName, [I]))
end;

function TBindListListViewEditor.GetHeaderMemberNameExpression(
  const AName: string): string;
begin
  Result := AName;
end;

procedure TBindListListViewEditor.GetHeaderMemberNames(ANames: TStrings);
begin
  ANames.Clear;
  ANames.Add(sHeader);
  ANames.Add(sSubtitle);
  ANames.Add(sFooter);
end;

function TBindListListViewEditor.ListCount: Integer;
begin
  Result := FEditorObject.FListView.Items.Count;
end;

{ TBindListViewEditorFactory }

constructor TBindListViewEditorFactory.Create;
begin
  inherited;

end;

function TBindListViewEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
var
  LEditor: IInterface;
begin
  if AObject is TComponent then
    if not GEditors.TryGetValue(TComponent(AObject), LEditor) then
      Result := TBindListListViewEditor.Create(TCustomListView(AObject))
    else
    begin
      Assert(LEditor is TBindListListViewEditor);
      Result := LEditor as TBindListListViewEditor;
    end;
end;

function TBindListViewEditorFactory.Supports(AIntf: TGuid; AObject:
  TObject): Boolean;
begin
  Result := False;
  if  (AIntf = IBindListEditorCommon) or (AIntf = IBindListEditor) then
    if (AObject <> nil) and AObject.InheritsFrom(TCustomListView) then
      Result := True;
end;

{ TBindStringGridEditorFactory }

constructor TBindStringGridEditorFactory.Create;
begin
  inherited;

end;

function TBindStringGridEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
begin
  Result := TBindListStringGridEditor.Create(TStringGrid(AObject));
end;

function TBindStringGridEditorFactory.Supports(AIntf: TGuid; AObject:
  TObject): Boolean;
begin
  Result := False;
  if  (AIntf = IBindListEditorCommon) or (AIntf = IBindListEditor) then
    if (AObject <> nil) and AObject.InheritsFrom(TStringGrid) then
      Result := True;
end;

{ TBindCheckBoxEditorFactory }

constructor TBindCheckBoxEditorFactory.Create;
begin
  inherited;
end;

function TBindCheckBoxEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
begin
  Result := TBindStateCheckBoxEditor.Create(TCheckBox(AObject));
end;

function TBindCheckBoxEditorFactory.Supports(AIntf: TGuid;
  AObject: TObject): Boolean;
begin
  Result := False;
  if AIntf = IBindCheckBoxEditor then
    if (AObject <> nil) and AObject.InheritsFrom(TCheckBox) then
      Result := True;
end;

{ TBindStateCheckBoxEditor }

constructor TBindStateCheckBoxEditor.Create(ACheckBox: TCheckBox);
begin
  FCheckBox := ACheckBox;
end;

function TBindStateCheckBoxEditor.GetAllowGrayed: Boolean;
begin
  Result := FCheckBox.AllowGrayed;
end;

function TBindStateCheckBoxEditor.GetState: TBindCheckBoxState;
begin
  if GetAllowGrayed and (FCheckBox.State = TCheckBoxState.cbGrayed) then
    Result := TBindCheckBoxState.cbGrayed
  else
  begin
    if FCheckBox.Checked then
      Result := TBindCheckBoxState.cbChecked
    else
      Result := TBindCheckBoxState.cbUnchecked;
  end;
end;

procedure TBindStateCheckBoxEditor.SetAllowGrayed(Value: Boolean);
begin
  FCheckBox.AllowGrayed := Value;
end;

procedure TBindStateCheckBoxEditor.SetState(Value: TBindCheckBoxState);
begin
  if (Value = TBindCheckBoxState.cbGrayed) and GetAllowGrayed then
    FCheckBox.State := TCheckBoxState.cbGrayed
  else
    FCheckBox.Checked := Value = TBindCheckBoxState.cbChecked;
end;

function TBindListListBoxEditor.CreateItemsEditor(
  AControl: TControl): TBaseListBoxItemEditorObject;
begin
  Result := TListBoxItemEditorObject.Create(AControl as TCustomListBox);
end;

destructor TBindListListBoxEditor.Destroy;
begin
  GEditors.Remove(FListBox);
  inherited;
end;

{ TBindListComboBoxEditor }

constructor TBindListComboBoxEditor.Create(ACombobox: TCustomComboBox);
begin
  FListBox := AComboBox;
  inherited Create(ACombobox);
  GEditors.Add(FListBox, Self);
end;

function TBindListComboBoxEditor.CreateItemsEditor(
  AControl: TControl): TBaseListBoxItemEditorObject;
begin
  Result := TComboBoxItemEditorObject.Create(AControl as TCustomComboBox);
end;

destructor TBindListComboBoxEditor.Destroy;
begin
  GEditors.Remove(FListBox);
  inherited;
end;

function TBindListComboBoxEditor.GetSelected: TLookupKey;
begin
  if FListBox.ItemIndex <> -1 then
    Result := Integer(FListBox.Items.Objects[FListBox.ItemIndex])
  else
    Result := 0;
end;

function TBindListComboBoxEditor.ListCount: Integer;
begin
  Result := FListBox.Items.Count;
end;

function TBindListComboBoxEditor.GetListItem(I: Integer): TLookupKey;
begin
  if I < FListBox.Items.Count then
    Result := Integer(FListBox.Items.Objects[I])
  else
    Result := 0;
end;

procedure TBindListComboBoxEditor.SetSelected(ALookupKey: TLookupKey);
var
  I: Integer;
begin
  if ALookupKey = 0 then
    FListBox.ItemIndex := -1
  else
  begin
    for I := 0 to FListBox.Items.Count do
      if FListBox.Items.Objects[I] = TObject(ALookupKey) then
      begin
        FListBox.ItemIndex := I;
        Exit;
      end;
    FListBox.ItemIndex := -1;
  end;
end;

const
  sDfm = 'DFM';

{ TBaseListBoxItemEditorObject }

function TBaseListBoxItemEditorObject.GetLookupKey: TLookupKey;
begin
  if FIndex < GetControlItems.Count then
    Result := Integer(GetControlItems.Objects[FIndex])
  else
    Result := 0;
end;

{ TListViewGroupEditorObject }

constructor TListViewGroupEditorObject.Create(
  AEditorObject: TListViewItemEditorObject);
begin
  FEditorObject := AEditorObject;
end;

function TListViewGroupEditorObject.CheckGroup(out AGroup: TListGroup): Boolean;
var
  LGroups: TListGroups;
begin
  LGroups := TCustomListViewHack(FEditorObject.FListView).Groups;
  if LGroups.Count > 0 then
    AGroup := LGroups.Items[LGroups.Count - 1]; // last item
  Result := AGroup <> nil;
end;

function TListViewGroupEditorObject.GetFooter: string;
var
  LListGroup: TListGroup;
begin
  if CheckGroup(LListGroup) then
    Result := LListGroup.Footer;
end;

function TListViewGroupEditorObject.GetFooterAlign: TAlignment;
var
  LListGroup: TListGroup;
begin
  Result := taLeftJustify;
  if CheckGroup(LListGroup) then
    Result := LListGroup.FooterAlign;
end;

function TListViewGroupEditorObject.GetGroupID: Integer;
var
  LListGroup: TListGroup;
begin
  Result := -1;
  if CheckGroup(LListGroup) then
    Result := LListGroup.GroupID;
end;

function TListViewGroupEditorObject.GetGroupObject: TListGroup;
var
  LListGroup: TListGroup;
begin
  if CheckGroup(LListGroup) then
    Result := LListGroup
  else
    Result := nil;
end;

function TListViewGroupEditorObject.GetHeader: string;
var
  LListGroup: TListGroup;
begin
  if CheckGroup(LListGroup) then
    Result := LListGroup.Header;
end;

function TListViewGroupEditorObject.GetHeaderAlign: TAlignment;
var
  LListGroup: TListGroup;
begin
  Result := taLeftJustify;
  if CheckGroup(LListGroup) then
    Result := LListGroup.HeaderAlign;
end;

function TListViewGroupEditorObject.GetOwner: TCustomListView;
begin
  Result := FEditorObject.FListView;
end;

function TListViewGroupEditorObject.GetState: TListGroupStateSet;
var
  LListGroup: TListGroup;
begin
  Result := [];
  if CheckGroup(LListGroup) then
    Result := LListGroup.State;
end;

function TListViewGroupEditorObject.GetSubtitle: string;
var
  LListGroup: TListGroup;
begin
  if CheckGroup(LListGroup) then
    Result := LListGroup.Subtitle;
end;

function TListViewGroupEditorObject.GetTitleImage: TImageIndex;
var
  LListGroup: TListGroup;
begin
  Result := -1;
  if CheckGroup(LListGroup) then
    Result := LListGroup.TitleImage;
end;

procedure TListViewGroupEditorObject.SetFooter(const Value: string);
var
  LListGroup: TListGroup;
begin
  if CheckGroup(LListGroup) then
    LListGroup.Footer := Value;
end;

procedure TListViewGroupEditorObject.SetFooterAlign(const Value: TAlignment);
var
  LListGroup: TListGroup;
begin
  if CheckGroup(LListGroup) then
    LListGroup.FooterAlign := Value;
end;

procedure TListViewGroupEditorObject.SetGroupID(const Value: Integer);
var
  LListGroup: TListGroup;
begin
  if CheckGroup(LListGroup) then
    LListGroup.GroupID := Value;
end;

procedure TListViewGroupEditorObject.SetHeader(const Value: string);
var
  LListGroup: TListGroup;
begin
  if CheckGroup(LListGroup) then
    LListGroup.Header := Value;
end;

procedure TListViewGroupEditorObject.SetHeaderAlign(const Value: TAlignment);
var
  LListGroup: TListGroup;
begin
  if CheckGroup(LListGroup) then
    LListGroup.HeaderAlign := Value;
end;

procedure TListViewGroupEditorObject.SetState(const Value: TListGroupStateSet);
var
  LListGroup: TListGroup;
begin
  if CheckGroup(LListGroup) then
    LListGroup.State := Value;
end;

procedure TListViewGroupEditorObject.SetSubtitle(const Value: string);
var
  LListGroup: TListGroup;
begin
  if CheckGroup(LListGroup) then
    LListGroup.Subtitle := Value;
end;

procedure TListViewGroupEditorObject.SetTitleImage(const Value: TImageIndex);
var
  LListGroup: TListGroup;
begin
  if CheckGroup(LListGroup) then
    LListGroup.TitleImage := Value;
end;

initialization
  GEditors := TEditors.Create(nil);
  RegisterBindEditorFactory([TBindCheckBoxEditorFactory, TBindListBoxEditorFactory,
    TBindComboBoxEditorFactory, TBindListViewEditorFactory, TBindStringGridEditorFactory]);
  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(
    TEdit,
    TLabeledEdit,
    TMaskEdit,
    TButtonedEdit
    ), 'Text', sDfm);
  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(
    TCheckBox
    ), 'CheckedState(Self)', sDfm);
  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
    TListBox,
    TComboBox
    ),
    'SelectedValue(Self)', sDfm);
  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
     TColorListBox,
     TColorBox
     ),
    'Selected', sDfm);
  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
     TListView
     ),
    'SelectedValue(Self)', sDfm);
  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
    TMemo
    ),
    'Lines.Text', sDfm);
  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
    TImage
    ),
    'Picture', sDfm);

  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
    TDateTimePicker
    ),
    'DateTime', sDfm);

  Data.Bind.Components.RegisterListItemValueExpression(TArray<TClass>.Create(
    TListBox,
    TComboBox
    ),
    'Text');
  Data.Bind.Components.RegisterListItemValueExpression(TArray<TClass>.Create(
    TListView
    ),
    sCaption, sHeader);

  Data.Bind.Components.RegisterObservableMemberOptions(TArray<TClass>.Create(
    TCheckBox,
    TListBox,
    TComboBox,
    TColorListBox,
    TColorBox,
    TListView,
    TEdit,
    TLabeledEdit,
    TDateTimePicker
    ), [moTrack]);


  Data.Bind.Components.RegisterValuePropertyName(TArray<TClass>.Create(
     TCustomGroupBox,
     TCustomLabel,
     TCustomStatusBar,
     TCustomButton,
     TCustomPanel
     ),
     'Caption', sDfm);

  Data.Bind.Components.RegisterValuePropertyName(TArray<TClass>.Create(
     TProgressBar
     ),
     'Position', sDfm);



finalization
  Assert(GEditors.Count = 0);
  GEditors.Free;
  Data.Bind.Components.UnRegisterObservableMember(TArray<TClass>.Create(
    TEdit,
    TLabeledEdit,
    TMaskEdit,
    TButtonedEdit,
    TCheckBox,
    TListBox,
    TComboBox,
    TColorListBox,
    TColorBox,
    TListView,
    TMemo,
    TImage,
    TDateTimePicker
  ));

  UnregisterBindEditorFactory([TBindCheckBoxEditorFactory, TBindListBoxEditorFactory,
    TBindComboBoxEditorFactory, TBindListViewEditorFactory, TBindStringGridEditorFactory]);
  //Data.Bind.Components.UnRegisterValuePropertyName(sDfm);
  UnRegisterListItemValueExpression(TArray<TClass>.Create(
    TListBox,
    TComboBox,
    TListView
    ));
  Data.Bind.Components.UnRegisterObservableMemberOptions(TArray<TClass>.Create(
    TCheckBox,
    TListBox,
    TComboBox,
    TColorListBox,
    TColorBox,
    TListView,
    TEdit,
    TLabeledEdit,
    TDateTimePicker));
  Data.Bind.Components.UnRegisterValuePropertyName(TArray<TClass>.Create(
     TCustomGroupBox,
     TCustomLabel,
     TCustomStatusBar,
     TCustomButton,
     TCustomPanel,
     TProgressBar
  ));

end.
