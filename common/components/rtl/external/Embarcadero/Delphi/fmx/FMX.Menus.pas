{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Menus;

interface

uses
  System.Classes, System.Types, System.UITypes, System.Rtti,
  FMX.Types, FMX.Forms, FMX.StdCtrls, FMX.ActnList, FMX.Messages,
  FMX.Controls, FMX.Styles;

type

  TStartMenuLoopMessage = class(FMX.Messages.TMessage)
  private
    FRoot: IRoot;
  public
    constructor Create(const ARoot: IRoot);
    property Root: IRoot read FRoot;
  end;

{ Menus }

  TMenuItem = class;

  ///<summary> This is a interface used to define different menu views.
  ///</summary>
  IMenuView = interface(IControl)
    ['{C211C5EA-789A-48C3-9739-900782101C51}']
    function GetLoop: Boolean;
    procedure SetLoop(const Value: Boolean);
    function GetParentView: IMenuView;
    procedure SetParentView(const Value: IMenuView);
    function GetChildView: IMenuView;
    procedure SetChildView(const Value: IMenuView);
    function GetSelected: TMenuItem;
    procedure SetSelected(const Value: TMenuItem);
    function GetIsMenuBar: Boolean;
    function GetItemsCount: Integer;
    function GetItem(const AIndex: Integer): TFmxObject;
    { access }
    property IsMenuBar: Boolean read GetIsMenuBar;
    property Loop: Boolean read GetLoop write SetLoop;
    property ParentView: IMenuView read GetParentView write SetParentView;
    property ChildView: IMenuView read GetChildView write SetChildView;
    property Selected: TMenuItem read GetSelected write SetSelected;
  end;

  IFMXMenuService = interface(IInterface)
    ['{8338685D-26BB-4421-AE54-1DC8456DC2A0}']
    procedure StartMenuLoop(const AView: IMenuView);
    function ShortCutToText(ShortCut: TShortCut): string;
    procedure ShortCutToKey(ShortCut: TShortCut; var Key: Word; var Shift: TShiftState);
    function TextToShortCut(Text: string): integer;
    procedure CreateOSMenu(AForm: TCommonCustomForm; const AMenu: IItemsContainer);
    procedure UpdateMenuItem(const AItem: IItemsContainer; AChange: TMenuItemChanges);
    procedure DestroyMenuItem(const AItem: IItemsContainer);
    function IsMenuBarOnWindowBorder: boolean;
    procedure UpdateMenuBar;
  end;

{ TMenuItem }
  /// <summary> This class describe the role and functionality of a menu item.
  ///  This object is used to populate different types of menus defined in FMX:
  ///  main menu, menu bar, popup menu.
  /// </summary>
  TMenuItem = class(TTextControl, IItemsContainer, INativeControl, IGroupName)
  private
    FContent: TContent;
    FNoItemsContent: TFmxObject;
    FIsSelected: Boolean;
    FPopupTimer: TTimer;
    FShortCut: TShortCut;
    FShortCutObject: TFmxObject;
    FSubmarkObject: TFmxObject;
    FCheckmarkObject: TFmxObject;
    FGlyphObject: TFmxObject;
    FBitmapObject: TFmxObject;
    FHandle: TFmxHandle;
    FIsChecked: Boolean;
    FBitmap: TBitmap;
    FAutoCheck: Boolean;
    FRadioItem: Boolean;
    FGroupName: string;
    FMenuService: IFMXMenuService;
    FClickImmediately: Boolean;
    procedure SetIsSelected(const Value: Boolean);
    function GetMenuView: IMenuView;
    procedure DoPopupTimer(Sender: TObject);
    procedure SetShortCut(const Value: TShortCut);
    function GetShortCut: TShortCut;
    function ShortCutStored: Boolean;
    procedure SetBitmap(const Value: TBitmap);
    procedure TurnSiblingsOff;
    function GetRadioItem: Boolean;
    procedure SetRadioItem(const Value: Boolean);
    function GetIsChecked: boolean;
    procedure SetIsChecked(const Value: boolean);
    function IsCheckedStored: boolean;
    function GetGroupName: string;
    procedure SetGroupName(const Value: string);
    function GroupNameStored: boolean;
    function GetGroupIndex: Integer;
    procedure SetGroupIndex(const Value: Integer);
    procedure UpdateGroup(const Value: string);
    function RadioItemStored: Boolean;
    function GetAutoCheck: Boolean;
    procedure SetAutoCheck(const Value: Boolean);
    function AutoCheckStored: Boolean;
    procedure AddNoItemObject(const AObject: TFmxObject);
    function GetHandle: TFmxHandle;
    procedure SetHandle(const Value: TFmxHandle);
    function GetHandleSupported: boolean;
    function GetItems(const Index: Integer): TMenuItem;
  protected
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure Click; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure SetText(const Value: string); override;
    function EnterChildren(AObject: IControl): Boolean; override;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    function GetVisibleItemsCount: Integer;
    procedure Move; override;
    procedure Resize; override;
    function CalcVisibleObjectsItemSize(const ACanvas: TCanvas; APointF: TPointF): TPointF;
    { style }
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    { IItemContainer }
    function GetItemsCount: Integer;
    function GetItem(const AIndex: Integer): TFmxObject;
    procedure SetVisible(const AValue: Boolean); override;
    procedure SetEnabled(const Value: Boolean); override;
    procedure DialogKey(var Key: Word; Shift: TShiftState); override;
    { OS Menu }
    property Handle: TFmxHandle read GetHandle write SetHandle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    { menu }
    function CalcSize: TPointF;
    function CalcRenderSize: TPointF;
    { menus }
    procedure Popup;
    procedure NeedPopup;
    function HavePopup: Boolean;
    property View: IMenuView read GetMenuView;
    property ItemsCount: integer read GetItemsCount;
    property Items[const AIndex: Integer]: TMenuItem read GetItems;
  published
    property Action;
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property Cursor;
    property DesignVisible;
    property Enabled default True;
//    property Hint;
    property HitTest default True;
    property IsSelected: Boolean read FIsSelected write SetIsSelected stored False;
    property Locked default False;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property AutoCheck: Boolean read GetAutoCheck write SetAutoCheck stored AutoCheckStored default False;
    property GroupIndex: Integer read GetGroupIndex write SetGroupIndex stored GroupNameStored default 0;
    /// <remarks>
    ///   If set action, then the value of the property RadioItem depends on the number of Action.GroupIndex.
    /// <para><c>RadioItem = (Action.GroupIndex &lt;&gt; 0)</c></para>
    /// </remarks>
    property RadioItem: Boolean read GetRadioItem write SetRadioItem stored RadioItemStored default False;
    property IsChecked: Boolean read FIsChecked write SetIsChecked stored IsCheckedStored default False;
    property ShortCut: TShortCut read GetShortCut write SetShortCut stored ShortCutStored;

//    property ShowHint default False;
    property StyleLookup;
    property Text;
    property TouchTargetExpansion;
    property Visible default True;

    {events}
    property OnApplyStyleLookup;
    {Mouse events}
    property OnClick;
  end;

{ TPopupMenu }
   ///<summary> This class implement a popup type menu. To open this popupmenu you
   /// to specify the call Popup(X, Y) where X, Y are the top left coordinates of the 
   /// menu placement rectangle. 
   ///</summary>
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TPopupMenu = class(TCustomPopupMenu, IItemsContainer)
  private
    FContent: TContent;
    FNoItemsContent: TFmxObject;
    FPopupPoint: TPoint;
    FMenuService: IFMXMenuService;
    procedure AddNoItemObject(const AObject: TFmxObject);
    { IItemContainer }
    function GetItemsCount: Integer;
    function GetItem(const AIndex: Integer): TFmxObject;
    function GetObject: TFmxObject;
    function GetItems(const Index: Integer): TMenuItem;
  protected
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; 
    procedure CloseMenu; inline;
    procedure Popup(X, Y: Single); override;
    property PopupPoint: TPoint read FPopupPoint;
    procedure DialogKey(var Key: Word; Shift: TShiftState);
    property ItemsCount: integer read GetItemsCount;
    property Items[const AIndex: Integer]: TMenuItem read GetItems;
  end;

{ TMenuBar }
  ///<summary> This class implement a menu on a bar. The user can set the position
  ///  of the bar. This type of the menu can be tansform in the main meu of an
  /// application if USEOsMenu is set to True.
  ///</summary>
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TMenuBar = class(TStyledControl, IItemsContainer, INativeControl, IMenuView)
  private
    FContent: TContent;
    FContentLayout: TControl;
    FNoItemsContent: TControl;
    { IMenuView }
    FLoop: Boolean;
    FParentView: IMenuView;
    FChildView: IMenuView;
    FSelected: TMenuItem;
    FMenuService: IFMXMenuService;
    function GetLoop: Boolean;
    procedure SetLoop(const Value: Boolean);
    function GetParentView: IMenuView;
    procedure SetParentView(const Value: IMenuView);
    function GetChildView: IMenuView;
    procedure SetChildView(const Value: IMenuView);
    function GetSelected: TMenuItem;
    procedure SetSelected(const Value: TMenuItem);
    function GetIsMenuBar: Boolean;
    { IItemsContainer }
    function GetItemsCount: Integer;
    function GetItem(const AIndex: Integer): TFmxObject;
    { }
    procedure AddNoItemObject(AObject: TFmxObject);
    function GetHandle: TFmxHandle;
    procedure SetHandle(const Value: TFmxHandle);
    function GetHandleSupported: boolean;
    function GetItems(const Index: Integer): TMenuItem;
    procedure UpdateVisible;
    procedure StartMenuLoopMessage(const Sender: TObject; const M: TMessage);
  protected
    function GetMenuItem(const AIndex: Integer): TMenuItem;
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    procedure DialogKey(var Key: Word; Shift: TShiftState); override;
    procedure DoUpdateOSMenu(const Sender: TObject);
    { TComponent }
    procedure Loaded; override;
    { TStyledControl }
    function GetDefaultStyleLookupName: string; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartMenuLoop;
    procedure Clear;
    property ItemsCount: integer read GetItemsCount;
    property Items[const AIndex: Integer]: TMenuItem read GetItems;
  published
    property Anchors;
    property Align;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
//    property Hint;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
//    property ShowHint default False;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Width;
    { events }
    property OnApplyStyleLookup;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Mouse events}
    property OnCanFocus;
    property OnClick;

    property OnMouseMove;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TMainMenu }
  ///<summary> This class implements the principal menu of an application. On
  ///  Windows is situated on the most top level of the application form. On MAC
  ///  this menu appear outside the application form in the main menu of the OS
  ///  with respect to the application.
  ///</summary>
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
  TMainMenu = class(TFmxObject, IItemsContainer, INativeControl)
  private
    FMenuService: IFMXMenuService;
    FHandle: TFmxHandle;
    FStyleChangedId: Integer;
    procedure StyleChangedHandler(const Sender: TObject; const Msg : TMessage);
    { IItemContainer }
    function GetItemsCount: Integer;
    function GetItem(const AIndex: Integer): TFmxObject;
    function GetObject: TFmxObject;
    function GetHandle: TFmxHandle;
    procedure SetHandle(const Value: TFmxHandle);
    function GetHandleSupported: boolean;
  protected
    procedure Loaded; override;
    procedure RecreateOSMenu; virtual;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    //added to enable the shortcut functionality of main menu items
    procedure DialogKey(var Key: Word; Shift: TShiftState);
    property ItemsCount: integer read GetItemsCount;
    property Items[const AIndex: Integer]: TFmxObject read GetItem;
  end;

