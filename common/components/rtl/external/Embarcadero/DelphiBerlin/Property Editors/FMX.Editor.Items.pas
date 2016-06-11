{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Editor.Items;

interface

uses
  DesignEditors, DesignMenus, DesignIntf, Classes, Vcl.Menus, System.Generics.Collections, FMX.Types, FmxDsnConst,
  FMX.Design.Items, FMX.SearchBox;

const
  EDITOR_OPEN_DESIGNER = 0;
  EDITOR_CREATE_ITEM = 1;
  EDITOR_NEW_ITEM = 2;

type

{ TItemsEditor }

  /// <summary>
  ///   Items Editor Base Classes for controls, which haves list of items.
  ///   It allows to create list of member of different classes.
  /// </summary>
  TItemsEditor = class(TComponentEditor)
  private
    class var FListOfLastItems: TDictionary<string, Integer>;
  protected
    FAllowChild: Boolean;
    FItemsClasses: array of TItemClassDesc;
    procedure DoCreateItem(Sender: TObject); virtual;
    function GetIndexOfItemClass: Integer;
    procedure SetIndexOfItemClass(const Value: Integer);
  protected
    function CanShow: Boolean; virtual;
    property IndexOfItemClass: Integer read GetIndexOfItemClass write SetIndexOfItemClass;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
    procedure Edit; override;
  end;

{ TMenuEditor }

  TMenuEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ TListBoxEditor }

  TListBoxEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ TTreeViewEditor }

  TTreeViewEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ THeaderEditor }

  THeaderEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ TTabControlEditor }

  TTabControlEditor = class(TItemsEditor)
  private
    FEditorNextTab: Integer;
    FEditorPrevTab: Integer;
    FEditorDeleteTab: Integer;
    FVerbCount: Integer;
    function GetTabIndex: Integer;
  protected
    procedure DoCreateItem(Sender: TObject); override;
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
  end;

{ TActiveTabProperty }

  TActiveTabProperty = class (TComponentProperty)
  private
    FCurrentControl: TComponent;
    FNewValue: string;
    FNewControl: TComponent;
    procedure CheckValue(const S: string);
    procedure EnumerateItems(const VisibleOnly: Boolean; Proc: TGetStrProc);
    procedure CheckControl(const S: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  { TBrushKindProperty }

  TBrushKindProperty = class (TEnumProperty)
  public
    procedure SetValue(const Value: string); override;
  end;

{ TGridEditor }

  TGridEditor = class(TItemsEditor)
  protected
    function CanShow: Boolean; override;
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ TStringGridEditor }

  TStringGridEditor = class(TItemsEditor)
  protected
    function CanShow: Boolean; override;
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

