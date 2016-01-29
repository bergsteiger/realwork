{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.RibbonStyleActnCtrls;

interface

uses
  Vcl.XPStyleActnCtrls, Vcl.ActnMan, Vcl.ActnMenus, Vcl.ActnCtrls, Winapi.Windows, Vcl.Graphics;

{$IF NOT DEFINED(CLR)}
  {$DEFINE USE_ZLIB}
{$ENDIF}

type
  // The available elements of the Ribbon that need to be skinned
  TRibbonElement = (reRibbon, reForm, reApplicationMenu, reTab, reGroup, reMenu,
    reButton, reCombo, reSpinner, reGallery, reQuickAccessToolbar, reScrollBar,
    reStatusBar, reCheckBox, reRadioButton);

  // The individual skinned items of the Ribbon.
  // Grouped by the element that they below to.
  TSkinRibbon = (srBackground, srBackgroundDisabled, srHeader, srBody,
    srPage, srHelp);
  TSkinForm = (sfLeftFrame, sfLeftFrameDisabled, sfLeftFrameTop,
    sfLeftFrameTopDisabled, sfRightFrame, sfRightFrameDisabled, sfRightFrameTop,
    sfRightFrameTopDisabled, sfBottomFrame, sfBottomFrameDisabled, sfButton,
    sfButtonHover, sfButtonPressed, sfNone, sfMinimize, sfMinimizeHover,
    sfMinimizePressed, sfMinimizeDisabled, sfMaximize, sfMaximizeHover,
    sfMaximizePressed, sfMaximizeDisabled, sfRestore, sfRestoreHover,
    sfRestorePressed, sfRestoreDisabled, sfClose, sfCloseHover, sfClosePressed,
    sfCloseDisabled, sfHelp, sfHelpHover, sfHelpPressed, sfHelpDisabled);
  TSkinApplicationMenu = (samButton, samButtonHover, samButtonPressed,
    samButtonShadow, samBorder, samMenuNormal, samMenuDisabled, samMenuHover,
    samMenuPressed, samMenuSplitNormal, samMenuSplitHover, samMenuSplitPressed,
    samMenuSubMenu);
  TSkinTab = (stBackground, stNormal, stHover, stHoverUnselected,
    stHoverSelected, stKeyTipsActive, stScrollLeft, stScrollLeftHover,
    stScrollLeftPressed, stScrollRight, stScrollRightHover, stScrollRightPressed,
    stSeparator, stScrollGroupLeft, stScrollGroupLeftHover, stScrollGroupRight,
    stScrollGroupRightHover);
  TSkinRibbonGroup = (srgBackground, srgBackgroundHover,
    srgBackgroundDisabled, srgCaption, srgCaptionHover, srgCaptionDisabled,
    srgDialogButton, srgDialogButtonHover, srgDialogButtonPressed,
    srgDialogButtonIcon, srgDialogButtonIconHover, srgDialogButtonIconPressed,
    srgMinimizeButton, srgMinimizeButtonHover, srgMinimizeButtonPressed,
    srgMinimizeButtonIcon, srgMinimizeButtonPressedIcon);
  TSkinMenu = (smBackground, smBanner, smNormal, smSelected,
    smHover, smDisabled, smCheck, smCheckDisabled, smCheckIcon,
    smCheckDisabledIcon, smRadio, smRadioDisabled, smSeparator, smArrowLeftIcon,
    smArrowLeftDisabledIcon, smArrowRightIcon, smArrowRightDisabledIcon, smResize,
    smResizeVertical, smResizeBoth, smRichContentHover, smRichContentDisabled,
    smScrollButton, smScrollButtonHover, smScrollButtonUpIcon,
    smScrollButtonDownIcon, smOptionButton, smOptionButtonHover,
    smOptionButtonDisabled);
  TSkinButton = (sbSmall, sbSmallDisabled, sbSmallHover, sbSmallPressed,
    sbSmallSelected, sbSmallHoverSelected, sbSmallInactive,
    sbLarge, sbLargeDisabled, sbLargeSplitActive,
    sbLargeHover, sbLargePressed, sbLargeSelected, sbLargeHoverSelected,
    sbSmallSplit, sbSmallSplitDisabled, sbSmallSplitHover, sbSmallSplitPressed,
    sbSmallSplitSelected, sbSmallSplitHoverSelected, sbSmallSplitInactive,
    sbSmallSplitHoverSplit, sbSmallSplitPressedSplit, sbSmallSplitInactiveSplit, sbLargeSplit, sbLargeSplitDisabled,
    sbLargeSplitHover, sbLargeSplitPressed, sbLargeSplitSelected,
    sbLargeSplitHoverSelected, sbLargeSplitHoverSplit, sbLargeSplitPressedSplit,
    sbArrow, sbArrowDisabled, sbArrowPressed, sbLargeArrowDown,
    sbLargeArrowDownDisabled, sbSeparator, sbDisabledSeparator, sbGroup,
    sbGroupStart, sbGroupStartHover,sbGroupStartPressed, sbGroupStartSelected,
    sbGroupStartHoverSelected, sbGroupStartInactive,
    sbGroupMiddle, sbGroupMiddleHover, sbGroupMiddlePressed, sbGroupMiddleSelected,
    sbGroupMiddleHoverSelected, sbGroupMiddleInactive, sbGroupEndSplitInactive,
    sbGroupStartSplitInactive, sbGroupSingleSplitInactive, sbGroupMiddleSplitInactive,
    sbGroupEnd, sbGroupEndHover, sbGroupEndPressed, sbGroupEndSelected,
    sbGroupEndHoverSelected, sbGroupEndInactive,
    sbGroupSingle, sbGroupSingleHover, sbGroupSinglePressed, sbGroupSingleSelected,
    sbGroupSingleHoverSelected, sbGroupSingleInactive, sbGroupSplit, sbGroupStartSplitHover,
    sbGroupMiddleSplitHover, sbGroupEndSplitHover, sbGroupSingleSplitHover,
    sbGroupStartInactiveSplit, sbGroupEndSplitInactiveSplit, sbGroupStartSplitHoverSplit,
    sbGroupEndSplitHoverSplit, sbGroupSingleSplitHoverSplit, sbGroupSingleSplitInactiveSplit,
    sbGroupMiddleSplitPressed, sbGroupMiddleSplitInactiveSplit, sbGroupMiddleSplitHoverSplit,
    sbGroupStartSplitInactiveSplit, sbGroupStartSplitPressed, sbGroupEndSplitPressed,
    sbGroupSingleSplitPressed, sbGroupStartSplitPressedSplit, sbGroupMiddleSplitPressedSplit,
    sbGroupEndSplitPressedSplit, sbGroupSingleSplitPressedSplit);
  TSkinComboBox = (scButton, scButtonInactive, scButtonHover, scButtonPressed,
    scButtonIcon);
  TSkinSpinEdit = (ssButton, ssButtonDisabled, ssButtonHover, ssButtonInactive,
    ssButtonPressed, ssButtonUp, ssButtonDown, ssButtonUpIcon, ssButtonDownIcon);
  TSkinGallery = (sgButton, sgUpButton, sgUpButtonHover, sgUpButtonPressed,
    sgUpButtonDisabled, sgDownButton, sgDownButtonHover, sgDownButtonPressed,
    sgDownButtonDisabled, sgMoreButton, sgMoreButtonHover, sgMoreButtonHoverDisabled,
    sgItemHover, sgItemPressed, sgItemSelected, sgItemHoverSelected);
  TSkinQuickAccessToolbar = (sqBackground, sqStart, sqStartRTL, sqMiddle, sqEnd,
    sqEndRTL, sqButton, sqButtonHover, sqButtonPressed, sqButtonCustomizeIcon,
    sqButtonMoreIcon, sqGroup, sqGroupHover, sqGroupPressed);
  TSkinScrollBar = (ssbBar, ssbBarHover, ssbBarPressed, ssbBarIcon, ssbButton,
    ssbButtonActive, ssbButtonDisabled, ssbButtonHover, ssbButtonPressed,
    ssbButtonUpIcon, ssbButtonDownIcon);
  TSkinStatusBar = (ssbrBackground, ssbrNotification, ssbrControl, ssbrGripper);
  TSkinCheckBox = (scNormal, scDisabled, scHover, scPressed, scSelected,
    scHoverSelected, scDisabledSelected);
  TSkinRadioButton = (sbNormal, sbDisabled, sbHover, sbPressed, sbSelected,
    sbHoverSelected, sbDisabledSelected);

  // TBitmap descendant that automatically sets the AlphaFormat property to afDefined
  //
  // TAlphaBitmap is used by the ribbon skinning engine. Ribbon Skins are 32 bit
  // bitmaps that include an Alpha Channel.
  TAlphaBitmap = class(TBitmap)
  public
    constructor Create; override;
  end;

  // Class is responsible for loading the resources from file or application.
  // Also loads the common elements amongst each skin. Each descendant will then
  // modify what resource or file is to be loaded.
  TCustomRibbonSkin = class
  public
    type
      // ltResource - skins are loaded as a resource
      // ltFile - skins are loaded from a single file
      TRibbonSkinLoadType = (ltResource, ltFile);
  private
    FBitmap: TAlphaBitmap;
  protected
    procedure DoLoadByResource; virtual;
    procedure DoLoadByFile; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    // Sets the method for loading the skins for use by the application
    function GetLoadType: TRibbonSkinLoadType; virtual;
    // Override GetResourceHandle to supply skins in a separate DLL file
    function GetResourceHandle: THandle; virtual;
    function GetLoadTypeValue: string; virtual;
    procedure LoadSkin; virtual;
    property Bitmap: TAlphaBitmap read FBitmap;
  end;

  TCustomRibbonSkinClass = class of TCustomRibbonSkin;

  TRibbonStyleActionBars = class(TXPStyleActionBars)
  private
    FRibbonSkin: TCustomRibbonSkin;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function GetControlClass(ActionBar: TCustomActionBar; AnItem: TActionClientItem): TCustomActionControlClass; override;
    function GetPopupClass(ActionBar: TCustomActionBar): TCustomPopupClass; override;
    function GetColorMapClass(ActionBar: TCustomActionBar): TCustomColorMapClass; override;
    function GetAddRemoveItemClass(ActionBar: TCustomActionBar): TCustomAddRemoveItemClass; override;
    function GetScrollBtnClass: TCustomToolScrollBtnClass; override;
    function GetSkinClass: TCustomRibbonSkinClass; virtual; abstract;
    // Methods to draw a particular ribbon skin element
    // Element - The item to draw from the Element group
    // Canvas - Where the element is to be drawn
    // Rect - The rect for drawing the element
    // Center - Set to True to center the element within the given Rect
    procedure DrawElement(Element: TSkinRibbon; Canvas: TCanvas; Rect: TRect; Height: Integer); overload;
    procedure DrawElement(Element: TSkinForm; Canvas: TCanvas; Rect: TRect; Height: Integer); overload;
    procedure DrawElement(Element: TSkinApplicationMenu; Canvas: TCanvas; Rect: TRect); overload;
    procedure DrawElement(Element: TSkinApplicationMenu; Canvas: TCanvas; const X, Y: Integer; const Opacity: Byte); overload;
    procedure DrawElement(Element: TSkinTab; Canvas: TCanvas; Rect: TRect; Opacity: Byte = 255); overload;
    procedure DrawElement(Element: TSkinRibbonGroup; Canvas: TCanvas; Rect: TRect); overload;
    procedure DrawElement(Element: TSkinMenu; Canvas: TCanvas; Rect: TRect); overload;
    procedure DrawElement(Element: TSkinButton; Canvas: TCanvas; Rect: TRect; Opacity: Byte = 255); overload;
    procedure DrawElement(Element: TSkinComboBox; Canvas: TCanvas; Rect: TRect); overload;
    procedure DrawElement(Element: TSkinSpinEdit; Canvas: TCanvas; Rect: TRect); overload;
    procedure DrawElement(Element: TSkinGallery; Canvas: TCanvas; Rect: TRect); overload;
    procedure DrawElement(Element: TSkinQuickAccessToolbar; Canvas: TCanvas; Rect: TRect); overload;
    procedure DrawElement(Element: TSkinScrollBar; Canvas: TCanvas; Rect: TRect); overload;
    procedure DrawElement(Element: TSkinStatusBar; Canvas: TCanvas; Rect: TRect); overload;
    procedure DrawElement(Element: TSkinCheckBox; Canvas: TCanvas; Rect: TRect); overload;
    procedure DrawElement(Element: TSkinRadioButton; Canvas: TCanvas; Rect: TRect); overload;
    property RibbonSkin: TCustomRibbonSkin read FRibbonSkin;
  end;

implementation

uses
  Vcl.RibbonActnCtrls, Vcl.RibbonGalleryBar, Vcl.Ribbon, System.SysUtils,{$IFDEF USE_ZLIB} System.ZLib,{$ENDIF} Vcl.RibbonActnMenus,
  Vcl.ListActns, System.Contnrs, System.Classes, System.Types, Vcl.GraphUtil;

procedure DrawTransparentBitmap(Source: TBitmap; Destination: TCanvas;
  DestRect: TRect); overload;
begin
  DrawTransparentBitmap(Source, Destination, DestRect, 255);
end;

procedure DrawTransparentBitmap(Source: TBitmap; SourceRect: TRect;
  Destination: TCanvas; DestRect: TRect); overload;
begin
  DrawTransparentBitmap(Source, SourceRect, Destination, DestRect, 255);
end;

procedure DrawTransparentBitmap(Source: TBitmap; Destination: TCanvas;
  const X, Y: Integer; const Opacity: Byte); overload;
var
  BlendFunc: TBlendFunction;
begin
  BlendFunc.BlendOp := AC_SRC_OVER;
  BlendFunc.BlendFlags := 0;
  BlendFunc.SourceConstantAlpha := Opacity;

  if Source.PixelFormat = pf32bit then
    BlendFunc.AlphaFormat := AC_SRC_ALPHA
  else
    BlendFunc.AlphaFormat := 0;

  Winapi.Windows.AlphaBlend(Destination.Handle, X, Y, Source.Width, Source.Height,
    Source.Canvas.Handle, 0, 0, Source.Width, Source.Height, BlendFunc);
end;

procedure DrawButton(Bitmap: TBitmap; SourceRect: TRect; Canvas: TCanvas;
  Rect: TRect; BorderX, BorderY: Integer; Opacity: Byte = 255); overload;
var
  LLeft, LRight, LTop, LCenter: TRect;
  LSrcRect, LDstRect: TRect;
  LHeight, LWidth: Integer;
  LTopPos, LLeftPos: Integer;
begin

  LWidth := SourceRect.Right - SourceRect.Left;
  LHeight := SourceRect.Bottom - SourceRect.Top;
  LLeftPos := SourceRect.Left;
  LTopPos := SourceRect.Top;

  if Rect.Bottom - Rect.Top = LHeight then
  begin
    // Rendered image will be the same height as the source image
    // Left side
    LSrcRect := System.Types.Rect(LLeftPos, LTopPos, LLeftPos + BorderX, LTopPos + LHeight);
    LDstRect := System.Types.Rect(Rect.Left, Rect.Top, Rect.Left + BorderX, Rect.Bottom);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LDstRect, Opacity);
    // Right side
    LSrcRect := System.Types.Rect(LLeftPos + LWidth - BorderX, LTopPos, LLeftPos + LWidth, LTopPos + LHeight);
    LDstRect := System.Types.Rect(Rect.Right - BorderX, Rect.Top, Rect.Right, Rect.Bottom);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LDstRect, Opacity);
    // Center
    LSrcRect := System.Types.Rect(LLeftPos + BorderX, LTopPos, LLeftPos + LWidth - BorderX, LTopPos + LHeight);
    LDstRect := System.Types.Rect(Rect.Left + BorderX, Rect.Top, Rect.Right - BorderX, Rect.Bottom);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LDstRect, Opacity);
  end
  else
  begin
    // Rendered image will have a different height than the source image
    // Left side
    LLeft := System.Types.Rect(Rect.Left, Rect.Top, Rect.Left + BorderX, Rect.Bottom);
    LSrcRect := System.Types.Rect(LLeftPos, LTopPos, LLeftPos + BorderX, LTopPos + LHeight);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LLeft, Opacity);
    // Right side
    LRight := System.Types.Rect(Rect.Right - BorderX, Rect.Top, Rect.Right, Rect.Bottom);
    LSrcRect := System.Types.Rect(LLeftPos + LWidth - BorderX, LTopPos, LLeftPos + LWidth, LTopPos + LHeight);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LRight, Opacity);
    // Top side
    LTop := System.Types.Rect(Rect.Left + BorderX, Rect.Top, Rect.Right - BorderX, Rect.Top + BorderY);
    LSrcRect := System.Types.Rect(LLeftPos + BorderX, LTopPos, LLeftPos + LWidth - BorderX, LTopPos + BorderY);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LTop, Opacity);
    // Bottom side
    LTop := System.Types.Rect(Rect.Left + BorderX, Rect.Bottom - BorderY, Rect.Right - BorderX, Rect.Bottom);
    LSrcRect := System.Types.Rect(LLeftPos + BorderX, LTopPos + LHeight - BorderY, LLeftPos + LWidth - BorderX, LTopPos + LHeight);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LTop, Opacity);
    // Center
    LCenter := Rect;
    InflateRect(LCenter, -BorderX, -BorderY);
    LSrcRect := System.Types.Rect(LLeftPos + BorderX, LTopPos + BorderY, LLeftPos + LWidth - BorderX, LTopPos + LHeight - BorderY);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LCenter, Opacity);
  end;