function TextToShortCut(const Text: string): integer;

implementation

uses System.SysConst, System.SysUtils, System.Variants, System.Actions,
     System.Generics.Collections, System.Math,
     FMX.Consts, FMX.Platform, FMX.Objects;

var
  GMainMenu: TFmxObject;

function TextToShortCut(const Text: string): integer;
begin
  Result := FMX.ActnList.TextToShortCut(Text);
end;

{$REGION 'implementation of TClickList'}
type
  TClickList = class (TComponent)
  public const
    TimerInterval: Integer = 40;
  private
    FMenuItemList: TList<Pointer>;
    FTimerHandle: TFMXHandle;
    FPlatformTimer: IFMXTimerService;
    procedure StartTimer;
    procedure StopTimer;
    procedure TimerProc;
    procedure UpdateTimer;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoClicks;
    procedure Add(const MenuItem: TMenuItem);
    procedure Remove(const MenuItem: TMenuItem);
    function Contains(const MenuItem: TMenuItem): Boolean;
  end;

var
  vClickList: TClickList;

{ TClickList }

constructor TClickList.Create(AOwner: TComponent);
begin
  inherited;
  FTimerHandle := cIdNoTimer;
  FMenuItemList := TList<Pointer>.Create;
end;

destructor TClickList.Destroy;
begin
  StopTimer;
  FPlatformTimer := nil;
  FreeAndNil(FMenuItemList);
  inherited;
end;

procedure TClickList.Add(const MenuItem: TMenuItem);
begin
  if Assigned(MenuItem) then
  begin
    FreeNotification(MenuItem);
    FMenuItemList.Add(MenuItem);
    if FMenuItemList.Count > 0 then
      StartTimer;
  end;
end;

function TClickList.Contains(const MenuItem: TMenuItem): Boolean;
begin
  Result := FMenuItemList.Contains(MenuItem);
end;

procedure TClickList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent is TMenuItem) then
  begin
    FMenuItemList.Remove(TMenuItem(AComponent));
    UpdateTimer;
  end;
end;

procedure TClickList.Remove(const MenuItem: TMenuItem);
begin
  if Assigned(MenuItem) then
  begin
    FMenuItemList.Remove(MenuItem);
    RemoveFreeNotification(MenuItem);
    UpdateTimer;
  end;
end;

procedure TClickList.DoClicks;
var
  MenuItem: TMenuItem;
begin
  try
    while FMenuItemList.Count > 0 do
    begin
      MenuItem := FMenuItemList[0];
      FMenuItemList.Delete(0);
      RemoveFreeNotification(MenuItem);
      MenuItem.FClickImmediately := True;
      try
        MenuItem.Click;
      finally
        MenuItem.FClickImmediately := False;
      end;
    end;
  finally
    UpdateTimer;
  end;
end;

procedure TClickList.StartTimer;
begin
  if not (csDestroying in ComponentState) then
  begin
    if not Assigned(FPlatformTimer) then
    begin
      if not TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, IInterface(FPlatformTimer)) then
        raise EUnsupportedPlatformService.Create('IFMXTimerService');
    end;
    if FTimerHandle = cIdNoTimer then
      FTimerHandle := FPlatformTimer.CreateTimer(TimerInterval, TimerProc);
  end;
end;

procedure TClickList.StopTimer;
begin
  if Assigned(FPlatformTimer) and (FTimerHandle <> cIdNoTimer) then
  begin
    FPlatformTimer.DestroyTimer(FTimerHandle);
    FTimerHandle := cIdNoTimer;
  end;
end;

procedure TClickList.TimerProc;
begin
  DoClicks;
end;

procedure TClickList.UpdateTimer;
begin
  if (FMenuItemList.Count = 0) and
     (Assigned(FPlatformTimer)) then
    StopTimer;
end;
{$ENDREGION}

type
  THackFMXActionLink = class (TActionLink);

type

  TMenuItemContent = class(TContent)
  private
  protected
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
  public
  end;

  TMenuViewContent = class(TContent)
  protected
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
  public
  end;

  TPopupMenuContent = class(TContent)
  protected
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
  public
  end;

  TMenuBarContent = class(TContent)
  protected
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
  public
  end;
  
  ///<summary> This class implement the getter/setter methods from IMenuView interface and 
  /// overrides some related style methods.
  ///</summary>
  TMenuView = class(TStyledControl, IMenuView)
  private
    FContent: TContent;
    FContentLayout: TControl;
    FNoItemsContent: TControl;
    FLoop: Boolean;
    FParentView, FChildView: IMenuView;
    FSelected: TMenuItem;
    procedure AddNoItemObject(AObject: TFmxObject); 
    { IMenuView }
    function GetLoop: Boolean;
    procedure SetLoop(const Value: Boolean);
    function GetParentView: IMenuView;
    procedure SetParentView(const Value: IMenuView);
    function GetChildView: IMenuView;
    procedure SetChildView(const Value: IMenuView);
    function GetSelected: TMenuItem;
    procedure SetSelected(const Value: TMenuItem);
    function GetIsMenuBar: Boolean;
    function GetItemsCount: Integer;
    function GetItem(const AIndex: Integer): TFmxObject;
  protected
    procedure DoRealign; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    { TStyledControl }
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;
  
