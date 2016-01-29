{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.ScreenTips;

interface

uses
  {$IFDEF CLR}
  WinUtils,
  {$ENDIF CLR}
  System.Classes, System.Actions, Vcl.ActnMan, Vcl.ActnList, Winapi.Windows, Vcl.Graphics, Vcl.ExtCtrls, Vcl.AppEvnts, Vcl.Forms,
  System.Types, System.SysUtils, Vcl.Controls, System.Contnrs, Winapi.Messages;

{$IF NOT DEFINED(CLR)}
  {$DEFINE USE_ZLIB}
{$ENDIF}

const
  // Screen Tips default gradient colors
  cDefaultStartColor = clWhite;
  cDefaultEndColor = clBtnFace;
  cDefaultBorderColor = $00767676;

  // Spacing between the Header and Description text
  cScreenTipHeaderSpacing = 14;
  // Width of the ScreenTip when only text is being displayed
  cScreenTipTextOnlyWidth = 210;
  // Width of the ScreenTip when text and an image are to be displayed
  cScreenTipTextAndImageWidth = 318;
  // Minimum height of a ScreenTip
  cScreenTipMinimumHeight = 50;

type
  TTipBorderStyle = (hbsNormal, hbsRounded);

  TScreenTipsWindowClass = class of TScreenTipsWindow;
  TScreenTipItem = class;

  TScreenTipsWindow = class(THintWindow)
  private
    FBody: string;
    FImage: TPicture;
    FGradientStartColor: TColor;
    FGradientEndColor: TColor;
    FHelpBitmap: TBitmap;
    FVisibleTimer: TTimer;
    FTimeOutTimer: TTimer;
    FActiveItem: TScreenTipItem;
    FFooter: string;
    FHintControl: TControl;
    FTipBorderStyle: TTipBorderStyle;
    FCornerSize: Integer;
    FTitle: string;
    function HasDisabledText: Boolean;
    procedure SetHelpBitmap(const Value: TBitmap);
    procedure SetFooter(const Value: string);
    procedure SetGradientEndColor(const Value: TColor);
    procedure SetGradientStartColor(const Value: TColor);
    procedure SetBody(const Value: string);
    procedure SetImage(const Value: TPicture);
    procedure TimeOutTimerHandler(Sender: TObject);
    procedure VisibleTimerHandler(Sender: TObject);
  protected
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateRoundedStyle; virtual;
    procedure CreateTipBorderStyle; virtual;
    procedure CreateWnd; override;
    procedure DrawBackground(const aRect: TRect); virtual;
    procedure DrawBorder(const aRect: TRect); virtual;
    procedure DrawFooter; virtual;
    function DrawHeader: Integer; virtual;
    procedure Paint; override;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ActivateToolTip(Rect: TRect; Item: TScreenTipItem); virtual;
    procedure HideHint;
    property HintControl: TControl read FHintControl write FHintControl;
    property Image: TPicture read FImage write SetImage;
    property GradientStartColor: TColor read FGradientStartColor write SetGradientStartColor;
    property GradientEndColor: TColor read FGradientEndColor write SetGradientEndColor;
    property Body: string read FBody write SetBody;
    property Footer: string read FFooter write SetFooter;
    property FooterImage: TBitmap read FHelpBitmap write SetHelpBitmap;
    property ActiveItem: TScreenTipItem read FActiveItem;
    property TipBorderStyle: TTipBorderStyle read FTipBorderStyle write FTipBorderStyle default hbsRounded;
    property CornerSize: Integer read FCornerSize write FCornerSize default 5;
  end;

  TScreenTipOption = (soShowHeader, soShowShortCut);
  TScreenTipOptions = set of TScreenTipOption;

  TImageAlign = (iaLeft, iaRight);
  TItemImageAlign = (iiaLeft, iiaCenter, iiaRight);

  TDescriptionType = (dtManual, dtHelp, dtResource);

  TScreenTipsCollection = class;

  TCustomScreenTipsManager = class;

  TScreenTipItem = class(TCollectionItem)
  private
    FHeader: string;
    FImage: TPicture;
    FDescription: TStrings;
    FAction: TContainedAction;
    FItemOwner: TScreenTipsCollection;
    FShowImage: Boolean;
    FDisabledDescription: TStrings;
    FWidth: Integer;
    FHeight: Integer;
    FCacheDisabledHeight: Integer;
    FCacheDisabledWidth: Integer;
    FShowFooter: Boolean;
    FManager: TCustomScreenTipsManager;
    FDisabledHeader: string;
    procedure SetDescription(const Value: TStrings);
    procedure SetDisabledDescription(const Value: TStrings);
    function GetHeight: Integer;
    function GetManager: TCustomScreenTipsManager;
    procedure SetImage(const Value: TPicture);
    procedure SetAction(const Value: TContainedAction);
    procedure DescriptionChange(Sender: TObject);
    function IsDisableHeaderStored: Boolean;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure SetManager(AManager: TCustomScreenTipsManager);
    function IsEnabled: Boolean;
    property Height: Integer read GetHeight write FHeight;
    property Width: Integer read FWidth write FWidth;
  published
    property Action: TContainedAction read FAction write SetAction;
    property Description: TStrings read FDescription write SetDescription;
    property DisabledHeader: string read FDisabledHeader write FDisabledHeader stored IsDisableHeaderStored;
    property DisabledDescription: TStrings read FDisabledDescription write SetDisabledDescription;
    property Header: string read FHeader write FHeader;
    property Image: TPicture read FImage write SetImage;
    property Manager: TCustomScreenTipsManager read GetManager;
    property ShowFooter: Boolean read FShowFooter write FShowFooter default True;
    property ShowImage: Boolean read FShowImage write FShowImage default False;
  end;

  TScreenTipsCollection = class(TCollection)
  private
    FManager: TCustomScreenTipsManager;
    function GetItem(Index: Integer): TScreenTipItem;
    procedure SetItem(Index: Integer; const Value: TScreenTipItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(Manager: TCustomScreenTipsManager);
    function Add: TScreenTipItem;
    function Insert(Index: Integer): TScreenTipItem;
    property Items[Index: Integer]: TScreenTipItem read GetItem write SetItem; default;
  end;

  TScreenTipsManager = class;

  TScreenTipBorderStyle = class(TPersistent)
  private
    FColor: TColor;
    FCornerSize: Integer;
    FStyle: TTipBorderStyle;
  public
    constructor Create;
  published
    property Style: TTipBorderStyle read FStyle write FStyle default hbsRounded;
    property CornerSize: Integer read FCornerSize write FCornerSize default 5;
    property Color: TColor read FColor write FColor default cDefaultBorderColor;
  end;

  TShowScreenTipEvent = procedure (Manager: TObject; Action: TBasicAction;
    var ShowScreenTip: Boolean) of object;
  TScreenTipWinClass = procedure (Manager: TObject;
    var ScreenTipWinClass: TScreenTipsWindowClass) of object;
  TCreateScreenTipEvent = procedure (Manager: TObject; Item: TScreenTipItem) of object;
  TDuplicateCreateErrorEvent = procedure (Manager: TObject; Action: TBasicAction) of object;

  TDisplayOffset = class(TPersistent)
  private
    FX: Integer;
    FY: Integer;
    FControl: TControl;
  public
    constructor Create;
  published
    property Control: TControl read FControl write FControl;
    property X: Integer read FX write FX default 0;
    property Y: Integer read FY write FY default 5;
  end;

  EAllocatedActionsException = class(Exception);

  TAllocatedActions = class
  private
    FList: TStringList;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddAction(const aName: string; aScreenTipItem: TObject);
    procedure Clear;
    function Delete(const aName: string; out aIndex: Integer): Boolean;
    function Exists(const aName: string): Boolean;
    function Find(const aName: string; out aIndex: Integer): Boolean;
    function GetItem(const aName: string): TScreenTipItem;
    property Count: Integer read GetCount;
  end;

  // Holds the TScreenTipsPopup component and the control it is associated with
  TAssociateItem = class
  private
    FPopupTip: TControl;
    FAssociate: TControl;
  public
    constructor Create(APopupTip, AAssociate: TControl);
    destructor Destroy; override;
    property PopupTip: TControl read FPopupTip write FPopupTip;
    property Associate: TControl read FAssociate write FAssociate;
  end;

  // Holds a list of TScreenTipsPopup components and the control associated with it
  TAssociateItemList = class
  private
    FList: TObjectList;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Add(Popup, Associate: TControl);
    procedure Remove(Associate: TControl);
    function Find(Associate: TControl): Integer;
    function Get(const Idx: Integer): TAssociateItem;
  end;

  TCustomScreenTipsManager = class(TComponent)
  private
    FLinkedActionLists: TActionListCollection;
    FScreenTips: TScreenTipsCollection;
    FAllocatedActions: TAllocatedActions;
    FFooter: string;
    FFooterImage: TPicture;
    FOptions: TScreenTipOptions;
    FAppEvents: TApplicationEvents;
    FWnd: TScreenTipsWindow;
    FGradientStartColor: TColor;
    FGradientEndColor: TColor;
    FOnGetScreenTipWinClass: TScreenTipWinClass;
    FOnShowScreenTip: TShowScreenTipEvent;
    FOnCreateScreenTip: TCreateScreenTipEvent;
    FOnScreenTipsLoaded: TNotifyEvent;
    FAcceptFocus: Boolean;
    FOnDuplicateCreateError: TDuplicateCreateErrorEvent;
    FBorderStyle: TScreenTipBorderStyle;
    FDisplayOffset: TDisplayOffset;
    FCalculatingHeight: Boolean;
    FPopupControlList: TComponentList;
    FAssociateItemList: TAssociateItemList;
    FFont: TFont;
    procedure ApplicationActivate(Sender: TObject);
    procedure ApplicationDeactivate(Sender: TObject);
    procedure ApplicationShowHint(var HintStr: string; var CanShow: Boolean;
      var HintInfo: THintInfo);
    function CalculateHeight(Item: TScreenTipItem): Integer;
    function CalculateWidth(Item: TScreenTipItem): Integer;
    procedure GenerateScreenTipsForActionList(aActionList: TCustomActionList);
    function GetLinkedActionLists: TActionListCollection;
    function GetScreenTips: TScreenTipsCollection;
    function HasLinkedActionLists: Boolean;
    procedure HideActiveHint;
    function IsDisplayOffsetStored: Boolean;
    function IsFooterStored: Boolean;
    function IsFontStored: Boolean;
    function IsLinkedActionListsStored: Boolean;
    function IsScreenTipItemsStored: Boolean;
    procedure SetFont(const Value: TFont);
    procedure SetFooterImage(const Value: TPicture);
    procedure SetLinkedActionLists(const Value: TActionListCollection);
    procedure SetScreenTips(const Value: TScreenTipsCollection);
    procedure ValidateAllocatedActions;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoCreateScreenTip(aItem: TScreenTipItem); virtual;
    procedure DoDuplicateCreateError(aAction: TBasicAction); virtual;
    procedure DoGetScreenTipClass(var WindowClass: TScreenTipsWindowClass); virtual;
    procedure DoScreenTipsLoaded; virtual;
    procedure DoShow(Item: TScreenTipItem; var HintInfo: THintInfo); virtual;
    procedure DoShowScreenTip(Action: TBasicAction; Item: TScreenTipItem;
      var HintInfo: THintInfo); virtual;
    procedure Loaded; override;
    procedure UpdateActionInfo(aAction: TContainedAction; aTooltip: TScreenTipItem);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddPopup(AScreenTipPopup: TCustomControl);
    procedure ClearScreenTips;
    function CreateScreenTip(aAction: TBasicAction): TScreenTipItem;
    function GenerateScreenTips: Boolean;
    function GetScreenTip(aAction: TBasicAction): TScreenTipItem;
    procedure RemovePopup(AScreenTipPopup: TCustomControl);
    function RemoveScreenTip(aScreenTip: TScreenTipItem): Boolean;
    procedure UpdateOptions;
    property BorderStyle: TScreenTipBorderStyle read FBorderStyle write FBorderStyle;
    property DisplayOffset: TDisplayOffset read FDisplayOffset
      write FDisplayOffset stored IsDisplayOffsetStored;
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property Footer: string read FFooter write FFooter stored IsFooterStored;
    property FooterImage: TPicture read FFooterImage write SetFooterImage;
    property GradientEndColor: TColor read FGradientEndColor write FGradientEndColor default cDefaultEndColor;
    property GradientStartColor: TColor read FGradientStartColor write FGradientStartColor default cDefaultStartColor;
    property LinkedActionLists: TActionListCollection read GetLinkedActionLists
      write SetLinkedActionLists stored IsLinkedActionListsStored;
    property Options: TScreenTipOptions read FOptions write FOptions default [soShowHeader..soShowShortCut];
    property ScreenTips: TScreenTipsCollection read GetScreenTips
      write SetScreenTips stored IsScreenTipItemsStored;
    property OnCreateScreenTip: TCreateScreenTipEvent read FOnCreateScreenTip write FOnCreateScreenTip;
    property OnShowScreenTip: TShowScreenTipEvent read FOnShowScreenTip write FOnShowScreenTip;
    property OnGetScreenTipWinClass: TScreenTipWinClass read FOnGetScreenTipWinClass write FOnGetScreenTipWinClass;
    property OnScreenTipsLoaded: TNotifyEvent read FOnScreenTipsLoaded write FOnScreenTipsLoaded;
    property OnDuplicateCreateError: TDuplicateCreateErrorEvent read FOnDuplicateCreateError write FOnDuplicateCreateError;
  end;

  TScreenTipsManager = class(TCustomScreenTipsManager)
  published
    property BorderStyle;
    property DisplayOffset;
    property Font;
    property Footer;
    property FooterImage;
    property GradientEndColor;
    property GradientStartColor;
    property LinkedActionLists;
    property Options;
    property ScreenTips;
    property OnCreateScreenTip;
    property OnDuplicateCreateError;
    property OnShowScreenTip;
    property OnGetScreenTipWinClass;
    property OnScreenTipsLoaded;
  end;

  IScreenTipItem = interface
    ['{FC7D9558-D3EC-4C4D-8E68-ADFEC71451B1}']
    function GetScreenTipItem: TScreenTipItem;
  end;

  TScreenTipPopupType = (ptCustom, ptHelp, ptInfo);

  TCustomScreenTipsPopup = class(TCustomControl, IScreenTipItem)
  private
    FGlyph: TPicture;
    FCustomGlyph: TPicture;
    FKnownGlyph: TBitmap;
    FPopupType: TScreenTipPopupType;
    FScreenTipsManager: TCustomScreenTipsManager;
    FAssociate: TControl;
    FScreenTip: TScreenTipItem;
    FTransparent: Boolean;
    function GetPicture: TPicture;
    procedure InitialisePopupType;
    procedure ResizeControl;
    procedure SetAssociate(const Value: TControl);
    procedure SetPicture(const Value: TPicture);
    procedure SetPopupType(const Value: TScreenTipPopupType);
    procedure SetScreenTip(const Value: TScreenTipItem);
    procedure SetScreenTipsManager(const Value: TCustomScreenTipsManager);
    procedure SetTransparent(const Value: Boolean);
  protected
    procedure LinkPopupToManager; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure RemoveLinkToManager; virtual;
    procedure UpdateAssociateToManager; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetScreenTipItem: TScreenTipItem;
    property Associate: TControl read FAssociate write SetAssociate;
    property Glyph: TPicture read GetPicture write SetPicture;
    property PopupType: TScreenTipPopupType read FPopupType write SetPopupType default ptInfo;
    property ScreenTip: TScreenTipItem read FScreenTip write SetScreenTip;
    property ScreenTipManager: TCustomScreenTipsManager read FScreenTipsManager write SetScreenTipsManager;
    property Transparent: Boolean read FTransparent write SetTransparent default True;
  published
    property ShowHint default True;
  end;

  TScreenTipsPopup = class(TCustomScreenTipsPopup)
  published
    property Align;
    property Anchors;
    property Associate;
    property Glyph;
    property PopupType;
    property ScreenTip;
    property ScreenTipManager;
    property Transparent;
    property Visible;
  end;

implementation

uses
  System.UITypes, System.Math,
  Vcl.Menus, Vcl.Dialogs, Vcl.RibbonConsts, Vcl.GraphUtil, Vcl.ImgList{$IFDEF USE_ZLIB}, System.ZLib{$ENDIF};

{$R ScreenTips.res}

const
  cFooterHeight = 28;
  cFooterLineHeight = 2;
  cHeaderHeight = 26;
  cSpacing = 8;
  cMarginLeft = 16;
  cMarginRight = 16;

procedure LoadCompressedResourceBitmap(ResID: string; Bitmap: TBitmap);
{$IFDEF USE_ZLIB}
var
  LResStream: TResourceStream;
  LZStream: TZDecompressionStream;
{$ENDIF USE_ZLIB}
begin
{$IFDEF USE_ZLIB}
  LResStream := TResourceStream.Create(HInstance, ResID, RT_RCDATA);
  LZStream := TZDecompressionStream.Create(LResStream);
  try
    Bitmap.AlphaFormat := afDefined;
    Bitmap.LoadFromStream(LZStream);
  finally
    LZStream.Free;
    LResStream.Free;
  end;
{$ENDIF USE_ZLIB}
end;

{ TCustomScreenTipsManager }

procedure TCustomScreenTipsManager.AddPopup(AScreenTipPopup: TCustomControl);
begin
  if FPopupControlList.IndexOf(AScreenTipPopup) = -1 then
    FPopupControlList.Add(AScreenTipPopup);
  if (AScreenTipPopup as TScreenTipsPopup).Associate <> nil then
  begin
    FAssociateItemList.Add(AScreenTipPopup, (AScreenTipPopup as TScreenTipsPopup).Associate);
    FreeNotification(AScreenTipPopup);
  end;  
end;

procedure TCustomScreenTipsManager.ApplicationActivate(Sender: TObject);
begin
  HideActiveHint;
end;

procedure TCustomScreenTipsManager.ApplicationDeactivate(Sender: TObject);
begin
  HideActiveHint;
end;

procedure TCustomScreenTipsManager.ApplicationShowHint(var HintStr: string;
  var CanShow: Boolean; var HintInfo: THintInfo);
var
  LScreenTip: TScreenTipItem;
  LCheckShowing: Boolean;
  LIdx: Integer;
begin
  if (HintInfo.HintControl <> nil) then
  begin
    LScreenTip := nil;
    if HintInfo.HintControl is TScreenTipsPopup then
    begin
      LIdx := FPopupControlList.IndexOf(HintInfo.HintControl);
      if LIdx > -1 then
        LScreenTip := TScreenTipsPopup(FPopupControlList[LIdx]).GetScreenTipItem;
    end
    else
    begin
      LScreenTip := GetScreenTip(HintInfo.HintControl.Action);
      if LScreenTip = nil then
      begin
        LIdx := FAssociateItemList.Find(HintInfo.HintControl);
        if LIdx > -1 then
          LScreenTip := TScreenTipsPopup(FAssociateItemList.Get(LIdx).PopupTip).GetScreenTipItem;
      end;
    end;
    if (LScreenTip <> nil) then
    begin
      LCheckShowing := (FWnd <> nil) and (FWnd.ActiveItem <> nil);
      if LCheckShowing then
        LCheckShowing := (TScreenTipItem(FWnd.ActiveItem).Action = HintInfo.HintControl.Action);
      if not LCheckShowing then
        DoShowScreenTip(HintInfo.HintControl.Action, LScreenTip, HintInfo);
      HintStr := '';
    end;
  end;
end;

function TCustomScreenTipsManager.CalculateHeight(Item: TScreenTipItem): Integer;
var
  LWin: TScreenTipsWindow;
  LHeight: Integer;
  LWidth: Integer;
  LRect: TRect;
  LStr: string;
  LBitmapHeight: Integer;
  LGetDisabledHeight: Boolean;
  LFlags: Cardinal;

  function GetDescriptionHeight(AWin: TScreenTipsWindow): Integer;
  begin
    Result := cScreenTipHeaderSpacing;
    LRect := Rect(cMarginLeft, 0, AWin.Width - cMarginRight, 0);
    if LGetDisabledHeight then
    begin
      LFlags := DT_LEFT or DT_CALCRECT or DT_WORDBREAK or DT_NOPREFIX;
      DrawText(AWin.Canvas.Handle, Trim(Item.DisabledDescription.Text), -1, LRect, LFlags);
      Inc(Result, LRect.Bottom - LRect.Top + 16);
      AWin.Canvas.Font.Style := [fsBold];
      Inc(Result, AWin.Canvas.TextHeight(Item.DisabledHeader) + 16);
      AWin.Canvas.Font.Style := [];
    end
    else
    begin
      LFlags := DT_LEFT or DT_CALCRECT or DT_WORDBREAK or DT_NOPREFIX;
      DrawText(AWin.Canvas.Handle, Trim(Item.Description.Text), -1, LRect, LFlags);
      Inc(Result, LRect.Bottom - LRect.Top);
    end;
  end;

  function GetHeight(aWidth: Integer): Integer;
  begin
    LWin := TScreenTipsWindow.Create(nil);
    try
      Result := cSpacing;
      LWin.Width := aWidth;
      Inc(Result, GetDescriptionHeight(LWin));
      // Draw the dividing line for the footer if it is to be displayed
      if Item.ShowFooter then
        Result := Result + cFooterHeight + 2;
      if soShowHeader in Options then
      begin
        LWin.Canvas.Font.Style := [fsBold];
        LRect := Rect(8, 0, LWin.Width - 16, 0);
        LStr := Item.Header;
        if (Item.Action <> nil) and (soShowShortCut in Options) and
          (TCustomAction(Item.Action).ShortCut <> 0) then
          LStr := Format('%s (%s)', [LStr, ShortCutToText(TCustomAction(Item.Action).ShortCut)]);
        LFlags := DT_LEFT or DT_CALCRECT or DT_WORDBREAK or DT_NOPREFIX;
        DrawText(LWin.Canvas.Handle, LStr, -1, LRect, LFlags);
        Inc(Result, cScreenTipHeaderSpacing + LRect.Bottom - LRect.Top);
      end;
    finally
      LWin.Free;
    end;
  end;

begin
  FCalculatingHeight := True;
  try
    LGetDisabledHeight := Item.Action <> nil;
    if LGetDisabledHeight then
    begin
      LGetDisabledHeight := (not (csDesigning in ComponentState)) and
        (not TCustomAction(Item.Action).Enabled) and (Trim(Item.DisabledDescription.Text) <> '');
    end;
    LWidth := CalculateWidth(Item);
    // The height of the ScreenTip depends on the width of the help tip
    LHeight := GetHeight(LWidth);
    // check to see if the height needs to be adjusted
    // because of the size of the associated image
    if Item.ShowImage and ((Item.Image.Graphic <> nil) and not Item.Image.Graphic.Empty) then
    begin
      LBitmapHeight := Item.Image.Graphic.Height + 16;
      if (Item.Manager = nil) or (soShowHeader in Item.Manager.Options) then
        Inc(LBitmapHeight, cHeaderHeight);
      if Item.ShowFooter then
        Inc(LBitmapHeight, cFooterHeight + cFooterLineHeight);
      LHeight := Max(LHeight, LBitmapHeight);
    end;
    if LGetDisabledHeight then
    begin
      Item.FCacheDisabledHeight := LHeight;
      Item.FCacheDisabledWidth := LWidth;
    end
    else
    begin
      Item.Height := LHeight;
      Item.Width := LWidth;
    end;
    // make sure the correct height is returned (either disabled or enabled)
    if LGetDisabledHeight then
      Result := Item.FCacheDisabledHeight
    else
      Result := Item.Height;
    Result := Max(cScreenTipMinimumHeight, Result);
  finally
    FCalculatingHeight := False;
  end;
end;

// Calculate the width of the screen tip.
//
// A ScreenTip can have only two widths. If the ScreenTip has an image to
// display then it's width is 318 pixels, if the ScreenTip has no image to
// display, then the width of the ScreenTip is 210 pixels.
function TCustomScreenTipsManager.CalculateWidth(Item: TScreenTipItem): Integer;
begin
  if Item.ShowImage and (Item.Image.Graphic <> nil) and
    (not Item.Image.Graphic.Empty) and Item.IsEnabled then
    Item.Width := cScreenTipTextAndImageWidth
  else
    Item.Width := cScreenTipTextOnlyWidth;
  Result := Item.Width;
end;

procedure TCustomScreenTipsManager.ClearScreenTips;
begin
  FAllocatedActions.Clear;
  if FScreenTips <> nil then
    FScreenTips.Clear;
end;

constructor TCustomScreenTipsManager.Create(AOwner: TComponent);
begin
  inherited;
  FWnd := nil;
  FLinkedActionLists := nil;
  FFont := TFont.Create;
  FAllocatedActions := TAllocatedActions.Create;
  FFooterImage := TPicture.Create;
  LoadCompressedResourceBitmap('SCREENTIPS_FOOTER', FFooterImage.Bitmap);
  FOptions := [soShowHeader..soShowShortCut];
  FFooter := SDefaultFooterText;
  FGradientStartColor := cDefaultStartColor;
  FGradientEndColor := cDefaultEndColor;
  FBorderStyle := TScreenTipBorderStyle.Create;
  FAcceptFocus := True;
  FDisplayOffset := TDisplayOffset.Create;
  FDisplayOffset.X := 0;
  FDisplayOffset.Y := 5;
  FPopupControlList := TComponentList.Create(False);
  FAssociateItemList := TAssociateItemList.Create;
  if not (csDesigning in ComponentState) then
  begin
    FAppEvents := TApplicationEvents.Create(Self);
    FAppEvents.OnShowHint := ApplicationShowHint;
    FAppEvents.OnActivate := ApplicationActivate;
    FAppEvents.OnDeactivate := ApplicationDeactivate;
  end;
end;

function TCustomScreenTipsManager.CreateScreenTip(aAction: TBasicAction): TScreenTipItem;
begin
  Result := GetScreenTip(aAction);
  if Result = nil then
  begin
    Result := ScreenTips.Add;
    Result.Action := TContainedAction(aAction);
    DoCreateScreenTip(Result);
  end
  else
    DoDuplicateCreateError(aAction);
end;

procedure TCustomScreenTipsManager.ValidateAllocatedActions;
var
  I: Integer;
  LItem: TScreenTipItem;
  LFoundActionsList: TStringList;
begin
  if FScreenTips = nil then
    Exit;
  if (FScreenTips.Count = 0) then
    FAllocatedActions.Clear
  else
  begin
    LFoundActionsList := TStringList.Create;
    try
      for I := 0 to FScreenTips.Count - 1 do
      begin
        if FScreenTips.Items[I] <> nil then
        begin
          LItem := FScreenTips[I];
          if (LItem.Action <> nil) and (FAllocatedActions.Exists(LItem.Action.Name)) then
            LFoundActionsList.AddObject(LItem.Action.Name, LItem);
        end;
      end;
      FAllocatedActions.Clear;
      if LFoundActionsList.Count > 0 then
      begin
        for I := 0 to LFoundActionsList.Count - 1 do
        begin
          FAllocatedActions.AddAction(LFoundActionsList[I], LFoundActionsList.Objects[I]);
        end;
      end;
    finally
      LFoundActionsList.Free;
    end;
  end;
end;

destructor TCustomScreenTipsManager.Destroy;
begin
  if FWnd <> nil then
    FreeAndNil(FWnd);
  FAllocatedActions.Free;
  if FLinkedActionLists <> nil then
    FLinkedActionLists.Free;
  FFooterImage.Free;
  if not (csDesigning in ComponentState) then
    FAppEvents.Free;
  FBorderStyle.Free;
  FDisplayOffset.Free;
  if FScreenTips <> nil then
    FScreenTips.Free;
  FAssociateItemList.Free;
  FPopupControlList.Free;
  FFont.Free;
  inherited;
end;

procedure TCustomScreenTipsManager.DoCreateScreenTip(aItem: TScreenTipItem);
begin
  if Assigned(FOnCreateScreenTip) then
    FOnCreateScreenTip(Self, aItem);
end;

procedure TCustomScreenTipsManager.DoDuplicateCreateError(aAction: TBasicAction);
begin
  if Assigned(FOnDuplicateCreateError) then
    FOnDuplicateCreateError(Self, aAction);
end;

procedure TCustomScreenTipsManager.DoScreenTipsLoaded;
begin
  if Assigned(FOnScreenTipsLoaded) then
    FOnScreenTipsLoaded(Self);
end;

procedure TCustomScreenTipsManager.DoShow(Item: TScreenTipItem; var HintInfo: THintInfo);
var
  LClass: TScreenTipsWindowClass;
  LRect: TRect;
  LPt: TPoint;
  LMinHeight: Integer;
  LMinWidth: Integer;
  LXPt: TPoint;
begin
  LClass := TScreenTipsWindow;
  DoGetScreenTipClass(LClass);
  if LClass = nil then
    LClass := TScreenTipsWindow;
  HintInfo.HintWindowClass := nil;
  if FWnd <> nil then
    FreeAndNil(FWnd);
  FWnd := LClass.Create(nil);
  FWnd.Font := Font;
  FWnd.HintControl := HintInfo.HintControl;
  if Item.Manager <> nil then
    LPt.X := Item.Manager.DisplayOffset.X
  else
    LPt.X := 0;
  if (Item.Manager <> nil) and (Item.Manager.DisplayOffset.Control = nil) or
    (HintInfo.HintControl is TScreenTipsPopup) or
    (FAssociateItemList.Find(HintInfo.HintControl) > -1) then
  begin
    LPt.Y := HintInfo.HintControl.Height;
    LPt.Y := LPt.Y + Item.Manager.DisplayOffset.Y;
    LPt := HintInfo.HintControl.ClientToScreen(LPt);
  end
  else if (Item.Manager <> nil) then
  begin
    LPt := Point(Item.Manager.DisplayOffset.Control.Left, 0);
    LPt := Item.Manager.DisplayOffset.Control.ClientToScreen(LPt);
    LXPt.X := Item.Manager.DisplayOffset.X;
    LXPt.Y := 0;
    LXPt := HintInfo.HintControl.ClientToScreen(LXPt);
    LPt.X := LXPt.X;
    LPt.Y := LPt.Y + Item.Manager.DisplayOffset.Control.Height + Item.Manager.DisplayOffset.Y;
  end
  else
  begin
    LPt.Y := HintInfo.HintControl.Height;
    LPt := HintInfo.HintControl.ClientToScreen(LPt);
  end;
  LMinHeight := CalculateHeight(Item);
  LMinWidth := Item.Width;
  LRect := Rect(LPt.X, LPt.Y, LPt.X + LMinWidth, LPt.Y + LMinHeight - 4);
  FWnd.ActivateToolTip(LRect, Item);
end;

procedure TCustomScreenTipsManager.DoShowScreenTip(Action: TBasicAction;
  Item: TScreenTipItem; var HintInfo: THintInfo);
var
  LShowHelpTip: Boolean;
begin
  LShowHelpTip := True;
  if Assigned(FOnShowScreenTip) then
    FOnShowScreenTip(Self, Action, LShowHelpTip);
  if LShowHelpTip then
    DoShow(Item, HintInfo);
end;

procedure TCustomScreenTipsManager.DoGetScreenTipClass(
  var WindowClass: TScreenTipsWindowClass);
begin
  if Assigned(FOnGetScreenTipWinClass) then
    FOnGetScreenTipWinClass(Self, WindowClass);
end;

procedure TCustomScreenTipsManager.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
  LIdx: Integer;
  LItem: TScreenTipItem;
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if AComponent = FDisplayOffset.Control then
      FDisplayOffset.Control := nil
    else if AComponent is TBasicAction then
    begin
      if FScreenTips <> nil then
      begin
        for I := 0 to FScreenTips.Count - 1 do
        begin
          LItem := FScreenTips.Items[I];
          if LItem.Action = AComponent then
          begin
            FScreenTips.Delete(I);
            Break;
          end;
        end;
      end;
    end
    else if (AComponent is TCustomActionList) and (FLinkedActionLists <> nil) then
    begin
      if FLinkedActionLists <> nil then
      begin
        for I := FLinkedActionLists.Count - 1 downto 0 do
        begin
          if FLinkedActionLists[I].ActionList = AComponent then
          begin
            FLinkedActionLists.Delete(I);
            Break;
          end;
        end;
      end;
    end
    else
    begin
      if (FPopupControlList <> nil) and (AComponent <> Self) then
      begin
        LIdx := FPopupControlList.IndexOf(AComponent);
        if LIdx > -1 then
          RemovePopup(AComponent as TCustomControl);
      end;
    end;
  end;
end;

function TCustomScreenTipsManager.RemoveScreenTip(aScreenTip: TScreenTipItem): Boolean;
var
  LIdx: Integer;
begin
  Result := False;
  if aScreenTip <> nil then
  begin
    if FAllocatedActions.Delete(aScreenTip.Action.Name, LIdx) then
    begin
      for LIdx := 0 to FScreenTips.Count - 1 do
      begin
        if FScreenTips[LIdx] = aScreenTip then
          Break;
      end;
      Result := (LIdx > -1) and (FScreenTips.Count > LIdx) and (FScreenTips[LIdx] = aScreenTip);
      if Result then
        FScreenTips.Delete(LIdx);
    end;
  end;
end;

procedure TCustomScreenTipsManager.RemovePopup(AScreenTipPopup: TCustomControl);
var
  LIdx: Integer;
begin
  RemoveFreeNotification(AScreenTipPopup);
  LIdx := FPopupControlList.IndexOf(AScreenTipPopup);
  if LIdx > -1 then
    FPopupControlList.Delete(LIdx);
end;

procedure TCustomScreenTipsManager.SetLinkedActionLists(const Value: TActionListCollection);
begin
  if not Assigned(FLinkedActionLists) then
    FLinkedActionLists := TActionListCollection.Create(Self, TActionListItem);
  FLinkedActionLists.Assign(Value);
end;

function TCustomScreenTipsManager.IsLinkedActionListsStored: Boolean;
begin
  Result := HasLinkedActionLists and (LinkedActionLists.Count > 0);
end;

procedure TCustomScreenTipsManager.Loaded;
begin
  inherited;
  ValidateAllocatedActions;
end;

function TCustomScreenTipsManager.GetLinkedActionLists: TActionListCollection;
begin
  if FLinkedActionLists = nil then
    FLinkedActionLists := TActionListCollection.Create(Self, TActionListItem);
  Result := FLinkedActionLists;
end;

function TCustomScreenTipsManager.HasLinkedActionLists: Boolean;
begin
  Result := FLinkedActionLists <> nil;
end;

procedure TCustomScreenTipsManager.HideActiveHint;
begin
  if FWnd <> nil then
    FWnd.HideHint;
end;


procedure TCustomScreenTipsManager.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TCustomScreenTipsManager.SetFooterImage(const Value: TPicture);
begin
  if FFooterImage <> nil then
    FFooterImage.Assign(Value);
end;

function TCustomScreenTipsManager.GetScreenTips: TScreenTipsCollection;
begin
  if FScreenTips = nil then
    FScreenTips := TScreenTipsCollection.Create(Self);
  Result := FScreenTips;
end;

procedure TCustomScreenTipsManager.SetScreenTips(const Value: TScreenTipsCollection);
begin
  if FScreenTips = nil then
    FScreenTips := TScreenTipsCollection.Create(Self);
  FScreenTips.Assign(Value);
end;

function TCustomScreenTipsManager.IsDisplayOffsetStored: Boolean;
begin
  Result := (FDisplayOffset.X <> 0) or (FDisplayOffset.Y <> 0) or
    (FDisplayOffset.Control <> nil);
end;

function TCustomScreenTipsManager.IsFontStored: Boolean;
begin
  Result := (FFont.Name <> string(DefFontData.Name)) and (FFont.Height <> DefFontData.Height) and
    (FFont.CharSet <> DefFontData.Charset);
end;

function TCustomScreenTipsManager.IsFooterStored: Boolean;
begin
  Result := FFooter <> SDefaultFooterText;
end;

function TCustomScreenTipsManager.IsScreenTipItemsStored: Boolean;
begin
  Result := (FScreenTips <> nil) and (ScreenTips.Count > 0);
end;

function TCustomScreenTipsManager.GetScreenTip(aAction: TBasicAction): TScreenTipItem;
begin
  if (aAction <> nil) and (FAllocatedActions.Exists(aAction.Name)) then
    Result := FAllocatedActions.GetItem(aAction.Name)
  else
    Result := nil;
end;

procedure TCustomScreenTipsManager.UpdateActionInfo(aAction: TContainedAction; aTooltip: TScreenTipItem);
var
  LIdx: Integer;
  LOldItem: TScreenTipItem;
begin
  if aAction = nil then
    Exit;
  if FAllocatedActions.Find(aAction.Name, LIdx) then
  begin
    LOldItem := FAllocatedActions.GetItem(aAction.Name);
    LOldItem.Action := nil;
    FAllocatedActions.Delete(aAction.Name, LIdx);
  end;
  if aTooltip <> nil then
    FAllocatedActions.AddAction(aAction.Name, aTooltip);
end;

procedure TCustomScreenTipsManager.UpdateOptions;
begin
  // forces any changed options to be used
  // as the tip window will now be recreated
  if FWnd <> nil then
    FreeAndNil(FWnd);
end;

procedure TCustomScreenTipsManager.GenerateScreenTipsForActionList(aActionList: TCustomActionList);
var
  I: Integer;
begin
  for I := 0 to aActionList.ActionCount - 1 do
  begin
    if GetScreenTip(aActionList.Actions[I]) = nil then
    begin
      // create one
      CreateScreenTip(aActionList.Actions[I]);
    end;
  end;
end;

function TCustomScreenTipsManager.GenerateScreenTips: Boolean;
var
  I: Integer;
begin
  ValidateAllocatedActions;
  if LinkedActionLists.Count > 0 then
  begin
    for I := 0 to LinkedActionLists.Count - 1 do
     GenerateScreenTipsForActionList(LinkedActionLists[I].ActionList);
  end
  else if (csDesigning in ComponentState) then
    MessageDlg(SGenerateScreenTipsError, mtInformation, [mbOK], 0);
  DoScreenTipsLoaded;
  Result := FScreenTips.Count > 0;
end;

{ TScreenTipItem }

procedure TScreenTipItem.Assign(Source: TPersistent);
var
  LSrc: TScreenTipItem;
begin
  if not (Source is TScreenTipItem) then
    raise Exception.Create(SInvalidScreenTipItemAssign);
  LSrc := TScreenTipItem(Source);
  FAction := LSrc.Action;
  FHeader := LSrc.Header;
  FDisabledHeader := LSrc.DisabledHeader;
  FImage.Assign(LSrc.Image);
  FDescription.Assign(LSrc.Description);
  FShowImage := LSrc.ShowImage;
  FDisabledDescription.Assign(LSrc.DisabledDescription);
  FShowFooter := LSrc.ShowFooter;
end;

constructor TScreenTipItem.Create(Collection: TCollection);
begin
  inherited;
  FManager := nil;
  FImage := TPicture.Create;
  FItemOwner := TScreenTipsCollection(Collection);
  FShowFooter := True;
  FShowImage := False;
  FDescription := TStringList.Create;
  FDisabledHeader := SCommandIsDisabled;
  TStringList(FDescription).OnChange := DescriptionChange;
  FDisabledDescription := TStringList.Create;
  TStringList(FDisabledDescription).OnChange := DescriptionChange;
end;

procedure TScreenTipItem.DescriptionChange(Sender: TObject);
begin
  FCacheDisabledHeight := 0;
  FHeight := 0;
  FWidth := 0;
  FCacheDisabledWidth := 0;
end;

destructor TScreenTipItem.Destroy;
begin
  FImage.Free;
  FDescription.Free;
  FDisabledDescription.Free;
  inherited;
end;

function TScreenTipItem.GetHeight: Integer;
begin
  // default a height if no manager assigned
  if Manager = nil then
  begin
    Result := cScreenTipMinimumHeight;
    Exit;
  end;
  if Manager.FCalculatingHeight then
    Result := FHeight
  else
  begin
    if FHeight = 0 then
      Manager.CalculateHeight(Self as TScreenTipItem);
    Result := FHeight;
  end;
end;

function TScreenTipItem.GetDisplayName: string;
begin
  if FAction <> nil then
    Result := FAction.Name + ' -> ' + FHeader
  else if FHeader <> '' then
    Result := FHeader
  else
    Result := inherited GetDisplayName;
end;

function TScreenTipItem.GetManager: TCustomScreenTipsManager;
begin
  if FManager = nil then
  begin
    if FItemOwner <> nil then
      FManager := FItemOwner.FManager;
  end;
  Result := FManager;
end;

function TScreenTipItem.IsDisableHeaderStored: Boolean;
begin
  Result := FDisabledHeader <> SCommandIsDisabled;
end;

function TScreenTipItem.IsEnabled: Boolean;
begin
  Result := (Action = nil) or TCustomAction(Action).Enabled;
end;

procedure TScreenTipItem.SetAction(const Value: TContainedAction);
var
  LCustomAction: TCustomAction;
  LDescription: string;
begin
  FAction := Value;
  if (Value <> nil) and (FHeader = '') then
  begin
    if FAction is TCustomAction then
    begin
      LCustomAction := TCustomAction(FAction);
      FHeader := LCustomAction.Caption;
      FHeader := StripHotkey(FHeader);
      LDescription := LCustomAction.Hint;
      if POS('|', LDescription) > 0 then
        LDescription := Copy(LDescription, POS('|', LDescription) + 1, Length(LDescription));
      FDescription.Text := LDescription;
    end;
  end;
  if Manager <> nil then
    Manager.UpdateActionInfo(Value, Self);
end;

procedure TScreenTipItem.SetDescription(const Value: TStrings);
begin
  FDescription.Assign(Value);
end;

procedure TScreenTipItem.SetDisabledDescription(const Value: TStrings);
begin
  FDisabledDescription.Assign(Value);
end;

procedure TScreenTipItem.SetImage(const Value: TPicture);
begin
  FImage.Assign(Value);
end;

procedure TScreenTipItem.SetManager(AManager: TCustomScreenTipsManager);
begin
  FManager := AManager;
end;

{ TScreenTipsCollection }

function TScreenTipsCollection.Add: TScreenTipItem;
begin
  Result := TScreenTipItem(inherited Add);
end;

constructor TScreenTipsCollection.Create(Manager: TCustomScreenTipsManager);
begin
  inherited Create(TScreenTipItem);
  FManager := Manager;
end;
  
{ TScreenTipBorderStyle }

constructor TScreenTipBorderStyle.Create;
begin
  inherited;
  FStyle := hbsRounded;
  FCornerSize := 5;
  FColor := $00767676;
end;

function TScreenTipsCollection.GetItem(Index: Integer): TScreenTipItem;
begin
  Result := TScreenTipItem(inherited GetItem(Index));
end;

function TScreenTipsCollection.GetOwner: TPersistent;
begin
  Result := FManager;
end;

function TScreenTipsCollection.Insert(Index: Integer): TScreenTipItem;
begin
  Result := TScreenTipItem(inherited Insert(Index));
end;

procedure TScreenTipsCollection.SetItem(Index: Integer; const Value: TScreenTipItem);
begin
  inherited SetItem(Index, Value);
end;

{ TAllocatedActions }

procedure TAllocatedActions.AddAction(const aName: string; aScreenTipItem: TObject);
var
  LIdx: Integer;
begin
  if not FList.Find(aName, LIdx) then
    FList.AddObject(aName, aScreenTipItem)
  else
    FList.Objects[LIdx] := aScreenTipItem;
end;

procedure TAllocatedActions.Clear;
begin
  FList.Clear;
end;

constructor TAllocatedActions.Create;
begin
  inherited;
  FList := TStringList.Create;
  FList.Sorted := True;
end;

function TAllocatedActions.Delete(const aName: string; out aIndex: Integer): Boolean;
begin
  Result := FList.Find(aName, aIndex);
  FList.Delete(aIndex);
end;

destructor TAllocatedActions.Destroy;
begin
  FList.Free;
  inherited;
end;

function TAllocatedActions.Exists(const aName: string): Boolean;
var
  LIdx: Integer;
begin
  Result := FList.Find(aName, LIdx);
end;

function TAllocatedActions.Find(const aName: string; out aIndex: Integer): Boolean;
begin
  Result := FList.Find(aName, aIndex);
end;

function TAllocatedActions.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TAllocatedActions.GetItem(const aName: string): TScreenTipItem;
var
  LIdx: Integer;
begin
  if not Find(aName, LIdx) then
    Result := nil
  else
    Result := TScreenTipItem(FList.Objects[LIdx]);
end;

{ TAssociateItemList }

procedure TAssociateItemList.Add(Popup, Associate: TControl);
var
  LIdx: Integer;
begin
  if Popup = nil then
    Exit;
  LIdx := FList.IndexOf(Popup);
  if LIdx > -1 then
    TAssociateItem(FList[LIdx]).Associate := Associate
  else
    FList.Add(TAssociateItem.Create(Popup, Associate));
end;

constructor TAssociateItemList.Create;
begin
  inherited;
  FList := TObjectList.Create;
end;

destructor TAssociateItemList.Destroy;
begin
  FList.Free;
  inherited;
end;

function TAssociateItemList.Find(Associate: TControl): Integer;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
  begin
    if Get(I).Associate = Associate then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function TAssociateItemList.Get(const Idx: Integer): TAssociateItem;
begin
  if (Idx > -1) and (Idx < FList.Count) then
    Result := TAssociateItem(FList[Idx])
  else
    Result := nil;
end;

procedure TAssociateItemList.Remove(Associate: TControl);
var
  LIdx: Integer;
begin
  LIdx := Find(Associate);
  if LIdx > -1 then
  begin
    FList.Delete(LIdx);
  end;
end;

{ TAssociateItem }

constructor TAssociateItem.Create(APopupTip, AAssociate: TControl);
begin
  inherited Create;
  PopupTip := APopupTip;
  Associate := AAssociate;
end;

destructor TAssociateItem.Destroy;
begin
  FAssociate := nil;
  inherited;
end;

{ TCustomScreenTipsPopup }

constructor TCustomScreenTipsPopup.Create(AOwner: TComponent);
begin
  inherited;
  FGlyph := TPicture.Create;
  FTransparent := True;
  FCustomGlyph := TPicture.Create;
  FKnownGlyph := TBitmap.Create;
  InitialisePopupType;
  FScreenTip := TScreenTipItem.Create(nil);
  ShowHint := True;
end;

destructor TCustomScreenTipsPopup.Destroy;
begin
  FCustomGlyph.Free;
  FGlyph.Free;
  FScreenTip.Free;
  FKnownGlyph.Free;
  inherited;
end;

function TCustomScreenTipsPopup.GetScreenTipItem: TScreenTipItem;
begin
  Result := FScreenTip;
end;

function TCustomScreenTipsPopup.GetPicture: TPicture;
begin
  Result := FGlyph;
end;

procedure TCustomScreenTipsPopup.InitialisePopupType;
begin
  LoadCompressedResourceBitmap('SCREENTIPS_INFO', FKnownGlyph);
  Width := FKnownGlyph.Width;
  Height := FKnownGlyph.Height;
  FPopupType := ptInfo;
end;

procedure TCustomScreenTipsPopup.LinkPopupToManager;
begin
  if FScreenTipsManager <> nil then
    FScreenTipsManager.AddPopup(Self);
end;

procedure TCustomScreenTipsPopup.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FScreenTipsManager then
      FScreenTipsManager := nil
    else if AComponent = FAssociate then
      FAssociate := nil;
  end;
end;

procedure TCustomScreenTipsPopup.Paint;
var
  LPicture: TPicture;
begin
  inherited;
  if (PopupType = ptCustom) and (FGlyph.Graphic <> nil) and (not FGlyph.Graphic.Empty) then
  begin
    LPicture := TPicture.Create;
    try
      LPicture.Assign(FGlyph.Graphic);
      if FTransparent then
        LPicture.Graphic.Transparent := True;
      Canvas.Draw(0, 0, LPicture.Graphic);
    finally
      LPicture.Free;
    end;
  end
  else if (PopupType = ptInfo) or (PopupType = ptHelp) then
  begin
    if not FKnownGlyph.Empty then
    begin
      FKnownGlyph.Transparent := True;
      Canvas.Draw(0, 0, FKnownGlyph);
    end;
  end
  else
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.TextOut(0, 0, 'SUseTheGlyphProperty');
  end;
end;

procedure TCustomScreenTipsPopup.RemoveLinkToManager;
begin
  if FScreenTipsManager <> nil then
  begin
    FScreenTipsManager.RemovePopup(Self);
  end;
end;

procedure TCustomScreenTipsPopup.ResizeControl;
begin
  if (PopupType = ptCustom) and (FGlyph.Graphic <> nil) and (not FGlyph.Graphic.Empty) then
  begin
    Height := FGlyph.Graphic.Height;
    Width := FGlyph.Graphic.Width;
  end
  else if (PopupType = ptInfo) or (PopupType = ptHelp) then
  begin
    Height := FKnownGlyph.Height;
    Width := FKnownGlyph.Width;
  end
  else
  begin
    Width := Canvas.TextWidth(SUseTheGlyphProperty);
    Height := Canvas.TextHeight(SUseTheGlyphProperty);
  end;
end;

procedure TCustomScreenTipsPopup.SetAssociate(const Value: TControl);
begin
  if FAssociate <> Value then
  begin
    FAssociate := Value;
    UpdateAssociateToManager;
  end;
end;

procedure TCustomScreenTipsPopup.SetScreenTip(const Value: TScreenTipItem);
begin
  FScreenTip.Assign(Value);
end;

procedure TCustomScreenTipsPopup.SetScreenTipsManager(const Value: TCustomScreenTipsManager);
begin
  if FScreenTipsManager <> Value then
  begin
    FScreenTip.SetManager(Value);
    FScreenTipsManager := Value;
    if Value <> nil then
      LinkPopupToManager
    else
      RemoveLinkToManager;
  end;
end;

procedure TCustomScreenTipsPopup.SetPicture(const Value: TPicture);
begin
  if FPopupType = ptCustom then
    FCustomGlyph.Assign(Value);
  FGlyph.Assign(Value);
  ResizeControl;
  Invalidate;
end;

procedure TCustomScreenTipsPopup.SetPopupType(const Value: TScreenTipPopupType);
begin
  if FPopupType <> Value then
  begin
    FPopupType := Value;
    // set the correct glyph
    case FPopupType of
      ptCustom:
        begin
          if (FCustomGlyph.Graphic <> nil) and (not FCustomGlyph.Graphic.Empty) then
            FGlyph.Assign(FCustomGlyph)
          else if (FGlyph.Graphic <> nil) and (not FGlyph.Graphic.Empty) then
            FCustomGlyph.Assign(FGlyph)
          else
            FGlyph.Assign(nil);
        end;
      ptHelp: LoadCompressedResourceBitmap('SCREENTIPS_HELP', FKnownGlyph);
      ptInfo: LoadCompressedResourceBitmap('SCREENTIPS_INFO', FKnownGlyph);
    end;
    // force transparency for known PopupType
    if FPopupType <> ptCustom then
      Transparent := True;
    ResizeControl;
    Invalidate;
  end;
end;

procedure TCustomScreenTipsPopup.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    Invalidate;
  end;
end;

procedure TCustomScreenTipsPopup.UpdateAssociateToManager;
begin
  if FScreenTipsManager <> nil then
  begin
    FScreenTipsManager.AddPopup(Self);
  end;
end;

function CentreYPOS(aTextHeight, aImageHeight, aY: Integer): Integer; inline;
begin
  if aTextHeight > aImageHeight then
    Result := aY
  else
    Result := aY - ((aImageHeight - aTextHeight) div 2);
end;

function CenterY(const aImageHeight, aAreaHeight: Integer): Integer; inline;
begin
  Result := (aAreaHeight - aImageHeight) div 2;
end;

{ TScreenTipsWindow }

procedure TScreenTipsWindow.ActivateToolTip(Rect: TRect; Item: TScreenTipItem);
begin
  Width := Item.Width;
  Height := Item.Height;
  FActiveItem := Item;
  if (FActiveItem.Action <> nil) and (soShowShortCut in FActiveItem.Manager.Options) and
    (TCustomAction(FActiveItem.Action).ShortCut <> 0) then
  begin
    FTitle := Format('%s (%s)', [FActiveItem.Header,
      ShortCutToText(TCustomAction(FActiveItem.Action).ShortCut)]);
  end
  else
    FTitle := FActiveItem.Header;
  if FActiveItem.IsEnabled or not HasDisabledText then
    FBody := FActiveItem.Description.Text
  else
    FBody := FActiveItem.DisabledDescription.Text;
  FFooter := FActiveItem.Manager.Footer;
  FooterImage := FActiveItem.Manager.FooterImage.Bitmap;
  FGradientStartColor := FActiveItem.Manager.GradientStartColor;
  FGradientEndColor := FActiveItem.Manager.GradientEndColor;
  Image := FActiveItem.Image;
  FTipBorderStyle := FActiveItem.Manager.BorderStyle.Style;
  FCornerSize := FActiveItem.Manager.BorderStyle.CornerSize;
  ActivateHint(Rect, '');
  FVisibleTimer.Enabled := True;
  FTimeOutTimer.Enabled := True;
end;

procedure TScreenTipsWindow.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  HideHint;
end;

procedure TScreenTipsWindow.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  HideHint;
end;

constructor TScreenTipsWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clBtnFace;
  FImage := nil;
  FHelpBitmap := TBitmap.Create;
  FVisibleTimer := TTimer.Create(nil);
  FVisibleTimer.Interval := 250;
  FVisibleTimer.Enabled := False;
  FVisibleTimer.OnTimer := VisibleTimerHandler;
  FTimeOutTimer := TTimer.Create(nil);
  FTimeOutTimer.Interval := 20000;
  FTimeOutTimer.Enabled := False;
  FTimeOutTimer.OnTimer := TimeOutTimerHandler;
  FTipBorderStyle := hbsRounded;
  FCornerSize := 5;
end;

procedure TScreenTipsWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    WindowClass.Style := WindowClass.Style;
    if NewStyleControls then
      ExStyle := WS_EX_TOOLWINDOW;
    if CheckWin32Version(5, 1) then
      WindowClass.Style := WindowClass.Style or CS_DROPSHADOW;
    if NewStyleControls then
      ExStyle := WS_EX_TOOLWINDOW;
    AddBiDiModeExStyle(ExStyle);
  end;
end;

procedure TScreenTipsWindow.CreateRoundedStyle;
var
  LRgn: HRGN;
begin
  LRgn := CreateRoundRectRgn(0, 0, ClientWidth, ClientHeight,
    FCornerSize - 1, FCornerSize - 1);
  SetWindowRgn(Handle, LRgn, True);
end;

procedure TScreenTipsWindow.CreateTipBorderStyle;
begin
  if FTipBorderStyle = hbsRounded then
    CreateRoundedStyle;
end;

procedure TScreenTipsWindow.CreateWnd;
begin
  inherited;
  CreateTipBorderStyle;
end;

destructor TScreenTipsWindow.Destroy;
begin
  FreeAndNil(FVisibleTimer);
  FreeAndNil(FTimeOutTimer);
  FreeAndNil(FHelpBitmap);
  if FImage <> nil then
    FImage.Free;
  inherited;
end;

procedure TScreenTipsWindow.DrawBackground(const aRect: TRect);
begin
  // Draw backgrounds
  GradientFillCanvas(Canvas, FGradientStartColor, FGradientEndColor, aRect, gdVertical);
end;

procedure TScreenTipsWindow.DrawBorder(const aRect: TRect);
var
  LRect: TRect;
begin
  LRect := ARect;
  Canvas.Pen.Color := (FActiveItem as TScreenTipItem).Manager.BorderStyle.Color;
  Canvas.Pen.Width := 1;
  if FTipBorderStyle = hbsRounded then
  begin
    LRect.Right := LRect.Right - 1;
    LRect.Bottom := LRect.Bottom - 1;
    Canvas.RoundRect(0, 0, LRect.Right, LRect.Bottom, FCornerSize, FCornerSize);
  end
  else if FTipBorderStyle = hbsNormal then
    Canvas.Rectangle(LRect);
end;

procedure TScreenTipsWindow.DrawFooter;
var
  LRect: TRect;
  LTextHeight: Integer;
  LTextWidth: Integer;
begin
  // draw the footer
  if TScreenTipItem(FActiveItem).ShowFooter then
  begin
    // draw divider between footer and body
    Canvas.Pen.Width := 1;
    Canvas.Pen.Color := clGray;
    Canvas.MoveTo((cSpacing div 2) + 1, ClientRect.Bottom - cFooterHeight - cFooterLineHeight);
    Canvas.LineTo(ClientRect.Right - (cSpacing div 2) - 1, ClientRect.Bottom - cFooterHeight - cFooterLineHeight);
    Canvas.Pen.Color := clWhite;
    Canvas.MoveTo(cSpacing div 2, ClientRect.Bottom - cFooterHeight - 1);
    Canvas.LineTo(ClientRect.Right - (cSpacing div 2), ClientRect.Bottom - cFooterHeight - 1);
    Canvas.Draw(cSpacing, ClientRect.Bottom - cFooterHeight + CenterY(FHelpBitmap.Height, cFooterHeight), FHelpBitmap);
    // draw footer text
    LRect := ClientRect;
    LRect.Bottom := LRect.Top;
    Canvas.Font.Style := [fsBold];
    Canvas.Font.Color := clWindowText;
    DrawText(Canvas.Handle, FFooter, -1, LRect, DT_LEFT or DT_CALCRECT);
    LTextHeight := LRect.Bottom - LRect.Top;
    LRect.Top := ClientRect.Bottom - cFooterHeight + CenterY(LTextHeight, cFooterHeight);
    LTextWidth := Canvas.TextWidth(FFooter);
    // draw footer image
    if FHelpBitmap <> nil then
      LRect.Left := cSpacing + FHelpBitmap.Width + cSpacing
    else
      LRect.Left := cSpacing + cSpacing;
    LRect.Right := LRect.Left + LTextWidth;
    LRect.Bottom := LRect.Top + LTextHeight;
    DrawText(Canvas.Handle, FFooter, -1, LRect, DT_LEFT);
  end;
end;

function TScreenTipsWindow.DrawHeader: Integer;
var
  LRect: TRect;
  LTitleHeight: Integer;
begin
  // when overriding DrawHeader you MUST return the height of the header
  if soShowHeader in FActiveItem.Manager.Options then
  begin
    LRect := ClientRect;
    Canvas.Font.Style := [fsBold];
    LRect.Top := LRect.Top + cSpacing;
    LRect.Left := LRect.Left + cSpacing;
    LRect.Right := LRect.Right - cSpacing;

    LRect.Bottom := LRect.Top;
    DrawText(Canvas.Handle, FTitle, -1, LRect, DT_LEFT or DT_WORDBREAK or DT_CALCRECT);
    LTitleHeight := LRect.Bottom - LRect.Top;
    DrawText(Canvas.Handle, FTitle, -1, LRect, DT_LEFT or DT_WORDBREAK);
    Result := cSpacing + LTitleHeight + cScreenTipHeaderSpacing;
  end
  else
    Result := cSpacing;
end;

function TScreenTipsWindow.HasDisabledText: Boolean;
begin
  Result := Trim(FActiveItem.DisabledDescription.Text) <> '';
end;

procedure TScreenTipsWindow.HideHint;
begin
  FVisibleTimer.Enabled := False;
  FActiveItem := nil;
  if HandleAllocated then
    ShowWindow(Handle, SW_HIDE);
end;

procedure TScreenTipsWindow.Paint;
var
  LRect: TRect;
  LTextHeight: Integer;
  LLeftPos: Integer; // left position. can be different if image is being shown
  LRightPos: Integer;
  LY: Integer; // position from the top that the next line will be drawn at
  LShowImage: Boolean;
begin
  inherited;
  // draw background
  LRect := ClientRect;
  DrawBackground(LRect);
  Canvas.Brush.Style := bsClear;
  // Draw header
  LY := DrawHeader;
  // Draw image if one is available. Images are only displayed for Enabled
  // items and the Items ShowImage property must also be True
  LShowImage := FActiveItem.ShowImage and (FImage <> nil) and (FImage.Graphic <> nil) and
    (not FImage.Graphic.Empty) and FActiveItem.IsEnabled;
  if LShowImage then
  begin
    FImage.Graphic.Transparent := True;
    Canvas.Draw(cSpacing, LY, FImage.Graphic);
  end;
  Canvas.Font.Color := clWindowText;
  // Check to see if the command is disabled. Disabled commands have an
  // additional message that is drawn in Bold
  if not FActiveItem.IsEnabled and HasDisabledText then
  begin
    LTextHeight := Canvas.TextHeight(FActiveItem.DisabledHeader);
    LRect := ClientRect;
    LRect.Left := cSpacing * 2;
    LRect.Top := LY;
    DrawText(Canvas.Handle, FActiveItem.DisabledHeader, -1, LRect, DT_LEFT);
    Inc(LY, LTextHeight + cSpacing);
  end;
  // Draw body
  LRect := ClientRect;
  Canvas.Font.Style := [];
  LLeftPos := LRect.Left + (2 * cSpacing);
  LRightPos := LRect.Right - (2 * cSpacing);
  if LShowImage then
    Inc(LLeftPos, FImage.Width);
  LRect.Left := LLeftPos;
  LRect.Right := LRightPos;
  LRect.Bottom := LRect.Top;
  DrawText(Canvas.Handle, FBody, -1, LRect, DT_LEFT or DT_WORDBREAK or DT_CALCRECT);
  Inc(LRect.Top, LY);
  Inc(LRect.Bottom, LY);
  DrawText(Canvas.Handle, FBody, -1, LRect, DT_LEFT or DT_WORDBREAK);
  DrawFooter;
  LRect := Rect(0, 0, ClientWidth, ClientHeight);
  // Draw border
  DrawBorder(LRect);
end;

procedure TScreenTipsWindow.SetBody(const Value: string);
begin
  FBody := Value;
end;

procedure TScreenTipsWindow.SetFooter(const Value: string);
begin
  FFooter := Value;
end;

procedure TScreenTipsWindow.SetGradientEndColor(const Value: TColor);
begin
  FGradientEndColor := Value;
end;

procedure TScreenTipsWindow.SetGradientStartColor(const Value: TColor);
begin
  FGradientStartColor := Value;
end;

procedure TScreenTipsWindow.SetHelpBitmap(const Value: TBitmap);
begin
  FHelpBitmap.Assign(Value);
  if Value <> nil then
  begin
    FHelpBitmap.Transparent := True;
    FHelpBitmap.TransparentColor := FHelpBitmap.Canvas.Pixels[0, FHelpBitmap.Height - 1];
  end;
end;

procedure TScreenTipsWindow.SetImage(const Value: TPicture);
begin
  if Value = nil then
  begin
    if FImage <> nil then
      FreeAndNil(FImage);
  end
  else
  begin
    if FImage = nil then
      FImage := TPicture.Create;
    FImage.Assign(Value);
    if FImage.Graphic <> nil then
      FImage.Graphic.Transparent := True;
  end;
end;

procedure TScreenTipsWindow.TimeOutTimerHandler(Sender: TObject);
begin
  FTimeOutTimer.Enabled := False;
  FVisibleTimer.Enabled := False;
  HideHint;
end;

procedure TScreenTipsWindow.VisibleTimerHandler(Sender: TObject);
var
  LPt: TPoint;
  LRect: TRect;
  LEnabled: Boolean;
begin
  FVisibleTimer.Enabled := False;
  LEnabled := True;
  try
    GetCursorPos(LPt);
    LRect := HintControl.BoundsRect;
    if HintControl.Parent <> nil then
      MapWindowPoints(HintControl.Parent.Handle, 0, LRect, 2);
    if not LRect.Contains(LPt) then
    begin
      LRect := Self.BoundsRect;
      if not LRect.Contains(LPt) then
      begin
        LEnabled := False;
        FTimeOutTimer.Enabled := False;
        HideHint;
      end;
    end;
  finally
    FVisibleTimer.Enabled := LEnabled;
  end;
end;

procedure TScreenTipsWindow.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

{ TDisplayOffset }

constructor TDisplayOffset.Create;
begin
  inherited;
  FX := 0;
  FY := 5;
end;

end.