end;

procedure DrawButton(Bitmap: TBitmap; Canvas: TCanvas; Rect: TRect; BorderX,
  BorderY: Integer; Opacity: Byte = 255); overload;
var
  LLeft, LRight, LTop, LCenter: TRect;
  LSrcRect, LDstRect: TRect;
begin
  if Rect.Bottom - Rect.Top = Bitmap.Height then
  begin
    // Rendered image will be the same height as the source image
    // Left side
    LSrcRect := System.Types.Rect(0, 0, BorderX, Bitmap.Height);
    LDstRect := System.Types.Rect(Rect.Left, Rect.Top, Rect.Left + BorderX, Rect.Bottom);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LDstRect, Opacity);
    // Right side
    LSrcRect := System.Types.Rect(Bitmap.Width - BorderX, 0, Bitmap.Width, Bitmap.Height);
    LDstRect := System.Types.Rect(Rect.Right - BorderX, Rect.Top, Rect.Right, Rect.Bottom);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LDstRect, Opacity);
    // Center
    LSrcRect := System.Types.Rect(BorderX, 0, Bitmap.Width - BorderX, Bitmap.Height);
    LDstRect := System.Types.Rect(Rect.Left + BorderX, Rect.Top, Rect.Right - BorderX, Rect.Bottom);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LDstRect, Opacity);
  end
  else
  begin
    // Rendered image will have a different height than the source image
    // Left side
    LLeft := System.Types.Rect(Rect.Left, Rect.Top, Rect.Left + BorderX, Rect.Bottom);
    LSrcRect := System.Types.Rect(0, 0, BorderX, Bitmap.Height);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LLeft, Opacity);
    // Right side
    LRight := System.Types.Rect(Rect.Right - BorderX, Rect.Top, Rect.Right, Rect.Bottom);
    LSrcRect := System.Types.Rect(Bitmap.Width - BorderX, Rect.Top, Bitmap.Width, Bitmap.Height);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LRight, Opacity);
    // Top side
    LTop := System.Types.Rect(BorderX, Rect.Top, Rect.Right - BorderX, BorderY);
    LSrcRect := System.Types.Rect(BorderX, Rect.Top, Bitmap.Width - BorderX, BorderY);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LTop, Opacity);
    // Bottom side
    LTop := System.Types.Rect(BorderX, Rect.Bottom - BorderY, Rect.Right - BorderX, Rect.Bottom);
    LSrcRect := System.Types.Rect(BorderX, Bitmap.Height - BorderY, Bitmap.Width - BorderX, Bitmap.Height);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LTop, Opacity);
    // Center
    LCenter := Rect;
    InflateRect(LCenter, -BorderX, -BorderY);
    LSrcRect := System.Types.Rect(BorderX, BorderY, Bitmap.Width - BorderX, Bitmap.Height - BorderY);
    DrawTransparentBitmap(Bitmap, LSrcRect, Canvas, LCenter, Opacity);
  end;
end;

procedure DrawButton(Bitmap: TBitmap; Canvas: TCanvas; Rect: TRect; Border: Integer; Opacity: Byte = 255); overload;
begin
  DrawButton(Bitmap, Canvas, Rect, Border, Border, Opacity);
end;

procedure DrawButton(Bitmap: TBitmap; Canvas: TCanvas; Rect: TRect; Opacity: Byte = 255); overload;
begin
  DrawButton(Bitmap, Canvas, Rect, 2, 2, Opacity);
end;

{ TAlphaBitmap }

constructor TAlphaBitmap.Create;
begin
  inherited;
  AlphaFormat := afDefined;
end;

{ TRibbonStyleActionBars }

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinRibbonGroup;
  Canvas: TCanvas; Rect: TRect);
var
  LSrcRect: TRect;
  LDstRect: TRect;