{ TMenuItemContent }

procedure TMenuItemContent.DoAddObject(const AObject: TFmxObject);
begin
  if not (AObject is TMenuItem) and (Parent is TMenuItem) then
    TMenuItem(Parent).AddNoItemObject(AObject)
  else
    inherited;
end;

procedure TMenuItemContent.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if not (AObject is TMenuItem) and (Parent is TMenuItem) then
    TMenuItem(Parent).AddNoItemObject(AObject)
  else
    inherited;
end;

procedure TMenuItemContent.DoRealign;
begin
end;

{ TMenuItem }

constructor TMenuItem.Create(AOwner: TComponent);
begin
  inherited;
  TPlatformServices.Current.SupportsPlatformService(IFMXMenuService, IInterface(FMenuService));
  FContent := TMenuItemContent.Create(Self);
  FContent.Parent := Self;
  FContent.Stored := False;
  FContent.Locked := True;
  FContent.HitTest := False;
  FContent.Visible := False;
  TextAlign := TTextAlign.taLeading;
  WordWrap := False;
  FBitmap := TBitmap.Create(0, 0);
end;

procedure TMenuItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
  Filer.DefineProperty('Align', IgnoreIntegerValue, nil, False);
  Filer.DefineProperty('Height', IgnoreFloatValue, nil, False);
  Filer.DefineProperty('Width', IgnoreFloatValue, nil, False);
  Filer.DefineProperty('Position.X',IgnoreFloatValue, nil, False);
  Filer.DefineProperty('Position.Y', IgnoreFloatValue, nil, False);
  Filer.DefineProperty('RotationAngle', IgnoreFloatValue, nil, False);
  Filer.DefineProperty('RotationCenter.X', IgnoreFloatValue, nil, False);
  Filer.DefineProperty('Scale.X', IgnoreFloatValue, nil, False);
  Filer.DefineProperty('Scale.Y', IgnoreFloatValue, nil, False);
  Filer.DefineProperty('WordWrap', IgnoreBooleanValue, nil, False);
end;

destructor TMenuItem.Destroy;
begin
  try
    Handle := 0;
  except
    // nor what do not
  end;
  FBitmap.Free;
  FreeAndNil(FContent);
  FMenuService := nil;
  inherited;
end;

function TMenuItem.GetHandleSupported: boolean;
var P: TFmxObject;
begin
  Result := false;
  if (csDesigning in ComponentState) then Exit;
  P := self;
  while P.Parent <> nil do
  begin
    if P.Parent is TContent then
      P := P.Parent;
    if (P is TMenuBar) then
    begin
      Result := False;
      break;
    end
    else if (P is TMainMenu) then
    begin
      Result := True;
      break;
    end;
    P := P.Parent;
  end;
end;

function TMenuItem.GetHandle: TFmxHandle;
begin
  Result := FHandle;
end;

procedure TMenuItem.SetHandle(const Value: TFmxHandle);
begin
  if Value <> FHandle then
  begin
{    if (FHandle <> 0) and Assigned(FMenuService) then
      FMenuService.DestroyMenuItem(Self);}
    FHandle := Value;
  end;
end;

procedure TMenuItem.DialogKey(var Key: Word; Shift: TShiftState);
var
  k: word;
  I: integer;
  SState: TShiftState;
  UseInherit: boolean;
begin
  if (Key > 0) and Enabled and Assigned(FMenuService) then
  begin
    UseInherit := ((ActionClient) and (Action is TCustomAction)) or
                  (ShortCut = 0);
    if UseInherit and (ShortCut <> 0) then
    begin
      I := 0;
      UseInherit := TCustomAction(Action).ShortCut = ShortCut;
      while (not UseInherit) and
            (I < TCustomAction(Action).SecondaryShortCuts.Count) do
      begin
        UseInherit := TCustomAction(Action).SecondaryShortCuts.ShortCuts[I] = ShortCut;
        inc(I);
      end;
    end;
    if UseInherit then
      inherited DialogKey(Key, Shift)
    else if Assigned(FMenuService) then

    begin
      FMenuService.ShortCutToKey(ShortCut, k, SState);
      if (Key = k) and (Shift = SState) then
      begin
        Click;
        Key:=0;
      end;
    end;
  end;
  if Key > 0 then
    for I := 0 to ItemsCount - 1 do
    begin
      Items[I].DialogKey(Key, Shift);
      if Key = 0 then
        Break;
    end;
end;

function TMenuItem.EnterChildren(AObject: IControl): Boolean;
begin
  inherited EnterChildren(AObject);
  IsSelected := True;
  Result := True;
end;

function TMenuItem.GetMenuView: IMenuView;
var
  P: TFmxObject;
  View: IMenuView;
begin
  Result := nil;
  P := Parent;
  while Assigned(P) do
  begin
    if (IInterface(P).QueryInterface(IMenuView, View) = S_OK) then
    begin
      Result := View;
      Break;
    end;
    P := P.Parent;
  end;
end;

function TMenuItem.GetVisibleItemsCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FContent.ChildrenCount - 1 do
    if (FContent.Children[i] is TMenuItem) and TMenuItem(FContent.Children[I]).Visible then
      Result := Result + 1;
end;

procedure TMenuItem.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
begin
  inherited;
  if Button = TMouseButton.mbLeft then
    NeedPopup;
end;

procedure TMenuItem.Move;
begin
  inherited;
  if (csDesigning in ComponentState) and (Parent is TMenuBarContent) then
    TMenuBarContent(Parent).Realign;
end;

procedure TMenuItem.Resize;
begin
  inherited;
  if (csDesigning in ComponentState) and (Parent is TMenuBarContent) then
    TMenuBarContent(Parent).Realign;
end;



procedure TMenuItem.DoPopupTimer(Sender: TObject);
begin
  FPopupTimer.Enabled := False;
  Popup;
end;

procedure TMenuItem.NeedPopup;
begin
  if not HavePopup then Exit;
  Click;
  if Not Assigned(FPopupTimer) then
    FPopupTimer := TTimer.Create(nil);
  FPopupTimer.Parent := Self;
  FPopupTimer.Interval := 1;
  FPopupTimer.OnTimer := DoPopupTimer;
  FPopupTimer.Enabled := True;
end;

procedure TMenuItem.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure TMenuItem.TurnSiblingsOff;
var
  I: Integer;
  Item: TMenuItem;
  LParent: IItemsContainer;
  LItem: TFmxObject;
  LGroup: IGroupName;
  function ParentMenuItem: IItemsContainer;
  var
    P: TFmxObject;
  begin
    P := Parent;
    Result := nil;
    while Assigned(P) do
    begin
      if (IInterface(P).QueryInterface(IItemsContainer, Result) = S_OK) then
        Break
      else
        P := P.Parent;
    end;
  end;
begin
  LParent := ParentMenuItem;
  if Assigned(LParent) then
    for I := 0 to LParent.GetItemsCount - 1 do
    begin
      LItem := LParent.GetItem(I);
      if (IInterface(LItem).QueryInterface(IGroupName, LGroup) = S_OK) and
         (LGroup.GroupName = Inttostr(GroupIndex)) and
         (LItem <> self) then
      begin
        if LItem is TMenuItem then
        begin
          Item := TMenuItem(LItem);
          if Item.RadioItem and (Item.GroupIndex = GroupIndex) then
            Item.IsChecked := False;
        end
        else
          LGroup.IsChecked := False;
      end
    end
  else if Assigned(View) then
    for I := 0 to View.GetItemsCount - 1 do
    begin
      Item := TMenuItem(View.GetItem(I));
      if (Item <> Self) and Item.FRadioItem and (Item.GroupIndex = GroupIndex) then
        Item.SetIsChecked(False);
    end;
end;

procedure TMenuItem.SetIsSelected(const Value: Boolean);
begin
  if FIsSelected <> Value then
  begin
    FIsSelected := Value;
    StartTriggerAnimation(Self, 'IsSelected');
    ApplyTriggerEffect(Self, 'IsSelected');
    if Assigned(View) then
      View.Selected := Self;
  end;
