{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ListView.iOS;

interface

implementation

uses
  Macapi.ObjectiveC, Macapi.ObjCRuntime, iOSapi.Foundation, iOSapi.CocoaTypes, iOSapi.UIKit, iOSapi.CoreGraphics,
  System.SysUtils, System.Generics.Collections, System.Types, System.TypInfo, System.Math, Macapi.Helpers, FMX.Types,
  FMX.Platform, FMX.Graphics, FMX.Forms, FMX.ListView.Types, FMX.Platform.iOS, FMX.Helpers.iOS, FMX.Controls,
  FMX.ZOrder.iOS, FMX.ImgList, System.UITypes;

type
  UITableViewDataSource = interface(IObjectiveC)
    ['{B0E27566-79D5-4D8F-8082-063D04D710F7}']

    [MethodName('numberOfSectionsInTableView:')]
    function tableViewNumberOfSectionsInTableView(tableView: UITableView): NSInteger; cdecl;

    [MethodName('tableView:numberOfRowsInSection:')]
    function tableViewNumberOfRowsInSection(tableView: UITableView; section: NSInteger): NSInteger; cdecl;

    [MethodName('tableView:cellForRowAtIndexPath:')]
    function tableViewCellForRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath): UITableViewCell; cdecl;

    [MethodName('tableView:canEditRowAtIndexPath:')]
    function tableViewCanEditRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath): Boolean; cdecl;

    [MethodName('tableView:commitEditingStyle:forRowAtIndexPath:')]
    procedure tableViewCommitEditingStyleForRowAtIndexPath(tableView: UITableView;
      commitEditingStyle: UITableViewCellEditingStyle; forRowAtIndexPath: NSIndexPath); cdecl;

    [MethodName('tableView:titleForHeaderInSection:')]
    function tableViewTitleForHeaderInSection(tableView: UITableView;
      titleForHeaderInSection: NSInteger): NSString; cdecl;

    [MethodName('sectionIndexTitlesForTableView:')]
    function sectionIndexTitlesForTableView(tableView: UITableView): NSArray; cdecl;
  end;

  ITableViewDataSourceClick = interface(IObjectiveC)
    ['{F4E94236-947F-4E37-BD83-FD1C62D9238A}']
    procedure ButtonClicked(sender: Pointer); cdecl;
  end;

  TCellFiller = class;
  TListViewPresentation = class;
  TCustomUITableCell = class;

  TTableViewDataSource = class(TOCLocal, UITableViewDataSource, ITableViewDataSourceClick)
  protected type
    TSection = class
    private
      FSectionIndex: Integer;
      FItemIndex: Integer;
      FFellowIndices: TList<Integer>;
    public
      constructor Create(const ASectionIndex, AItemIndex: Integer);
      destructor Destroy; override;
      property SectionIndex: Integer read FSectionIndex;
      property ItemIndex: Integer read FItemIndex;
      property FellowIndices: TList<Integer> read FFellowIndices;
    end;
    TSections = TObjectList<TSection>;
    TSectionedIndex = record
      Section: Integer;
      Row: Integer;
      constructor Create(const ASection, ARow: Integer);
    end;
    TSectionedIndices = TDictionary<Integer, TSectionedIndex>;
  private const
    ReusableCellID = 'TListView~Cell';
  private
    [Weak] FParent: IListViewPresentationParent;
    FSections: TSections;
    FSectionsUpdateNeeded: Boolean;
    FSectionedIndices: TSectionedIndices;
    FCellFiller: TCellFiller;
    FScale: Single;
    [Weak] FPresentation: TListViewPresentation;
    FReloadNeeded: Boolean;
    FReusableCellId: NSString;
    FCellLeash: TList<TCustomUITableCell>;
    FButtonMap: TDictionary<NativeUInt, Integer>;
    FItemToContent: TDictionary<Integer, Pointer>;
    procedure UpdateSections;
  protected
    procedure SectionsUpdateNeeded;
    property Sections: TSections read FSections;
    property SectionedIndices: TSectionedIndices read FSectionedIndices;
  public
    constructor Create(const AParent: IListViewPresentationParent);
    destructor Destroy; override;

    [MethodName('numberOfSectionsInTableView:')]
    function tableViewNumberOfSectionsInTableView(tableView: UITableView): NSInteger; cdecl;

    [MethodName('tableView:numberOfRowsInSection:')]
    function tableViewNumberOfRowsInSection(tableView: UITableView; section: NSInteger): NSInteger; cdecl;

    [MethodName('tableView:cellForRowAtIndexPath:')]
    function tableViewCellForRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath): UITableViewCell; cdecl;

    [MethodName('tableView:canEditRowAtIndexPath:')]
    function tableViewCanEditRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath): Boolean; cdecl;

    [MethodName('tableView:commitEditingStyle:forRowAtIndexPath:')]
    procedure tableViewCommitEditingStyleForRowAtIndexPath(tableView: UITableView;
      commitEditingStyle: UITableViewCellEditingStyle; forRowAtIndexPath: NSIndexPath); cdecl;

    [MethodName('tableView:titleForHeaderInSection:')]
    function tableViewTitleForHeaderInSection(tableView: UITableView;
      titleForHeaderInSection: NSInteger): NSString; cdecl;

    [MethodName('sectionIndexTitlesForTableView:')]
    function sectionIndexTitlesForTableView(tableView: UITableView): NSArray; cdecl;

    procedure ButtonClicked(sender: Pointer); cdecl;

    procedure PopulateView(const Index: Integer; const ContentView: UIView);
    procedure DoItemInvalidated(const Item: TListItem);
    procedure ViewDisappeared(const Index: Integer);
    procedure Reload;
    property ReloadNeeded: Boolean write FReloadNeeded;
    function GetLocalRect(const Item: TListItem; const Drawable: TListItemDrawable): TRect;
    function GetScale: Single;
  end;

  ICustomUITableViewCell = interface(UITableViewCell)
    ['{B8DE25BE-3824-452B-9FE2-A56E85C3300E}']
    procedure willTransitionToState(state: UITableViewCellStateMask); cdecl;
    procedure didTransitionToState(state: UITableViewCellStateMask); cdecl;
    procedure prepareForReuse; cdecl;
  end;

  ICustomUITableViewCellClass = interface(UITableViewCellClass)
    ['{D4931F68-E5B5-4017-A92D-C34FA8A38FFA}']
  end;

  TCustomUITableCell = class(TOCLocal)
  private
    [Weak] FPresentation: TListViewPresentation;
    procedure InitView(const ReusableID: NSString);
  public
    constructor Create(const ReusableID: NSString; const Presentation: TListViewPresentation);
    destructor Destroy; override;
    function GetObjectiveCClass: PTypeInfo; override;
    procedure willTransitionToState(state: UITableViewCellStateMask); cdecl;
    procedure didTransitionToState(state: UITableViewCellStateMask); cdecl;
    procedure prepareForReuse; cdecl;
  end;

  TCICustomUITableCell = class(TOCGenericImport<ICustomUITableViewCellClass, ICustomUITableViewCell>);

  UITableViewDelegate = interface(IObjectiveC)
    ['{4C0AFEA0-191F-4C5C-A087-63E7567790A9}']

    [MethodName('tableView:shouldHighlightRowAtIndexPath:')]
    function TableViewShouldHighlightRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath): Boolean; cdecl;

    [MethodName('tableView:willSelectRowAtIndexPath:')]
    function TableViewWillSelectRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath): NSIndexPath; cdecl;

    [MethodName('tableView:didSelectRowAtIndexPath:')]
    procedure TableViewDidSelectRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath); cdecl;

    [MethodName('tableView:willDeselectRowAtIndexPath:')]
    function TableViewWillDeselectRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath): NSIndexPath; cdecl;

    [MethodName('tableView:didDeselectRowAtIndexPath:')]
    procedure TableViewDidDeselectRowAtIndexPath(tableView: UITableView;
      indexPath: NSIndexPath); cdecl;

    [MethodName('tableView:heightForRowAtIndexPath:')]
    function tableViewHeightForRowAtIndexPath(tableView: UITableView;
      heightForRowAtIndexPath: NSIndexPath): CGFloat; cdecl;

    [MethodName('tableView:heightForHeaderInSection:')]
    function tableViewHeightForHeaderInSection(tableView: UITableView; heightForHeaderInSection: NSInteger)
      : CGFloat; cdecl;

    [MethodName('tableView:viewForHeaderInSection:')]
    function tableViewViewForHeaderInSection(tableView: UITableView; viewForHeaderInSection: NSInteger): UIView; cdecl;
  end;

  UIScrollViewDelegate = interface(IObjectiveC)
    ['{8C11887F-EE49-46A0-943E-6908DBCB88BE}']
    procedure scrollViewDidScroll(scrollView: UIScrollView); cdecl;
  end;

  TTableViewDelegate = class(TOCLocal, UITableViewDelegate, UIScrollViewDelegate)
  private const
    ReusableHeaderID = 'TListView~Header';
  private
    [Weak] FParent: TListViewPresentation;
    [Weak] FDataSource: TTableViewDataSource;
    FPresentationParent: IListViewPresentationParent;
    FReusableHeaderID: NSString;
  public
    constructor Create(const AParent: TListViewPresentation; const DataSource: TTableViewDataSource);
    destructor Destroy; override;

    [MethodName('tableView:shouldHighlightRowAtIndexPath:')]
    function TableViewShouldHighlightRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath): Boolean; cdecl;

    [MethodName('tableView:willSelectRowAtIndexPath:')]
    function TableViewWillSelectRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath): NSIndexPath; cdecl;

    [MethodName('tableView:willDeselectRowAtIndexPath:')]
    function TableViewWillDeselectRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath): NSIndexPath; cdecl;

    [MethodName('tableView:didSelectRowAtIndexPath:')]
    procedure TableViewDidSelectRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath); cdecl;

    [MethodName('tableView:didDeselectRowAtIndexPath:')]
    procedure TableViewDidDeselectRowAtIndexPath(tableView: UITableView;
      indexPath: NSIndexPath); cdecl;

    [MethodName('tableView:heightForRowAtIndexPath:')]
    function tableViewHeightForRowAtIndexPath(tableView: UITableView;
      heightForRowAtIndexPath: NSIndexPath): CGFloat; cdecl;

    [MethodName('tableView:heightForHeaderInSection:')]
    function tableViewHeightForHeaderInSection(tableView: UITableView; heightForHeaderInSection: NSInteger)
      : CGFloat; cdecl;

    procedure scrollViewDidScroll(scrollView: UIScrollView); cdecl;

    [MethodName('tableView:viewForHeaderInSection:')]
    function tableViewViewForHeaderInSection(tableView: UITableView; viewForHeaderInSection: NSInteger): UIView; cdecl;
  end;

  IRefreshDelegate = interface(IObjectiveC)
    ['{B7AA36DE-35B4-43D7-91CB-7695152BA4A3}']
    procedure RefreshData(sender: Pointer); cdecl;
  end;

  UISearchBarDelegate = interface(IObjectiveC)
    ['{1CAA727D-EF90-467E-9E7D-D79273BA334C}']
    [MethodName('searchBar:textDidChange:')]
    procedure searchBarTextDidChange(searchBar: UISearchBar; textDidChange: NSString); cdecl;
    procedure searchBarSearchButtonClicked(searchBar: UISearchBar); cdecl;
  end;

  TRefreshDelegate = class(TOCLocal, IRefreshDelegate)
  private
    [Weak] FParent: TListViewPresentation;
  public
    constructor Create(const AParent: TListViewPresentation);
    procedure RefreshData(sender: Pointer); cdecl;
  end;

  TUISearchBarDelegate = class(TOCLocal, UISearchBarDelegate)
  private
    [Weak] FParent: TListViewPresentation;
  public
    constructor Create(const AParent: TListViewPresentation);
    [MethodName('searchBar:textDidChange:')]
    procedure searchBarTextDidChange(searchBar: UISearchBar; textDidChange: NSString); cdecl;
    procedure searchBarSearchButtonClicked(searchBar: UISearchBar); cdecl;
  end;

  TListViewPresentation = class(TInterfacedObject, IListViewPresentation)
  private const
    DefaultSearchBarHeight = 44;
  private
    [Weak] FParent: IListViewPresentationParent;
    FTableView: UITableView;
    FMainView: UIView;
    FDataSource: TTableViewDataSource;
    FDelegate: TTableViewDelegate;
    FRefresh: UIRefreshControl;
    FRefreshDelegate: TRefreshDelegate;
    FSearchBar: UISearchBar;
    FSearchBarDelegate: TUISearchBarDelegate;
    FLoadingCell: Boolean;

    procedure SetItemSelected(const ItemIndex: Integer; const Value: Boolean);
    procedure SetItemIndex(const ItemIndex: Integer);
    procedure InvokePullRefresh;
    procedure SearchBarTextChanged;
    procedure ScrollViewPositionChanged;
    procedure FixOrderAndBounds;
    procedure StopPullRefresh;

  protected
    procedure AncestorVisibleChanged(const Visible: Boolean); virtual;
    procedure ParentChanged; virtual;
    procedure OrderChanged; virtual;
    procedure SizeChanged; virtual;
    procedure EditModeChanged; virtual;
    procedure StatusChanged; virtual;
    procedure ItemsUpdated; virtual;
    procedure ItemInvalidated(const Item: TListItem);
  public
    constructor Create(const AParent: IListViewPresentationParent);
    destructor Destroy; override;
    procedure ReloadData;
  end;

  TListViewPresentationService = class(TInterfacedObject, IFMXListViewPresentationService)
  public
    function AttachPresentation(const Parent: IInterface): IInterface;
    procedure DetachPresentation(const Parent: IInterface);
  end;

  TCellFiller = class
  public const
    TagBase = -1000;
  protected
    class var FColorSpace: CGColorSpaceRef;
  protected
    [Weak] FDataSource: TTableViewDataSource;
  private
    constructor Create(const DataSource: TTableViewDataSource);
    procedure SetCellText(const ALabel: UILabel; const TextDrawable: TListItemText);
    procedure SetButtonTitle(const Button: UIButton; const Title: NSString);
    procedure SetButtonText(const Button: UIButton; const ButtonDrawable: TListItemTextButton);

    procedure SetCellBitmap(const ImageView: UIImageView; const Bitmap: TBitmap; const BitmapRect: TRect;
      const ItemIndex: Integer);
    function GetUILabel(const ContentView: UIView; const Tag: Integer): UILabel;
    function GetUIImageView(const ContentView: UIView; const Tag: Integer): UIImageView;
    function GetUIButton(const ContentView: UIView; const Tag: Integer): UIButton;
    procedure CreateLabel(const ContentView: UIView; const Tag: Integer; const Item: TListItem; const Drawable: TListItemText);
    procedure CreateImageView(const ContentView: UIView; const Tag: Integer; const Item: TListItem;
      const Drawable: TListItemImage);
    procedure CreateAccessory(const Cell: UITableViewCell; const Tag: Integer; const Item: TListItem;
      const Drawable: TListItemAccessory);
    procedure CreateTextButton(const ContentView: UIView; const Tag: Integer; const Item: TListItem;
      const Drawable: TListItemTextButton; const Target: ILocalObject; ButtonMap: TDictionary<NativeUInt,Integer>);
    procedure CreateGlyphButton(const Cell: UITableViewCell; const Tag: Integer; const Item: TListItem;
      const Drawable: TListItemGlyphButton; const Target: ILocalObject);
    procedure CreateNativeView(const ContentView: UIView; const Tag: Integer; const Item: TListItem;
      const Drawable: TListItemDrawable; Target: ILocalObject; ButtonMap: TDictionary<NativeUInt,Integer>);
    procedure HideSubviews(const View: UIView);
  end;


