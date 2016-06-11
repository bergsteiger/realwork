{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit FMX.ListView.DynamicAppearance;

interface

uses
  System.Rtti, System.Generics.Collections, System.Classes, System.TypInfo, System.SysUtils, FMX.Types, FMX.Controls,
  FMX.StdCtrls, FMX.ListView.Types, FMX.ListView.Appearances;

type
  TDynamicAppearance = class;

  /// <summary>
  /// TAppearanceObjectItem is an item in TAppearanceObjectItemCollection with
  /// AppearanceObjectName, AppearanceObjectClassName and the object itself (Appearance).
  /// </summary>
  TAppearanceObjectItem = class(TCollectionItem)
  private const
    FObjectAppearanceClassNames: array [0..4] of TClass = (TTextObjectAppearance, TImageObjectAppearance,
      TTextButtonObjectAppearance, TGlyphButtonObjectAppearance, TAccessoryObjectAppearance);
  private
    [Weak] FOwner: TDynamicAppearance;
    FAppearance: TCommonObjectAppearance;
    FAppearanceClass: TClass;
    FObjectName: string;
    procedure SetAppearanceClass(Value: TClass);
    procedure SetAppearance(Value: TCommonObjectAppearance);

    function GetObjectName: string;
    procedure SetObjectName(Value: string);

    function GetClassName: string;
    procedure SetClassName(Value: string);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    ///<summary>Name of this appearance object, e.g. 'text'</summary>
    property AppearanceObjectName: string read GetObjectName write SetObjectName nodefault;
    ///<summary>Class name of this appearance object, e.g. TTextObjectAppearance</summary>
    property AppearanceClassName: string read GetClassName write SetClassName nodefault;
    ///<summary>Object appearance itself</summary>
    property Appearance: TCommonObjectAppearance read FAppearance write SetAppearance;
  end;

  ///<summary>Collection of Items representing Appearance Objects that comprise a dynamic appearance.</summary>
  TAppearanceObjectItemCollection = class(TOwnedCollection)
  private
    [Weak] FDynamicAppearance: TDynamicAppearance;
  protected
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    { Design }
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    ///<summary>Create new TAppearanceObjectItemCollection for specified DynamicAppearance</summary>
    constructor Create(Owner: TComponent; DynamicAppearance: TDynamicAppearance); reintroduce;
  end;

  ///<summary>User-defined, designable ListView Item appearance. This class is one of the items
  ///that can be selected in the Object Inspector as an item appearance for Header, Item and Footer.
  ///
  ///Unlike static appearances, the objects in this one are stored in a collection. The collection can be
  ///filled with any combination of objects, which can then be edited in the designer to create fully
  ///customized item look.</summary>
  TDynamicAppearance = class(TPresetItemObjects)
  strict private
    FObjectsCollection: TCollection;
  protected
    function GetGroupClass: TPresetItemObjects.TGroupClass; override;

    function GetObjectsCollection: TCollection;
    procedure SetObjectsCollection(Value: TCollection);

    ///<summary>Create new Object Apperance specified by AppearanceClass and Name and initialize Item.Appearance
    ///with it.</summary>
    procedure CreateObjectAppearance(const AppearanceClass: TClass; const Name: string; const Item: TAppearanceObjectItem);
    ///<summary>Initialize DataMember for given ObjectAppearance. The expression is Data[ObjectAppearance.Name].</summary>
    procedure InitDataMember(const ObjectAppearance: TCommonObjectAppearance);
    ///<summary>Invoked when an appearance object is modified</summary>
    procedure ObjectPropertyChange(Sender: TObject);
    ///<summary>Invoked when an appearance object is renamed</summary>
    procedure ObjectRenamed(const Sender: TCommonObjectAppearance; const OldName: string);
    ///<summary>Propagate change notification up. Used by ObjectRemoving, ObjectAdded.</summary>
    procedure ItemAppearanceChange;
    ///<summary>Called when item is removed from the ObjectsCollection</summary>
    procedure ObjectRemoving(const Value: TCommonObjectAppearance);
    ///<summary>Called when item is added to the ObjectsCollection</summary>
    procedure ObjectAdded(const Value: TCommonObjectAppearance);
  public
    constructor Create(const Owner: TControl); override;
    destructor Destroy; override;
  published
    ///<summary>Collection of Object Appearances that comprise this Item Appearance</summary>
    property ObjectsCollection: TCollection read GetObjectsCollection write SetObjectsCollection;
  end;

implementation

constructor TDynamicAppearance.Create(const Owner: TControl);
begin
  inherited Create(Owner);
  FObjectsCollection := TAppearanceObjectItemCollection.Create(Owner, Self);

  // Add default text object, unless
  if (Owner = nil) or ([csLoading,csReading] * Owner.ComponentState = []) then
    CreateObjectAppearance(TTextObjectAppearance, TListViewItem.TMemberNames.Text + '1',
      TAppearanceObjectItem(FObjectsCollection.Add));
end;

destructor TDynamicAppearance.Destroy;
begin
  FObjectsCollection.Free;
  inherited;
end;

procedure TDynamicAppearance.ItemAppearanceChange;
begin
  if (OwnerControl <> nil) and not (csDestroying in OwnerControl.ComponentState) then
    (OwnerControl as IPublishedAppearanceOwner).ItemAppearanceChangeObjects(nil);
end;

procedure TDynamicAppearance.InitDataMember(const ObjectAppearance: TCommonObjectAppearance);
begin
  // Define livebindings data members
  ObjectAppearance.DataMembers :=
    TObjectAppearance.TDataMembers.Create(
      TObjectAppearance.TDataMember.Create(
        ObjectAppearance.Name,
        Format('Data["%s"]', [ObjectAppearance.Name])));
end;

procedure TDynamicAppearance.CreateObjectAppearance(const AppearanceClass: TClass; const Name: string; const Item: TAppearanceObjectItem);
var
  ObjectAppearance: TCommonObjectAppearance;
  OldAppearance: TCommonObjectAppearance;
begin
  ObjectAppearance := TCommonObjectAppearance(AppearanceClass.NewInstance);
  ObjectAppearance.Create;
  ObjectAppearance.Name := Name;
  ObjectAppearance.Owner := Self;
  ObjectAppearance.DefaultValues.Visible := True;
  ObjectAppearance.RestoreDefaults;
  ObjectAppearance.OnChange := ObjectPropertyChange;
  InitDataMember(ObjectAppearance);
  Item.Appearance := ObjectAppearance;

  OldAppearance := UpdateObject(ObjectAppearance, True);
  OldAppearance.Free;
end;

procedure TDynamicAppearance.ObjectPropertyChange(Sender: TObject);
begin
  DoChange;
end;

procedure TDynamicAppearance.ObjectRemoving(const Value: TCommonObjectAppearance);
begin
  RemoveObject(Value);
  ItemAppearanceChange;
end;

procedure TDynamicAppearance.ObjectRenamed(const Sender: TCommonObjectAppearance; const OldName: string);
begin
  ItemAppearanceChange;
end;

procedure TDynamicAppearance.ObjectAdded(const Value: TCommonObjectAppearance);
begin
  ItemAppearanceChange;
end;


function TDynamicAppearance.GetGroupClass: TPresetItemObjects.TGroupClass;
begin
  Result := TDynamicAppearance;
end;

function TDynamicAppearance.GetObjectsCollection: TCollection;
begin
  Result := FObjectsCollection;
end;

procedure TDynamicAppearance.SetObjectsCollection(Value: TCollection);
begin
  if FObjectsCollection = nil then
    FObjectsCollection := TCollection.Create(TAppearanceObjectItem);
  FObjectsCollection.Clear;
  FObjectsCollection.Assign(Value);
end;

type
  TOption = TRegisterAppearanceOption;
const
  sThisUnit = 'FMX.ListView.DynamicAppearance';     // Will be added to the uses list when appearance is used

{ TCommonObjectAppearanceItem }

procedure TAppearanceObjectItem.Assign(Source: TPersistent);
begin
  if Source.ClassType = FAppearanceClass then
    FAppearance.Assign(Source)
  else
    inherited;
end;

constructor TAppearanceObjectItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TAppearanceObjectItem.Destroy;
begin
  FAppearance.Free;
  inherited;
end;

procedure TAppearanceObjectItem.SetAppearance(Value: TCommonObjectAppearance);
begin
  FAppearanceClass := Value.ClassType;
  FObjectName := Value.Name;
  FAppearance := Value;
end;

procedure TAppearanceObjectItem.SetAppearanceClass(Value: TClass);
begin
  FAppearanceClass := Value;
  FOwner.CreateObjectAppearance(Value, FObjectName, Self);
  FOwner.ObjectAdded(FAppearance);
end;

procedure TAppearanceObjectItem.SetClassName(Value: string);
var
  R: TClass;
begin
  for R in FObjectAppearanceClassNames do
    if R.ClassNameIs(Value) then
    begin
      SetAppearanceClass(R);
      Exit;
    end;
  Assert(False);
end;

function TAppearanceObjectItem.GetClassName: string;
begin
  Result := FAppearance.ClassName;
end;

function TAppearanceObjectItem.GetObjectName: string;
begin
  Result := FObjectName;
end;

procedure TAppearanceObjectItem.SetObjectName(Value: string);
var
  OldName: string;
begin
  OldName := FObjectName;
  FObjectName := Value;
  if FAppearance <> nil then
  begin
    FAppearance.Name := Value;
    FOwner.InitDataMember(FAppearance);
  end;
  if FOwner <> nil then
    FOwner.ObjectRenamed(FAppearance, OldName);
end;

{ TItemCollection }

constructor TAppearanceObjectItemCollection.Create(Owner: TComponent; DynamicAppearance: TDynamicAppearance);
begin
  inherited Create(Owner, TAppearanceObjectItem);
  FDynamicAppearance := DynamicAppearance;
end;

function TAppearanceObjectItemCollection.GetAttrCount: Integer;
begin
  Result := 2;
end;

function TAppearanceObjectItemCollection.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := 'Name';
    1: Result := 'ObjectClass';
  end;
end;

function TAppearanceObjectItemCollection.GetItemAttr(Index, ItemIndex: Integer): string;
var
  Item: TAppearanceObjectItem;
begin
  if ItemIndex < Count then
  begin
    Item := TAppearanceObjectItem(Items[ItemIndex]);
    case Index of
      0: Result := Item.AppearanceObjectName;
      1: Result := Item.AppearanceClassName;
    end;
  end;
end;

procedure TAppearanceObjectItemCollection.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  inherited;
  if Action = TCollectionNotification.cnAdded then
  begin
    TAppearanceObjectItem(Item).FOwner := FDynamicAppearance;
    FDynamicAppearance.ObjectAdded(TAppearanceObjectItem(Item).Appearance);
  end
  else if Action = TCollectionNotification.cnExtracting then
    TAppearanceObjectItem(Item).FOwner.ObjectRemoving(TAppearanceObjectItem(Item).Appearance);
end;

initialization
  TAppearancesRegistry.RegisterAppearance(
    TDynamicAppearance, 'DynamicAppearance',
    [TRegisterAppearanceOption.Item, TRegisterAppearanceOption.ItemEdit]);
finalization
  TAppearancesRegistry.UnregisterAppearances(
    TArray<TItemAppearanceObjectsClass>.Create(
      TDynamicAppearance));
end.