end;

procedure TMenuItem.SetShortCut(const Value: TShortCut);
begin
  if ShortCut <> Value then
  begin
    if (Action is TCustomAction) then
      TCustomAction(Action).ShortCut := Value
    else
      FShortCut := Value;
    if IsHandleValid(Handle) and Assigned(FMenuService) then
      FMenuService.UpdateMenuItem(Self, [TMenuItemChange.mcShortcut]);
  end;
end;

function TMenuItem.GetShortCut: TShortCut;
begin
  if (Action is TCustomAction) then
    Result := TCustomAction(Action).ShortCut
  else
    Result := FShortCut;
end;

function TMenuItem.ShortCutStored: Boolean;
begin
  Result := (not (Action is TCustomAction)) and (ShortCut <> 0);
end;

procedure TMenuItem.SetText(const Value: string);
var
  AlignRoot: IAlignRoot;
begin
  if Text <> Value then
  begin
    inherited;
    if IsHandleValid(Handle) and Assigned(FMenuService) then
      FMenuService.UpdateMenuItem(Self, [TMenuItemChange.mcText])
    else
      if Assigned(View) and Supports(View, IAlignRoot, AlignRoot) then
        AlignRoot.Realign;
  end;
end;

procedure TMenuItem.SetEnabled(const Value: Boolean);
begin
  if Value <> Enabled then
  begin
    inherited;
    if Assigned(FMenuService) then
      FMenuService.UpdateMenuItem(Self, [TMenuItemChange.mcEnabled]);
    if Assigned(TextObject) then
    begin
      TextObject.Width := TextObject.Width + 1;
    end;
  end;
end;


procedure TMenuItem.SetVisible(const AValue: Boolean);
begin
  if Visible <> AValue then
  begin
    inherited;
    if (Parent is TMenuBarContent) and Assigned(FMenuService) then
      TMenuBarContent(Parent).DoRealign;
    FMenuService.UpdateMenuItem(Self, [TMenuItemChange.mcVisible]);
  end;
end;

procedure TMenuItem.AddNoItemObject(const AObject: TFmxObject);
begin
  if Not Assigned(FNoItemsContent) then
  begin
    FNoItemsContent := TFmxObject.Create(nil);
    FNoItemsContent.Parent := Self;
    FNoItemsContent.Stored := False;
  end;
  FNoItemsContent.AddObject(AObject);
end;

procedure TMenuItem.DoAddObject(const AObject: TFmxObject);
begin
  if Assigned(FContent) and (AObject is TMenuItem) then
  begin
    TMenuItem(AObject).Locked := True;
    TMenuItem(AObject).Handle := 0;
    FContent.AddObject(AObject);
    if (not (csLoading in ComponentState)) and Assigned(FMenuService) then
      FMenuService.UpdateMenuItem(Self, [TMenuItemChange.mcText]);
  end
  else
    inherited;
end;

procedure TMenuItem.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if Assigned(FContent) and (AObject is TMenuItem) then
  begin
    TMenuItem(AObject).Locked := True;
    TMenuItem(AObject).Handle := 0;
    FContent.InsertObject(Index, AObject);
    if (not (csLoading in ComponentState)) and Assigned(FMenuService) then
      FMenuService.UpdateMenuItem(Self, [TMenuItemChange.mcText]);
  end
  else
    inherited;
end;

procedure TMenuItem.ApplyStyle;
var
  O: TFmxObject;
begin
  inherited;
  O := FindStyleResource('glyph');
  if Assigned(O) and (O is TControl)  then
  begin
    FGlyphObject := O;
    TControl(FGlyphObject).Visible := not (FBitmap.IsEmpty) or (Assigned(View) and not View.GetIsMenuBar);
  end;
  O := FindStyleResource('checkmark');
  if Assigned(O) and (O is TControl) then
  begin
    FCheckmarkObject := O;
    if Assigned(View) and not View.GetIsMenuBar and IsChecked then
    begin
      ApplyTriggerEffect(Self, 'IsChecked');
      StartTriggerAnimation(Self, 'IsChecked');
    end;
    TControl(FCheckmarkObject).Visible := True;
  end;
  O := FindStyleResource('bitmap');
  if Assigned(O) and (O is TControl)  then
  begin
    FBitmapObject := O;
    if FBitmapObject is TImage then
      TImage(FBitmapObject).Bitmap.Assign(FBitmap);
    TControl(FBitmapObject).Visible := not (FBitmap.IsEmpty);
  end;
  O := FindStyleResource('shortcut');
  if Assigned(O) then
  begin
    FShortCutObject := O;
    if Assigned(FShortCutObject) and (FShortCutObject is TText) and Assigned(FMenuService) then
    begin
      TText(FShortCutObject).Text := FMenuService.ShortCutToText(ShortCut);
      TText(FShortCutObject).WordWrap := False;
      TText(FShortCutObject).Visible := (Assigned(View) and not View.GetIsMenuBar);
    end;
  end;
  O := FindStyleResource('submark');
  if Assigned(O) and (O is TControl) then
  begin
    FSubmarkObject := O;
    TControl(FSubmarkObject).Visible := Assigned(View) and not View.GetIsMenuBar and (GetVisibleItemsCount > 0);
  end;
end;

procedure TMenuItem.FreeStyle;
begin
  inherited;
  FCheckmarkObject := nil;
  FShortCutObject := nil;
  FGlyphObject := nil;
  FSubmarkObject := nil;
end;

function TMenuItem.CalcSize: TPointF;
var
  C: TCanvas;
begin
  if Text = '-' then
  begin
    StyleLookup := 'menuseparatorstyle';
    Result := PointF(0, 8);
    Exit;
  end;
  if (StyleLookup = '') and (View.IsMenuBar)  then
    StyleLookup := 'menubaritemstyle';
  if not Assigned(Canvas) then
    C := TCanvasManager.MeasureCanvas
  else
    C := Canvas;

  ApplyStyleLookup;

  Result := CalcVisibleObjectsItemSize(C, PointF(0, 23));
end;

function TMenuItem.CalcRenderSize: TPointF;
var
  C: TCanvas;
begin
  if Text = '-' then
  begin
    Result := PointF(0, 8);
    Exit;
  end;
  if not Assigned(Canvas) then
    C := TCanvasManager.MeasureCanvas
  else
    C := Canvas;

  Result := CalcVisibleObjectsItemSize(C, PointF(0, 23));
end;

function TMenuItem.CalcVisibleObjectsItemSize(const ACanvas: TCanvas;
  APointF: TPointF): TPointF;
begin
  if Text = '-' then
    Result:= PointF(0, 8)
  else
  begin
    Result := PointF(0, 23);
  if Assigned(FGlyphObject) and (FGlyphObject is TControl) and (TControl(FGlyphObject).Visible) then
  begin
    Result.X := Result.X + TControl(FGlyphObject).Width + TControl(FGlyphObject).Margins.Left + TControl(FGlyphObject).Margins.Right;
  end;
  if Assigned(TextObject) and (TextObject is TText) then
  begin
    ACanvas.Font.Assign(TText(TextObject).Font);
    TText(TextObject).Width := Round(ACanvas.TextWidth(DelAmp(Text)));
    Result.X := Result.X + TText(TextObject).Width + TControl(TextObject).Margins.Left + TControl(TextObject).Margins.Right;
  end;
  if Assigned(FShortCutObject) and (FShortCutObject is TText) and (TControl(FShortCutObject).Visible) and Assigned(FMenuService) then
  begin
    ACanvas.Font.Assign(TText(FShortCutObject).Font);
    TText(FShortCutObject).Width := Round(ACanvas.TextWidth(FMenuService.ShortCutToText(ShortCut)));
    Result.X := Result.X + TText(FShortCutObject).Width + TControl(FShortCutObject).Margins.Left + TControl(FShortCutObject).Margins.Right;
  end;
  if Assigned(FSubmarkObject) and (FSubmarkObject is TControl) and (TControl(FSubmarkObject).Visible) then
  begin
    Result.X := Result.X + TControl(FSubmarkObject).Width + TControl(FSubmarkObject).Margins.Left + TControl(FSubmarkObject).Margins.Right;
  end;
  end;
end;

procedure TMenuItem.Clear;
begin
  FContent.DeleteChildren;
end;