constructor TTableViewDataSource.TSection.Create(const ASectionIndex, AItemIndex: Integer);
begin
  inherited Create;
  FSectionIndex := ASectionIndex;
  FItemIndex := AItemIndex;
  FFellowIndices := TList<Integer>.Create;
end;

destructor TTableViewDataSource.TSection.Destroy;
begin
  FFellowIndices.Free;
  inherited;
end;

constructor TTableViewDataSource.TSectionedIndex.Create(const ASection, ARow: Integer);
begin
  Section := ASection;
  Row := ARow;
end;

constructor TTableViewDataSource.Create(const AParent: IListViewPresentationParent);
begin
  inherited Create;

  FParent := AParent;
  FSections := TSections.Create;
  FSectionedIndices := TSectionedIndices.Create;
  FSectionsUpdateNeeded := True;
  FScale := 0;
  FCellFiller := TCellFiller.Create(Self);
  FReusableCellId := StrToNSStr(ReusableCellID);
  FReusableCellId.retain;
  FButtonMap := TDictionary<NativeUInt, Integer>.Create;
  FItemToContent := TDictionary<Integer, Pointer>.Create;
end;

destructor TTableViewDataSource.Destroy;
begin
  FSectionedIndices.Free;
  FSections.Free;
  FReusableCellId.release;
  FCellFiller.Free;
  if FCellLeash <> nil then
    FCellLeash.Clear;
  FCellLeash.Free;
  FButtonMap.Free;
  inherited;