begin
  if Element = srgBackground then
  begin
    LSrcRect := System.Types.Rect(225, 504, 225 + 20, 504 + 86);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 3, 3, 255);
  end
  else if Element = srgBackgroundHover then
  begin
    LSrcRect := System.Types.Rect(204, 504, 204 + 20, 504 + 86);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 3, 3, 255);
  end
  else if Element = srgBackgroundDisabled then
  begin
    LSrcRect := System.Types.Rect(246, 504, 246 + 20, 504 + 86);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 3, 3, 255);
  end
  else if Element = srgMinimizeButton then
  begin
    LSrcRect := System.Types.Rect(275, 208, 275 + 40, 208 + 86);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 3, 3, 255);
  end
  else if Element = srgMinimizeButtonHover then
  begin
    LSrcRect := System.Types.Rect(315, 208, 315 + 40, 208 + 85);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 3, 3, 255);
  end
  else if Element = srgMinimizeButtonPressed then
  begin
    LSrcRect := System.Types.Rect(355, 208, 355 + 40, 208 + 85);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 3, 3, 255);
  end
  else if Element in [srgCaption, srgCaptionHover, srgCaptionDisabled] then
  begin
    if Element = srgCaptionHover then
      LSrcRect := System.Types.Rect(206, 573, 206 + 16, 573 + 11)
    else if Element = srgCaptionDisabled then
      LSrcRect := System.Types.Rect(248, 573, 248 + 16, 573 + 12)
    else
      LSrcRect := System.Types.Rect(227, 573, 227 + 16, 573 + 12);
    Rect.Bottom := Rect.Bottom - 4;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
  end
  else if Element = srgDialogButton then
  begin
    LSrcRect := System.Types.Rect(329, 167, 329 + 15, 167 + 14);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
  end
  else if Element = srgDialogButtonHover then
  begin
    LSrcRect := System.Types.Rect(344, 167, 344 + 15, 167 + 14);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
  end
  else if Element = srgDialogButtonPressed then
  begin
    LSrcRect := System.Types.Rect(359, 167, 359 + 15, 167 + 14);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
  end
  else if Element = srgMinimizeButtonIcon then
  begin
    LSrcRect := System.Types.Rect(396, 208, 396 + 31, 208 + 31);
    LDstRect := Rect;
    LDstRect.Right := LDstRect.Left + 31;
    LDstRect.Bottom := LDstRect.Top + 31;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  end
  else if Element = srgMinimizeButtonPressedIcon then
  begin
    LSrcRect := System.Types.Rect(396, 240, 396 + 31, 240 + 31);
    LDstRect := Rect;
    LDstRect.Right := LDstRect.Left + 31;
    LDstRect.Bottom := LDstRect.Top + 31;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  end
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinTab; Canvas: TCanvas;
  Rect: TRect; Opacity: Byte = 255);
var
  LRect: TRect;
  LSegment: TRect;
  LSrcRect: TRect;
  LDstRect: TRect;

  procedure DrawTab(ElementStart, ElementMiddle, ElementEnd: TRect);
  var
    LDstRect: TRect;
    LSrcRect: TRect;
  begin
    Dec(LRect.Left, 2);
    Inc(LRect.Right, 2);
    LSegment := LRect;
    LDstRect := LRect;

    LDstRect.Right := LDstRect.Left + 6;
    LDstRect.Bottom := LDstRect.Top + 4;
    LSrcRect := ElementStart;
    LSrcRect.Bottom := LSrcRect.Top + 4;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);

    LDstRect.Top := Rect.Bottom - 4;
    LDstRect.Bottom := Rect.Bottom;
    LSrcRect := ElementStart;
    LSrcRect.Top := LSrcRect.Bottom - 4;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);

    LDstRect.Top := Rect.Top + 4;
    LDstRect.Bottom := Rect.Bottom - 4;
    LSrcRect := ElementStart;
    LSrcRect.Top := LSrcRect.Top + 4;
    LSrcRect.Bottom := LSrcRect.Bottom - 4;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);

    LSegment.Left := LSegment.Left + 5;
    LSegment.Right := LSegment.Left + LRect.Right - LRect.Left - 10;
    DrawTransparentBitmap(RibbonSkin.Bitmap, ElementMiddle, Canvas, LSegment);

    LSegment.Left := LSegment.Right;
    LSegment.Right := LSegment.Left + 6;
    LSegment.Top := LRect.Top;
    LSegment.Bottom := LSegment.Top + 4;
    LSrcRect := ElementEnd;
    LSrcRect.Bottom := LSrcRect.Top + 4;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LSegment);

    LSegment.Top := LRect.Bottom - 4;
    LSegment.Bottom := LRect.Bottom;
    LSrcRect := ElementEnd;
    LSrcRect.Top := LSrcRect.Bottom - 4;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LSegment);

    LSegment.Top := LRect.Top + 4;
    LSegment.Bottom := LRect.Bottom - 4;
    LSrcRect := ElementEnd;
    LSrcRect.Top := LSrcRect.Top + 4;
    LSrcRect.Bottom := LSrcRect.Bottom - 4;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LSegment);
  end;

begin
  LRect := Rect;
  if Element = stHover then
  begin
    DrawTab(System.Types.Rect(275, 344, 275+6, 344+23),
      System.Types.Rect(282, 344, 282 + 86, 344 + 23),
      System.Types.Rect(369, 344, 369+6, 344+23));
  end
  else if ELement = stNormal then
  begin
    DrawTab(System.Types.Rect(275, 294, 275+6, 294+23),
      System.Types.Rect(282, 294, 282 + 86, 294 + 23),
      System.Types.Rect(369, 294, 369+6, 294+23));
  end
  else if Element = stKeyTipsActive then
  begin
    DrawTab(System.Types.Rect(275, 369, 275+6, 369+23),
      System.Types.Rect(282, 369, 282 + 86, 369 + 23),
      System.Types.Rect(369, 369, 369+6, 369+23));
  end
  else if Element = stHoverUnselected then
  begin
    DrawTab(System.Types.Rect(275, 319, 275+6, 319+22),
      System.Types.Rect(282, 319, 282 + 86, 319 + 22),
      System.Types.Rect(369, 319, 369+6, 319+22));
  end
  else
  begin
    case Element of
      stBackground:
        begin
          LSrcRect := System.Types.Rect(276, 395, 276 + 24, 395 + 24);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      stSeparator:
        begin
          LSrcRect := System.Types.Rect(301, 395, 301 + 1, 395 + 23);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, Opacity);
        end;
      stScrollLeft:
        begin
          LSrcRect := System.Types.Rect(276, 185, 276 + 12, 185 + 22);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      stScrollLeftHover:
        begin
          LSrcRect := System.Types.Rect(290, 185, 290 + 12, 185 + 22);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      stScrollLeftPressed:
        begin
          LSrcRect := System.Types.Rect(304, 185, 304 + 12, 185 + 22);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      stScrollRight:
        begin
          LSrcRect := System.Types.Rect(317, 185, 317 + 12, 185 + 22);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      stScrollRightHover:
        begin
          LSrcRect := System.Types.Rect(331, 185, 331 + 12, 185 + 22);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      stScrollRightPressed:
        begin
          LSrcRect := System.Types.Rect(345, 185, 345 + 12, 185 + 22);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      stScrollGroupLeft:
        begin
          LSrcRect := System.Types.Rect(292, 0, 292 + 12, 0 + 91);
          LDstRect := Rect;
          LDstRect.Right := LDstRect.Left + 12;
          LDstRect.Bottom := LDstRect.Top + 91;
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
          LSrcRect := System.Types.Rect(104, 192, 104 + 3, 192 + 5);
          LDstRect.Left := ((LDstRect.Right - LDstRect.Left) div 2) - 3 div 2;
          LDstRect.Right := LDstRect.Left + 3;
          LDstRect.Top := ((LDstRect.Bottom - LDstRect.Top) div 2) - 5 div 2;
          LDstRect.Bottom := LDstRect.Top + 5;
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
        end;
      stScrollGroupLeftHover:
        begin
          LSrcRect := System.Types.Rect(304, 0, 304 + 12, 0 + 91);
          LDstRect := Rect;
          LDstRect.Right := LDstRect.Left + 12;
          LDstRect.Bottom := LDstRect.Top + 91;
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
          LSrcRect := System.Types.Rect(104, 192, 104 + 3, 192 + 5);
          LDstRect.Left := ((LDstRect.Right - LDstRect.Left) div 2) - 3 div 2;
          LDstRect.Right := LDstRect.Left + 3;
          LDstRect.Top := ((LDstRect.Bottom - LDstRect.Top) div 2) - 5 div 2;
          LDstRect.Bottom := LDstRect.Top + 5;
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
        end;
      stScrollGroupRight:
        begin
          LSrcRect := System.Types.Rect(292, 92, 292 + 12, 92 + 91);
          LDstRect := Rect;
          LDstRect.Right := LDstRect.Left + 12;
          LDstRect.Bottom := LDstRect.Top + 91;
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
          LSrcRect := System.Types.Rect(108, 192, 108 + 3, 192 + 5);
          LDstRect.Left := ((LDstRect.Right - LDstRect.Left) div 2) - 3 div 2;
          LDstRect.Right := LDstRect.Left + 3;
          LDstRect.Top := ((LDstRect.Bottom - LDstRect.Top) div 2) - 5 div 2;
          LDstRect.Bottom := LDstRect.Top + 5;
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
        end;
      stScrollGroupRightHover:
        begin
          LSrcRect := System.Types.Rect(304, 92, 304 + 12, 92 + 91);
          LDstRect := Rect;
          LDstRect.Right := LDstRect.Left + 12;
          LDstRect.Bottom := LDstRect.Top + 91;
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
          LSrcRect := System.Types.Rect(108, 192, 108 + 3, 192 + 5);
          LDstRect.Left := ((LDstRect.Right - LDstRect.Left) div 2) - 3 div 2;
          LDstRect.Right := LDstRect.Left + 3;
          LDstRect.Top := ((LDstRect.Bottom - LDstRect.Top) div 2) - 5 div 2;
          LDstRect.Bottom := LDstRect.Top + 5;
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
        end;
    end;
  end;
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinButton;
  Canvas: TCanvas; Rect: TRect; Opacity: Byte = 255);
var
  LSrcRect: TRect;
  LDstRect: TRect;
  LOffSet: Integer;
  LBitmap: TAlphaBitmap;