procedure TMenuItem.Click;
begin
  if FClickImmediately then
  begin
    if not (ActionClient and
            (Action is TCustomAction) and
            (TCustomAction(Action).AutoCheck)) then
    begin
      if AutoCheck then
        if (RadioItem and (not IsChecked)) or
           (not RadioItem) then
          IsChecked := not IsChecked;
    end;
    // else work is done by Action
    inherited;
  end
  else
  begin
    DoMouseLeave;
    if not Assigned(vClickList) then
      vClickList := TClickList.Create(nil);
    vClickList.Add(self);
  end;
end;

procedure TMenuItem.Popup;
var
  Popup: TPopup;
  Menu: TMenuView;
  Item: TMenuItem;
  i: Integer;
begin
  if Not Assigned(FContent) then
    Exit;
  if FContent.ChildrenCount = 0 then
    Exit;

  IsSelected := True;
  Popup := TPopup.Create(nil);
  Menu := TMenuView.Create(nil);
  try
    if Assigned(View) then
    begin
      View.ChildView := Menu;
      Menu.FParentView := View;
    end;
    // set style
    if Assigned(Scene) and Assigned(Scene.StyleBook) then
      Popup.StyleBook := Scene.StyleBook;
    // create popup
    Popup.PlacementTarget := Self;
    if View.IsMenuBar then
      Popup.Placement := TPlacement.plBottom
    else
      Popup.Placement := TPlacement.plRight;
    // create menu
    Menu.Parent := Popup;
    // copy items to menu
    Menu.BeginUpdate;
    for i := 0 to GetItemsCount - 1 do
    begin
      Item := TMenuItem(GetItem(0));
      Item.Parent := Menu;
    end;
    Menu.EndUpdate;
    // calc size
    Popup.BoundsRect := RectF(0, 0, Menu.Width, Menu.Height);
    // show
    Popup.Popup;
    // start loop
    if Assigned(FMenuService) then
      FMenuService.StartMenuLoop(Menu);
  finally
    // copy back
    FContent.BeginUpdate;
    for i := 0 to Menu.GetItemsCount - 1 do
    begin
      Item := TMenuItem(Menu.GetItem(0));
      Item.Parent := FContent;
    end;
    FContent.EndUpdate;
    // hide popup
    Popup.IsOpen := False;
    // hide
    if Assigned(View) then
    begin
      View.Selected := nil;
      View.ChildView := nil;
      Menu.FParentView := nil;
    end;
    Menu.Visible := False;
    if Assigned(Menu) then
      FreeAndNil(Menu);
    IsSelected := False;
    if Assigned(Popup) then
      FreeAndNil(Popup);
  end;
end;

function TMenuItem.GetIsChecked: boolean;
begin
  Result := FIsChecked;
end;

function TMenuItem.IsCheckedStored: boolean;
begin
  Result := not (ActionClient and
                 (ActionLink is TActionLink) and
                 (THackFMXActionLink(ActionLink).IsCheckedLinked) and
                 (Action is TContainedAction));
end;

procedure TMenuItem.SetIsChecked(const Value: Boolean);
begin
  if FIsChecked <> Value then
  begin
    if not IsCheckedStored then
    begin
      FIsChecked := Value;
      TContainedAction(Action).Checked := FIsChecked;
    end
    else
    begin
      FIsChecked := Value;
      if Value and FRadioItem then
        TurnSiblingsOff;
    end;
    if IsHandleValid(Handle) then
    begin
      if Assigned(FMenuService) then
        FMenuService.UpdateMenuItem(Self, [TMenuItemChange.mcChecked]);
    end
    else
    begin
      StartTriggerAnimation(Self, 'IsChecked');
      ApplyTriggerEffect(Self, 'IsChecked');
    end;
  end;
end;

function TMenuItem.GetGroupName: string;
begin
  if RadioItem then
    Result := FGroupName
  else
    Result := '';
end;

function TMenuItem.GroupNameStored: boolean;
begin
  Result := (not RadioItem) or
            (not (ActionClient and
                 (ActionLink is TActionLink) and
                 (THackFMXActionLink(ActionLink).IsGroupIndexLinked) and
                 (Action is TContainedAction)));
end;

procedure TMenuItem.UpdateGroup(const Value: string);
var I, Code: integer;
begin
  if not GroupNameStored then
  begin
    if (Value = '') then
    begin
      I := 0;
      Code := 0;
    end
    else
      Val(Value, I, Code);
    if (Code = 0) then
    begin
      FGroupName := inttostr(I);
      if not RadioItem then
        I := 0;
      if TContainedAction(Action).GroupIndex <> I then
        TContainedAction(Action).GroupIndex := I;
    end
    else
      FGroupName := Value;
  end
  else
    FGroupName := Value;
end;

procedure TMenuItem.SetGroupName(const Value: string);
begin
  if FGroupName <> Value then
    UpdateGroup(Value);
end;

function TMenuItem.GetAutoCheck: Boolean;
begin
  if (Action is TContainedAction) then
    Result := TContainedAction(Action).AutoCheck
  else
    Result := FAutoCheck;
end;

function TMenuItem.AutoCheckStored: Boolean;
begin
  Result := not (Action is TContainedAction);
end;

procedure TMenuItem.SetAutoCheck(const Value: Boolean);
begin
  FAutoCheck := Value;
  if (Action is TContainedAction) then
    TContainedAction(Action).AutoCheck := FAutoCheck;
end;

function TMenuItem.GetGroupIndex: Integer;
var
  I, Code: integer;
begin
  if FGroupName = '' then
    Result := 0
  else
  begin
    Val(FGroupName, I, Code);
    if Code = 0 then
      Result := I
    else
      Result := -1;
  end;
end;

procedure TMenuItem.SetGroupIndex(const Value: Integer);
var V: string;
begin
  V := inttostr(Value);
  SetGroupName(V);
end;

function TMenuItem.RadioItemStored: Boolean;
begin
  Result := not (Action is TContainedAction);
end;

function TMenuItem.GetRadioItem: Boolean;
begin
  //
  if (Action is TContainedAction) then
    Result := (TContainedAction(Action).GroupIndex <> 0)
  else
    Result := FRadioItem;
end;

procedure TMenuItem.SetRadioItem(const Value: Boolean);
begin
  if FRadioItem <> Value then
  begin
    FRadioItem := Value;
    if (Action is TContainedAction) then Exit;
    if FIsChecked and FRadioItem then
      TurnSiblingsOff;
  end;
end;

procedure TMenuItem.ActionChange(Sender: TBasicAction; CheckDefaults: Boolean);
begin
  inherited;
  if Sender is TCustomAction then
  begin
    if (not CheckDefaults) or (not IsChecked) then
      IsChecked := TCustomAction(Sender).Checked;
    if (not CheckDefaults) or (FGroupName = '') or (FGroupName = '0') then
      SetGroupName(IntToStr(TCustomAction(Sender).GroupIndex));
  end;
end;

function TMenuItem.HavePopup: Boolean;
begin
  Result := GetVisibleItemsCount > 0;
end;

function TMenuItem.GetItem(const AIndex: Integer): TFmxObject;
begin
  Result := FContent.Controls[AIndex];
end;

function TMenuItem.GetItems(const Index: Integer): TMenuItem;
var Obj: TFmxObject;
begin
  Obj := GetItem(Index);
  if not (Obj is TMenuItem) then
    raise EInvalidCast.Create(SInvalidCast);
  result := TMenuItem(Obj);
end;

function TMenuItem.GetItemsCount: Integer;
begin
  Result := FContent.ControlsCount;
end;

{ TMenuViewContent }

procedure TMenuViewContent.DoAddObject(const AObject: TFmxObject);
begin
  if not (AObject is TMenuItem) and (Parent is TMenuView) then
    TMenuView(Parent).AddNoItemObject(AObject)
  else
    inherited;
end;

procedure TMenuViewContent.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if not (AObject is TMenuItem) and (Parent is TMenuView) then
    TMenuView(Parent).AddNoItemObject(AObject)
  else
    inherited;
end;

procedure TMenuViewContent.DoRealign;
begin
end;

{ TMenuView }

constructor TMenuView.Create(AOwner: TComponent);
begin
  inherited;
  FContent := TMenuViewContent.Create(Self);
  FContent.Parent := Self;
  FContent.Stored := False;
  FContent.Locked := True;
  FContent.HitTest := False;
  Width := 200;
  Height := 200;