end;


function TTableViewDataSource.GetLocalRect(const Item: TListItem; const Drawable: TListItemDrawable): TRect;
var
  BorderRect: TRectF;
begin
  BorderRect := FParent.GetItemClientRect(Item.Index);
  FScale := GetScale;
  Drawable.CalculateLocalRect(BorderRect, FScale, [], Item);
  Result := Drawable.LocalRect.Round;
end;

function TTableViewDataSource.GetScale: Single;
var
  Scene: IScene;
begin
  if (FScale = 0) and Supports(FParent.GetRootObject, IScene, Scene) then
    FScale := Scene.GetSceneScale
  else
    FScale := 1;
  Result := FScale;
end;

procedure TTableViewDataSource.PopulateView(const Index: Integer; const ContentView: UIView);
var
  I: Integer;
  Item: TListItem;
begin
  FPresentation.FLoadingCell := True;
  FPresentation.FParent.SetCreatingNativeView(True);
  try
    Item := FParent.GetAdapter[Index];
    Item.WillBePainted;
    FCellFiller.HideSubviews(ContentView);
    for I := 0 to Item.View.Count - 1 do
      FCellFiller.CreateNativeView(ContentView, TCellFiller.TagBase + I, Item, Item.View[I], Self as ILocalObject,
        FButtonMap);
  finally
    FPresentation.FLoadingCell := False;
    FPresentation.FParent.SetCreatingNativeView(False);
  end;
end;

procedure TTableViewDataSource.DoItemInvalidated(const Item: TListItem);
var
  Cell: Pointer;
  ContentView: UIView;
  I: Integer;
begin
  if FItemToContent.TryGetValue(Item.Index, Cell) then
  begin
    ContentView := TUITableViewCell.Wrap(Cell).contentView;
    Item.WillBePainted;
    FCellFiller.HideSubviews(ContentView);
    for I := 0 to Item.View.Count - 1 do
      FCellFiller.CreateNativeView(ContentView, TCellFiller.TagBase + I, Item, Item.View[I], Self as ILocalObject,
        FButtonMap);
  end;
end;

procedure TTableViewDataSource.ViewDisappeared(const Index: Integer);
begin
  FItemToContent.Remove(Index);
