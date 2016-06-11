{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ListView.Adapters.Base;

{$SCOPEDENUMS ON}

interface

uses
  System.Classes, System.Generics.Collections, System.SysUtils, System.Generics.Defaults, System.Rtti,
  FMX.Types, FMX.ListView.Types, FMX.Graphics, System.Types, FMX.TextLayout,
  System.UITypes, FMX.Controls;

type
  TAbstractListViewAdapter = class abstract (TInterfacedPersistent)
  strict private
    FOnChanged: TNotifyEvent;
    FOnItemsMayChange: TNotifyEvent;
    FOnItemsCouldHaveChanged: TNotifyEvent;
    FOnItemsInvalidate: TNotifyEvent;
    FOnItemsResize: TNotifyEvent;
    FOnResetView: TNotifyEvent;
  strict protected
    procedure CreateNewViews;
    procedure DoCreateNewViews; virtual;

    procedure ResetViews(const APurposes: TListItemPurposes);
    procedure DoResetViews(const APurposes: TListItemPurposes); virtual;

    procedure ResetView(const Item: TListItem);
    procedure DoResetView(const Item: TListItem); virtual;
    procedure DoSort(AComparer: IComparer<TListItem>); virtual;

    procedure SetOnChanged(const Value: TNotifyEvent);
    procedure SetOnItemsMayChange(const Value: TNotifyEvent);
    procedure SetOnItemsCouldHaveChanged(const Value: TNotifyEvent);
    procedure SetOnItemsInvalidate(const Value: TNotifyEvent);
    procedure SetOnItemsResize(const Value: TNotifyEvent);
    procedure SetOnResetView(const Value: TNotifyEvent);

  public
    procedure Changed;
    procedure ItemsMayChange;
    procedure ItemsCouldHaveChanged;
    procedure ItemsInvalidate;
    procedure ItemsResize;
    procedure Sort(AComparer: IComparer<TListItem>);
    property OnChanged: TNotifyEvent write SetOnChanged;
    property OnItemsMayChange: TNotifyEvent write SetOnItemsMayChange;
    property OnItemsCouldHaveChanged: TNotifyEvent write SetOnItemsCouldHaveChanged;
    /// notify the view that repaint is necessary
    property OnItemsInvalidate: TNotifyEvent write SetOnItemsInvalidate;
    /// notify the view that the sizes of items need recalculation
    property OnItemsResize: TNotifyEvent write SetOnItemsResize;
    property OnResetView: TNotifyEvent write SetOnResetView;
  end;

  /// <summary>Minimal concrete implementation of IListViewAdapter</summary>
  TListViewItems = class(TAbstractListViewAdapter, IListViewAdapter)
  public type
    TOrder = (FirstToLast, LastToFirst);
  strict private
    FActiveItems: TListItemsList;
    FOnNotify: TCollectionNotifyEvent<TListItem>;

    { IListViewAdapter }
    function GetDefaultViewHeight: Integer;
  strict protected
    function GetCount: Integer; virtual;
    function GetItem(const Index: Integer): TListItem; virtual;
    procedure ResetIndexes;
    procedure ObjectsNotify(Sender: TObject; const Item: TListItem; Action: TCollectionNotification);
    property ActiveItems: TListItemsList read FActiveItems write FActiveItems;
    procedure DoSort(AComparer: IComparer<TListItem>); override;

  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>Return index of AItem</summary>
    function IndexOf(const AItem: TListItem): Integer;
    /// <summary>Return TEnumerator&lt;TListItem&gt; of items in this adapter</summary>
    function GetEnumerator: TEnumerator<TListItem>;
    /// <summary>Access TListItem by Index</summary>
    property Item[const Index: Integer]: TListItem read GetItem; default;
    /// <summary>Count of items</summary>
    property Count: Integer read GetCount;
    /// <summary>Collection notify event, used internally</summary>
    property OnNotify: TCollectionNotifyEvent<TListItem> read FOnNotify write FOnNotify;
  end;

  /// <summary>Implementation of IListViewAdapter and IListViewFilterable</summary>
  TFilterableListViewItems = class(TListViewItems, IListViewFilterable)
  strict private
    FUnfilteredItems: TListItemsList;
    FFilteredItems: TListItemsList;
    FFilterPredicate: TFilterPredicate;

    procedure ItemsCleared;
    procedure ItemDeleted(const Index: Integer);
    procedure ItemAdded(const Index: Integer; const Item: TListItem);

    { IListViewFilterable }
    function GetFilterPredicate: TFilterPredicate;
    function GetUnfilteredItems: TListItemsList;
    procedure SetFilterPredicate(const Value: TFilterPredicate);
    function GetFiltered: Boolean;
    procedure ApplyFilter;
  strict protected
    /// <summary>Return True if item should be shown</summary>
    function DoFilterItem(const Item: TListItem): Boolean; virtual; abstract;
    /// <summary>Return unfiltered items. FFilteredItems by default.</summary>
    function DoGetUnfilteredItems: TListItemsList; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>Filter predicate</summary>
    property Filter: TFilterPredicate read GetFilterPredicate write SetFilterPredicate;
    /// <summary>A complete list of all items, regardless of state of Filtered</summary>
    property UnfilteredItems: TListItemsList read GetUnfilteredItems;
    ///<summary>Filtered is True if some items are not displayed</summary>
    property Filtered: Boolean read GetFiltered;
  end;


implementation

uses
  System.Math;


procedure TAbstractListViewAdapter.ResetViews(const APurposes: TListItemPurposes);
begin
  DoResetViews(APurposes);
end;

procedure TAbstractListViewAdapter.CreateNewViews;
begin
  DoCreateNewViews;
end;

procedure TAbstractListViewAdapter.DoCreateNewViews;
begin
end;

procedure TAbstractListViewAdapter.DoResetViews(const APurposes: TListItemPurposes);
begin
end;

procedure TAbstractListViewAdapter.DoSort(AComparer: IComparer<TListItem>);
begin
end;

procedure TAbstractListViewAdapter.ResetView(const Item: TListItem);
begin
  if Assigned(FOnResetView) then
    FOnResetView(Item);
  DoResetView(Item);
end;

procedure TAbstractListViewAdapter.DoResetView(const Item: TListItem);
begin
  //
end;

procedure TAbstractListViewAdapter.SetOnChanged(const Value: TNotifyEvent);
begin
  FOnChanged := Value;
end;

procedure TAbstractListViewAdapter.SetOnItemsCouldHaveChanged(const Value: TNotifyEvent);
begin
  FOnItemsCouldHaveChanged := Value;
end;

procedure TAbstractListViewAdapter.SetOnItemsMayChange(const Value: TNotifyEvent);
begin
  FOnItemsMayChange := Value;
end;

procedure TAbstractListViewAdapter.SetOnItemsResize(const Value: TNotifyEvent);
begin
  FOnItemsResize := Value;
end;

procedure TAbstractListViewAdapter.SetOnItemsInvalidate(const Value: TNotifyEvent);
begin
  FOnItemsInvalidate := Value;
end;

procedure TAbstractListViewAdapter.SetOnResetView(const Value: TNotifyEvent);
begin
  FOnResetView := Value;
end;

procedure TAbstractListViewAdapter.Sort(AComparer: IComparer<TListItem>);
begin
  DoSort(AComparer);
end;

procedure TAbstractListViewAdapter.Changed;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TAbstractListViewAdapter.ItemsMayChange;
begin
  if Assigned(FOnItemsMayChange) then
    FOnItemsMayChange(Self);
end;

procedure TAbstractListViewAdapter.ItemsCouldHaveChanged;
begin
  if Assigned(FOnItemsCouldHaveChanged) then
    FOnItemsCouldHaveChanged(Self);
end;

procedure TAbstractListViewAdapter.ItemsResize;
begin
  if Assigned(FOnItemsResize) then
    FOnItemsResize(Self);
end;

procedure TAbstractListViewAdapter.ItemsInvalidate;
begin
  if Assigned(FOnItemsInvalidate) then
    FOnItemsInvalidate(Self);
end;


{$REGION 'TListViewItems'}

constructor TListViewItems.Create;
begin
  inherited Create;
end;

destructor TListViewItems.Destroy;
begin
  inherited;
  FActiveItems := nil;
end;

procedure TListViewItems.ObjectsNotify(Sender: TObject; const Item: TListItem; Action: TCollectionNotification);
begin
  if Assigned(FOnNotify) then
    FOnNotify(Sender, Item, Action);
end;

function TListViewItems.IndexOf(const AItem: TListItem): Integer;
begin
  Result := FActiveItems.IndexOf(AItem);
end;

procedure TListViewItems.ResetIndexes;
var
  I: Integer;
begin
  for I := 0 to FActiveItems.Count - 1 do
    FActiveItems[I].Index := I;
end;

function TListViewItems.GetCount: Integer;
begin
  Result := FActiveItems.Count;
end;

function TListViewItems.GetDefaultViewHeight: Integer;
begin
  Result := 42;
end;

function TListViewItems.GetEnumerator: TEnumerator<TListItem>;
begin
  Result := FActiveItems.GetEnumerator
end;

function TListViewItems.GetItem(const Index: Integer): TListItem;
begin
  if Index < FActiveItems.Count then
    Result := FActiveItems[Index]
  else
    Result := nil;
end;

procedure TListViewItems.DoSort(AComparer: IComparer<TListItem>);
begin
  inherited;
  ItemsMayChange;
  FActiveItems.Sort(AComparer);
  ResetIndexes;
  ItemsCouldHaveChanged;
  Changed;
end;

{$ENDREGION}

{$REGION 'TFilterableListViewItems'}

{ TFilterableListViewItems }

constructor TFilterableListViewItems.Create;
begin
  inherited Create;
  FUnfilteredItems := TObjectList<TListItem>.Create;
  FUnfilteredItems.OnNotify := ObjectsNotify;
  ActiveItems := FUnfilteredItems;
end;

destructor TFilterableListViewItems.Destroy;
begin
  if FFilteredItems <> nil then
  begin
    FFilteredItems.OnNotify := nil;
    FFilteredItems.Free;
  end;
  FUnfilteredItems.OnNotify := nil;
  FUnfilteredItems.Free;
  inherited;
end;

function TFilterableListViewItems.DoGetUnfilteredItems: TListItemsList;
begin
  Result := FUnfilteredItems;
end;

function TFilterableListViewItems.GetUnfilteredItems: TListItemsList;
begin
  Result := DoGetUnfilteredItems;
end;

function TFilterableListViewItems.GetFiltered: Boolean;
begin
  Result := (FFilteredItems <> nil) and (FFilteredItems.Count <> FUnfilteredItems.Count);
end;

function TFilterableListViewItems.GetFilterPredicate: TFilterPredicate;
begin
  Result := FFilterPredicate;
end;

procedure TFilterableListViewItems.SetFilterPredicate(const Value: TFilterPredicate);
begin
  ItemsMayChange;
  try
    FFilterPredicate := Value;
    ApplyFilter;

    if FFilteredItems <> nil then
      ActiveItems := FFilteredItems
    else
      ActiveItems := FUnfilteredItems;

    ResetIndexes;
  finally
    ItemsCouldHaveChanged;
  end;
end;

procedure TFilterableListViewItems.ApplyFilter;
var
  Item: TListItem;
  HeaderIndex, FooterIndex, SectionSize: Integer;
begin
  if not Assigned(FFilterPredicate) then
  begin
    if FFilteredItems <> nil then
    begin
      ActiveItems := FUnfilteredItems;
      FFilteredItems.OnNotify := nil;
      FreeAndNil(FFilteredItems);
    end;
  end
  else
  begin
    if FFilteredItems = nil then
    begin
      FFilteredItems := TObjectList<TListItem>.Create(False);
      FFilteredItems.OnNotify := OnNotify;
    end
    else
      FFilteredItems.Clear;

    HeaderIndex := -1;
    FooterIndex := -1;
    SectionSize := 0;
    for Item in FUnfilteredItems do
    begin
      if Item.Purpose =  TListItemPurpose.Header then
      begin
        if SectionSize = 0 then
        begin
          if FooterIndex <> -1 then
            FFilteredItems.Delete(FooterIndex);
          if HeaderIndex <> -1 then
            FFilteredItems.Delete(HeaderIndex);
        end;

        FFilteredItems.Add(Item);
        HeaderIndex := FFilteredItems.Count - 1;
        FooterIndex := -1;
        SectionSize := 0;
      end
      else if Item.Purpose = TListItemPurpose.Footer then
      begin
        FFilteredItems.Add(Item);
        FooterIndex := FFilteredItems.Count - 1;
        if FooterIndex < HeaderIndex then
        begin
          FooterIndex := HeaderIndex;
          HeaderIndex := FFilteredItems.Count - 1;
        end;
      end
      else if DoFilterItem(Item) then
      begin
        FFilteredItems.Add(Item);
        Inc(SectionSize);
      end;
    end;

    if SectionSize = 0 then
    begin
      if FooterIndex <> -1 then
        FFilteredItems.Delete(FooterIndex);
      if HeaderIndex <> -1 then
        FFilteredItems.Delete(HeaderIndex);
    end;
  end;
end;

procedure TFilterableListViewItems.ItemAdded(const Index: Integer; const Item: TListItem);
var
  LastIndex: Integer;
begin
  if Index < 0 then
  begin
    if FUnfilteredItems.Count > 0 then
    begin
      LastIndex := FUnfilteredItems.Last.Index;
      if LastIndex > -1 then
        Item.Index := LastIndex + 1;
    end
    else
      Item.Index := 0;
    FUnfilteredItems.Add(Item)
  end
  else
    FUnfilteredItems.Insert(Index, Item);
  if FFilteredItems <> nil then
    ApplyFilter;
end;

procedure TFilterableListViewItems.ItemDeleted(const Index: Integer);
var
  LItem: TListItem;
begin
  if ActiveItems = FFilteredItems then
  begin
    LItem := ActiveItems[Index];
    FFilteredItems.Delete(Index);
    FUnfilteredItems.Remove(LItem); // Free the item
  end
  else
  begin
    FUnfilteredItems.Delete(Index); // Free the item
    FreeAndNil(FFilteredItems);
  end;
end;

procedure TFilterableListViewItems.ItemsCleared;
begin
  if FFilteredItems <> nil then
    FFilteredItems.Clear;
  FUnfilteredItems.Clear;
end;

{$ENDREGION}

end.