end;

destructor TMenuView.Destroy;
begin
  inherited;
end;

procedure TMenuView.AddNoItemObject(AObject: TFmxObject);
begin
  if Not Assigned(FNoItemsContent) then
  begin
    FNoItemsContent := TControl.Create(nil);
    FNoItemsContent.Parent := Self;
    FNoItemsContent.Stored := False;
    FNoItemsContent.Locked := True;
    FNoItemsContent.HitTest := False;
  end;
  FNoItemsContent.AddObject(AObject);
end;

procedure TMenuView.DoAddObject(const AObject: TFmxObject);
begin
  if Assigned(FContent) and (AObject is TMenuItem) then
  begin
    TMenuItem(AObject).Handle := 0;
    FContent.AddObject(AObject);
  end
  else
    inherited;
end;

procedure TMenuView.ApplyStyle;
var
  O: TFmxObject;
begin
  inherited;
  O := FindStyleResource('content');
  if Assigned(O) and (O is TControl) then
    FContentLayout := TControl(O);
end;

procedure TMenuView.FreeStyle;
begin
  inherited;
  FContentLayout := nil;
end;

function TMenuView.GetChildView: IMenuView;
begin
  Result := FChildView;
end;

function TMenuView.GetIsMenuBar: Boolean;
begin
  Result := False;
end;

function TMenuView.GetLoop: Boolean;
begin
  Result := FLoop;
end;

function TMenuView.GetParentView: IMenuView;
begin
  Result := FParentView;
end;

function TMenuView.GetSelected: TMenuItem;
begin
  Result := FSelected;
end;

{ IMenuItemsContainer }

function TMenuView.GetItemsCount: Integer;
begin
  Result := FContent.ControlsCount;
end;

function TMenuView.GetItem(const AIndex: Integer): TFmxObject;
begin
  Result := FContent.Controls[AIndex];
end;

procedure TMenuView.DoRealign;
var
  MarginR, ContentR: TRectF;
  P: TPointF;
  i: Integer;
  Size: TPointF;
  Item: TMenuItem;
begin
  if FUpdating > 0 then
    Exit;
  if csLoading in ComponentState then
    Exit;
  if FDisableAlign then
    Exit;

  FDisableAlign := True;
  try
    ApplyStyleLookup;
    if Assigned(FContentLayout) and Assigned(ResourceControl) then
    begin
      ResourceControl.BoundsRect := RectF(0, 0, Width, Height);
      ContentR.TopLeft := AbsoluteToLocal(FContentLayout.LocalToAbsolute(PointF(0, 0)));
      P := AbsoluteToLocal(FContentLayout.LocalToAbsolute(PointF(FContentLayout.Width, FContentLayout.Height)));
      ContentR.BottomRight := PointF(Self.Width - P.X, Self.Height - P.Y);
    end
    else
      ContentR := RectF(0, 0, 0, 0);

    if Assigned(ResourceControl) then
      MarginR := RectF(ResourceControl.Padding.Left, ResourceControl.Padding.Top,
        ResourceControl.Padding.Bottom, ResourceControl.Padding.Right)
    else
        MarginR := RectF(0, 0, 0, 0);
    { calc items size }
    Size := PointF(0, 0);
    if FContent.ControlsCount > 0 then
      for i := 0 to FContent.ControlsCount - 1 do
      if FContent.Controls[i] is TMenuItem then
      begin
        Item := TMenuItem(FContent.Controls[i]);
        if (Item.Visible) or
          ((csDesigning in ComponentState) and Item.DesignVisible) then
        begin
          P := Item.CalcSize;
          Size.Y := Size.Y + P.Y + Item.Margins.Top + Item.Margins.Bottom;
          if P.X + Item.Margins.Left + Item.Margins.Right > Size.X then
            Size.X := P.X + Item.Margins.Left + Item.Margins.Right;
        end;
      end;
    SetBounds(Position.X, Position.Y, Size.X + ContentR.Left + ContentR.Right,
          Size.Y + ContentR.Top + ContentR.Bottom);
    FContent.SetBounds(MarginR.Left, MarginR.Top, MarginR.Left + Size.X, MarginR.Top + Size.Y);
    if Assigned(ResourceControl) then
      ResourceControl.SetBounds(MarginR.Left, MarginR.Top, Self.Width - MarginR.Left - MarginR.Right,
        Self.Height - MarginR.Top - MarginR.Bottom);
    { align }
    Size := PointF(0, 0);
    if FContent.ControlsCount > 0 then
      for i := 0 to FContent.ControlsCount - 1 do
      if FContent.Controls[i] is TMenuItem then
      begin
        Item := TMenuItem(FContent.Controls[i]);
        if (Item.Visible) or
          ((csDesigning in ComponentState) and Item.DesignVisible) then
        begin
          Item := TMenuItem(FContent.Controls[i]);
          P := Item.CalcSize;
          Item.SetBounds(ContentR.Left + Item.Margins.Left, ContentR.Top + Size.Y, Self.Width - Item.Margins.Left - Item.Margins.Right - ContentR.Left - ContentR.Right,
            P.Y - Item.Margins.Top - Item.Margins.Bottom);
          Size.Y := Size.Y + Item.Height + Item.Margins.Top + Item.Margins.Bottom;
        end;
      end;
  finally
    FDisableAlign := False;
  end;
end;

procedure TMenuView.SetChildView(const Value: IMenuView);
begin
  FChildView := Value;
end;

procedure TMenuView.SetLoop(const Value: Boolean);
begin
  FLoop := Value;
  Repaint;
end;

procedure TMenuView.SetParentView(const Value: IMenuView);
begin
  FParentView := Value;
end;

procedure TMenuView.SetSelected(const Value: TMenuItem);
begin
  if FSelected <> Value then
  begin
    if Assigned(FSelected) then
      FSelected.IsSelected := False;
    FSelected := Value;
    if Assigned(FSelected) then
      FSelected.IsSelected := True;
  end;
end;

{ TPopupMenuContent }

procedure TPopupMenuContent.DoAddObject(const AObject: TFmxObject);
begin
  if not (AObject is TMenuItem) and (Parent is TPopupMenu) then
    TPopupMenu(Parent).AddNoItemObject(AObject)
  else
    inherited;
end;

procedure TPopupMenuContent.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if not (AObject is TMenuItem) and (Parent is TPopupMenu) then
    TPopupMenu(Parent).AddNoItemObject(AObject)
  else
    inherited;
end;

procedure TPopupMenuContent.DoRealign;
begin
end;

{ TPopupMenu }

constructor TPopupMenu.Create(AOwner: TComponent);
begin
  inherited;
  TPlatformServices.Current.SupportsPlatformService(IFMXMenuService, IInterface(FMenuService));
  FContent := TPopupMenuContent.Create(Self);
  FContent.Parent := Self;
  FContent.Stored := False;
  FContent.Locked := True;
  FContent.HitTest := False;
  FContent.Visible := False;
end;

destructor TPopupMenu.Destroy;
begin
  FMenuService := nil;
  inherited;
end;

procedure TPopupMenu.DialogKey(var Key: Word; Shift: TShiftState);
var
  I: integer;
  MItem: TMenuItem;
begin
  for I := GetItemsCount - 1 downto 0 do
  begin
    MItem:= TMenuItem(GetItem(I));
    MItem.DialogKey(Key, Shift);
  end;
end;

{ IItemContainer }

function TPopupMenu.GetItem(const AIndex: Integer): TFmxObject;
begin
  Result := TMenuItem(FContent.Controls[AIndex]);
end;

function TPopupMenu.GetItems(const Index: Integer): TMenuItem;
var
  Obj: TFmxObject;
begin
  Obj := GetItem(Index);
  if not (Obj is TMenuItem) then
    raise EInvalidCast.Create(SInvalidCast);
  result := TMenuItem(Obj);
end;

function TPopupMenu.GetItemsCount: Integer;
begin
  Result := FContent.ControlsCount;
end;

function TPopupMenu.GetObject: TFmxObject;
begin
  Result := Self;
end;

procedure TPopupMenu.AddNoItemObject(const AObject: TFmxObject);
begin
  if Not Assigned(FNoItemsContent) then
  begin
    FNoItemsContent := TFmxObject.Create(nil);
    FNoItemsContent.Parent := Self;
    FNoItemsContent.Stored := False;
  end;
  FNoItemsContent.AddObject(AObject);