end;

procedure TTableViewDataSource.Reload;
begin
  if FReloadNeeded then
  begin
    FReloadNeeded := False;
    FItemToContent.Clear;
    FPresentation.ReloadData;
  end;
end;

procedure TTableViewDataSource.UpdateSections;
var
  I: Integer;
  Section: TSection;
begin
  FSections.Clear;
  FSectionedIndices.Clear;
  Section := TSection.Create(0, -1);
  FSections.Add(Section);
  for I := 0 to FParent.GetItemCount - 1 do
    if FParent.GetAdapter.Item[I].Purpose = TListItemPurpose.Header then
    begin
      if I > 0 then
      begin
        Section := TSection.Create(FSections.Count, I);
        FSections.Add(Section);
      end
      else
        Section.FItemIndex := I;
    end
    else
    begin
      FSectionedIndices.AddOrSetValue(I, TSectionedIndex.Create(Section.SectionIndex, Section.FellowIndices.Count));
      Section.FellowIndices.Add(I);
    end;
end;

procedure TTableViewDataSource.SectionsUpdateNeeded;
begin
  FSectionsUpdateNeeded := True;
end;

function TTableViewDataSource.tableViewNumberOfSectionsInTableView(tableView: UITableView): NSInteger;
begin
  if FSectionsUpdateNeeded then
  begin
    UpdateSections;
    FSectionsUpdateNeeded := False;
  end;
  Result := FSections.Count;
end;

function TTableViewDataSource.tableViewNumberOfRowsInSection(tableView: UITableView; section: NSInteger): NSInteger;
begin
  if FSectionsUpdateNeeded then
  begin
    UpdateSections;
    FSectionsUpdateNeeded := False;
  end;
  Result := FSections[section].FellowIndices.Count;
end;

function TTableViewDataSource.tableViewCellForRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath): UITableViewCell;
var
  Section: TSection;
  ItemIndex: Integer;
  ReusedCell: Pointer;
  NewCell: TCustomUITableCell;
begin
  Section := FSections[indexPath.section];
  ItemIndex := Section.FellowIndices[indexPath.row];

  ReusedCell := tableView.dequeueReusableCellWithIdentifier(FReusableCellId);
  if ReusedCell <> nil then
    Result := TUITableViewCell.Wrap(ReusedCell)
  else
  begin
    NewCell := TCustomUITableCell.Create(FReusableCellId, FPresentation);
    if FCellLeash = nil then
      FCellLeash := TList<TCustomUITableCell>.Create;
    FCellLeash.Add(NewCell);
    Result := TUITableViewCell.Wrap(NewCell.GetObjectID);
  end;
  PopulateView(ItemIndex, Result.contentView);
  FItemToContent.AddOrSetValue(ItemIndex, (Result as ILocalObject).GetObjectID);
  Result.setTag(ItemIndex);
end;

function TTableViewDataSource.tableViewCanEditRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath): Boolean;
begin
  Result := tableView.isEditing or (TListViewModeFlag.SwipeDelete in FParent.GetFlags);
end;

procedure TTableViewDataSource.tableViewCommitEditingStyleForRowAtIndexPath(tableView: UITableView;
  commitEditingStyle: UITableViewCellEditingStyle; forRowAtIndexPath: NSIndexPath);
begin
  if commitEditingStyle = UITableViewCellEditingStyleDelete then
    FParent.DeleteItem(FSections[forRowAtIndexPath.section].FellowIndices[forRowAtIndexPath.row]);
end;

function TTableViewDataSource.tableViewTitleForHeaderInSection(tableView: UITableView;
  titleForHeaderInSection: NSInteger): NSString;
var
  ItemIndex: Integer;
begin
  Result := nil;
  if (titleForHeaderInSection >= 0) and (titleForHeaderInSection < FSections.Count) then
  begin
    ItemIndex := FSections[titleForHeaderInSection].ItemIndex;
    if (ItemIndex >= 0) and (ItemIndex < FParent.GetItemCount) then
      Result := StrToNSStr(FParent.GetItemText(ItemIndex));
  end;
end;

function TTableViewDataSource.sectionIndexTitlesForTableView(tableView: UITableView): NSArray;
var
  Titles: array of Pointer;
  I, ItemIndex: Integer;
begin
  if TListViewNativeOption.Indexed in FParent.GetOptions then
  begin
    SetLength(Titles, FSections.Count);
    for I := 0 to Length(Titles) - 1 do
    begin
      ItemIndex := FSections[I].FItemIndex;
      if ItemIndex <> -1 then
        Titles[I] := (StrToNSStr(FParent.GetItemIndexTitle(ItemIndex)) as ILocalObject).GetObjectID
      else
        Titles[I] := (StrToNSStr(string.Empty) as ILocalObject).GetObjectID
    end;
    Result := TNSArray.Wrap(TNSArray.OCClass.arrayWithObjects(@Titles[0], Length(Titles)));
  end
  else
    Result := nil;
end;

procedure TTableViewDataSource.ButtonClicked(sender: Pointer);
var
  Index: Integer;
begin
  if FButtonMap.TryGetValue(NativeUInt((TUIButton.Wrap(sender) as ILocalObject).GetObjectID), Index) then
    FParent.ItemButtonClicked(Index);
end;

constructor TTableViewDelegate.Create(const AParent: TListViewPresentation; const DataSource: TTableViewDataSource);
begin
  inherited Create;

  FPresentationParent := AParent.FParent;
  FParent := AParent;
  FDataSource := DataSource;
  FReusableHeaderID := StrToNSStr(ReusableHeaderID);
  FReusableHeaderID.retain;
end;

destructor TTableViewDelegate.Destroy;
begin
  FReusableHeaderID.release;
  inherited;
end;

function TTableViewDelegate.TableViewShouldHighlightRowAtIndexPath(tableView: UITableView;
  indexPath: NSIndexPath): Boolean;
begin
  Result := True;
end;

function TTableViewDelegate.TableViewWillDeselectRowAtIndexPath(tableView: UITableView;
  indexPath: NSIndexPath): NSIndexPath;
begin
  if FPresentationParent.CanUnselectItem(FParent.FDataSource.Sections[indexPath.section].FellowIndices[indexPath.row]) then
    Result := indexPath
  else
    Result := nil;
end;

function TTableViewDelegate.TableViewWillSelectRowAtIndexPath(tableView: UITableView;
  indexPath: NSIndexPath): NSIndexPath;
begin
  if FPresentationParent.CanSelectItem(FParent.FDataSource.Sections[indexPath.section].FellowIndices[indexPath.row]) then
    Result := indexPath
  else
    Result := nil;