begin
  if Element in [sbLarge, sbLargeHover, sbLargePressed, sbLargeSelected, sbLargeHoverSelected] then
  begin
    LOffSet := 66;
    if Element = sbLargeHover then
      LSrcRect := System.Types.Rect(151, 207, 151 + 50, 207 + LOffset)
    else if Element = sbLargePressed then
      LSrcRect := System.Types.Rect(101, 207 + LOffset, 101 + 50, 207 + (2 * LOffset))
    else if Element = sbLargeSelected then
      LSrcRect := System.Types.Rect(151, 207 + LOffSet, 151 + 50, 207 + (2 * LOffSet))
    else if Element = sbLargeHoverSelected then
      LSrcRect := System.Types.Rect(101, 207 + (2 * LOffSet), 101 + 50, 207 + (3 * LOffSet));
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbSmall, sbSmallHover, sbSmallPressed, sbSmallSelected,
    sbSmallHoverSelected, sbSmallInactive] then
  begin
    LOffSet := 22;
    if Element = sbSmallHover then
      LSrcRect := System.Types.Rect(99, LOffSet, 99 + 100, 2 * LOffSet)
    else if Element = sbSmallPressed then
      LSrcRect := System.Types.Rect(99, 2 * LOffSet, 99 + 100, 3 * LOffSet)
    else if Element = sbSmallSelected then
      LSrcRect := System.Types.Rect(99, 3 * LOffSet, 99 + 100, 4 * LOffSet)
    else if Element = sbSmallHoverSelected then
      LSrcRect := System.Types.Rect(99, 4 * LOffSet, 99 + 100, 5 * LOffSet)
    else if Element = sbSmallInactive then
      LSrcRect := System.Types.Rect(99, 5 * LOffSet, 99 + 100, 6 * LOffSet);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element = sbSmallSplit then
  begin
    LSrcRect := System.Types.Rect(200, 111, 200 + 2, 110 + 20);
    LDstRect := Rect;
    LDstRect.Right := LDstRect.Left + 2;
    Inc(LDstRect.Top);
    Dec(LDstRect.Bottom);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  end
  else if Element = sbLargeSplit then
  begin
    LSrcRect := System.Types.Rect(101, 204, 101 + 50, 204 + 2);
    LDstRect := Rect;
    LDstRect.Bottom := LDstRect.Top + 2;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
    LOffSet := 66;
    LSrcRect := System.Types.Rect(151, 207 + (2 * LOffSet) + Rect.Top + 2, 151 + 50, 207 + (3 * LOffset));
    LDstRect := System.Types.Rect(0, 0, 50, LOffset - (Rect.Top + 2));
    LBitmap := TAlphaBitmap.Create;
    try
      LBitmap.SetSize(50, LOffSet - (Rect.Top + 2));
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, LBitmap.Canvas, LDstRect);
      LSrcRect := Rect;
      Dec(LSrcRect.Left);
      Inc(LSrcRect.Right);
      DrawButton(LBitmap, Canvas, LSrcRect, Opacity);
    finally
      LBitmap.Free;
    end;
  end
  else if Element = sbLargeSplitActive then
  begin
    LOffSet := 66;
    LSrcRect := System.Types.Rect(151, 207 + (2 * LOffSet), 151 + 50, 207 + (3 * LOffset));
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element = sbLargeSplitSelected then
  begin
    LOffSet := 66;
    LSrcRect := System.Types.Rect(151, 207 + LOffSet, 151 + 50, 207 + (2 * LOffSet));
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element = sbLargeSplitHoverSelected then
  begin
    LOffSet := 66;
    LSrcRect := System.Types.Rect(101, 207 + (2 * LOffSet), 101 + 50, 207 + (3 * LOffSet));
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbLargeSplitPressed, sbLargeSplitHover] then
  begin
    LSrcRect := System.Types.Rect(101, 204, 101 + 50, 204 + 2);
    LDstRect := Rect;
    LDstRect.Bottom := LDstRect.Top + 2;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
    LOffSet := 66;
    if Element = sbLargeSplitHover then
      LSrcRect := System.Types.Rect(151, 207 + Rect.Top + 2, 151 + 50, 207 + LOffset)
    else if Element = sbLargeSplitSelected then
      LSrcRect := System.Types.Rect(151, 207 + Rect.Top + 2 + LOffSet, 151 + 50, 207 + (2 * LOffSet))
    else
      LSrcRect := System.Types.Rect(101, 207 + LOffSet + Rect.Top + 2, 101 + 50, 207 + (2 * LOffset));
    LDstRect := System.Types.Rect(0, 0, 50, LOffset - (Rect.Top + 2));
    LBitmap := TAlphaBitmap.Create;
    try
      LBitmap.SetSize(50, LOffSet - (Rect.Top + 2));
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, LBitmap.Canvas, LDstRect);
      LSrcRect := Rect;
      Inc(LSrcRect.Top, 2);
      Dec(LSrcRect.Left);
      Inc(LSrcRect.Right);
      DrawButton(LBitmap, Canvas, LSrcRect, Opacity);
    finally
      LBitmap.Free;
    end;
  end
  else if Element in [sbGroupStart, sbGroupMiddle, sbGroupEnd, sbGroupSingle] then
  begin
    if Element = sbGroupStart then
      LSrcRect := System.Types.Rect(0, 0, 22, 22)
    else if Element = sbGroupMiddle then
      LSrcRect := System.Types.Rect(22, 0, 46, 22)
    else if Element = sbGroupEnd then
      LSrcRect := System.Types.Rect(47, 0, 70, 22)
    else
      LSrcRect := System.Types.Rect(71, 0, 95, 22);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbGroupStartHover, sbGroupMiddleHover, sbGroupEndHover,
    sbGroupSingleHover] then
  begin
    if Element = sbGroupStartHover then
      LSrcRect := System.Types.Rect(0, 22, 22, 44)
    else if Element = sbGroupMiddleHover then
      LSrcRect := System.Types.Rect(22, 22, 46, 44)
    else if Element = sbGroupEndHover then
      LSrcRect := System.Types.Rect(47, 22, 70, 44)
    else
      LSrcRect := System.Types.Rect(71, 22, 95, 44);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbGroupStartPressed, sbGroupMiddlePressed,
    sbGroupEndPressed, sbGroupSinglePressed] then
  begin
    if Element = sbGroupStartPressed then
      LSrcRect := System.Types.Rect(0, 44, 22, 66)
    else if Element = sbGroupMiddlePressed then
      LSrcRect := System.Types.Rect(22, 44, 46, 66)
    else if Element = sbGroupEndPressed then
      LSrcRect := System.Types.Rect(47, 44, 70, 66)
    else
      LSrcRect := System.Types.Rect(71, 44, 95, 66);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbGroupStartSelected, sbGroupMiddleSelected,
    sbGroupEndSelected, sbGroupSingleSelected] then
  begin
    if Element = sbGroupStartSelected then
      LSrcRect := System.Types.Rect(0, 66, 22, 88)
    else if Element = sbGroupMiddleSelected then
      LSrcRect := System.Types.Rect(22, 66, 46, 88)
    else if Element = sbGroupEndSelected then
      LSrcRect := System.Types.Rect(47, 66, 70, 88)
    else
      LSrcRect := System.Types.Rect(71, 66, 95, 88);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbGroupStartHoverSelected, sbGroupMiddleHoverSelected,
    sbGroupEndHoverSelected, sbGroupSingleHoverSelected] then
  begin
    if Element = sbGroupStartHoverSelected then
      LSrcRect := System.Types.Rect(0, 88, 22, 110)
    else if Element = sbGroupMiddleHoverSelected then
      LSrcRect := System.Types.Rect(22, 88, 46, 110)
    else if Element = sbGroupEndHoverSelected then
      LSrcRect := System.Types.Rect(47, 88, 70, 110)
    else
      LSrcRect := System.Types.Rect(71, 88, 95, 110);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbGroupStartInactive, sbGroupMiddleInactive,
    sbGroupEndInactive, sbGroupSingleInactive] then
  begin
    if Element = sbGroupStartInactive then
      LSrcRect := System.Types.Rect(0, 110, 22, 132)
    else if Element = sbGroupMiddleInactive then
      LSrcRect := System.Types.Rect(22, 110, 46, 132)
    else if Element = sbGroupEndInactive then
      LSrcRect := System.Types.Rect(47, 110, 70, 132)
    else
      LSrcRect := System.Types.Rect(71, 110, 95, 132);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbGroupStartSplitInactive, sbGroupMiddleSplitInactive,
    sbGroupEndSplitInactive, sbGroupSingleSplitInactive] then
  begin
    if Element = sbGroupStartInactive then
      LSrcRect := System.Types.Rect(0, 110, 22 - 2, 132)
    else if Element = sbGroupEndInactive then
      LSrcRect := System.Types.Rect(22, 110, 46 - 2, 132)
    else if Element = sbGroupEndInactive then
      LSrcRect := System.Types.Rect(47, 110, 70 - 2, 132)
    else
      LSrcRect := System.Types.Rect(71, 110, 95 - 2, 132);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbSmallSplitHoverSplit, sbSmallSplitPressedSplit,
    sbSmallSplitInactiveSplit] then
  begin
    LOffSet := 22;
    if Element = sbSmallSplitHoverSplit then
      LSrcRect := System.Types.Rect(99 + 100 - (Rect.Right - Rect.Left), LOffSet, 99 + 100, 2 * LOffSet)
    else if Element = sbSmallSplitPressedSplit then
      LSrcRect := System.Types.Rect(99 + 100 - (Rect.Right - Rect.Left), 2 * LOffSet, 99 + 100, 3 * LOffSet)
    else if Element = sbSmallSplitSelected then
      LSrcRect := System.Types.Rect(99 + 100 - (Rect.Right - Rect.Left), 3 * LOffSet, 99 + 100, 4 * LOffSet)
    else if Element = sbSmallSplitHoverSelected then
      LSrcRect := System.Types.Rect(99 + 100 - (Rect.Right - Rect.Left), 4 * LOffSet, 99 + 100, 5 * LOffSet)
    else if Element = sbSmallSplitInactiveSplit then
      LSrcRect := System.Types.Rect(99 + 100 - (Rect.Right - Rect.Left), 5 * LOffSet, 99 + 100, 6 * LOffSet);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbGroupStartSplitHoverSplit, sbGroupMiddleSplitHoverSplit,
    sbGroupEndSplitHoverSplit, sbGroupSingleSplitHoverSplit] then
  begin
    if Element = sbGroupStartSplitHoverSplit then
      LSrcRect := System.Types.Rect(22 - (Rect.Right - Rect.Left), 22, 22, 44)
    else if Element = sbGroupMiddleSplitHoverSplit then
      LSrcRect := System.Types.Rect(46 - (Rect.Right - Rect.Left), 22, 46, 44)
    else if Element = sbGroupEndSplitHoverSplit then
      LSrcRect := System.Types.Rect(70 - (Rect.Right - Rect.Left), 22, 70, 44)
    else
      LSrcRect := System.Types.Rect(95 - (Rect.Right - Rect.Left), 22, 95, 44);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbGroupStartSplitPressedSplit, sbGroupMiddleSplitPressedSplit,
    sbGroupEndSplitPressedSplit, sbGroupSingleSplitPressedSplit] then
  begin
    if Element = sbGroupStartSplitHoverSplit then
      LSrcRect := System.Types.Rect(22 - (Rect.Right - Rect.Left), 44, 22, 66)
    else if Element = sbGroupMiddleSplitHoverSplit then
      LSrcRect := System.Types.Rect(46 - (Rect.Right - Rect.Left), 44, 46, 66)
    else if Element = sbGroupEndSplitHoverSplit then
      LSrcRect := System.Types.Rect(70 - (Rect.Right - Rect.Left), 44, 70, 66)
    else
      LSrcRect := System.Types.Rect(95 - (Rect.Right - Rect.Left), 44, 95, 66);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbGroupStartSplitHover, sbGroupMiddleSplitHover,
    sbGroupEndSplitHover, sbGroupSingleSplitHover] then
  begin
    if Element = sbGroupStartSplitHover then
      LSrcRect := System.Types.Rect(0, 22, 22 - 2, 44)
    else if Element = sbGroupMiddleSplitHover then
      LSrcRect := System.Types.Rect(22, 22, 46 - 2, 44)
    else if Element = sbGroupEndSplitHover then
      LSrcRect := System.Types.Rect(46, 22, 70 - 2, 44)
    else
      LSrcRect := System.Types.Rect(71, 22, 95 - 2, 44);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbGroupStartSplitPressed, sbGroupMiddleSplitPressed,
    sbGroupEndSplitPressed, sbGroupSingleSplitPressed] then
  begin
    if Element = sbGroupStartSplitPressed then
      LSrcRect := System.Types.Rect(0, 44, 22 - 2, 66)
    else if Element = sbGroupMiddleSplitPressed then
      LSrcRect := System.Types.Rect(22, 44, 46 - 2, 66)
    else if Element = sbGroupEndSplitPressed then
      LSrcRect := System.Types.Rect(47, 44, 70 - 2, 66)
    else
      LSrcRect := System.Types.Rect(71, 44, 95 - 2, 66);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbGroupStartSplitInactiveSplit, sbGroupMiddleSplitInactiveSplit,
    sbGroupEndSplitInactiveSplit, sbGroupSingleSplitInactiveSplit] then
  begin
    if Element = sbGroupStartSplitInactiveSplit then
      LSrcRect := System.Types.Rect(22 - (Rect.Right - Rect.Left), 110, 22, 132)
    else if Element = sbGroupMiddleSplitInactiveSplit then
      LSrcRect := System.Types.Rect(46 - (Rect.Right - Rect.Left), 110, 46, 132)
    else if Element = sbGroupEndSplitInactiveSplit then
      LSrcRect := System.Types.Rect(70 - (Rect.Right - Rect.Left), 110, 70, 132)
    else
      LSrcRect := System.Types.Rect(95 - (Rect.Right - Rect.Left), 110, 95, 132);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [sbSeparator, sbDisabledSeparator] then
  begin
    if Element = sbSeparator then
      LSrcRect := System.Types.Rect(270, 511, 270 + 2, 511 + 55)
    else
      LSrcRect := System.Types.Rect(273, 511, 273 + 2, 511 + 55);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
    Canvas.Pen.Color := clWhite;
    Canvas.MoveTo(Rect.Left + 1, Rect.Top);
    Canvas.LineTo(Rect.Left + 1, Rect.Bottom);
  end
  else if Element in [sbArrow..sbLargeArrowDown] then
  begin
    if Element = sbArrowDisabled then
      LSrcRect := System.Types.Rect(122, 187, 122 + 5, 187 + 4)
    else if Element = sbArrowPressed then
      LSrcRect := System.Types.Rect(128, 187, 128 + 5, 187 + 4)
    else
      LSrcRect := System.Types.Rect(116, 187, 116 + 5, 187 + 4);
    LDstRect := Rect;
    LDstRect.Right := LDstRect.Left + 5;
    LDstRect.Bottom := LDstRect.Top + 4;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  end
  else if Element = sbGroupSplit then
  begin
    LSrcRect := System.Types.Rect(96, 111, 96 + 2, 111 + 20);
    LDstRect := Rect;
    InflateRect(LDstRect, 0, -1);
    LDstRect.Right := LDstRect.Left + 2;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  end
  else if Element = sbSmallSplitHover then
  begin
    // Exclude the end border
    LSrcRect := System.Types.Rect(99, 22, 99 + 100 - 2, 2 * 22);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
  end
  else if Element = sbSmallSplitInactive then
  begin
    // Exclude the end border
    LSrcRect := System.Types.Rect(99, 5 * 22, 99 + 100 - 2, 6 * 22);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
  end
  else if Element = sbSmallSplitPressed then
  begin
    // Exclude the end border
    LSrcRect := System.Types.Rect(99, 2 * 22, 99 + 100 - 2, 3 * 22);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
  end
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinMenu;
  Canvas: TCanvas; Rect: TRect);