end;

procedure TPopupMenu.DoAddObject(const AObject: TFmxObject);
begin
  if AObject is TMenuItem then
    FContent.AddObject(AObject)
  else
    inherited;
end;

procedure TPopupMenu.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if AObject is TMenuItem then
    FContent.InsertObject(Index, AObject)
  else
    inherited;
end;

procedure TPopupMenu.Clear;
begin
  FContent.DeleteChildren;
end;

procedure TPopupMenu.CloseMenu;
begin
end;

procedure TPopupMenu.Popup(X, Y: Single);
var
  Popup: TPopup;
  Menu: TMenuView;
  Item: TMenuItem;
  i: Integer;
  TempPopupPoint: TPointF;
  LScreenSize: TPointF;
  ScreenService: IFMXScreenService;
  List: TList<TMenuItem>;
begin
  Popup := TPopup.Create(nil);
  Menu := TMenuView.Create(nil);
  try
    // create popup
    Popup.Parent := Parent;
    if Parent is TMenuBar then
      Popup.Placement := TPlacement.plBottom
    else
      Popup.Placement := TPlacement.plRight;
    // create menu
    Menu.Parent := Popup;
    // copy items to menu
    Menu.BeginUpdate;
    try
      List := TList<TMenuItem>.Create;
      try
        for i := 0 to GetItemsCount - 1 do
          if (Items[I].Visible) or
            ((csDesigning in ComponentState) and Items[I].DesignVisible) then
            List.Add(Items[I]);
        for i := 0 to List.Count - 1 do
          List[I].Parent := Menu;
      finally
        FreeAndNil(List);
      end;
    finally
      Menu.EndUpdate;
    end;
    // calc size
    Popup.BoundsRect := RectF(0, 0, Menu.Width * Popup.AbsoluteMatrix.m11, Menu.Height * Popup.AbsoluteMatrix.m11);

    Popup.PlacementRectangle.Left := X;
    Popup.PlacementRectangle.Top := Y;
    Popup.Placement := TPlacement.plAbsolute;
    // recalculate the position for the popup in order to be entirely visible
    if  not (csDesigning in ComponentState) and
        TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, IInterface(ScreenService)) then
      LScreenSize := ScreenService.GetScreenSize;
    if (X >= 0) and (X < LScreenSize.X) and
       (Y >= 0) and (Y < LScreenSize.Y) then
    begin
      TempPopupPoint.X := Popup.PlacementRectangle.Left + Popup.Width;
      TempPopupPoint.Y :=Popup.PlacementRectangle.Top + Popup.Height;
      //right
      if TempPopupPoint.Y > LScreenSize.Y  then
        Popup.PlacementRectangle.Top := Max(0, Popup.PlacementRectangle.Top - (TempPopupPoint.Y - LScreenSize.Y));
      //bottom
      if TempPopupPoint.X > LScreenSize.X then
        Popup.PlacementRectangle.Left := Max(0, Popup.PlacementRectangle.Left - (TempPopupPoint.X - LScreenSize.X));
    end;
    // show
    Popup.Popup;
    // start loop
    if Assigned(FMenuService) then
      FMenuService.StartMenuLoop(Menu);
    // copy back
    for i := 0 to Menu.GetItemsCount - 1 do
    begin
      Item := TMenuItem(Menu.GetItem(0));
      Item.Parent := Self;
    end;
  finally
    // hide popup
    Popup.IsOpen := False;
    Menu.Visible := False;
    FreeAndNil(Menu);
    FreeAndNil(Popup);
  end;
end;

{ TMenuBarContent }

procedure TMenuBarContent.DoAddObject(const AObject: TFmxObject);
begin
  if not (AObject is TMenuItem) then
    TMenuBar(Parent).AddNoItemObject(AObject)
  else
    inherited;
end;

procedure TMenuBarContent.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if not (AObject is TMenuItem) then
    TMenuBar(Parent).AddNoItemObject(AObject)
  else
    inherited;
end;

procedure TMenuBarContent.DoRealign;
begin
  TMenuBar(Parent).Realign;
end;

procedure TMenuBarContent.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  if (AObject is TMenuItem) then
    TMenuBar(Parent).Realign;
end;

{ TMenuBar }

procedure TMenuBar.Clear;
begin
  FContent.DeleteChildren;
  FContent.Repaint;
end;

constructor TMenuBar.Create(AOwner: TComponent);
begin
  inherited;
  if not TPlatformServices.Current.SupportsPlatformService(IFMXMenuService, IInterface(FMenuService)) then
    raise EUnsupportedPlatformService.Create('IFMXMenuService');
  FContent := TMenuBarContent.Create(Self);
  FContent.Parent := Self;
  FContent.Stored := False;
  FContent.Locked := True;
  FContent.HitTest := False;
  FContent.Align := TAlignLayout.alContents;
  Width := 500;
  Height := 24;
  SetAcceptsControls(False);
  TMessageManager.DefaultManager.SubscribeToMessage(TStartMenuLoopMessage, StartMenuLoopMessage);
end;

destructor TMenuBar.Destroy;
var
  NeedClear: boolean;
begin
  TMessageManager.DefaultManager.Unsubscribe(TStartMenuLoopMessage, StartMenuLoopMessage);
  FMenuService := nil;
  NeedClear := GMainMenu = self;
  inherited;
  if NeedClear then
    GMainMenu := nil;
end;

procedure TMenuBar.DialogKey(var Key: Word; Shift: TShiftState);
begin
  inherited DialogKey(Key, Shift);
end;

procedure TMenuBar.AddNoItemObject(AObject: TFmxObject);
begin
  if Not Assigned(FNoItemsContent) then
  begin
    FNoItemsContent := TControl.Create(nil);
    FNoItemsContent.Parent := Self;
    FNoItemsContent.Stored := False;
    FNoItemsContent.Locked := True;
    FNoItemsContent.HitTest := False;
    FNoItemsContent.Align := TAlignLayout.alContents;
  end;
  FNoItemsContent.AddObject(AObject);
end;

procedure TMenuBar.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  if AObject is TMenuItem then
  begin
    TMenuItem(AObject).Handle := 0;
    FContent.AddObject(AObject);
    DoRealign;
  end;
end;

procedure TMenuBar.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  inherited;
  if AObject is TMenuItem then
  begin
    TMenuItem(AObject).Handle := 0;
    FContent.InsertObject(Index, AObject);
    Realign;
  end;
end;

procedure TMenuBar.ApplyStyle;
var
  O: TFmxObject;
begin
  inherited;
  O := FindStyleResource('content');
  if Assigned(O) and (O is TControl) then
  begin
    FContentLayout := TControl(O);
    Realign;
  end;
end;

procedure TMenuBar.FreeStyle;
begin
  inherited;
  FContentLayout := nil;
end;

function TMenuBar.GetChildView: IMenuView;
begin
  Result := FChildView;
end;

function TMenuBar.GetDefaultStyleLookupName: string;
begin
  Result := 'menubarstyle';
end;

function TMenuBar.GetHandle: TFmxHandle;
begin
  Result := 0;
end;

procedure TMenuBar.SetHandle(const Value: TFmxHandle);
begin
end;

function TMenuBar.GetHandleSupported: boolean;
begin
  Result := False;
end;

function TMenuBar.GetIsMenuBar: Boolean;
begin
  Result := True;
end;

function TMenuBar.GetItem(const AIndex: Integer): TFmxObject;
begin
  Result := FContent.Controls[AIndex];
end;

function TMenuBar.GetItems(const Index: Integer): TMenuItem;
var
  Obj: TFmxObject;
begin
  Obj := GetItem(Index);
  if not (Obj is TMenuItem) then
    raise EInvalidCast.Create(SInvalidCast);
  result := TMenuItem(Obj);
end;

function TMenuBar.GetItemsCount: Integer;
begin
  Result := FContent.ControlsCount;
end;

function TMenuBar.GetLoop: Boolean;
begin
  Result := FLoop;
end;

function TMenuBar.GetMenuItem(const AIndex: Integer): TMenuItem;
begin
  Result := TMenuItem(GetItem(AIndex));
end;