end;

procedure TTableViewDelegate.TableViewDidSelectRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath);
begin
  FPresentationParent.DidSelectItem(FParent.FDataSource.Sections[indexPath.section].FellowIndices[indexPath.row]);
end;

procedure TTableViewDelegate.TableViewDidDeselectRowAtIndexPath(tableView: UITableView; indexPath: NSIndexPath);
begin
  FPresentationParent.DidUnselectItem(FParent.FDataSource.Sections[indexPath.section].FellowIndices[indexPath.row]);
end;

                                                  
function TTableViewDelegate.tableViewHeightForRowAtIndexPath(tableView: UITableView;
  heightForRowAtIndexPath: NSIndexPath): CGFloat;
begin
  Result := FPresentationParent.GetItemHeight(FParent.FDataSource.Sections[heightForRowAtIndexPath.section].
    FellowIndices[heightForRowAtIndexPath.row]);
end;

function TTableViewDelegate.tableViewHeightForHeaderInSection(tableView: UITableView;
  heightForHeaderInSection: NSInteger): CGFloat;
var
  ItemIndex: Integer;
begin
  ItemIndex := FDataSource.Sections[heightForHeaderInSection].ItemIndex;
  Result := FPresentationParent.GetItemHeight(ItemIndex);
end;

function TTableViewDelegate.tableViewViewForHeaderInSection(tableView: UITableView;
  viewForHeaderInSection: NSInteger): UIView;
var
  ItemIndex: Integer;
  ReusedCell: Pointer;
  Header: UITableViewHeaderFooterView;
begin
  ItemIndex := FDataSource.Sections[viewForHeaderInSection].ItemIndex;
  ReusedCell := tableView.dequeueReusableHeaderFooterViewWithIdentifier(FReusableHeaderID);
  if ReusedCell = nil then
  begin
    Header := TUITableViewHeaderFooterView.Wrap(
      TUITableViewHeaderFooterView.Alloc.initWithReuseIdentifier(FReusableHeaderID));
    Header.textLabel.setHidden(True);
    FDataSource.PopulateView(ItemIndex, Header.contentView);
  end
  else
  begin
    Header := TUITableViewHeaderFooterView.Wrap(ReusedCell);
    FDataSource.PopulateView(ItemIndex, Header.contentView);
  end;

  Result := Header;
end;

procedure TTableViewDelegate.scrollViewDidScroll(scrollView: UIScrollView);
begin
  FParent.ScrollViewPositionChanged;
end;

constructor TRefreshDelegate.Create(const AParent: TListViewPresentation);
begin
  inherited Create;
  FParent := AParent;
end;

procedure TRefreshDelegate.RefreshData(sender: Pointer);
begin
  FParent.InvokePullRefresh;
end;

constructor TUISearchBarDelegate.Create(const AParent: TListViewPresentation);
begin
  inherited Create;
  FParent := AParent;
end;

procedure TUISearchBarDelegate.searchBarTextDidChange(searchBar: UISearchBar; textDidChange: NSString);
begin
  FParent.SearchBarTextChanged;
end;

procedure TUISearchBarDelegate.searchBarSearchButtonClicked(searchBar: UISearchBar);
begin
  FParent.FSearchBar.resignFirstResponder;
end;

constructor TListViewPresentation.Create(const AParent: IListViewPresentationParent);
var
  Flags: TListViewModeFlags;
  TableViewFrame: TRect;
begin
  inherited Create;

  FParent := AParent;

  FDataSource := TTableViewDataSource.Create(FParent);
  FDataSource.FPresentation := Self;
  FDelegate := TTableViewDelegate.Create(Self, FDataSource);

  Flags := FParent.GetFlags;

  FTableView := TUITableView.Wrap(
    TUITableView.Alloc.initWithFrame(RectToNSRect(FParent.GetContentFrame),
      IfThen(TListViewNativeOption.Grouped in FParent.GetOptions, UITableViewStyleGrouped, UITableViewStylePlain)));

  FTableView.setDelegate((FDelegate as ILocalObject).GetObjectID);
  FTableView.setDataSource((FDataSource as ILocalObject).GetObjectID);
  FTableView.setAllowsSelection(TListViewModeFlag.Enabled in Flags);
  FTableView.setAllowsSelectionDuringEditing(TListViewModeFlag.Enabled in Flags);
  FTableView.setAllowsMultipleSelectionDuringEditing((TListViewModeFlag.Enabled in Flags) and
    not (TListViewModeFlag.Deletion in Flags));
  FTableView.setEditing(TListViewModeFlag.Edit in FParent.GetFlags);
  FTableView.setHidden(not (TListViewModeFlag.Visible in FParent.GetFlags));

  if TListViewModeFlag.PullRefresh in Flags then
  begin
    FRefreshDelegate := TRefreshDelegate.Create(Self);
    FRefresh := TUIRefreshControl.Create;
    FRefresh.addTarget((FRefreshDelegate as ILocalObject).GetObjectID, sel_getUID('RefreshData:'),
      UIControlEventValueChanged);
    FTableView.addSubview(FRefresh);
  end;

  FMainView := FTableView;
  if TListViewModeFlag.Search in Flags then
  begin
    FSearchBar := TUISearchBar.Alloc;
    FSearchBar.initWithFrame(RectToNSRect(TRect.Create(0, 0, FParent.GetContentFrame.Width, DefaultSearchBarHeight)));
    FSearchBarDelegate := TUISearchBarDelegate.Create(Self);
    FSearchBar.setDelegate((FSearchBarDelegate as ILocalObject).GetObjectID);
    if TListViewModeFlag.SearchOnTop in FParent.GetFlags then
    begin
      FMainView := TUIView.Wrap(TUIView.Alloc.initWithFrame(RectToNSRect(FParent.GetContentFrame)));
      FMainView.setOpaque(True);
      FMainView.setAutoresizesSubviews(True);

      TableViewFrame := FParent.GetContentFrame;
      TableViewFrame.Offset(-TableViewFrame.Left, -TableViewFrame.Top);
      TableViewFrame.Inflate(0, -DefaultSearchBarHeight, 0, 0);
      FTableView.setFrame(RectToNSRect(TableViewFrame));

      FSearchBar.setAutoresizingMask(UIViewAutoresizingFlexibleWidth);
      FTableView.setAutoresizingMask(UIViewAutoresizingFlexibleWidth + UIViewAutoresizingFlexibleHeight +
        UIViewAutoresizingFlexibleRightMargin + UIViewAutoresizingFlexibleBottomMargin);
      FMainView.addSubview(FSearchBar);
      FMainView.addSubview(FTableView);
    end
    else
      FTableView.setTableHeaderView(FSearchBar);
  end;

  FixOrderAndBounds;