var
  LSrcRect: TRect;
  LDstRect: TRect;
  LHeight: Integer;
  LWidth: Integer;
begin
  if Element = smHover then
  begin
    LWidth := 100;
    LHeight := 132 div 6;
    LSrcRect := System.Types.Rect(99, LHeight, 99 + LWidth, 2 * LHeight);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element = smSelected then
  begin
    LWidth := 100;
    LHeight := 132 div 6;
    LSrcRect := System.Types.Rect(99, 3 * LHeight, 99 + LWidth, 4 * LHeight);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element = smDisabled then
  begin
    LWidth := 100;
    LHeight := 132 div 6;
    LSrcRect := System.Types.Rect(99, 0, 99 + LWidth, LHeight);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element in [smRichContentHover, smRichContentDisabled] then
  begin
    LWidth := 100;
    LHeight := 104 div 2;
    if Element = smRichContentHover then
      LSrcRect := System.Types.Rect(0, 293, LWidth, 293 + LHeight)
    else
      LSrcRect := System.Types.Rect(0, 293 + LHeight, LWidth, 293 + (2 * LHeight));
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element = smOptionButton then
  begin
    LSrcRect := System.Types.Rect(361, 184, 361 + 20, 184 + 22);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element = smOptionButtonHover then
  begin
    LSrcRect := System.Types.Rect(381, 184, 381 + 20, 184 + 22);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element = smCheck then
  begin
    LSrcRect := System.Types.Rect(203, 103, 203+20, 103+20);
    LDstRect := Rect;
    LDstRect.Left := LDstRect.Left + 2;
    LDstRect.Top := LDstRect.Top + 1;
    LDstRect.Right := LDstRect.Left + 20;
    LDstRect.Bottom := LDstRect.Top + 20;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  end
  else if Element = smCheckDisabled then
  begin
    LSrcRect := System.Types.Rect(223, 103, 223+20, 103+20);
    LDstRect := Rect;
    LDstRect.Left := LDstRect.Left + 2;
    LDstRect.Top := LDstRect.Top + 1;
    LDstRect.Right := LDstRect.Left + 20;
    LDstRect.Bottom := LDstRect.Top + 20;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  end
  else if Element = smCheckIcon then
  begin
    LSrcRect := System.Types.Rect(243, 103, 243+20, 103+20);
    LDstRect := Rect;
    LDstRect.Left := LDstRect.Left + 2;
    LDstRect.Top := LDstRect.Top + 1;
    LDstRect.Right := LDstRect.Left + 20;
    LDstRect.Bottom := LDstRect.Top + 20;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  end
  else if Element = smCheckDisabledIcon then
  begin
    LSrcRect := System.Types.Rect(263, 103, 263+20, 103+20);
    LDstRect := Rect;
    LDstRect.Left := LDstRect.Left + 2;
    LDstRect.Top := LDstRect.Top + 1;
    LDstRect.Right := LDstRect.Left + 20;
    LDstRect.Bottom := LDstRect.Top + 20;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  end
  else
  begin
    case Element of
      smScrollButton:
        begin
          LSrcRect := System.Types.Rect(0, 146, 291, 146 + 13);
          DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
        end;
      smScrollButtonHover:
        begin
          LSrcRect := System.Types.Rect(0, 133, 291, 133 + 13);
          DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
        end;
      smResize:
        begin
          LSrcRect := System.Types.Rect(424, 77, 424 + 15, 77 + 11);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      smResizeVertical:
        begin
          LSrcRect := System.Types.Rect(424, 72, 424 + 14, 72 + 4);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      smResizeBoth:
        begin
          LSrcRect := System.Types.Rect(424, 65, 424 + 6, 65 + 6);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      smSeparator:
        begin
          LSrcRect := System.Types.Rect(202, 39, 202 + 87, 39 + 25);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      smBanner:
        begin
          LSrcRect := System.Types.Rect(202, 4, 202 + 25, 4 + 22);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      smScrollButtonUpIcon:
        begin
          LSrcRect := System.Types.Rect(144, 188, 144+5, 188+3);
          LDstRect := Rect;
          LDstRect.Left := ((Rect.Right - Rect.Left) div 2) - (5 div 2);
          LDstRect.Right := LDstRect.Left + 5;
          LDstRect.Top := ((Rect.Bottom - Rect.Top) div 2) - (3 div 2);
          LDstRect.Bottom := LDstRect.Top + 3;
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
        end;
      smScrollButtonDownIcon:
        begin
          LSrcRect := System.Types.Rect(144, 192, 144+5, 192+3);
          LDstRect := Rect;
          LDstRect.Left := ((Rect.Right - Rect.Left) div 2) - (5 div 2);
          LDstRect.Right := LDstRect.Left + 5;
          LDstRect.Top := ((Rect.Bottom - Rect.Top) div 2) - (3 div 2);
          LDstRect.Bottom := LDstRect.Top + 3;
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
        end;
      smArrowLeftIcon:
        begin
          LSrcRect := System.Types.Rect(134, 187, 134 + 4, 187 + 7);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      smArrowLeftDisabledIcon:
        begin
          LSrcRect := System.Types.Rect(134, 195, 134 + 4, 195 + 7);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      smArrowRightIcon:
        begin
          LSrcRect := System.Types.Rect(139, 187, 139 + 4, 187 + 7);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
      smArrowRightDisabledIcon:
        begin
          LSrcRect := System.Types.Rect(139, 195, 139 + 4, 195 + 7);
          DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
        end;
    end;
  end;
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinForm;
  Canvas: TCanvas; Rect: TRect; Height: Integer);
var
  LSrcRect: TRect;
  LDstRect: TRect;
  LWidth: Integer;
  LHeight: Integer;