procedure TMenuBar.SetChildView(const Value: IMenuView);
begin
  FChildView := Value;
end;

procedure TMenuBar.SetLoop(const Value: Boolean);
begin
  FLoop := Value;
  Repaint;
end;

procedure TMenuBar.SetParentView(const Value: IMenuView);
begin
  FParentView := Value;
end;

procedure TMenuBar.SetSelected(const Value: TMenuItem);
begin
  if FSelected <> Value then
  begin
    if Assigned(FSelected) then
      FSelected.IsSelected := False;
    FSelected := Value;
    if Assigned(FSelected) then
      FSelected.IsSelected := True;
  end;
end;

procedure TMenuBar.UpdateVisible;
var LForm: TCommonCustomForm;
    LVisible: boolean;
begin
  if not (csLoading in ComponentState) then
  begin
    if (Root is TCommonCustomForm) then
    begin
      if ((not Assigned(GMainMenu)) or (GMainMenu = self)) then
      begin
        LForm := TCommonCustomForm(Root);
        LVisible := not((not (csDesigning in LForm.ComponentState)) and
                         FMenuService.IsMenuBarOnWindowBorder and
                         LForm.Border.IsSupported);
      end
      else
        LVisible := True;

      if LVisible and (GMainMenu = self) then
        GMainMenu := nil;
      Visible := LVisible;
    end
    else
      Visible := False;
  end;
end;

type
  TOpenCustomForm = class(TCommonCustomForm)

  end;

procedure TMenuBar.StartMenuLoopMessage(const Sender : TObject; const M : TMessage);
begin
  if TStartMenuLoopMessage(M).Root = Root then
    StartMenuLoop;
end;

procedure TMenuBar.StartMenuLoop;
begin
  FMenuService.StartMenuLoop(Self);
end;

function TMenuBar.GetParentView: IMenuView;
begin
  Result := FParentView;
end;

function TMenuBar.GetSelected: TMenuItem;
begin
  Result := FSelected;
end;

procedure TMenuBar.DoUpdateOSMenu;
var
  Form: TCommonCustomForm;
begin
  Form := nil;
  if not (csLoading in ComponentState) and not (csDesigning in ComponentState) then
  begin
    if Assigned(Root) and (Root.GetObject is TCommonCustomForm) then
      Form := TCommonCustomForm(Root.GetObject);
    UpdateVisible;
    if (not Visible) and
       (Assigned(Form)) and
       Assigned(FMenuService) and
       (FMenuService.IsMenuBarOnWindowBorder) then
    begin
      GMainMenu := self;
      FMenuService.CreateOSMenu(Form, self);
    end;
    if Assigned(Form) then
      TOpenCustomForm(Form).Realign;
  end;
end;

procedure TMenuBar.Loaded;
begin
  inherited;
  DoUpdateOSMenu(nil);
end;

procedure TMenuBar.DoRealign;
var
  ContentR: TRectF;
  P: TPointF;
  i: Integer;
  CurX: Single;
  Item: TMenuItem;
begin
  if (FUpdating = 0) and
     (not(csLoading in ComponentState)) and
     (not FDisableAlign) then
  begin
    FDisableAlign := True;
    try
      if Assigned(FContentLayout) then
      begin
        ContentR.TopLeft := AbsoluteToLocal(FContentLayout.LocalToAbsolute(PointF(0, 0)));
        P := AbsoluteToLocal(FContentLayout.LocalToAbsolute(PointF(FContentLayout.Width, FContentLayout.Height)));
        ContentR.BottomRight := PointF(Self.Width - P.X, Self.Height - P.Y);
      end
      else
        ContentR := RectF(0, 0, 0, 0);
      CurX := 0;
        for i := 0 to ItemsCount - 1 do
        begin
          Item := Items[I];
          if Item.Visible or
           ((csDesigning in ComponentState) and Item.DesignVisible) then
          begin
            P := Item.CalcSize;
            Item.SetBounds(ContentR.Left + CurX, ContentR.Top + Item.Margins.Top, P.X - Item.Margins.Left - Item.Margins.Right,
              Self.Height - Item.Margins.Top - Item.Margins.Bottom - ContentR.Top - ContentR.Bottom);
            CurX := CurX + Item.Width + Item.Margins.Left + Item.Margins.Right;
          end;
        end;
    finally
      FDisableAlign := False;
    end;
  end;
  inherited;
end;

procedure TMenuBar.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  if (AObject is TMenuItem) then
  begin
    FContent.RemoveObject(AObject);
    Realign;
  end;
end;

{ TMainMenu }

constructor TMainMenu.Create(AOwner: TComponent);
begin
  inherited;
  if Assigned(GMainMenu) and (not (csDesigning in ComponentState)) then
    raise EComponentError.Create(StrESingleMainMenu);
  if not TPlatformServices.Current.SupportsPlatformService(IFMXMenuService, IInterface(FMenuService)) then
    raise EUnsupportedPlatformService.Create('IFMXMenuService');
  GMainMenu := self;
  FStyleChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TStyleChangedMessage, StyleChangedHandler);
end;

destructor TMainMenu.Destroy;
var
  NeedClear: boolean;
begin
  TMessageManager.DefaultManager.Unsubscribe(TStyleChangedMessage, FStyleChangedId);
  NeedClear := (GMainMenu = self);
  if Assigned(FMenuService) then
    FMenuService.UpdateMenuBar;
  FMenuService := nil;
  inherited;
  if NeedClear then
    GMainMenu := nil;
end;

procedure TMainMenu.BeforeDestruction;
begin
  try
    SetHandle(0);
  except
    // nor what do not
  end;
  inherited;
end;

procedure TMainMenu.DialogKey(var Key: Word; Shift: TShiftState);
var
  I: integer;
  MItem: TMenuItem;
begin
  for I := GetItemsCount - 1 downto 0 do
  begin
    MItem:= TMenuItem(GetItem(I));
    MItem.DialogKey(Key, Shift);
  end;
end;

procedure TMainMenu.RecreateOSMenu;
begin
  if ([csLoading, csDestroying] * ComponentState = []) then
  begin
    if Assigned(Root) and (Root.GetObject is TCommonCustomForm) then
      FMenuService.CreateOSMenu(TCommonCustomForm(Root.GetObject), Self);
  end;
end;

procedure TMainMenu.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    RecreateOSMenu;
end;

procedure TMainMenu.DoAddObject(const AObject: TFmxObject);
begin
  if not(AObject is TMenuItem) then
    raise EComponentError.Create(SMainMenuSupportsOnlyTMenuItems);
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    TMenuItem(AObject).Handle := 0;
    RecreateOSMenu;
  end;
end;

procedure TMainMenu.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if not(AObject is TMenuItem) then
    raise EComponentError.Create(SMainMenuSupportsOnlyTMenuItems);
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    TMenuItem(AObject).Handle := 0;
    RecreateOSMenu;
  end;
end;

procedure TMainMenu.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    RecreateOSMenu;
end;

function TMainMenu.GetHandle: TFmxHandle;
begin
  Result := FHandle;
end;

procedure TMainMenu.SetHandle(const Value: TFmxHandle);
begin
  if FHandle <> Value then
  begin
    if FHandle <> 0 then
      FMenuService.DestroyMenuItem(self);
    FHandle := Value;
  end;
end;

procedure TMainMenu.StyleChangedHandler(const Sender: TObject; const Msg: TMessage);
begin
  if not (csDesigning in ComponentState) then
    RecreateOSMenu;
end;

function TMainMenu.GetHandleSupported: boolean;
begin
  Result := not (csDesigning in ComponentState);
end;

function TMainMenu.GetItem(const AIndex: Integer): TFmxObject;
begin
  Result := Children[AIndex] as TMenuItem;
end;

function TMainMenu.GetItemsCount: Integer;
begin
  Result:= ChildrenCount;
end;

function TMainMenu.GetObject: TFmxObject;
begin
  Result := Self;
end;

{ TStartMenuLoopMessage }

constructor TStartMenuLoopMessage.Create(const ARoot: IRoot);
begin
  inherited Create;
  FRoot := ARoot;
end;

initialization
  vClickList := nil;
  GMainMenu := nil;
  RegisterFmxClasses([TMenuItem, TMenuView, TPopupMenu, TMainMenu, TMenuBar]);

finalization
  FreeAndNil(vClickList);

end.