end;

destructor TListViewPresentation.Destroy;
begin
  if FSearchBar <> nil then
  begin
    FTableView.setTableHeaderView(nil);
    FSearchBar.setDelegate(nil);
    FSearchBarDelegate := nil;
    FSearchBar := nil;
  end;
  FRefresh := nil;
  FRefreshDelegate := nil;
  FTableView.setDataSource(nil);
  FTableView.setDelegate(nil);
  FDataSource.Free;
  FDelegate.Free;
  if FMainView <> nil then
    FMainView.removeFromSuperview;
  FMainView := nil;
  FTableView := nil;

  inherited;
end;

procedure TListViewPresentation.SizeChanged;
begin
  FixOrderAndBounds;
end;

procedure TListViewPresentation.EditModeChanged;
                                                                                
                                        
              
                            
                
                                                          
                                                                                   
               
begin
  if FTableView.isEditing xor (TListViewModeFlag.Edit in FParent.GetFlags) then
  begin
    FDataSource.ReloadNeeded := True;
    FDataSource.Reload;
    FTableView.setEditingAnimated(TListViewModeFlag.Edit in FParent.GetFlags, True);
  end;
end;

procedure TListViewPresentation.StatusChanged;
begin
  FTableView.setAllowsSelection(TListViewModeFlag.Enabled in FParent.GetFlags);
  FTableView.setAllowsSelectionDuringEditing(TListViewModeFlag.Enabled in FParent.GetFlags);
  FTableView.setAllowsMultipleSelectionDuringEditing(TListViewModeFlag.Enabled in FParent.GetFlags);
  FTableView.setHidden(not (TListViewModeFlag.Visible in FParent.GetFlags));
end;

procedure TListViewPresentation.ItemInvalidated(const Item: TListItem);
begin
  FDataSource.DoItemInvalidated(Item);
end;

procedure TListViewPresentation.ItemsUpdated;
begin
  if not FLoadingCell then
  begin
    FTableView.setEstimatedRowHeight(FParent.GetEstimatedItemHeight());
    FTableView.setEstimatedSectionHeaderHeight(FParent.GetEstimatedHeaderHeight());
    FTableView.setEstimatedSectionFooterHeight(FParent.GetEstimatedFooterHeight());

    FDataSource.ReloadNeeded := True;
    FDataSource.SectionsUpdateNeeded;
    FDataSource.Reload;
  end;
end;

procedure TListViewPresentation.AncestorVisibleChanged(const Visible: Boolean);
begin
  FMainView.setAlpha(FParent.GetControlOpacity);
  FixOrderAndBounds;
end;

procedure TListViewPresentation.ParentChanged;
begin
  FixOrderAndBounds;
end;

procedure TListViewPresentation.ReloadData;
begin
  FTableView.reloadData;
end;

procedure TListViewPresentation.OrderChanged;
begin
  FixOrderAndBounds;
end;

procedure TListViewPresentation.FixOrderAndBounds;
var
  ZOrderManager: TiOSZOrderManager;
begin
  if (FParent.GetRootObject is TCommonCustomForm) and (FMainView <> nil) then
  begin
    ZOrderManager := WindowHandleToPlatform(TCommonCustomForm(FParent.GetRootObject).Handle).ZOrderManager;
    ZOrderManager.UpdateOrderAndBounds(TControl(FParent), FMainView);
    FMainView.setAlpha(FParent.GetControlOpacity);
  end;
end;

procedure TListViewPresentation.SetItemIndex(const ItemIndex: Integer);
var
  IndexPath: NSIndexPath;
  SectionedIndex: TTableViewDataSource.TSectionedIndex;
begin
  if FDataSource.SectionedIndices.TryGetValue(ItemIndex, SectionedIndex) then
  begin
    IndexPath := TNSIndexPath.Wrap(TNSIndexPath.OCClass.indexPathForRow(SectionedIndex.Row, SectionedIndex.Section));
    FTableView.selectRowAtIndexPath(IndexPath, False, UITableViewScrollPositionNone);
  end;
end;

procedure TListViewPresentation.SetItemSelected(const ItemIndex: Integer; const Value: Boolean);
var
  IndexPath: NSIndexPath;
  SectionedIndex: TTableViewDataSource.TSectionedIndex;
begin
  if FDataSource.SectionedIndices.TryGetValue(ItemIndex, SectionedIndex) then
  begin
    IndexPath := TNSIndexPath.Wrap(TNSIndexPath.OCClass.indexPathForRow(SectionedIndex.Row, SectionedIndex.Section));
    if Value then
      FTableView.selectRowAtIndexPath(IndexPath, False, UITableViewScrollPositionNone)
    else
      FTableView.deselectRowAtIndexPath(IndexPath, False);
  end;
end;

procedure TListViewPresentation.InvokePullRefresh;
begin
  FParent.InvokePullRefresh;
  if (FRefresh <> nil) and not (TListViewModeFlag.PullRefreshWait in FParent.GetFlags) then
    FRefresh.endRefreshing;
end;

procedure TListViewPresentation.StopPullRefresh;
begin
  if FRefresh <> nil then
    FRefresh.endRefreshing;
end;

procedure TListViewPresentation.SearchBarTextChanged;
begin
  FParent.SetSearchFilter(NSStrToStr(FSearchBar.text));
end;

procedure TListViewPresentation.ScrollViewPositionChanged;
begin
  FParent.SetScrollViewPos(FTableView.contentOffset.y);
  FTableView.endEditing(True);
end;

function TListViewPresentationService.AttachPresentation(const Parent: IInterface): IInterface;
var
  TableViewParent: IListViewPresentationParent;
begin
  if Supports(Parent, IListViewPresentationParent, TableViewParent) then
    Result := TListViewPresentation.Create(TableViewParent)
  else
    Result := nil;
end;

procedure TListViewPresentationService.DetachPresentation(const Parent: IInterface);
begin
end;


{ TCellFiller }