begin
  case Element of
    sfButton:
      begin
        LSrcRect := System.Types.Rect(347, 424, 347 + 25, 424 + 25);
        DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
      end;
    sfButtonHover:
      begin
        LSrcRect := System.Types.Rect(295, 424, 295 + 25, 424 + 25);
        DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
      end;
    sfButtonPressed:
      begin
        LSrcRect := System.Types.Rect(321, 424, 321 + 25, 424 + 25);
        DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
      end;
    sfMinimize..sfMinimizeDisabled:
      begin
        if Element = sfMinimize then
          LSrcRect := System.Types.Rect(332, 452, 332 + 15, 452 + 13)
        else if Element = sfMinimizeDisabled then
          LSrcRect := System.Types.Rect(332, 469, 332 + 15, 469 + 13)
        else if Element = sfMinimizeHover then
          LSrcRect := System.Types.Rect(332, 486, 332 + 15, 486 + 13)
        else if Element = sfMinimizePressed then
          LSrcRect := System.Types.Rect(332, 502, 332 + 15, 503 + 13);
        LWidth := 15;
        LHeight := 13;
        LDstRect := Rect;
        LDstRect.Left := LDstRect.Left + (LDstRect.Right - LDstRect.Left) div 2 - (LWidth div 2);
        LDstRect.Right := LDstRect.Left + 15;
        LDstRect.Top := LDstRect.Top + (LDstRect.Bottom - LDstRect.Top) div 2 - (LHeight div 2);
        LDstRect.Bottom := LDstRect.Top + 13;
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
      end;
    sfMaximize..sfMaximizeDisabled:
      begin
        if Element = sfMaximize then
          LSrcRect := System.Types.Rect(314, 452, 314 + 15, 452 + 13)
        else if Element = sfMaximizeDisabled then
          LSrcRect := System.Types.Rect(314, 469, 314 + 15, 469 + 13)
        else if Element = sfMaximizeHover then
          LSrcRect := System.Types.Rect(314, 486, 314 + 15, 486 + 13)
        else if Element = sfMaximizePressed then
          LSrcRect := System.Types.Rect(314, 503, 314 + 15, 503 + 13);
        LWidth := 15;
        LHeight := 13;
        LDstRect := Rect;
        LDstRect.Left := LDstRect.Left + (LDstRect.Right - LDstRect.Left) div 2 - (LWidth div 2);
        LDstRect.Right := LDstRect.Left + 15;
        LDstRect.Top := LDstRect.Top + (LDstRect.Bottom - LDstRect.Top) div 2 - (LHeight div 2);
        LDstRect.Bottom := LDstRect.Top + 13;
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
      end;
    sfRestore..sfRestoreDisabled:
      begin
        if Element = sfRestore then
          LSrcRect := System.Types.Rect(296, 452, 296 + 15, 452 + 13)
        else if Element = sfRestoreDisabled then
          LSrcRect := System.Types.Rect(296, 469, 296 + 15, 469 + 13)
        else if Element = sfRestoreHover then
          LSrcRect := System.Types.Rect(296, 486, 296 + 15, 486 + 13)
        else if Element = sfRestorePressed then
          LSrcRect := System.Types.Rect(296, 503, 296 + 15, 503 + 13);
        LWidth := 15;
        LHeight := 13;
        LDstRect := Rect;
        LDstRect.Left := LDstRect.Left + (LDstRect.Right - LDstRect.Left) div 2 - (LWidth div 2);
        LDstRect.Right := LDstRect.Left + 15;
        LDstRect.Top := LDstRect.Top + (LDstRect.Bottom - LDstRect.Top) div 2 - (LHeight div 2);
        LDstRect.Bottom := LDstRect.Top + 13;
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
      end;
    sfClose..sfCloseDisabled:
      begin
        if Element = sfClose then
          LSrcRect := System.Types.Rect(350, 452, 350 + 15, 452 + 13)
        else if Element = sfCloseDisabled then
          LSrcRect := System.Types.Rect(350, 469, 350 + 15, 469 + 13)
        else if Element = sfCloseHover then
          LSrcRect := System.Types.Rect(350, 486, 350 + 15, 486 + 13)
        else if Element = sfClosePressed then
          LSrcRect := System.Types.Rect(350, 503, 350 + 15, 503 + 13);
        LWidth := 15;
        LHeight := 13;
        LDstRect := Rect;
        LDstRect.Left := LDstRect.Left + (LDstRect.Right - LDstRect.Left) div 2 - (LWidth div 2);
        LDstRect.Right := LDstRect.Left + 15;
        LDstRect.Top := LDstRect.Top + (LDstRect.Bottom - LDstRect.Top) div 2 - (LHeight div 2);
        LDstRect.Bottom := LDstRect.Top + 13;
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
      end;
  else
    if Element = sfLeftFrame then
    begin
      LSrcRect := System.Types.Rect(275, 452, 275 + 4, 452 + 20);
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
    end
    else if Element = sfRightFrame then
    begin
      LSrcRect := System.Types.Rect(280, 452, 280 + 4, 452 + 20);
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
    end
    else if Element = sfLeftFrameDisabled then
    begin
      LSrcRect := System.Types.Rect(285, 452, 285 + 4, 452 + 20);
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
    end
    else if Element = sfRightFrameDisabled then
    begin
      LSrcRect := System.Types.Rect(290, 452, 290 + 4, 452 + 20);
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
    end
    else if Element = sfLeftFrameTop then
    begin
      LSrcRect := System.Types.Rect(275, 420, 275 + 4, 420 + 5);
      LDstRect := Rect;
      LDstRect.Bottom := 5;
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);

      LSrcRect := System.Types.Rect(275, 420 + 5, 275 + 4, 420 + 29);
      LDstRect := Rect;
      LDstRect.Top := 5;
      LDstRect.Bottom := Height - 2;
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);

      LSrcRect := System.Types.Rect(275, 420 + 29, 275 + 4, 420 + 31);
      LDstRect := Rect;
      LDstRect.Top := Height - 2;
      LDstRect.Bottom := Height;
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);
    end
    else if Element = sfRightFrameTop then
    begin
      LSrcRect := System.Types.Rect(280, 420, 280 + 4, 420 + 5);
      LDstRect := Rect;
      LDstRect.Bottom := 5;
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);

      LSrcRect := System.Types.Rect(280, 420 + 5, 280 + 4, 420 + 29);
      LDstRect := Rect;
      LDstRect.Top := 5;
      LDstRect.Bottom := Height - 2;
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);

      LSrcRect := System.Types.Rect(280, 420 + 29, 280 + 4, 420 + 31);
      LDstRect := Rect;
      LDstRect.Top := Height - 2;
      LDstRect.Bottom := Height;
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);
    end
    else if Element = sfLeftFrameTopDisabled then
    begin
      LSrcRect := System.Types.Rect(285, 420, 285 + 4, 420 + 30);
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
    end
    else if Element = sfRightFrameTopDisabled then
    begin
      LSrcRect := System.Types.Rect(290, 420, 290 + 4, 420 + 30);
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
    end
    else if Element = sfBottomFrame then
    begin
      LSrcRect := System.Types.Rect(295, 421, 295 + 75, 421 + 2);
      DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
    end
  end;
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinRibbon;
  Canvas: TCanvas; Rect: TRect; Height: Integer);
var
  LSrcRect: TRect;
  LDstRect: TRect;
begin
  case Element of
    srPage:
      begin
        LSrcRect := System.Types.Rect(181, 497, 181 + 20, 497 + 91);
        DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 3, 3, 255);
      end;
    srBody:
      begin
        LSrcRect := System.Types.Rect(432, 152 + 31, 432 + 3, 152 + 147);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 255);
      end;
    srBackground:
      begin
        LSrcRect := System.Types.Rect(432, 152, 432 + 3, 152 + 1);
        LDstRect := Rect;
        LDstRect.Bottom := LDstRect.Top + 1;
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);

        LSrcRect := System.Types.Rect(432, 152 + 1, 432 + 3, 152 + 29 - 2);
        LDstRect := Rect;
        LDstRect.Top := LDstRect.Top + 1;
        LDstRect.Bottom := LDstRect.Top + Height - 2;
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);

        LSrcRect := System.Types.Rect(432, 152 + 29, 432 + 3, 152 + 31);
        LDstRect := Rect;
        LDstRect.Top := LDstRect.Top + Height - 2;
        LDstRect.Bottom := LDstRect.Top + 2;
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);
      end;
    srBackgroundDisabled:
      begin
        LSrcRect := System.Types.Rect(436, 152, 436 + 3, 152 + 1);
        LDstRect := Rect;
        LDstRect.Bottom := LDstRect.Top + 1;
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);

        LSrcRect := System.Types.Rect(436, 152 + 1, 436 + 3, 152 + 29 - 2);
        LDstRect := Rect;
        LDstRect.Top := LDstRect.Top + 1;
        LDstRect.Bottom := LDstRect.Top + Height - 2;
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);

        LSrcRect := System.Types.Rect(436, 152 + 29, 436 + 3, 152 + 31);
        LDstRect := Rect;
        LDstRect.Top := LDstRect.Top + Height - 2;
        LDstRect.Bottom := Height;
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);
      end;
    srHelp:
      begin
        LSrcRect := System.Types.Rect(280, 473, 280 + 14, 473 + 14);
        LDstRect := System.Types.Rect(Rect.Left, Rect.Top, Rect.Left + 14, Rect.Top + 14);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
      end;
  end;
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinApplicationMenu;
  Canvas: TCanvas; Rect: TRect);
var
  LRect: TRect;
  LBitmap: TAlphaBitmap;
  LWidth: Integer;
  LHeight: Integer;
  LSrcRect: TRect;
  LDstRect: TRect;
begin
  if Element in [samMenuHover, samMenuDisabled] then
  begin
    LWidth := 100;
    LHeight := 132 div 3;
    if Element = samMenuHover then
      LSrcRect := System.Types.Rect(0, 160, LWidth, 160 + LHeight)
    else
      LSrcRect := System.Types.Rect(0, 160 + (2 * LHeight), LWidth, 160 + (3 * LHeight));
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
  end
  else if Element = samMenuSplitHover then
  begin
    LBitmap := TAlphaBitmap.Create;
    try
      LBitmap.SetSize(98, 132 div 3);
      LRect := Rect;
      LRect.Right := 100 - 2;
      LRect.Top := 160 + LBitmap.Height;
      LRect.Bottom := 160 + (LBitmap.Height * 2);
      LDstRect := System.Types.Rect(0, 0, 98, 44);
      DrawTransparentBitmap(RibbonSkin.Bitmap, LRect, LBitmap.Canvas, LDstRect, 255);
      DrawButton(LBitmap, Canvas, Rect);
    finally
      LBitmap.Free;
    end;
  end
  else if Element = samBorder then
  begin
    // top
    LSrcRect := System.Types.Rect(102, 480, 102 + 5, 480 + 18);
    LDstRect := Rect;
    LDstRect.Right := 5;
    LDstRect.Bottom := 18;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
    LSrcRect := System.Types.Rect(173, 480, 173 + 5, 480 + 18);
    LDstRect := Rect;
    LDstRect.Left := LDstRect.Right - 5;
    LDstRect.Bottom := 18;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
    LSrcRect := System.Types.Rect(107, 480, 107 + 66, 480 + 18);
    LDstRect := Rect;
    LDstRect.Left := 5;
    LDstRect.Right := LDstRect.Right - 5;
    LDstRect.Bottom := 18;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
    // left side
    LSrcRect := System.Types.Rect(102, 497, 102 + 6, 497 + 65);
    LDstRect := Rect;
    LDstRect.Top := 18;
    LDstRect.Right := 6;
    LDstRect.Bottom := LDstRect.Bottom - 29;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
    // right side
    LSrcRect := System.Types.Rect(172, 497, 172 + 6, 497 + 65);
    LDstRect := Rect;
    LDstRect.Top := 18;
    LDstRect.Left := LDstRect.Right - 6;
    LDstRect.Bottom := LDstRect.Bottom - 29;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
    // bottom
    LSrcRect := System.Types.Rect(102, 561, 102 + 5, 561 + 29);
    LDstRect := Rect;
    LDstRect.Right := LDstRect.Left + 5;
    LDstRect.Top := LDstRect.Bottom - 29;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
    LSrcRect := System.Types.Rect(173, 561, 173 + 5, 561 + 29);
    LDstRect := Rect;
    LDstRect.Left := LDstRect.Right - 5;
    LDstRect.Top := LDstRect.Bottom - 29;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
    LSrcRect := System.Types.Rect(107, 561, 107 + 66, 561 + 29);
    LDstRect := Rect;
    LDstRect.Left := 5;
    LDstRect.Right := LDstRect.Right - 5;
    LDstRect.Top := LDstRect.Bottom - 29;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  end
  else if Element = samButtonShadow then
  begin
    LSrcRect := System.Types.Rect(387, 296, 387 + 38, 296 + 38);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
  end
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinApplicationMenu; Canvas: TCanvas;
  const X, Y: Integer; const Opacity: Byte);