{ TEditEditor }

  TEditEditor = class(TItemsEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

implementation

uses
  System.SysUtils, FMX.Consts, FMX.Forms, FMX.TreeView, FMX.Header, FMX.Grid, FMX.ListBox, FMX.TabControl, FMX.Menus,
  Vcl.Dialogs, Vcl.Controls, Windows, FMX.Platform.Win, FMX.Design.Lang, ActnEdit, FMX.ActnList, DsnConst,
  FMX.Controls, FMX.Edit;

{$REGION 'TItemsEditor'}

function TItemsEditor.CanShow: Boolean;
begin
  Result := True;
end;

procedure TItemsEditor.DoCreateItem(Sender: TObject);
var
  MenuItem: Vcl.Menus.TMenuItem;
begin
  if Sender is Vcl.Menus.TMenuItem then
  begin
    MenuItem := Sender as Vcl.Menus.TMenuItem;
    if MenuItem.Tag >= 0 then
      IndexOfItemClass := MenuItem.Tag;
  end;
  if (Component is TFmxObject) and (IndexOfItemClass >= 0) and (IndexOfItemClass < Length(FItemsClasses)) then
    Designer.CreateChild(FItemsClasses[IndexOfItemClass].ItemClass, Component);
end;

procedure TItemsEditor.Edit;
begin
  if CanShow then
    ExecuteVerb(EDITOR_OPEN_DESIGNER);
end;

procedure TItemsEditor.ExecuteVerb(Index: Integer);
var
  Container: IItemsContainer;
begin
  case Index of
    EDITOR_OPEN_DESIGNER:
      begin
        if Assigned(DesignItemsForm) then
          FreeAndNil(DesignItemsForm);
        DesignItemsForm := TDesignItemsForm.Create(Application);
        if Supports(Component, IItemsContainer, Container) then
        begin
          DesignItemsForm.btnAddChild.Visible := FAllowChild;
          DesignItemsForm.Caption := GetVerb(Index).TrimRight([' ', '.']);
          DesignItemsForm.Designer := Designer;
          DesignItemsForm.SetItemClasses(Container, FItemsClasses);
          DesignItemsForm.Show;
        end;
      end;
    EDITOR_NEW_ITEM:
      DoCreateItem(nil);
  end;
end;

function TItemsEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    EDITOR_OPEN_DESIGNER:
      Result := SItemsEditor;
    EDITOR_CREATE_ITEM:
      Result := SNewItem;
    EDITOR_NEW_ITEM:
      begin
        if (IndexOfItemClass >= 0) and (IndexOfItemClass < Length(FItemsClasses)) then
          Result := Format(SNewLastItem, [FItemsClasses[IndexOfItemClass].ItemClass.ClassName])
        else
          Result := Format(SNewLastItem, [IntToStr(IndexOfItemClass)]);
      end;
  else
    Result := Format(SItems + ' %d', [Index]);
  end;
end;

function TItemsEditor.GetVerbCount: Integer;
begin
  if CanShow then
    Result := 3
  else
    Result := 0;
end;

function TItemsEditor.GetIndexOfItemClass: Integer;
var
  I: Integer;
begin
  Result := 0;
  if (FListOfLastItems <> nil) and FListOfLastItems.TryGetValue(ClassType.QualifiedClassName, I) then
    Result := I;
end;

procedure TItemsEditor.SetIndexOfItemClass(const Value: Integer);
var
  I: Integer;
begin
  if FListOfLastItems = nil then
  begin
    FListOfLastItems := TDictionary<string, Integer>.Create;
  end;
  if FListOfLastItems.TryGetValue(ClassType.QualifiedClassName, I) then
    FListOfLastItems[ClassType.QualifiedClassName] := Value
  else
    FListOfLastItems.Add(ClassType.QualifiedClassName, Value);
end;

procedure TItemsEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
var
  I: Integer;
  MenuItem: IMenuItem;
begin
  inherited PrepareItem(Index, AItem);
  case Index of
    EDITOR_CREATE_ITEM:
      begin
        if Length(FItemsClasses) > 1 then
        begin
          AItem.Visible := True;
          for I := 0 to High(FItemsClasses) do
          begin
            MenuItem := AItem.AddItem(FItemsClasses[I].ItemClass.ClassName, 0, False, True, DoCreateItem);
            MenuItem.Tag := I;
            MenuItem := nil;
          end;
        end
        else
          AItem.Visible := False;
      end;
    EDITOR_NEW_ITEM:
      begin
        AItem.Visible := (IndexOfItemClass >= 0) and (IndexOfItemClass < Length(FItemsClasses));
        AItem.Tag := -1;
      end;
  end;
end;

{$ENDREGION}

{$REGION 'TMenuEditor'}

constructor TMenuEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := true;
  SetLength(FItemsClasses, 1);
  FItemsClasses[0] := TItemClassDesc.Create(FMX.Menus.TMenuItem, True);
end;

{$ENDREGION}

{$REGION 'TListBoxEditor'}

constructor TListBoxEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := false;
  SetLength(FItemsClasses, 6);
  FItemsClasses[0] := TItemClassDesc.Create(TListBoxItem);
  FItemsClasses[1] := TItemClassDesc.Create(TMetropolisUIListBoxItem);
  FItemsClasses[2] := TItemClassDesc.Create(TListBoxHeader, False, True);
  FItemsClasses[3] := TItemClassDesc.Create(TSearchBox, False, True);
  FItemsClasses[4] := TItemClassDesc.Create(TListBoxGroupHeader);
  FItemsClasses[5] := TItemClassDesc.Create(TListBoxGroupFooter);
end;

{$ENDREGION}

{$REGION 'TTreeViewEditor'}

constructor TTreeViewEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := true;
  SetLength(FItemsClasses, 1);
  FItemsClasses[0] := TItemClassDesc.Create(TTreeViewItem, True);
end;

{$ENDREGION}

{$REGION 'THeaderEditor'}

constructor THeaderEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := false;
  SetLength(FItemsClasses, 1);
  FItemsClasses[0] := TItemClassDesc.Create(THeaderItem);
end;

{$ENDREGION}

{$REGION 'TTabControlEditor'}

constructor TTabControlEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FEditorNextTab := inherited GetVerbCount;
  FEditorPrevTab := FEditorNextTab + 1;
  FEditorDeleteTab := FEditorNextTab + 2;
  FVerbCount := FEditorNextTab + 3;
  FAllowChild := False;
  SetLength(FItemsClasses, 1);
  FItemsClasses[0] := TItemClassDesc.Create(TTabItem);
end;

procedure TTabControlEditor.DoCreateItem(Sender: TObject);
begin
  inherited;
  if (Component is TTabControl) then
    TTabControl(Component).TabIndex := TTabControl(Component).TabCount - 1;
end;

function TTabControlEditor.GetTabIndex: Integer;
begin
  if (Component is TTabControl) and (TTabControl(Component).TabIndex >= 0) and
    (TTabControl(Component).TabIndex < TTabControl(Component).TabCount) then
    Result := TTabControl(Component).TabIndex
  else
    Result := -1;
end;

procedure TTabControlEditor.ExecuteVerb(Index: Integer);
var
  Obj: TFmxObject;
  LTabIndex: Integer;
  LControl: TTabControl;
  procedure SelectTab(I: Integer);
  begin
    if I >= LControl.TabCount then
      I := LControl.TabCount - 1;
    if I < 0 then
      I := -1;
    LControl.TabIndex := I;
    if I >= 0 then
      Designer.SelectComponent(LControl.Tabs[I])
    else
      Designer.SelectComponent(Component);
  end;
begin
  inherited;
  if Component is TTabControl then
  begin
    LTabIndex := GetTabIndex;
    LControl := TTabControl(Component);
    if Index = FEditorNextTab then
      SelectTab(LTabIndex + 1)
    else if Index = FEditorPrevTab then
      SelectTab(LTabIndex - 1)
    else if (Index = FEditorDeleteTab) and (LTabIndex >= 0) then
    begin
      Obj := (LControl as IItemsContainer).GetItem(LTabIndex);
      FreeAndNil(Obj);
      SelectTab(LTabIndex);
    end;
  end;
end;

function TTabControlEditor.GetVerb(Index: Integer): string;
var
  S: string;
begin
  Result := Inherited GetVerb(Index);
  if Component is TTabControl then
    if Index = FEditorNextTab then
      Result := SNextTab
    else if Index = FEditorPrevTab then
      Result := SPrevTab
    else if Index = FEditorDeleteTab then
    begin
      if GetTabIndex >= 0 then
      begin
        S := TTabControl(Component).Tabs[GetTabIndex].Name;
        if S = '' then
          S := Format(SUnnamedTab, [GetTabIndex, TTabControl(Component).Tabs[GetTabIndex].ClassName])
        else
          S := QuotedStr(S);
        Result := Format(SDeleteItem, [S]);
      end
      else
        Result := Format(SDeleteItem, ['']);
    end;
end;

function TTabControlEditor.GetVerbCount: Integer;
begin
  Result := FVerbCount;
end;

procedure TTabControlEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
begin
  inherited;
  if Component is TTabControl then
  begin
    if Index = FEditorNextTab then
      AItem.Enabled := GetTabIndex < TTabControl(Component).TabCount - 1
    else if Index = FEditorPrevTab then
      AItem.Enabled := GetTabIndex > 0
    else if Index = FEditorDeleteTab then
      AItem.Enabled := GetTabIndex >= 0;
  end
  else
    AItem.Visible := False;
end;

{$ENDREGION}

{$REGION 'TBrushKindProperty'}
{ TBrushKindProperty }

procedure TBrushKindProperty.SetValue(const Value: string);
begin
  if WideSameText(Value, GetValue) or not WideSameText(Value, 'Bitmap') or
    (Vcl.Dialogs.MessageDlg(SBitmapBrushWindowsOnly, mtWarning, [mbOK, mbCancel], 0) = mrOk) then
    inherited;
end;

{$ENDREGION}

{$REGION 'TActiveTabProperty'}
{ TActiveTabProperty }

function TActiveTabProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited - [paMultiSelect, paSortList];
end;

procedure TActiveTabProperty.EnumerateItems(const VisibleOnly: Boolean; Proc: TGetStrProc);
var
  Persistent: TPersistent;
  Container: IItemsContainer;
  I: Integer;
  Obj: TFmxObject;
  S: TComponentName;
begin
  if PropCount = 1 then
  begin
    Persistent := GetComponent(0);
    if (Persistent is TComponent) and Persistent.GetInterface(IItemsContainer, Container) then
      for I := 0 to Container.GetItemsCount - 1 do
      begin
        Obj := Container.GetItem(I);
        if (Obj is TControl) and (not VisibleOnly or TControl(Obj).Visible) then
        begin
          FCurrentControl := Obj;
          S := TControl(Obj).Name;
          if S = '' then
            S := Format(SUnnamedTab, [I, Obj.ClassName]);
          Proc(S);
        end;
      end;
  end;
end;

procedure TActiveTabProperty.CheckValue(const S: string);
begin
  if WideSameText(S, FNewValue) then
    FNewControl := FCurrentControl;
end;

procedure TActiveTabProperty.CheckControl(const S: string);
begin
  if GetOrdValue = NativeInt(FCurrentControl) then
    FNewValue := S;
end;

procedure TActiveTabProperty.SetValue(const Value: string);
begin
  FCurrentControl := nil;
  FNewControl := nil;
  FNewValue := Value;
  EnumerateItems(False, CheckValue);
  SetOrdValue(NativeInt(FNewControl));
end;

function TActiveTabProperty.GetValue: string;
begin
  FCurrentControl := nil;
  FNewControl := nil;
  FNewValue := '';
  EnumerateItems(False, CheckControl);
  Result := FNewValue;
end;

procedure TActiveTabProperty.GetValues(Proc: TGetStrProc);
begin
  EnumerateItems(True, Proc);
end;
{$ENDREGION}


{$REGION 'TGridEditor'}

function GridItemsEditorEnabled(const Grid: TCustomGrid): Boolean;
var
  I: Integer;
begin
  Result := Grid <> nil;
  if Result and (Grid.ColumnCount > 0) then
  begin
    for I := 0 to Grid.ColumnCount - 1 do
      if not Grid.Columns[I].Locked then
        Exit;
    Result := False;
  end;
end;

constructor TGridEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
var
  List: TArray<TColumnClass>;
  I: Integer;
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := False;
  SetLength(FItemsClasses, Length(FItemsClasses) + 1);
  FItemsClasses[Length(FItemsClasses) - 1] := TItemClassDesc.Create(TColumn);
  List := TColumnClasses.RegisteredColumns;
  for I := Low(List) to High(List) do
    if List[I].ClassName <> TColumn.ClassName then
    begin
      SetLength(FItemsClasses, Length(FItemsClasses) + 1);
      FItemsClasses[Length(FItemsClasses) - 1] := TItemClassDesc.Create(TFmxObjectClass(List[I]));
    end;
end;

function TGridEditor.CanShow: Boolean;
begin
  Result := inherited and (Component is TCustomGrid) and GridItemsEditorEnabled(TCustomGrid(Component));
end;

{$ENDREGION}

{$REGION 'TStringGridEditor'}

function TStringGridEditor.CanShow: Boolean;
begin
  Result := inherited and (Component is TCustomGrid) and GridItemsEditorEnabled(TCustomGrid(Component));
end;

constructor TStringGridEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
var
  List: TArray<TColumnClass>;
  I: Integer;
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := False;
  SetLength(FItemsClasses, Length(FItemsClasses) + 1);
  FItemsClasses[Length(FItemsClasses) - 1] := TItemClassDesc.Create(TStringColumn);

  List := TColumnClasses.RegisteredColumns;
  for I := Low(List) to High(List) do
    if (List[I].ClassName <> TStringColumn.ClassName) and not List[I].InheritsFrom(TImageColumn) then
    begin
      SetLength(FItemsClasses, Length(FItemsClasses) + 1);
      FItemsClasses[Length(FItemsClasses) - 1] := TItemClassDesc.Create(TFmxObjectClass(List[I]));
    end;
end;

{$ENDREGION}

{$REGION 'TEditEditor'}

constructor TEditEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FAllowChild := False;
  SetLength(FItemsClasses, 7);
  FItemsClasses[0] := TItemClassDesc.Create(TEditButton);
  FItemsClasses[1] := TItemClassDesc.Create(TClearEditButton);
  FItemsClasses[2] := TItemClassDesc.Create(TPasswordEditButton);
  FItemsClasses[3] := TItemClassDesc.Create(TSearchEditButton);
  FItemsClasses[4] := TItemClassDesc.Create(TEllipsesEditButton);
  FItemsClasses[5] := TItemClassDesc.Create(TDropDownEditButton);
  FItemsClasses[6] := TItemClassDesc.Create(TSpinEditButton);
end;

{$ENDREGION}

initialization
finalization
  FreeandNil(TItemsEditor.FListOfLastItems);

end.