procedure TCellFiller.SetCellText(const ALabel: UILabel; const TextDrawable: TListItemText);
begin
  if TextDrawable.Visible and not TextDrawable.Text.IsEmpty then
  begin
    ALabel.setText(StrToNSStr(TextDrawable.Text));
    ALabel.setTextAlignment(TextAlignToUITextAlignment(TextDrawable.TextAlign));
    ALabel.setTextColor(AlphaColorToUIColor(TextDrawable.TextColor));
    ALabel.setHighlightedTextColor(AlphaColorToUIColor(TextDrawable.SelectedTextColor));
    ALabel.setFont(FontToUIFont(TextDrawable.Font));
                                                               
    if TextDrawable.TextVertAlign = TTextAlign.Leading then
      ALabel.sizeToFit;
    if TextDrawable.WordWrap then
    begin
      ALabel.setNumberOfLines(0);
      ALabel.setLineBreakMode(UILineBreakModeWordWrap)
    end
    else
    begin
      ALabel.setNumberOfLines(1);
      ALabel.setLineBreakMode(UILineBreakModeClip);
    end;
    ALabel.setHidden(False);
  end
  else
  begin
    ALabel.setText(nil);
    ALabel.setHidden(True);
  end;
end;

procedure TCellFiller.SetButtonTitle(const Button: UIButton; const Title: NSString);
begin
  Button.setTitle(Title, UIControlStateNormal);
  Button.setTitle(Title, UIControlStateHighlighted);
  Button.setTitle(Title, UIControlStateDisabled);
  Button.setTitle(Title, UIControlStateSelected);
end;

procedure TCellFiller.SetButtonText(const Button: UIButton; const ButtonDrawable: TListItemTextButton);
begin
  if ButtonDrawable.Visible and not ButtonDrawable.Text.IsEmpty then
  begin
    SetButtonTitle(Button, StrToNSStr(ButtonDrawable.Text));

    Button.setTitleColor(AlphaColorToUIColor(ButtonDrawable.TextColor), UIControlStateNormal);
    Button.setTintColor(AlphaColorToUIColor(ButtonDrawable.TintColor));
    Button.setFont(FontToUIFont(ButtonDrawable.Font));
    Button.setHidden(False);
  end
  else
  begin
    SetButtonTitle(Button, nil);
    Button.setHidden(True);
  end;
end;

procedure TCellFiller.SetCellBitmap(const ImageView: UIImageView; const Bitmap: TBitmap; const BitmapRect: TRect;
  const ItemIndex: Integer);
var
  BitmapData: TBitmapData;
  ContextRef: CGContextRef;
  ImageRef: CGImageRef;
  Image: UIImage;
begin
  if Bitmap.Map(TMapAccess.Read, BitmapData) then
    try
      if BitmapRect.IsEmpty or ((BitmapRect.TopLeft = TPoint.Zero) and (BitmapRect.BottomRight =
        TPoint.Create(Bitmap.Width, Bitmap.Height))) then
        ContextRef := CGBitmapContextCreate(BitmapData.Data, BitmapData.Width, BitmapData.Height, 8, BitmapData.Pitch,
          FColorSpace, kCGImageAlphaPremultipliedLast)
      else
        ContextRef := CGBitmapContextCreate(BitmapData.GetPixelAddr(BitmapRect.Left, BitmapRect.Top), BitmapRect.Width,
          BitmapRect.Height, 8, BitmapData.Pitch, FColorSpace, kCGImageAlphaPremultipliedLast);
      if ContextRef <> nil then
      try
        ImageRef := CGBitmapContextCreateImage(ContextRef);
        if ImageRef <> nil then
        try
          Image := TUIImage.Wrap(TUIImage.alloc.initWithCGImage(ImageRef, Bitmap.BitmapScale, UIImageOrientationUp));
          if Image <> nil then
          try
            ImageView.setImage(Image);
          finally
            Image.release;
          end;
        finally
          CGImageRelease(ImageRef);
        end;
      finally
        CGContextRelease(ContextRef);
      end;
    finally
      Bitmap.Unmap(BitmapData);
    end;
end;

function TCellFiller.GetUILabel(const ContentView: UIView; const Tag: Integer): UILabel;
var
  V: UIView;
begin
  Result := nil;
  V := TUIView.Wrap(ContentView.superview).viewWithTag(Tag);
  if V <> nil then
    if V.isKindOfClass(objc_getClass('UILabel')) then
      Result := TUILabel.Wrap((V as ILocalObject).GetObjectID)
    else
    begin
      V.setHidden(True);
      ContentView.bringSubviewToFront(V);
      V.removeFromSuperview;
    end;
end;

function TCellFiller.GetUIImageView(const ContentView: UIView; const Tag: Integer): UIImageView;
var
  V: UIView;
begin
  Result := nil;
  V := TUIView.Wrap(ContentView.superview).viewWithTag(Tag);
  if V <> nil then
    if V.isKindOfClass(objc_getClass('UIImageView')) then
      Result := TUIImageView.Wrap((V as ILocalObject).GetObjectID)
    else
    begin
      V.setHidden(True);
      ContentView.bringSubviewToFront(V);
      V.removeFromSuperview;
    end;
end;

function TCellFiller.GetUIButton(const ContentView: UIView; const Tag: Integer): UIButton;
var
  V: UIView;
begin
  Result := nil;
  V := TUIView.Wrap(ContentView.superview).viewWithTag(Tag);
  if V <> nil then
    if V.isKindOfClass(objc_getClass('UIButton')) then
      Result := TUIButton.Wrap((V as ILocalObject).GetObjectID)
    else
    begin
      V.setHidden(True);
      ContentView.bringSubviewToFront(V);
      V.removeFromSuperview;
    end;
end;

procedure TCellFiller.CreateLabel(const ContentView: UIView; const Tag: Integer; const Item: TListItem; const Drawable: TListItemText);
var
  LLabel: UILabel;
begin
  LLabel := GetUILabel(ContentView, Tag);
  if LLabel = nil then
  begin
    LLabel := TUILabel.Wrap(TUILabel.Alloc.initWithFrame(RectToNSRect(FDataSource.GetLocalRect(Item, Drawable))));
    LLabel.setTag(Tag);
    ContentView.addSubview(LLabel);
  end
  else
    LLabel.setFrame(RectToNSRect(FDataSource.GetLocalRect(Item, Drawable)));
  ContentView.bringSubviewToFront(LLabel);

  SetCellText(LLabel, Drawable);
end;

procedure TCellFiller.CreateImageView(const ContentView: UIView; const Tag: Integer; const Item: TListItem;
  const Drawable: TListItemImage);
var
  ImageView: UIImageView;
  SrcRect, DstRect: TRectF;
  LocalRect: TRect;
  Bitmap: TBitmap;