var
  LSrcRect: TRect;
  LDstRect: TRect;
begin
  LDstRect := Rect(X, Y, X + 36, Y + 36);
  if Element = samButton then
  begin
    LSrcRect := System.Types.Rect(387, 336, 387 + 36, 336 + 36);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, Opacity);
  end
  else if Element = samButtonHover then
  begin
    LSrcRect := System.Types.Rect(387, 376, 387 + 36, 376 + 36);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, Opacity);
  end
  else if Element = samButtonPressed then
  begin
    LSrcRect := System.Types.Rect(387, 416, 387 + 36, 416 + 36);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, Opacity);
  end
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinQuickAccessToolbar;
  Canvas: TCanvas; Rect: TRect);
var
  LSrcRect: TRect;
  LDstRect: TRect;
begin
  case Element of
    sqBackground:
      begin
        LSrcRect := System.Types.Rect(370, 494, 370 + 30, 494 + 26);
        DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 3, 3, 255);
      end;
    sqStart:
      begin
        LSrcRect := System.Types.Rect(268, 571, 268 + 15, 571 + 24);
        LDstRect := System.Types.Rect(Rect.Left, Rect.Top, Rect.Left + 15, Rect.Top + 24);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
      end;
    sqStartRTL:
      begin
        LSrcRect := System.Types.Rect(360, 571, 360 + 15, 571 + 24);
        LDstRect := System.Types.Rect(Rect.Left, Rect.Top, Rect.Left + 15, Rect.Top + 24);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
      end;
    sqMiddle:
      begin
        LSrcRect := System.Types.Rect(283, 571, 283 + 25, 571 + 24);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sqEnd:
      begin
        LSrcRect := System.Types.Rect(308, 571, 308 + 13, 571 + 24);
        LDstRect := System.Types.Rect(Rect.Left, Rect.Top, Rect.Left + 13, Rect.Top + 24);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
      end;
    sqEndRTL:
      begin
        LSrcRect := System.Types.Rect(322, 571, 322 + 13, 571 + 24);
        LDstRect := System.Types.Rect(Rect.Left, Rect.Top, Rect.Left + 13, Rect.Top + 24);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
      end;
    sqButton: exit;
    sqButtonHover:
      begin
        LSrcRect := System.Types.Rect(411, 128, 411 + 13, 128 + 22);
        LDstRect := Rect;
        Dec(LDstRect.Bottom, 2);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);
      end;
    sqButtonPressed:
      begin
        LSrcRect := System.Types.Rect(424, 128, 424 + 13, 128 + 22);
        LDstRect := Rect;
        Dec(LDstRect.Bottom, 2);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);
      end;
    sqButtonCustomizeIcon:
      begin
        LSrcRect := System.Types.Rect(208, 190, 208 + 5, 190 + 7);
        LDstRect := Rect;
        LDstRect.Left := LDstRect.Left + ((LDstRect.Right - LDstRect.Left) div 2) - 2;
        LDstRect.Right := LDstRect.Left + 5;
        LDstRect.Top := (LDstRect.Bottom div 2) - 4;
        LDstRect.Bottom := LDstRect.Top + 7;
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);
      end;
    sqButtonMoreIcon:
      begin
        LSrcRect := System.Types.Rect(234, 190, 234 + 7, 190 + 5);
        LDstRect := Rect;
        LDstRect.Left := LDstRect.Left + ((LDstRect.Right - LDstRect.Left) div 2) - 2;
        LDstRect.Right := LDstRect.Left + 7;
        LDstRect.Top := (LDstRect.Bottom div 2) - 3;
        LDstRect.Bottom := LDstRect.Top + 5;
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect, 255);
      end;
    sqGroup:
      begin
        LSrcRect := System.Types.Rect(335, 521, 335 + 22, 521 + 22);
        DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
      end;
    sqGroupHover:
      begin
        LSrcRect := System.Types.Rect(357, 521, 357 + 22, 521 + 22);
        DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
      end;
    sqGroupPressed:
      begin
        LSrcRect := System.Types.Rect(379, 521, 379 + 22, 521 + 22);
        DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 2, 2, 255);
      end;
  end;
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinGallery;
  Canvas: TCanvas; Rect: TRect);
var
  LSrcRect: TRect;
begin
  case Element of
    sgUpButton:
      begin
        LSrcRect := System.Types.Rect(202, 432, 202 + 15, 432 + 20);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sgUpButtonHover:
      begin
        LSrcRect := System.Types.Rect(234, 432, 234 + 15, 432 + 20);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sgUpButtonPressed:
      begin
        LSrcRect := System.Types.Rect(250, 432, 250 + 15, 432 + 20);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sgUpButtonDisabled:
      begin
        LSrcRect := System.Types.Rect(218, 432, 218 + 15, 432 + 20);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sgDownButton:
      begin
        LSrcRect := System.Types.Rect(202 + 20, 432, 202 + 15, 432 + 40);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sgDownButtonHover:
      begin
        LSrcRect := System.Types.Rect(234 + 20, 432, 202 + 15, 432 + 40);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sgDownButtonPressed:
      begin
        LSrcRect := System.Types.Rect(250 + 29, 432, 202 + 15, 432 + 40);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sgDownButtonDisabled:
      begin
        LSrcRect := System.Types.Rect(218 + 20, 432, 202 + 15, 432 + 40);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sgMoreButton:
      begin
        LSrcRect := System.Types.Rect(202, 432 + 40, 202 + 15, 432 + 60);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sgMoreButtonHover:
      begin
        LSrcRect := System.Types.Rect(234, 432 + 40, 234 + 15, 432 + 60);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sgMoreButtonHoverDisabled:
      begin
        LSrcRect := System.Types.Rect(218, 432 + 40, 218 + 15, 432 + 60);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sgItemHover:
      begin
        LSrcRect := System.Types.Rect(202, 207, 202 + 72, 207 + 56);
        DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 3, 3);
      end;
    sgItemPressed:
      begin
        LSrcRect := System.Types.Rect(202, 263, 202 + 72, 263 + 56);
        DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 3, 3);
      end;
    sgItemSelected:
      begin
        LSrcRect := System.Types.Rect(202, 319, 202 + 72, 319 + 56);
        DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 3, 3);
      end;
    sgItemHoverSelected:
      begin
        LSrcRect := System.Types.Rect(202, 375, 202 + 72, 375 + 56);
        DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 3, 3);
      end;
  end;
end;

constructor TRibbonStyleActionBars.Create;
begin
  inherited;
  FRibbonSkin := GetSkinClass.Create;
end;

destructor TRibbonStyleActionBars.Destroy;
begin
  FRibbonSkin.Free;
  inherited;
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinStatusBar;
  Canvas: TCanvas; Rect: TRect);
begin
  //
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinScrollBar;
  Canvas: TCanvas; Rect: TRect);
begin
  //
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinSpinEdit;
  Canvas: TCanvas; Rect: TRect);
var
  LSrcRect: TRect;
  LDstRect: TRect;
begin
  if Element = ssButtonHover then
  begin
    LSrcRect := System.Types.Rect(257, 160, 257 + 17, 160 + 10);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 0, 0, 255);
  end
  else if Element = ssButtonPressed then
  begin
    LSrcRect := System.Types.Rect(257, 170, 257 + 17, 170 + 10);
    DrawButton(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect, 0, 0, 255);
  end
  else if Element = ssButtonUp then
  begin
    LSrcRect := System.Types.Rect(274, 160, 274 + 17, 160 + 10);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
  end
  else if Element = ssButtonDown then
  begin
    LSrcRect := System.Types.Rect(274, 170, 274 + 17, 170 + 10);
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
  end
  else if Element = ssButtonUpIcon then
  begin
    LSrcRect := System.Types.Rect(144, 188, 144 + 5, 188 + 3);
    LDstRect := Rect;
    LDstRect.Left := ((LDstRect.Right - LDstRect.Left) div 2) - (5 div 2);
    LDstRect.Top := ((LDstRect.Bottom - LDstRect.Top) div 2) - (3 div 2);
    LDstRect.Right := LDstRect.Left + 5;
    LDstRect.Bottom := LDstRect.Top + 3;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  end
  else if Element = ssButtonDownIcon then
  begin
    LSrcRect := System.Types.Rect(144, 192, 144 + 5, 192 + 3);
    LDstRect := Rect;
    LDstRect.Left := ((LDstRect.Right - LDstRect.Left) div 2) - (5 div 2);
    LDstRect.Top := ((LDstRect.Bottom - LDstRect.Top) div 2) - (3 div 2);
    LDstRect.Right := LDstRect.Left + 5;
    LDstRect.Bottom := LDstRect.Top + 3;
    DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  end;
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinComboBox;
  Canvas: TCanvas; Rect: TRect);
var
  LSrcRect: TRect;
  LDstRect: TRect;
begin
  LDstRect := System.Types.Rect(Rect.Left, Rect.Top, Rect.Left + 14, Rect.Top + 22);
  case Element of
    scButton: LSrcRect := System.Types.Rect(276, 521, 276 + 14, 521 + 22);
    scButtonInactive: LSrcRect := System.Types.Rect(318, 521, 318 + 14, 521 + 22);
    scButtonHover: LSrcRect := System.Types.Rect(290, 521, 290 + 14, 521 + 22);
    scButtonPressed: LSrcRect := System.Types.Rect(304, 521, 304 + 14, 521 + 22);
  end;
  DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
  // Draw the associated arrow
  LDstRect := System.Types.Rect(Rect.Left + 7 - (5 div 2),
    Rect.Top + 11 - 2,
    Rect.Left + 7 - (5 div 2) + 5,
    Rect.Top + 11 - 2 + 4);
  case Element of
    scButton: LSrcRect := System.Types.Rect(276, 544, 276 + 5, 544 + 4);
    scButtonInactive: LSrcRect := System.Types.Rect(282, 544, 282 + 5, 544 + 4);
    scButtonHover: LSrcRect := System.Types.Rect(288, 544, 288 + 5, 544 + 4);
    scButtonPressed: LSrcRect := System.Types.Rect(294, 544, 294 + 5, 544 + 4);
  end;
  DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, LDstRect);
