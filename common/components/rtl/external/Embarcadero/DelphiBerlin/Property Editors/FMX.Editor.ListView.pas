{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit FMX.Editor.ListView;

{$SCOPEDENUMS ON}

interface

uses
  System.Classes, ColnEdit, DesignIntf, FMX.Types, FMX.ListView.DynamicAppearance, System.TypInfo, DesignEditors,
  DesignMenus, FmxReg, ActionEditors, System.Actions, FmxDsnConst, FMX.ListView.Appearances, FMX.Controls, System.Types,
  System.SysUtils, TreeIntf, FmxSprigs, Vcl.ComCtrls, FMX.ListView;

type
  TVclListView = Vcl.ComCtrls.TListView;

  TListViewObjectsSprig = class;
  TListViewObjectsProperties = class(TInterfacedPersistent, IDesignablePersistent)
  private type
    TOpenItemAppearanceProperties = class(TItemAppearanceProperties);
  private
    FAppearance: TItemAppearanceProperties;
    FShim: IPersistentShim;
    function GetHeight: Integer;
    function GetName: string;
    procedure SetHeight(const Value: Integer);
    procedure SetName(const Value: string);
    function IsHeightStored: Boolean;

    function GetOwnerControl: FMX.Controls.TControl;
    function GetDesignParent: TPersistent;
    function GetBoundsRect: TRect;
    procedure Bind(AShim: IPersistentShim);
    procedure Unbind;
    function BeingDesigned: Boolean;
    function GetObjects: TAppearanceObjectItemCollection;
    procedure SetObjects(Value: TAppearanceObjectItemCollection);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(const AAppearance: TItemAppearanceProperties);
    destructor Destroy; override;
    property Objects: TAppearanceObjectItemCollection read GetObjects write SetObjects stored false;
  published
    property Appearance: string read GetName write SetName stored False;
    property Height: Integer read GetHeight write SetHeight stored IsHeightStored nodefault;
  end;

  TListViewObjectsProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
  end;

  TListViewAppearanceNamePropertyEditor = class(TStringProperty)
  private
    procedure Synch1SetValue(const Value: string; AGetValue,
      AGetSynchValue: TFunc<string>; ASetSynchValue: TProc<string>);
    procedure Synch2SetValue(const Value: string; AGetValue,
      AGetSynchValue: TFunc<string>;
      AGetPrefix: TFunc<string, string>;
      ASetSynchValue: TProc<string>);
  protected
    function GetFilter: TRegisterAppearanceOptions; virtual;
  public
    procedure GetValues(Proc: TGetStrProc); override;
    function GetAttributes: TPropertyAttributes; override;
    procedure SetValue(const Value: string); override;
  end;

  TListViewHeaderAppearanceNamePropertyEditor = class(TListViewAppearanceNamePropertyEditor)
  protected
    function GetFilter: TRegisterAppearanceOptions; override;
  end;

  TListViewFooterAppearanceNamePropertyEditor = class(TListViewAppearanceNamePropertyEditor)
  protected
    function GetFilter: TRegisterAppearanceOptions; override;
  end;

  TListViewItemEditAppearanceNamePropertyEditor = class(TListViewAppearanceNamePropertyEditor)
  protected
    function GetFilter: TRegisterAppearanceOptions; override;
  end;

  TListViewSelectionEditor = class(TSelectionEditor)
  private
    procedure AppearanceRequiresUnits(Proc: TGetStrProc);
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TListViewItemAppearancePropertiesEditor = class(TSelectionEditor, ISelectionPropertyFilter)
  protected
    { ISelectionPropertyFilter }
     procedure FilterProperties(const ASelection: IDesignerSelections; const ASelectionProperties: IInterfaceList);
  end;

  TListViewEditModeSelectionEditor = class(TSelectionEditor)
  private
    FVerbs: TArray<string>;
    const ToggleEditMode = 0;
    const ToggleDesignMode = 1;
  private
    procedure VerbToggleEdit(const ListView: TCustomListView);
    procedure VerbToggleDesign(const ListView: TCustomListView);
  public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer; const List: IDesignerSelections); override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
    constructor Create(const ADesigner: IDesigner); override;
  end;

  TListViewSprig = class(FmxSprigs.TControlSprig)
  public
    procedure FigureChildren; override;
  end;

  TListViewAppearanceSprig = class(TPersistentSprig)
  private
    FListView: FMX.ListView.TCustomListView;
  public
    constructor Create(const AListView: FMX.ListView.TCustomListView);
    function Ghosted: Boolean; override;
    function UniqueName: string; override;
    procedure FigureParent; override;
    procedure FigureChildren; override;
    function Caption: string; override;
    function DeleteStyle: TSprigDeleteStyle; override;
  end;

  TListViewObjectsSprig = class(TPersistentSprig)
  strict private
    FAppearance: TItemAppearanceProperties;
    FClassName: string;
    FPersistent: TPersistent;
  public
    constructor Create(AListView: TCustomListView; AAppearance: TItemAppearanceProperties);
    destructor Destroy; override;
    procedure AppearanceChanged(Sender: TObject);
    procedure AppearanceDeleted(Sender: TObject);
    procedure FigureChildren; override;
    function UniqueName: string; override;
    function Ghosted: Boolean; override;
    procedure FigureParent; override;
    function Caption: string; override;
    function DeleteStyle: TSprigDeleteStyle; override;
    function SortByIndex: Boolean; override;
  end;

  TObjectAppearanceSprig = class(TPersistentSprig)
  private
    FOwner: TItemAppearanceProperties;
    FName: string;
    FIndex: Integer;
  public
    constructor Create(const AOwner: TItemAppearanceProperties; const AName: string;
      const AObjectAppearance: TObjectAppearance; AIndex: Integer = -1);
    function Ghosted: Boolean; override;
    function UniqueName: string; override;
    procedure FigureParent; override;
    function Caption: string; override;
    function DeleteStyle: TSprigDeleteStyle; override;
    function CustomDelete: Boolean; override;
    function ItemIndex: Integer; override;
  end;


  /// <summary>Collection editor for TListViewObjectsProperties.Objects: TAppearanceObjectItemCollection
  ///  </summary>
  TDynAppearanceCollectionEditor = class(TCollectionEditor)
  private
    procedure AddObject(Sender: TObject);
  protected
    function CanAdd(Index: Integer): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  /// <summary>Property editor for TListViewObjectsProperties.Objects: TAppearanceObjectItemCollection
  /// </summary>
  TAppearanceObjectsPropertyEditor = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  /// <summary>Property editor for TAppearanceObjectItem.AppearanceObjectClass
  /// </summary>
  TAppearanceObjectClassPropertyEditor = class(TStringProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
    function GetAttributes: TPropertyAttributes; override;
    procedure SetValue(const Value: string); override;
  end;

  /// <summary>Provide virtual properties for TListViewObjectsProperties with Appearance = TDynamicAppearance.
  ///  Generates following property sheet items:
  ///   Objects: TAppearanceObjectItemCollection
  ///   {object name: object appearance class}+ (e.g. text: TTextObjectAppearance)
  ///  </summary>
  TListViewObjectsPropertyDynamicEditor = class(TSelectionEditor, ISelectionPropertyFilter)
  protected
    procedure FilterProperties(const ASelection: IDesignerSelections; const ASelectionProperties: IInterfaceList);
  end;

  /// <summary>
  ///  AppearanceObject item editor: dynamically created from items in TAppearanceObjectItemCollection collection.
  ///  Items in the property sheet are like 'text': TTextObjectAppearance
  /// </summary>
  TAppearanceObjectSynthProperty = class(TCustomSyntheticProperty, IProperty80)
  strict private
    FItem: TAppearanceObjectItem;
    FCollection: TCollection;
    FHost: IPropertyHost;
    FDropDown: TVclListView;

    function DropDownCreate(const Host: IPropertyHost): TVclListView;
    function DropDownCreateDelete(const Host: IPropertyHost): TVclListView;

    procedure DropDownSelect(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure DropDownEnter(Sender: TObject);
    procedure DropDownEnterDelete(Sender: TObject);
  protected
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetProperties(Proc: TGetPropProc); override;
    procedure Edit(const Host: IPropertyHost; DblClick: Boolean); reintroduce; overload;
    procedure CreateNewObject(const AAppearance: TAppearanceObject);
  public
    constructor Create(const ADesigner: IDesigner; const Item: TAppearanceObjectItem;
     const Collection: TCollection); reintroduce;
    destructor Destroy; override;
  end;

  /// <summary>TListViewObjectsProperties.Objects property. It is implemented as custom property
  ///  because it only should appear for items where Appearance is TDynamicAppearance.
  /// </summary>
  TAppearanceObjectItemCollectionProperty = class(TCustomSyntheticProperty, IProperty80)
  strict private
    FObjectsProperties: TListViewObjectsProperties;
  protected
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetProperties(Proc: TGetPropProc); override;
    // IProperty80
    procedure Edit(const Host: IPropertyHost; DblClick: Boolean); reintroduce; overload;
  public
    constructor Create(const ADesigner: IDesigner; const Host: TListViewObjectsProperties); reintroduce;
  end;

procedure Register;

implementation

uses
  System.Rtti, Vcl.Forms, FMX.Design.ListView, FMX.ListView.Types,
  System.Generics.Collections;

{ TListViewObjectsProperties }

constructor TListViewObjectsProperties.Create(const AAppearance: TItemAppearanceProperties);
var
  Sprigged: ISpriggedPersistent;
begin
  inherited Create;
  FAppearance := AAppearance;
  if Supports(FAppearance, ISpriggedPersistent, Sprigged) then
    Sprigged.SetSprig(Self);
end;

destructor TListViewObjectsProperties.Destroy;
var
  Sprigged: ISpriggedPersistent;
begin
  if Supports(FAppearance, ISpriggedPersistent, Sprigged) then
  begin
    Sprigged.SetSprig(nil);
    Sprigged := nil;
  end;
  Unbind;
  inherited;
end;

function TListViewObjectsProperties.GetHeight: Integer;
begin
  Result := FAppearance.Height;
end;

function TListViewObjectsProperties.GetBoundsRect: TRect;
begin
  if FShim <> nil then
    Result := FShim.GetBoundsRect
  else
    Result := TRect.Empty;
end;

function TListViewObjectsProperties.GetDesignParent: TPersistent;
begin
  Result := GetOwnerControl;
end;

function TListViewObjectsProperties.GetOwner: TPersistent;
begin
  Result := GetOwnerControl;
end;

function TListViewObjectsProperties.GetOwnerControl: TControl;
begin
  Result := TControl(FAppearance.Owner);
end;

function TListViewObjectsProperties.GetName: string;
begin
  Result := FAppearance.Name;
end;

function TListViewObjectsProperties.IsHeightStored: Boolean;
begin
  Result := TOpenItemAppearanceProperties(FAppearance).IsHeightStored;
end;

procedure TListViewObjectsProperties.SetHeight(const Value: Integer);
begin
  FAppearance.Height := Value;
end;

procedure TListViewObjectsProperties.SetName(const Value: string);
begin
  FAppearance.Name := Value;
end;

function TListViewObjectsProperties.BeingDesigned: Boolean;
var
  Parent: IListViewDesignPresentationParent;
begin
  Result := Supports(FAppearance.Owner, IListViewDesignPresentationParent, Parent) and Parent.HasDesignPresentationAttached;
end;

procedure TListViewObjectsProperties.Bind(AShim: IPersistentShim);
begin
  FShim := AShim;
end;

procedure TListViewObjectsProperties.Unbind;
begin
  FShim := nil;
end;

procedure TListViewObjectsProperties.SetObjects(Value: TAppearanceObjectItemCollection);
begin
  if FAppearance.Objects is TDynamicAppearance then
    TDynamicAppearance(FAppearance.Objects).ObjectsCollection.Assign(Value);
end;

function TListViewObjectsProperties.GetObjects: TAppearanceObjectItemCollection;
begin
  Result := nil;
  if FAppearance.Objects is TDynamicAppearance then
    Result := TAppearanceObjectItemCollection(TDynamicAppearance(FAppearance.Objects).ObjectsCollection);
end;

{ TListViewItemAppearancePropertiesNamePropertyEditor }

function TListViewAppearanceNamePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

function TListViewAppearanceNamePropertyEditor.GetFilter: TRegisterAppearanceOptions;
var
  LProperties: TItemAppearanceProperties;
begin
  Result := [TRegisterAppearanceOption.Item];
  if GetComponent(0) is TListViewObjectsProperties then
  begin
    LProperties := TListViewObjectsProperties(GetComponent(0)).FAppearance;
    case LProperties.AppearanceType of
      TAppearanceType.Item:
        Result := [TRegisterAppearanceOption.Item];
      TAppearanceType.ItemEdit:
        Result := [TRegisterAppearanceOption.ItemEdit];
      TAppearanceType.Header:
        Result := [TRegisterAppearanceOption.Header];
      TAppearanceType.Footer:
        Result := [TRegisterAppearanceOption.Footer];
    else
      Assert(False);
    end;
  end;

end;

procedure TListViewAppearanceNamePropertyEditor.GetValues(Proc: TGetStrProc);
var
  LFilter: TRegisterAppearanceOptions;
  LAppearance: TRegisteredAppearance;
begin
  LFilter := GetFilter;
  for LAppearance in TAppearancesRegistry.GetRegisteredAppearances(LFilter) do
  begin
    Proc(LAppearance.Name);  // Display name
  end;
end;

//  Synch when item value is changed, and item value is exact prefix
procedure TListViewAppearanceNamePropertyEditor.Synch1SetValue(const Value: string;
  AGetValue, AGetSynchValue: TFunc<string>;
  ASetSynchValue: TProc<string>);
var
  LValue, LSynchValue: string;
  LNewValue: string;
begin
  LValue := AGetValue;
  LSynchValue := AGetSynchValue;
  inherited SetValue(Value);
  LNewValue := AGetValue;
  if LNewValue <> '' then
    ASetSynchValue(LNewValue);
end;

//  Synch when item value is changed, and item value is exact prefix
procedure TListViewAppearanceNamePropertyEditor.Synch2SetValue(const Value: string;
  AGetValue, AGetSynchValue: TFunc<string>;
  AGetPrefix: TFunc<string, string>;
  ASetSynchValue: TProc<string>);
var
  LValue, LSynchValue: string;
  LNewValue: string;
  LPrefix: string;
begin
  LValue := AGetValue;
  LSynchValue := AGetSynchValue;
  inherited SetValue(Value);
  LNewValue := AGetValue;
  LPrefix := AGetPrefix(LNewValue);
  if LPrefix <> '' then
    ASetSynchValue(LPrefix);
end;


{ TListViewSelectionEditor }

procedure TListViewSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited;
  Proc('FMX.ListView.Types');
  Proc('FMX.ListView.Appearances');
  Proc('FMX.ListView.Adapters.Base');
  AppearanceRequiresUnits(Proc);
end;

type
  TOpenListView = class(TCustomListView);

procedure TListViewSelectionEditor.AppearanceRequiresUnits(Proc: TGetStrProc);
var
  I: Integer;
  LComponent: TComponent;
  LAppearance: TRegisteredAppearance;
  LList: TList<string>;
begin
  LList := TList<string>.Create;
  try
    for I := 0 to Designer.Root.ComponentCount - 1 do   // Ignore components in frames
    begin
      LComponent := Designer.Root.Components[I];
      if LComponent is TCustomListView then
      begin
        LList.Add(TOpenListView(LComponent).ItemAppearanceClassName);
        LList.Add(TOpenListView(LComponent).ItemEditAppearanceClassName);
        LList.Add(TOpenListView(LComponent).HeaderAppearanceClassName);
        LList.Add(TOpenListView(LComponent).FooterAppearanceClassName);
      end;
    end;
    for LAppearance in TAppearancesRegistry.GetRegisteredAppearances([]) do
    begin
      // Check for custom installed appearances
      if (LAppearance.UnitName <> '') and
        LList.Contains(LAppearance.Value.ClassName) then
        Proc(LAppearance.UnitName);
    end;
  finally
    LList.Free;
  end;
end;

{ TListViewItemAppearancePropertiesEditor }

procedure TListViewItemAppearancePropertiesEditor.FilterProperties(const ASelection: IDesignerSelections;
  const ASelectionProperties: IInterfaceList);
const
  sHeaderClassName = 'HeaderAppearanceClassName';
  sFooterClassName = 'FooterAppearanceClassName';
  sItemClassName = 'ItemAppearanceClassName';
  sItemEditClassName = 'ItemEditAppearanceClassName';
var
  I, J: Integer;
  LSelectedItem: TPersistent;
  LItem: IProperty;
  LName: string;
begin
  for I := 0 to ASelection.Count - 1 do
  begin
    LSelectedItem := ASelection[I];
    if LSelectedItem is TCustomListView then
    begin
      for J := ASelectionProperties.Count - 1 downto 0 do
      begin
        LItem := ASelectionProperties.Items[J] as IProperty;
        if LItem <> nil then
        begin
          LName := LItem.GetName;
          if (LName = sItemClassName) or
            (LName = sHeaderClassName) or
            (LName = sItemEditClassName) or
            (LName = sFooterClassName) then
          begin
            LItem := nil;
            ASelectionProperties.Delete(J);
          end;
        end;
      end;
    end;
  end;
end;


{ TListViewSprig }


function AppearanceProperty(const AAppearance: TItemAppearanceProperties): string;
const
  sItemAppearance = 'Item';
  sHeaderAppearance = 'Header';
  sFooterAppearance = 'Footer';
  sItemEditAppearance = 'ItemEdit';
begin
  case AAppearance.AppearanceType of
    TAppearanceType.Item:
      Result := sItemAppearance;
    TAppearanceType.ItemEdit:
      Result := sItemEditAppearance;
    TAppearanceType.Header:
      Result := sHeaderAppearance;
    TAppearanceType.Footer:
      Result := sFooterAppearance;
  else
    Assert(False);
  end;
end;

function AppearanceObjectsSprigName(const AAppearance: TItemAppearanceProperties): string;
begin
  Result := AAppearance.Owner.Name + '.' + AppearanceProperty(AAppearance);
end;

function AppearanceSprigName(const AListView: TCustomListView): string;
begin
  Result := AListView.Name + '.' + TOpenListView(AListView).ItemAppearanceObjects.ClassName;
end;

function AppearanceObjectsSprigDisplayName(const AAppearance: TItemAppearanceProperties): string;
begin
  Result := AppearanceProperty(AAppearance);
end;

function ObjectAppearanceSprigName(const AOwner: TItemAppearanceProperties; const AName: string): string;
begin
  Result := AppearanceObjectsSprigName(AOwner) + '.' + AName;
end;

function ObjectAppearanceSprigDisplayName(const AOwner: TItemAppearanceProperties; const AName: string): string;
begin
  Result := AName;
end;

procedure TListViewSprig.FigureChildren;

  procedure AddAppearanceSprig(const AListView: TCustomListView);
  var
    LSprig: TSprig;
  begin
    LSprig := Find(AppearanceSprigName(AListView), False);
    if LSprig = nil then
      // if not then make it
      Add(TListViewAppearanceSprig.Create(AListView));
  end;

var
  LListView: TCustomListView;
begin
  //inherited;

  LListView := Item as TCustomListView;
  AddAppearanceSprig(LListView);
end;

{ TListViewAppearanceSprig }

function TListViewObjectsSprig.Caption: string;
begin
  Assert(FAppearance <> nil);
  Result := AppearanceObjectsSprigDisplayName(FAppearance);
end;

procedure TListViewObjectsSprig.FigureParent;
begin
end;

function TListViewObjectsSprig.Ghosted: Boolean;
begin
  Assert(FAppearance <> nil);
  Result := not FAppearance.Active;
end;

function TListViewObjectsSprig.SortByIndex: Boolean;
begin
  Result := True;
end;

function TListViewObjectsSprig.UniqueName: string;
begin
  Assert(FAppearance <> nil);
  Result := AppearanceObjectsSprigName(FAppearance as TItemAppearanceProperties);
end;

constructor TListViewObjectsSprig.Create(AListView: TCustomListView; AAppearance: TItemAppearanceProperties);
begin
  FPersistent := TListViewObjectsProperties.Create(AAppearance);
  inherited Create(FPersistent); // Select list view when click this sprig item
  ImageIndex := CCollectionSprigImage;
  FAppearance := AAppearance;
  FAppearance.OnChange := AppearanceChanged;
  FAppearance.OnDestroy := AppearanceDeleted;
end;

function TListViewObjectsSprig.DeleteStyle: TSprigDeleteStyle;
begin
  Result := dsAbort;
end;

destructor TListViewObjectsSprig.Destroy;
begin
  if FAppearance <> nil then
  begin
    FAppearance.OnChange := nil;
    FAppearance.OnDestroy := nil;
  end;
  FreeAndNil(FPersistent);
  inherited;
end;

procedure TListViewObjectsSprig.FigureChildren;

  function AddObjectAppearanceSprig(const AOwner: TItemAppearanceProperties; const AName: string;
    const AObjectAppearance: TObjectAppearance; AIndex: Integer): TSprig;
  begin
    Result := Find(ObjectAppearanceSprigName(AOwner, AName), False);
    if (Result <> nil) and not Result.Item.ClassNameIs(AObjectAppearance.ClassName) then
    begin
      Result.Invalidate;
      Result := nil;
    end;

    if Result = nil then
      Result := Add(TObjectAppearanceSprig.Create(AOwner, AName, AObjectAppearance, AIndex));
  end;

  function GetMemberName(const Appearance: TCommonObjectAppearance): string;
  begin
    if Length(Appearance.DataMembers) > 0 then
      Result := Appearance.DataMembers[0].Key
    else
      Result := Appearance.Name;
  end;

var
  LAppearance: TItemAppearanceProperties;
  LProperties: TItemAppearanceObjects;
  I: Integer;
  LPropCount: Integer;
  LProp: TObject;
  LProps: TPropList;
  CommonAppearance: TCommonObjectAppearance;
  PublishedObjects: TList<string>;
  Valid: TList<Integer>;
  LIndex: Integer;
begin
  Assert(FAppearance <> nil);
  Assert(FPersistent <> nil);
  inherited;
  LAppearance := FAppearance;
  if FClassName <> LAppearance.AppearanceClassName then
    for I := Count - 1 downto 0 do
      Items[I].Free;

  LIndex := 0;

  LProperties := LAppearance.Objects;
  if LProperties <> nil then
  begin
    LPropCount := GetPropList(LProperties.ClassInfo, [tkClass], @LProps);
    PublishedObjects := TList<string>.Create;
    Valid := TList<Integer>.Create;
    try
      for I := 0 to LPropCount - 1 do
      begin
        LProp := TObject(GetOrdProp(LProperties, LProps[I]));
        if LProp is TObjectAppearance then
        begin
          Valid.Add(AddObjectAppearanceSprig(LAppearance, GetPropName(LProps[I]), TObjectAppearance(LProp), LIndex).Index);
          Inc(LIndex);
          PublishedObjects.Add(TObjectAppearance(LProp).Name);
        end
      end;
      for CommonAppearance in LProperties.Objects do
        if not PublishedObjects.Contains(CommonAppearance.Name) then
        begin
          Valid.Add(AddObjectAppearanceSprig(LAppearance, GetMemberName(CommonAppearance), CommonAppearance, LIndex).Index);
          Inc(LIndex);
        end;

      // Remove invalid
      for I := Count - 1 downto 0 do
        if not Valid.Contains(I) then
          Items[I].Invalidate;

    finally
      PublishedObjects.Free;
      Valid.Free;
    end;
  end;
  ClearUnneededSprigs;
  FClassName := LAppearance.AppearanceClassName;
end;

procedure TListViewObjectsSprig.AppearanceChanged(Sender: TObject);
begin
  FigureChildren;
end;

procedure TListViewObjectsSprig.AppearanceDeleted(Sender: TObject);
begin
  if FAppearance <> nil then
  begin
    FAppearance.OnChange := nil;
    FAppearance.OnDestroy := nil;
    FAppearance := nil;
  end;
  FreeAndNil(FPersistent);
end;

{ TListViewAppearanceSprig }

function TListViewAppearanceSprig.Caption: string;
begin
  Result := 'ItemAppearance'; // Do not localize
end;

function TListViewAppearanceSprig.Ghosted: Boolean;
begin
  Result := False;
end;

constructor TListViewAppearanceSprig.Create(const AListView: FMX.ListView.TCustomListView);
begin
  FListView := AListView;
  inherited Create(TOpenListView(AListView).ItemAppearance);
end;

function TListViewAppearanceSprig.DeleteStyle: TSprigDeleteStyle;
begin
  Result := dsAbort;
end;

procedure TListViewAppearanceSprig.FigureChildren;

  procedure AddObjectsSprig(const AListView: TCustomListView; const AAppearance: TItemAppearanceProperties);
  var
    LSprig: TSprig;
  begin
    LSprig := Find(AppearanceObjectsSprigName(AAppearance), False);
    if LSprig = nil then
      // if not then make it
      Add(TListViewObjectsSprig.Create(AListView, AAppearance));
  end;

var
  LAppearanceProperties: TItemAppearanceProperties;
begin
  for LAppearanceProperties in  TOpenListView(FListView).GetAppearanceProperties do
    AddObjectsSprig(FListView, LAppearanceProperties);
end;

procedure TListViewAppearanceSprig.FigureParent;
begin
end;

function TListViewAppearanceSprig.UniqueName: string;
begin
  Result := AppearanceSprigName(FListView);
end;

{ TObjectAppearanceSprig }

constructor TObjectAppearanceSprig.Create(const AOwner: TItemAppearanceProperties;
  const AName: string; const AObjectAppearance: TObjectAppearance; AIndex: Integer = -1);
begin
  FOwner := AOwner;
  FName := AName;
  FIndex := AIndex;
  inherited Create(AObjectAppearance);
  ImageIndex := CUIControlSprigImage;
end;

function TObjectAppearanceSprig.Caption: string;
begin
  Result := ObjectAppearanceSprigDisplayName(FOwner, FName);
end;

function TObjectAppearanceSprig.CustomDelete: Boolean;
var
  DynAppearance: TDynamicAppearance;
  I: Integer;
  Designer: IDesigner;
  Selections: IDesignerSelections;
begin
  Result := False;
  if FOwner.Objects is TDynamicAppearance then
  begin
    DynAppearance := TDynamicAppearance(FOwner.Objects);
    for I := 0 to DynAppearance.ObjectsCollection.Count - 1 do
    begin
      if TAppearanceObjectItem(DynAppearance.ObjectsCollection.Items[I]).Appearance = Item then
      begin
        DynAppearance.ObjectsCollection.BeginUpdate;
        try
          GetDesigner(Designer);
          if Designer <> nil then
            Designer.ClearSelection;
          DynAppearance.ObjectsCollection.Delete(I);
          Invalidate;
          if Designer <> nil then
          begin
            Selections := TDesignerSelections.Create;
            Selections.Add(Parent.Item);
            Designer.SelectComponent(Selections.DesignObjects[0]);
            Designer.Modified;
          end;
          Result := True;
        finally
          DynAppearance.ObjectsCollection.EndUpdate;
        end;
        Break;
      end;
    end;
  end;
end;

function TObjectAppearanceSprig.DeleteStyle: TSprigDeleteStyle;
begin
  Result := TSprigDeleteStyle.dsCustom;
end;

procedure TObjectAppearanceSprig.FigureParent;
begin
end;

function TObjectAppearanceSprig.Ghosted: Boolean;
begin
  if not Invalid then
    Result := not (Item as TObjectAppearance).Visible
  else
    Result := True;
end;

function TObjectAppearanceSprig.ItemIndex: Integer;
begin
  if FIndex = -1 then
    Result := inherited
  else
    Result := FIndex;
end;

function TObjectAppearanceSprig.UniqueName: string;
begin
  Result := ObjectAppearanceSprigName(FOwner, FName);
end;

{ TListViewItemAppearancePropertiesProperty }

function TListViewObjectsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited + [paVolatileSubProperties];
end;

{ TListViewHeaderAppearanceNamePropertyEditor }

function TListViewHeaderAppearanceNamePropertyEditor.GetFilter: TRegisterAppearanceOptions;
begin
  Result := [TRegisterAppearanceOption.Header]
end;

{ TListViewFooterAppearanceName }

function TListViewFooterAppearanceNamePropertyEditor.GetFilter: TRegisterAppearanceOptions;
begin
  Result := [TRegisterAppearanceOption.Footer]
end;

{ TListViewItemEditAppearanceNamePropertyEditor }

function TListViewItemEditAppearanceNamePropertyEditor.GetFilter: TRegisterAppearanceOptions;
begin
  Result := [TRegisterAppearanceOption.ItemEdit]
end;

{ TListViewEditModeSelectionEditor }

constructor TListViewEditModeSelectionEditor.Create(const ADesigner: IDesigner);
begin
  inherited;
  SetLength(FVerbs, 2);
  FVerbs[ToggleEditMode] := SToggleEditMode;
  FVerbs[ToggleDesignMode] := SToggleDesignMode;
end;

procedure TListViewEditModeSelectionEditor.ExecuteVerb(Index: Integer; const List: IDesignerSelections);
var
  OwnerComponent: TComponent;
  LListView: TCustomListView;
begin
  OwnerComponent := nil;
  if List.Count > 0 then
    if List[0] is TCustomListView then
      OwnerComponent := TCustomListView(List[0])
    else if List[0] is TPublishedAppearance then
      OwnerComponent := TPublishedAppearance(List[0]).Owner
    else if List[0] is TListViewObjectsProperties then
      OwnerComponent := TListViewObjectsProperties(List[0]).FAppearance.Owner;

  if OwnerComponent is TCustomListView then
  begin
    LListView := TCustomListView(OwnerComponent);
    case Index of
      ToggleEditMode:   VerbToggleEdit(LListView);
      ToggleDesignMode: VerbToggleDesign(LListView);
    end;
  end;
end;

function TListViewEditModeSelectionEditor.GetVerb(Index: Integer): string;
begin
  Result := FVerbs[Index];
end;

function TListViewEditModeSelectionEditor.GetVerbCount: Integer;
begin
  Result := Length(FVerbs);
end;

procedure TListViewEditModeSelectionEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
var
  OwnerComponent: TComponent;
  LListView: TCustomListView;
  List: IDesignerSelections;
begin
  inherited;
  OwnerComponent := nil;
  List := TDesignerSelections.Create;
  Designer.GetSelections(List);
  if List.Count > 0 then
    if List[0] is TCustomListView then
      OwnerComponent := TCustomListView(List[0])
    else if List[0] is TPublishedAppearance then
      OwnerComponent := TPublishedAppearance(List[0]).Owner
    else if List[0] is TListViewObjectsProperties then
      OwnerComponent := TListViewObjectsProperties(List[0]).FAppearance.Owner;

  if OwnerComponent is TCustomListView then
  begin
    LListView := TCustomListView(OwnerComponent);
    case Index of
      ToggleEditMode:   AItem.Checked := LListView.EditMode;
      ToggleDesignMode: AItem.Checked := TListViewDesignPresentationManager.Instance.IsEnabled(LListView);
    end;
  end;
end;

procedure TListViewEditModeSelectionEditor.VerbToggleDesign(const ListView: TCustomListView);
begin
  TListViewDesignPresentationManager.Instance.ToggleVerb(ListView);
end;

procedure TListViewEditModeSelectionEditor.VerbToggleEdit(const ListView: TCustomListView);
begin
  ListView.EditMode := not ListView.EditMode;
  Designer.Modified;
end;

procedure TListViewAppearanceNamePropertyEditor.SetValue(const Value: string);
var
  LAppearance: TPublishedAppearance;
  LFilter: TRegisterAppearanceOptions;
  LProperties: TItemAppearanceProperties;
begin
  if GetComponent(0) is TPublishedAppearance and (Value <> '') then
  begin
    LAppearance := TPublishedAppearance(GetComponent(0));
  end
  else if GetComponent(0) is TListViewObjectsProperties then
  begin
    LProperties :=
      TListViewObjectsProperties(GetComponent(0)).FAppearance;
    LAppearance :=
      TOpenListView(LProperties.Owner).ItemAppearance;
  end;
  LFilter := GetFilter;

  if LAppearance <> nil then
  begin
    if LFilter = [TRegisterAppearanceOption.Item] then
      // Synch itemedit with item
      Synch1SetValue(Value,
       function: string
       begin
         Result := LAppearance.ItemAppearance;
       end,
       function: string
       begin
         Result := LAppearance.ItemEditAppearance;
       end,
       procedure(AValue: string)
       var
         LPair: TRegisteredAppearance;
         LPrefixLength: Integer;
       begin
         LPrefixLength := MaxInt;
         for LPair in TAppearancesRegistry.GetRegisteredAppearances([TRegisterAppearanceOption.ItemEdit]) do
            if LPair.Name.StartsWith(AValue) and (LPrefixLength > LPair.Name.Length - AValue.Length)  then
            begin
              LPrefixLength := LPair.Name.Length - AValue.Length;
              LAppearance.ItemEditAppearance := LPair.Name;
            end;
       end)
    else if LFilter = [TRegisterAppearanceOption.ItemEdit] then
      // Synch item with itemedit
      Synch2SetValue(Value,
       function: string
       begin
         Result := LAppearance.ItemEditAppearance;
       end,
       function: string
       begin
         Result := LAppearance.ItemAppearance;
       end,
       function(AValue: string): string  // Get prefix of itemedit
       var
         LPair: TRegisteredAppearance;
         LPrefixLength: Integer;
       begin
         Result := '';
         LPrefixLength := 0;
         for LPair in TAppearancesRegistry.GetRegisteredAppearances([TRegisterAppearanceOption.Item]) do
           if (LPair.Name <> '') and AValue.StartsWith(LPair.Name) and (LPrefixLength < LPair.Name.Length) then
            begin
              LPrefixLength := LPair.Name.Length;
              Result := LPair.Name;
            end;
       end,
       procedure(AValue: string)
       var
         LPair: TRegisteredAppearance;
       begin
         for LPair in TAppearancesRegistry.GetRegisteredAppearances([TRegisterAppearanceOption.Item]) do
           if SameText(AValue, LPair.Name) then
             LAppearance.ItemAppearance := AValue;
       end)
    else
      inherited;
  end
  else
    inherited;
end;

{ Dynamic appearance }

{ TDynAppearanceCollectionEditor }

constructor TDynAppearanceCollectionEditor.Create(AOwner: TComponent);
begin
  inherited;
  AddCmd.OnExecute := AddObject;
end;

procedure TDynAppearanceCollectionEditor.AddObject(Sender: TObject);
begin
  with TAppearanceObjectItem(TAppearanceObjectItemCollection(Collection).Add) do
  begin
    AppearanceObjectName := Format(ObjectAppearanceFormat[TAppearanceObject.Text], [Collection.Count]);
    AppearanceClassName := ObjectAppearanceClass[TAppearanceObject.Text];
  end;
  UpdateListbox;
end;

function TDynAppearanceCollectionEditor.CanAdd(Index: Integer): Boolean;
begin
  Result := True;
end;

{ TAppearanceObjectsPropertyEditor }

type
  TOpenPersistent = class(TPersistent);

procedure TAppearanceObjectsPropertyEditor.Edit;
begin
  ShowCollectionEditorClass(Designer, TDynAppearanceCollectionEditor,
    TOpenPersistent(GetComponent(0)).GetOwner as TComponent, TCollection(GetOrdValue), GetName);
end;

function TAppearanceObjectsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [TPropertyAttribute.paDialog, TPropertyAttribute.paReadOnly];
end;

{ TListViewObjectsPropertyDynamicEditor }

procedure TListViewObjectsPropertyDynamicEditor.FilterProperties(const ASelection: IDesignerSelections;
  const ASelectionProperties: IInterfaceList);
var
  Item: TAppearanceObjectItem;
  DynProperty: TAppearanceObjectSynthProperty;
  I: Integer;
  Properties: TListViewObjectsProperties;
begin
  if ASelection.Count <> 1 then
    Exit;

  if ASelection[0] is TListViewObjectsProperties then
  begin
    Properties := TListViewObjectsProperties(ASelection[0]);
    if SameText(Properties.Appearance, TDynamicAppearance.ClassName.Substring(1)) then
    begin
      // add Objects: TAppearanceObjectItemCollection
      ASelectionProperties.Add(TAppearanceObjectItemCollectionProperty.Create(Designer, Properties));

      // Actual appearance objects
      for I := 0 to Properties.Objects.Count - 1 do
      begin
        Item := TAppearanceObjectItem(Properties.Objects.Items[I]);
        DynProperty := TAppearanceObjectSynthProperty.Create(Designer, Item, Properties.Objects);
        ASelectionProperties.Add(DynProperty);
      end;

      ASelectionProperties.Add(TAppearanceObjectSynthProperty.Create(Designer, nil, Properties.Objects));
    end;
  end;
end;

{ TAppearanceObjectClassPropertyEditor }

function TAppearanceObjectClassPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [TPropertyAttribute.paValueList];//[paValueList, paSortList, paMultiSelect];
end;

procedure TAppearanceObjectClassPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: TAppearanceObject;
begin
  for I := Low(TAppearanceObject) to High(TAppearanceObject) do
    Proc(ObjectAppearanceClass[I]);
end;

procedure TAppearanceObjectClassPropertyEditor.SetValue(const Value: string);
begin
  inherited;
end;

{ TDynamicProperty }

constructor TAppearanceObjectSynthProperty.Create(const ADesigner: IDesigner; const Item: TAppearanceObjectItem;
  const Collection: TCollection);
begin
  inherited Create(ADesigner, 1);
  FItem := Item;
  FCollection := Collection;
end;

destructor TAppearanceObjectSynthProperty.Destroy;
begin
  FDropDown.Free;
  inherited;
end;

function TAppearanceObjectSynthProperty.DropDownCreate(const Host: IPropertyHost): TVclListView;
var
  Host20: IPropertyHost20;
begin
  Result := TVclListView.Create(nil);
  if Supports(Host, IPropertyHost20, Host20) then
    Result.Width := Host20.GetDropDownWidth;
  Result.OnSelectItem := DropDownSelect;
  Result.Visible := True;
  Result.BorderStyle := TFormBorderStyle.bsNone;
  Result.Columns.Add.Width := Host20.GetDropDownWidth;
  Result.ReadOnly := True;
  Result.RowSelect := True;
  Result.ShowColumnHeaders := False;
  Result.ViewStyle := TViewStyle.vsReport;
  Result.OnEnter := DropDownEnter;
end;

function TAppearanceObjectSynthProperty.DropDownCreateDelete(const Host: IPropertyHost): TVclListView;
begin
  Result := DropDownCreate(Host);
  Result.OnEnter := DropDownEnterDelete;
end;

procedure TAppearanceObjectSynthProperty.DropDownEnter(Sender: TObject);
var
  I: TAppearanceObject;
begin
  for I := Low(TAppearanceObject) to High(TAppearanceObject) do
    FDropDown.AddItem(ObjectAppearanceClass[I], nil);
end;

procedure TAppearanceObjectSynthProperty.DropDownEnterDelete(Sender: TObject);
begin
  FDropDown.AddItem(SDeleteAppearanceObject, nil);
end;

procedure TAppearanceObjectSynthProperty.DropDownSelect(Sender: TObject; Item: Vcl.ComCtrls.TListItem; Selected: Boolean);
var
  Selections: IDesignerSelections;
begin
  if FItem <> nil then
  begin
    // can only be delete
    FCollection.BeginUpdate;
    try
      Designer.ClearSelection;
      FCollection.Delete(FItem.Index);

      Selections := TDesignerSelections.Create;
      Selections.Add(FCollection);
      Designer.SelectComponent(Selections.DesignObjects[0]);
      Designer.Modified;
    finally
      FCollection.EndUpdate;
    end;
  end
  else
    CreateNewObject(TAppearanceObject(Item.Index));
  FHost.CloseDropDown;
end;

procedure TAppearanceObjectSynthProperty.CreateNewObject(const AAppearance: TAppearanceObject);
var
  Selections: IDesignerSelections;
begin
  with TAppearanceObjectItem(FCollection.Add) do
  begin
    AppearanceObjectName := Format(ObjectAppearanceFormat[AAppearance], [Collection.Count]);
    AppearanceClassName := ObjectAppearanceClass[AAppearance];
  end;
  Selections := TDesignerSelections.Create;
  Designer.GetSelections(Selections);
  Designer.ClearSelection;
  if Selections.Count > 0 then
    Designer.SelectComponent(Selections.DesignObjects[0]);
  Designer.Modified;
end;

procedure TAppearanceObjectSynthProperty.Edit(const Host: IPropertyHost; DblClick: Boolean);
begin
  FHost := Host;
  if FItem = nil then
  begin
    if DblClick then
      CreateNewObject(TAppearanceObject.Text)
    else
    begin
      if FDropDown <> nil then
        FDropDown.Free;
      FDropDown := DropDownCreate(Host);
      Host.DropDownControl(FDropDown);
    end;
  end
  else
  begin
    if FDropDown <> nil then
      FDropDown.Free;
    FDropDown := DropDownCreateDelete(Host);
    Host.DropDownControl(FDropDown);
  end;
end;

function TAppearanceObjectSynthProperty.GetAttributes: TPropertyAttributes;
begin
  if FItem <> nil then
    Result := [TPropertyAttribute.paNotNestable, TPropertyAttribute.paVolatileSubProperties,
      TPropertyAttribute.paSubProperties, TPropertyAttribute.paReadOnly, TPropertyAttribute.paCustomDropDown]
  else
    Result := [TPropertyAttribute.paCustomDropDown];
end;

function TAppearanceObjectSynthProperty.GetName: string;
begin
  if FItem = nil then
    Result := '+'
  else
    Result := FItem.AppearanceObjectName;
end;

procedure TAppearanceObjectSynthProperty.GetProperties(Proc: TGetPropProc);
var
  Components: IDesignerSelections;
begin
  Components := TDesignerSelections.Create;
  Components.Add(FItem);
  GetComponentProperties(Components, tkProperties, Designer, Proc);
end;

function TAppearanceObjectSynthProperty.GetValue: string;
begin
  if FItem = nil then
    Result := SAddNewAppearanceObject
  else
    Result := FItem.AppearanceClassName;
end;

{ TAppearanceObjectItemCollectionProperty }

constructor TAppearanceObjectItemCollectionProperty.Create(const ADesigner: IDesigner;
  const Host: TListViewObjectsProperties);
begin
  inherited Create(ADesigner, 1);
  FObjectsProperties := Host;
end;

procedure TAppearanceObjectItemCollectionProperty.Edit(const Host: IPropertyHost; DblClick: Boolean);
begin
  ShowCollectionEditorClass(Designer, TDynAppearanceCollectionEditor,
    TOpenPersistent(FObjectsProperties).GetOwner as TComponent, FObjectsProperties.Objects, GetName);
end;

function TAppearanceObjectItemCollectionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [TPropertyAttribute.paNotNestable, TPropertyAttribute.paVolatileSubProperties,
    TPropertyAttribute.paSubProperties, TPropertyAttribute.paReadOnly, TPropertyAttribute.paDialog];
end;

function TAppearanceObjectItemCollectionProperty.GetName: string;
begin
  Result := 'Objects';
end;

procedure TAppearanceObjectItemCollectionProperty.GetProperties(Proc: TGetPropProc);
var
  Components: IDesignerSelections;
begin
  Components := TDesignerSelections.Create;
  Components.Add(FObjectsProperties.Objects);
  GetComponentProperties(Components, tkProperties, Designer, Proc);
end;

function TAppearanceObjectItemCollectionProperty.GetValue: string;
begin
  Result := Format('(%s)', [FObjectsProperties.ClassName]);
end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TAppearanceObjectItemCollection), nil, '', TAppearanceObjectsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TListViewObjectsProperties, 'Appearance', TListViewAppearanceNamePropertyEditor);
  // AppearanceClassName can be changed when object is selected in the Collection Editor
  RegisterPropertyEditor(TypeInfo(string), TAppearanceObjectItem, 'AppearanceClassName', TAppearanceObjectClassPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TPublishedAppearance, 'ItemAppearance', TListViewAppearanceNamePropertyEditor); // drop down list
  RegisterPropertyEditor(TypeInfo(string), TPublishedAppearance, 'HeaderAppearance', TListViewHeaderAppearanceNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TPublishedAppearance, 'FooterAppearance', TListViewFooterAppearanceNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TPublishedAppearance, 'ItemEditAppearance', TListViewItemEditAppearanceNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(TItemAppearanceObjects), TPublishedObjects, 'ItemObjects', TListViewObjectsProperty); // volatile properties
  RegisterPropertyEditor(TypeInfo(TItemAppearanceObjects), TPublishedObjects, 'HeaderObjects', TListViewObjectsProperty);
  RegisterPropertyEditor(TypeInfo(TItemAppearanceObjects), TPublishedObjects, 'FooterObjects', TListViewObjectsProperty);
  RegisterPropertyEditor(TypeInfo(TItemAppearanceObjects), TPublishedObjects, 'ItemEditObjects', TListViewObjectsProperty);
  RegisterSelectionEditor(TCustomListView, TListViewSelectionEditor);  // Add units
  RegisterSelectionEditor(TListView, TListViewItemAppearancePropertiesEditor);  // filter properties

  RegisterSprigType(TListView, TListViewSprig);  // structure view
  RegisterSelectionEditor(TListView, TListViewEditModeSelectionEditor);
  RegisterSelectionEditor(TPublishedAppearance, TListViewEditModeSelectionEditor);
  RegisterSelectionEditor(TListViewObjectsProperties, TListViewEditModeSelectionEditor);
  // Dynamic appearance editor
  RegisterSelectionEditor(TListViewObjectsProperties, TListViewObjectsPropertyDynamicEditor);
end;


end.
