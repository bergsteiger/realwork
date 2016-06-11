{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit FMX.Design.ListView;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, System.Classes, System.Types, System.Generics.Collections, System.Rtti,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.StdCtrls, FMX.Objects,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView,
  FMX.Platform, ColnEdit;

type
  TListItemDrawableShim = class;
  TListItemTextShim = class;
  TListItemImageShim = class;
  TListItemAccessoryShim = class;
  TListItemTextButtonShim = class;
  TListItemGlyphButtonShim = class;
  TListViewDesignPresentationManager = class;

  TListItemShim = class(TControl, IPersistentShim, IPersistentProvider)
  strict private
    [Weak] FListItem: TListItem;
    FPurpose: TListItemPurpose;
    FStyleResources: IListItemStyleResources;
    FShims: TList<TListItemDrawableShim>;
    [Weak] FAppearanceProperties: TItemAppearanceProperties;
    FAppearanceOwner: IPublishedAppearanceOwner;
    procedure SetListItem(const AListItem: TListItem);
    function GetDesignName: string;

    // IPersistentShim
    function GetDesignBoundsRect: TRect;
    function IPersistentShim.GetBoundsRect = GetDesignBoundsRect;

    // Persistent provider
    function GetPersistent: TPersistent;
  public
    constructor Create(AppearanceProperties: TItemAppearanceProperties; AppearanceOwner: IPublishedAppearanceOwner); reintroduce; overload;
    destructor Destroy; override;
    procedure Paint; override;
    procedure PaintDrawables;

    procedure CreateShims;
    procedure CreateShim(const Index: Integer; const Drawable: TListItemDrawable);
    procedure FreeShims;

    function GetAppearanceObjects: TItemAppearanceObjects;
    procedure Bind(const Drawable: TListItemDrawable; Shim: TListItemDrawableShim);

    function CreateTextShim(const Drawable: TListItemText): TListItemTextShim;
    function CreateImageShim(const Drawable: TListItemImage): TListItemImageShim;
    function CreateAccessoryShim(const Drawable: TListItemAccessory): TListItemAccessoryShim;
    function CreateTextButtonShim(const Drawable: TListItemTextButton): TListItemTextButtonShim;
    function CreateGlyphButtonShim(const Drawable: TListItemGlyphButton): TListItemGlyphButtonShim;

    property ListItem: TListItem read FListItem write SetListItem;
    property Purpose: TListItemPurpose read FPurpose;
    property StyleResources: IListItemStyleResources read FStyleResources write FStyleResources;
  published
    property Height;
  end;

  TListItemDrawableShim = class(TControl, IPersistentShim, IListViewDrawableShim, IPersistentProvider)
  strict private
    [Weak] FDrawable: TListItemDrawable;
    [Weak] FListItem: TListItem;
    [Weak] FItemShim: TListItemShim;
    [Weak] FPersistent: TPersistent;
    FDrawableName: string;

    procedure SetDrawable(const Drawable: TListItemDrawable);
    function GetShimBoundsRect: TRect;
    function CalcAppearanceBounds(const AValue: TRect; const CurrentBounds: TRectF): TRectF;
    function IPersistentShim.GetBoundsRect = GetShimBoundsRect;

    // Persistent provider
    function GetPersistent: TPersistent;

  protected
    function GetSize: TPointF;
    procedure SetSize(const ASize: TPointF);

    function GetDrawableAlign: TListItemAlign;
    procedure SetDrawableAlign(const AAlign: TListItemAlign);
    function GetVertAlign: TListItemAlign;
    procedure SetVertAlign(const AAlign: TListItemAlign);
    function GetDrawableVisible: Boolean;
    procedure SetDrawableVisible(const Value: Boolean);
    function GetPlaceOffset: TPosition;
    procedure SetDrawableName(const Value: string);
    function GetDrawableName: string;

    function GetOpacity: Single;
    procedure SetOpacity(const AValue: Single);

    procedure DoSetDrawable(const Drawable: TListItemDrawable); virtual;

    procedure Paint; override;

    procedure SetPersistent(const Value: TPersistent);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Drawable: TListItemDrawable read FDrawable write SetDrawable;
    property ListItem: TListItem read FListItem write FListItem;
    property ItemShim: TListItemShim read FItemShim write FItemShim;
  published
    property Size: TPointF read GetSize write SetSize;
    /// <summary>Horizontal alignment of drawable inside its designated area.</summary>
    property Align: TListItemAlign read GetDrawableAlign write SetDrawableAlign;
    /// <summary>Vertical alignment of drawable inside its designated area.</summary>
    property VertAlign: TListItemAlign read GetVertAlign write SetVertAlign;
    /// <summary>Determines whether the current drawable is visible or not.</summary>
    property Visible: Boolean read GetDrawableVisible write SetDrawableVisible;
    /// <summary>The offset in logical units regarding aligned location for finer placement control.</summary>
    property PlaceOffset: TPosition read GetPlaceOffset;
    /// <summary>Name of this drawable</summary>
    property DrawableName: string read GetDrawableName write SetDrawableName;
    /// <summary>Drawing opacity</summary>
    property Opacity: Single read GetOpacity write SetOpacity;
  end;

  TListItemTextShim = class(TListItemDrawableShim)
  protected
    procedure DoSetDrawable(const Drawable: TListItemDrawable); override;
  end;

  TListItemImageShim = class(TListItemDrawableShim)
  end;

  TListItemAccessoryShim = class(TListItemDrawableShim)
  end;

  TListItemGlyphButtonShim = class(TListItemDrawableShim)
  end;

  TListItemTextButtonShim = class(TListItemDrawableShim)
  end;

  TListViewDesignPresentation = class(TInterfacedObject, IListViewPresentation)
  private const
    DefaultSearchBarHeight = 44;
  private
    FParent: IListViewPresentationParent;
    FStyleResources: IListItemStyleResources;
    FAppearanceOwner: IPublishedAppearanceOwner;
    [Weak] FControl: TControl;
    [Weak] FManager: TListViewDesignPresentationManager;
    FBackground: TRectangle;
    FItemsList: TList<TListItemShim>;
    FReloading: Boolean;
    FDisabling: Boolean;

    procedure SetItemSelected(const ItemIndex: Integer; const Value: Boolean);
    procedure SetItemIndex(const ItemIndex: Integer);
    procedure StopPullRefresh;

    function GetItemsList: TList<TListItemShim>;

    property ItemsList: TList<TListItemShim> read GetItemsList;
  protected
    procedure AncestorVisibleChanged(const Visible: Boolean); virtual;
    procedure ParentChanged; virtual;
    procedure OrderChanged; virtual;
    procedure SizeChanged; virtual;
    procedure EditModeChanged; virtual;
    procedure StatusChanged; virtual;
    procedure ItemsUpdated; virtual;
    procedure ItemInvalidated(const Item: TListItem);
    procedure ItemsWillChange;
  public
    constructor Create(AOwner: IInterface);
    destructor Destroy; override;
    procedure ReloadData;
    property Disabling: Boolean read FDisabling write FDisabling;
    property Manager: TListViewDesignPresentationManager read FManager write FManager;
  end;

  TListViewDesignPresentationManager = class
  strict private
    FPresentations: TDictionary<IInterface, IListViewPresentation>;
    FEnabled: TDictionary<IListViewPresentationParent, Boolean>;
    FCachedAdapters: TDictionary<IInterface, TAppearanceListViewItems>;
    FPrototypeData: TDictionary<TClass, TFunc<TCommonObjectAppearance,TListViewItem,TValue>>;
    class var FInstance: TListViewDesignPresentationManager;
    constructor Create;
  protected
    /// <summary>Temporarily detach the main items adapter from ListView and attach a design-time adapter</summary>
    procedure InjectPrototypeItems(const ListView: TCustomListView);
    /// <summary>Detach the design-time items adapter and restore the main adapter</summary>
    procedure RetractPrototypeItems(const ListView: TCustomListView);
    /// <summary>Obtain prototype data for given Item and Appearance</summary>
    function PrototypeDataFor(const Appearance: TCommonObjectAppearance; const Item: TListViewItem): TValue;
    /// <summary>Fill prototype ListItems with data</summary>
    procedure InitPrototypeData;
    /// <summary>Generate a generic looking bitmap for design-time items</summary>
    function GetBitmap: TBitmap; overload;
    /// <summary>Generate a unique bitmap with AIndex painted in it</summary>
    function GetBitmap(const AIndex: string): TBitmap; overload;
    /// <summary>Generate prototype data for design-time items</summary>
    procedure MakeBeautifulData(const ListView: TCustomListView; const Item: TListViewItem);
    /// <summary>Enable design mode for given ListView</summary>
    procedure Enable(const AOwner: TCustomListView);
    /// <summary>Disable design mode for given ListView</summary>
    procedure Disable(const AOwner: TCustomListView);
  public
    function AttachPresentation(const AOwner: IInterface): IListViewPresentation;
    procedure DetachPresentation(const AOwner: IInterface);

    /// <summary>Toggle design mode. Used by the menu verb.</summary>
    procedure ToggleVerb(const AOwner: TCustomListView);
    /// <summary>Return true if given ListView is currently being designed</summary>
    function IsEnabled(const AOwner: TCustomListView): Boolean;

    class function Instance: TListViewDesignPresentationManager;
    destructor Destroy; override;
  end;

  /// <summary>The adapter used in design mode. It keeps a reference to the main Items and returns
  ///  them when LiveBindings Editor edits the ListView while ListView is being designed.
  /// </summary>
  TPosticheItems = class(TAppearanceListViewItems, IListViewEditor)
  private
    FLocked: Boolean;
    FTrueItems: TAppearanceListViewItems;
  public
    /// <summary>Set to True to use the real items. False for design-time items.</summary>
    procedure Lock(const State: Boolean);
    /// <summary>Set reference to the true items that would be supplied to the LiveBindings editors</summary>
    procedure SetTrueItems(const Adapter: TAppearanceListViewItems);

    procedure DoClear; override;
    function DoAddItem(const Index: Integer = -1): TListViewItem; override;
    function DoGetUnfilteredItems: TListItemsList; override;
    procedure DoResetViews(const APurposes: TListItemPurposes); override;
  end;

  TDesignPresentationService = class(TInterfacedObject, IFMXListViewPresentationService)
    function AttachPresentation(const AOwner: IInterface): IInterface;
    procedure DetachPresentation(const AOwner: IInterface);
  end;

implementation

uses
  System.TypInfo, System.Math, System.Math.Vectors, System.UITypes, FMX.Consts, FmxDsnConst;


type
  TUtils = class
    class function GetAppearanceProperties(Owner: IPublishedAppearanceOwner; Purpose: TListItemPurpose):
      TItemAppearanceProperties; overload;
    class function GetAppearanceProperties(Owner: IPublishedAppearanceOwner; Purpose: TListItemPurpose;
      const EditMode: Boolean): TItemAppearanceProperties; overload;
    class procedure ResetSprigBinding(const ItemShim: TListItemShim; const Owner: IPublishedAppearanceOwner);
  end;
{ TListViewItemShim }

constructor TListItemShim.Create(AppearanceProperties: TItemAppearanceProperties;
  AppearanceOwner: IPublishedAppearanceOwner);
begin
  inherited Create(nil);
  FAppearanceProperties := AppearanceProperties;
  FAppearanceOwner := AppearanceOwner;
  Height := 44;
  Align := TAlignLayout.None;
  Locked := False;
  Stored := False;
end;

procedure TListItemShim.SetListItem(const AListItem: TListItem);
begin
  FListItem := AListItem;
  FPurpose := AListItem.Purpose;
  Name := GetDesignName;
  AListItem.WillBePainted;
  CreateShims;
end;


function TListItemShim.GetDesignBoundsRect: TRect;
begin
  Result := BoundsRect.Round;
end;

function TListItemShim.GetDesignName: string;
const
  DesignNames: array [TListItemPurpose] of string = ('Item%s%d', 'Header%s%d', 'Footer%s%d'); // do not localize
  Prototype: string = 'Prototype'; // do not localize
begin
  Result := Format(DesignNames[ListItem.Purpose], [Prototype, ListItem.Index]);
end;

function TListItemShim.GetPersistent: TPersistent;
var
  Sprigged: ISpriggedPersistent;
begin
  if Supports(FAppearanceProperties, ISpriggedPersistent, Sprigged) then
    Result := Sprigged.GetSprig
  else
    Result := FAppearanceProperties;
end;

procedure TListItemShim.Paint;
var
  R: TRectF;
begin
  inherited;
  if not FInPaintTo then
  begin
    R := LocalRect;
    R.Inflate(-0.5, -0.5);
    Canvas.Stroke.Thickness := 1;
    Canvas.Stroke.Dash := TStrokeDash.Dash;
    Canvas.Stroke.Kind := TBrushKind.Solid;
    Canvas.Stroke.Color := $A0909090;
    Canvas.DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    Canvas.Stroke.Dash := TStrokeDash.Solid;

    ListItem.WillBePainted;
    PaintDrawables;
  end;
end;

procedure TListItemShim.PaintDrawables;
const
  DefaultParams: TListItemDrawable.TParams = (AbsoluteOpacity: 1.0; ItemSelectedAlpha: 1.0;
    DeletingUnwantedOpacity: 1.0; ParentAbsoluteRect: (Left:0;Top:0;Right:0;Bottom:0); Images: nil);

var
  I: Integer;
  Drawable: TListItemDrawable;
  Params: TListItemDrawable.TParams;
  NPasses, Pass: Integer;
begin
  Params := DefaultParams;

  NPasses := 1;
  for I := 0 to Pred(ListItem.View.Count) do
    NPasses := Max(NPasses, ListItem.View[I].GetRenderPassCount);

  for Pass := 0 to NPasses - 1 do
    for I := 0 to Pred(ListItem.View.Count) do
    begin
      Drawable := ListItem.View[I];
      Drawable.UpdateValuesFromResources(StyleResources.StyleResources, ListItem.Purpose);
      Drawable.CalculateLocalRect(LocalRect, Scale.X, [], ListItem);
      if Drawable.Visible then
        Drawable.Render(Canvas, 0, [], StyleResources.StyleResources, Params, Pass);
    end;
end;

procedure TListItemShim.CreateShims;
var
  I: Integer;
begin
  FreeShims;
  FShims := TList<TListItemDrawableShim>.Create;
  for I := 0 to ListItem.View.Count - 1 do
    CreateShim(I, ListItem.View[I]);
end;

function TListItemShim.GetAppearanceObjects: TItemAppearanceObjects;
begin
  if FAppearanceOwner.ItemAppearanceObjects <> nil then
    case ListItem.Purpose of
      TListItemPurpose.None:
        if FAppearanceOwner.IsEditMode then
          Result := FAppearanceOwner.ItemAppearanceObjects.ItemEditObjects
        else
          Result := FAppearanceOwner.ItemAppearanceObjects.ItemObjects;
      TListItemPurpose.Header:
        Result := FAppearanceOwner.ItemAppearanceObjects.HeaderObjects;
      TListItemPurpose.Footer:
        Result := FAppearanceOwner.ItemAppearanceObjects.FooterObjects;
      else
        Result := FAppearanceOwner.ItemAppearanceObjects.ItemObjects;
    end
  else
    Result := nil;
end;

procedure TListItemShim.Bind(const Drawable: TListItemDrawable; Shim: TListItemDrawableShim);
var
  PublishedObject: TCommonObjectAppearance;
  AppearanceObjects: TItemAppearanceObjects;
begin
  AppearanceObjects := GetAppearanceObjects;
  if AppearanceObjects <> nil then
    for PublishedObject in AppearanceObjects.Objects do
    begin
      if (Drawable = nil) or SameText(PublishedObject.Name, Drawable.Name) then
      begin
        if Shim <> nil then
        begin
          (PublishedObject as IDesignablePersistent).Bind(Shim);
          Shim.SetPersistent(PublishedObject);
        end
        else
          (PublishedObject as IDesignablePersistent).Unbind;
        if Drawable <> nil then
          Break;
      end;
    end;
end;

procedure TListItemShim.CreateShim(const Index: Integer; const Drawable: TListItemDrawable);
var
  Shim: TListItemDrawableShim;
begin
  Shim := nil;
  if Drawable.Visible then
  begin
    if Drawable is TListItemText then
      Shim := CreateTextShim(TListItemText(Drawable))
    else if Drawable is TListItemImage then
      Shim := CreateImageShim(TListItemImage(Drawable))
    else if Drawable is TListItemAccessory then
      Shim := CreateAccessoryShim(TListItemAccessory(Drawable))
    else if Drawable is TListItemTextButton then
      Shim := CreateTextButtonShim(TListItemTextButton(Drawable))
    else if Drawable is TListItemGlyphButton then
      Shim := CreateGlyphButtonShim(TListItemGlyphButton(Drawable));
  end;
  if Shim <> nil then
  begin
    FShims.Add(Shim);
    Shim.ItemShim := Self;
    Shim.ListItem := ListItem;
    Shim.Name := Format('%s_%s%d', [Name, Drawable.Name, Index]); // do not localize
    Shim.Parent := Self;
    Drawable.CalculateLocalRect(LocalRect, Scale.X, [], ListItem);
    Shim.SetBoundsRect(Drawable.LocalRect);
    Shim.Repaint;
    Bind(Drawable, Shim);
  end;
end;

function TListItemShim.CreateAccessoryShim(const Drawable: TListItemAccessory): TListItemAccessoryShim;
begin
  Result := TListItemAccessoryShim.Create(nil);
  Result.Drawable := Drawable;
end;

function TListItemShim.CreateGlyphButtonShim(const Drawable: TListItemGlyphButton): TListItemGlyphButtonShim;
begin
  Result := TListItemGlyphButtonShim.Create(nil);
  Result.Drawable := Drawable;
end;

function TListItemShim.CreateImageShim(const Drawable: TListItemImage): TListItemImageShim;
begin
  Result := TListItemImageShim.Create(nil);
  Result.Drawable := Drawable;
end;

function TListItemShim.CreateTextButtonShim(const Drawable: TListItemTextButton): TListItemTextButtonShim;
begin
  Result := TListItemTextButtonShim.Create(nil);
  Result.Drawable := Drawable;
end;

function TListItemShim.CreateTextShim(const Drawable: TListItemText): TListItemTextShim;
begin
  Result := TListItemTextShim.Create(nil);
  Result.Drawable := Drawable;
end;

destructor TListItemShim.Destroy;
begin
  TUtils.ResetSprigBinding(Self, FAppearanceOwner);
  FreeShims;
  inherited;
end;

procedure TListItemShim.FreeShims;
var
  I: Integer;
begin
  Bind(nil, nil);
  if FShims <> nil then
    for I := FShims.Count - 1 downto 0 do
      FShims[I].Free;
  FShims.Free;
end;

{ TListItemDrawableShim }

constructor TListItemDrawableShim.Create(AOwner: TComponent);
begin
  inherited;
  Locked := False;
  Stored := False;
end;

destructor TListItemDrawableShim.Destroy;
var
  Bound: IDesignablePersistent;
begin
  if Supports(FPersistent, IDesignablePersistent, Bound) then
    Bound.Unbind;
  inherited;
end;

procedure TListItemDrawableShim.DoSetDrawable(const Drawable: TListItemDrawable);
begin
end;

function TListItemDrawableShim.GetDrawableAlign: TListItemAlign;
begin
  Result := TListItemAlign.Leading;
end;

function TListItemDrawableShim.GetDrawableName: string;
begin
  Result := FDrawableName;
end;

function TListItemDrawableShim.GetDrawableVisible: Boolean;
begin
  Result := True;
end;

function TListItemDrawableShim.GetOpacity: Single;
begin
  Result := 1.0;
end;

function TListItemDrawableShim.GetPersistent: TPersistent;
begin
  Result := FPersistent;
end;

procedure TListItemDrawableShim.SetPersistent(const Value: TPersistent);
begin
  FPersistent := Value;
end;

function TListItemDrawableShim.GetPlaceOffset: TPosition;
begin
  Result := TPosition.Create(TPointF.Zero);
end;

function TListItemDrawableShim.GetShimBoundsRect: TRect;
begin
  Result := BoundsRect.Round;
  Result.Offset(ItemShim.BoundsRect.Round.TopLeft);
end;

function TListItemDrawableShim.CalcAppearanceBounds(const AValue: TRect; const CurrentBounds: TRectF): TRectF;
var
  ShimRect: TRectF;
  DiffA, DiffB: TPointF;
begin

  ShimRect := TRectF.Create(GetShimBoundsRect);
  DiffA := AValue.TopLeft - ShimRect.TopLeft;
  if SameValue(CurrentBounds.Width, 0, TEpsilon.Position) then
    DiffB.X := AValue.Width
  else
    DiffB.X := AValue.BottomRight.X - ShimRect.BottomRight.X;

  if SameValue(CurrentBounds.Height, 0, TEpsilon.Position) then
    DiffB.Y := AValue.Height
  else
    DiffB.Y := AValue.BottomRight.Y - ShimRect.BottomRight.Y;

  Result := CurrentBounds;
  Result.TopLeft := CurrentBounds.TopLeft + DiffA;
  Result.BottomRight := CurrentBounds.BottomRight + DiffB;
end;

function TListItemDrawableShim.GetSize: TPointF;
begin
  Result := TPointF.Create(50, 50);
end;

function TListItemDrawableShim.GetVertAlign: TListItemAlign;
begin
  Result := TListItemAlign.Leading;
end;

procedure TListItemDrawableShim.Paint;
const
  DefaultParams: TListItemDrawable.TParams = (AbsoluteOpacity: 1.0; ItemSelectedAlpha: 1.0;
    DeletingUnwantedOpacity: 1.0; ParentAbsoluteRect: (Left:0;Top:0;Right:0;Bottom:0); Images: nil);
var
  R: TRectF;
begin
  inherited;
  if not FInPaintTo then
  begin
    R := LocalRect;
    R.Inflate(-0.5, -0.5);
    Canvas.Stroke.Thickness := 1;
    Canvas.Stroke.Dash := TStrokeDash.Dash;
    Canvas.Stroke.Kind := TBrushKind.Solid;
    Canvas.Stroke.Color := $A0909090;
    Canvas.DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    Canvas.Stroke.Dash := TStrokeDash.Solid;
  end;
end;

procedure TListItemDrawableShim.SetDrawable(const Drawable: TListItemDrawable);
begin
  FDrawable := Drawable;
  if Drawable <> nil then
    FDrawableName := FDrawable.Name
  else
    FDrawableName := string.Empty;
  DoSetDrawable(Drawable);
end;

procedure TListItemDrawableShim.SetDrawableAlign(const AAlign: TListItemAlign);
begin

end;

procedure TListItemDrawableShim.SetDrawableName(const Value: string);
begin

end;

procedure TListItemDrawableShim.SetDrawableVisible(const Value: Boolean);
begin

end;

procedure TListItemDrawableShim.SetOpacity(const AValue: Single);
begin

end;

procedure TListItemDrawableShim.SetSize(const ASize: TPointF);
begin

end;

procedure TListItemDrawableShim.SetVertAlign(const AAlign: TListItemAlign);
begin

end;

{ TListViewDesignPresentationManager }

constructor TListViewDesignPresentationManager.Create;
begin
  FEnabled := TDictionary<IListViewPresentationParent, Boolean>.Create;
  FCachedAdapters := TDictionary<IInterface, TAppearanceListViewItems>.Create;
end;

destructor TListViewDesignPresentationManager.Destroy;
begin
  FPresentations.Free;
  FEnabled.Free;
  FCachedAdapters.Free;
  FPrototypeData.Free;
end;

function TListViewDesignPresentationManager.AttachPresentation(const AOwner: IInterface): IListViewPresentation;
var
  Presentation: TListViewDesignPresentation;
  Parent: IListViewPresentationParent;
  Enabled: Boolean;
  Reattaching: Boolean;
begin
  Reattaching := IsEnabled(AOwner as TCustomListView);
  DetachPresentation(AOwner);
  if Reattaching then
    Enable(AOwner as TCustomListView);

  if Supports(AOwner, IListViewPresentationParent, Parent) and FEnabled.TryGetValue(Parent, Enabled) then
  begin
    Presentation := TListViewDesignPresentation.Create(AOwner);
    Presentation.Manager := Self;
    if FPresentations = nil then
      FPresentations := TDictionary<IInterface, IListViewPresentation>.Create;
    FPresentations.AddOrSetValue(AOwner, Presentation);
    Presentation.ReloadData;
    Result := Presentation;
  end;
end;

procedure TListViewDesignPresentationManager.DetachPresentation(const AOwner: IInterface);
var
  Presentation: IListViewPresentation;
  Parent: IListViewPresentationParent;
begin
  if Supports(AOwner, IListViewPresentationParent, Parent) and FEnabled.ContainsKey(Parent)
    and (AOwner is TCustomListView) then
    Disable(AOwner as TCustomListView);
  if (FPresentations <> nil) and FPresentations.TryGetValue(AOwner, Presentation) then
    FPresentations.Remove(AOwner);
end;

class function TListViewDesignPresentationManager.Instance: TListViewDesignPresentationManager;
begin
  if FInstance = nil then
    FInstance := TListViewDesignPresentationManager.Create;
  Result := FInstance;
end;

function TListViewDesignPresentationManager.IsEnabled(const AOwner: TCustomListView): Boolean;
begin
  Result := FEnabled.TryGetValue(AOwner as IListViewPresentationParent, Result);
end;

procedure TListViewDesignPresentationManager.Disable(const AOwner: TCustomListView);
var
  Presentation: IListViewPresentation;
begin
  FEnabled.Remove(AOwner);
  if (FPresentations <> nil) and FPresentations.TryGetValue(AOwner, Presentation) then
    TListViewDesignPresentation(Presentation).Disabling := True;

  RetractPrototypeItems(AOwner);
end;

procedure TListViewDesignPresentationManager.Enable(const AOwner: TCustomListView);
var
  Parent: IListViewPresentationParent;
  CurrentlyEnabled: Boolean;
  Presentation: IListViewPresentation;
begin
  if Supports(AOwner, IListViewPresentationParent, Parent) then
  begin
    if not FEnabled.TryGetValue(Parent, CurrentlyEnabled) then
    begin
      if (FPresentations <> nil) and FPresentations.TryGetValue(AOwner, Presentation) then
        TListViewDesignPresentation(Presentation).Disabling := False;
      FEnabled.AddOrSetValue(Parent, True);
      InjectPrototypeItems(AOwner);
    end;
  end;
end;

procedure TListViewDesignPresentationManager.ToggleVerb(const AOwner: TCustomListView);
var
  Parent: IListViewPresentationParent;
begin
  if Supports(AOwner, IListViewPresentationParent, Parent) then
  begin
    if not IsEnabled(AOwner) then
      Enable(AOwner)
    else
      Disable(AOwner);
    Parent.RecreateNativePresentation;
  end;
end;

procedure TListViewDesignPresentationManager.InjectPrototypeItems(const ListView: TCustomListView);
var
  Header, Footer: TListViewItem;
  Postiche: TPosticheItems;
begin
  ListView.BeginUpdate;
  try
    FCachedAdapters.AddOrSetValue(ListView, ListView.Items);
    Postiche := TPosticheItems.Create(ListView);
    Postiche.SetTrueItems(ListView.Items);
    ListView.Items := Postiche;
    Header := ListView.Items.Add;
    Header.Purpose := TListItemPurpose.Header;
    ListView.Items.Add;
    Footer := ListView.Items.Add;
    Footer.Purpose := TListItemPurpose.Footer;
    Postiche.Lock(True);
  finally
    ListView.EndUpdate;
  end;
end;

procedure TListViewDesignPresentationManager.RetractPrototypeItems(const ListView: TCustomListView);
var
  Presentation: IListViewPresentation;
  Current: TAppearanceListViewItems;
  CachedAdapter: TAppearanceListViewItems;
begin
  if FCachedAdapters.TryGetValue(ListView, CachedAdapter) then
    begin
    ListView.BeginUpdate;
    try
      TPosticheItems(ListView.Items).Lock(False);

      if (FPresentations <> nil) and FPresentations.TryGetValue(ListView, Presentation) then
        (Presentation as TListViewDesignPresentation).ItemsWillChange;
      Current := ListView.Items;
      ListView.Items := CachedAdapter;
      FCachedAdapters.Remove(ListView);
      Current.Free;
    finally
      ListView.EndUpdate;
    end;
  end;
end;

function TListViewDesignPresentationManager.PrototypeDataFor(const Appearance: TCommonObjectAppearance;
  const Item: TListViewItem): TValue;
var
  Pair: TPair<TClass, TFunc<TCommonObjectAppearance,TListViewItem,TValue>>;
begin
  InitPrototypeData;
  for Pair in FPrototypeData do
  begin
    if Appearance.ClassType.InheritsFrom(Pair.Key) then
      Exit(Pair.Value(Appearance, Item))
  end;
  Exit(TValue.Empty);
end;

{$REGION 'image resources'}
function TListViewDesignPresentationManager.GetBitmap: TBitmap;
const
  man_1_150 =
{$REGION 'man_1_150.png'}
'{'#13#10 +
'89504E470D0A1A0A0000000D49484452000000960000009608060000003C0171'#13#10 +
'E2000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000'#13#10 +
'19C549444154785EED5D696C5CD7753EE4EC0B6738DCF74D944849A46459F2A2'#13#10 +
'C5766C3846E2A2F913346D7F340D5014A891367FDAA2409B22ED9FB640FBA340'#13#10 +
'8A36309A1F718BA228EA145D82D6698A3A8662C74E62C78AEA4D5E285192494A'#13#10 +
'5C67381C0EB77EDF7D1C7A349AE190A3F766DE7D7CD71893E2CC7B73DFB9DFFD'#13#10 +
'CEB9E79C7B6E5DFB979EDF12B7B912305902F526DFCFBD9D2B01250117582E10'#13#10 +
'2C91800B2C4BC4EADED405968B014B24E002CB12B1BA377581E562C01209B8C0'#13#10 +
'B244ACEE4D5D60B918B044022EB02C11AB7B5317582E062C91800B2C4BC4EADE'#13#10 +
'D405968B014B24E0026B2F6245987E6B734BB6DC70FD5EA4E5C60ACB49697363'#13#10 +
'5336D63744EA44C2B190F8FCDE7297B8EF6F4BC065AC0228909508A8F5B50D89'#13#10 +
'3686A573A05D4E5E382AF77F6A4CDA7A9A01B44D173C7B90800BAC6D216D004C'#13#10 +
'0454BDA74E9A3B1232F6D0613971FEA81C7B705812ED7109C8A6DCBE715BBDEF'#13#10 +
'B6F21238D0C0223B115064A186C688F48D74CB99C7C765ECE123D239D82E8190'#13#10 +
'5F81CD535727D39373925959933AFCEEB6F2123890C052B613D9A9BE4EDABA9B'#13#10 +
'14904E9E1F95C32707942D4556A26D45839D6D133F373C86A8942A748DF8B2C8'#13#10 +
'AA3B48A9C9040A01154B4425DE1295AEC10E8900481EAF07E0D9DC0152A1D448'#13#10 +
'5204D7C71FCDC8CD895BB2BCB4AC8047F6520CA67E1A57E13765EC1FF4E67860'#13#10 +
'6D41DF91A1EAEAEBA1EEC20053BB347726241486D584F7F8FE5E19A81EAC95CD'#13#10 +
'ACC9D25C52FD4CA75624935E9555A8C8D5952C0CFE75F55D042F7D13FCFC4155'#13#10 +
'9D8E0596B1BADB506C94688B49477F1B8CF246B80C7C602618EADB6A6EBFCC42'#13#10 +
'A010306CEA3E1B6441B824A826F133B59096F9E945492DA665693E256BD975F4'#13#10 +
'E1E001CC71C052048401F7FA3CD2DEDBAAD8A909AB3A82C170729A6C2029CDF7'#13#10 +
'89EE53EA11B6DB06D86BE17652E600B29B13D3B2B6BAAEFE4EBBEE203447012B'#13#10 +
'A7F63AC14E7D235D1269A0215EAFD8C974409541478ED908E695744626DFBB29'#13#10 +
'3393B3B2BABA269E6DC67332C01C032C1ADFFE804F0E8DF74B475FAB32A0F763'#13#10 +
'3F5939C80419C13437B328EF5F9A808D9652ECE564FBCB31EE063243EF912EE9'#13#10 +
'1DEEDCB67FF66E945B092A658B41FDAE6315D9D81293538F1D9781633D9FF4D1'#13#10 +
'EA2FAFD1FD1D012C2EFDDBFB5AA4EF709764A16AAAADF6F63A766455AAE681D1'#13#10 +
'1E193AD6E76870690F2C32950F2AB0F770E7CE6A6DAF035D8BCFB1BF5483BDB0'#13#10 +
'01078EF7AADFED3A11EE453EDA038B2CC0D85EBC396E642268D014B8D0CF0184'#13#10 +
'90E8F97762605B7B60D14FD5D10F63DD6C3782C500254BD15B7FE4D4106CAF06'#13#10 +
'C3A9EAA0A635B038F31928660059477542378817395EC327062510F4A9B09253'#13#10 +
'9AD6C06248A6B9BD510D0E3C555A8E0943404D880CB4F5B4948C55EAF8605A03'#13#10 +
'8B1EF6060494BD0899D8155788F8C82AFE975EDB543FB37865D6EF4C73A61AA4'#13#10 +
'ABC407D6D291798B015F5B60D1A4F222EEE75783619F39AD72BCF05A839A2380'#13#10 +
'8248C139D91694270722F285D198FCF2B1B83CD21B86C3B44E7D46F9B9F05F28'#13#10 +
'12906E64AB3AC5D6D2D6F34E15128E8664FCDC08525FC235B54F082682043892'#13#10 +
'A8AF5EBD469AFDF2404750BA1AE00A89F924E4BD3346F8FA54469E7D734EA696'#13#10 +
'37C40F9703172173D30B72E9E5778C6C0CCD130AB505166776A23586F4E151CC'#13#10 +
'7E4FD55508C986361ED98919A6879BFC3210F7014C21196B0D48B00048C538F5'#13#10 +
'9DD9ACFCE92BB72499852F0E0C4635F8E6C5B765766A1141746D95897A546D7B'#13#10 +
'AF1CA33EAF910653255D483051BDD14E0A00386422AAB6AF5D6891AF9E6B9167'#13#10 +
'4E25E44C67704FA0A2F047C16A4F1F6A5000E58BAC156B8A2203C23EAABDD29E'#13#10 +
'68FD08F5488DB15265A89C2EBCD699A10040114CA7019CCF8FC4E48F2FB4CA5F'#13#10 +
'3CD12EBF7434A66CA8067F65A27CFA50545AC35EF53D9C2C5C1D1260559A2B95'#13#10 +
'E2A6EC759549A3EC6DADFF00F39ABC5E0C88C9BE1F0E3019290D2031758AF6D2'#13#10 +
'69A8B7AF9C69923F3CD72A7F70B6557E652C2EC309BFF84CC8AD2220CF758714'#13#10 +
'78C95A81B05F6569E88E2C6D81C59888CFEFB9273703D7640452FE2A4E79C361'#13#10 +
'2F7D7628225F3EDD245F7FAA437EFF6C8B7C1AAB3AAA2E7A36CC6EF7C3C8A769'#13#10 +
'CFFE30BD269AD0D3E19B2F170BC464B6D88BDF8F599BF45F155B3C15F33EE454'#13#10 +
'1AD9886A6D05BB6DA86EC2BE3A690A7AE46C77587E0B40FADA79B01298E9CBF7'#13#10 +
'37C9A3700B9051AC5EA0F560E538D8E893752C48BC50838C24549A3A5D1DE997'#13#10 +
'FF166D578534D8B95DAB07F9575C9EB36D2823D8D0220497E15332545A004C40'#13#10 +
'90B4453C009217BFD7419D05143B7545BDE2AFF146D43F7F75565E9A4C4B03FA'#13#10 +
'76F3EA8C5C7EE53D955EAD6BD31A5847EE1B949E431DC6A65380A80346F0637D'#13#10 +
'616904037165457B9AAE0082868637814550C503F623EA677FBA20FF7E2529D1'#13#10 +
'905766AECFCACF5E79777B7B999ED0B29F842B9023598A0EC8DF7EA849BE8055'#13#10 +
'DA53831179B23F02551691F33D6179A03324275A833218F7DB12547CE421A842'#13#10 +
'829F4C5C0FBF1C5D29F76440562047332F7104B0A8F2C846FD7050EADA7A1ABC'#13#10 +
'B0F7B0F1830E57FCACB771FC732F327604B06086CB09F892A8F6746D54D186F7'#13#10 +
'02A934602CBA536C1402DDB758B50656CEE3CE720A271046D1B945B13ACDED2A'#13#10 +
'22A80CC7AFBED0D21758F48AB38E15744702C67A67545F35C809C16C879DA62F'#13#10 +
'F1EE3C82B6C062AAC93AA88A364922582F311BAEF4F6CBA05ECDD55FFEF36A0B'#13#10 +
'2C6A89CD756C5BC7ECAE673D0507CC720E8C6166557FE7F67E2741B9CF6B0B2C'#13#10 +
'DA23DC95530F875506CCB5CA64288D1B0145B5CE99A21CBCEA71F49D2D1A030B'#13#10 +
'C97548F7256325B39BEAA573CBD0C3BB1D31343BB05E0BB9680B2CA3181A8085'#13#10 +
'A96D004B8F3D85A506F9763AD7FFBA9D2226FAF295C6897E1CA04DA8406EF6E4'#13#10 +
'5C5F5AD55B155E4FAEA9C0B8CE607284F14E3F0F8B9AB18A1ED37AA7D3EBB560'#13#10 +
'7CD3BE7362115501612792892DA9E3655A4FF776236D5521A73681B596451110'#13#10 +
'FCE396E6C05A5ADD909C325486BBDE04AC6FCE3B5D0C2B99AC2C2C6584866FE1'#13#10 +
'2E98BDCD2BFB7C8AE93D3934194573EDD3B74A7AA22D636141285DF180FCFC70'#13#10 +
'837C0E79E39F1D6AA8E4F96D73CD786B08B8AA539B5A99F047E7AFCE069796C0'#13#10 +
'E2DC5E830FEBF367FBE4F79E1A90DFB8AF51BA911DA0737BA23F2CBF89BCFAA7'#13#10 +
'7A83929A9C469D2F3A7FF5A52D2D8145FBC38B8CD09698DE81E7C289F019E491'#13#10 +
'3D73BA59BEF8100AC85558D5D92E934B4F606DD7175DD1DC77550A048F9FEC90'#13#10 +
'AE4450D6342E6DA425B0A820D6608B4C2DAEDA65829ADA0F3271472284946B7D'#13#10 +
'97865A024B394721F38FE7D2A60EA85D6E46BF9CDA726F970E55D00F6D81C5D2'#13#10 +
'0653F32BB2985EABE0B1ED7D49D60141756D81C53D8537E656E4265E4E6B0BA9'#13#10 +
'ACCCA756C5A3712E90BEC042BACC8DD915999849390D5732399B56CF4675A86B'#13#10 +
'D3165874F16C20BBE1D2C482AEB22FD9EFCB57171037348EADD3B5690B2C0ADC'#13#10 +
'0F43EBE2DBB774AF9F711776BE77695A021AEF82E603690D2C1FD4E15BD717E5'#13#10 +
'D66246D7897D57BF3F984ACAA5ABF3A654B2A9A550B40616636949AC0A5FBD32'#13#10 +
'5B4B199AFADDFFFADA0D5958D6FFEC69AD81A5321CE07DFFFEFFCD983AB8B5BA'#13#10 +
'592AB32E2FBCF1B1F2D1696C5E29F1690D2C3E0007E0271FCCA959AE7B7BE9AD'#13#10 +
'19F9D1FBB312AEB03AA09D9E5F7B60D1C87D1B76D6DB938B7692EBBEFBC274AC'#13#10 +
'BFFDEF0F54BEBBCEABC1DC836B0F2C3A119338ECFBBB6F4EED7B30ED74C13FBF'#13#10 +
'7C4D5EBC3C85D5A0F643E20C55C8A708E3C8937FFAC155995ED07375F8C1544A'#13#10 +
'FEE4F9CB709B38E7D455474C0FD63D98BCBD2C5FFD874BB2BAA6D736B08FA697'#13#10 +
'E5996FBC261FE2A753D84AD9BEED5F7A5EE720FA8E3653C7E3C23EF9F4C94EF9'#13#10 +
'85737DE2432CF149E435855900D7868D81E63FFBF65BF2ED1F4ECAC4744A8236'#13#10 +
'ED67A5A2730CB028001AC0193096170C160BF9E4D25FFE9C34A0F4A21DDB3F5E'#13#10 +
'BC2ABFF6573F443CB0DE71A07284BB211F34743D8430F31961E3EA2AB992B523'#13#10 +
'A66419F9EC7FF7E2842AAEE634A672CCAAB018723860AB503597AF2DD91258DF'#13#10 +
'C30AF6E57766D424706A7384F15E3838F4C82FC38BFD9FAFDFB4DDB86D80499F'#13#10 +
'FDEEFB2A3B94FD746A7324B03858CC7CF8B71F5D575E793BB57F81B1FECABBB7'#13#10 +
'1DB5022CAA35EC247433FB42A3F8F6D2AAFCEE73AFDB26CB7461392B7FF35F57'#13#10 +
'D486549EACE1E4E658C6E2A0D18679F5DD59F9F5BF7ED516B1C46FFDEF47F21A'#13#10 +
'323142017BAE54CD04BAA381454135E068DF172F4FCB375EB862A6DCF67DAFB7'#13#10 +
'10CBFCFA77DE93C0F6AA75DF37D0EC02C7038B1A87CCF5F7DF9F006BD5C6FDB0'#13#10 +
'88CC8BDFF9D61B0839ADE0F43067AB4047BB1B0A27B70799A61CD45AE46DD1ED'#13#10 +
'F1956FFE582E2225268243020E4A733E636124B9AA6742E00F901F5FEDC615E0'#13#10 +
'7FFCF886631DA1A5E4792080957BF80F109333EA5055AF4D63532DFD554E5F05'#13#10 +
'164AF4C0008BB6CDD47C466E57B9DE03D59F931DA1079EB198103887DDC5B3C9'#13#10 +
'EA1612E96D09ABA0384FD23848EDC03016E3878B5815F255CD76A83D8A0C0B9F'#13#10 +
'E3F63E9693E1C10116EC9C340AC82657AB7BD040087EB491AE06C96267F3416A'#13#10 +
'070658AB28DB3D36D42CF1F646998636AC06BE92A8107E0DD9D28F9C3F22C170'#13#10 +
'5095D93E28EDC0000B651EE4F86897743605640A65B53E422D11D4ECB7A4113F'#13#10 +
'37F11DD7F01D2CCAD7D71E133F8C78DD4FA6DF8FB00E04B078344A241E92A6EE'#13#10 +
'66A843D42F658D780CF80406FEDAB2A0DEE77E44B6FB6797C152BCEF2D7C0F6F'#13#10 +
'BB85FF65EBEA25DE1C839D65E21799D7654BEEE4786031179EFBF486C7FA84AA'#13#10 +
'697E651375A78C4AD7749C2EC096277BCD4065B10276A50DE69B7C8C525DBC57'#13#10 +
'0ADFC30A44142E017C13591603A33DD2D6D32C1B9A6DF6A8541E8E07D6067451'#13#10 +
'2B98AA03AF29B81AA6935935E8B9C6D01D196B0AA0B89214B90E1586D3476405'#13#10 +
'40D9AD0428DFE36708CC09B01EAFBD0D701A097CDB7767A925FCE1C3B98C84C3'#13#10 +
'7E193D3D2C2D5D4D07025C8E0616CF336C86B17EE4BE41A9079A5885F83D1434'#13#10 +
'2BB4A189038281471ECE41855D05EB509D917DF8A2BACC7FE5FE9E53A5C0AA6A'#13#10 +
'64C0FC10330FA2FF084ED9591CC7B20575EC0FF8E4E803C3D2DC99C00101CE5E'#13#10 +
'253A16580455ACA9418E9E392401FA91802626FF5D9E599159504DB124831CC0'#13#10 +
'080896A7C2FE51E1D14F19EEFE01ABA9177EE7DFF81E3F835B172DE0611C7BB7'#13#10 +
'25AF5D4F81118D53BD68EB05827E39F6E06169EB6A566701F15C6BAAEB2A479A'#13#10 +
'2AD5707BBECE59DBBF30909B1C240C600CC6F2D84387251C0BA9E3E7728D65BC'#13#10 +
'3F351897A70FC770BCC8DD72225826A10B5F9A582A5BF1856088A080C7670E37'#13#10 +
'AA74987C70709FC4FBB3ABF2DC9BB7D57EC77C20F354D835B83FA6AFDD9699EB'#13#10 +
'B3B2925AC1296638A4892023087914310D418D9BD6C032663AC004B0D0B3EE07'#13#10 +
'1BF8A06EA2F1B00CC1580F4783EA78DFFCC6416E097BE5574FB54973C87397C1'#13#10 +
'4E60DD585A936FFE644616B04DCBB3CB8607DE6BAC3D2C5F3CD9BA7D36EA27DF'#13#10 +
'44D6FB9F0F97E485F71724C87F14B43AF4977DA64A24F0D3C98C2CCE2EC9D2FC'#13#10 +
'B22C2FA6653999562C4B80E95824443B60E5540705EE43CD86686344E25079D1'#13#10 +
'C6B004C2010904FC00984FB14D31BF11EDAB00FC0D04C360C22F85875BA8F302'#13#10 +
'F199E77E7A4BDE9DCD48609702B33C8BFA7323097974009EF53CFCE654EA77AE'#13#10 +
'2CC8C5AB49F1EF720F03B7C6695F7560329AFFE954469697D23237B528B353F3'#13#10 +
'92595E556A54279079A2F7FDE21FE9C0B80414851B6E08492B96EDBDC35D8A95'#13#10 +
'BA06DBA509067A341E912018CB037660C0B7A4CD8201E4095BC7DBC2D21EF516'#13#10 +
'7531301FEF067C1393C88428C5585CFD51FD5DE88F494BC4AB1CA1B946ACD006'#13#10 +
'FBD9741A2BD1B53D95D556078C03F57CF9FD06EB26DAE3D2D9DF06E60D2966CE'#13#10 +
'A4B38AE1EAE017B3FBCE315B2B720A9BAA8C3FE32D3118E2C372F291A372FCC1'#13#10 +
'23D239D00AA3DCAF9661041D3F471B45B1D42E91130E3AF7F6F1E0C952E053DE'#13#10 +
'F2B8DFB09B4ACC3AA552B17DBF196AB5D891376ABB3F8FE2AD20139913883617'#13#10 +
'41E6F17AA46BA85DC6CF8ECAA9C78E6342752A15AAEC311B5BFCB60516054784'#13#10 +
'D00775E2C2A8DC0FA1761F42910FCC5E1ED7BB23D80AC26FB459E65770EC6F89'#13#10 +
'6BE97BEA89F9A106219E129F217E5B223E49043D77FBBB0876FAB9E81DBDC746'#13#10 +
'F070D2D0266BC4E41AB97F48CE3C312EADF087F13938A9ECD86C072C320E4193'#13#10 +
'688BCB89F34765FCDC88B47424947AA380CD102457680BD829CD31294628C66A'#13#10 +
'CF0355E953ABCCC2C6BFD06CEA6AF0292F7E31E250AAAB42C62A06941CC0F8FC'#13#10 +
'11A8C9B1878F28B7056DCC9CDD692780D90A58B41F68788F9C1A92F18747D4AC'#13#10 +
'E4A8A9955D05CC544AD004D3420620E53D4BA82A16D61B680C940CF3F880CEDD'#13#10 +
'DEE7AD8D53E92BD0856510422091ADDA7A9BE5CCE363D23FDAADAE3063D29905'#13#10 +
'4E5B00CB70196C4AD7409B9C7A1476C4E14EF162DD4F95678519C154613256A9'#13#10 +
'6C03C54890CC0E2315489BFDFD84D1EE1E0A42690DA8CD42A79A0F2BE3FB94CC'#13#10 +
'085C747468AC574E5E38AAD8ABD0BD621650F67B9F9A032B37B883C77AE518C2'#13#10 +
'1D5164211806BB89145520150E76666D4B5230904B0D3CD9AC153654130CF4C2'#13#10 +
'0D187CAF07C67D80FEA912DDA47D65E123EC3C91CAF1A2BD07763F716E549A61'#13#10 +
'36D8015C350516598ABEA8E1F101193CDEAB0662E35E520CF63AAD9471BD0503'#13#10 +
'BE786847A915F4858ECD1074622140B822EC83715F0A57B4E1685F15B3CFF6DA'#13#10 +
'C5FD7C8EFD5B477828180928BB8B0B9E5A6751D40C589C553442B984EE1BE932'#13#10 +
'7C38D598E2DB2346E0501D96720790C9B8D994CC568CD58C2D5DA55B3AC75856'#13#10 +
'E9C2225FCD891A808D4AB74C5B6F4B4D99AB26C0DAD8D8500ECDF1B323D2008F'#13#10 +
'B9D5AAAF700C38D6EB003181556AC77B8E7532E86BE1F62DFE9B7EB052AB4A82'#13#10 +
'D560ACFDF08E399FE58ADA8715EDE8E943C8FF6A51FEB05AB4AA038BCEBF68CC'#13#10 +
'0015BDCB55517DC566375521196B17A9D343BF5AC4D9C56B9288E194F2201936'#13#10 +
'1C6CAC5A8C28D538BDF7A868A3C08595632D6CAEAA028BEA8ECBE4FEA33D124D'#13#10 +
'446A369B38DE5464CBC8F0439CB9286BE5188BEAB090D5C848DCEDC33CFA62C8'#13#10 +
'24B0E86AA08D55454D78078C73CC7514E06AEA68ACFA04AE1AB072F6D3D0F13E'#13#10 +
'E980FEA7B159CBC6014F67B76419CC52CA49BA0C562AC63A0A58CCA52AC54978'#13#10 +
'7F054C574593B1A82815736DDB5CF1966855FD5CD503161EB2F74897F48F7457'#13#10 +
'D5482F055EB2501AF607DD02C5EC2C8675C868C5525610029614DEE3EAB01828'#13#10 +
'1563E1BED55A15EE3641696A84903ED43FD2A3C242D5027B5580C5D54A039C77'#13#10 +
'43F055199907B5B23E3E1902026619C0222B15AE0C090C1ADE29BE5762D4082A'#13#10 +
'02AF58CB05A06BFF9446EFE87A6014A31F1B3AAA257BCB81453AF6C1901C1AEF'#13#10 +
'977AA6B4D462A95464F4C952B483F82AC65806B08ABFA7322A809E145686C5EC'#13#10 +
'2FC69ED7B633416BA9EEF3BF9B801A846DDB84186C35568A96038BA9B65D03ED'#13#10 +
'70DA355555C7EF6540C92CF3B99861FE050A38862A2CD5F83E5786858CC67F67'#13#10 +
'19CE818D552BC3BD388B1AD9A803882B725387D54B564B81A55C0B5081DDC31D'#13#10 +
'3559F2960317FD518B7039D0D95F0802CE70867C8A952052AA52E574DD9D6F45'#13#10 +
'B5CABC7AC60A2BC9C52AD7E77B799F6E874630161325E94BB4B2590A2C0E57F7'#13#10 +
'50878422F6AC5BC0816758A7987626D8D2BB311646852BC362F61983CF6B3663'#13#10 +
'AC7C10F51DE954E11FEE15B0AA59062CAE469853D58DEC473BA573E40B329797'#13#10 +
'A502E1799445A1302443EF7C2975C66B5264AC8291E1BFB97F31B7E5CBAA81AB'#13#10 +
'F4BE2A9F2B16968EBE564B0D79CB8085B46CE5AF5239E8365805161B083A4917'#13#10 +
'6180DF95E80974A4C046E5FA4DF031627207B8F00FDA572A92622723EB4E4B5E'#13#10 +
'3A07DBB0F9C45FF6192B05B025C052B61562812D5DF648E128251C835D682BDD'#13#10 +
'193324937145B85B22206D2FC603E908CD5F19AA7BD278E7AE1A9B228B6CCB14'#13#10 +
'EF76D85A5669134B804597027797709F9F4DC9CAC0DAB6DB8076563EB9F0F71D'#13#10 +
'609540652ED04C70E55FCCBFE7568536C595F1E8CC4045909AFB30CB317325AC'#13#10 +
'653AB03803B8458BF509ACE870250FB91B6371F6166639101C748EEE16EBCB07'#13#10 +
'56A12F8BA7A73239D0AE9A90F2D8C4AA30DEDC2089D6D81D3BC5CD92AFF9C082'#13#10 +
'408D7D7E61CB68D6AC87E77D18B12C04168542AFFC6EBE5CDA6719A841B56122'#13#10 +
'AF4386D7DDBAD59659CFCE7E32C4D3D2D964C9767E5381C5CE7AB10FAE056C45'#13#10 +
'3B4B8746B54D60E554762E9C43E7E86E8C9BF3DC1358F98C4530324E68371F56'#13#10 +
'B1B1A0766946E68315EAD054607174E81FE1FE37BB846ECA819BB6461A59A23B'#13#10 +
'463890C562214C9729870E026F191912F9A0B472774EB967D9EFFB8CDB125489'#13#10 +
'36F3C7CB546091A5A806EDEC622814BE91E580A21CDB590E1408594831519991'#13#10 +
'22285526699EE6236315AAC7FD0E78D53E8FBE7A10E6610D31B3EBA39693DDFE'#13#10 +
'9E1182A65354A7123C547D469683612B5185316B94D9A3E5D499B17A346CB19C'#13#10 +
'9D45F622486D6DB9E7DB8460AD30ECE1207D5A26260898062CB25510D55E4278'#13#10 +
'998DFEFDA17B7F9F661D04DA448AB1208DFCD55E396091ED9260AC9DF150EE0B'#13#10 +
'8D184BAD0EB754C88D2F33ED62D380C5991A819B81AE865C4159AA0ABBBF94A3'#13#10 +
'13C2CDC090E5762EBE729B4DEB555597D2CFC06B93DB9B15EA51578BC0E44657'#13#10 +
'DE4FEDE2D1E0C56948420823CC63A6CFD1BC3246E895177B0469085215722690'#13#10 +
'B9F47861DB14E8A72DEC835DB525D7E657E58D9B29A9C364D9B5FF28AFBD0543'#13#10 +
'FF443BAA06E259D761975D45CDD1D7AE25D5B9CF542D767F7E1AF0D995AC7C7C'#13#10 +
'F596ACA256395D106634D30BAF1995EA4884F6F7E5E40B90B3D5874A1F641A96'#13#10 +
'395269C765656C7C80751CD8F8795EC7EB8D94661D64807465F659D583300352'#13#10 +
'C63D4C079641A73A08F46E21EEA80208783F32BE4385ECF35AF386F2DEEE6476'#13#10 +
'394AD381756F8FE75EED14099866BC3B4520EE739823011758E6C8D1BD4B8104'#13#10 +
'5C60B990B044022EB02C11AB7B5317582E062C91800B2C4BC4EADED405968B01'#13#10 +
'4B24E002CB12B1BA377581E562C01209B8C0B244ACEE4D5D60B918B044022EB0'#13#10 +
'2C11AB7BD3FF07FDDE21383BBCEE970000000049454E44AE426082}';
{$ENDREGION}
var
  LTextStream: TStream;
  LParser: TParser;
  LBinaryStream: TStream;
begin
  LParser := nil;
  LBinaryStream := nil;
  LTextStream := nil;
  Result := nil;
  try
    try
      LTextStream := TStringStream.Create(man_1_150);
      LTextStream.Seek(Longint(0), soFromBeginning);
      LParser := System.Classes.TParser.Create(LTextStream);
      LBinaryStream := TMemoryStream.Create;
      LParser.HexToBinary(LBinaryStream);
      LBinaryStream.Seek(Longint(0), soFromBeginning);
      Result := TBitmap.CreateFromStream(LBinaryStream);
    finally
      LParser.Free;
      LTextStream.Free;
      LBinaryStream.Free;
    end;
  except
    LParser.Free;
    LTextStream.Free;
    LBinaryStream.Free;
  end;
end;
{$ENDREGION 'image resources'}
function TListViewDesignPresentationManager.GetBitmap(const AIndex: string): TBitmap;
const
  // Arbitrary colors for bitmaps
  CColorValues: array[0..10] of TAlphaColor = (TAlphaColorRec.Darkblue, TAlphaColorRec.Darkcyan,
    TAlphaColorRec.Darkgoldenrod, TAlphaColorRec.Darkgray, TAlphaColorRec.Darkgreen, TAlphaColorRec.Darkgrey,
    TAlphaColorRec.Darkkhaki, TAlphaColorRec.Darkmagenta, TAlphaColorRec.Darkolivegreen, TAlphaColorRec.Darkorange,
    TAlphaColorRec.Darkorchid);
var
  Bmp: TBitmap;
  C: TCanvas;
  LColor: TAlphaColor;
  LWidth: Integer;
  LHeight: Integer;
  LColorIndex: Integer;
  LRect: TRectF;
begin
  LWidth := 100;
  LHeight := 100;
  LColorIndex := Abs(AIndex.GetHashCode) mod Length(CColorValues);
  Assert(LColorIndex >= 0);
  Assert(LColorIndex < Length(CColorValues));
  LColor := CColorValues[LColorIndex];

  Bmp := TBitmap.Create(LWidth,LHeight);
  C := Bmp.Canvas;

  C.BeginScene;
  try
    C.Fill.Color := LColor;
    C.Stroke.Color := LColor;
    C.FillRect(RectF(0,0,LWidth,LHeight),0,0,[],1);

    C.Fill.Color := TAlphaColorRec.Black;
    C.Stroke.Color := TAlphaColorRec.Black;
    C.Stroke.Thickness := 5;
    C.DrawRectSides(RectF(0,0,LWidth,LHeight), 0, 0, [TCorner.TopLeft, TCorner.TopRight, TCorner.BottomLeft, TCorner.BottomRight],
      1, [TSide.Top, TSide.Left, TSide.Bottom, TSide.Right], TCornerType.Round);

    C.Fill.Color := TAlphaColorRec.White;
    C.Stroke.Color := TAlphaColorRec.White;
    C.Font.Size := 24;
    LRect := TRectF.Create(0, 0, LWidth, LHeight);
    C.MeasureText(LRect, AIndex, False, [], TTextAlign.Leading, TTextAlign.Leading);
    C.FillText(RectF(0, 0, LWidth, LRect.Height + 20), AIndex, False, 1, [], TTextAlign.Center, TTextAlign.Center);
  finally
    C.EndScene;
  end;

  Result := Bmp;
end;


procedure TListViewDesignPresentationManager.InitPrototypeData;
const
  PurposeStrings: array [TListItemPurpose] of string = (SItemPurpose, SHeaderPurpose, SFooterPurpose);
begin
  if FPrototypeData <> nil then
    Exit;
  FPrototypeData := TDictionary<TClass, TFunc<TCommonObjectAppearance,TListViewItem,TValue>>.Create;
  FPrototypeData.Add(TCustomTextObjectAppearance,
    function(Appearance: TCommonObjectAppearance; Item: TListViewItem): TValue
    var
      Name: string;
    begin
      if Length(Appearance.DataMembers) > 0 then
        Name := Appearance.DataMembers[0].Key
      else
        Name := Appearance.Name;
      Result := Format(SPrototypeText, [PurposeStrings[Item.Purpose], Name]);
    end);
  FPrototypeData.Add(TCustomImageObjectAppearance,
    function(Appearance: TCommonObjectAppearance; Item: TListViewItem): TValue
    begin
      Result := GetBitmap(Appearance.Name);
    end);
  FPrototypeData.Add(TCustomTextButtonObjectAppearance,
    function(Appearance: TCommonObjectAppearance; Item: TListViewItem): TValue
    begin
      Result := TValue.Empty;
    end);
  FPrototypeData.Add(TCustomGlyphButtonObjectAppearance,
    function(Appearance: TCommonObjectAppearance; Item: TListViewItem): TValue
    begin
      Result := True;
    end);
                                                
                                                              
                                                                                      
                 
                                     
                 
end;

procedure TListViewDesignPresentationManager.MakeBeautifulData(const ListView: TCustomListView; const Item: TListViewItem);
var
  AppearanceOwner: IPublishedAppearanceOwner;
  CommonAppearance: TCommonObjectAppearance;
  AppearanceObjects: TItemAppearanceObjects;
  Objects: TArray<TCommonObjectAppearance>;
  Data: TValue;
begin
  Item.BeginUpdate;
  try
    if Supports(ListView, IPublishedAppearanceOwner, AppearanceOwner) then
    begin
      AppearanceObjects := TUtils.GetAppearanceProperties(AppearanceOwner, Item.Purpose).Objects;
      if AppearanceObjects <> nil then
      begin
        Objects := TUtils.GetAppearanceProperties(AppearanceOwner, Item.Purpose).Objects.Objects;
        if Objects <> nil then
          for CommonAppearance in Objects do
            if not Item.HasData[CommonAppearance.Name] then
            begin
              Data := PrototypeDataFor(CommonAppearance, Item);
              if not Data.IsEmpty then
                Item.Data[CommonAppearance.Name] := Data;
            end;
      end;
    end;
  finally
    Item.EndUpdate;
  end;
end;

{ TListViewDesignPresentation }

constructor TListViewDesignPresentation.Create(AOwner: IInterface);
begin
  inherited Create;
  Supports(AOwner, IListViewPresentationParent, FParent);
  Supports(AOwner, IListItemStyleResources, FStyleResources);
  Supports(AOwner, IPublishedAppearanceOwner, FAppearanceOwner);
  FControl := TControl(AOwner);

  FBackground := TRectangle.Create(nil);
  FBackground.Name := 'background_rect';
  FBackground.Locked := True;
  FBackground.Stored := False;
  FBackground.Align := TAlignLayout.Contents;
  FBackground.Parent := FControl;
  FBackground.Fill.Color := TAlphaColorRec.Pink;
end;

function TListViewDesignPresentation.GetItemsList: TList<TListItemShim>;
begin
  if FItemsList = nil then
    FItemsList := TList<TListItemShim>.Create;
  Result := FItemsList;
end;

destructor TListViewDesignPresentation.Destroy;
begin
  FBackground.Free;
  ItemsWillChange;
  FItemsList.Free;
  inherited;
end;

procedure TListViewDesignPresentation.AncestorVisibleChanged(const Visible: Boolean);
begin
  inherited
end;

procedure TListViewDesignPresentation.EditModeChanged;
begin
end;

procedure TListViewDesignPresentation.ItemInvalidated(const Item: TListItem);
begin
  ReloadData;
end;

procedure TListViewDesignPresentation.ItemsUpdated;
begin
  ReloadData;
end;

procedure TListViewDesignPresentation.ItemsWillChange;
var
  I: Integer;
begin
  for I := ItemsList.Count - 1 downto 0 do
    ItemsList[I].Free;
  ItemsList.Clear;
end;

procedure TListViewDesignPresentation.OrderChanged;
begin

end;

procedure TListViewDesignPresentation.ParentChanged;
begin
  inherited;
end;

procedure TListViewDesignPresentation.ReloadData;
var
  I: Integer;
  Top: Single;
  ItemRect: TRectF;
  Shim: TListItemShim;
  ListItem: TListItem;
  AppearanceProperties: TItemAppearanceProperties;
begin
  if FReloading or FDisabling then
    Exit;

  FReloading := True;
  try
    FBackground.Fill.Color := FParent.GetBackgroundStyleColor;

    ItemsWillChange;

    Top := 0;
    for I := 0 to FParent.GetItemCount - 1 do
    begin
      ItemRect := FParent.GetItemClientRect(I);
      ItemRect.Offset(0, Top);
      if ItemRect.Top > FParent.GetContentFrame.Height then
        Break;
      ListItem := FParent.GetAdapter[I];
      FManager.MakeBeautifulData(FParent as TCustomListView, TListViewItem(ListItem));
      if I < ItemsList.Count then
        Shim := ItemsList[I]
      else
      begin
        if ListItem.Purpose = TListItemPurpose.None then
        begin
          AppearanceProperties := TUtils.GetAppearanceProperties(FAppearanceOwner, ListItem.Purpose,
            not FAppearanceOwner.IsEditMode);
          if AppearanceProperties <> nil then
            (AppearanceProperties as IDesignablePersistent).Unbind;
        end;

        AppearanceProperties := TUtils.GetAppearanceProperties(FAppearanceOwner, ListItem.Purpose);
        Shim := TListItemShim.Create(AppearanceProperties, FAppearanceOwner);
        (AppearanceProperties as IDesignablePersistent).Bind(Shim);
        ItemsList.Add(Shim);
      end;
      Shim.Parent := FControl;
      Shim.SetBounds(ItemRect.Left, ItemRect.Top, ItemRect.Width, ItemRect.Height);
      Shim.ListItem := ListItem;
      Shim.StyleResources := FStyleResources;
      Top := Top + ItemRect.Height;
    end;
  finally
    FReloading := False;
  end;
end;

procedure TListViewDesignPresentation.SetItemIndex(const ItemIndex: Integer);
begin
end;

procedure TListViewDesignPresentation.SetItemSelected(const ItemIndex: Integer; const Value: Boolean);
begin
end;

procedure TListViewDesignPresentation.SizeChanged;
begin
end;

procedure TListViewDesignPresentation.StatusChanged;
begin

end;

procedure TListViewDesignPresentation.StopPullRefresh;
begin
end;

{ TListItemTextShim }

procedure TListItemTextShim.DoSetDrawable(const Drawable: TListItemDrawable);
begin
end;

{ TDesignPresentationService }

function TDesignPresentationService.AttachPresentation(const AOwner: IInterface): IInterface;
begin
  Result := TListViewDesignPresentationManager.Instance.AttachPresentation(AOwner);
end;

procedure TDesignPresentationService.DetachPresentation(const AOwner: IInterface);
begin
  TListViewDesignPresentationManager.Instance.DetachPresentation(AOwner);
end;

{ TUtils }

class function TUtils.GetAppearanceProperties(Owner: IPublishedAppearanceOwner;
  Purpose: TListItemPurpose): TItemAppearanceProperties;
begin
  Result := GetAppearanceProperties(Owner, Purpose, Owner.IsEditMode);
end;

class function TUtils.GetAppearanceProperties(Owner: IPublishedAppearanceOwner; Purpose: TListItemPurpose;
  const EditMode: Boolean): TItemAppearanceProperties;
begin
  case Purpose of
    TListItemPurpose.None:
      if EditMode then
        Result := Owner.ItemEditAppearanceProperties
      else
        Result := Owner.ItemAppearanceProperties;
    TListItemPurpose.Header:
      Result := Owner.HeaderAppearanceProperties;
    TListItemPurpose.Footer:
      Result := Owner.FooterAppearanceProperties;
    else
      Result := Owner.ItemAppearanceProperties;
  end;
end;

class procedure TUtils.ResetSprigBinding(const ItemShim: TListItemShim; const Owner: IPublishedAppearanceOwner);
var
  AppearanceProperties: TItemAppearanceProperties;
  Designable: IDesignablePersistent;
begin
  if ItemShim.Purpose = TListItemPurpose.None then
  begin
    AppearanceProperties := TUtils.GetAppearanceProperties(Owner, ItemShim.Purpose, not Owner.IsEditMode);
    if Supports(AppearanceProperties, IDesignablePersistent, Designable) then
      Designable.Unbind;
  end;
  AppearanceProperties := TUtils.GetAppearanceProperties(Owner, ItemShim.Purpose);
  if Supports(AppearanceProperties, IDesignablePersistent, Designable) then
    Designable.Unbind;
end;


{ TPosticheItems }

function TPosticheItems.DoAddItem(const Index: Integer): TListViewItem;
begin
  if FLocked then
    Result := FTrueItems.AddItem(Index)
  else
    Result := inherited;
end;

procedure TPosticheItems.DoClear;
begin
  if FLocked then
    FTrueItems.Clear
  else
    inherited;
end;

// TListViewItemEditorObject.CurrentItem uses UnfilteredItems to obtain current item
function TPosticheItems.DoGetUnfilteredItems: TListItemsList;
begin
  if FLocked then
    Result := (FTrueItems as IListViewFilterable).UnfilteredItems
  else
    Result := inherited;
end;

procedure TPosticheItems.DoResetViews(const APurposes: TListItemPurposes);
var
  State: Boolean;
begin
  State := FLocked;
  Lock(False);
  try
    inherited;
  finally
    Lock(State);
  end;
end;

procedure TPosticheItems.Lock(const State: Boolean);
begin
  FLocked := State;
end;

procedure TPosticheItems.SetTrueItems(const Adapter: TAppearanceListViewItems);
begin
  FTrueItems := Adapter;
end;

initialization
  RegisterFmxClasses([TListItemShim]);
  TPlatformServices.Current.AddPlatformService(IFMXListViewPresentationService, TDesignPresentationService.Create);
end.