end;

function TRibbonStyleActionBars.GetAddRemoveItemClass(ActionBar: TCustomActionBar): TCustomAddRemoveItemClass;
begin
  Result := TRibbonCustomizeItem;
end;

function TRibbonStyleActionBars.GetColorMapClass(ActionBar: TCustomActionBar): TCustomColorMapClass;
begin
  Result := nil;
end;

function TRibbonStyleActionBars.GetControlClass(ActionBar: TCustomActionBar;
  AnItem: TActionClientItem): TCustomActionControlClass;
var
  LGalleryProps: TGalleryProperties;
  LButtonProps: TButtonProperties;
begin
  Result := nil;
  if AnItem.CommandStyle = csComboBox then
    Result := TRibbonComboControl
  else if AnItem.CommandStyle = csCheckBox then
    Result := TRibbonCheckBoxControl
  else if AnItem.CommandStyle = csRadioButton then
    Result := TRibbonRadioButtonControl
  else if ((ActionBar is TCustomRibbonQuickAccessToolbar) or
    (ActionBar is TCustomRibbonQuickAccessPopupToolbar)) and
    (AnItem.Tag = 100) then
    Result := TRibbonGroupDropDown
  else if AnItem.CommandStyle = csControl then
    Result := TRibbonCustomControl
  else if (AnItem.CommandStyle = csGallery) and
    (TGalleryProperties(AnItem.CommandProperties).GalleryType = gtRibbon) then
    Result := TRibbonGalleryControl
  else if ActionBar is TCustomActionMainMenuBar then
  begin
    if ActionBar is TRibbonApplicationMenuBar then
      Result := TRibbonApplicationMenuButton
    else
      Result := TRibbonStyleMenuButton;
  end
  else if (ActionBar is TRibbonGalleryBar) and (AnItem.CommandStyle <> csSeparator) then
    Result := TRibbonGalleryItem
  else if (AnItem.CommandProperties is TButtonProperties) and
    (TButtonProperties(AnItem.CommandProperties).ButtonType in [btDropDown, btSplit]) and
    (AnItem.CommandStyle = csGallery) then
  begin
    if AnItem.CommandProperties is TGalleryProperties then
      LGalleryProps := TGalleryProperties(AnItem.CommandProperties)
    else
      LGalleryProps := nil;
    if LGalleryProps = nil then
    begin
      Result := TRibbonDropDownButton
    end
    else
    begin
      if (LGalleryProps.ButtonType = btDropDown) then
        Result := TRibbonDropDownButton
      else if (LGalleryProps.ButtonSize = bsSmall) then
        Result := TRibbonGallerySplitButton
      else if LGalleryProps.ButtonType = btSplit then
        Result := TRibbonLargeSplitButton;
    end;
  end
  else if ActionBar is TRibbonStyleMainPopupMenu then
  begin
    if AnItem.CommandStyle = csSeparator then
      Result := TRibbonMainMenuSeparator
    else if (AnItem.CommandStyle = csMenu) then
    begin
      if (TMenuProperties(AnItem.CommandProperties).ShowRichContent) then
        Result := TRibbonRichContentMainMenuItem
      else
        Result := TRibbonMainMenuItem
    end
    else
      Result := TRibbonMenuItem;
  end
  else if (AnItem.CommandProperties is TButtonProperties) and
    ((TButtonProperties(AnItem.CommandProperties)).ButtonType = btSplit) and
    (AnItem.Items.Count > 0) and
    (TButtonProperties(AnItem.CommandProperties).ButtonSize = bsSmall) then
    Result := TRibbonSmallSplitButton
  else if ActionBar is TRibbonApplicationPopupMenu then
  begin
    if AnItem.HasItems and (AnItem.Action <> nil) then
      Result := TRibbonSplitMenuItem
    else
      Result := TRibbonApplicationMenuItem
  end
  else if (ActionBar is TCustomActionPopupMenu) and
   not (ActionBar is TCustomRibbonQuickAccessPopupToolbar) then
  begin
    if AnItem.CommandStyle = csMenu then
    begin
      if TMenuProperties(AnItem.CommandProperties).ContainedControl <> nil then
        Result := TRibbonGalleryControlMenuItem
      else if TMenuProperties(AnItem.CommandProperties).ShowRichContent then
        Result := TRibbonRichContentItem
      else
        Result := TRibbonMenuItem;
    end
    else if AnItem.CommandStyle = csButton then
      Result := TRibbonMenuItem
    else if AnItem.CommandStyle = csSeparator then
      Result := TRibbonSeparator
    else
      Result := TRibbonGalleryMenuItem
  end
  else if (AnItem.CommandStyle = csButton) then
  begin
    begin
      LButtonProps := (AnItem.CommandProperties as TButtonProperties);
      if (LButtonProps <> nil) and (LButtonProps.ButtonType in [btDropDown, btSplit]) then
      begin
        if LButtonProps.ButtonType = btDropDown then
          Result := TRibbonDropDownButton
        else
        begin
          if LButtonProps.ButtonSize = bsLarge then
            Result := TRibbonLargeSplitButton
          else
            Result := TRibbonSmallSplitButton
        end;
      end
      else if (LButtonProps <> nil) and (LButtonProps.ButtonSize = bsLarge) then
        Result := TRibbonLargeButtonControl
      else
        Result := TRibbonSmallButtonControl;
    end;
  end
  else if AnItem.CommandStyle = csSeparator then
  begin
    if AnItem.Caption = '-' then
      Result := TRibbonMenuSeparatorItem
    else
      Result := TRibbonSeparator
  end
  else
    Result := TRibbonSmallButtonControl
end;

function TRibbonStyleActionBars.GetPopupClass(ActionBar: TCustomActionBar): TCustomPopupClass;
begin
  // make sure inherited code path is used if the ActionBar
  // is a MainMenu and a menu is already visible 
  if (ActionBar is TCustomActionToolBar) then
    Result := inherited GetPopupClass(ActionBar)
  else if ActionBar is TRibbonApplicationMenuBar then
  begin
    if (TRibbonApplicationMenuBar(ActionBar).VisibleMenuCount = 1) then
      Result := TRibbonApplicationPopupMenu
    else if (TRibbonApplicationMenuBar(ActionBar).VisibleMenuCount > 1) and
      (TRibbonApplicationMenuBar(ActionBar).VisibleMenuCount < 3) then
      Result := TRibbonStyleMainPopupMenu
    else
      Result := TRibbonActionPopupMenu
  end
  else if ActionBar is TActionMainMenuBar then
    Result := TRibbonActionPopupMenu
  else
    Result := TRibbonStylePopupMenu;
end;

function TRibbonStyleActionBars.GetScrollBtnClass: TCustomToolScrollBtnClass;
begin
  Result := TRibbonToolScrollButton;
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinCheckBox;
  Canvas: TCanvas; Rect: TRect);
var
  LSrcRect: TRect;
begin
  case Element of
    scNormal:
      begin
        LSrcRect := System.Types.Rect(104, 160, 104 + 13, 160 + 13);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    scDisabled:
      begin
        LSrcRect := System.Types.Rect(104 + 13, 160, 104 + 26, 160 + 13);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    scHover:
      begin
        LSrcRect := System.Types.Rect(104 + 26, 160, 104 + 39, 160 + 13);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    scPressed:
      begin
        LSrcRect := System.Types.Rect(104 + 39, 160, 104 + 52, 160 + 13);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    scSelected:
      begin
        LSrcRect := System.Types.Rect(104 + 52, 160, 104 + 65, 160 + 13);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    scHoverSelected:
      begin
        LSrcRect := System.Types.Rect(104 + 65, 160, 104 + 78, 160 + 13);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    scDisabledSelected:
      begin
        LSrcRect := System.Types.Rect(104 + 78, 160, 104 + 91, 160 + 13);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
  end;
end;

procedure TRibbonStyleActionBars.DrawElement(Element: TSkinRadioButton;
  Canvas: TCanvas; Rect: TRect);
var
  LSrcRect: TRect;
begin
  case Element of
    sbNormal:
      begin
        LSrcRect := System.Types.Rect(104, 174, 104 + 12, 174 + 12);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sbDisabled:
      begin
        LSrcRect := System.Types.Rect(104 + 12, 174, 104 + 24, 174 + 12);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sbHover:
      begin
        LSrcRect := System.Types.Rect(104 + 24, 174, 104 + 36, 174 + 12);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sbPressed:
      begin
        LSrcRect := System.Types.Rect(104 + 36, 174, 104 + 48, 174 + 12);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sbSelected:
      begin
        LSrcRect := System.Types.Rect(104 + 48, 174, 104 + 60, 174 + 12);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sbHoverSelected:
      begin
        LSrcRect := System.Types.Rect(104 + 60, 174, 104 + 72, 174 + 12);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
    sbDisabledSelected:
      begin
        LSrcRect := System.Types.Rect(104 + 72, 174, 104 + 84, 174 + 12);
        DrawTransparentBitmap(RibbonSkin.Bitmap, LSrcRect, Canvas, Rect);
      end;
  end;
end;

{ TCustomRibbonSkin }

constructor TCustomRibbonSkin.Create;
begin
  inherited;
  FBitmap := TAlphaBitmap.Create;
  LoadSkin;
end;

destructor TCustomRibbonSkin.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

function TCustomRibbonSkin.GetLoadType: TRibbonSkinLoadType;
begin
  Result := ltResource;
end;

function TCustomRibbonSkin.GetLoadTypeValue: string;
begin
  Result := '';
end;

function TCustomRibbonSkin.GetResourceHandle: THandle;
begin
  Result := 0;
end;

procedure TCustomRibbonSkin.LoadSkin;
begin
  case GetLoadType of
    ltResource: DoLoadByResource;
    ltFile: DoLoadByFile;
  end;
end;

procedure TCustomRibbonSkin.DoLoadByFile;
begin
  FBitmap.LoadFromFile(GetLoadTypeValue);
end;

{$IFNDEF CLR}
procedure LoadCompressedResourceBitmap(ResID: string; Bitmap: TAlphaBitmap);
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
    Bitmap.LoadFromStream(LZStream);
  finally
    LZStream.Free;
    LResStream.Free;
  end;
{$ENDIF USE_ZLIB}
end;
{$ENDIF}

procedure TCustomRibbonSkin.DoLoadByResource;
begin
  LoadCompressedResourceBitmap(GetLoadTypeValue, FBitmap);
end;

end.