begin
  ImageView := GetUIImageView(ContentView, Tag);
  if ImageView = nil then
  begin
    if not Drawable.Visible then
      Exit;
    ImageView := TUIImageView.Create;
    ImageView.setTag(Tag);
    ContentView.addSubview(ImageView);
  end;

  ContentView.bringSubviewToFront(ImageView);

  Bitmap := nil;
  if Drawable.Visible then
  begin
    LocalRect := FDataSource.GetLocalRect(Item, Drawable);
    case Drawable.ImageSource of
      TListItemImage.TImageSource.Bitmap:
        Bitmap := Drawable.Bitmap;
      TListItemImage.TImageSource.ImageList:
        if Item.Controller.Images <> nil then
          Bitmap := Item.Controller.Images.Bitmap(TPointF.Create(TPoint(LocalRect.Size)) * FDataSource.GetScale,
            Drawable.ImageIndex);
    end;
  end;
  if Bitmap <> nil then
  begin
    Drawable.FitInto(Bitmap, SrcRect, DstRect);
    ImageView.setFrame(RectToNSRect(DstRect.Round));
    SetCellBitmap(ImageView, Bitmap, SrcRect.Round, Item.Index);
    ImageView.setHidden(False);
    ImageView.setAlpha(Drawable.Opacity);
  end
  else
  begin
    ImageView.setImage(nil);
    ImageView.setHidden(False);
  end;
end;

constructor TCellFiller.Create(const DataSource: TTableViewDataSource);
begin
  FColorSpace := CGColorSpaceCreateDeviceRGB;
  FDataSource := DataSource;
end;

procedure TCellFiller.CreateAccessory(const Cell: UITableViewCell; const Tag: Integer; const Item: TListItem;
  const Drawable: TListItemAccessory);
var
  Accessory: UITableViewCellAccessoryType;
begin
  if Cell.isKindOfClass(objc_getClass('UITableViewCell')) then
  begin
    if Drawable.Visible then
      case Drawable.AccessoryType of
        TAccessoryType.More:
          Accessory := UITableViewCellAccessoryDisclosureIndicator;
        TAccessoryType.Checkmark:
          Accessory := UITableViewCellAccessoryCheckmark;
        TAccessoryType.Detail:
          Accessory := UITableViewCellAccessoryDetailButton;
      else
        Accessory := UITableViewCellAccessoryNone;
      end
    else
      Accessory := UITableViewCellAccessoryNone;
    if Cell.isEditing then
      Cell.setEditingAccessoryType(Accessory)
    else
      Cell.setAccessoryType(Accessory);
  end;
end;

procedure TCellFiller.CreateTextButton(const ContentView: UIView; const Tag: Integer; const Item: TListItem;
  const Drawable: TListItemTextButton; const Target: ILocalObject; ButtonMap: TDictionary<NativeUInt,Integer>);
var
  Button: UIButton;
begin
  Button := GetUIButton(ContentView, Tag);
  if Button = nil then
  begin
    if not Drawable.Visible then
      Exit;

    Button := TUIButton.Wrap(TUIButton.OCClass.buttonWithType(UIButtonTypeRoundedRect));
    Button.setTag(Tag);
    ButtonMap.AddOrSetValue(NativeUInt((Button as ILocalObject).GetObjectID), Item.Index);
    ContentView.addSubview(Button);
  end;

  ContentView.bringSubviewToFront(Button);
  Button.setFrame(RectToNSRect(FDataSource.GetLocalRect(Item, Drawable)));
  SetButtonText(Button, Drawable);
  ButtonMap.AddOrSetValue(NativeUInt((Button as ILocalObject).GetObjectID), Item.Index);

  Button.addTarget(Target.GetObjectID, sel_getUID('ButtonClicked:'), UIControlEventTouchUpInside);
end;

procedure TCellFiller.CreateGlyphButton(const Cell: UITableViewCell; const Tag: Integer; const Item: TListItem;
  const Drawable: TListItemGlyphButton; const Target: ILocalObject);
begin
  // not supported
end;

procedure TCellFiller.CreateNativeView(const ContentView: UIView; const Tag: Integer;
  const Item: TListItem; const Drawable: TListItemDrawable; Target: ILocalObject;
  ButtonMap: TDictionary<NativeUInt,Integer>);
begin
  if Drawable is TListItemText then
    CreateLabel(ContentView, Tag, Item, TListItemText(Drawable))
  else if Drawable is TListItemImage then
    CreateImageView(ContentView, Tag, Item, TListItemImage(Drawable))
  else if Drawable is TListItemAccessory then
    CreateAccessory(TUITableViewCell.Wrap(ContentView.superview), Tag, Item, TListItemAccessory(Drawable))
  else if Drawable is TListItemTextButton then
    CreateTextButton(ContentView, Tag, Item, TListItemTextButton(Drawable), Target, ButtonMap)
  else if Drawable is TListItemGlyphButton then
    CreateGlyphButton(TUITableViewCell.Wrap(ContentView.superview), Tag, Item, TListItemGlyphButton(Drawable), Target);
end;

procedure TCellFiller.HideSubviews(const View: UIView);
var
  Subviews: NSArray;
  I: Integer;
begin
  Subviews := View.subviews;
  if (Subviews <> nil) and (Subviews.count > 0) then
    for I := Subviews.count - 1 downto 0 do
      TUIView.Wrap(Subviews.objectAtIndex(I)).setHidden(True);
end;

{ TCustomUITableCell }

constructor TCustomUITableCell.Create(const ReusableID: NSString; const Presentation: TListViewPresentation);
begin
  inherited Create;
  FPresentation := Presentation;
  InitView(ReusableID);
end;

destructor TCustomUITableCell.Destroy;
begin
  inherited;
end;

procedure TCustomUITableCell.InitView(const ReusableID: NSString);
var
  V: Pointer;
begin
  V := UITableViewCell(Super).initWithStyle(UITableViewCellStyleDefault, ReusableID);
  if GetObjectID <> V then
    UpdateObjectID(V);
end;

function TCustomUITableCell.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(ICustomUITableViewCell);
end;

procedure TCustomUITableCell.willTransitionToState(state: UITableViewCellStateMask);
begin
  UITableViewCell(Super).willTransitionToState(state);
end;

procedure TCustomUITableCell.didTransitionToState(state: UITableViewCellStateMask);
begin
  UITableViewCell(Super).didTransitionToState(state);
end;

procedure TCustomUITableCell.prepareForReuse;
begin
  UITableViewCell(Super).prepareForReuse;
  FPresentation.FDataSource.ViewDisappeared(UITableViewCell(Super).tag);
end;

initialization
  TPlatformServices.Current.AddPlatformService(IFMXListViewPresentationService, TListViewPresentationService.Create);

end.

