
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars components                                      }
{                                                                   }
{       Copyright (c) 1998-2001 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxBar;

{$I dxBarVer.inc}

interface

uses
  SysUtils, TypInfo, Windows, Messages, Graphics, Controls, Forms, Classes,
  {$IFDEF DELPHI4}ImgList, ActnList, {$ENDIF}Menus, StdCtrls;

const
  WM_REPAINTBAR = WM_USER + 1;

  dxBarDefaultButtonArrowWidth = 11;
  dxBarDefaultLargeButtonArrowWidth = 13;//4;
  dxBarTransparentShadowSize = 4;
  dxBarOpaqueShadowSize = 2;

type
  TCurImageList = {$IFDEF DELPHI4}TCustomImageList{$ELSE}TImageList{$ENDIF};

  TdxBarPopupMenuLink = class;
  TdxBarManager = class;
  TdxBar = class;
  TdxBars = class;
  TdxBarItemLink = class;
  TdxBarItemLinks = class;
  TdxBarPopupMenu = class;
  TdxDockControl = class;
  TdxBarDockControl = class;
  TdxBarShadow = class;
  TCustomdxBarControl = class;
  TdxDockRow = class;
  TdxBarControl = class;
  TdxBarSubMenuControl = class;
  TdxBarItem = class;
  TdxBarItemControl = class;
  TCustomdxBarSubItem = class;

  TdxBarItemClass = class of TdxBarItem;

  {--------------------------
      Nonvisual components
   --------------------------}

  TdxBarDesigner = class
    procedure DeleteComponent(BarManager: TdxBarManager; Component: TPersistent); virtual; abstract;
    procedure SelectComponent(BarManager: TdxBarManager; Instance: TPersistent); virtual; abstract;
    function SelectedComponent(BarManager: TdxBarManager): TPersistent; virtual; abstract;
    procedure ShowDefaultEventHandler(AItem: TdxBarItem); virtual; abstract;
    function UniqueName(BarManager: TdxBarManager; const BaseName: string): string; virtual; abstract;
  end;

  TdxBarHintWindowClass = class of TdxBarHintWindow;

  TdxBarHintWindow = class(TCustomControl)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ActivateHint(P: TPoint; const AHint: string; BarManager: TdxBarManager); virtual;
  end;

  TdxBarItemVisible = (ivNever, ivInCustomizing, ivAlways);

  TdxBarGroup = class(TComponent)
  private
    FBarManager: TdxBarManager;
    FEnabled: Boolean;
    FItems: TList;
    FItemsNames: TStringList;
    FVisible: TdxBarItemVisible;
    function GetCount: Integer;
    function GetIndex: Integer;
    function GetItem(Index: Integer): TComponent;
    procedure SetEnabled(Value: Boolean);
    procedure SetIndex(Value: Integer);
    procedure SetVisible(Value: TdxBarItemVisible);
    procedure ReadItems(Reader: TReader);
    procedure WriteItems(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(AParent: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    procedure Add(AItem: TComponent);
    procedure Delete(Index: Integer);
    function IndexOf(AItem: TComponent): Integer;
    procedure Move(FromIndex, ToIndex: Integer);
    procedure Remove(AItem: TComponent);
    
    property BarManager: TdxBarManager read FBarManager;
    property Count: Integer read GetCount;
    property Index: Integer read GetIndex write SetIndex;
    property Items[Index: Integer]: TComponent read GetItem; default;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Visible: TdxBarItemVisible read FVisible write SetVisible default ivAlways;
  end;

  TdxBarPopupMenuLinkActionEvent = procedure(Sender: TdxBarPopupMenuLink; var X, Y: Integer;
    ClickedByMouse: Boolean; var AllowPopup: Boolean) of object;

  TdxBarPopupMenuLink = class(TCollectionItem)
  private
    FControl: TWinControl;
    FPopupMenu: TdxBarPopupMenu;
    FOnAction: TdxBarPopupMenuLinkActionEvent;
    function GetBarManager: TdxBarManager;
    procedure SetControl(Value: TWinControl);
    procedure SetPopupMenu(Value: TdxBarPopupMenu);
  protected
    function IsShortCut(AShortCut: TShortCut): Boolean;
  public
    procedure Assign(Source: TPersistent); override;
    function DoAction(Wnd: HWND; P: TPoint): Boolean;
    property BarManager: TdxBarManager read GetBarManager;
  published
    property Control: TWinControl read FControl write SetControl;
    property PopupMenu: TdxBarPopupMenu read FPopupMenu write SetPopupMenu;
    property OnAction: TdxBarPopupMenuLinkActionEvent read FOnAction write FOnAction;
  end;
        
  TdxBarPopupMenuLinks = class(TCollection)
  private
    FBarManager: TdxBarManager;
    function GetItem(Index: Integer): TdxBarPopupMenuLink;
    procedure SetItem(Index: Integer; Value: TdxBarPopupMenuLink);
  protected
    function GetOwner: TPersistent; override;
    function IsShortCut(AControl: TWinControl; AShortCut: TShortCut): Boolean;
  public
    constructor Create(ABarManager: TdxBarManager);
    function Add: TdxBarPopupMenuLink;
    function DoAction(AControl: TWinControl; Wnd: HWND; const P: TPoint): Boolean;
    property BarManager: TdxBarManager read FBarManager;
    property Items[Index: Integer]: TdxBarPopupMenuLink read GetItem write SetItem; default;
  end;

  TdxBarDockingStyle = (dsNone, dsLeft, dsTop, dsRight, dsBottom);
  TdxBarDockingStyles = set of TdxBarDockingStyle;
  TdxBarManagerStyle = (bmsStandard, bmsEnhanced, bmsFlat);
  TdxBarMenuAnimations = (maNone, maRandom, maUnfold, maSlide);
  TdxBarEvent = procedure(Sender: TdxBarManager; ABar: TdxBar) of object;
  TdxBarItemLinkEvent = procedure(Sender: TdxBarManager; AItemLink: TdxBarItemLink) of object;
  TdxBarVisibleChangeEvent = procedure(Sender: TdxBarManager; ABar: TdxBar) of object;
  TdxBarCanDockingEvent = procedure(Sender: TdxBar; Style: TdxBarDockingStyle;
    DockControl: TdxDockControl; var CanDocking: Boolean) of object;
  TdxBarMenuMergeEvent = procedure(Sender, ChildBarManager: TdxBarManager; AddItems: Boolean) of object;
  TdxBarShowPopupEvent = procedure(Sender: TdxBarManager; PopupItemLinks: TdxBarItemLinks) of object;
  TdxBarClickItemEvent = procedure(Sender: TdxBarManager; ClickedItem: TdxBarItem) of object;

  TdxBarManager = class(TComponent)
  private
    FAllowCallFromAnotherForm: Boolean;
    FAllowReset: Boolean;
    FAlwaysMerge: Boolean;
    FAlwaysSaveText: Boolean;
    FAutoDockColor: Boolean;
    FAutoHideEmptyBars: Boolean;
    FBars: TdxBars;
    FButtonArrowWidth: Integer;
    FCanCustomize: Boolean;
    FChangingStyle: Boolean;
    FCategories: TStrings;
    FCreatingFlag: Boolean;
    FDesigning: Boolean;
    FDetachingSubMenu: Boolean;
    FDockColor: TColor;
    FDockControls: TList;
    FDragging: Boolean;
    FDraggingItem: TdxBarItem;
    FDraggingItemLink: TdxBarItemLink;
    FDraggingItemLinkParentHandle: HWND;
    FEditFontHandle: HFONT;
    FFirstDocksUpdate: Boolean;
    FFlatCloseButton: Boolean;
    FFlatToolbarsBorderBrush: HBRUSH;
    FFlatToolbarsBrush: HBRUSH;
    FFlatToolbarsDownedBrush: HBRUSH;
    FFlatToolbarsDownedSelBrush: HBRUSH;
    FFlatToolbarsSelBrush: HBRUSH;
    FFocusedBarControl: TCustomdxBarControl;
    FFont: TFont;
    FGroups: TList;
    FHelpButtonGlyph: TBitmap;
    FHelpContext: THelpContext;
    FHideFloatingBarsWhenInactive: Boolean;
    FImageListBkColor: TColor;
    FImages, FLargeImages, FHotImages: TCurImageList;
    FImagesChangeLink, FLargeImagesChangeLink, FHotImagesChangeLink: TChangeLink;
    FIniFileName: string;
    FInternalFontChange: Boolean;
    FIsCustomizing: Boolean;
    FItems: TList;
    FLargeButtonArrowWidth: Integer;
    FLargeIcons: Boolean;
    FLockUpdate: Boolean;
    FMainForm: TCustomForm;
    FMainFormActive: Boolean;
    FMainMenuBar: TdxBar;
    FMenuAnimations: TdxBarMenuAnimations;
    FMenusShowRecentItemsFirst: Boolean;
    FModified: Boolean;
    FMostRecentItemsPercents: Byte;
    FMostRecentlyUsedUseCount: Integer;
    FNotDocking: TdxBarDockingStyles;
    FPopupMenuLinks: TdxBarPopupMenuLinks;
    FPopupMenus: TList;
    FPrevActiveMDIChild: HWND;
    FPrevChildMainMenuVisible: Boolean;
    FReadStateCount: Integer;
    FRegistryPath: string;
    FScaled: Boolean;
    FSelectedItem: TdxBarItemControl;
    FShowCloseButton: Boolean;
    FShowFullMenusAfterDelay: Boolean;
    FShowHelpButton: Boolean;
    FShowHint: Boolean;
    FShowHintForDisabledItems: Boolean;
    FShowShortCutInHint: Boolean;
    FStoreInIniFile: Boolean;
    FStoreInRegistry: Boolean;
    FStretchGlyphs: Boolean;
    FStyle: TdxBarManagerStyle;
    FSunkenBorder: Boolean;
    FTempBarsList: TList;
    FToolbarsVisibleChanging: Boolean;
    FUseF10ForMenu: Boolean;
    FUseFullReset: Boolean;
    FUseSystemFont: Boolean;
    FWaitForDockingTime: Integer;
    IsMDIMaximized: Boolean;

    FBeforeFingersSize: Integer;
    FFingersSize: Integer;
    FSubMenuBeginGroupIndent: Integer;
    FGlyphSize: Integer;
    FButtonWidth: Integer;
    FButtonHeight: Integer;
    FRealButtonArrowWidth: Integer;

    FOnBarAdd: TdxBarEvent;
    FOnBarAfterReset: TdxBarEvent;
    FOnBarBeforeReset: TdxBarEvent;
    FOnBarClose: TdxBarEvent;
    FOnBarDelete: TdxBarEvent;
    FOnBarDockingStyleChange: TdxBarEvent;
    FOnBarVisibleChange: TdxBarVisibleChangeEvent;

    FOnItemLinkAdd: TdxBarItemLinkEvent;
    FOnItemLinkChange: TdxBarItemLinkEvent;
    FOnItemLinkDelete: TdxBarItemLinkEvent;

    FOnCloseButtonClick: TNotifyEvent;
    FOnDocking: TdxBarCanDockingEvent;
    FOnHelpButtonClick: TNotifyEvent;
    FOnHideCustomizingForm: TNotifyEvent;
    FOnMenuMerge: TdxBarMenuMergeEvent;
    FOnShowCustomizingForm: TNotifyEvent;
    FOnShowCustomizingPopup: TdxBarShowPopupEvent;
    FOnShowToolbarsPopup: TdxBarShowPopupEvent;

    FOnClickItem: TdxBarClickItemEvent;

    function GetBarControlFocused: Boolean;
    function GetCategoryItemsVisible(AIndex: Integer): TdxBarItemVisible;
    function GetCategoryVisible(AIndex: Integer): Boolean;
    function GetDockColor: TColor;
    function GetDockControl(Index: Integer): TdxDockControl;
    function GetDockControlCount: Integer;
    function GetFlat: Boolean;
    function GetFlatToolbarsBorderColor: COLORREF;
    function GetFlatToolbarsColor: COLORREF;
    function GetFlatToolbarsDownedColor: COLORREF;
    function GetFlatToolbarsDownedSelColor: COLORREF;
    function GetFlatToolbarsSelColor: COLORREF;
    function GetGroup(Index: Integer): TdxBarGroup;
    function GetGroupCount: Integer;
    function GetIsCustomizing: Boolean;
    function GetIsDestroying: Boolean;
    function GetIsLoading: Boolean;
    function GetItemCount: Integer;
    function GetItem(Index: Integer): TdxBarItem;
    function GetMainMenuControl: TdxBarControl;
    function GetRealLargeButtonArrowWidth: Integer;
    procedure SetAutoDockColor(Value: Boolean);
    procedure SetAutoHideEmptyBars(Value: Boolean);
    procedure SetBars(Value: TdxBars);
    procedure SetButtonArrowWidth(Value: Integer);
    procedure SetCategories(Value: TStrings);
    procedure SetCategoryItemsVisible(AIndex: Integer; Value: TdxBarItemVisible);
    procedure SetCategoryVisible(AIndex: Integer; Value: Boolean);
    procedure SetDockColor(Value: TColor);
    procedure SetFlatCloseButton(Value: Boolean);
    procedure SetFont(Value: TFont);
    procedure SetHelpButtonGlyph(Value: TBitmap);
    procedure SetHideFloatingBarsWhenInactive(Value: Boolean);
    procedure SetHotImages(Value: TCurImageList);
    procedure SetImageListBkColor(Value: TColor);
    procedure SetImages(Value: TCurImageList);
    procedure SetLargeButtonArrowWidth(Value: Integer);
    procedure SetLargeIcons(Value: Boolean);
    procedure SetLargeImages(Value: TCurImageList);
    procedure SetLockUpdate(Value: Boolean);
    procedure SetMenuAnimations(Value: TdxBarMenuAnimations);
    procedure SetMenusShowRecentItemsFirst(Value: Boolean);
    procedure SetMostRecentItemsPercents(Value: Byte);
    procedure SetPopupMenuLinks(Value: TdxBarPopupMenuLinks);
    procedure SetScaled(Value: Boolean);
    procedure SetSelectedItem(Value: TdxBarItemControl);
    procedure SetShowCloseButton(Value: Boolean);
    procedure SetShowFullMenusAfterDelay(Value: Boolean);
    procedure SetShowHelpButton(Value: Boolean);
    procedure SetShowHint(Value: Boolean);
    procedure SetShowShortCutInHint(Value: Boolean);
    procedure SetStyle(Value: TdxBarManagerStyle);
    procedure SetSunkenBorder(Value: Boolean);
    procedure SetUseSystemFont(Value: Boolean);
    procedure SetWaitForDockingTime(Value: Integer);

    procedure AddCustomizeLink(ItemLinks: TdxBarItemLinks;
      ABeginGroup: Boolean; ItemClass: TdxBarItemClass);
    procedure CalcButtonsConsts;
    procedure DrawDraggingLine(AControl: TdxBarItemControl;
      IsBeginGroup, IsFirstPart, IsVerticalDirection: Boolean);
    procedure FontChanged(Sender: TObject);
    function ActiveMDIChild: HWND;
    procedure MainFormClientWndProc(Msg: UINT; wParam: WPARAM; lParam: LPARAM);
    procedure MainFormWndProc(Msg: UINT; wParam: WPARAM; lParam: LPARAM);
    function LoadMainFormFromBin: TForm;
    procedure CheckToolbarsVisibility;

    procedure DisplayHint;
    procedure HintActivate(AShow: Boolean; const CustomHint: string);

    procedure DestroyItems;
    procedure HelpButtonGlyphChanged(Sender: TObject);
    procedure HotImageListChange(Sender: TObject);
    procedure ImageListChange(Sender: TObject);
    procedure LargeImageListChange(Sender: TObject);
    procedure ToolbarsPopupClick(Sender: TObject);

    procedure CalcMostRecentlyUsedUseCount;
    function ShowRecentItemsFirst: Boolean;

    procedure AddDockControl(ADockControl: TdxDockControl);
    procedure RemoveDockControl(ADockControl: TdxDockControl);

    procedure AddGroup(AGroup: TdxBarGroup);
    procedure RemoveGroup(AGroup: TdxBarGroup);

    function IsDockColorStored: Boolean;
    procedure ReadDockControlHeights(Reader: TReader);
    procedure WriteDockControlHeights(Writer: TWriter);

    procedure CreateFlatToolbarsBrushes;
    procedure DestroyFlatToolbarsBrushes;

    procedure RefreshFloatingBarsShadows;
  protected
    procedure AssignFont;
    function CanReset: Boolean;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DesignerModified;
    procedure DoBarAfterReset(ABar: TdxBar); dynamic;
    procedure DoBarBeforeReset(ABar: TdxBar); dynamic;
    procedure DoBarClose(ABar: TdxBar); dynamic;
    procedure DoBarDockingStyleChanged(ABar: TdxBar); dynamic;
    procedure DoClickItem(AItem: TdxBarItem); virtual;
    procedure DoCloseButtonClick; dynamic;
    function DoDocking(ABar: TdxBar; AStyle: TdxBarDockingStyle;
      ADockControl: TdxDockControl): Boolean; virtual;
    procedure DoHelpButtonClick; dynamic;
    procedure DoShowCustomizingPopup(PopupItemLinks: TdxBarItemLinks); dynamic;
    procedure DoShowToolbarsPopup(PopupItemLinks: TdxBarItemLinks); dynamic;
    procedure DragAndDrop(AItem: TdxBarItem; AItemLink: TdxBarItemLink);
    function FindDockControl(APath: string): TdxBarDockControl;
    function GetCategoryRealIndex(AIndex: Integer): Integer;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetWindowForMouseCapturing: HWND;
    procedure HotImagesChanged;
    procedure ImagesChanged;
    procedure LargeImagesChanged;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ReadState(Reader: TReader); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure ShowToolbars(Show, ForceHiding: Boolean; ActiveWindow: HWND);
    procedure UpdateItems(Sender: TdxBarItem);

    property BarControlFocused: Boolean read GetBarControlFocused;
    property Dragging: Boolean read FDragging;
    property DraggingItem: TdxBarItem read FDraggingItem;
    property DraggingItemLink: TdxBarItemLink read FDraggingItemLink;
    property FocusedBarControl: TCustomdxBarControl read FFocusedBarControl;
    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
    property MainFormActive: Boolean read FMainFormActive;

    function BorderSizeX: Integer;
    function BorderSizeY: Integer;
    property BeforeFingersSize: Integer read FBeforeFingersSize;
    property FingersSize: Integer read FFingersSize;
    property SubMenuBeginGroupIndent: Integer read FSubMenuBeginGroupIndent;
    property GlyphSize: Integer read FGlyphSize;
    property ButtonWidth: Integer read FButtonWidth;
    property ButtonHeight: Integer read FButtonHeight;
    property RealButtonArrowWidth: Integer read FRealButtonArrowWidth;
    property RealLargeButtonArrowWidth: Integer read GetRealLargeButtonArrowWidth;

    function GetLightColor(ABtnFaceColorPart, AHighlightColorPart, AWindowColorPart: Integer): COLORREF;
    property Flat: Boolean read GetFlat;
    property FlatToolbarsBorderBrush: HBRUSH read FFlatToolbarsBorderBrush;
    property FlatToolbarsBrush: HBRUSH read FFlatToolbarsBrush;
    property FlatToolbarsDownedBrush: HBRUSH read FFlatToolbarsDownedBrush;
    property FlatToolbarsDownedSelBrush: HBRUSH read FFlatToolbarsDownedSelBrush;
    property FlatToolbarsSelBrush: HBRUSH read FFlatToolbarsSelBrush;
    property FlatToolbarsBorderColor: COLORREF read GetFlatToolbarsBorderColor;
    property FlatToolbarsColor: COLORREF read GetFlatToolbarsColor;
    property FlatToolbarsDownedColor: COLORREF read GetFlatToolbarsDownedColor;
    property FlatToolbarsDownedSelColor: COLORREF read GetFlatToolbarsDownedSelColor;
    property FlatToolbarsSelColor: COLORREF read GetFlatToolbarsSelColor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function BarByCaption(const ACaption: string): TdxBar;
    function BarByName(const AName: string): TdxBar;
    function GetAllItemsByCategory(ACategory: Integer; List: TList): Integer;
    function GetCountByCategory(ACategory: Integer): Integer;
    function GetItemByCategory(ACategory, AIndex: Integer): TdxBarItem;
    function GetItemByName(const AName: string): TdxBarItem;
    function GetItemsByCategory(ACategory: Integer; List: TList): Integer;

    procedure MoveItem(CurIndex, NewIndex: Integer);
    procedure ExchangeItems(Index1, Index2: Integer);

    procedure CreateToolbarsPopupList(ItemLinks: TdxBarItemLinks);
    procedure Customizing(Show: Boolean);
    procedure HideAll;
    procedure ResetUsageData;
    procedure ResetUsageDataWithConfirmation;
    //procedure WhatIsThis;

    procedure LoadFromRegistry(ARegistryPath: string);
    procedure SaveToRegistry(ARegistryPath: string);
    procedure LoadFromIniFile(AFileName: string);
    procedure SaveToIniFile(AFileName: string);

    function CreateGroup: TdxBarGroup;

    property CategoryItemsVisible[AIndex: Integer]: TdxBarItemVisible
      read GetCategoryItemsVisible write SetCategoryItemsVisible;
    property CategoryVisible[AIndex: Integer]: Boolean read GetCategoryVisible
      write SetCategoryVisible;
    property Designing: Boolean read FDesigning;
    property DockControlCount: Integer read GetDockControlCount;
    property DockControls[Index: Integer]: TdxDockControl read GetDockControl;
    property GroupCount: Integer read GetGroupCount;
    property Groups[Index: Integer]: TdxBarGroup read GetGroup;
    property IsCustomizing: Boolean read GetIsCustomizing;
    property ItemCount: Integer read GetItemCount;
    property Items[Index: Integer]: TdxBarItem read GetItem;
    property LockUpdate: Boolean read FLockUpdate write SetLockUpdate;
    property MainForm: TCustomForm read FMainForm;
    property MainMenuControl: TdxBarControl read GetMainMenuControl;
    property MainMenuBar: TdxBar read FMainMenuBar;
    property Modified: Boolean read FModified write FModified;  // only for Standard style
    property SelectedItem: TdxBarItemControl read FSelectedItem write SetSelectedItem;
  published
    property AllowCallFromAnotherForm: Boolean read FAllowCallFromAnotherForm
      write FAllowCallFromAnotherForm default False;
    property AllowReset: Boolean read FAllowReset write FAllowReset default True;
    property AlwaysMerge: Boolean read FAlwaysMerge write FAlwaysMerge default False;
    property AlwaysSaveText: Boolean read FAlwaysSaveText write FAlwaysSaveText default False;
    property AutoDockColor: Boolean read FAutoDockColor write SetAutoDockColor default True;
    property AutoHideEmptyBars: Boolean read FAutoHideEmptyBars write SetAutoHideEmptyBars default False;
    property Scaled: Boolean read FScaled write SetScaled default True; // must be before Font
    property Font: TFont read FFont write SetFont; // must be before Bars
    property Bars: TdxBars read FBars write SetBars;
    property ButtonArrowWidth: Integer read FButtonArrowWidth write SetButtonArrowWidth
      default dxBarDefaultButtonArrowWidth;
    property CanCustomize: Boolean read FCanCustomize write FCanCustomize default True;
    property Categories: TStrings read FCategories write SetCategories;
    property DockColor: TColor read GetDockColor write SetDockColor stored IsDockColorStored;
    property FlatCloseButton: Boolean read FFlatCloseButton write SetFlatCloseButton default False;
    property HelpButtonGlyph: TBitmap read FHelpButtonGlyph write SetHelpButtonGlyph;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property HideFloatingBarsWhenInactive: Boolean read FHideFloatingBarsWhenInactive
      write SetHideFloatingBarsWhenInactive default True;
    property HotImages: TCurImageList read FHotImages write SetHotImages;
    property ImageListBkColor: TColor read FImageListBkColor write SetImageListBkColor default clFuchsia;
    property Images: TCurImageList read FImages write SetImages;
    property IniFileName: string read FIniFileName write FIniFileName;
    property LargeImages: TCurImageList read FLargeImages write SetLargeImages;
    property LargeButtonArrowWidth: Integer read FLargeButtonArrowWidth write
      SetLargeButtonArrowWidth default dxBarDefaultLargeButtonArrowWidth;
    property LargeIcons: Boolean read FLargeIcons write SetLargeIcons default False;
    property MenuAnimations: TdxBarMenuAnimations read FMenuAnimations
      write SetMenuAnimations default maNone;
    property MenusShowRecentItemsFirst: Boolean read FMenusShowRecentItemsFirst
      write SetMenusShowRecentItemsFirst default True;
    property MostRecentItemsPercents: Byte read FMostRecentItemsPercents
      write SetMostRecentItemsPercents default 95;
    property NotDocking: TdxBarDockingStyles read FNotDocking write FNotDocking default [];
    property PopupMenuLinks: TdxBarPopupMenuLinks read FPopupMenuLinks write SetPopupMenuLinks;
    property RegistryPath: string read FRegistryPath write FRegistryPath;
    property ShowCloseButton: Boolean read FShowCloseButton write SetShowCloseButton default False;
    property ShowFullMenusAfterDelay: Boolean read FShowFullMenusAfterDelay
      write SetShowFullMenusAfterDelay default True;
    property ShowHelpButton: Boolean read FShowHelpButton write SetShowHelpButton default False;
    property ShowHint: Boolean read FShowHint write SetShowHint default True;
    property ShowHintForDisabledItems: Boolean read FShowHintForDisabledItems
      write FShowHintForDisabledItems default True;
    property ShowShortCutInHint: Boolean read FShowShortCutInHint
      write SetShowShortCutInHint default False;
    property StoreInIniFile: Boolean read FStoreInIniFile write FStoreInIniFile default False;
    property StoreInRegistry: Boolean read FStoreInRegistry write FStoreInRegistry default False;
    property StretchGlyphs: Boolean read FStretchGlyphs write FStretchGlyphs default True;
    property Style: TdxBarManagerStyle read FStyle write SetStyle default bmsEnhanced;
    property SunkenBorder: Boolean read FSunkenBorder write SetSunkenBorder default False;
    property UseF10ForMenu: Boolean read FUseF10ForMenu write FUseF10ForMenu default True;
    property UseFullReset: Boolean read FUseFullReset write FUseFullReset default False;
    property UseSystemFont: Boolean read FUseSystemFont write SetUseSystemFont;
    property WaitForDockingTime: Integer read FWaitForDockingTime write SetWaitForDockingTime default 21;

    property OnBarAdd: TdxBarEvent read FOnBarAdd write FOnBarAdd;
    property OnBarAfterReset: TdxBarEvent read FOnBarAfterReset write FOnBarAfterReset;
    property OnBarBeforeReset: TdxBarEvent read FOnBarBeforeReset write FOnBarBeforeReset;
    property OnBarClose: TdxBarEvent read FOnBarClose write FOnBarClose;
    property OnBarDelete: TdxBarEvent read FOnBarDelete write FOnBarDelete;
    property OnBarDockingStyleChange: TdxBarEvent read FOnBarDockingStyleChange
      write FOnBarDockingStyleChange;
    property OnBarVisibleChange: TdxBarVisibleChangeEvent read FOnBarVisibleChange
      write FOnBarVisibleChange;

    property OnItemLinkAdd: TdxBarItemLinkEvent read FOnItemLinkAdd
      write FOnItemLinkAdd;
    property OnItemLinkChange: TdxBarItemLinkEvent read FOnItemLinkChange
      write FOnItemLinkChange;
    property OnItemLinkDelete: TdxBarItemLinkEvent read FOnItemLinkDelete
      write FOnItemLinkDelete;

    property OnCloseButtonClick: TNotifyEvent read FOnCloseButtonClick
      write FOnCloseButtonClick;
    property OnDocking: TdxBarCanDockingEvent read FOnDocking write FOnDocking;
    property OnHelpButtonClick: TNotifyEvent read FOnHelpButtonClick write FOnHelpButtonClick;
    property OnHideCustomizingForm: TNotifyEvent read FOnHideCustomizingForm
      write FOnHideCustomizingForm;
    property OnMenuMerge: TdxBarMenuMergeEvent read FOnMenuMerge write FOnMenuMerge;
    property OnShowCustomizingForm: TNotifyEvent read FOnShowCustomizingForm
      write FOnShowCustomizingForm;
    property OnShowCustomizingPopup: TdxBarShowPopupEvent read FOnShowCustomizingPopup
      write FOnShowCustomizingPopup;
    property OnShowToolbarsPopup: TdxBarShowPopupEvent read FOnShowToolbarsPopup
      write FOnShowToolbarsPopup;

    property OnClickItem: TdxBarClickItemEvent read FOnClickItem write FOnClickItem;
  end;

  TdxBarManagerList = class
  private
    FList: TList;
    function GetBarManager(Index: Integer): TdxBarManager;
    function GetCount: Integer;
    function GetCustomizingBarManager: TdxBarManager;
  public
    constructor Create;
    destructor Destroy; override;
    property BarManagers[Index: Integer]: TdxBarManager read GetBarManager; default;
    property Count: Integer read GetCount;
    property CustomizingBarManager: TdxBarManager read GetCustomizingBarManager;
  end;

  TdxBarBorderStyle = (bbsNone, bbsSingle);

  TdxBar = class(TCollectionItem)
  private
    FAllowClose: Boolean;
    FAllowCustomizing: Boolean;
    FAllowQuickCustomizing: Boolean;
    FAllowReset: Boolean;
    FBars: TdxBars;
    FBorderStyle: TdxBarBorderStyle;
    FCaption: string;
    FChangingDockingStyle: Boolean;
    FDockControl: TdxBarDockControl;
    FDockedDockControl: TdxBarDockControl;
    FDockedDockingStyle: TdxBarDockingStyle;
    FDockedLeft: Integer;
    FDockedTop: Integer;
    FDockingStyle: TdxBarDockingStyle;
    FEditFontHandle: HFONT;
    FFloatLeft: Integer;
    FFloatTop: Integer;
    FFloatClientWidth: Integer;
    FFloatClientHeight: Integer;
    FFont: TFont;
    FFreeNotificationItems: TList;
    FHidden: Boolean;  // if True, then doesn't show in customizing form in run-time
    FInternalFontChange: Boolean;
    FInternallyHidden: Boolean;
    FIsMainMenu: Boolean;
    FIsPredefined: Boolean;
    FItemLinks: TdxBarItemLinks;
    FLoadedDockControl: TdxBarDockControl;
    FLoadedDockingStyle: TdxBarDockingStyle;
    FLoadedVisible: Boolean;
    FLockUpdate: Boolean;
    FName: string;
    FNotDocking: TdxBarDockingStyles;
    FMultiLine: Boolean;
    FOneOnRow: Boolean;
    FRotateWhenVertical: Boolean;
    FRow: Integer;
    FShowMark: Boolean;
    FSizeGrip: Boolean;
    FUseOwnFont: Boolean;
    FUseRecentItems: Boolean;
    FUseRestSpace: Boolean;
    FVisible: Boolean;  // is it currently visible or not?
    FWholeRow: Boolean;

    function GetBarManager: TdxBarManager;
    function GetControl: TdxBarControl;
    function GetDockedDockingStyle: TdxBarDockingStyle;
    function GetDockingStyle: TdxBarDockingStyle;
    function GetRealDockControl: TdxDockControl;
    procedure SetAllowClose(Value: Boolean);
    procedure SetAllowQuickCustomizing(Value: Boolean);
    procedure SetBorderStyle(Value: TdxBarBorderStyle);
    procedure SetCaption(Value: string);
    procedure SetDockControl(Value: TdxBarDockControl);
    procedure SetDockedDockControl(Value: TdxBarDockControl);
    procedure SetDockedValue(Index: Integer; Value: Integer);
    procedure SetDockingStyle(Value: TdxBarDockingStyle);
    procedure SetFloatValue(Index: Integer; Value: Integer);
    procedure SetFont(Value: TFont);
    procedure SetHidden(Value: Boolean);
    procedure SetIsMainMenu(Value: Boolean);
    procedure SetItemLinks(Value: TdxBarItemLinks);
    procedure SetLockUpdate(Value: Boolean);
    procedure SetMultiLine(Value: Boolean);
    procedure SetRotateWhenVertical(Value: Boolean);
    procedure SetRow(Value: Integer);
    procedure SetShowMark(Value: Boolean);
    procedure SetSizeGrip(Value: Boolean);
    procedure SetUseOwnFont(Value: Boolean);
    procedure SetUseRecentItems(Value: Boolean);
    procedure SetUseRestSpace(Value: Boolean);
    procedure SetVisible(Value: Boolean);
    procedure SetWholeRow(Value: Boolean);

    procedure FontChanged(Sender: TObject);
    procedure ItemLinksChanged(Sender: TObject);
    procedure ResetToolbarClick(Sender: TObject);

    function IsDockedDockingStyleStored: Boolean;
    function IsDockingStyleStored: Boolean;
  protected
    procedure AddFreeNotification(AItem: TdxBarItem);
    procedure RemoveFreeNotification(AItem: TdxBarItem);
    procedure MakeFreeNotification;

    function BarNCSizeX(AStyle: TdxBarDockingStyle): Integer;
    function BarNCSizeY(AStyle: TdxBarDockingStyle): Integer;
    function CanClose: Boolean;
    function CanReset: Boolean;
    function HasSizeGrip: Boolean;
    function IsShortCut(AShortCut: TShortCut): Boolean;
    function IsStatusBar: Boolean;
    property Bars: TdxBars read FBars;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ChangeDockingStyle(AStyle: TdxBarDockingStyle;
      ADockControl: TdxDockControl);
    procedure Reset;
    procedure ResetWithConfirmation;

    property BarManager: TdxBarManager read GetBarManager;
    property Control: TdxBarControl read GetControl;
    property IsPredefined: Boolean read FIsPredefined;
    property LockUpdate: Boolean read FLockUpdate write SetLockUpdate;
    property RealDockControl: TdxDockControl read GetRealDockControl;
  published
    property AllowClose: Boolean read FAllowClose write SetAllowClose default True;
    property AllowCustomizing: Boolean read FAllowCustomizing write FAllowCustomizing
      default True;
    property AllowQuickCustomizing: Boolean read FAllowQuickCustomizing
      write SetAllowQuickCustomizing default True;
    property AllowReset: Boolean read FAllowReset write FAllowReset default True;
    property BorderStyle: TdxBarBorderStyle read FBorderStyle write SetBorderStyle
      default bbsSingle;
    property Caption: string read FCaption write SetCaption;
    property DockControl: TdxBarDockControl read FDockControl write SetDockControl;
    property DockedDockControl: TdxBarDockControl read FDockedDockControl
      write SetDockedDockControl;
    property DockedDockingStyle: TdxBarDockingStyle read GetDockedDockingStyle
      write FDockedDockingStyle stored IsDockedDockingStyleStored;
    property DockedLeft: Integer index 1 read FDockedLeft write SetDockedValue;
    property DockedTop: Integer index 2 read FDockedTop write SetDockedValue;
    property DockingStyle: TdxBarDockingStyle read GetDockingStyle write SetDockingStyle
      stored IsDockingStyleStored;
    property FloatLeft: Integer index 1 read FFloatLeft write SetFloatValue;
    property FloatTop: Integer index 2 read FFloatTop write SetFloatValue;
    property FloatClientWidth: Integer index 3 read FFloatClientWidth write SetFloatValue;
    property FloatClientHeight: Integer index 4 read FFloatClientHeight write SetFloatValue;
    property Font: TFont read FFont write SetFont stored FUseOwnFont;
    property Hidden: Boolean read FHidden write SetHidden default False;
    property IsMainMenu: Boolean read FIsMainMenu write SetIsMainMenu default False;
    property ItemLinks: TdxBarItemLinks read FItemLinks write SetItemLinks;
    property MultiLine: Boolean read FMultiLine write SetMultiLine default False;
    property Name: string read FName write FName;
    property NotDocking: TdxBarDockingStyles read FNotDocking write FNotDocking default [];
    property OneOnRow: Boolean read FOneOnRow write FOneOnRow;
    property RotateWhenVertical: Boolean read FRotateWhenVertical write SetRotateWhenVertical
      default True;
    property Row: Integer read FRow write SetRow;
    property ShowMark: Boolean read FShowMark write SetShowMark default True;
    property SizeGrip: Boolean read FSizeGrip write SetSizeGrip default True;
    property UseOwnFont: Boolean read FUseOwnFont write SetUseOwnFont;
    property UseRecentItems: Boolean read FUseRecentItems write SetUseRecentItems default True;
    property UseRestSpace: Boolean read FUseRestSpace write SetUseRestSpace default False;
    property Visible: Boolean read FVisible write SetVisible;
    property WholeRow: Boolean read FWholeRow write SetWholeRow;
  end;

  TdxDockControls = array[dsLeft..dsBottom] of TdxDockControl;

  TdxBars = class(TCollection)
  private
    FDockControls: TdxDockControls;
    FDocking: Boolean;
    FDockingZoneSize: Integer;
    FBarManager: TdxBarManager;
    FLoading: Boolean;
    FMoving: Boolean;
    FMovingBarControl: TdxBarControl;
    FMovingBarOriginalDockingStyle: TdxBarDockingStyle;
    FMovingOffset: TPoint;
    FMovingStaticOffset: TPoint;

    function GetDockControl(Index: TdxBarDockingStyle): TdxDockControl;
    function GetItem(Index: Integer): TdxBar;
    procedure SetItem(Index: Integer; Value: TdxBar);
  protected
    function GetOwner: TPersistent; override;

    procedure RegInDock(AStyle: TdxBarDockingStyle; ADockControl: TdxDockControl;
      ABarControl: TdxBarControl; APos: TPoint);
    procedure UnregFromDock(AStyle: TdxBarDockingStyle;
      ADockControl: TdxDockControl; ABarControl: TdxBarControl);

    procedure ChangeBarControlPos(ABarControl: TdxBarControl; APos: TPoint);
    function GetDockingStyleAtPos(Bar: TdxBar; Pos: TPoint;
      var DockControl: TdxDockControl): TdxBarDockingStyle;
    procedure Moving(AMovingBarControl: TdxBarControl);
    procedure Update(Item: TCollectionItem); override;

    property DockingZoneSize: Integer read FDockingZoneSize write FDockingZoneSize;
  public
    constructor Create(ABarManager: TdxBarManager);
    destructor Destroy; override;
    function Add: TdxBar;
    function GetUniqueToolbarName(const BaseName: string): string;

    property BarManager: TdxBarManager read FBarManager;
    property DockControls[Index: TdxBarDockingStyle]: TdxDockControl read GetDockControl;
    property IsLoading: Boolean read FLoading write FLoading;
    property IsMoving: Boolean read FMoving;
    property Items[Index: Integer]: TdxBar read GetItem write SetItem; default;
  end;

  TdxBarUserDefine = (udCaption, udGlyph, udPaintStyle, udWidth);
  TdxBarUserDefines = set of TdxBarUserDefine;

  TdxBarPaintStyle = (psStandard, psCaption, psCaptionInMenu, psCaptionGlyph);

  TdxBarItemLink = class(TCollectionItem)
  private
    FBeginGroup: Boolean;
    FControl: TdxBarItemControl;
    FData: Integer;
    FItem: TdxBarItem;
    FItemRect: TRect;
    FLoadedRecentIndex: Integer;
    FLoadedUseCount: Integer;
    FLoadedVisible: Boolean;
    FMostRecentlyUsed: Boolean;
    FOriginalItemLink: TdxBarItemLink;
    FPrevRecentIndex: Integer;
    FRowHeight: Integer;
    FUseCount: Integer;
    FUserCaption: string;
    FUserDefine: TdxBarUserDefines;
    FUserGlyph: TBitmap;
    FUserPaintStyle: TdxBarPaintStyle;
    FUserWidth: Integer;
    FVisible: Boolean;

    function GetAvailableIndex: Integer;
    function GetBarControl: TCustomdxBarControl;
    function GetBarManager: TdxBarManager;
    function GetBeginGroup: Boolean;
    function GetCanVisibleIndex: Integer;
    function GetCaption: string;
    function GetGlyph: TBitmap;
    function GetOwnerValue: TdxBarItemLinks;
    function GetPaintStyle: TdxBarPaintStyle;
    function GetVisibleIndex: Integer;
    function GetWidth: Integer;
    procedure SetBeginGroup(Value: Boolean);
    procedure SetItem(Value: TdxBarItem);
    procedure SetMostRecentlyUsed(Value: Boolean);
    procedure SetUserCaption(Value: string);
    procedure SetUserDefine(Value: TdxBarUserDefines);
    procedure SetUserGlyph(Value: TBitmap);
    procedure SetUserPaintStyle(Value: TdxBarPaintStyle);
    procedure SetUserWidth(Value: Integer);
    procedure SetVisible(Value: Boolean);

    procedure AddToRecentList;
    procedure RemoveFromRecentList;
    procedure RestoreRecentIndex;
    procedure SaveRecentIndex;
    procedure InternalBringToTopInRecentList(IncCount: Boolean);
    procedure Synchronize(AItemLink: TdxBarItemLink);
    procedure CheckMostRecentlyUsed;
    function GetRecentIndex: Integer;
    procedure SetRecentIndex(Value: Integer);
    property RecentIndex: Integer read GetRecentIndex write SetRecentIndex;

    function CanVisible: Boolean;
    function GetRealItemLink: TdxBarItemLink;
  protected
    function HasItem(AItem: TdxBarItem): Boolean;
  {$IFDEF DELPHI4}
    procedure InitiateAction;
  {$ENDIF}
    function IsAccel(Key: Word; Shift: TShiftState): Boolean;
    procedure ItemLinkChanged;

    property RowHeight: Integer read FRowHeight write FRowHeight;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure BringToTopInRecentList(IncCount: Boolean);
    procedure CreateControl;
    procedure DestroyControl;
    procedure SendToBottomInRecentList;

    property AvailableIndex: Integer read GetAvailableIndex;
    property BarControl: TCustomdxBarControl read GetBarControl;
    property BarManager: TdxBarManager read GetBarManager;
    property CanVisibleIndex: Integer read GetCanVisibleIndex;
    property Caption: string read GetCaption;
    property Control: TdxBarItemControl read FControl;
    property Data: Integer read FData write FData default 0;
    property Glyph: TBitmap read GetGlyph;
    property ItemRect: TRect read FItemRect write FItemRect;
    property OriginalItemLink: TdxBarItemLink read FOriginalItemLink;
    property Owner: TdxBarItemLinks read GetOwnerValue;
    property PaintStyle: TdxBarPaintStyle read GetPaintStyle;
    property RealItemLink: TdxBarItemLink read GetRealItemLink;
    property VisibleIndex: Integer read GetVisibleIndex;
    property Width: Integer read GetWidth;
  published
    property BeginGroup: Boolean read GetBeginGroup write SetBeginGroup default False;
    property Item: TdxBarItem read FItem write SetItem;
    property MostRecentlyUsed: Boolean read FMostRecentlyUsed
      write SetMostRecentlyUsed default True;
    property UserCaption: string read FUserCaption write SetUserCaption;
    property UserDefine: TdxBarUserDefines read FUserDefine write SetUserDefine default [];
    property UserGlyph: TBitmap read FUserGlyph write SetUserGlyph;
    property UserPaintStyle: TdxBarPaintStyle read FUserPaintStyle
      write SetUserPaintStyle default psStandard;
    property UserWidth: Integer read FUserWidth write SetUserWidth default 0;
    property Visible: Boolean read FVisible write SetVisible;
  end;

  TdxBarIterationProc = procedure(Index: Integer; ItemLink: TdxBarItemLink;
    var Stop: Boolean; var Data: Pointer) of object;

  TdxBarItemLinks = class(TCollection)
  private
    FAssigning: Boolean;
    FAvailableItems, FCanVisibleItems, FVisibleItems: TList;
    FBarControl: TCustomdxBarControl;
    FBarManager: TdxBarManager;
    FOwner: TObject;
    FPrevRecentItemCount: Integer;
    FRecentItems: TList;
    FRecentItemCount: Integer;
    FUseRecentItems: Boolean;
    FOnChange: TNotifyEvent;

    function GetAvailableItem(Index: Integer): TdxBarItemLink;
    function GetAvailableItemCount: Integer;
    function GetCanVisibleItem(Index: Integer): TdxBarItemLink;
    function GetCanVisibleItemCount: Integer;
    function GetItem(Index: Integer): TdxBarItemLink;
    function GetMostRecentItemCount: Integer;
    function GetRealVisibleItemCount: Integer;
    function GetVisibleItem(Index: Integer): TdxBarItemLink;
    function GetVisibleItemCount: Integer;
    procedure SetItem(Index: Integer; Value: TdxBarItemLink);
    procedure SetRecentItemCount(Value: Integer);

    procedure RefreshVisibilityLists;
    property MostRecentItemCount: Integer read GetMostRecentItemCount;
    procedure RestoreRecentItemCount;
    property RecentItemCount: Integer read FRecentItemCount write SetRecentItemCount;

    procedure EmptyItemRects;
    procedure Loaded(CheckVisible: Boolean);
    procedure CheckVisibleIntegrity;
    procedure AssignUsageData(AItemLinks: TdxBarItemLinks);
  protected
    function CanUseRecentItems: Boolean;
  {$IFDEF DELPHI4}
    procedure InitiateActions;
  {$ENDIF}
    function IsDesignTimeLinks: Boolean;
    function IsShortCut(AShortCut: TShortCut): Boolean;

    function FindItemWithAccel(Key: Word; Shift: TShiftState; Current: TdxBarItemLink): TdxBarItemLink;
    function First: TdxBarItemLink;
    function Last: TdxBarItemLink;
    function Next(Current: TdxBarItemLink): TdxBarItemLink;
    function Prev(Current: TdxBarItemLink): TdxBarItemLink;

    procedure Update(Item: TCollectionItem); override;

    property RealVisibleItemCount: Integer read GetRealVisibleItemCount;
  public
    constructor Create(ABarManager: TdxBarManager);
    destructor Destroy; override;
    function Add: TdxBarItemLink;
    procedure Assign(Source: TPersistent); override;
    function AvailableIndexOf(Value: TdxBarItemLink): Integer;
    function CanVisibleIndexOf(Value: TdxBarItemLink): Integer;
    procedure CreateBarControl;
    procedure FreeForeignItems(ForeignBarManager: TdxBarManager);
    function HasItem(AItem: TdxBarItem): Boolean;
    function IndexOf(Value: TdxBarItemLink): Integer;
    function VisibleIndexOf(Value: TdxBarItemLink): Integer;

    property AvailableItems[Index: Integer]: TdxBarItemLink read GetAvailableItem;
    property AvailableItemCount: Integer read GetAvailableItemCount;
    property BarControl: TCustomdxBarControl read FBarControl write FBarControl;
    property BarManager: TdxBarManager read FBarManager;
    property CanVisibleItems[Index: Integer]: TdxBarItemLink read GetCanVisibleItem;
    property CanVisibleItemCount: Integer read GetCanVisibleItemCount;
    property Items[Index: Integer]: TdxBarItemLink read GetItem write SetItem; default;
  {$WARNINGS OFF}
    property Owner: TObject read FOwner;  // TdxBar, TdxBarPopupMenu, TCustomdxBarSubItem, nil
  {$WARNINGS ON}
    property VisibleItems[Index: Integer]: TdxBarItemLink read GetVisibleItem;
    property VisibleItemCount: Integer read GetVisibleItemCount;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TdxBarPaintSubMenuBarEvent = procedure(Sender: TObject;
    Canvas: TCanvas; const R: TRect) of object;

  TdxBarPopupMenu = class(TComponent)
  private
    DontUseMessageLoop: Boolean;
    FBarManager: TdxBarManager;
    FBarSize: Integer;
    FEditFontHandle: HFONT;
    FFont: TFont;
    FInternalFontChange: Boolean;
    FItemLinks: TdxBarItemLinks;
    FOwnerBounds: PRect;
    FOwnerWidth, FOwnerHeight: Integer;
    FPopupMenuVisible: Boolean;
    FShowAnimation: Boolean;
    FUseOwnFont: Boolean;
    FUseRecentItems: Boolean;
    FOnCloseUp: TNotifyEvent;
    FOnPaintBar: TdxBarPaintSubMenuBarEvent;
    FOnPopup: TNotifyEvent;

    function GetSubMenuControl: TdxBarSubMenuControl;
    procedure SetBarManager(Value: TdxBarManager);
    procedure SetBarSize(Value: Integer);
    procedure SetFont(Value: TFont);
    procedure SetItemLinks(Value: TdxBarItemLinks);
    procedure SetUseOwnFont(Value: Boolean);
    procedure SetUseRecentItems(Value: Boolean);

    procedure FontChanged(Sender: TObject);
    procedure SubMenuCloseUp(Sender: TObject);
    procedure SubMenuPopup(Sender: TObject);
    procedure OwnerDesignerModified;
  protected
    procedure DoPaintBar(Canvas: TCanvas; const R: TRect); virtual;
    function IsShortCut(AShortCut: TShortCut): Boolean;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Popup(X, Y: Integer);
    procedure PopupEx(X, Y, AOwnerWidth, AOwnerHeight: Integer;
      AShowAnimation: Boolean; AOwnerBounds: PRect);
    procedure PopupFromCursorPos;
    property SubMenuControl: TdxBarSubMenuControl read GetSubMenuControl;
  published
    property BarManager: TdxBarManager read FBarManager write SetBarManager;
    property BarSize: Integer read FBarSize write SetBarSize default 0;
    property Font: TFont read FFont write SetFont stored FUseOwnFont;
    property ItemLinks: TdxBarItemLinks read FItemLinks write SetItemLinks;
    property UseOwnFont: Boolean read FUseOwnFont write SetUseOwnFont;
    property UseRecentItems: Boolean read FUseRecentItems write SetUseRecentItems default False;

    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property OnPaintBar: TdxBarPaintSubMenuBarEvent read FOnPaintBar write FOnPaintBar;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
  end;

  {-----------------------
      Visual components
   -----------------------}

  { dock controls }  

  TdxDockControl = class(TCustomControl)
  private
    FAllowDocking: Boolean;
    FBarManager: TdxBarManager;
    FDockingStyle: TdxBarDockingStyle;
    FRowList: TList;
    FRowMarginSize: Integer;

    function GetBars: TdxBars;
    function GetDockingStyle: TdxBarDockingStyle;
    function GetHorizontal: Boolean;
    function GetIsDesigning: Boolean;
    function GetIsLoading: Boolean;
    function GetMain: Boolean;
    function GetRow(Index: Integer): TdxDockRow;
    function GetRowCount: Integer;
    function GetTopLeft: Boolean;
    function GetVertical: Boolean;
    procedure SetBarManager(Value: TdxBarManager);

    procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RequestAlign; override;
    procedure WndProc(var Message: TMessage); override;

    procedure AddBarControl(ABarControl: TdxBarControl; APos: TPoint; Update: Boolean);
    procedure DeleteBarControl(ABarControl: TdxBarControl; ADockCol: Pointer; Update: Boolean);
    procedure MoveBarControl(ABarControl: TdxBarControl; APos: TPoint);

    procedure AssignPositions;
    procedure BarManagerChanged; virtual;
    function CanDocking(Bar: TdxBar): Boolean; virtual;
    procedure ColorChanged; virtual;
    function GetDockZoneBounds: TRect;
    procedure GetDockZoneMargins(Row, ZoneNumber: Integer; var M1, M2: Integer);
    function GetRectForRow(ARow: Integer): TRect;
    function GetClientSize: Integer; virtual;
    function GetSize: Integer;
    function GetRowAtPos(APos: TPoint; var Insert: Boolean): Integer;
    function GetColAtPos(ARow: Integer; APos: TPoint): Integer;
    procedure GetPosForRow(Row: Integer; OneOnRow: Boolean; var P: TPoint);
    function GetSunkenBorder: Boolean; virtual;
    procedure NCChanged;
    procedure PaintBarControls;
    procedure SetSize;
    procedure UpdateDock;

    property AllowDocking: Boolean read FAllowDocking write FAllowDocking default True;
    property Horizontal: Boolean read GetHorizontal;
    property IsDesigning: Boolean read GetIsDesigning;
    property IsLoading: Boolean read GetIsLoading;
    property Main: Boolean read GetMain;
    property RowMarginSize: Integer read FRowMarginSize write FRowMarginSize;
    property SunkenBorder: Boolean read GetSunkenBorder;
    property TopLeft: Boolean read GetTopLeft;
    property Vertical: Boolean read GetVertical;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateEx(AOwner: TComponent; ABarManager: TdxBarManager;
      ADockStyle: TdxBarDockingStyle);
    destructor Destroy; override;
  {$IFDEF DELPHI4}
    procedure InitiateAction; override;
  {$ENDIF}

    property BarManager: TdxBarManager read FBarManager write SetBarManager;
    property Bars: TdxBars read GetBars;
    property DockingStyle: TdxBarDockingStyle read GetDockingStyle;
    property RowCount: Integer read GetRowCount;
    property RowList: TList read FRowList;
    property Rows[Index: Integer]: TdxDockRow read GetRow;
  end;

  TdxBarDockAlign = (dalNone, dalTop, dalBottom, dalLeft, dalRight);

  TdxBarDockControl = class(TdxDockControl)
  private
    FAllowZeroSizeInDesignTime: Boolean;
    FSunkenBorder: Boolean;
    FUseOwnColor: Boolean;
    FUseOwnSunkenBorder: Boolean;
    function GetAlign: TdxBarDockAlign;
    function GetColor: TColor;
    function GetIsLoading: Boolean;
    function GetParentColor: Boolean;
    procedure SetAlign(Value: TdxBarDockAlign);
    procedure SetAllowZeroSizeInDesignTime(Value: Boolean);
    procedure SetColor(Value: TColor);
    procedure SetParentColor(Value: Boolean);
    procedure SetSunkenBorder(Value: Boolean);
    procedure SetUseOwnColor(Value: Boolean);
    procedure SetUseOwnSunkenBorder(Value: Boolean);
    function IsColorStored: Boolean;
    procedure WMCreate(var Message: TWMCreate); message WM_CREATE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure BarManagerChanged; override;
    function CanDocking(Bar: TdxBar): Boolean; override;
    procedure ColorChanged; override;
    function GetClientSize: Integer; override;
    function GetMinSize: Integer;
    function GetSunkenBorder: Boolean; override;
    property IsLoading: Boolean read GetIsLoading;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align: TdxBarDockAlign read GetAlign write SetAlign;
    property AllowDocking;
    property AllowZeroSizeInDesignTime: Boolean read FAllowZeroSizeInDesignTime
      write SetAllowZeroSizeInDesignTime default False;
  {$IFDEF DELPHI4}
    property Anchors;
  {$ENDIF}
    property BarManager;
    property Color read GetColor write SetColor stored IsColorStored;
    property ParentColor: Boolean read GetParentColor write SetParentColor
      stored IsColorStored;
    property SunkenBorder: Boolean read GetSunkenBorder write SetSunkenBorder
      stored FUseOwnSunkenBorder;
    property UseOwnColor: Boolean read FUseOwnColor write SetUseOwnColor default False;
    property UseOwnSunkenBorder: Boolean read FUseOwnSunkenBorder
      write SetUseOwnSunkenBorder default False;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  {$IFDEF DELPHI4}
    property OnResize;
  {$ENDIF}
  end;

  { shadow support }

  TdxBarShadowCorner = (scLeft, scRight, scTop);
  TdxBarShadowCorners = set of TdxBarShadowCorner;

  TdxBarShadowPartKind = (spHorizontal, spVertical);

  TdxBarShadowPart = class(TCustomControl)
  private
    FCorners: TdxBarShadowCorners;
    FImage: TBitmap;
    FKind: TdxBarShadowPartKind;
    FOwner: TdxBarShadow;
    function GetControl: TWinControl;
    function GetShadowSize: Integer;
    function GetTransparent: Boolean;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    function CanShow: Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure UpdateImage;
    property Control: TWinControl read GetControl;
    property Image: TBitmap read FImage;
    property Owner: TdxBarShadow read FOwner;
    property ShadowSize: Integer read GetShadowSize;
    property Transparent: Boolean read GetTransparent;
  public
    constructor CreateEx(AOwner: TdxBarShadow;
      AKind: TdxBarShadowPartKind; ACorners: TdxBarShadowCorners);
    destructor Destroy; override;
    procedure Hide;
    procedure Show;
    procedure UpdateBounds(const ABounds: TRect);
    property Corners: TdxBarShadowCorners read FCorners;
    property Kind: TdxBarShadowPartKind read FKind;
  end;

  TdxBarShadow = class
  private
    FHorizontal: Boolean;
    FOwner: TWinControl;
    FParts: array[0..4] of TdxBarShadowPart;
    FVisible: Boolean;
    function GetShadowSize: Integer;
    function GetTransparent: Boolean;
    procedure SetVisible(Value: Boolean);
  protected
    R1, R2: TRect;
    procedure CreateParts;
    procedure DestroyParts;
    procedure Hide;
    procedure Show;
    property Transparent: Boolean read GetTransparent;
  public
    constructor Create(AOwner: TWinControl);
    destructor Destroy; override;
    procedure Refresh;
    procedure SetOwnerBounds(AR1, AR2: TRect);
    property Horizontal: Boolean read FHorizontal;
    property Owner: TWinControl read FOwner;
    property ShadowSize: Integer read GetShadowSize;
    property Visible: Boolean read FVisible write SetVisible;
  end;

  { TCustomdxBarControl }

  TdxBarMarkState = (msNone, msSelected, msPressed);

  TCustomdxBarControl = class(TCustomControl)
  private
    FBkBrush: HBRUSH;
    FChildBar: TCustomdxBarControl;
    FClickedControl: TdxBarItemControl;
    FDestroyFlag: Boolean;
    FDockControl: TdxDockControl;
    FDockingStyle: TdxBarDockingStyle;
    FDragDown: Boolean;
    FDragPoint: TPoint;
    FIgnoreMouseClick: Boolean;
    FIsActive: Boolean;
    FItemLinks: TdxBarItemLinks;
    FMarkState: TdxBarMarkState;
    FMouseOverClickedControl: Boolean;
    FMovingChanging: Boolean;
    FOwnerBounds: TRect;
    FParentBar: TCustomdxBarControl;
    FPrevActiveBarControl: TCustomdxBarControl;
    FSelectedItem: TdxBarItemControl;
    FShadow: TdxBarShadow;

    FTextSize, FEditTextSize: Integer;
    FMenuArrowHeight, FMenuArrowWidth: Integer;
    FComboBoxArrowWidth: Integer;

    function GetBarControlOwnerBrush: HBRUSH;
    function GetBarManager: TdxBarManager;
    function GetFlat: Boolean;
    function GetIsDestroying: Boolean;
    function GetOwnerLinkBounds(AOwnerPart: Boolean): TRect;

    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMMouseLeave(var Message: TMessage); message WM_MOUSELEAVE;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRepaintBar(var Message: TMessage); message WM_REPAINTBAR;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
  protected
    FLastMousePos: TPoint;

  {$IFDEF DELPHI4}
    procedure AdjustSize; override;
  {$ENDIF}
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWindowHandle; override;
    procedure CreateControls; virtual;
    procedure DestroyControls; virtual;
    procedure WndProc(var Message: TMessage); override;

    procedure BeforeDestroyHandle;
    procedure CalcDrawingConsts; virtual;
    function CanAlignControl(AControl: TdxBarItemControl): Boolean; virtual;
    function CanCallInheritedNCCalcSize: Boolean; virtual;
    //function CanCallInheritedNCPaint: Boolean; virtual;
    function CanCustomizing: Boolean; virtual;
    function CanFinishMouseTracking(const Message: TWMNCHitTest): Boolean; dynamic;
    function ChildrenHaveShadows: Boolean; virtual;
    procedure DblClickOnItem(Item: TdxBarItemControl); dynamic;
    procedure DrawBarControlOwner(DC: HDC; R: TRect; ABarControl: TCustomdxBarControl);
    procedure DrawBarControlOwnerBorder(DC: HDC; R: TRect; ABarControl: TCustomdxBarControl);
    procedure DrawOwnerLink(DC: HDC);
    procedure DrawSelectedItem(AControl: TdxBarItemControl);
    function GetBeginGroupSize: Integer; virtual; abstract;
    function GetEditFontHandle: HFONT; virtual;
    function GetFullItemRect(Item: TdxBarItemControl): TRect; virtual;
    function GetIsCustomizing: Boolean; virtual;
    function GetIsShadowVisible: Boolean; virtual;
    function GetItemRectEx(Item: TdxBarItemControl; IsBeginGroup: Boolean): TRect; virtual;
    function GetItemRegion(Item: TdxBarItemControl): HRGN; virtual;
    function GetItemScreenRect(Item: TdxBarItemControl): TRect;
    function GetToolbarBrush: HBRUSH; virtual;
    function GetToolbarDownedBrush: HBRUSH; virtual;
    function GetToolbarDownedSelBrush: HBRUSH; virtual;
    function GetToolbarSelBrush: HBRUSH; virtual;
    procedure GetWindowRect(var R: TRect);
    function HasShadow: Boolean;
    function HideOnClick: Boolean; virtual;
    function IsChildBar(Value: TCustomdxBarControl): Boolean; virtual;
    function IsLinkedToOwner: Boolean;
    function ItemAtPosEx(Pos: TPoint;
      var IsBeginGroup, IsFirstPart, IsVerticalDirection: Boolean): TdxBarItemControl; virtual;
    function ItemExists(Item: TdxBarItemControl): Boolean;
    function MarkExists: Boolean; virtual;
    function NotHandleMouseMove(P: TPoint): Boolean; virtual;
    procedure PaintItem(AControl: TdxBarItemControl); virtual;
    procedure PaintSelectedItem(OldSelectedItem: TdxBarItemControl); virtual;
    procedure ResizeShadow;
    function SelectedItemWantsKey(Key: Word): Boolean;
    procedure SetCursorForMoving(AMoving: Boolean);
    procedure SetDockingStyle(Value: TdxBarDockingStyle); virtual;
    procedure SetFont; virtual; abstract;
    procedure SetIsActive(Value: Boolean); virtual;
    procedure SetKeySelectedItem(Value: TdxBarItemControl); virtual;
    procedure SetMarkState(Value: TdxBarMarkState); virtual; abstract;
    procedure SetMouseSelectedItem(Value: TdxBarItemControl); virtual;
    procedure SetSelectedItem(Value: TdxBarItemControl); virtual;
    procedure UpdateControlStyle;
    function WantMouse: Boolean;

    property ChildBar: TCustomdxBarControl read FChildBar write FChildBar;
    property DockControl: TdxDockControl read FDockControl write FDockControl;
    property DockingStyle: TdxBarDockingStyle read FDockingStyle write SetDockingStyle;
    property Flat: Boolean read GetFlat;
    property IsDestroying: Boolean read GetIsDestroying;
    property IsShadowVisible: Boolean read GetIsShadowVisible;
    property MarkState: TdxBarMarkState read FMarkState write SetMarkState;
    property ParentBar: TCustomdxBarControl read FParentBar write FParentBar;
    property SelectedItem: TdxBarItemControl read FSelectedItem write SetSelectedItem;
    property Shadow: TdxBarShadow read FShadow;

    property BeginGroupSize: Integer read GetBeginGroupSize;
    property OwnerBounds: TRect read FOwnerBounds write FOwnerBounds;
    property OwnerLinkBounds[AOwnerPart: Boolean]: TRect read GetOwnerLinkBounds;

    property BarControlOwnerBrush: HBRUSH read GetBarControlOwnerBrush;
    property ToolbarBrush: HBRUSH read GetToolbarBrush;
    property ToolbarDownedBrush: HBRUSH read GetToolbarDownedBrush;
    property ToolbarDownedSelBrush: HBRUSH read GetToolbarDownedSelBrush;
    property ToolbarSelBrush: HBRUSH read GetToolbarSelBrush;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetItemRect(Item: TdxBarItemControl): TRect;
    procedure HideAll; virtual;
    function ItemAtPos(Pos: TPoint): TdxBarItemControl;
    procedure RepaintBar; virtual;

    property BarManager: TdxBarManager read GetBarManager;
    property BkBrush: HBRUSH read FBkBrush;
    property Canvas;
    property ComboBoxArrowWidth: Integer read FComboBoxArrowWidth;
    property EditFontHandle: HFONT read GetEditFontHandle;
    property EditTextSize: Integer read FEditTextSize;
    property Font;
    property IsActive: Boolean read FIsActive write SetIsActive;
    property IsCustomizing: Boolean read GetIsCustomizing;
    property ItemLinks: TdxBarItemLinks read FItemLinks write FItemLinks;
    property MenuArrowHeight: Integer read FMenuArrowHeight;
    property MenuArrowWidth: Integer read FMenuArrowWidth;
    property TextSize: Integer read FTextSize;
  end;

  { TdxBarControl }

  TdxDockCol = class
  private
    FBarControl: TdxBarControl;
    FDockRow: TdxDockRow;
    FPos: TPoint;
  public
    constructor Create(ADockRow: TdxDockRow; ABarControl: TdxBarControl);
    procedure AssignPosition;
    property BarControl: TdxBarControl read FBarControl;
    property DockRow: TdxDockRow read FDockRow;
    property Pos: TPoint read FPos write FPos;
  end;

  TdxDockRow = class
  protected
    FColList: TList;
    FDockControl: TdxDockControl;
    function GetCol(Index: Integer): TdxDockCol;
    function GetColCount: Integer;
  public
    constructor Create(ADockControl: TdxDockControl);
    destructor Destroy; override;
    property ColCount: Integer read GetColCount;
    property ColList: TList read FColList;
    property Cols[Index: Integer]: TdxDockCol read GetCol;
    property DockControl: TdxDockControl read FDockControl;
  end;

  TdxBarMDIButton = (mdibMinimize, mdibRestore, mdibClose);

  TdxBarControl = class(TCustomdxBarControl)
  private
    BeforeBarGetFocusFocusedWnd: HWND;
    FBar: TdxBar;
    FCloseButtonState: TdxBarMarkState;
    FDockedHandle, FFloatingHandle: HWND;
    FEditSizingCursor, FRightBorderSizing: Boolean;
    FHasCaption: Boolean;
    FHasSizeGrip: Boolean;
    FHitTest: Longint;
    FInternalLockCount: Integer;
    FIsDowned: Boolean;
    FMDIButtonWidth, FMDIButtonHeight: Integer;
    FMinSize, FMaxSize: Integer;
    FMoreButtonsHintTimer: UINT;
    FMoving: Boolean;
    FSettingFont: Boolean;
    FSizingEditWidth: Integer;
    FTruncated: Boolean;
    FQuickPopup: TdxBarControl;
    NewLeft, NewTop, NewWidth, NewHeight: Integer;
    RX, RY: TPoint;

    function GetCaptionBkColor: Integer;
    function GetHorizontal: Boolean;
    function GetInternallyLocked: Boolean;
    function GetMultiLine: Boolean;
    function GetVertical: Boolean;
    procedure SetCloseButtonState(Value: TdxBarMarkState);
    procedure SetMoving(Value: Boolean);

    procedure CalcControlsPositions;
    procedure ChangeStyleWinTo(AStyle: TdxBarDockingStyle;
      ADockControl: TdxDockControl);
    procedure DrawEditSizingFrame(AWidth: Integer);
    function GetDragPointOffset(Style: TdxBarDockingStyle): TPoint;
    function GetCaptionNCRect: TRect;
    function GetCaptionRect: TRect;
    procedure DrawCaptionElement(DC: HDC; R: TRect; AState: TdxBarMarkState);
    procedure DrawCloseButton(DC: HDC);
    procedure DrawMark(DC: HDC);

    procedure DrawMDIButton(AButton: TdxBarMDIButton; APressed: Boolean);
    function GetMDIWidth: Integer;
    function GetMDIHeight: Integer;
    function RectMDI(Button: TdxBarMDIButton): TRect;
    function RealMDIButtonsOnBar: Boolean;
    function MDIButtonsOnBar: Boolean;
    function MDIButtonEnabled(AButton: TdxBarMDIButton; State: Integer): Boolean;

    procedure StartMoreButtonsHintTimer;
    procedure FinishMoreButtonsHintTimer;

    procedure CheckMarkState(const P: TPoint);

    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinmaxInfo); message WM_GETMINMAXINFO;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMMouseLeave(var Message: TMessage); message WM_MOUSELEAVE;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMSizing(var Message: TMessage); message WM_SIZING;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;

    procedure BeginInternal;
    procedure EndInternal;
    property InternallyLocked: Boolean read GetInternallyLocked;

    procedure CalcDrawingConsts; override;
    function CanAlignControl(AControl: TdxBarItemControl): Boolean; override;
    function CanCallInheritedNCCalcSize: Boolean; override;
    function CanCustomizing: Boolean; override;
    function CanFinishMouseTracking(const Message: TWMNCHitTest): Boolean; override;
    function CloseButtonRect: TRect;
    function CloseButtonRectNC: TRect;
    function GetBeginGroupSize: Integer; override;
    function GetCol: Integer;
    function GetDockCol: TdxDockCol;
    function GetRow: Integer;
    function GetMinWidth(AStyle: TdxBarDockingStyle): Integer;
    function GetMinHeight(AStyle: TdxBarDockingStyle): Integer;
    function GetMaxWidth(AStyle: TdxBarDockingStyle): Integer;
    function GetMaxHeight(AStyle: TdxBarDockingStyle): Integer;
    procedure GetMultiLineBarSize(AStyle: TdxBarDockingStyle;
      ASize: Integer; var Result: TPoint);
    function GetSizeAllCursorBounds: TRect; virtual;
    function GetSizeForWidth(AStyle: TdxBarDockingStyle; AWidth: Integer): TPoint;
    function GetSizeForHeight(AStyle: TdxBarDockingStyle; AHeight: Integer): TPoint;
    function GetTrackSize(AStyle: TdxBarDockingStyle): TPoint;
    procedure InvalidateMark;
    function MarkExists: Boolean; override;
    function MarkNCRect: TRect;
    function MarkRect: TRect;
    function MarkScreenRect: TRect;
    function SizeGripRect: TRect;

    procedure BarManagerStyleChanged;
    procedure CaptionChanged; virtual;
    procedure FrameChanged;
    function GetEditFontHandle: HFONT; override;
    function GetFullItemRect(Item: TdxBarItemControl): TRect; override;
    function GetItemRegion(Item: TdxBarItemControl): HRGN; override;
    function GetToolbarBrush: HBRUSH; override;
    function ItemAtPosEx(Pos: TPoint;
      var IsBeginGroup, IsFirstPart, IsVerticalDirection: Boolean): TdxBarItemControl; override;
    function NotHandleMouseMove(P: TPoint): Boolean; override;
    procedure PaintItem(AControl: TdxBarItemControl); override;
    procedure RebuildBar;
    procedure RefreshShadow;
    procedure SavePos;
    procedure SetFont; override;
    procedure SetIsActive(Value: Boolean); override;
    procedure SetDockingStyle(Value: TdxBarDockingStyle); override;
    procedure SetKeySelectedItem(Value: TdxBarItemControl); override;
    procedure SetMarkState(Value: TdxBarMarkState); override;

    property CaptionBkColor: Integer read GetCaptionBkColor;
    property CloseButtonState: TdxBarMarkState read FCloseButtonState
      write SetCloseButtonState;

    property Horizontal: Boolean read GetHorizontal;
    property IsDowned: Boolean read FIsDowned write FIsDowned;
    property Moving: Boolean read FMoving write SetMoving;
    property MultiLine: Boolean read GetMultiLine;
    property Vertical: Boolean read GetVertical;

    property MDIButtonWidth: Integer read FMDIButtonWidth;
    property MDIButtonHeight: Integer read FMDIButtonHeight;
  public
    constructor CreateEx(AOwner: TComponent; ABar: TdxBar); virtual;
    destructor Destroy; override;
    procedure BarGetFocus(ASelectedItem: TdxBarItemControl); virtual;
    procedure BarLostFocus; virtual;
    procedure HideAll; override;
    procedure Repaint; override;
    procedure RepaintBar; override;
    property Bar: TdxBar read FBar;
  end;

  { TdxBarSubMenuControl }

  TdxBarButtonControl = class;
  TdxBarSubItemControl = class;

  TXDirection = (xdLeft, xdRight);
  TYDirection = (ydTop, ydBottom);

  TdxBarSubMenuControl = class(TCustomdxBarControl)
  private
    FDestroyingControls: Boolean;
    FDetachCaptionSelected: Boolean;
    FDropDownButton: TdxBarButtonControl;
    FExpandingMenu: Boolean;
    FExpandMenuTimer: UINT;
    FLightBrush: HBRUSH;
    FLightPalette: HPALETTE;
    FMarkSize: Integer;
    FMenuAnimations: TdxBarMenuAnimations;
    FNormalItemHeight: Integer;
    FOnShowLeft, FOnShowTop: Integer;
    FOwnerWidth, FOwnerHeight: Integer;
    FSavedItemLinks: TList;
    FScrollTimerID: UINT;
    FShowAnimation: Boolean;
    FTopIndex: Integer;
    FSubItem: TdxBarSubItemControl;
    XDirection: TXDirection;
    YDirection: TYDirection;

    FOnCloseUp: TNotifyEvent;
    FOnPopup: TNotifyEvent;

    function GetBarSize: Integer;
    function GetBorderSize: Integer;
    function GetDetachCaptionSize: Integer;
    function GetMaxVisibleCount: Integer;
    function GetToolbarItemsBrush: HBRUSH;
    procedure SetDetachCaptionSelected(Value: Boolean);
    procedure SetTopIndex(Value: Integer);

    procedure CalcControlsPositions(Size: PPoint);
    procedure CreateLightBrush;
    procedure DestroyLightBrush;
    procedure PreparePalette(DC: HDC);
    procedure UnpreparePalette(DC: HDC);
    procedure ExpandMenu;
    function ExtendedView: Boolean;
    procedure InvalidateDetachCaption;
    function MouseOnUpArrow: Boolean;
    function MouseOnDownArrow: Boolean;
    function MouseOnMark: Boolean;
    procedure SetExpandMenuTimer(Time: UINT; ExpandAfterDelay: Boolean);
    procedure KillExpandMenuTimer;

    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseLeave(var Message: TMessage); message WM_MOUSELEAVE;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    ParentWnd: HWND;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWindowHandle; override;
    procedure DestroyWnd; override;
    procedure DoCloseUp; dynamic;
    procedure DoPopup; dynamic;
    procedure Paint; override;

    procedure CalcDrawingConsts; override;
    function CanCustomizing: Boolean; override;
    function ChildrenHaveShadows: Boolean; override;
    procedure CreateControls; override;
    procedure DestroyControls; override;
    procedure DrawBar(const R: TRect);
    function GetBeginGroupSize: Integer; override;
    function GetEditFontHandle: HFONT; override;
    function GetIsContextMenu: Boolean; virtual;
    function GetIsShadowVisible: Boolean; override;
    function GetItemRectEx(Item: TdxBarItemControl; IsBeginGroup: Boolean): TRect; override;
    function HideOnClick: Boolean; override;
    function ItemAtPosEx(Pos: TPoint;
      var IsBeginGroup, IsFirstPart, IsVerticalDirection: Boolean): TdxBarItemControl; override;
    procedure PaintItem(AControl: TdxBarItemControl); override;
    procedure SetFont; override;
    procedure SetIsActive(Value: Boolean); override;
    procedure SetMarkState(Value: TdxBarMarkState); override;
    procedure SetRecentItemCount;
    procedure SetSelectedItem(Value: TdxBarItemControl); override;
    procedure SetSizeAndCheckBounds(var ChangeXDirection, ChangeYDirection: Boolean);

    function CanDetach: Boolean;
    function Detachable: Boolean;
    function DetachCaptionAreaSize: Integer;
    function DetachCaptionRect: TRect;
    function MouseOnDetachCaption: Boolean;
    procedure DoDetachMenu;

    function MarkArrowSize: Integer;
    function MarkExists: Boolean; override;
    function MarkRect: TRect;

    function DownArrowExists: Boolean;
    function UpArrowExists: Boolean;
    function VisibleCount: Integer;

    property BarSize: Integer read GetBarSize;
    property BorderSize: Integer read GetBorderSize;
    property DetachCaptionSelected: Boolean read FDetachCaptionSelected
      write SetDetachCaptionSelected;
    property DetachCaptionSize: Integer read GetDetachCaptionSize;
    property MarkSize: Integer read FMarkSize;
    property NormalItemHeight: Integer read FNormalItemHeight;

    property ToolbarItemsBrush: HBRUSH read GetToolbarItemsBrush;

    property IsContextMenu: Boolean read GetIsContextMenu;
    property TopIndex: Integer read FTopIndex write SetTopIndex;
    property MaxVisibleCount: Integer read GetMaxVisibleCount;

    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Hide;
    procedure HideAll; override;
    procedure RepaintBar; override;
    procedure Show;

    property OwnerWidth: Integer read FOwnerWidth write FOwnerWidth;
    property OwnerHeight: Integer read FOwnerHeight write FOwnerHeight;
  end;

  {--------------------------------------
                   Items
   --------------------------------------}

{$IFDEF DELPHI4}
  TdxBarItemActionLink = class(TActionLink)
  protected
    FClient: TdxBarItem;
    procedure AssignClient(AClient: TObject); override;
    function IsCaptionLinked: Boolean; override;
    function IsCheckedLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsHelpContextLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    function IsShortCutLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    procedure SetCaption(const Value: string); override;
    procedure SetChecked(Value: Boolean); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHelpContext(Value: THelpContext); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetShortCut(Value: TShortCut); override;
    procedure SetVisible(Value: Boolean); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
  end;

  TdxBarItemActionLinkClass = class of TdxBarItemActionLink;
{$ENDIF}

  TdxBarItemAlign = (iaLeft, iaCenter, iaRight, iaClient);

  TdxBarItem = class(TComponent)
  private
  {$IFDEF DELPHI4}
    FActionLink: TdxBarItemActionLink;
  {$ENDIF}
    FAlign: TdxBarItemAlign;
    FBarManager: TdxBarManager;
    FCaption: string;
    FCategory: Integer;
    FClickItemLink: TdxBarItemLink;
    FData: Pointer;
    FDescription: string;
    FEnabled: Boolean;
    FGlyph: TBitmap;
    FHelpContext: THelpContext;
    FHint: string;
    FImageIndex: Integer;
    FLinks: TList;  // the list of the itemlinks
    FLoadedVisible: TdxBarItemVisible;
    FShortCut: TShortCut;
    FUnclickAfterDoing: Boolean;
    FVisible: TdxBarItemVisible;

    FOnClick: TNotifyEvent;
    FOnCreate: TNotifyEvent;
    FOnDestroy: TNotifyEvent;
  {$IFDEF DELPHI4}
    function GetAction: TBasicAction;
  {$ENDIF}
    function GetActuallyVisible: Boolean;
    function GetCurItemLink: TdxBarItemLink;
    function GetEnabled: Boolean;
    function GetFlat: Boolean; 
    function GetIndex: Integer;
    function GetIsDesigning: Boolean;
    function GetIsDestroying: Boolean;
    function GetIsLoading: Boolean;
    function GetLinkCount: Integer;
    function GetLinks(Index: Integer): TdxBarItemLink;
    function GetVisibleForUser: Boolean;
  {$IFDEF DELPHI4}
    procedure SetAction(Value: TBasicAction);
  {$ENDIF}
    procedure SetAlign(Value: TdxBarItemAlign);
    procedure SetCaption(Value: string);
    procedure SetCategory(Value: Integer);
    procedure SetDescription(Value: string);
    procedure SetEnabled(Value: Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetImageIndex(Value: Integer);
    procedure SetShortCut(Value: TShortCut);
    procedure SetVisible(Value: TdxBarItemVisible);

    procedure DestroyLinks;
  {$IFDEF DELPHI4}
    procedure DoActionChange(Sender: TObject);
    function IsCaptionStored: Boolean;
    function IsEnabledStored: Boolean;
    function IsHelpContextStored: Boolean;
    function IsHintStored: Boolean;
    function IsImageIndexStored: Boolean;
    function IsShortCutStored: Boolean;
    function IsVisibleStored: Boolean;
    function IsOnClickStored: Boolean;
  {$ENDIF}
    function GetHintFromCaption: string;
    procedure OnGlyphChanged(Sender: TObject);
  protected
  {$IFDEF DELPHI4}
    procedure AssignTo(Dest: TPersistent); override;
  {$ENDIF}
    procedure Loaded; override;
  {$IFDEF DELPHI4}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  {$ENDIF}
    procedure ReadState(Reader: TReader); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(AParent: TComponent); override;

  {$IFDEF DELPHI4}
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); dynamic;
  {$ENDIF}
    procedure AlignChanged; dynamic;
    procedure BarManagerChanged; virtual;
    function CanClicked: Boolean; virtual;
    procedure CaptionChanged; virtual;
    procedure EnabledChanged; virtual;
  {$IFDEF DELPHI4}
    function GetActionLinkClass: TdxBarItemActionLinkClass; dynamic;
  {$ENDIF}
    function GetHidden: Boolean; virtual;
    procedure GlyphChanged; virtual;
    function HasAccel(AItemLink: TdxBarItemLink): Boolean; virtual;
    function HasControls: Boolean;
    procedure HideControl(AControl: TdxBarItemControl); virtual;
    procedure HotGlyphChanged; virtual;
    function ImageIndexLinked: Boolean;
    procedure LargeGlyphChanged; virtual;
    function NeedToBeHidden: Boolean; virtual;
    procedure ObjectNotification(AOperation: TOperation; AObject: TObject); virtual;
    procedure ShortCutChanged; virtual;
    procedure Update; virtual;
    procedure UpdateEx; virtual;
    function UseHotImages: Boolean; virtual;
    function UseLargeImages: Boolean; virtual;
    procedure VisibleChanged; virtual;

  {$IFDEF DELPHI4}
    property ActionLink: TdxBarItemActionLink read FActionLink write FActionLink;
  {$ENDIF}
    property Flat: Boolean read GetFlat;
    property Hidden: Boolean read GetHidden;
    property IsDesigning: Boolean read GetIsDesigning;
    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
    property OnCreate: TNotifyEvent read FOnCreate write FOnCreate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; dynamic;
    procedure DirectClick; dynamic;
    procedure DoClick; dynamic;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    property ActuallyVisible: Boolean read GetActuallyVisible;
    property BarManager: TdxBarManager read FBarManager;
    property ClickItemLink: TdxBarItemLink read FClickItemLink;
    property CurItemLink: TdxBarItemLink read GetCurItemLink;
    property Data: Pointer read FData write FData;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property ImageIndex: Integer read FImageIndex write SetImageIndex
      {$IFDEF DELPHI4}stored IsImageIndexStored {$ENDIF}default -1;
    property Index: Integer read GetIndex;
    property LinkCount: Integer read GetLinkCount;
    property Links[Index: Integer]: TdxBarItemLink read GetLinks;
    property ShortCut: TShortCut read FShortCut write SetShortCut
      {$IFDEF DELPHI4}stored IsShortCutStored {$ENDIF}default 0;
    property UnclickAfterDoing: Boolean read FUnclickAfterDoing write FUnclickAfterDoing
      default False;
    property VisibleForUser: Boolean read GetVisibleForUser;

    property OnClick: TNotifyEvent read FOnClick write FOnClick{$IFDEF DELPHI4} stored IsOnClickStored{$ENDIF};
  published
  {$IFDEF DELPHI4}
    property Action: TBasicAction read GetAction write SetAction;
  {$ENDIF}
    property Align: TdxBarItemAlign read FAlign write SetAlign default iaLeft;
    property Caption: string read FCaption write SetCaption{$IFDEF DELPHI4} stored IsCaptionStored{$ENDIF};
    property Category: Integer read FCategory write SetCategory;
    property Description: string read FDescription write SetDescription;
    property Enabled: Boolean read GetEnabled write SetEnabled
      {$IFDEF DELPHI4}stored IsEnabledStored {$ENDIF}default True;
    property HelpContext: THelpContext read FHelpContext write FHelpContext
      {$IFDEF DELPHI4}stored IsHelpContextStored {$ENDIF}default 0;
    property Hint: string read FHint write FHint{$IFDEF DELPHI4} stored IsHintStored{$ENDIF};
    property Visible: TdxBarItemVisible read FVisible write SetVisible{$IFDEF DELPHI4} stored IsVisibleStored{$ENDIF};

    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
  end;

  TdxBarWindowItem = class(TdxBarItem)
  private
    FEmptyWindow: Boolean;
    FText: string;

    FOnChange: TNotifyEvent;
    FOnCurChange: TNotifyEvent;
    FOnEnter: TNotifyEvent;
    FOnExit: TNotifyEvent;
    FOnKeyDown: TKeyEvent;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyUp: TKeyEvent;

    function GetCurText: string;
    function GetFocusedItemLink: TdxBarItemLink;
    procedure SetCurText(Value: string);
  protected
    function CanClicked: Boolean; override;
    procedure Change; dynamic;
    procedure CurChange; dynamic;
    procedure DoEnter; dynamic;
    procedure DoExit; dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); dynamic;
    procedure KeyPress(var Key: Char); dynamic;
    procedure KeyUp(var Key: Word; Shift: TShiftState); dynamic;
    procedure SetText(Value: string); virtual;
    property EmptyWindow: Boolean read FEmptyWindow write FEmptyWindow;
  public
    procedure SetFocus; virtual;
    property CurText: string read GetCurText write SetCurText;
    property FocusedItemLink: TdxBarItemLink read GetFocusedItemLink;
  published
    property Text: string read FText write SetText;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnCurChange: TNotifyEvent read FOnCurChange write FOnCurChange;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TNotifyEvent read FOnExit write FOnExit;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyEvent read FOnKeyUp write FOnKeyUp;
  end;

  TdxBarButtonStyle = (bsDefault, bsChecked, bsDropDown);

  TOnDropDownEvent = procedure(AControl: TdxBarButtonControl; X, Y: Integer;
      ByMouse: Boolean) of object;

  TdxBarButton = class(TdxBarItem)
  private
    FAllowAllUp: Boolean;
    FButtonStyle: TdxBarButtonStyle;
    FCloseSubMenuOnClick: Boolean;
    FDown: Boolean;
    FDropDownEnabled: Boolean;
    FDropDownMenu: TdxBarPopupMenu;
    FGroupIndex: Integer;
    FLowered: Boolean;
    FPaintStyle: TdxBarPaintStyle;
    FOnDropDown : TOnDropDownEvent; {V}

    procedure SetAllowAllUp(Value: Boolean);
    procedure SetButtonStyle(Value: TdxBarButtonStyle);
    procedure SetDown(Value: Boolean);
    procedure SetDropDownEnabled(Value: Boolean);
    procedure SetDropDownMenu(Value: TdxBarPopupMenu);
    procedure SetGroupIndex(Value: Integer);
    procedure SetLowered(Value: Boolean);
    procedure SetPaintStyle(Value: TdxBarPaintStyle);

  {$IFDEF DELPHI4}
    function IsDownStored: Boolean;
  {$ENDIF}
  protected
    procedure ButtonStyleChanged; virtual;
    function CanChangePaintStyle: Boolean; virtual;
    procedure DownChanged; virtual;
    procedure DoDropDown(AControl: TdxBarButtonControl; X, Y: Integer;
      ByMouse: Boolean); dynamic;
    procedure DropDownEnabledChanged; virtual;
    function HasAccel(AItemLink: TdxBarItemLink): Boolean; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PaintStyleChanged; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Click; override;
  published
    property AllowAllUp: Boolean read FAllowAllUp write SetAllowAllUp default False;
    property ButtonStyle: TdxBarButtonStyle read FButtonStyle write SetButtonStyle
      default bsDefault;
    property CloseSubMenuOnClick: Boolean read FCloseSubMenuOnClick write FCloseSubMenuOnClick
      default True;
    property DropDownEnabled: Boolean read FDropDownEnabled write SetDropDownEnabled default True;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;  // must be here
    property Down: Boolean read FDown write SetDown
      {$IFDEF DELPHI4}stored IsDownStored {$ENDIF}default False;
    property DropDownMenu: TdxBarPopupMenu read FDropDownMenu write SetDropDownMenu;
    property Glyph;
    property ImageIndex;
    property Lowered: Boolean read FLowered write SetLowered default False;
    property PaintStyle: TdxBarPaintStyle read FPaintStyle write SetPaintStyle default psStandard;
    property ShortCut;
    property UnclickAfterDoing default True;

    property OnClick;
    property OnDropDown : TOnDropDownEvent read FOnDropDown write FOnDropDown; {V}
  end;

  TdxBarEdit = class(TdxBarWindowItem)
  private
    FMaxLength: Integer;
    FReadOnly: Boolean;
    FShowCaption: Boolean;
    FWidth: Integer;

    procedure SetMaxLength(Value: Integer);
    procedure SetShowCaption(Value: Boolean);
    procedure SetWidth(Value: Integer);
  protected
    procedure DrawInterior(ACanvas: TCanvas; R: TRect; ItemLink: TdxBarItemLink); virtual;
    function HasAccel(AItemLink: TdxBarItemLink): Boolean; override;
    procedure WidthChanged; virtual;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Glyph;
    property ImageIndex;
    property MaxLength: Integer read FMaxLength write SetMaxLength default 0;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default False;
    property Width: Integer read FWidth write SetWidth;

    property OnClick;
  end;

  TCustomdxBarCombo = class;

  TdxBarCheckKeyForDropDownWindowEvent = procedure (Sender: TCustomdxBarCombo;
    Key: Word; Shift: TShiftState; var AcceptKey: Boolean) of object;
  TdxBarGetDropDownWindowEvent = procedure (Sender: TCustomdxBarCombo;
    var Window: HWND) of object;

  TCustomdxBarCombo = class(TdxBarEdit)
  private
    FOnCheckKeyForDropDownWindow: TdxBarCheckKeyForDropDownWindowEvent;
    FOnCloseUp: TNotifyEvent;
    FOnDropDown: TNotifyEvent;
    FOnGetDropDownWindow: TdxBarGetDropDownWindowEvent;
    function GetDroppedDown: Boolean;
    function GetShowEditor: Boolean;
    procedure SetDroppedDown(Value: Boolean);
    procedure SetShowEditor(Value: Boolean);
  protected
    procedure AfterDropDown; dynamic;
    procedure CheckDropDownPoint(var X, Y: Integer);
    function CheckKeyForDropDownWindow(Key: Word; Shift: TShiftState): Boolean; virtual;
    procedure CloseUp; dynamic;
    procedure DropDown(X, Y: Integer); dynamic;
    function GetDropDownWindow: HWND; virtual;
    procedure InitDropDownWindow; virtual;
  public
    property DropDownWindow: HWND read GetDropDownWindow;
    property DroppedDown: Boolean read GetDroppedDown write SetDroppedDown;
  published
    property ShowEditor: Boolean read GetShowEditor write SetShowEditor default True;

    property OnCheckKeyForDropDownWindow: TdxBarCheckKeyForDropDownWindowEvent
      read FOnCheckKeyForDropDownWindow write FOnCheckKeyForDropDownWindow;
    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnGetDropDownWindow: TdxBarGetDropDownWindowEvent
      read FOnGetDropDownWindow write FOnGetDropDownWindow;
  end;

  TdxBarCustomCombo = class;

  TdxBarDrawItemEvent = procedure(Sender: TdxBarCustomCombo; AIndex: Integer;
    ARect: TRect; AState: TOwnerDrawState) of object;

  TdxBarMeasureItemEvent = procedure(Sender: TdxBarCustomCombo; AIndex: Integer;
    var AHeight: Integer) of object;

  TdxBarCustomCombo = class(TCustomdxBarCombo)
  private
    FDropDownCount: Integer;
    FDropDownWidth: Integer;
    FInteriorIsDrawing: Boolean;
    FItemHeight: Integer;
    FItemIndex: Integer;
    FItems: TStrings;
    FListBox: TCustomListBox;
    FSorted: Boolean;
    FOnDrawItem: TdxBarDrawItemEvent;
    FOnMeasureItem: TdxBarMeasureItemEvent;

    function GetCurItemIndex: Integer;
    function GetItemsHeight(Index: Integer): Integer;
    procedure SetCurItemIndex(Value: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure SetSorted(Value: Boolean);

    procedure CheckLocalPos;
    procedure ItemsChanged(Sender: TObject);
    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure ListBoxMeasureItem(Control: TWinControl; Index: Integer; var Height: Integer);
  protected
    FCanvas: TCanvas;
    procedure AfterDropDown; override;
    function CheckKeyForDropDownWindow(Key: Word; Shift: TShiftState): Boolean; override;
    procedure CloseUp; override;
    procedure CurChange; override;
    procedure DrawInterior(ACanvas: TCanvas; R: TRect; ItemLink: TdxBarItemLink); override;
    procedure DrawItem(AIndex: Integer; ARect: TRect; AState: TOwnerDrawState); virtual;
    procedure DropDown(X, Y: Integer); override;
    function GetCanvas: TCanvas; virtual;
    function GetDropDownWidth: Integer; virtual;
    function GetDropDownWindow: HWND; override;
    function GetNearestItemIndex(AText: string): Integer;
    procedure InitDropDownWindow; override;
    procedure MeasureItem(AIndex: Integer; var AHeight: Integer); virtual;
    procedure MeasureItemWidth(AIndex: Integer; var AWidth: Integer); virtual;
    procedure SetText(Value: string); override;
    property ListBox: TCustomListBox read FListBox;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Canvas: TCanvas read GetCanvas;
    property CurItemIndex: Integer read GetCurItemIndex write SetCurItemIndex;
    property ItemHeight: Integer read FItemHeight write FItemHeight default 0;
    property Items: TStrings read FItems write SetItems;
    property ItemsHeight[Index: Integer]: Integer read GetItemsHeight;
    property Sorted: Boolean read FSorted write SetSorted default False;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;  // loading after all
  published
    property DropDownCount: Integer read FDropDownCount write FDropDownCount default 8;
    property DropDownWidth: Integer read FDropDownWidth write FDropDownWidth default 0;

    property OnDrawItem: TdxBarDrawItemEvent read FOnDrawItem write FOnDrawItem;
    property OnMeasureItem: TdxBarMeasureItemEvent read FOnMeasureItem write FOnMeasureItem;
  end;

  TdxBarCombo = class(TdxBarCustomCombo)
  published
    property ItemHeight;
    property Items;
    property Sorted;
    property ItemIndex;  // loading after all
  end;

  TCustomdxBarSubItem = class(TdxBarItem)
  private
    FBarSize: Integer;
    FDetachable: Boolean;
    FDetachingBar: TdxBar;
    FItemLinks: TdxBarItemLinks;
    FShowCaption: Boolean;
    FOnCloseUp: TNotifyEvent;
    FOnDetaching: TNotifyEvent;
    FOnPaintBar: TdxBarPaintSubMenuBarEvent;
    FOnPopup: TNotifyEvent;
    function GetDetachingBarIndex: Integer;
    procedure SetBarSize(Value: Integer);
    procedure SetDetachingBar(Value: Integer);
    procedure SetItemLinks(Value: TdxBarItemLinks);
    procedure SetShowCaption(Value: Boolean);
  protected
    procedure BarManagerChanged; override;
    function CanClicked: Boolean; override;
    procedure DoCloseUp; dynamic;
    procedure DoDetaching; dynamic;
    procedure DoPaintBar(Canvas: TCanvas; const R: TRect); virtual;
    procedure DoPopup; dynamic;
    function HasDesignTimeLinks: Boolean; virtual;
    function IsShortCut(AShortCut: TShortCut): Boolean;
    procedure ObjectNotification(AOperation: TOperation; AObject: TObject); override;

    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanContainItem(AItem: TdxBarItem): Boolean;
    function GetDetachingBar: TdxBar;

    property ItemLinks: TdxBarItemLinks read FItemLinks write SetItemLinks;
  published
    property BarSize: Integer read FBarSize write SetBarSize default 0;
    property Detachable: Boolean read FDetachable write FDetachable default False;
    property DetachingBar: Integer read GetDetachingBarIndex write SetDetachingBar
      default -1;
    property Glyph;
    property ImageIndex;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default True;
    property OnClick;
    property OnDetaching: TNotifyEvent read FOnDetaching write FOnDetaching;
    property OnPaintBar: TdxBarPaintSubMenuBarEvent read FOnPaintBar write FOnPaintBar;
  end;

  TdxBarSubItem = class(TCustomdxBarSubItem)
  private
    FAllowCustomizing: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AllowCustomizing: Boolean read FAllowCustomizing write FAllowCustomizing
      default True;
    property ItemLinks;
    property OnCloseUp;
    property OnPopup;
  end;

  TCustomdxBarContainerItem = class(TCustomdxBarSubItem)
  private
    FNeedClearItemList: Boolean;
    FOnGetData: TNotifyEvent;
  protected
    procedure AddListedItemLinks(AItemLinks: TdxBarItemLinks; AIndex: Integer;
      FirstCall: Boolean; CallingItemLink: TdxBarItemLink); virtual;
    procedure DeleteListedItemLinks(AItemLinks: TdxBarItemLinks; AIndex: Integer); virtual;
    procedure ClearItemList; virtual;
    function HideWhenRun: Boolean; virtual;
    procedure NeedClearItemList;
  public
    destructor Destroy; override;
  published
    property OnGetData: TNotifyEvent read FOnGetData write FOnGetData;
  end;

  TdxBarListItem = class(TCustomdxBarContainerItem)
  private
    FItemIndex: Integer;
    FItemList: TList;
    FItems: TStrings;
    FShowCheck: Boolean;
    FShowNumbers: Boolean;
    function GetDataIndex: Integer;
    procedure SetDataIndex(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure ClickItem(Sender: TObject);
  protected
    procedure AddListedItemLinks(AItemLinks: TdxBarItemLinks; AIndex: Integer;
      FirstCall: Boolean; CallingItemLink: TdxBarItemLink); override;
    procedure ClearItemList; override;
    procedure DeleteListedItemLinks(AItemLinks: TdxBarItemLinks; AIndex: Integer); override;
    function GetDisplayText(const AText: string): string; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DirectClick; override;
  published
    property DataIndex: Integer read GetDataIndex write SetDataIndex stored False;
    property ItemIndex: Integer read FItemIndex write FItemIndex default -1;
    property Items: TStrings read FItems write SetItems;
    property ShowCheck: Boolean read FShowCheck write FShowCheck default False;
    property ShowNumbers: Boolean read FShowNumbers write FShowNumbers default True;
  end;

  TdxBarContainerItem = class(TCustomdxBarContainerItem)
  protected
    procedure AddListedItemLinks(AItemLinks: TdxBarItemLinks; AIndex: Integer;
      FirstCall: Boolean; CallingItemLink: TdxBarItemLink); override;
    procedure DeleteListedItemLinks(AItemLinks: TdxBarItemLinks; AIndex: Integer); override;
  published  
    property ItemLinks;
  end;

  {--------------------------------------
              Item's controls
   --------------------------------------}

  TdxBarItemControlClass = class of TdxBarItemControl;
  TdxBarPaintType = (ptHorz, ptMenu, ptVert);

  TdxBarItemControl = class(TObject)
  private
    FBeginGroupRect: TRect;
    FBreakingRow: Boolean;
    FChangeRecentGroup: Boolean;
    FHasWindow: Boolean;
    FIsActive: Boolean;
    FItemLink: TdxBarItemLink;
    FLastInRow: Boolean;
    FNonRecent: Boolean;
    FParent: TCustomdxBarControl;
    FPressed: Boolean;
    FSelectedByMouse: Boolean;

    function GetAlign: TdxBarItemAlign;
    function GetBarManager: TdxBarManager;
    function GetFlat: Boolean;
    function GetIsSelected: Boolean;
    function GetItem: TdxBarItem;
    function GetNormalItemHeightInSubMenu: Integer;
    function GetRealHeight: Integer;
    function GetRealWidth: Integer;
    function GetUnclickAfterDoing: Boolean;
    procedure SetPressed(Value: Boolean);
  protected
    procedure AlignChanged; dynamic;
    procedure BeforeDestroyParentHandle; virtual;
    procedure BeginGroupChanged; virtual;
    procedure CaptionChanged; virtual;
    procedure EnabledChanged; virtual;
    procedure GlyphChanged; virtual;
    procedure PressedChanged; virtual;
    procedure ShortCutChanged; virtual;
    procedure VisibleChanged; virtual;

    function CanClicked: Boolean; virtual;
    function CanCustomize: Boolean; virtual;
    function CanMouseSelect: Boolean; virtual;
    function CanSelect: Boolean; virtual;
    function CanVisuallyPressed: Boolean;
    procedure Click(ByMouse: Boolean); virtual;
    procedure ControlActivate(Immediately: Boolean); virtual;
    procedure ControlInactivate(Immediately: Boolean); virtual;
    procedure ControlClick(ByMouse: Boolean); virtual;
    procedure ControlUnclick(ByMouse: Boolean); virtual;
    procedure DblClick; dynamic;
    function DrawSelected: Boolean; virtual;
    function WantsDblClick: Boolean; dynamic;

    procedure KeyDown(Key: Word); virtual;
    function WantsKey(Key: Word): Boolean; virtual;

    procedure DrawLowered(DC: HDC; var R: TRect);
    procedure DrawGlyph(R: TRect; FullBounds: PRect; PaintType: TdxBarPaintType;
      IsGlyphEmpty, Selected, Down, DrawDowned, Center, ForceUseBkBrush,
      BarControlOwner: Boolean);
    procedure DrawGlyphAndBkgnd(R: TRect; const GlyphRect: TRect; PaintType: TdxBarPaintType;
      AGlyph: TBitmap; AImages: TCurImageList; AImageIndex: Integer;
      IsGlyphEmpty, Selected, Down, DrawDowned, ForceUseBkBrush, GrayScale,
      BarControlOwner: Boolean);
    procedure DrawGlyphAndTextInSubMenu(DC: HDC; var R: TRect;
      Selected, ShowGlyph, Down: Boolean);
    procedure DrawItemText(DC: HDC; S: string; PaintRect: TRect;
      Alignment: UINT; Enabled, Selected, Rotated, Clipped, Flat: Boolean);
    procedure FrameAndFillRect(DC: HDC; var R: TRect; Selected, Pressed: Boolean);
    procedure GetArrowParams(APaintType: TdxBarPaintType;
      ASelected, ADroppedDown: Boolean; var ABrush: HBRUSH; var AArrowColor: COLORREF); virtual;

    function GetCaption: string; virtual;
    function GetEnabled: Boolean; virtual;
    function GetGlyph: TBitmap; virtual;
    function GetImageIndex: Integer; virtual;
    function GetImages: TCurImageList; virtual;
    function GetHint: string; virtual;
    function GetHotImages: TCurImageList; virtual;
    function GetLargeImages: TCurImageList; virtual;
    function GetShortCut: TShortCut; virtual;
    function GetTextAreaOffset: Integer; virtual;

    function GetHeight: Integer; virtual;
    function GetMinHeight: Integer; virtual;
    function GetMinWidth: Integer; virtual;
    function GetOwnedBarControl: TCustomdxBarControl; virtual;
    function GetWidth: Integer; virtual;
    function HasHint: Boolean; virtual;
    function HasShadow: Boolean; virtual;
    function ImageExists: Boolean;
    function ImageIndexLinked: Boolean;
    function IsDestroyOnClick: Boolean; virtual;
    function IsExpandable: Boolean; virtual;
    function MousePressed: Boolean;
    function NeedCaptureMouse: Boolean; virtual;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); virtual;
    function ParentIsQuickCustControl: Boolean;
    function WantMouse: Boolean;

    property Align: TdxBarItemAlign read GetAlign;
    property Caption: string read GetCaption;
    property Enabled: Boolean read GetEnabled;
    property Flat: Boolean read GetFlat;
    property Glyph: TBitmap read GetGlyph;
    property Height: Integer read GetRealHeight;
    property Hint: string read GetHint;
    property HotImages: TCurImageList read GetHotImages;
    property ImageIndex: Integer read GetImageIndex;
    property Images: TCurImageList read GetImages;
    property LargeImages: TCurImageList read GetLargeImages;
    property MinHeight: Integer read GetMinHeight;
    property MinWidth: Integer read GetMinWidth;
    property NormalItemHeightInSubMenu: Integer read GetNormalItemHeightInSubMenu;
    property OwnedBarControl: TCustomdxBarControl read GetOwnedBarControl;
    property Pressed: Boolean read FPressed write SetPressed;
    property ShortCut: TShortCut read GetShortCut;
    property TextAreaOffset: Integer read GetTextAreaOffset;
    property UnclickAfterDoing: Boolean read GetUnclickAfterDoing;
    property Width: Integer read GetRealWidth;
  public
    constructor Create(AItemLink: TdxBarItemLink); virtual;
    destructor Destroy; override;
    procedure Repaint; virtual;

    property BarManager: TdxBarManager read GetBarManager;
    property HasWindow: Boolean read FHasWindow;
    property IsActive: Boolean read FIsActive;
    property IsSelected: Boolean read GetIsSelected;
    property Item: TdxBarItem read GetItem;
    property ItemLink: TdxBarItemLink read FItemLink;
    property Parent: TCustomdxBarControl read FParent;
  end;

  TdxBarWinControl = class(TdxBarItemControl)
  private
    FDefWndProc: Pointer;
    FFocused: Boolean;
    FFocusing: Boolean;
    FHandle: HWND;
    FKeyPressedInside: Integer;
    FPrevDefWndProc: Pointer;
    FPrevFocusedControl: HWND;
    FWindowRect: TRect;
    function GetItem: TdxBarWindowItem;
    function GetWindowRect: TRect;
  protected
    function CanClicked: Boolean; override;
    procedure ControlInactivate(Immediately: Boolean); override;
    procedure ControlClick(ByMouse: Boolean); override;
    procedure CreateWindowHandle; virtual;
    procedure DestroyWindowHandle; virtual;
    function DoKeyDown(var Message: TWMKey): Boolean;
    function DoKeyPress(var Message: TWMKey): Boolean;
    function DoKeyUp(var Message: TWMKey): Boolean;
    function GetText: string; virtual;
    function IsDestroyOnClick: Boolean; override;
    procedure SetFocused(Value: Boolean); virtual;
    procedure SetText(Value: string); virtual;
    procedure WndProc(var Message: TMessage); virtual;
  public
    constructor Create(AItemLink: TdxBarItemLink); override;
    destructor Destroy; override;
    property Focused: Boolean read FFocused write SetFocused;
    property Handle: HWND read FHandle;
    property Item: TdxBarWindowItem read GetItem;
    property Text: string read GetText write SetText;
    property WindowRect: TRect read GetWindowRect write FWindowRect;
  end;

  TdxBarButtonControl = class(TdxBarItemControl)
  private
    FDroppedDown: Boolean;
    FShowAnimation: Boolean;
    FOnDropDown: TOnDropDownEvent;
    function ArrowPressed: Boolean;
    function GetButtonStyle: TdxBarButtonStyle;
    function GetDown: Boolean;
    function GetDropDownEnabled: Boolean;
    function GetDropDownMenuControl: TdxBarSubMenuControl;
    function GetDroppedDownFlat: Boolean;
    function GetGroupIndex: Integer;
    function GetItem: TdxBarButton;
    function GetLowered: Boolean;
    function GetPaintStyle: TdxBarPaintStyle;
    function MouseOverArrow: Boolean;
    function GetOnDropDown: TOnDropDownEvent;
  protected
    function ArrowWidth: Integer; virtual;
    procedure ButtonStyleChanged; virtual;
    procedure ControlInactivate(Immediately: Boolean); override;
    procedure ControlClick(ByMouse: Boolean); override;
    procedure ControlUnclick(ByMouse: Boolean); override;
    procedure DoCloseUp; dynamic;
    procedure DoDropDown(ByMouse: Boolean); dynamic;
    procedure DownChanged; virtual;
    procedure DrawArrow(const ARect: TRect; Selected: Boolean; PaintType: TdxBarPaintType);
    function DrawSelected: Boolean; override;
    procedure DropDownEnabledChanged; virtual;
    procedure GlyphChanged; override;
    function GetDefaultHeight: Integer; virtual;
    function GetDefaultWidth: Integer; virtual;
    function GetHeight: Integer; override;
    function GetOwnedBarControl: TCustomdxBarControl; override;
    function GetWidth: Integer; override;
    function IsDestroyOnClick: Boolean; override;
    function IsFlatTextSelected(APressed: Boolean): Boolean;
    procedure KeyDown(Key: Word); override;
    function NeedCaptureMouse: Boolean; override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;
    procedure PaintStyleChanged; virtual;
    function WantsKey(Key: Word): Boolean; override;

    property ButtonStyle: TdxBarButtonStyle read GetButtonStyle;
    property Down: Boolean read GetDown;
    property DropDownEnabled: Boolean read GetDropDownEnabled;
    property DropDownMenuControl: TdxBarSubMenuControl read GetDropDownMenuControl;
    property DroppedDown: Boolean read FDroppedDown;
    property DroppedDownFlat: Boolean read GetDroppedDownFlat;
    property GroupIndex: Integer read GetGroupIndex;
    property Lowered: Boolean read GetLowered;
    property PaintStyle: TdxBarPaintStyle read GetPaintStyle;
    property OnDropDown: TOnDropDownEvent read GetOnDropDown write FOnDropDown;
  public
    property Item: TdxBarButton read GetItem;
  end;

  TdxBarEditControl = class(TdxBarWinControl)
  private
    function GetCaptionWidth: Integer;
    function GetItem: TdxBarEdit;
    function GetMaxLength: Integer;
    function GetReadOnly: Boolean;
    function GetShowCaption: Boolean;
  protected
    procedure ControlClick(ByMouse: Boolean); override;
    procedure CreateWindowHandle; override;
    procedure DrawBorder(DC: HDC; var ARect: TRect; PaintType: TdxBarPaintType;
      Selected: Boolean);
    procedure DrawCaption(DC: HDC; var ARect: TRect; PaintType: TdxBarPaintType;
      Selected: Boolean);
    function DrawSelected: Boolean; override;
    procedure DrawTextField(DC: HDC; const ARect: TRect);
    function GetHeight: Integer; override;
    function GetMinWidth: Integer; override;
    function GetWidth: Integer; override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;
    procedure SetFocused(Value: Boolean); override;
    procedure SetText(Value: string); override;
    procedure WidthChanged; virtual;
    procedure WndProc(var Message: TMessage); override;

    property CaptionWidth: Integer read GetCaptionWidth;
    property MaxLength: Integer read GetMaxLength;
    property ReadOnly: Boolean read GetReadOnly;
    property ShowCaption: Boolean read GetShowCaption;
  public
    property Item: TdxBarEdit read GetItem;
  end;

  TCustomdxBarComboControl = class(TdxBarEditControl)
  private
    FDropDownButtonRect: TRect;
    FOnPressDroppedDown: Boolean;
    FDroppedDown: Boolean;

    function GetDropDownWindow: HWND;
    function GetItem: TCustomdxBarCombo;
  protected
    procedure ControlInactivate(Immediately: Boolean); override;
    procedure GetArrowParams(APaintType: TdxBarPaintType;
      ASelected, ADroppedDown: Boolean; var ABrush: HBRUSH; var AArrowColor: COLORREF); override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;
    procedure SetDroppedDown(Value: Boolean); virtual;
    procedure WndProc(var Message: TMessage); override;

    property DropDownButtonRect: TRect read FDropDownButtonRect;
    property DropDownWindow: HWND read GetDropDownWindow;
  public
    property DroppedDown: Boolean read FDroppedDown write SetDroppedDown;
    property Item: TCustomdxBarCombo read GetItem;
  end;

  TdxBarComboControl = class(TCustomdxBarComboControl)
  private
    FLocalItemIndex: Integer;
    function GetItem: TdxBarCustomCombo;
    function GetItemIndex: Integer;
    function GetItems: TStrings;
    function GetSorted: Boolean;
    procedure SetLocalItemIndex(Value: Integer);
  protected
    procedure SetFocused(Value: Boolean); override;
    procedure WndProc(var Message: TMessage); override;

    property ItemIndex: Integer read GetItemIndex;
    property Items: TStrings read GetItems;
    property Sorted: Boolean read GetSorted;
  public
    property Item: TdxBarCustomCombo read GetItem;
    property LocalItemIndex: Integer read FLocalItemIndex write SetLocalItemIndex;
  end;

  TdxBarSubItemControl = class(TdxBarItemControl)
  private
    FShowAnimation: Boolean;
    function GetCaptionOffset: Integer;
    function GetItem: TCustomdxBarSubItem;
  protected
    procedure GlyphChanged; override;
    function GetSubMenuControl: TdxBarSubMenuControl; virtual;
    function CanClicked: Boolean; override;
    procedure ControlActivate(Immediately: Boolean); override;
    procedure ControlInactivate(Immediately: Boolean); override;
    procedure ControlClick(ByMouse: Boolean); override;
    procedure CreateSubMenuControl; virtual;
    procedure DoCreateSubMenuControl;
    function GetDefaultHeight: Integer; virtual;
    function GetDefaultWidth: Integer; virtual;
    function GetHeight: Integer; override;
    function GetOwnedBarControl: TCustomdxBarControl; override;
    function GetWidth: Integer; override;
    function HasSubMenu: Boolean; virtual;
    function IsDestroyOnClick: Boolean; override;
    function IsExpandable: Boolean; override;
    procedure KeyDown(Key: Word); override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;
    function WantsDblClick: Boolean; override;
    function WantsKey(Key: Word): Boolean; override;
    property CaptionOffset: Integer read GetCaptionOffset;
  public
    destructor Destroy; override;
    property Item: TCustomdxBarSubItem read GetItem;
    property SubMenuControl: TdxBarSubMenuControl read GetSubMenuControl;
  end;

  TdxBarContainerItemControl = class(TdxBarSubItemControl)
  private
    function GetItem: TCustomdxBarContainerItem;
  protected
    procedure CreateSubMenuControl; override;
    function GetCaption: string; override;
    function IsExpandable: Boolean; override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;
    function ShowRealCaption: Boolean; 
  public
    property Item: TCustomdxBarContainerItem read GetItem;
  end;

  TdxArrowType = ({atLeft, }atRight, {atUp, }atDown);

function dxBarItemClass(AIndex: Integer): TdxBarItemClass;
function dxBarItemCount: Integer;
function dxBarVisibleItemClass(AIndex: Integer): TdxBarItemClass;
function dxBarVisibleItemCount: Integer;
procedure dxBarRegisterItem(AItemClass: TdxBarItemClass;
  AItemControlClass: TdxBarItemControlClass; AVisible: Boolean);
procedure dxBarUnregisterItem(AItemClass: TdxBarItemClass);
procedure dxBarDesignerModified(ABarManager: TdxBarManager);

function ActiveBarControl: TCustomdxBarControl;
function VisibleTodxBarVisible(Value: Boolean): TdxBarItemVisible;
function GetBarManagerByForm(AForm: TCustomForm): TdxBarManager;

function GetWorkArea(const P: TPoint): TRect;
function IsVertical(ABarControl: TCustomdxBarControl): Boolean;
function GetTextOf(const S: string): string;
procedure DrawItemArrow(DC: HDC; R: TRect; ArrowType: TdxArrowType;
  Enabled, Selected, Flat: Boolean);
procedure DrawLargeItemArrow(DC: HDC; R: TRect; ArrowType: TdxArrowType;
  aSize: Longint; Selected, Enabled, Flat: Boolean);
procedure FrameFlatSelRect(DC: HDC; const R: TRect);
procedure DrawVerticalGradient(Canvas: TCanvas; const ARect: TRect;
  FromR, ToR, FromG, ToG, FromB, ToB: Byte);
procedure TransparentDraw(DrawDC: HDC; Brush: HBRUSH; FullRect, R: TRect; ABitmap: TBitmap;
  AImages: TCurImageList; AImageIndex: Integer;
  AEnabled, AGrayScale, AFlat, ASelected, ADown, APressed: Boolean; ImageListBkColor: TColor);
function CloneFont(Source: HFONT): HFONT;

procedure ProcessMouseMessages;
procedure ProcessPaintMessages;

function dxBarCustomizingPopup: TdxBarSubMenuControl;
function dxBarCustomizingPopupItemLink: TdxBarItemLink;

procedure ClearInternalItemList;

function LeftButtonPressed: Boolean;
function RightButtonPressed: Boolean;

var
  dxBarDesigner: TdxBarDesigner;
  dxBarHintWindowClass: TdxBarHintWindowClass = TdxBarHintWindow;
  dxBarManagerList: TdxBarManagerList;
  PatternBrush: HBRUSH;
  InternalItemList: TList;
  dxBarMakeInactiveImagesDingy: Boolean = True;

const
  crdxBarDrag = 1041;
  crdxBarDragCopy = 1042;
  crdxBarDragNoDrop = 1043;
  crdxBarEditSizing = 1044;

  dxBarManagerTempCategoryIndex = -1000;
  dxBarCustomizingPopupPaintStyleGroupIndex = -1000;

  dxBarNonrecentlyUsedItemsColorDelta: Integer = 20;
  dxBarFlatToolbarsColorDelta: Integer = 20;

implementation

{$R dxBar.res}

uses
  CommCtrl, MMSystem, Registry, IniFiles, dxBarCustForm, dxBarPopupMenuEd, dxBarStrs;

const
{$IFNDEF DELPHI6}
  WS_EX_LAYERED = $00080000;
  AC_SRC_ALPHA = $01;
  ULW_ALPHA = $00000002;
{$ENDIF}

  dxBarButtonBorderWidth = 7;
  dxBarButtonBorderHeight = 6;

  dxBarFingerSize = 3;
  dxBarHorSize = 4;
  dxBarTopSize = 2;
  dxBarBottomSize = 1;
  dxBarFlatBorderSize = 3;

  DefautGlyphSize = 16;
  InsertZone = 10;
  MarkSizeX = 11;
  MarkSizeY = 9;
  MarkSizeArrowY = 4;
  MarkSizeArrowX = 2 * MarkSizeArrowY - 1;
  MakeBeginGroupDragSize = 4;
  MinToolbarSize = 2 + 19 + 2;
  FloatToolbarMarkIndent = 1;

  HintOffset = 20;

  MinEditWidth = 20;
  EditSizingZoneSize = 7;

  MinDockSize = 3;
  DetachAreaDelta = 15;

  dxBarWaitForShowHintTime = 1000;
  dxBarWaitForHideHintTime = 10000;
  dxBarHiddedHintLifeTime = 400;
  dxBarWaitForSubMenuTime = 400;
  dxBarScrollMenuTime = 80;
  dxBarSlowExpandMenuTime = 4000;

  MDIButtonCommands: array[TdxBarMDIButton] of Integer =
    (SC_MINIMIZE, SC_RESTORE, SC_CLOSE);
  MDIButtonStyles: array[TdxBarMDIButton] of Integer =
    (DFCS_CAPTIONMIN, DFCS_CAPTIONRESTORE, DFCS_CAPTIONCLOSE);

  ImageShadowSize = 2;

  ListItemSeparator = '-';

type
  PBoolean = ^Boolean;

  TCurIniFile = {$IFDEF DELPHI4}TMemIniFile{$ELSE}TIniFile{$ENDIF};

  TDummyBitmap = class(TBitmap);
  TDummyControl = class(TControl);
  TDummyForm = class(TCustomForm);

  PRegItemRecord = ^TRegItemRecord;
  TRegItemRecord = record
    ItemClass: TdxBarItemClass;
    ItemControlClass: TdxBarItemControlClass;
    Visible: Boolean;
  end;

var
  IsWin95, IsWin95Or98, IsWin98Or2000: Boolean;
  FUser32DLL: HMODULE;
  TrackMouseEvent: function(var EventTrack: TTrackMouseEvent): BOOL; stdcall;
  UpdateLayeredWindow: function(Handle: THandle; hdcDest: HDC; pptDst: PPoint;
    _psize: PSize; hdcSrc: HDC; pptSrc: PPoint; crKey: COLORREF;
    pblend: PBLENDFUNCTION; dwFlags: DWORD): Boolean; stdcall;

  FRegItemList: TList;
  FBarControls: TList;

  FActiveBarControl: TCustomdxBarControl;

  FIsMDIButtonPressed, FIsMouseOverMDIButton: Boolean;
  FPressedMDIButton: TdxBarMDIButton;

  ResettingToolbar, InternalLoading: Boolean;

  ShowFullMenus: Boolean;

  BitsPerPixel: Integer;

{$IFNDEF DELPHI4}
const
  HBMMENU_POPUP_CLOSE = 8;
  HBMMENU_POPUP_RESTORE = 9;
  HBMMENU_POPUP_MAXIMIZE = 10;
  HBMMENU_POPUP_MINIMIZE = 11;
type
  TMenuItemInfo = record
    cbSize: UINT;
    fMask: UINT;
    fType: UINT;             { used if MIIM_TYPE}
    fState: UINT;            { used if MIIM_STATE}
    wID: UINT;               { used if MIIM_ID}
    hSubMenu: HMENU;         { used if MIIM_SUBMENU}
    hbmpChecked: HBITMAP;    { used if MIIM_CHECKMARKS}
    hbmpUnchecked: HBITMAP;  { used if MIIM_CHECKMARKS}
    dwItemData: DWORD;       { used if MIIM_DATA}
    dwTypeData: PAnsiChar;      { used if MIIM_TYPE}
    cch: UINT;               { used if MIIM_TYPE}
    hbmpItem: HBITMAP;       { used if MIIM_BITMAP}
  end;
function GetMenuItemInfo(p1: HMENU; p2: UINT; p3: BOOL; var p4: TMenuItemInfo): BOOL; stdcall;
  external user32 name 'GetMenuItemInfoA';
{$ENDIF}

{ global methods }

function dxBarItemClass(AIndex: Integer): TdxBarItemClass;
begin
  Result := PRegItemRecord(FRegItemList[AIndex])^.ItemClass;
end;

function dxBarItemCount: Integer;
begin
  Result := FRegItemList.Count;
end;

function dxBarVisibleItemClass(AIndex: Integer): TdxBarItemClass;
var
  VisibleIndex, I: Integer;
begin
  Result := nil;  
  VisibleIndex := -1;
  with FRegItemList do
    for I := 0 to Count - 1 do
      with PRegItemRecord(FRegItemList[I])^ do
      begin
        if Visible then Inc(VisibleIndex);
        if VisibleIndex = AIndex then
        begin
          Result := ItemClass;
          Exit;
        end;
      end;
end;

function dxBarVisibleItemCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  with FRegItemList do
    for I := 0 to Count - 1 do
      if PRegItemRecord(FRegItemList[I])^.Visible then Inc(Result);
end;

procedure dxBarRegisterItem(AItemClass: TdxBarItemClass;
  AItemControlClass: TdxBarItemControlClass; AVisible: Boolean);
var
  ARecord: PRegItemRecord;
begin
  New(ARecord);
  with ARecord^ do
  begin
    ItemClass := AItemClass;
    ItemControlClass := AItemControlClass;
    Visible := AVisible;
  end;
  FRegItemList.Add(ARecord);
  RegisterClass(AItemClass);
end;

procedure dxBarUnregisterItem(AItemClass: TdxBarItemClass);
var
  I: Integer;
begin
  for I := 0 to FRegItemList.Count - 1 do
    if PRegItemRecord(FRegItemList[I])^.ItemClass = AItemClass then
    begin
      Dispose(PRegItemRecord(FRegItemList[I]));
      FRegItemList.Delete(I);
      UnregisterClass(AItemClass);
      Break;
    end;
end;

procedure AddBarControl(ABarControl: TCustomdxBarControl);
begin
  FBarControls.Add(ABarControl);
end;

procedure RemoveBarControl(ABarControl: TCustomdxBarControl);
begin
  FBarControls.Remove(ABarControl);
end;

function BarControlExists(ABarControl: TCustomdxBarControl): Boolean;
begin
  Result := (ABarControl <> nil) and (FBarControls.IndexOf(ABarControl) <> -1);
end;

procedure dxBarDesignerModified(ABarManager: TdxBarManager);
begin
  if ABarManager <> nil then ABarManager.DesignerModified;
end;

function ActiveBarControl: TCustomdxBarControl;
begin
  Result := FActiveBarControl;
end;

function VisibleTodxBarVisible(Value: Boolean): TdxBarItemVisible;
begin
  if Value then
    Result := ivAlways
  else
    Result := ivNever;
end;

function GetBarManagerByForm(AForm: TCustomForm): TdxBarManager;
var
  I: Integer;
begin
  Result := nil;
  if (AForm <> nil) and (dxBarManagerList <> nil) then
    for I := 0 to dxBarManagerList.Count - 1 do
      if dxBarManagerList[I].MainForm = AForm then
      begin
        Result := dxBarManagerList[I];
        Break;
      end;
end;

function GetParentBarOrSubMenuForBar(Value: TCustomdxBarControl): TCustomdxBarControl;
begin
  Result := Value;
  while (Result <> nil) and not Result.IsDestroying do
    if Result.ParentBar <> nil then
      Result := Result.ParentBar
    else
      if (Result is TdxBarSubMenuControl) and
        (TdxBarSubMenuControl(Result).FDropDownButton <> nil) then
        Result := TdxBarSubMenuControl(Result).FDropDownButton.Parent
      else
        Break;
end;

function GetParentBarForBar(Value: TCustomdxBarControl): TCustomdxBarControl;
begin
  Result := GetParentBarOrSubMenuForBar(Value);
  if Result is TdxBarSubMenuControl then Result := nil;
end;

function GetParentBarOrSubMenuForControl(Value: TdxBarItemControl): TCustomdxBarControl;
begin
  if Value = nil then Result := nil
  else
    Result := GetParentBarOrSubMenuForBar(Value.Parent);
end;

function GetParentBarForControl(Value: TdxBarItemControl): TCustomdxBarControl;
begin
  Result := GetParentBarOrSubMenuForControl(Value);
  if Result is TdxBarSubMenuControl then Result := nil;
end;

function FindVCLControl(Wnd: HWND): TWinControl;
begin
  repeat
    Result := FindControl(Wnd);
    if Result <> nil then Break;
    Wnd := GetParent(Wnd);
  until Wnd = 0;
end;

function HasAsParent(Wnd: HWND; ParentWnd: HWND): Boolean;
begin
  repeat
    Wnd := GetParent(Wnd);
    Result := Wnd = ParentWnd;
    if (Wnd = 0) or Result then Break;
  until False;
end;

function WindowFromPointEx(P: TPoint): HWND;

  function FindOne(Wnd: HWND; P: TPoint): HWND;
  begin
    Result := ChildWindowFromPointEx(Wnd, P, CWP_SKIPINVISIBLE);
    if Result = 0 then
      Result := Wnd
    else
      if Result <> Wnd then
      begin
        MapWindowPoints(Wnd, Result, P, 1);
        Result := FindOne(Result, P);
      end;
  end;

begin
  Result := WindowFromPoint(P);
  if Result <> 0 then
  begin
    ScreenToClient(Result, P);
    Result := FindOne(Result, P);
  end;
end;

function GetTextOf(const S: string): string;
var
  I: Integer;
begin
  Result := S;
  I := 1;
  while I < Length(Result) do
  begin
    if Result[I] = '&' then Delete(Result, I, 1);
    Inc(I);
  end;
end;

procedure DrawItemArrow(DC: HDC; R: TRect; ArrowType: TdxArrowType;
  Enabled, Selected, Flat: Boolean);
var
  Size: Integer;
begin
  if ArrowType = atRight then
    Size := R.Bottom - R.Top - 6
  else  // atDown
    Size := R.Right - R.Left - 8;
  Size := (Size - 1) div 2 + Byte(Size mod 2 <> 0);
  if Size < 3 then Size := 3;
  DrawLargeItemArrow(DC, R, ArrowType, Size, Selected, Enabled, Flat);
end;

procedure DrawLargeItemArrow(DC: HDC; R: TRect; ArrowType: TdxArrowType;
  aSize: Longint; Selected, Enabled, Flat: Boolean);
var
  Color: COLORREF;
  X, Y: Longint;
  P: array[1..3] of TPoint;
  Pen: HPEN;
  Brush: HBRUSH;

  procedure DrawEnabled;
  begin
    with R do
      if ArrowType = atRight then
      begin
        X := (Left + Right - aSize) div 2;
        Y := (Top + Bottom - (2 * aSize - 1)) div 2;
        P[1] := Point(X, Y);
        P[2] := Point(X, Y + 2 * aSize - 2);
      end
      else  // atDown
      begin
        X := (Left + Right - (2 * aSize - 1)) div 2;
        Y := (Top + Bottom - aSize) div 2;
        P[1] := Point(X, Y);
        P[2] := Point(X + 2 * aSize - 2, Y);
      end;
    P[3] := Point(X + aSize - 1, Y + aSize - 1);

    Pen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(Color)));
    Brush := SelectObject(DC, GetSysColorBrush(Color));
    Polygon(DC, P, 3);
    SelectObject(DC, Brush);
    DeleteObject(SelectObject(DC, Pen));
  end;

  procedure DrawDisabled;
  begin
    Pen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNHIGHLIGHT)));
    if ArrowType = atRight then
    begin
      MoveToEx(DC, X + aSize - 1, Y + aSize, nil);
      LineTo(DC, X, Y + 2 * aSize - 1);
      MoveToEx(DC, X + aSize, Y + aSize, nil);
      LineTo(DC, X, Y + 2 * aSize);
    end
    else
    begin
      MoveToEx(DC, X + aSize, Y + aSize - 1, nil);
      LineTo(DC, X + 2 * aSize - 1, Y);
      MoveToEx(DC, X + aSize, Y + aSize, nil);
      LineTo(DC, X + 2 * aSize, Y);
    end;
    DeleteObject(SelectObject(DC, Pen));
  end;

begin
  if Enabled then
    if Selected then
      Color := COLOR_HIGHLIGHTTEXT
    else
      Color := COLOR_BTNTEXT
  else
    Color := COLOR_BTNSHADOW;
  DrawEnabled;
  if not Enabled and not Flat then DrawDisabled;
end;

procedure FrameFlatSelRect(DC: HDC; const R: TRect);
begin
  FrameRect(DC, R, GetSysColorBrush(COLOR_HIGHLIGHT));
end;

{ items global functions }

function GetWorkArea(const P: TPoint): TRect;
const
  MONITOR_DEFAULTTONEAREST = $2;
type
  HMONITOR = type Integer;
  PMonitorInfo = ^TMonitorInfo;
  TMonitorInfo = record
    cbSize: DWORD;
    rcMonitor: TRect;
    rcWork: TRect;
    dwFalgs: DWORD;
  end;
var
  Info: TMonitorInfo;
  GetMonitorInfo: function(hMonitor: HMONITOR; lpMonitorInfo: PMonitorInfo): Boolean; stdcall;
  MonitorFromPoint: function(ptScreenCoords: TPoint; dwFlags: DWORD): HMONITOR; stdcall;
begin
  if FUser32DLL > 32 then
  begin
    GetMonitorInfo := GetProcAddress(FUser32DLL, 'GetMonitorInfoA');
    MonitorFromPoint := GetProcAddress(FUser32DLL, 'MonitorFromPoint');
  end
  else
  begin
    GetMonitorInfo := nil;
    MonitorFromPoint := nil;
  end;

  if @GetMonitorInfo = nil then
    SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0)
  else
  begin
    Info.cbSize := SizeOf(Info);
    GetMonitorInfo(MonitorFromPoint(P, MONITOR_DEFAULTTONEAREST), @Info);
    Result := Info.rcWork;
  end;
end;

procedure CheckEditWidth(var Value: Integer);
begin
  if Value < MinEditWidth then Value := MinEditWidth;
end;

function IsRealVertical(ABarControl: TCustomdxBarControl): Boolean;
begin
  Result := ABarControl is TdxBarControl and TdxBarControl(ABarControl).Vertical;
end;

function IsVertical(ABarControl: TCustomdxBarControl): Boolean;
begin
  Result := IsRealVertical(ABarControl) and TdxBarControl(ABarControl).Bar.RotateWhenVertical;
end;

procedure RefreshDeviceConsts;
var
  DC: Integer;
begin
  DC := GetDC(0);
  try
    BitsPerPixel := GetDeviceCaps(DC, BITSPIXEL);
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure CreatePatternBrush;
var
  Pattern: TBitmap;
  X, Y: Integer;
begin
  Pattern := TBitmap.Create;
  with Pattern, Canvas do
  begin
    Width := 8;
    Height := 8;
    Brush.Color := GetSysColor(COLOR_BTNHIGHLIGHT);
    FillRect(Rect(0, 0, Width, Height));
    for Y := 0 to 7 do
      for X := 0 to 7 do
        if (Y mod 2) = (X mod 2) then
          Pixels[X, Y] := GetSysColor(COLOR_BTNFACE);
  end;
  if PatternBrush <> 0 then DeleteObject(PatternBrush);
  PatternBrush := Windows.CreatePatternBrush(Pattern.Handle);
  Pattern.Free;
end;

procedure DrawVerticalGradient(Canvas: TCanvas; const ARect: TRect;
  FromR, ToR, FromG, ToG, FromB, ToB: Byte);
var
  SR: TRect;
  H, I: Integer;
  R, G, B: Byte;
begin
  SR := ARect;
  with ARect do
    H := Bottom - Top;
  for I := 0 to 255 do
  begin
    SR.Bottom := ARect.Top + MulDiv(I + 1, H, 256);
    with Canvas do
    begin
      R := FromR + MulDiv(I, ToR - FromR, 255);
      G := FromG + MulDiv(I, ToG - FromG, 255);
      B := FromB + MulDiv(I, ToB - FromB, 255);
      Brush.Color := RGB(R, G, B);
      FillRect(SR);
    end;
    SR.Top := SR.Bottom;
  end;
end;

procedure TransparentDraw(DrawDC: HDC; Brush: HBRUSH; FullRect, R: TRect; ABitmap: TBitmap;
  AImages: TCurImageList; AImageIndex: Integer;
  AEnabled, AGrayScale, AFlat, ASelected, ADown, APressed: Boolean; ImageListBkColor: TColor);
const
  ROP_DSPDxax = $00E20746;
  AndOrBitBltFlags: array[Boolean] of DWORD = (MERGEPAINT, SRCAND);
  BitBltFlags: array[Boolean] of DWORD = (SRCINVERT, ROP_DSPDxax);
type
  PColors = ^TColors;
  TColors = array[0..MaxInt - 1] of Byte;
var
  W, H, BW, BH, X, Y: Integer;
  DC, BDC, MaskDC: HDC;
  B, BitmapHandle, PrevBitmapHandle, MaskHandle: HBITMAP;
  PrevPalette: HPALETTE;
  BI: TBitmapInfo;
  ATransparentColor, ATextColor, ABackColor: COLORREF;
  ABrush: HBRUSH;

  function GetBitmapColors(ABitmap: HBITMAP): PColors;
  begin
    with BI.bmiHeader do
    begin
      biSize := SizeOf(BI.bmiHeader);
      biWidth := BW;
      biHeight := -BH;
      biPlanes := 1;
      biBitCount := 32;
      biCompression := BI_RGB;

      GetMem(Result, 4 * BW * BH);
      GetDIBits(DrawDC, ABitmap, 0, BH, Result, BI, DIB_RGB_COLORS);
    end;
  end;

  procedure SetBitmapColors(ABitmap: HBITMAP; AColors: PColors);
  begin
    SetDIBits(DrawDC, ABitmap, 0, BH, AColors, BI, DIB_RGB_COLORS);
    FreeMem(AColors);
  end;

  procedure CreateGrayScaleBitmap;
  var
    Colors: PColors;
    I, J, K: Integer;
    AColor: COLORREF;
  begin
    Colors := GetBitmapColors(BitmapHandle);
    try
      for I := 0 to BW - 1 do
        for J := 0 to BH - 1 do
        begin
          K := (J * BW + I) * 4;
          AColor := (Colors^[K] + Colors^[K + 1] + Colors^[K + 2]) div 3;
          Colors^[K] := AColor;
          Colors^[K + 1] := AColor;
          Colors^[K + 2] := AColor;
        end;
    finally
      SetBitmapColors(BitmapHandle, Colors);
    end;
  end;

  procedure MakeBitmapDingy;
  var
    Colors: PColors;
    I, J, K: Integer;

    procedure LightColor(var AColor: Byte);
    begin
      Inc(AColor, MulDiv(255 - AColor, 3, 10));
    end;

  begin
    Colors := GetBitmapColors(BitmapHandle);
    try
      for I := 0 to BW - 1 do
        for J := 0 to BH - 1 do
        begin
          K := (J * BW + I) * 4;
          LightColor(Colors^[K]);
          LightColor(Colors^[K + 1]);
          LightColor(Colors^[K + 2]);
        end;
    finally
      SetBitmapColors(BitmapHandle, Colors);
    end;
  end;

  procedure DrawShadow;
  var
    LogBrush: TLogBrush;
  begin
    GetObject(Brush, SizeOf(LogBrush), @LogBrush);
    ATextColor := SetTextColor(DC, GetSysColor(COLOR_BTNSHADOW));
    ABackColor := SetBkColor(DC, LogBrush.lbColor);
    ABrush := SelectObject(DC, Brush);
    StretchBlt(DC, X + ImageShadowSize, Y + ImageShadowSize, W, H, MaskDC,
      0, 0, BW, BH, SRCCOPY);
    SelectObject(DC, ABrush);
    SetTextColor(DC, ATextColor);
    SetBkColor(DC, ABackColor);
  end;

  function InvertImage: Boolean;
  begin
    Result :=
      not AGrayScale and not (AFlat and ASelected) and (GetSysColor(COLOR_BTNFACE) = 0);
  end;

begin
  with R do
  begin
    W := Right - Left;
    H := Bottom - Top;
    if (ABitmap = nil) or ABitmap.Empty then
    begin
      BW := AImages.Width;
      BH := AImages.Height;
    end
    else
    begin
      BW := ABitmap.Width;
      BH := ABitmap.Height;
    end;
    OffsetRect(R, -FullRect.Left, -FullRect.Top);

    DC := CreateCompatibleDC(DrawDC);
    with FullRect do
      B := CreateCompatibleBitmap(DrawDC, Right - Left, Bottom - Top);
    B := SelectObject(DC, B);
    PrevPalette := SelectPalette(DC, GetCurrentObject(DrawDC, OBJ_PAL), True);
    RealizePalette(DC);
    try
      with FullRect do
        FillRect(DC, Rect(0, 0, Right - Left, Bottom - Top), Brush);

      if AEnabled then
      begin
        BDC := CreateCompatibleDC(DrawDC);
        BitmapHandle := CreateCompatibleBitmap(DrawDC, BW, BH);
        PrevBitmapHandle := SelectObject(BDC, BitmapHandle);
        try
          if (ABitmap = nil) or ABitmap.Empty then
          begin
            ABrush := CreateSolidBrush(ColorToRGB(ImageListBkColor));
            FillRect(BDC, Rect(0, 0, BW, BH), ABrush);
            DeleteObject(ABrush);
            ImageList_Draw(AImages.Handle, AImageIndex, BDC, 0, 0, ILD_NORMAL);
          end
          else
            BitBlt(BDC, 0, 0, BW, BH, ABitmap.Canvas.Handle, 0, 0, SRCCOPY);

          ATransparentColor := GetPixel(BDC, 0, BH - 1);

          MaskDC := CreateCompatibleDC(DrawDC);
          MaskHandle := CreateBitmap(BW, BH, 1, 1, nil);
          MaskHandle := SelectObject(MaskDC, MaskHandle);
          try
            ABackColor := SetBkColor(BDC, ATransparentColor);
            BitBlt(MaskDC, 0, 0, BW, BH, BDC, 0, 0, SRCCOPY);
            SetBkColor(BDC, ABackColor);

            if AGrayScale then
              CreateGrayScaleBitmap;

            if AFlat and not ASelected and not ADown and not AGrayScale and
              dxBarMakeInactiveImagesDingy then
              MakeBitmapDingy;

            X := Left;
            Y := Top;
            if AFlat and ASelected and not APressed {and not ADown} then
            begin
              Dec(X, ImageShadowSize div 2);
              Dec(Y, ImageShadowSize div 2);
              DrawShadow;
            end;

            StretchBlt(DC, X, Y, W, H, MaskDC, 0, 0, BW, BH, AndOrBitBltFlags[InvertImage]);
            BitBlt(BDC, 0, 0, BW, BH, MaskDC, 0, 0, SRCPAINT);
            StretchBlt(DC, X, Y, W, H, BDC, 0, 0, BW, BH, AndOrBitBltFlags[not InvertImage]);
          finally
            DeleteObject(SelectObject(MaskDC, MaskHandle));
            DeleteDC(MaskDC);
          end;
        finally
          SelectObject(BDC, PrevBitmapHandle);
          DeleteObject(BitmapHandle);
          DeleteDC(BDC);
        end
      end
      else
      begin
        MaskDC := CreateCompatibleDC(DrawDC);
        MaskHandle := CreateBitmap(BW, BH, 1, 1, nil);
        MaskHandle := SelectObject(MaskDC, MaskHandle);
        try
          if (ABitmap = nil) or ABitmap.Empty then
          begin
            FillRect(MaskDC, Rect(0, 0, BW, BH), GetStockObject(WHITE_BRUSH));
            ImageList_Draw(AImages.Handle, AImageIndex, MaskDC, 0, 0, ILD_NORMAL);
          end
          else
          begin
            BitBlt(MaskDC, 0, 0, BW, BH, ABitmap.Canvas.Handle, 0, 0, SRCCOPY);
            ABackColor := SetBkColor(ABitmap.Canvas.Handle, ColorToRGB(ABitmap.TransparentColor));
            BitBlt(MaskDC, 0, 0, BW, BH, ABitmap.Canvas.Handle, 0, 0, BitBltFlags[IsWin95]);
            SetBkColor(ABitmap.Canvas.Handle, ABackColor);
          end;

          ATextColor := SetTextColor(DC, $FFFFFF);
          ABackColor := SetBkColor(DC, 0);
          ABrush := SelectObject(DC, GetSysColorBrush(COLOR_BTNHIGHLIGHT));
          if not AFlat then
            StretchBlt(DC, Left + 1, Top + 1, W, H, MaskDC, 0, 0, BW, BH, ROP_DSPDxax);
          SelectObject(DC, GetSysColorBrush(COLOR_BTNSHADOW));
          StretchBlt(DC, Left, Top, W, H, MaskDC, 0, 0, BW, BH, ROP_DSPDxax);
          SelectObject(DC, ABrush);
          SetTextColor(DC, ATextColor);
          SetBkColor(DC, ABackColor);
        finally
          DeleteObject(SelectObject(MaskDC, MaskHandle));
          DeleteDC(MaskDC);
        end;
      end;

      with FullRect do
        BitBlt(DrawDC, Left, Top, Right - Left, Bottom - Top, DC, 0, 0, SRCCOPY);
    finally
      SelectPalette(DC, PrevPalette, False);
      DeleteObject(SelectObject(DC, B));
      DeleteDC(DC);
    end;
  end;
end;
{
procedure TransparentDrawEx(DrawDC: HDC; SourceDC: HDC; R: TRect; Brush: HBRUSH);
const
  ROP_DSPDxax = $00E20746;
  CopyBitBltFlags: array[Boolean] of DWORD = (SRCCOPY, NOTSRCCOPY);
var
  W, H: Integer;
  MaskDC: HDC;
  MaskHandle: HBITMAP;
  PrevPalette: HPALETTE;
  ATextColor, ABackColor: COLORREF;
  ABrush: HBRUSH;
begin
  with R do
  begin
    W := Right - Left;
    H := Bottom - Top;

    PrevPalette := SelectPalette(SourceDC, GetCurrentObject(DrawDC, OBJ_PAL), True);
    RealizePalette(SourceDC);
    try
      MaskDC := CreateCompatibleDC(DrawDC);
      MaskHandle := CreateBitmap(W, H, 1, 1, nil);
      MaskHandle := SelectObject(MaskDC, MaskHandle);
      try
        ABackColor := SetBkColor(SourceDC, GetPixel(SourceDC, 0, H - 1));
        BitBlt(MaskDC, 0, 0, W, H, SourceDC, 0, 0, SRCCOPY);
        SetBkColor(SourceDC, ABackColor);

        StretchBlt(DrawDC, Left, Top, W, H, SourceDC, 0, 0, W, H,
          CopyBitBltFlags[(GetSysColor(COLOR_BTNFACE) = 0)]);

        ATextColor := SetTextColor(DrawDC, 0);
        ABackColor := SetBkColor(DrawDC, $FFFFFF);
        ABrush := SelectObject(DrawDC, Brush);
        StretchBlt(DrawDC, Left, Top, W, H, MaskDC, 0, 0, W, H, ROP_DSPDxax);
        SelectObject(DrawDC, ABrush);
        SetTextColor(DrawDC, ATextColor);
        SetBkColor(DrawDC, ABackColor);
      finally
        DeleteObject(SelectObject(MaskDC, MaskHandle));
        DeleteDC(MaskDC);
      end;
    finally
      SelectPalette(SourceDC, PrevPalette, False);
    end;
  end;
end;
}

{ toolbars global function }

function SMCaptionY: Integer;
begin
  Result := GetSystemMetrics(SM_CYSMCAPTION);
end;

procedure ProcessMouseMessages;
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, 0, WM_MOUSEFIRST, WM_MOUSELAST, PM_NOREMOVE) do
  begin
    case Integer(GetMessage(Msg, 0, WM_MOUSEFIRST, WM_MOUSELAST)) of
      -1: Break;
      0: begin
           PostQuitMessage(Msg.wParam);
           Break;
         end;
    end;
    DispatchMessage(Msg);
  end;
end;

procedure ProcessPaintMessages;
var
  Msg: TMsg;
begin                         
  while PeekMessage(Msg, 0, WM_PAINT, WM_PAINT, PM_NOREMOVE) do
  begin
    case Integer(GetMessage(Msg, 0, WM_PAINT, WM_PAINT)) of
      -1: Break;
      0: begin
           PostQuitMessage(Msg.wParam);
           Break;
         end;
    end;
    DispatchMessage(Msg);
  end;
end;

type
  TPlaySoundType = (psMenuPopup, psMenuCommand);

procedure PlaySound(APlaySoundType: TPlaySoundType);
const
  PlaySounds: array[TPlaySoundType] of string = ('MenuPopup', 'MenuCommand');
begin
  MMSystem.PlaySound(PChar(PlaySounds[APlaySoundType]), 0,
    SND_ALIAS or SND_ASYNC or SND_NODEFAULT {or SND_NOSTOP }or SND_NOWAIT);
end;

procedure CreateEditFontHandle(Font: TFont; var EditFontHandle: HFONT; Scaled: Boolean);
var
  SystemLogFont, LogFont: TLogFont;
begin
  if EditFontHandle <> 0 then DeleteObject(EditFontHandle);
  if Scaled then
  begin
    SystemParametersInfo(SPI_GETICONTITLELOGFONT, SizeOf(SystemLogFont), @SystemLogFont, 0);
    GetObject(Font.Handle, SizeOf(LogFont), @LogFont);
    LogFont.lfHeight := SystemLogFont.lfHeight;
    with LogFont do
      if lfHeight > -11 then lfHeight := -11;
    EditFontHandle := CreateFontIndirect(LogFont);
  end
  else
    EditFontHandle := CloneFont(Font.Handle);
end;

function CloneFont(Source: HFONT): HFONT;
var
  LogFont: TLogFont;
begin
  GetObject(Source, SizeOf(LogFont), @LogFont);
  Result := CreateFontIndirect(LogFont);
end;

{ mouse tracking functions }

var
  FMouseTrackingWnd: HWND;
  FMouseTrackingTimerID: UINT;

function MouseTracking(AWnd: HWND): Boolean;
var
  Event: TTrackMouseEvent;
begin
  if @TrackMouseEvent <> nil then
  begin
    with Event do
    begin
      cbSize := SizeOf(Event);
      dwFlags := TME_QUERY;
      hwndTrack := AWnd;
    end;
    TrackMouseEvent(Event);
    Result := Event.dwFlags and TME_LEAVE <> 0;
  end
  else Result := AWnd = FMouseTrackingWnd;
end;

procedure FinishMouseTracking(AWnd: HWND);
var
  Event: TTrackMouseEvent;
begin
  if MouseTracking(AWnd) then
  begin
    if @TrackMouseEvent <> nil then
    begin
      with Event do
      begin
        cbSize := SizeOf(Event);
        dwFlags := TME_LEAVE or TME_CANCEL;
        hwndTrack := AWnd;
      end;
      TrackMouseEvent(Event);
    end
    else
    begin
      KillTimer(0, FMouseTrackingTimerID);
      FMouseTrackingTimerID := 0;
      FMouseTrackingWnd := 0;
    end;
    SendMessage(AWnd, WM_MOUSELEAVE, 0, 0);
  end;
end;

procedure MouseTrackingTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT; Time: DWORD); stdcall;
var
  P: TPoint;
begin
  GetCursorPos(P);
  Wnd := WindowFromPointEx(P);
  if Wnd <> FMouseTrackingWnd then
    FinishMouseTracking(FMouseTrackingWnd);
end;

procedure StartMouseTracking(AWnd: HWND);
var
  Event: TTrackMouseEvent;
begin
  if not MouseTracking(AWnd) then
    if @TrackMouseEvent <> nil then
    begin
      with Event do
      begin
        cbSize := SizeOf(Event);
        dwFlags := TME_LEAVE;
        hwndTrack := AWnd;
      end;
      TrackMouseEvent(Event);
    end
    else
    begin
      if FMouseTrackingWnd <> 0 then FinishMouseTracking(FMouseTrackingWnd);
      FMouseTrackingWnd := AWnd;
      FMouseTrackingTimerID := SetTimer(0, 0, 50, @MouseTrackingTimerProc);
    end;
end;

{ internal item list }

procedure ClearInternalItemList;
var
  I: Integer;
begin
  with InternalItemList do
    for I := Count - 1 downto 0 do
      with TdxBarItem(Items[I]) do
        if not HasControls then Free;
end;

{ test of mouse keys pressing }

function LeftButtonPressed: Boolean;
begin
  if GetSystemMetrics(SM_SWAPBUTTON) = 0 then
    Result := GetAsyncKeyState(VK_LBUTTON) < 0
  else
    Result := GetAsyncKeyState(VK_RBUTTON) < 0;
end;

function RightButtonPressed: Boolean;
begin
  if GetSystemMetrics(SM_SWAPBUTTON) = 0 then
    Result := GetAsyncKeyState(VK_RBUTTON) < 0
  else
    Result := GetAsyncKeyState(VK_LBUTTON) < 0;
end;

{ TdxBarToolbarsPopup }

type
  TdxBarToolbarsPopup = class(TdxBarSubMenuControl)
  protected
    function GetIsCustomizing: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

constructor TdxBarToolbarsPopup.Create(AOwner: TComponent);
begin
  ClearInternalItemList;
  inherited Create(AOwner);
  FItemLinks := TdxBarItemLinks.Create(BarManager);
  FItemLinks.FOwner := Self;
  BarManager.CreateToolbarsPopupList(FItemLinks);
  FItemLinks.FBarControl := Self;
end;

destructor TdxBarToolbarsPopup.Destroy;
begin
  Destroying;
  FItemLinks.Free;
  inherited Destroy;
end;

function TdxBarToolbarsPopup.GetIsCustomizing: Boolean;
begin
  Result := False;
end;

procedure ShowToolbarsPopup(Sender: TCustomControl; ABarManager: TdxBarManager; P: TPoint);
var
  ToolbarsPopup: TdxBarToolbarsPopup;
begin
  ToolbarsPopup := TdxBarToolbarsPopup.Create(ABarManager);
  with ToolbarsPopup do
    if FItemLinks.Count = 0 then Free
    else
    begin
      ABarManager.HideAll;
      Left := P.X;
      Top := P.Y;
      FShowAnimation := True;
      Show;
    end;
end;

{ TdxBarCustomizingPopup }

type
  TdxBarCustomizingPopup = class(TdxBarSubMenuControl)
  private
    procedure SetItemLink(Value: TdxBarItemLink);
    procedure TextItemChange(Sender: TObject);
    procedure ItemClick(Sender: TObject);
  protected
    procedure DoCloseUp; override;
    function GetIsCustomizing: Boolean; override;
    property ItemLink: TdxBarItemLink write SetItemLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FCustomizingPopupItemLink: TdxBarItemLink;
  CustomizedPopup: TdxBarCustomizingPopup;

function dxBarCustomizingPopup: TdxBarSubMenuControl;
begin
  Result := CustomizedPopup;
end;

function dxBarCustomizingPopupItemLink: TdxBarItemLink;
begin
  Result := FCustomizingPopupItemLink;
end;

constructor TdxBarCustomizingPopup.Create(AOwner: TComponent);
var
  FItemCount: Integer;
  I: Integer;
  ItemLink: TdxBarItemLink;
begin
  ClearInternalItemList;
  inherited Create(AOwner);
  FShowAnimation := False;
  FItemLinks := TdxBarItemLinks.Create(BarManager);
  FItemLinks.FOwner := Self;
  FItemCount := 8;
  if BarManager.Designing then
    Inc(FItemCount, 1 + Byte(BarManager.Style <> bmsStandard));
  for I := 0 to FItemCount - 1 do
  begin
    if I = 2 then
      InternalItemList.Add(TdxBarEdit.Create(nil))
    else
      InternalItemList.Add(TdxBarButton.Create(nil));
    with TdxBarItem(InternalItemList.Last) do
    begin
      Caption := LoadStr(DXBAR_CP_RESET + I);
      Tag := I;
      OnClick := ItemClick;
      if I in [3..6, 7, 8, 9] then
        with TdxBarButton(InternalItemList.Last) do
        begin
          ButtonStyle := bsChecked;
          if I in [3..6] then GroupIndex := dxBarCustomizingPopupPaintStyleGroupIndex;
        end;
    end;
    ItemLink := FItemLinks.Add;
    if I in [2, 3, 7] then ItemLink.BeginGroup := True;
    ItemLink.Item := TdxBarItem(InternalItemList.Last);
  end;
  FItemLinks.FBarControl := Self;
  BarManager.DoShowCustomizingPopup(FItemLinks);
end;

destructor TdxBarCustomizingPopup.Destroy;
begin
  Destroying;
  FItemLinks.Free;
  inherited Destroy;
end;

procedure TdxBarCustomizingPopup.SetItemLink(Value: TdxBarItemLink);
var
  CCPS: Boolean;
  I: Integer;
begin
  FCustomizingPopupItemLink := Value;
  with TdxBarEdit(ItemLinks[2].Item) do
  begin
    Text := Value.Caption;
    FOnChange := TextItemChange;
  end;  
  CCPS := (Value.Item is TdxBarButton) and TdxBarButton(Value.Item).CanChangePaintStyle;
  for I := 3 to 6 do
    with TdxBarButton(ItemLinks[I].Item) do
    begin
      Enabled := CCPS;
      Down :=
        CCPS and (Ord(Value.PaintStyle) = I - 3) or (not CCPS and (I = 3));
    end;
  with TdxBarButton(ItemLinks[7].Item) do
  begin
    Enabled := Value.Index > 0;
    Down := Value.BeginGroup;
  end;
  if ItemLinks.Count > 8 then
    with TdxBarButton(ItemLinks[8].Item) do
      Down := Value.Visible;
  if ItemLinks.Count > 9 then
    with TdxBarButton(ItemLinks[9].Item) do
      Down := Value.MostRecentlyUsed;
end;

procedure TdxBarCustomizingPopup.TextItemChange(Sender: TObject);
begin
  if TdxBarEdit(Sender).Text = '' then
  begin
    if dxBarCustomizingPopup <> nil then dxBarCustomizingPopup.Hide;
    Application.MessageBox(PChar(LoadStr(DXBAR_COMMANDNAMECANNOTBEBLANK)),
      PChar(Application.Title), MB_ICONSTOP);
  end
  else
    FCustomizingPopupItemLink.UserCaption := TdxBarEdit(Sender).Text;
end;

procedure TdxBarCustomizingPopup.ItemClick(Sender: TObject);
begin
  case TComponent(Sender).Tag of
    0: FCustomizingPopupItemLink.UserDefine := [];
    1: begin
         FCustomizingPopupItemLink.Free;
         FCustomizingPopupItemLink := nil;
       end;
    3..6:
      FCustomizingPopupItemLink.UserPaintStyle :=
        TdxBarPaintStyle(TComponent(Sender).Tag - 3);
    7: with FCustomizingPopupItemLink do
         BeginGroup := not BeginGroup;
    8: with FCustomizingPopupItemLink do
         Visible := not Visible;
    9: with FCustomizingPopupItemLink do
         MostRecentlyUsed := not MostRecentlyUsed;
  end;
end;

procedure TdxBarCustomizingPopup.DoCloseUp;
begin
  if FCustomizingPopupItemLink <> nil then
    with FCustomizingPopupItemLink do
      if not BarManager.FIsCustomizing and
        (BarControl <> nil) and (BarControl.SelectedItem = Control) then
      begin
        BarManager.FSelectedItem := nil;
        BarControl.SelectedItem := nil;
      end;
  inherited;
end;

function TdxBarCustomizingPopup.GetIsCustomizing: Boolean;
begin
  Result := False;
end;

{ TdxBarDropDownListBox }

type
  TdxBarDropDownListBox = class(TCustomListBox)
  private
    FCombo: TdxBarCustomCombo;
    WaitForCapture: Boolean;
    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
  protected
    procedure Click; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    property OnDrawItem;
    property OnMeasureItem;
  end;

constructor TdxBarDropDownListBox.Create(AOwner: TComponent);
begin
  inherited;
  Style := lbOwnerDrawVariable;
  Visible := False;
end;

procedure TdxBarDropDownListBox.WMCaptureChanged(var Message: TMessage);
begin
  inherited;
  WaitForCapture := False;
end;

procedure TdxBarDropDownListBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TdxBarDropDownListBox.WMLButtonUp(var Message: TWMLButtonUp);
var
  ACombo: TdxBarCustomCombo;
  AItemIndex: Integer;
  AItemLink, RealItemLink: TdxBarItemLink;
begin
  inherited;
  if WaitForCapture then
  begin
    ReleaseCapture;
    Exit;
  end;
  ACombo := FCombo;
  AItemIndex := ItemIndex;
  AItemLink := ACombo.CurItemLink;
  RealItemLink := AItemLink.RealItemLink;
  if RealItemLink <> nil then
  begin
    RealItemLink.BringToTopInRecentList(True);
    RealItemLink.BarManager.HideAll;
  end  
  else
    AItemLink.BarManager.HideAll;
  if AItemIndex > -1 then ACombo.ItemIndex := AItemIndex;
end;

procedure TdxBarDropDownListBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  InflateRect(Message.CalcSize_Params.rgrc[0], -2, -2);
end;

procedure TdxBarDropDownListBox.WMNCPaint(var Message: TWMNCPaint);
var
  R: TRect;
  DC: HDC;
begin
  inherited;
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  DC := GetWindowDC(Handle);
  if FCombo.Flat then
  begin
    FrameRect(DC, R, GetSysColorBrush(COLOR_BTNSHADOW));
    InflateRect(R, -1, -1);
    FrameRect(DC, R, GetSysColorBrush(COLOR_WINDOW));
  end
  else
    DrawEdge(DC, R, EDGE_RAISED, BF_RECT);
  ReleaseDC(Handle, DC);
end;

procedure TdxBarDropDownListBox.Click;
begin
  if ItemIndex > -1 then
    TdxBarComboControl(FCombo.CurItemLink.Control).LocalItemIndex := ItemIndex;
end;

procedure TdxBarDropDownListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
end;

procedure TdxBarDropDownListBox.CreateWnd;
begin
  inherited;
  Font.Handle := CloneFont(FCombo.CurItemLink.BarControl.EditFontHandle);
  Font.Color := clWindowText;
  Canvas.Font := Font;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, WM_SETFOCUS, 0, 0);
end;

procedure TdxBarDropDownListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (ItemIndex = -1) and (Items.Count > 0) then ItemIndex := TopIndex;
  inherited;
end;

procedure TdxBarDropDownListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  if (GetCapture = Handle) and WaitForCapture and PtInRect(ClientRect, Point(X, Y)) then
  begin
    WaitForCapture := False;
    CallWindowProc(DefWndProc, Handle, WM_LBUTTONDOWN, 0, MAKELPARAM(X, Y));
  end;
  inherited;
  I := ItemAtPos(Point(X, Y), True);
  if (0 <= I) and (I <= Items.Count - 1) then
    ItemIndex := I;
end;

{ TdxBarQuickCustItem and TdxBarQuickCustItemControl }

type
  TdxBarQuickCustItem = class(TdxBarButton)
  public
    procedure DoClick; override;
  end;

  TdxBarQuickCustItemControl = class(TdxBarButtonControl)
  private
    function GetLinkedItemLink: TdxBarItemLink;
  protected
    procedure ControlUnclick(ByMouse: Boolean); override;
    function GetCaption: string; override;
    function GetGlyph: TBitmap; override;
    function GetImageIndex: Integer; override;
    function GetImages: TCurImageList; override;
    function GetHint: string; override;
    function GetShortCut: TShortCut; override;
    function GetDefaultWidth: Integer; override;
    function IsDestroyOnClick: Boolean; override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;
    property LinkedItemLink: TdxBarItemLink read GetLinkedItemLink;
  end;

procedure TdxBarQuickCustItem.DoClick;
var
  ItemLink: TdxBarItemLink;
begin
  inherited;
  ItemLink := TdxBarItemLink(ClickItemLink.Data);
  with ItemLink do
    Visible := not Visible;
end;

function TdxBarQuickCustItemControl.GetLinkedItemLink: TdxBarItemLink;
begin
  Result := TdxBarItemLink(FItemLink.Data);
end;

procedure TdxBarQuickCustItemControl.ControlUnclick(ByMouse: Boolean);
begin
  inherited;
  Repaint;
end;

function TdxBarQuickCustItemControl.GetCaption: string;
begin
  Result := LinkedItemLink.Caption;
end;

function TdxBarQuickCustItemControl.GetGlyph: TBitmap;
begin
  Result := LinkedItemLink.Glyph;
end;

function TdxBarQuickCustItemControl.GetImageIndex: Integer;
begin
  Result := LinkedItemLink.Item.ImageIndex;
end;

function TdxBarQuickCustItemControl.GetImages: TCurImageList;
begin
  Result := LinkedItemLink.Item.BarManager.Images;
end;

function TdxBarQuickCustItemControl.GetHint: string;
begin
  Result := LinkedItemLink.Item.Hint;
end;

function TdxBarQuickCustItemControl.GetShortCut: TShortCut;
begin
  Result := LinkedItemLink.Item.ShortCut;
end;

function TdxBarQuickCustItemControl.GetDefaultWidth: Integer;
begin
  Result := inherited GetDefaultWidth;
  Inc(Result, GetDefaultHeight);
end;

function TdxBarQuickCustItemControl.IsDestroyOnClick: Boolean;
begin
  Result := False;
end;

procedure TdxBarQuickCustItemControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
var
  WholeR, R: TRect;
  DC: HDC;
  Selected: Boolean;
begin
  WholeR := ARect;
  R := ARect;
  DC := Parent.Canvas.Handle;
  Selected := IsSelected;
  with R do
  begin
    if Flat then
    begin
      if not Selected then
        FrameRect(DC,
          Rect(Left, Top, Left + (Bottom - Top), Bottom),
          BarManager.FlatToolbarsBrush);
      InflateRect(R, -1, -1);
    end;
    Right := Left + Bottom - Top;
  end;
  DrawGlyph(R, nil, ptMenu, True, Selected, LinkedItemLink.Visible, False, False,
    False, False);
  ARect.Left := R.Right + Byte(Flat);
  inherited;
  if Flat and Selected then
  begin
    FrameFlatSelRect(DC, WholeR);
    with R do
    begin
      Left := Right;
      Right := Left + 2;
    end;
    FillRect(DC, R, Parent.ToolbarSelBrush);
  end;
end;

{ TdxBarQuickCustExtButtonControl }

type
  TdxBarQuickCustExtButton = class(TdxBarButton);

  TdxBarQuickCustExtButtonControl = class(TdxBarButtonControl)
  protected
    function GetTextAreaOffset: Integer; override;
    function GetDefaultWidth: Integer; override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;
  end;

function TdxBarQuickCustExtButtonControl.GetTextAreaOffset: Integer;
begin
  Result := inherited GetTextAreaOffset + GetDefaultHeight;
end;

function TdxBarQuickCustExtButtonControl.GetDefaultWidth: Integer;
begin
  Result := inherited GetDefaultWidth;
  Inc(Result, GetDefaultHeight);
end;

procedure TdxBarQuickCustExtButtonControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
var
  WholeR, R: TRect;
  DC: HDC;
  Selected: Boolean;
  Brush: HBRUSH;
begin
  WholeR := ARect;
  R := ARect;
  DC := Parent.Canvas.Handle;
  Selected := IsSelected;
  with R do
  begin
    if Flat and Selected then InflateRect(R, -1, -1);
    Right := Left + Bottom - Top + Byte(Flat and Selected);
  end;
  if Selected then
    Brush := Parent.ToolbarSelBrush
  else
    if Flat then
      Brush := BarManager.FlatToolbarsBrush
    else
      Brush := COLOR_BTNFACE + 1;
  FillRect(DC, R, Brush);
  ARect.Left := R.Right;
  inherited;
  if Flat and Selected then
  begin
    FrameFlatSelRect(DC, WholeR);
    with R do
    begin
      Left := Right;
      Right := Left + 1;
    end;
    FillRect(DC, R, Parent.ToolbarSelBrush);
  end;
end;

{ TdxBarQuickControl }

type
  TdxBarQuickControl = class(TdxBarControl)
  private
    FAddRemoveSubItem: TdxBarSubItem;
    FOwnerBar: TdxBarControl;
    FQuickCustItem: TdxBarQuickCustItem;
    procedure AddRemoveSubItemPopup(Sender: TObject);
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
  protected
    function GetToolbarBrush: HBRUSH; override;
    function HideOnClick: Boolean; override;
  public
    constructor CreateWithOwnerBar(AOwner: TComponent; AOwnerBar: TdxBarControl);
    destructor Destroy; override;
    procedure HideAll; override;
    procedure Popup(const OwnerR: TRect);
  end;

var
  QuickCustBar: TdxBarQuickControl;
  HideQuickCustBarTimer: UINT;

procedure FinishHideQuickCustBar;
begin
  if HideQuickCustBarTimer <> 0 then
  begin
    KillTimer(0, HideQuickCustBarTimer);
    HideQuickCustBarTimer := 0;
  end;
end;

procedure HideQuickCustBarTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT; Time: DWORD); stdcall;
begin
  FinishHideQuickCustBar;
  if (QuickCustBar <> nil) and (QuickCustBar.BarManager.SelectedItem <> nil) and
    (GetParentBarForControl(QuickCustBar.BarManager.SelectedItem) <> QuickCustBar) then
    try
      QuickCustBar.FOwnerBar.MarkState := msNone;
    except
    end;
end;

procedure StartHideQuickCustBar;
begin
  if HideQuickCustBarTimer = 0 then
    HideQuickCustBarTimer := SetTimer(0, 0, 200, @HideQuickCustBarTimerProc);
end;

constructor TdxBarQuickControl.CreateWithOwnerBar(AOwner: TComponent; AOwnerBar: TdxBarControl);
var
  I: Integer;
  ItemLink: TdxBarItemLink;
begin
  ClearInternalItemList;
  inherited Create(AOwner);
  QuickCustBar := Self;
  FHasCaption := False;
  FOwnerBar := AOwnerBar;
  OwnerBounds := FOwnerBar.MarkScreenRect;

  FBar := BarManager.Bars.Add;
  FBar.FAllowQuickCustomizing := False;
  FBar.Hidden := True;
  FBar.Font := FOwnerBar.Font;
  FBar.UseOwnFont := FOwnerBar.Bar.UseOwnFont;
  FItemLinks := FBar.ItemLinks;
  FItemLinks.FBarControl := Self;

  // add links to available items
  FAddRemoveSubItem := TdxBarSubItem.Create(BarManager.MainForm);
  with FAddRemoveSubItem do
  begin
    Caption := LoadStr(DXBAR_ADDREMOVEBUTTONS);
    Enabled := FOwnerBar.Bar.AllowQuickCustomizing;
    if Enabled then OnPopup := AddRemoveSubItemPopup;
  end;  
  InternalItemList.Add(FAddRemoveSubItem);

  for I := 0 to FOwnerBar.ItemLinks.CanVisibleItemCount - 1 do
  begin
    ItemLink := FOwnerBar.ItemLinks.CanVisibleItems[I];
    if (ItemLink.VisibleIndex = -1) or
      (ItemLink.Control <> nil) and IsRectEmpty(ItemLink.ItemRect) then
    begin
      FItemLinks.Add.Assign(ItemLink);
      FItemLinks[FItemLinks.Count - 1].FOriginalItemLink := ItemLink;
    end;
  end;
  with FItemLinks.Add do
  begin
    Item := FAddRemoveSubItem;
    BeginGroup := True;
  end;
end;

destructor TdxBarQuickControl.Destroy;
begin
  FinishHideQuickCustBar;
  QuickCustBar := nil;
  inherited;
  if FQuickCustItem <> nil then
  begin
    FQuickCustItem.Free;
    FQuickCustItem := nil;
  end;
  FBar.Free;
end;

procedure TdxBarQuickControl.AddRemoveSubItemPopup(Sender: TObject);
var
  I: Integer;
  ItemLink: TdxBarItemLink;
  AllowReset: Boolean;
begin
  ClearInternalItemList;
  FAddRemoveSubItem.ItemLinks.Clear;
  
  FQuickCustItem := TdxBarQuickCustItem.Create(BarManager.MainForm);
  for I := 0 to FOwnerBar.ItemLinks.AvailableItemCount - 1 do
  begin
    ItemLink := FOwnerBar.ItemLinks.AvailableItems[I];
    if (ItemLink.Control = nil) or ItemLink.Control.CanCustomize then
      with FAddRemoveSubItem.ItemLinks.Add do
      begin
        Item := FQuickCustItem;
        Data := Integer(ItemLink);
      end;
  end;
  // add reset button
  AllowReset := BarManager.CanReset and FOwnerBar.Bar.CanReset;
  if AllowReset then
  begin
    InternalItemList.Add(TdxBarQuickCustExtButton.Create(BarManager.MainForm));
    with TdxBarButton(InternalItemList.Last) do
    begin
      Caption := LoadStr(DXBAR_RESETTOOLBAR);
      OnClick := FOwnerBar.Bar.ResetToolbarClick;
    end;
    with FAddRemoveSubItem.ItemLinks.Add do
    begin
      BeginGroup := True;
      Item := TdxBarButton(InternalItemList.Last);
    end;
  end;
  // add customize button
  BarManager.AddCustomizeLink(FAddRemoveSubItem.ItemLinks,
    not AllowReset, TdxBarQuickCustExtButton);
end;

procedure TdxBarQuickControl.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  with Message do
    if Result <> HTCLIENT then Result := HTBORDER;
  FHitTest := HTCLIENT;
end;

procedure TdxBarQuickControl.WMNCPaint(var Message: TMessage);
var
  DC: HDC;
begin
  inherited;
  DC := GetWindowDC(Handle);
  DrawOwnerLink(DC);
  ReleaseDC(Handle, DC);
end;

procedure TdxBarQuickControl.WMRButtonDown(var Message: TWMRButtonDown);
begin
  with TMessage(Message) do
    Result := DefWindowProc(Handle, Msg, wParam, lParam);
end;

procedure TdxBarQuickControl.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if (Message.WindowPos^.flags and SWP_HIDEWINDOW <> 0) and not IsDestroying then
    FOwnerBar.MarkState := msNone;
end;

function TdxBarQuickControl.GetToolbarBrush: HBRUSH;
begin
  if Flat then
    Result := GetSysColorBrush(COLOR_WINDOW)
  else
    Result := inherited GetToolbarBrush;
end;

function TdxBarQuickControl.HideOnClick: Boolean;
begin
  Result := True;
end;

procedure TdxBarQuickControl.HideAll;
var
  WasFocused: Boolean;
  P: TPoint;
begin
  WasFocused := BarManager.FocusedBarControl = Self;
  inherited;
  if WasFocused then
  begin
    if LeftButtonPressed then
    begin
      GetCursorPos(P);
      Windows.ScreenToClient(FOwnerBar.Handle, P);
      if PtInRect(FOwnerBar.MarkRect, P) then
        FOwnerBar.FIgnoreMouseClick := True;
    end;
    FOwnerBar.MarkState := msNone;
  end;
end;

procedure TdxBarQuickControl.Popup(const OwnerR: TRect);
var
  P, l_Size: TPoint;
  WorkArea: TRect;
begin
  l_Size := GetSizeForWidth(dsNone, 0);
  Inc(l_Size.X, 2 * BarManager.BorderSizeX);
  Inc(l_Size.Y, 2 * BarManager.BorderSizeY);
  if IsRealVertical(FOwnerBar) then
    P := Point(OwnerR.Right, OwnerR.Top)
  else
    if (FOwnerBar.DockingStyle = dsNone) and Flat then
      P := Point(OwnerR.Left, OwnerR.Bottom)
    else
      P := Point(OwnerR.Right - l_Size.X, OwnerR.Bottom);
  WorkArea := GetWorkArea(P);
  if IsRealVertical(FOwnerBar) then
  begin
    if P.X + l_Size.X > WorkArea.Right then P.X := OwnerR.Left - l_Size.X;
    if P.Y < WorkArea.Top then P.Y := WorkArea.Top;
    if P.Y + l_Size.Y > WorkArea.Bottom then P.Y := WorkArea.Bottom - l_Size.Y;
  end
  else
  begin
    if P.X < WorkArea.Left then P.X := WorkArea.Left;
    if P.X + l_Size.X > WorkArea.Right then P.X := WorkArea.Right - l_Size.X;
    if P.Y + l_Size.Y > WorkArea.Bottom then P.Y := OwnerR.Top - l_Size.Y;
  end;
  SetWindowPos(Handle, HWND_TOP, P.X, P.Y, l_Size.X, l_Size.Y,
    SWP_SHOWWINDOW or SWP_NOACTIVATE);
end;

{ TdxBarManagerCategories }

type
  PdxBarCategoryData = ^TdxBarCategoryData;
  TdxBarCategoryData = record
    ItemsVisible, LoadedItemsVisible: TdxBarItemVisible;
    Visible: Boolean;
  end;

  TdxBarManagerCategories = class(TStringList)
  private
    FMoving: Boolean;
    Owner: TdxBarManager;
    procedure ListChanged(Sender: TObject);
    procedure ChangeCategory(OldCategory, NewCategory: Integer);
    procedure ReadItemsVisibles(Reader: TReader);
    procedure ReadVisibles(Reader: TReader);
    procedure WriteItemsVisibles(Writer: TWriter);
    procedure WriteVisibles(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TdxBarManager);
    destructor Destroy; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Exchange(Index1, Index2: Integer); override;
    procedure Move(CurIndex, NewIndex: Integer); override;
  end;

constructor TdxBarManagerCategories.Create(AOwner: TdxBarManager);
begin
  inherited Create;
  Owner := AOwner;
  if not Owner.IsLoading then
    Add(LoadStr(DXBAR_DEFAULTCATEGORYNAME));
  OnChange := ListChanged;
end;

destructor TdxBarManagerCategories.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Objects[I] <> nil then
    begin
      Dispose(PdxBarCategoryData(Objects[I]));
      Objects[I] := nil;
    end;
  inherited;
end;

procedure TdxBarManagerCategories.ListChanged(Sender: TObject);
begin
  Owner.DesignerModified;
end;

procedure TdxBarManagerCategories.ChangeCategory(OldCategory, NewCategory: Integer);
var
  List: TList;
  I: Integer;
begin
  if (OldCategory > -1) and (OldCategory < Count) and (NewCategory > -1) then
  begin
    List := TList.Create;
    Owner.GetAllItemsByCategory(OldCategory, List);
    for I := 0 to List.Count - 1 do
      TdxBarItem(List[I]).FCategory := NewCategory;
    List.Free;
  end;
end;

procedure TdxBarManagerCategories.ReadItemsVisibles(Reader: TReader);
var
  I: Integer;
begin
  Reader.ReadListBegin;
  try
    BeginUpdate;
    try
      for I := 0 to Count - 1 do
      begin
        if Reader.EndOfList then Break;
        Owner.CategoryItemsVisible[I] := TdxBarItemVisible(Reader.ReadInteger);
      end;
    finally
      EndUpdate;
    end;
  finally
    Reader.ReadListEnd;
  end;  
end;

procedure TdxBarManagerCategories.ReadVisibles(Reader: TReader);
var
  I: Integer;
begin
  Reader.ReadListBegin;
  try
    BeginUpdate;
    try
      for I := 0 to Count - 1 do
      begin
        if Reader.EndOfList then Break;
        Owner.CategoryVisible[I] := Reader.ReadBoolean;
      end;
    finally
      EndUpdate;
    end;
  finally
    Reader.ReadListEnd;
  end;  
end;

procedure TdxBarManagerCategories.WriteItemsVisibles(Writer: TWriter);
var
  I: Integer;
begin
  Writer.WriteListBegin;
  try
    for I := 0 to Count - 1 do
      Writer.WriteInteger(Longint(Owner.CategoryItemsVisible[I]));
  finally
    Writer.WriteListEnd;
  end;
end;

procedure TdxBarManagerCategories.WriteVisibles(Writer: TWriter);
var
  I: Integer;
begin
  Writer.WriteListBegin;
  try
    for I := 0 to Count - 1 do
      Writer.WriteBoolean(Owner.CategoryVisible[I]);
  finally
    Writer.WriteListEnd;
  end;
end;

procedure TdxBarManagerCategories.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ItemsVisibles', ReadItemsVisibles, WriteItemsVisibles, True);
  Filer.DefineProperty('Visibles', ReadVisibles, WriteVisibles, True);
end;

procedure TdxBarManagerCategories.Delete(Index: Integer);
var
  List: TList;
  I: Integer;
begin
  if FMoving then inherited
  else
  begin
    if (Index > -1 ) and (Index < Count) then
    begin
      List := TList.Create;
      Owner.GetAllItemsByCategory(Index, List);
      for I := 0 to List.Count - 1 do TdxBarItem(List[I]).Free;
      List.Free;
      for I := Index + 1 to Count - 1 do ChangeCategory(I, I - 1);
      if Objects[Index] <> nil then Dispose(PdxBarCategoryData(Objects[Index]));
      inherited;
    end;
    if Count = 0 then
      Add(LoadStr(DXBAR_DEFAULTCATEGORYNAME));
  end;    
end;

procedure TdxBarManagerCategories.Insert(Index: Integer; const S: string);
var
  I: Integer;
begin
  if not FMoving and (Index > -1) and (Index < Count) then
    for I := Count - 1 downto Index do ChangeCategory(I, I + 1);
  inherited Insert(Index, S);
end;

procedure TdxBarManagerCategories.Exchange(Index1, Index2: Integer);
var
  I: Integer;
  List1: TList;
  List2: TList;
begin
  if (Index1 > -1) and (Index1 < Count) and
    (Index2 > -1) and (Index2 < Count) then
  begin
    List1 := TList.Create;
    List2 := TList.Create;
    Owner.GetAllItemsByCategory(Index1, List1);
    Owner.GetAllItemsByCategory(Index2, List2);
    for I := 0 to List1.Count - 1 do
      TdxBarItem(List1[I]).Category := Index2;
    for I := 0 to List2.Count - 1 do
      TdxBarItem(List2[I]).Category := Index1;
    List2.Free;
    List1.Free;
    inherited Exchange(Index1, Index2);
  end;
end;

procedure TdxBarManagerCategories.Move(CurIndex, NewIndex: Integer);
var
  List: TList;
  I: Integer;
begin
  if (0 <= CurIndex) and (CurIndex < Count) and
    (0 <= NewIndex) and (NewIndex < Count) and
    (CurIndex <> NewIndex) then
  begin
    List := TList.Create;
    Owner.GetAllItemsByCategory(CurIndex, List);
    for I := 0 to List.Count - 1 do
      TdxBarItem(List[I]).FCategory := dxBarManagerTempCategoryIndex;
    if CurIndex < NewIndex then
      for I := CurIndex + 1 to NewIndex do
        ChangeCategory(I, I - 1)
    else
      for I := CurIndex - 1 downto NewIndex do
        ChangeCategory(I, I + 1);
    for I := 0 to List.Count - 1 do
      TdxBarItem(List[I]).FCategory := NewIndex;
    List.Free;
    FMoving := True;
    inherited Move(CurIndex, NewIndex);
    FMoving := False;
  end;
end;

{ TdxBarHintWindow }

constructor TdxBarHintWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clInfoBk;
  Canvas.Brush.Style := bsClear;
end;

procedure TdxBarHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP or WS_DISABLED;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
  end;
end;

procedure TdxBarHintWindow.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  DrawEdge(Canvas.Handle, R, BDR_RAISEDOUTER, BF_RECT);
  InflateRect(R, -1, -1);
  Inc(R.Left, 2);
  Inc(R.Top, 2);
  DrawText(Canvas.Handle, PChar(Caption), -1, R,
    DT_LEFT or DT_NOCLIP or DT_NOPREFIX or DT_WORDBREAK);
end;

procedure TdxBarHintWindow.ActivateHint(P: TPoint; const AHint: string; BarManager: TdxBarManager);
var
  NonClientMetrics: TNonClientMetrics;
  R, WorkArea: TRect;
begin
  Caption := AHint;

  if BarManager.UseSystemFont then
  begin
    NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
    if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
      Canvas.Font.Handle := CreateFontIndirect(NonClientMetrics.lfStatusFont)
    else
      Canvas.Font.Size := 8;
  end
  else Canvas.Font := BarManager.Font;
  Canvas.Font.Color := clInfoText;

  WorkArea := GetWorkArea(P);
  R := Rect(0, 0, WorkArea.Right - WorkArea.Left, 0);
  DrawText(Canvas.Handle, PChar(AHint), -1, R, DT_CALCRECT or DT_LEFT or
    DT_NOPREFIX or DT_WORDBREAK);
  Inc(R.Right, 2 * (1 + 2));
  Inc(R.Bottom, 2 * (1 + 2));
  Width := R.Right;
  Height := R.Bottom;
  OffsetRect(R, P.X, P.Y);

  if R.Left + Width > WorkArea.Right then
    R.Left := WorkArea.Right - Width;
  if R.Top + Height > WorkArea.Bottom then
    R.Top := P.Y - 5 * HintOffset div 2;
  if R.Left < WorkArea.Left then R.Left := WorkArea.Left;
  if R.Top < WorkArea.Top then R.Top := WorkArea.Top;

  InvalidateRect(Handle, nil, True);
  SetWindowPos(Handle, HWND_TOPMOST, R.Left, R.Top, 0,
    0, SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE);
end;

{ TdxBarGroup }

constructor TdxBarGroup.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := True;
  FItems := TList.Create;
  FVisible := ivAlways;
end;

destructor TdxBarGroup.Destroy;
begin
  FBarManager.RemoveGroup(Self);
  FItems.Free;
  inherited;
end;

function TdxBarGroup.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxBarGroup.GetIndex: Integer;
begin
  Result := FBarManager.FGroups.IndexOf(Self);
end;

function TdxBarGroup.GetItem(Index: Integer): TComponent;
begin
  Result := TComponent(FItems[Index]);
end;

procedure TdxBarGroup.SetEnabled(Value: Boolean);
var
  PrevLockUpdate: Boolean;
  I: Integer;
  Item: TComponent;
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    PrevLockUpdate := FBarManager.LockUpdate;
    if [csLoading, csDestroying] * ComponentState = [] then
      FBarManager.LockUpdate := True;
    try
      for I := 0 to Count - 1 do
      begin
        Item := Items[I];
        if Item is TdxBarItem then
          TdxBarItem(Item).Enabled := Value
        else
          TdxBarGroup(Item).Enabled := Value;
      end;
    finally
      FBarManager.LockUpdate := PrevLockUpdate;
    end;
  end;
end;

procedure TdxBarGroup.SetIndex(Value: Integer);
begin
  if Index <> Value then
    FBarManager.FGroups.Move(Index, Value);
end;

procedure TdxBarGroup.SetVisible(Value: TdxBarItemVisible);
var
  PrevLockUpdate: Boolean;
  I: Integer;
  Item: TComponent;
begin
//  if FVisible <> Value then {V}
  begin
    FVisible := Value;
    PrevLockUpdate := FBarManager.LockUpdate;
    if [csLoading, csDestroying] * ComponentState = [] then
      FBarManager.LockUpdate := True;
    try
      for I := 0 to Count - 1 do
      begin
        Item := Items[I];
        if Item is TdxBarItem then
          TdxBarItem(Item).Visible := Value
        else
          TdxBarGroup(Item).Visible := Value;
      end;
    finally
      FBarManager.LockUpdate := PrevLockUpdate;
    end;
  end;
end;

procedure TdxBarGroup.ReadItems(Reader: TReader);
begin
  FItemsNames := TStringList.Create;
  Reader.ReadListBegin;
  try
    while not Reader.EndOfList do
      FItemsNames.Add(Reader.ReadString);
  finally
    Reader.ReadListEnd;
  end;
end;

procedure TdxBarGroup.WriteItems(Writer: TWriter);
var
  I: Integer;
begin
  Writer.WriteListBegin;
  try
    for I := 0 to Count - 1 do
      Writer.WriteString(Items[I].Name);
  finally
    Writer.WriteListEnd;
  end;
end;

procedure TdxBarGroup.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Items', ReadItems, WriteItems, Count <> 0);
end;

procedure TdxBarGroup.Loaded;
var
  I: Integer;
  AItem: TComponent;
begin
  inherited;
  if FItemsNames = nil then Exit;
  try
    for I := 0 to FItemsNames.Count - 1 do
    begin
      AItem := FBarManager.MainForm.FindComponent(FItemsNames[I]);
      if AItem <> nil then Add(AItem);
    end;
  finally
    FItemsNames.Free;
  end;
end;

procedure TdxBarGroup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent <> Self) and
    ((AComponent is TdxBarItem) or (AComponent is TdxBarGroup)) then
    Remove(AComponent);
end;

procedure TdxBarGroup.SetName(const NewName: TComponentName);
begin
  inherited;
  UpdateGroups;
end;

procedure TdxBarGroup.SetParentComponent(AParent: TComponent);
begin
  inherited;
  if AParent is TdxBarManager then
    TdxBarManager(AParent).AddGroup(Self);
end;

function TdxBarGroup.GetParentComponent: TComponent;
begin
  Result := FBarManager;
end;

function TdxBarGroup.HasParent: Boolean;
begin
  Result := FBarManager <> nil;
end;

procedure TdxBarGroup.Add(AItem: TComponent);

  function IsRecursive(AItem: TComponent): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if AItem is TdxBarGroup then
    begin
      Result := AItem = Self;
      if not Result then
        with TdxBarGroup(AItem) do
          for I := 0 to Count - 1 do
          begin
            Result := IsRecursive(Items[I]);
            if Result then Break;
          end;
    end;      
  end;

begin
  if (AItem = nil) or (IndexOf(AItem) <> -1) or
    not ((AItem is TdxBarItem) or (AItem is TdxBarGroup)) then Exit;
  if IsRecursive(AItem) then
    raise Exception.Create(LoadStr(DXBAR_RECURSIVEGROUPS));
  FItems.Add(AItem);
  AItem.FreeNotification(Self);
end;

procedure TdxBarGroup.Delete(Index: Integer);
begin
  FItems.Delete(Index);
end;

function TdxBarGroup.IndexOf(AItem: TComponent): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

procedure TdxBarGroup.Move(FromIndex, ToIndex: Integer);
begin
  FItems.Move(FromIndex, ToIndex);
end;

procedure TdxBarGroup.Remove(AItem: TComponent);
begin
  FItems.Remove(AItem);
end;

{ TdxBarPopupMenuLink }

function TdxBarPopupMenuLink.GetBarManager: TdxBarManager;
begin
  Result := TdxBarPopupMenuLinks(Collection).BarManager;
end;

procedure TdxBarPopupMenuLink.SetControl(Value: TWinControl);
begin
  if FControl <> Value then
  begin
    if (Value <> nil) and (GetParentForm(Value) <> BarManager.MainForm) then
      Value := nil;
    FControl := Value;
    if Value <> nil then Value.FreeNotification(BarManager);
  end;
end;

procedure TdxBarPopupMenuLink.SetPopupMenu(Value: TdxBarPopupMenu);
begin
  if FPopupMenu <> Value then
  begin
    FPopupMenu := Value;
    if Value <> nil then Value.FreeNotification(BarManager);
  end;
end;

function TdxBarPopupMenuLink.IsShortCut(AShortCut: TShortCut): Boolean;
var
  X, Y: Integer;
begin
  Result := FPopupMenu <> nil;
  if Assigned(FOnAction) then
  begin
    X := -1;
    Y := -1;
    FOnAction(Self, X, Y, False, Result);
  end;
  if Result then
    Result := (FPopupMenu <> nil) and FPopupMenu.IsShortCut(AShortCut);
end;

procedure TdxBarPopupMenuLink.Assign(Source: TPersistent);
begin
  if Source is TdxBarPopupMenuLink then
  begin
    Control := TdxBarPopupMenuLink(Source).Control;
    PopupMenu := TdxBarPopupMenuLink(Source).PopupMenu
  end
  else inherited Assign(Source);
end;

function TdxBarPopupMenuLink.DoAction(Wnd: HWND; P: TPoint): Boolean;
var
  Msg: TMsg;
  ClickedByMouse: Boolean;
{$IFDEF DELPHI5}
  PrevP: TPoint;
{$ENDIF}
begin
  PeekMessage(Msg, Wnd, WM_CONTEXTMENU, WM_CONTEXTMENU, PM_REMOVE);
  ClickedByMouse := P.X <> -1;
  if ClickedByMouse then
  begin
    ScreenToClient(Wnd, P);
  {$IFDEF DELPHI5}
    PrevP := P;
    MapWindowPoints(Wnd, FControl.Handle, PrevP, 1);
  {$ENDIF}
  end
  else
  begin
  {$IFDEF DELPHI5}
    PrevP := P;
  {$ENDIF}
    if HideCaret(Wnd) then
    begin
      ShowCaret(Wnd);
      GetCaretPos(P);
    end
    else
      P := Point(0, 0);
  end;
{$IFDEF DELPHI5}
  Result := False;
  TDummyControl(FControl).DoContextPopup(PrevP, Result);
  if Result then Exit;
{$ENDIF}
  Result := FPopupMenu <> nil;
  if Assigned(FOnAction) then
  begin
    MapWindowPoints(Wnd, FControl.Handle, P, 1);
    FOnAction(Self, P.X, P.Y, ClickedByMouse, Result);
    MapWindowPoints(FControl.Handle, Wnd, P, 1);
  end;
  if Result and (FPopupMenu <> nil) then
  begin
    if IsWindowEnabled(Wnd) then SetFocus(Wnd);
    ClientToScreen(Wnd, P);
    FPopupMenu.Popup(P.X, P.Y);
  end;
end;

{ TdxBarPopupMenuLinks }

constructor TdxBarPopupMenuLinks.Create(ABarManager: TdxBarManager);
begin
  inherited Create(TdxBarPopupMenuLink);
  FBarManager := ABarManager;
end;

function TdxBarPopupMenuLinks.GetItem(Index: Integer): TdxBarPopupMenuLink;
begin
  Result := TdxBarPopupMenuLink(inherited GetItem(Index));
end;

procedure TdxBarPopupMenuLinks.SetItem(Index: Integer; Value: TdxBarPopupMenuLink);
begin
  inherited SetItem(Index, Value);
end;
                                
function TdxBarPopupMenuLinks.GetOwner: TPersistent;
begin
  Result := FBarManager;
end;

function TdxBarPopupMenuLinks.IsShortCut(AControl: TWinControl;
  AShortCut: TShortCut): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if Items[I].Control = AControl then
    begin
      Result := Items[I].IsShortCut(AShortCut);
      if Result then Break;
    end;
end;

function TdxBarPopupMenuLinks.Add: TdxBarPopupMenuLink;
begin
  Result := TdxBarPopupMenuLink(inherited Add);
end;

function TdxBarPopupMenuLinks.DoAction(AControl: TWinControl; Wnd: HWND;
  const P: TPoint): Boolean;
var
  I: Integer;
begin
  Result := False;
  if FBarManager.Designing then Exit;
  for I := 0 to Count - 1 do
    if Items[I].Control = AControl then
    begin
      Result := Items[I].DoAction(Wnd, P);
      if Result then Break;
    end;
end;

{ TdxBarManager }

var
  KeyboardHookHandle: HHOOK;
  MouseHookHandle: HHOOK;
  WndProcHookHandle: HHOOK;
  EatKey, WaitForMenu, DontCallNextKeybHook: Boolean;
  EatingKey: WPARAM;
  InMouseHook: Boolean;
  AClassName: PChar;

  FDockTimerID: UINT;
  FDockBarManager: TdxBarManager;

  FHintWindow: TdxBarHintWindow;
  FHintWindowShowing: Boolean;
  FHintTimerID, FHiddenHintTimerID: UINT;
  FCustomHint: string;
  FLiveHiddenHint: Boolean;

  AnimatingSubMenu: TdxBarSubMenuControl;

procedure KillHintTimer;
begin
  if FHintTimerID <> 0 then
  begin
    KillTimer(0, FHintTimerID);
    FHintTimerID := 0;
  end;
end;

procedure KillHiddenHintTimer;
begin
  if FHiddenHintTimerID <> 0 then
  begin
    KillTimer(0, FHiddenHintTimerID);
    FHiddenHintTimerID := 0;
    FLiveHiddenHint := False;
  end;
end;

function dxBarKeyboardHook(Code: Integer; wParam: WParam; lParam: LParam): LRESULT; stdcall;
const
  KeyMessages: array[Boolean] of Integer = (WM_KEYUP, WM_KEYDOWN);
var
  AControl: TWinControl;
  AForm: TCustomForm;
  ABarManager: TdxBarManager;
  AKeyPressed: Boolean;
  //Msg: TMsg;
  Res: LRESULT;
  APopupMenuLinks: TdxBarPopupMenuLinks;

  function GetPopupMenuLinksForFocusedWindow(var AControl: TWinControl): TdxBarPopupMenuLinks;
  var
    ABarManager: TdxBarManager;
  begin
    Result := nil;
    AControl := FindVCLControl(GetFocus);
    if AControl <> nil then
    begin
      ABarManager := GetBarManagerByForm(GetParentForm(AControl));
      if ABarManager <> nil then
        Result := ABarManager.PopupMenuLinks;
    end;
  end;

  function KeyPressed: Boolean;
  var
    KS: TKeyboardState;
    I: Integer;
  begin
    GetKeyboardState(KS);
    for I := Low(KS) to High(KS) do
    begin
      Result := KS[I] and 128 <> 0;
      if Result then Break;
    end;
  end;

  function ShiftState: TShiftState;
  begin
    Result := [];
    if GetAsyncKeyState(VK_SHIFT) < 0 then Result := Result + [ssShift];
    if GetAsyncKeyState(VK_CONTROL) < 0 then Result := Result + [ssCtrl];
    if GetAsyncKeyState(VK_MENU) < 0 then Result := Result + [ssAlt];
  end;

  procedure HandleKey;
  var
    Shift: TShiftState;
    AItemLink: TdxBarItemLink;
    UniqueItem: Boolean;

    function IsShortCutUsed: Boolean;
    var
      ShortCut: TShortCut;
      AControl: TWinControl;
      APopupMenuLinks: TdxBarPopupMenuLinks;
      I: Integer;
    begin
      ShortCut := Byte(wParam);
      if GetAsyncKeyState(VK_SHIFT) < 0 then Inc(ShortCut, scShift);
      if GetAsyncKeyState(VK_CONTROL) < 0 then Inc(ShortCut, scCtrl);
      if GetAsyncKeyState(VK_MENU) < 0 then Inc(ShortCut, scAlt);

      APopupMenuLinks := GetPopupMenuLinksForFocusedWindow(AControl);
      if (APopupMenuLinks <> nil) and
        APopupMenuLinks.IsShortCut(AControl, ShortCut) then
      begin
        Result := True;
        Exit;
      end;
      
      with ABarManager do
      begin
        if MainMenuBar = nil then
          Result := False
        else
          Result := MainMenuBar.IsShortCut(ShortCut);
        if not Result then
          for I := 0 to Bars.Count - 1 do
            if Bars[I].Visible and not Bars[I].IsMainMenu then
            begin
              Result := Bars[I].IsShortCut(ShortCut);
              if Result then Break;
            end;
      end;
    end;

    function GlobalFindItemWithAccel: TdxBarItemLink;
    var
      I: Integer;
    begin
      with ABarManager do
      begin
        if MainMenuControl <> nil then
          Result := MainMenuBar.ItemLinks.FindItemWithAccel(wParam, Shift, nil)
        else
          Result := nil;
        if Result = nil then
          for I := 0 to Bars.Count - 1 do
            if Bars[I].Visible and not Bars[I].IsMainMenu then
            begin
              Result := Bars[I].ItemLinks.FindItemWithAccel(wParam, Shift, nil);
              if Result <> nil then Break;
            end;
      end;
    end;

  begin
    if IsShortCutUsed then
      Result := 1
    else
      if GetAsyncKeyState(VK_MENU) < 0 then
      begin
        Shift := ShiftState - [ssAlt];
        AItemLink := GlobalFindItemWithAccel;
        if (AItemLink <> nil) and AItemLink.Item.Enabled then
          with AItemLink do
          begin
            UniqueItem := Owner.FindItemWithAccel(wParam, Shift, AItemLink) = AItemLink;
            if not Control.IsDestroyOnClick or not UniqueItem then
              TdxBarControl(BarControl).BarGetFocus(Control);
            if UniqueItem then
            begin
              if Control is TdxBarSubItemControl then
                TdxBarControl(BarControl).IsDowned := True;
              Control.Click(False);
            end;
            Result := 1;
          end;
      end;
  end;

begin
  Result := 0;
  try
    if FIsMDIButtonPressed then
    begin
      Result := 1;
      Exit;
    end;

    if wParam = VK_PROCESSKEY then Exit;  // for Korean windows

    if Code >= 0 then
    begin
      if EatKey and (wParam = EatingKey) and ((lParam shr 31) and 1 <> 0) then  // release eating key
      begin
        EatKey := False;
        Result := 1;
        Exit;
      end;

      if (ActiveBarControl <> nil) and
        not ActiveBarControl.BarManager.FDetachingSubMenu then
        if not ActiveBarControl.IsCustomizing then
          with ActiveBarControl do
            if not (SelectedItem is TdxBarWinControl and
              TdxBarWinControl(SelectedItem).Focused) then
            begin
              //PeekMessage(Msg, GetFocus, WM_CONTEXTMENU, WM_CONTEXTMENU, PM_REMOVE);
              AKeyPressed := (lParam shr 31) and 1 = 0;
              if AKeyPressed then
              begin
                EatKey := True;
                EatingKey := wParam;
              end;
              SendMessage(Handle, KeyMessages[AKeyPressed], wParam, lParam);
  //            if ActiveBarControl <> nil then EatKey := False;
              if (ActiveBarControl <> nil) or (GetAsyncKeyState(wParam) >= 0) then
                EatKey := False;
              Result := 1;
              Exit;
            end
            else
        else
          if (wParam = VK_ESCAPE) and (GetCapture = ActiveBarControl.Handle) then
          begin
            ReleaseCapture;
            Result := 1;
            Exit;
          end;

      if GetCapture = 0 then
      begin
        if (wParam = VK_APPS) and ((lParam shr 31) and 1 <> 0) or
          (wParam = VK_F10) and ((lParam shr 31) and 1 = 0) and (ShiftState = [ssShift]) then
        begin
          APopupMenuLinks := GetPopupMenuLinksForFocusedWindow(AControl);
          if (APopupMenuLinks <> nil) and
            APopupMenuLinks.DoAction(AControl, GetFocus, Point(-1, -1)) then
          begin
            Result := 1;
            Exit;
          end;
        end;

        AControl := FindControl(GetActiveWindow);
        if AControl is TCustomForm then
          AForm := TCustomForm(AControl)
        else
          AForm := nil;
        if (AForm <> nil) and not (csDesigning in AForm.ComponentState) then
        begin
          with TDummyForm(AForm) do
            if (FormStyle = fsMDIForm) and (ActiveMDIChild <> nil) then
              AForm := ActiveMDIChild;
          ABarManager := GetBarManagerByForm(AForm);
          if (TDummyForm(AForm).FormStyle = fsMDIChild) and
            ((ABarManager = nil) or (ABarManager.MainMenuControl = nil)) or
            not (TDummyForm(AForm).FormStyle in [fsMDIChild, fsMDIForm]) and (ABarManager = nil) and
            (GetBarManagerByForm(Application.MainForm) <> nil) and
            GetBarManagerByForm(Application.MainForm).AllowCallFromAnotherForm and
            IsWindowEnabled(Application.MainForm.Handle) then
            ABarManager := GetBarManagerByForm(Application.MainForm);
        end
        else ABarManager := nil;

        if (ABarManager <> nil) and not ABarManager.IsCustomizing and
          not ABarManager.BarControlFocused then
          if (lParam shr 31) and 1 <> 0 then  // release key
            if (ABarManager.MainMenuControl <> nil) and
              ((wParam = VK_MENU) and WaitForMenu and not KeyPressed or
               ABarManager.UseF10ForMenu and (wParam = VK_F10) and (ShiftState = [])) then
            begin
              WaitForMenu := False;
              ABarManager.MainMenuControl.BarGetFocus(nil);
              Result := 1;
              Exit;
            end
            else WaitForMenu := False
          else  // press key
            if wParam = VK_MENU then WaitForMenu := True
            else
            begin
              WaitForMenu := False;
              HandleKey;
              Exit;
            end;
      end;
    end;
  finally
    if DontCallNextKeybHook then Result := 0
    else
    begin
      Res := CallNextHookEx(KeyboardHookHandle, Code, wParam, lParam);
      if Result = 0 then Result := Res;
    end;
  end;
end;

function dxBarMouseHook(Code: Integer; wParam: WParam; lParam: LParam): LRESULT; stdcall;
var
  ManualProcessing: Boolean;
  ABarManager: TdxBarManager;
  I: Integer;
  P: TPoint;
  AKeys: Longint;
  BarControl: TCustomdxBarControl;
  Control: TWinControl;
  Res: HRESULT;

  function ProcessMouseMessage: Boolean;
  var
    AWnd: HWND;
    AControl: TCustomdxBarControl;

    function IsParentWnd(AWnd, ARootParentWnd: HWND): Boolean;
    var
      AParentWnd: HWND;
    begin
      AParentWnd := AWnd;
      repeat
        AParentWnd := GetParent(AParentWnd);
        Result := AParentWnd = ARootParentWnd;
      until Result or (AParentWnd = 0);
    end;

  begin
    with PMouseHookStruct(lParam)^ do
    begin
      AControl := ActiveBarControl;
      if AControl <> nil then
      begin
        Result := True;
        repeat
          if (hwnd = AControl.Handle) or (GetParent(hwnd) = AControl.Handle) then
            Exit;
          AControl := AControl.ParentBar;
        until AControl = nil;

        if (ActiveBarControl.SelectedItem <> nil) and
          (ActiveBarControl.SelectedItem is TCustomdxBarComboControl) and
          TCustomdxBarComboControl(ActiveBarControl.SelectedItem).DroppedDown then
        begin
          AWnd := TCustomdxBarComboControl(ActiveBarControl.SelectedItem).DropDownWindow;
          Result := IsWindowVisible(AWnd) and ((hwnd = AWnd) or IsParentWnd(hwnd, AWnd));
        end
        else
          Result := False;
      end
      else
        Result := False;  
    end;
  end;
(*  function ProcessMouseMessage: Boolean;
  var
    TopWnd: HWND;
    AControl: TCustomdxBarControl;

    function TopWndIsChild: Boolean;
    var
      Wnd: HWND;
    begin
      Result := True;
      Wnd := TopWnd;
      repeat
        if Wnd = ActiveBarControl.Handle then Exit;
        Wnd := GetParent(Wnd);
      until Wnd = 0;
      Result := False;
    end;

  begin
    Result := True;
    with PMouseHookStruct(lParam)^ do
    begin
      //if hwnd = GetTopWindow(0) then Exit;
      TopWnd := GetTopWindow(0);
      if (hwnd = TopWnd) or
        not IsWindowVisible(TopWnd) and TopWndIsChild then Exit;
      AControl := ActiveBarControl;
      repeat
        if (hwnd = AControl.Handle) or
          (GetParent(hwnd) = AControl.Handle) then Exit;
        AControl := AControl.ParentBar;
      until AControl = nil;
    end;
    Result := False;
  end;*)

  function ActiveControl: TdxBarItemControl;
  begin
    Result := nil;
    with PMouseHookStruct(lParam)^ do
    begin
      if FindControl(hwnd) is TCustomdxBarControl then
        Result := TCustomdxBarControl(FindControl(hwnd)).SelectedItem;

      if (Result = nil) and (GetCapture > 0) and (ActiveBarControl <> nil) then
        if WindowFromPointEx(pt) = ActiveBarControl.Handle then
          Result := ActiveBarControl.SelectedItem
        else
        begin
          Result := ActiveBarControl.SelectedItem;
          if (Result <> nil) and
            (not (Result.ItemLink.Item is TCustomdxBarCombo) or
             not TCustomdxBarCombo(Result.ItemLink.Item).DroppedDown) then
            Result := nil;
        end;
    end;
  end;

begin
  Result := 0;
  try
    ManualProcessing := False;
    with PMouseHookStruct(lParam)^ do
      if (FindControl(hwnd) is TCustomForm) and (SmallInt(wHitTestCode) = HTERROR) then
      begin
        ABarManager := GetBarManagerByForm(TCustomForm(FindControl(hwnd)));
        if (ABarManager = nil) or not ABarManager.FIsCustomizing then
          ABarManager := dxBarManagerList.CustomizingBarManager;

        if (ABarManager <> nil) and ABarManager.FIsCustomizing and
          dxBarCustomizingForm.Active then
          with ABarManager do
            for I := 0 to Bars.Count - 1 do
              if (Bars[I].Control <> nil) and Bars[I].Control.WantMouse then
              begin
                ManualProcessing := True;
                hwnd := Bars[I].Control.Handle;
                wHitTestCode := SendMessage(hwnd, WM_NCHITTEST, 0, MakeLParam(pt.X, pt.Y));
                SendMessage(hwnd, WM_SETCURSOR, hwnd, MakeLParam(wHitTestCode, wParam));
                Break;
              end;
      end;

    if not InMouseHook and (Code >= 0) and (FActiveBarControl <> nil) then
    begin
      InMouseHook := True;
      if ((wParam = WM_RBUTTONUP) or (wParam = WM_NCRBUTTONUP) or
          (wParam = WM_MBUTTONUP) or (wParam = WM_NCMBUTTONUP)) and
        (ActiveControl = nil) and not ProcessMouseMessage then
      begin
        InMouseHook := False;
        Result := 1;
        Exit;
      end;
      if not ActiveBarControl.BarManager.Dragging then
        repeat
          if (((wParam = WM_LBUTTONUP) or (wParam = WM_NCLBUTTONUP)) and (ActiveControl = nil) and
              (AnimatingSubMenu = nil) and not ActiveBarControl.IsCustomizing and
              ((ActiveBarControl is TdxBarControl) or (ActiveBarControl.ParentBar <> nil)) or
              (wParam = WM_LBUTTONDOWN) or (wParam = WM_LBUTTONDBLCLK) or
              (wParam = WM_RBUTTONDOWN) or (wParam = WM_RBUTTONDBLCLK) or
              (wParam = WM_MBUTTONDOWN) or (wParam = WM_MBUTTONDBLCLK) or
              (wParam = WM_NCLBUTTONDOWN) or (wParam = WM_NCLBUTTONDBLCLK) or
              (wParam = WM_NCRBUTTONDOWN) or (wParam = WM_NCRBUTTONDBLCLK) or
              (wParam = WM_NCMBUTTONDOWN) or (wParam = WM_NCMBUTTONDBLCLK)) and
            not ProcessMouseMessage then
            ActiveBarControl.HideAll
          else Break;
        until ActiveBarControl = nil;
      InMouseHook := False;
      if not IsWindowVisible(PMouseHookStruct(lParam)^.hwnd) then
      begin
        Result := 1;
        Exit;
      end;
    end;

    if (QuickCustBar <> nil) and not QuickCustBar.IsActive and
      ((WM_MOUSEFIRST < wParam) and (wParam <= WM_MOUSELAST) or
       (WM_NCMOUSEMOVE < wParam) and (wParam <= WM_NCMBUTTONDBLCLK)) then
    begin
      with PMouseHookStruct(lParam)^ do
      begin
        if FindControl(hwnd) is TCustomdxBarControl then
          BarControl := TCustomdxBarControl(FindControl(hwnd))
        else
          BarControl := nil;
        P := pt;
        if BarControl <> nil then ScreenToClient(hwnd, P);
      end;
      if (BarControl = nil) or (BarControl <> QuickCustBar) and
        ((BarControl <> QuickCustBar.FOwnerBar) or
         not PtInRect(TdxBarControl(BarControl).MarkRect, P) or
         (wParam = WM_RBUTTONDOWN)) then
        QuickCustBar.FOwnerBar.MarkState := msNone;
    end;

    with PMouseHookStruct(lParam)^ do
      if ManualProcessing then
      begin
        P := pt;
        if (WM_NCMOUSEMOVE <= wParam) and (wParam <= WM_NCMBUTTONDBLCLK) then
        begin
          wParam := wParam - WM_NCMOUSEMOVE + WM_MOUSEMOVE;
          ScreenToClient(hwnd, P);
        end;
        if wParam <> WM_MOUSEMOVE then
          SetForegroundWindow(dxBarCustomizingForm.Handle);
        AKeys :=
          Byte(GetAsyncKeyState(VK_CONTROL) < 0) * MK_CONTROL +
          Byte(LeftButtonPressed) * MK_LBUTTON +
          Byte(GetAsyncKeyState(VK_MBUTTON) < 0) * MK_MBUTTON +
          Byte(RightButtonPressed) * MK_RBUTTON +
          Byte(GetAsyncKeyState(VK_SHIFT) < 0) * MK_SHIFT;
        SendMessage(hwnd, wParam, AKeys, MakeLParam(P.X, P.Y));
        Result := 1;
      end
      else
        if ((wParam = WM_RBUTTONUP) or (wParam = WM_NCRBUTTONUP)) {and (GetCapture = 0) }then
        begin
          Control := FindVCLControl(hwnd);
          if Control <> nil then
          begin
            ABarManager := GetBarManagerByForm(GetParentForm(Control));
            if (ABarManager <> nil) and
              ABarManager.PopupMenuLinks.DoAction(Control, hwnd, pt) then
              Result := 1;
          end;
        end;
  finally
    Res := CallNextHookEx(MouseHookHandle, Code, wParam, lParam);
    if Result = 0 then Result := Res;
  end;
end;

function dxBarWndProcHook(Code: Integer; wParam: WParam; lParam: LParam): LRESULT; stdcall;
var
  AWnd, AParentWnd: HWND;
  ABarManager: TdxBarManager;

  function GetParentFormHandle(Wnd: HWND): HWND;
  begin
    Result := Wnd;
    while not (FindControl(Result) is TCustomForm) and (GetParent(Result) <> 0) do
      Result := GetParent(Result);
  end;

  function GetBarManager(AWnd: HWND): TdxBarManager;
  var
    AControl: TWinControl;
  begin
    AControl := FindControl(AWnd);
    if AControl is TCustomForm then
      Result := GetBarManagerByForm(TCustomForm(AControl))
    else
{      if (message = WM_ACTIVATE) and (wParam = WA_INACTIVE) and
        (AControl is TdxBarControl) then  // for control containers
      begin
        ABarManager := TdxBarControl(AControl).BarManager;
        AControl := FindControl(lParam);
        if (AControl is TCustomForm) and (AControl = ABarManager.MainForm) or
          (AControl is TdxBarControl) and (TdxBarControl(AControl).BarManager = ABarManager) then
          ABarManager := nil;
      end
      else}
        Result := nil;
  end;

  {procedure NotifyActiveMDIChildAboutActivation;
  begin
    ABarManager := GetBarManagerByForm(Application.MainForm.ActiveMDIChild);
    if ABarManager <> nil then
      with PCWPStruct(lParam)^ do
        ABarManager.MainFormWndProc(message, wParam, lParam);
  end;}

begin
  with PCWPStruct(lParam)^ do
  begin
    AWnd := hwnd;
    if (message = WM_HELP) and (ActiveBarControl <> nil) then
    begin
      AParentWnd := ActiveBarControl.BarManager.MainForm.Handle;
      if GetParentFormHandle(AWnd) <> AParentWnd then
        AWnd := AParentWnd;
    end;
    ABarManager := GetBarManager(AWnd);
    if ABarManager <> nil then
      ABarManager.MainFormWndProc(message, wParam, lParam);
    if (Application.MainForm <> nil) and (Application.MainForm.FormStyle = fsMDIForm) and
      Application.MainForm.HandleAllocated and (AWnd = Application.MainForm.Handle) then
      case message of
        {WM_ACTIVATE:
          if (LOWORD(wParam) = WA_INACTIVE) or
            (ABarManager = nil) or not ABarManager.IsCustomizing or
            (csDestroying in dxBarCustomizingForm.ComponentState) then
            NotifyActiveMDIChildAboutActivation;}
        WM_WINDOWPOSCHANGED:
          if dxBarCustomizingForm <> nil then
            dxBarCustomizingForm.UpdateVisibility(PWindowPos(lParam)^);
      end;
  end;
  Result := CallNextHookEx(WndProcHookHandle, Code, wParam, lParam);
  with PCWPStruct(lParam)^ do
    if (message = WM_CHILDACTIVATE) or (message = WM_DESTROY) or (message = WM_MDIACTIVATE) then
    begin
      AParentWnd := GetParent(AWnd);
      GetClassName(AParentWnd, AClassName, 256);
      if AnsiStrIComp(AClassName, 'MDICLIENT') = 0 then
      begin
        ABarManager := GetBarManager(GetParent(AParentWnd));
        if ABarManager <> nil then
          ABarManager.MainFormClientWndProc(message, wParam, lParam);
      end
    end;
end;

procedure RegisterdxBarManager(ABarManager: TdxBarManager);
begin
  if dxBarManagerList.FList.IndexOf(ABarManager) < 0 then
    dxBarManagerList.FList.Add(ABarManager);
  if not ABarManager.Designing and (FHintWindow = nil) then
    FHintWindow := dxBarHintWindowClass.Create(nil);
  if KeyboardHookHandle = 0 then
    KeyboardHookHandle :=
      SetWindowsHookEx(WH_KEYBOARD, dxBarKeyboardHook, 0, GetCurrentThreadId);
  if MouseHookHandle = 0 then
    MouseHookHandle := SetWindowsHookEx(WH_MOUSE, dxBarMouseHook, 0, GetCurrentThreadId);
  if WndProcHookHandle = 0 then
    WndProcHookHandle :=
      SetWindowsHookEx(WH_CALLWNDPROC, dxBarWndProcHook, 0, GetCurrentThreadId);
end;

procedure UnregisterdxBarManager(ABarManager: TdxBarManager);
begin
  dxBarManagerList.FList.Remove(ABarManager);
  if dxBarManagerList.Count = 0 then
  begin
    if WndProcHookHandle <> 0 then
    begin
      UnhookWindowsHookEx(WndProcHookHandle);
      WndProcHookHandle := 0;
    end;
    if MouseHookHandle <> 0 then
    begin
      UnhookWindowsHookEx(MouseHookHandle);
      MouseHookHandle := 0;
    end;
    if KeyboardHookHandle <> 0 then
    begin
      UnhookWindowsHookEx(KeyboardHookHandle);
      KeyboardHookHandle := 0;
    end;
    if FHintWindow <> nil then
    begin
      FHintWindow.Free;
      FHintWindow := nil;
    end;
  end;
end;

constructor TdxBarManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCreatingFlag := True;
  if (AOwner = nil) and (Application.MainForm <> nil) then
    AOwner := Application.MainForm;
  if not (AOwner is TCustomForm) then
    raise Exception.Create(LoadStr(DXBAR_BARMANAGERBADOWNER));
  FMainForm := TCustomForm(AOwner);
  if GetBarManagerByForm(FMainForm) <> nil then
    raise Exception.Create(LoadStr(DXBAR_BARMANAGERMORETHENONE));
  FCreatingFlag := False;

  RegisterdxBarManager(Self);
  FDesigning := csDesigning in ComponentState;
  FAllowReset := True;
  FAutoDockColor := True;
  FItems := TList.Create;
  FCategories := TdxBarManagerCategories.Create(Self);
  FDockControls := TList.Create;
  FBars := TdxBars.Create(Self);
  FPopupMenus := TList.Create;
  FCanCustomize := True;
  FDockColor := clBtnFace;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  FGroups := TList.Create;
  FHelpButtonGlyph := TBitmap.Create;
  FHelpButtonGlyph.OnChange := HelpButtonGlyphChanged;
  FHideFloatingBarsWhenInactive := True;
  FImageListBkColor := clFuchsia;
  FImagesChangeLink := TChangeLink.Create;
  FImagesChangeLink.OnChange := ImageListChange;
  FLargeImagesChangeLink := TChangeLink.Create;
  FLargeImagesChangeLink.OnChange := LargeImageListChange;
  FHotImagesChangeLink := TChangeLink.Create;
  FHotImagesChangeLink.OnChange := HotImageListChange;
  FButtonArrowWidth := dxBarDefaultButtonArrowWidth;
  FLargeButtonArrowWidth := dxBarDefaultLargeButtonArrowWidth;
  FMenusShowRecentItemsFirst := True;
  FMostRecentItemsPercents := 95;
  CalcMostRecentlyUsedUseCount;
  FPopupMenuLinks := TdxBarPopupMenuLinks.Create(Self);
  FScaled := True;
  FShowFullMenusAfterDelay := True;
  FShowHint := True;
  FShowHintForDisabledItems := True;
  FStretchGlyphs := True;
  CalcButtonsConsts;
  Style := bmsEnhanced;
  FUseF10ForMenu := True;
  UseSystemFont := True;
  FWaitForDockingTime := 21;
  CreateFlatToolbarsBrushes;
end;

destructor TdxBarManager.Destroy;
begin
  if not FCreatingFlag then
  begin
    if FHintTimerID <> 0 then
    begin
      KillHintTimer;
      HintActivate(False, '');
    end;
    KillHiddenHintTimer;
    Customizing(False);

    DestroyFlatToolbarsBrushes;
    while FPopupMenus.Count > 0 do
      TdxBarPopupMenu(FPopupMenus.Last).Free;
    FPopupMenus.Free;
    FHotImagesChangeLink.Free;
    FLargeImagesChangeLink.Free;
    FImagesChangeLink.Free;
    FHelpButtonGlyph.Free;
    while GroupCount > 0 do Groups[0].Free;
    FGroups.Free;
    FFont.Free;
    DeleteObject(FEditFontHandle);
    FBars.Free;
    FBars := nil;
    FDockControls.Free;
    FDockControls := nil;
    DestroyItems;
    FItems.Free;
    UnregisterdxBarManager(Self);
    FCategories.Free;
    if FTempBarsList <> nil then
    begin
      FTempBarsList.Free;
      FTempBarsList := nil;
    end;
    FPopupMenuLinks.Free;
  end;
  inherited Destroy;
end;

function TdxBarManager.GetBarControlFocused: Boolean;
begin
  Result := FFocusedBarControl <> nil;
end;

function TdxBarManager.GetCategoryItemsVisible(AIndex: Integer): TdxBarItemVisible;
begin
  if (0 <= AIndex) and (AIndex < FCategories.Count) then
    with FCategories do
      if Objects[AIndex] = nil then
        Result := ivAlways
      else
        Result := PdxBarCategoryData(Objects[AIndex])^.ItemsVisible
  else Result := ivNever;
end;

function TdxBarManager.GetCategoryVisible(AIndex: Integer): Boolean;
begin
  if (0 <= AIndex) and (AIndex < FCategories.Count) then
    with FCategories do
      Result := (Objects[AIndex] = nil) or PdxBarCategoryData(Objects[AIndex])^.Visible
  else Result := False;
end;

function TdxBarManager.GetDockColor: TColor;
begin
  if FAutoDockColor then
    Result := FMainForm.Color
  else
    Result := FDockColor;
end;

function TdxBarManager.GetDockControl(Index: Integer): TdxDockControl;
begin
  Result := FDockControls[Index];
end;

function TdxBarManager.GetDockControlCount: Integer;
begin
  Result := FDockControls.Count;
end;

function TdxBarManager.GetFlat: Boolean;
begin
  Result := FStyle = bmsFlat;
end;

function GetRealColor(AColor: COLORREF): COLORREF;
var
  DC: HDC;
begin
  DC := GetDC(0);
  Result := GetNearestColor(DC, AColor);
  ReleaseDC(0, DC);
end;

function TdxBarManager.GetFlatToolbarsBorderColor: COLORREF;

  function GetDarkValue(Value: Byte): Byte;
  begin
    Result := MulDiv(Value, 8, 10);
  end;

begin
  Result := GetSysColor(COLOR_BTNSHADOW);
  Result := RGB(
    GetDarkValue(GetRValue(Result)),
    GetDarkValue(GetGValue(Result)),
    GetDarkValue(GetBValue(Result)));
  Result := GetRealColor(Result);
end;

function TdxBarManager.GetFlatToolbarsColor: COLORREF;

  function GetLightValue(Value: Byte): Byte;
  begin
    Result := Value + MulDiv(255 - Value, 16, 100);
  end;

begin
  Result := GetSysColor(COLOR_BTNFACE);
  Result := RGB(
    GetLightValue(GetRValue(Result)),
    GetLightValue(GetGValue(Result)),
    GetLightValue(GetBValue(Result)));
  Result := GetRealColor(Result);
end;

function TdxBarManager.GetFlatToolbarsDownedColor: COLORREF;
begin
  Result := GetRealColor(GetLightColor(11, 9, 73));
end;

function TdxBarManager.GetFlatToolbarsDownedSelColor: COLORREF;
begin
  Result := GetRealColor(GetLightColor(14, 44, 40));
end;

function TdxBarManager.GetFlatToolbarsSelColor: COLORREF;
begin
  Result := GetRealColor(GetLightColor(-2, 30, 72));
end;

function TdxBarManager.GetGroup(Index: Integer): TdxBarGroup;
begin
  Result := TdxBarGroup(FGroups[Index]);
end;

function TdxBarManager.GetGroupCount: Integer;
begin
  Result := FGroups.Count;
end;

function TdxBarManager.GetIsCustomizing: Boolean;
begin
  Result := FIsCustomizing or FDesigning;
end;

function TdxBarManager.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TdxBarManager.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxBarManager.GetItem(Index: Integer): TdxBarItem;
begin
  if (0 <= Index) and (Index < FItems.Count) then
    Result := TdxBarItem(FItems[Index])
  else
    Result := nil;
end;

function TdxBarManager.GetRealLargeButtonArrowWidth: Integer;
begin
  Result := FLargeButtonArrowWidth - Byte(Flat);
end;

procedure TdxBarManager.SetAutoDockColor(Value: Boolean);
var
  I: Integer;
begin
  if FAutoDockColor <> Value then
  begin
    FAutoDockColor := Value;
    for I := 0 to DockControlCount - 1 do
      DockControls[I].ColorChanged;
  end;
end;

procedure TdxBarManager.SetAutoHideEmptyBars(Value: Boolean);
var
  I: Integer;
begin
  if FAutoHideEmptyBars <> Value then
  begin
    FAutoHideEmptyBars := Value;
    if not Value then
      for I := 0 to FBars.Count - 1 do
        Bars[I].FInternallyHidden := False;
  end;
end;

procedure TdxBarManager.SetBars(Value: TdxBars);
begin
  FBars.Assign(Value);
end;

procedure TdxBarManager.SetButtonArrowWidth(Value: Integer);
var
  I: Integer;
begin
  if FButtonArrowWidth <> Value then
  begin
    if Value < 2 then Exit;
    FButtonArrowWidth := Value;
    CalcButtonsConsts;
    for I := 0 to Bars.Count - 1 do
      with Bars[I] do
        if Control <> nil then Control.RepaintBar;
  end;
end;

procedure TdxBarManager.SetCategories(Value: TStrings);
begin
  Categories.Assign(Value);
end;

procedure TdxBarManager.SetCategoryItemsVisible(AIndex: Integer; Value: TdxBarItemVisible);
var
  PrevValue: TdxBarItemVisible;
  EmptyBars, AList: TList;
  PrevLockUpdate: Boolean;
  I: Integer;
begin
  if (0 <= AIndex) and (AIndex < FCategories.Count) then
  begin
    PrevValue := CategoryItemsVisible[AIndex];
    with FCategories do
    begin
      if Objects[AIndex] = nil then
      begin
        Objects[AIndex] := AllocMem(SizeOf(TdxBarCategoryData));
        with PdxBarCategoryData(Objects[AIndex])^ do
        begin
          ItemsVisible := ivAlways;
          Visible := True;
        end;  
      end;
      if Self.IsLoading then
      begin
        PdxBarCategoryData(Objects[AIndex])^.LoadedItemsVisible := Value;
        Exit;
      end;
      PdxBarCategoryData(Objects[AIndex])^.ItemsVisible := Value;

      PrevLockUpdate := LockUpdate;
      EmptyBars := nil;
      if not FDesigning then
      begin
        if FAutoHideEmptyBars then
        begin
          EmptyBars := TList.Create;
          for I := 0 to FBars.Count - 1 do
            if FBars[I].ItemLinks.AvailableItemCount = 0 then EmptyBars.Add(FBars[I]);
        end;
        LockUpdate := True;
      end;

      AList := TList.Create;
      try
        GetAllItemsByCategory(AIndex, AList);
        if Value = ivAlways then
          for I := AList.Count - 1 downto 0 do
            with TdxBarItem(AList[I]) do
              if Visible = PrevValue then Visible := Value
              else
        else
          for I := 0 to AList.Count - 1 do
            with TdxBarItem(AList[I]) do
              if Visible = PrevValue then Visible := Value;
      finally
        AList.Free;

        if not FDesigning then
        begin
          if FAutoHideEmptyBars then
          begin
            for I := 0 to FBars.Count - 1 do
              if (Value = ivNever) and (FBars[I].ItemLinks.AvailableItemCount = 0) and
                (EmptyBars.IndexOf(FBars[I]) = -1) or
                (Value = ivAlways) and (FBars[I].ItemLinks.AvailableItemCount > 0) and
                FBars[I].FInternallyHidden then
                with FBars[I] do
                begin
                  Visible := Value = ivAlways;
                  FInternallyHidden := Value = ivNever;
                end;
            EmptyBars.Free;
          end;
          LockUpdate := PrevLockUpdate;
        end;
      end;
    end;
    if Value <> PrevValue then DesignerModified;
  end;
end;

procedure TdxBarManager.SetCategoryVisible(AIndex: Integer; Value: Boolean);
begin
  if (0 <= AIndex) and (AIndex < FCategories.Count) and
    (CategoryVisible[AIndex] <> Value) then
  begin
    with FCategories do
    begin
      if Objects[AIndex] = nil then
      begin
        Objects[AIndex] := AllocMem(SizeOf(TdxBarCategoryData));
        PdxBarCategoryData(Objects[AIndex])^.ItemsVisible := ivAlways;
      end;
      PdxBarCategoryData(Objects[AIndex])^.Visible := Value;
    end;
    DesignerModified;
  end;
end;

function TdxBarManager.GetMainMenuControl: TdxBarControl;
begin
  if FMainMenuBar <> nil then
    Result := FMainMenuBar.Control
  else
    Result := nil;
end;

procedure TdxBarManager.SetDockColor(Value: TColor);
var
  I: Integer;
begin
  if FDockColor <> Value then
  begin
    FDockColor := Value;
    FAutoDockColor := False;
    for I := 0 to DockControlCount - 1 do
      DockControls[I].ColorChanged;
  end;
end;

procedure TdxBarManager.SetFlatCloseButton(Value: Boolean);
begin
  if FFlatCloseButton <> Value then
  begin
    FFlatCloseButton := Value;
    if MainMenuControl <> nil then
    begin
      if (SelectedItem <> nil) and (SelectedItem.Parent = MainMenuControl) then
        SelectedItem := nil;
      MainMenuControl.RepaintBar;
    end;
  end;
end;

procedure TdxBarManager.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TdxBarManager.SetHelpButtonGlyph(Value: TBitmap);
begin
  FHelpButtonGlyph.Assign(Value);
end;

procedure TdxBarManager.SetHideFloatingBarsWhenInactive(Value: Boolean);
begin
  if FHideFloatingBarsWhenInactive <> Value then
  begin
    FHideFloatingBarsWhenInactive := Value;
    ShowToolbars(FMainFormActive or not FHideFloatingBarsWhenInactive, False, 0);
  end;
end;

procedure TdxBarManager.SetHotImages(Value: TCurImageList);
begin
  if FHotImages <> Value then
  begin
    if FHotImages <> nil then
      FHotImages.UnRegisterChanges(FHotImagesChangeLink);
    FHotImages := Value;
    if FHotImages <> nil then
    begin
      FHotImages.RegisterChanges(FHotImagesChangeLink);
      FHotImages.FreeNotification(Self);
    end;
    HotImagesChanged;
  end;  
end;

procedure TdxBarManager.SetImageListBkColor(Value: TColor);
var
  I: Integer;
begin
  if FImageListBkColor <> Value then
  begin
    FImageListBkColor := Value;
    for I := 0 to FBars.Count - 1 do
      with FBars[I] do
        if Control <> nil then Control.Repaint;
  end;
end;

procedure TdxBarManager.SetImages(Value: TCurImageList);
begin
  if FImages <> Value then
  begin
    if FImages <> nil then
      FImages.UnRegisterChanges(FImagesChangeLink);
    FImages := Value;
    if FImages <> nil then
    begin
      FImages.RegisterChanges(FImagesChangeLink);
      FImages.FreeNotification(Self);
    end;
    ImagesChanged;
  end;  
end;

function TdxBarManager.GetIsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

procedure TdxBarManager.SetLargeButtonArrowWidth(Value: Integer);
var
  I: Integer;
begin
  if FLargeButtonArrowWidth <> Value then
  begin
    if Value < 2 then Exit;
    FLargeButtonArrowWidth := Value;
    for I := 0 to Bars.Count - 1 do
      with Bars[I] do
        if Control <> nil then Control.RepaintBar;
  end;
end;

procedure TdxBarManager.SetLargeIcons(Value: Boolean);
var
  I: Integer;
begin
  if FLargeIcons <> Value then
  begin
    FLargeIcons := Value;
    CalcButtonsConsts;
    DesignerModified;
    UpdateBarManagerOptions;
    for I := 0 to Bars.Count - 1 do
      with Bars[I] do
        if Control <> nil then Control.RepaintBar;
  end;
end;

procedure TdxBarManager.SetLargeImages(Value: TCurImageList);
begin
  if FLargeImages <> Value then
  begin
    if FLargeImages <> nil then
      FLargeImages.UnRegisterChanges(FLargeImagesChangeLink);
    FLargeImages := Value;
    if FLargeImages <> nil then
    begin
      FLargeImages.RegisterChanges(FLargeImagesChangeLink);
      FLargeImages.FreeNotification(Self);
    end;
    LargeImagesChanged;
  end;
end;

procedure TdxBarManager.SetLockUpdate(Value: Boolean);
var
  I: Integer;
begin
  if FLockUpdate <> Value then
  begin
    FLockUpdate := Value;

    for I := 0 to DockControlCount - 1 do
      with DockControls[I] do
        if Visible then
          SendMessage(Handle, WM_SETREDRAW, WPARAM(not Self.FLockUpdate), 0);

    for I := 0 to Bars.Count - 1 do
      if FBars[I].DockingStyle = dsNone then
        FBars[I].LockUpdate := FLockUpdate
      else
        FBars[I].FLockUpdate := FLockUpdate;

    if not FLockUpdate then
    begin   
      for I := 0 to DockControlCount - 1 do
        with DockControls[I] do
          if Visible then
          begin
            UpdateDock;
            SendMessage(Handle, WM_NCPAINT, 0, 0);
          end;
      for I := 0 to FBars.Count - 1 do
        if (FBars[I].DockingStyle <> dsNone) and (FBars[I].Control <> nil) then
          with FBars[I].Control do
          begin
            FrameChanged;
            Repaint;
          end;
    end;
  end;
end;

procedure TdxBarManager.SetMenuAnimations(Value: TdxBarMenuAnimations);
begin
  if FMenuAnimations <> Value then
  begin
    FMenuAnimations := Value;
    DesignerModified;
    UpdateBarManagerOptions;
  end;
end;

procedure TdxBarManager.SetMenusShowRecentItemsFirst(Value: Boolean);
begin
  if FMenusShowRecentItemsFirst <> Value then
  begin
    FMenusShowRecentItemsFirst := Value;
    DesignerModified;
    UpdateBarManagerOptions;
  end;
end;

procedure TdxBarManager.SetMostRecentItemsPercents(Value: Byte);
begin
  if Value > 100 then Value := 100;
  FMostRecentItemsPercents := Value;
  CalcMostRecentlyUsedUseCount;
end;

procedure TdxBarManager.SetPopupMenuLinks(Value: TdxBarPopupMenuLinks);
begin
  FPopupMenuLinks.Assign(Value);
end;

procedure TdxBarManager.SetScaled(Value: Boolean);
begin
  if FScaled <> Value then
  begin
    FScaled := Value;
    if Value and not FUseSystemFont then AssignFont;
  end;
end;

procedure TdxBarManager.SetSelectedItem(Value: TdxBarItemControl);
var
  OldSelectedItem: TdxBarItemControl;
begin
  if FSelectedItem <> Value then
  begin
    if IsCustomizing and (FSelectedItem <> nil) and
      ((Value = nil) or
       (GetParentBarForControl(Value) <> GetParentBarForControl(FSelectedItem))) then
      if GetParentBarForControl(FSelectedItem) <> nil then
        GetParentBarForControl(FSelectedItem).SetMouseSelectedItem(nil)
      else
        if (dxBarSubMenuEditor <> nil) and (GetParentBarOrSubMenuForControl(FSelectedItem) =
          dxBarSubMenuEditor.ItemLinks.BarControl) then
          dxBarSubMenuEditor.ItemLinks.BarControl.Free;
    OldSelectedItem := FSelectedItem;
    FSelectedItem := Value;
    if (OldSelectedItem <> nil) and (OldSelectedItem.Parent <> nil) and
      not FDragging then OldSelectedItem.Repaint;
    if Designing and (FSelectedItem <> nil) and not FDragging then
      dxBarDesigner.SelectComponent(Self, FSelectedItem.ItemLink.Item);
  end;
end;

procedure TdxBarManager.SetShowCloseButton(Value: Boolean);
begin
  if FShowCloseButton <> Value then
  begin
    FShowCloseButton := Value;
    if MainMenuControl <> nil then
    begin
      if (SelectedItem <> nil) and (SelectedItem.Parent = MainMenuControl) then
        SelectedItem := nil;
      MainMenuControl.RepaintBar;
    end;
  end;
end;

procedure TdxBarManager.SetShowFullMenusAfterDelay(Value: Boolean);
begin
  if FShowFullMenusAfterDelay <> Value then
  begin
    FShowFullMenusAfterDelay := Value;
    DesignerModified;
    UpdateBarManagerOptions;
  end;
end;

procedure TdxBarManager.SetShowHelpButton(Value: Boolean);
begin
  if FShowHelpButton <> Value then
  begin
    FShowHelpButton := Value;
    UpdateHelpButton;
  end;
end;

procedure TdxBarManager.SetShowHint(Value: Boolean);
begin
  if FShowHint <> Value then
  begin
    FShowHint := Value;
    DesignerModified;
    UpdateBarManagerOptions;
  end;
end;

procedure TdxBarManager.SetShowShortCutInHint(Value: Boolean);
begin
  if FShowShortCutInHint <> Value then
  begin
    FShowShortCutInHint := Value;
    DesignerModified;
    UpdateBarManagerOptions;
  end;
end;

procedure TdxBarManager.SetStyle(Value: TdxBarManagerStyle);
var
  I: Integer;
begin
  if FStyle <> Value then
  begin
    FChangingStyle := True;
    try
      FStyle := Value;
      if FStyle = bmsStandard then
      begin
        FBeforeFingersSize := 2;
        FFingersSize := FBeforeFingersSize + 2 * dxBarFingerSize + 1;
        FSubMenuBeginGroupIndent := 2;
      end
      else
      begin
        FBeforeFingersSize := 1;
        FFingersSize := FBeforeFingersSize + dxBarFingerSize + 2;
        if Flat then
          FSubMenuBeginGroupIndent := 8
        else
          FSubMenuBeginGroupIndent := 12;
      end;
      CalcButtonsConsts;
      for I := 0 to Bars.Count - 1 do
        with Bars[I] do
          if Control <> nil then Control.BarManagerStyleChanged;
      HostBarManagerStyleChanged;
    finally
      FChangingStyle := False;
    end;
  end;
end;

procedure TdxBarManager.SetSunkenBorder(Value: Boolean);
var
  I: Integer;
begin
  if FSunkenBorder <> Value then
  begin
    FSunkenBorder := Value;
    for I := 0 to DockControlCount - 1 do
      DockControls[I].NCChanged;
  end;
end;

procedure TdxBarManager.SetUseSystemFont(Value: Boolean);
begin
  if FUseSystemFont <> Value then
  begin
    FUseSystemFont := Value;
    if FUseSystemFont then
      MainFormWndProc(WM_SETTINGCHANGE, SPI_SETNONCLIENTMETRICS, 0);
  end;
end;

procedure TdxBarManager.SetWaitForDockingTime(Value: Integer);
begin
  if Value >= 0 then FWaitForDockingTime := Value;
end;

procedure TdxBarManager.AddCustomizeLink(ItemLinks: TdxBarItemLinks;
  ABeginGroup: Boolean; ItemClass: TdxBarItemClass);
begin
  if FCanCustomize then
  begin
    InternalItemList.Add(ItemClass.Create(nil));
    with TdxBarButton(InternalItemList.Last) do
    begin
      Caption := LoadStr(DXBAR_CUSTOMIZE);
      Enabled := dxBarCustomizingForm = nil;
      Tag := 1000;
      OnClick := ToolbarsPopupClick;
    end;
    with ItemLinks.Add do
    begin
      Item := TdxBarButton(InternalItemList.Last);
      BeginGroup := ABeginGroup;
    end;
  end;
end;

procedure TdxBarManager.CalcButtonsConsts;
begin
  FGlyphSize := DefautGlyphSize * (1 + Byte(FLargeIcons));
  FButtonWidth := FGlyphSize + dxBarButtonBorderWidth;
  FButtonHeight := FGlyphSize + dxBarButtonBorderHeight;
  FRealButtonArrowWidth := (1 + Byte(FLargeIcons)) * FButtonArrowWidth;
  if not Odd(FRealButtonArrowWidth) then Inc(FRealButtonArrowWidth);
  if Flat then Dec(FRealButtonArrowWidth);
end;

procedure TdxBarManager.DrawDraggingLine(AControl: TdxBarItemControl;
  IsBeginGroup, IsFirstPart, IsVerticalDirection: Boolean);
const
  LineSize = 6;
  Pairs: array[0..5] of DWORD = (2, 2, 2, 2, 2, 2);
type
  PPoints = ^TPoints;
  TPoints = array[0..0] of TPoint;
var
  IsLastControl: Boolean;
  R: TRect;
  DC: HDC;
  Origin: Integer;

  procedure PolyPolyLine(const Points: array of TPoint);
  begin
    Windows.PolyPolyLine(DC, PPoints(@Points)^, Pairs, 6);
  end;

begin
  if IsBeginGroup then
  begin
    if IsFirstPart then
      with AControl do
        AControl := Parent.ItemLinks.VisibleItems[ItemLink.VisibleIndex - 1].Control;
    IsFirstPart := not IsFirstPart;
  end
  else
    if not IsFirstPart then
    begin
      with AControl do
        IsLastControl := AControl.FLastInRow or
          Parent.ItemLinks.VisibleItems[ItemLink.VisibleIndex + 1].BeginGroup;
      if not IsLastControl then
      begin
        with AControl do
          AControl := Parent.ItemLinks.VisibleItems[ItemLink.VisibleIndex + 1].Control;
        IsFirstPart := True;
      end;
    end;
  R := AControl.Parent.GetItemRect(AControl);

  DC := AControl.Parent.Canvas.Handle;
  with R do
  begin
    SetROP2(DC, R2_NOT);
    if IsVerticalDirection then
    begin
      if IsFirstPart then Origin := R.Top
      else Origin := R.Bottom - LineSize;
      PolyPolyLine(
        [Point(Left, Origin), Point(Left, Origin + LineSize),
         Point(Left + 1, Origin + 1), Point(Left + 1, Origin + LineSize - 1),

         Point(Left + 2, Origin + 2), Point(Right - 2, Origin + 2),
         Point(Left + 2, Origin + 3), Point(Right - 2, Origin + 3),

         Point(Right - 2, Origin + 1), Point(Right - 2, Origin + LineSize - 1),
         Point(Right - 1, Origin), Point(Right - 1, Origin + LineSize)]);
    end
    else
    begin
      if IsFirstPart then Origin := R.Left
      else Origin := R.Right - LineSize;
      PolyPolyLine(
        [Point(Origin, Top), Point(Origin + LineSize, Top),
         Point(Origin + 1, Top + 1), Point(Origin + LineSize - 1, Top + 1),

         Point(Origin + 2, Top + 2), Point(Origin + 2, Bottom - 2),
         Point(Origin + 3, Top + 2), Point(Origin + 3, Bottom - 2),

         Point(Origin + 1, Bottom - 2), Point(Origin + LineSize - 1, Bottom - 2),
         Point(Origin, Bottom - 1), Point(Origin + LineSize, Bottom - 1)]);
    end;
    SetROP2(DC, R2_COPYPEN);
  end;
end;

procedure TdxBarManager.FontChanged(Sender: TObject);

  procedure ProcessBars;
  var
    I: Integer;
  begin
    for I := 0 to Bars.Count - 1 do
      with Bars[I] do
      begin
        FInternalFontChange := True;
        try
          if UseOwnFont then
            FontChanged(nil)
          else
            Font := Self.FFont;
        finally
          FInternalFontChange := False;
        end;
      end;
  end;

  procedure ProcessPopupMenus;
  var
    I: Integer;
  begin
    for I := 0 to FPopupMenus.Count - 1 do
      with TdxBarPopupMenu(FPopupMenus[I]) do
      begin
        FInternalFontChange := True;
        try
          if UseOwnFont then
            FontChanged(nil)
          else
            Font := Self.FFont;
        finally
          FInternalFontChange := False;
        end;
      end;
  end;

begin
  if not FInternalFontChange then
    FUseSystemFont := False;
  if FScaled then
  begin
    FFont.OnChange := nil;
    try
      AssignFont;
    finally
      FFont.OnChange := FontChanged;
    end;
  end;
  CreateEditFontHandle(FFont, FEditFontHandle, FScaled);
  ProcessBars;
  ProcessPopupMenus;
end;

{ TSystemMenuSubItem }

type
  TSystemMenuSubItem = class(TCustomdxBarSubItem)
  private
    FMDIChildHandle: HWND;
    function GetIconHandle: HICON;
    procedure ButtonClick(Sender: TObject);
  protected
    procedure BuildMenu;
    procedure DirectClick; override;
  public
    property IconHandle: HICON read GetIconHandle;
    property MDIChildHandle: HWND read FMDIChildHandle write FMDIChildHandle;
  end;

function TSystemMenuSubItem.GetIconHandle: HICON;
begin
  Result := SendMessage(FMDIChildHandle, WM_GETICON, ICON_SMALL, 0);
  if Result = 0 then
    Result := SendMessage(FMDIChildHandle, WM_GETICON, ICON_BIG, 0);
  Result :=
    CopyImage(Result, IMAGE_ICON, 16, 16, LR_COPYFROMRESOURCE);
end;

procedure TSystemMenuSubItem.ButtonClick(Sender: TObject);
begin
  with TdxBarItem(Sender) do
    SendMessage(MDIChildHandle, WM_SYSCOMMAND, Tag, 0);
end;

procedure TSystemMenuSubItem.BuildMenu;
const
  SLength = 1024;

  procedure BuildSubMenu(SubItem: TCustomdxBarSubItem; Menu: HWND);
  const
    BitmapNames: array[HBMMENU_POPUP_CLOSE..HBMMENU_POPUP_MINIMIZE] of string =
      ('DXBARCLOSE', 'DXBARRESTORE', 'DXBARMAXIMIZE', 'DXBARMINIMIZE');
  var
    ABeginGroup: Boolean;
    S: PChar;
    I, P: Integer;
    MI: TMenuItemInfo;
    AShortCutText: string;
    AItem: TdxBarItem;
  begin
    ABeginGroup := False;
    GetMem(S, SLength);
    try
      for I := 0 to GetMenuItemCount(Menu) - 1 do
      begin
        with MI do
        begin
          if IsWin98Or2000 then
            cbSize := SizeOf(MI)
          else
          begin
            cbSize := 44;
            MI.hbmpItem := 0;
          end;
          fMask :=
            MIIM_CHECKMARKS or MIIM_ID or MIIM_STATE or MIIM_SUBMENU or MIIM_TYPE;
          dwTypeData := S;
          cch := SLength;
        end;
        GetMenuItemInfo(Menu, I, True, MI);

        if MI.fType and MFT_SEPARATOR <> 0 then
        begin
          ABeginGroup := True;
          Continue;
        end;

        if MI.fType and MFT_BITMAP <> 0 then
          GetMenuString(Menu, I, S, SLength, MF_BYPOSITION)
        else
          if MI.cch = 0 then StrCopy(S, '');
        P := Pos(#9, S);
        if P = 0 then
          AShortCutText := ''
        else
        begin
          AShortCutText := Copy(S, P + 1, Length(S) - P);
          StrLCopy(S, S, P - 1);
        end;

        if MI.hSubMenu = 0 then
        begin
          AItem := TdxBarButton.Create(Owner);
          if MI.fState and MFS_CHECKED <> 0 then
            with TdxBarButton(AItem) do
            begin
              ButtonStyle := bsChecked;
              Down := True;
            end;
          with AItem do
          begin
            Tag := MI.wID;
            OnClick := ButtonClick;
          end;  
        end
        else
        begin
          AItem := TdxBarSubItem.Create(Owner);
          BuildSubMenu(TCustomdxBarSubItem(AItem), MI.hSubMenu);
        end;
        InternalItemList.Add(AItem);
        with AItem do
        begin
          Caption := S;
          Enabled := MI.fState and (MFS_DISABLED or MFS_GRAYED) = 0;
          if MI.hbmpItem in [HBMMENU_POPUP_CLOSE..HBMMENU_POPUP_MINIMIZE] then
            Glyph.Handle := LoadBitmap(HInstance, PChar(BitmapNames[MI.hbmpItem]))
          else
          begin
            if MI.fState and MFS_CHECKED <> 0 then
              if MI.hbmpChecked <> 0 then
                Glyph.Handle := CopyImage(MI.hbmpChecked, IMAGE_BITMAP, 0, 0, 0)
              else
            else
              if MI.hbmpUnchecked <> 0 then
                Glyph.Handle := CopyImage(MI.hbmpUnchecked, IMAGE_BITMAP, 0, 0, 0);
            if (Glyph.Handle = 0) and (MI.fType and MFT_BITMAP <> 0) then
              Glyph.Handle := CopyImage(HBITMAP(MI.dwTypeData), IMAGE_BITMAP, 0, 0, 0);
          end;  
          ShortCut := TextToShortCut(AShortCutText);
        end;

        with SubItem.ItemLinks.Add do
        begin
          BeginGroup := ABeginGroup;
          Item := AItem;
        end;
        ABeginGroup := False;
      end;
    finally
      FreeMem(S);
    end;
  end;

begin
  ClearInternalItemList;
  BuildSubMenu(Self, GetSystemMenu(FMDIChildHandle, False));
end;

procedure TSystemMenuSubItem.DirectClick;
begin
  BuildMenu;
  inherited;
end;

{ TSystemMenuSubItemControl }

type
  TSystemMenuSubItemControl = class(TdxBarSubItemControl)
  private
    function GetItem: TSystemMenuSubItem;
  protected
    function CanCustomize: Boolean; override;
    function CanSelect: Boolean; override;
    procedure DblClick; override;
    function HasShadow: Boolean; override;
    function GetHeight: Integer; override;
    function GetWidth: Integer; override;
    function IsExpandable: Boolean; override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;
    function WantsDblClick: Boolean; override;
  public
    property Item: TSystemMenuSubItem read GetItem;
  end;

function TSystemMenuSubItemControl.GetItem: TSystemMenuSubItem;
begin
  Result := TSystemMenuSubItem(ItemLink.Item);
end;

function TSystemMenuSubItemControl.CanCustomize: Boolean;
begin
  Result := False;
end;

function TSystemMenuSubItemControl.CanSelect: Boolean;
begin
  Result := not BarManager.IsCustomizing;
end;

procedure TSystemMenuSubItemControl.DblClick;
begin
  inherited;
  Parent.HideAll;
  with Item do
    SendMessage(FMDIChildHandle, WM_SYSCOMMAND,
      GetMenuDefaultItem(GetSystemMenu(FMDIChildHandle, False), 0, 0), 0);
end;

function TSystemMenuSubItemControl.HasShadow: Boolean;
begin
  Result := False;
end;

function TSystemMenuSubItemControl.GetHeight: Integer;
begin
  Result := GetSystemMetrics(SM_CYSMICON);
end;

function TSystemMenuSubItemControl.GetWidth: Integer;
begin
  Result := GetSystemMetrics(SM_CXSMICON);
end;

function TSystemMenuSubItemControl.IsExpandable: Boolean;
begin
  Result := False;
end;

procedure TSystemMenuSubItemControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
var
  Icon: HIcon;
begin
  Icon := Item.IconHandle;
  with ARect do
    DrawIconEx(Parent.Canvas.Handle, Left, Top, Icon,
      Right - Left, Bottom - Top, 0, Parent.BkBrush, DI_NORMAL);
  DestroyIcon(Icon);
end;

function TSystemMenuSubItemControl.WantsDblClick: Boolean;
begin
  Result := True;
end;

{ continuation }

function TdxBarManager.ActiveMDIChild: HWND;
begin
  Result := SendMessage(TDummyForm(FMainForm).ClientHandle, WM_MDIGETACTIVE, 0, 0);
end;

procedure TdxBarManager.MainFormClientWndProc(Msg: UINT; wParam: WPARAM; lParam: LPARAM);
var
  AActiveMDIChild: HWND;
  PrevIsMDIMaximized: Boolean;
  PrevLockUpdate: Boolean;

  procedure RefreshMainMenu(AWnd: HWND; AddItems, OnlySystemMenu, LeaveUpdateLocked: Boolean);
  var
    AForm: TWinControl;
    ABarManager: TdxBarManager;
    I: Integer;
    AItemLink: TdxBarItemLink;
    
    procedure CreateMDIChildSystemMenu(AWnd: HWND);
    var
      SystemMenuSubItem: TSystemMenuSubItem;
    begin
      if GetSystemMenu(AWnd, False) = 0 then Exit;
      MainMenuBar.LockUpdate := True;
      ClearInternalItemList;
      SystemMenuSubItem := TSystemMenuSubItem.Create(FMainForm);
      InternalItemList.Add(SystemMenuSubItem);
      SystemMenuSubItem.MDIChildHandle := AWnd;
      with MainMenuBar.ItemLinks.Add do
      begin
        Item := SystemMenuSubItem;
        Index := 0;
      end;
    end;

    procedure DestroyMDIChildSystemMenu;
    begin
      if (MainMenuBar.ItemLinks.Count <> 0) and
        (MainMenuBar.ItemLinks[0].Item is TSystemMenuSubItem) then
      begin
        MainMenuBar.LockUpdate := True;
        MainMenuBar.ItemLinks[0].Free;
        ClearInternalItemList;
      end;
    end;

  {$IFDEF DELPHI4}
  var
    PrevBoundsRect: TRect;

    procedure SetRightWindowRect;
    var
      AHandle: HWND;
      R: TRect;
    begin
      with TDummyForm(ABarManager.MainForm) do
        if HandleAllocated then
        begin
          AHandle := Handle;
          PrevBoundsRect := BoundsRect;
          GetWindowRect(AHandle, R);
          MapWindowPoints(0, GetParent(AHandle), R, 2);
          WindowHandle := 0;
          BoundsRect := R;
          WindowHandle := AHandle;
        end;
    end;

    procedure RestoreOriginalWindowRect;
    var
      AHandle: HWND;
    begin
      with TDummyForm(ABarManager.MainForm) do
        if HandleAllocated then
        begin
          AHandle := Handle;
          WindowHandle := 0;
          BoundsRect := PrevBoundsRect;
          WindowHandle := AHandle;
        end;
    end;
  {$ENDIF}

  begin
    AForm := FindControl(AWnd);
    if (MainMenuBar = nil) or (AForm = nil) then Exit;

    if AddItems and IsZoomed(AWnd) then
      CreateMDIChildSystemMenu(AWnd)
    else
      if not AddItems then
        DestroyMDIChildSystemMenu;
    if OnlySystemMenu then Exit;    

    with TDummyForm(FMainForm) do
    begin
      ABarManager := GetBarManagerByForm(TCustomForm(AForm));
      if (ABarManager = nil) or (ABarManager.MainMenuBar = nil) then Exit;

      if AddItems and (FAlwaysMerge or IsZoomed(AWnd)) then
      begin
        FPrevChildMainMenuVisible := ABarManager.MainMenuBar.Visible;
        if Assigned(FOnMenuMerge) then
          FOnMenuMerge(Self, ABarManager, True)
        else
        begin
          MainMenuBar.LockUpdate := True;
          for I := 0 to ABarManager.MainMenuBar.ItemLinks.CanVisibleItemCount - 1 do
          begin
            AItemLink := MainMenuBar.ItemLinks.Add;
            AItemLink.Assign(ABarManager.MainMenuBar.ItemLinks.CanVisibleItems[I]);
          end;
          MainMenuBar.LockUpdate := PrevLockUpdate;
        end;
        {$IFDEF DELPHI4}SetRightWindowRect;{$ENDIF}
        ABarManager.MainMenuBar.Visible := False;
        {$IFDEF DELPHI4}RestoreOriginalWindowRect;{$ENDIF}
      end;
      if not AddItems then
      begin
        MainMenuBar.LockUpdate := True;
        for I := MainMenuBar.ItemLinks.CanVisibleItemCount - 1 downto 0 do
        begin
          AItemLink := MainMenuBar.ItemLinks.CanVisibleItems[I];
          if AItemLink.Item.BarManager = ABarManager then AItemLink.Free;
        end;
        if not LeaveUpdateLocked then
          MainMenuBar.LockUpdate := PrevLockUpdate;
        if Assigned(FOnMenuMerge) then
          FOnMenuMerge(Self, ABarManager, False);
        {$IFDEF DELPHI4}SetRightWindowRect;{$ENDIF}
        if not FAlwaysMerge and not ABarManager.MainMenuBar.Visible then
          ABarManager.MainMenuBar.Visible := FPrevChildMainMenuVisible;
        {$IFDEF DELPHI4}RestoreOriginalWindowRect;{$ENDIF}
      end;
    end;
  end;

begin
  AActiveMDIChild := ActiveMDIChild;
  PrevIsMDIMaximized := IsMDIMaximized;
  IsMDIMaximized := (AActiveMDIChild <> 0) and IsZoomed(AActiveMDIChild);

  if MainMenuBar <> nil then
    PrevLockUpdate := MainMenuBar.LockUpdate
  else
    PrevLockUpdate := False;
  try
    if AActiveMDIChild <> FPrevActiveMDIChild then
    begin
      RefreshMainMenu(FPrevActiveMDIChild, False, False, True);
      RefreshMainMenu(AActiveMDIChild, True, False, False);
    end
    else
      if IsMDIMaximized <> PrevIsMDIMaximized then
        RefreshMainMenu(AActiveMDIChild, IsMDIMaximized, FAlwaysMerge, False);
  finally
    if MainMenuBar <> nil then
      MainMenuBar.LockUpdate := PrevLockUpdate;
  end;

  if (IsMDIMaximized <> PrevIsMDIMaximized) and (MainMenuControl <> nil) then
    MainMenuControl.RepaintBar;
  FPrevActiveMDIChild := AActiveMDIChild;
end;

procedure TdxBarManager.MainFormWndProc(Msg: UINT; wParam: WPARAM; lParam: LPARAM);
var
  AControl: TWinControl;
  P: TPoint;
  AItem: TdxBarItemControl;
  ContextID: Integer;
  I: Integer;

  procedure ActivateToolbars(Activate, ForceHiding: Boolean; ActiveWindow: HWND);
  begin
    FMainFormActive := Activate;
    ShowToolbars(Activate, ForceHiding, ActiveWindow);
  end;

begin
  if (csDestroying in FMainForm.ComponentState) or (FMainForm = dxBarCustomizingForm) then
  begin
    if (Msg = WM_DESTROY) and not FDesigning then
    begin
      if FStoreInRegistry then SaveToRegistry(FRegistryPath);
      if FStoreInIniFile then SaveToIniFile(FIniFileName);
    end;
    Exit;
  end;

  case Msg of
    WM_ACTIVATE:
      begin
        if (LOWORD(wParam) = WA_INACTIVE) and (FindControl(lParam) is TCustomdxBarControl) then
          with TCustomdxBarControl(FindControl(lParam)) do
            if (BarManager = Self) {and IsActive}{for control containers} then Exit;
        FMainFormActive := LOWORD(wParam) <> WA_INACTIVE;
//        if (LOWORD(wParam) <> WA_INACTIVE) and not IsWindowVisible(MainForm.Handle) then Exit;
        ActivateToolbars(FMainFormActive, False, lParam);
        if not FToolbarsVisibleChanging and FMainFormActive and
          (dxBarCustomizingForm <> nil) and FIsCustomizing and
          not IsWindowEnabled(MainForm.Handle) then
          SendMessage(dxBarCustomizingForm.Handle, Msg, wParam, MainForm.Handle);
      end;

    WM_ACTIVATEAPP:
      if wParam = 0 then
      begin
        ActivateToolbars(False, False, 0);
        if SelectedItem <> nil then
          SendMessage(SelectedItem.Parent.Handle, WM_MOUSELEAVE, 0, 0);
        SelectedItem := nil;
      end;

    WM_CREATE:
      if FTempBarsList <> nil then
      begin
        for I := 0 to DockControlCount - 1 do
          DockControls[I].HandleNeeded;
        for I := FTempBarsList.Count - 1 downto 0 do
          TdxBar(FTempBarsList[I]).Visible := True;
        FTempBarsList.Free;
        FTempBarsList := nil;
      end;

    WM_DISPLAYCHANGE: CheckToolbarsVisibility;

    WM_HELP:
      if not FDesigning then
        with PHelpInfo(lParam)^ do
          if iContextType = HELPINFO_WINDOW then
          begin
            AItem := nil;
            if ActiveBarControl <> nil then
            begin
              AControl := ActiveBarControl;
              AItem := TCustomdxBarControl(AControl).SelectedItem;
              if (AItem = nil) or (AItem.Item.HelpContext = 0) then
              begin
                while TCustomdxBarControl(AControl).ParentBar <> nil do
                begin
                  AItem := TdxBarSubMenuControl(AControl).FSubItem;
                  AControl := TCustomdxBarControl(AControl).ParentBar;
                  if AItem.Item.HelpContext <> 0 then Break;
                end;
                if (AItem = nil) or (AItem.Item.HelpContext = 0) then
                begin
                  HideAll;
                  ContextID := AControl.HelpContext;
                  if ContextID <> 0 then
                    if biHelp in TDummyForm(FMainForm).BorderIcons then
                      Application.HelpCommand(HELP_CONTEXTPOPUP, ContextID)
                    else
                      Application.HelpContext(ContextID);
                  Exit;
                end;
              end;
            end
            else
            begin
              AControl := FindControl(hItemHandle);
              if AControl is TCustomdxBarControl then
              begin
                P := MousePos;
                ScreenToClient(AControl.Handle, P);
                AItem := TCustomdxBarControl(AControl).ItemAtPos(P);
              end;
            end;
            if AItem <> nil then
            begin
              with AItem.ItemLink.ItemRect do P := Point((Left + Right) div 2, Bottom);
              ClientToScreen(AControl.Handle, P);
              ContextID := AItem.Item.HelpContext;
              HideAll;
              if ContextID = 0 then Exit;
              if biHelp in TDummyForm(FMainForm).BorderIcons then
              begin
                Application.HelpCommand(HELP_SETPOPUP_POS, Longint(PointToSmallPoint(P)));
                Application.HelpCommand(HELP_CONTEXTPOPUP, ContextID);
              end
              else
                Application.HelpContext(ContextID);
            end;
          end;

    WM_MDIACTIVATE:
      if TDummyForm(MainForm).FormStyle = fsMDIChild then
        ActivateToolbars(HWND(lParam) = MainForm.Handle, False, 0);

    {WM_NCACTIVATE:   - does not allow submenu.edit.setfocus
      if TDummyForm(MainForm).FormStyle = fsMDIChild then
        ActivateToolbars(Boolean(wParam), False, 0);}

    WM_SETTINGCHANGE:
      case wParam of
        SPI_SETNONCLIENTMETRICS: AssignFont;
        SPI_SETWORKAREA: CheckToolbarsVisibility;
      end;

    WM_SYSCOLORCHANGE:
      begin
        RefreshDeviceConsts;
        CreatePatternBrush;
        CreateFlatToolbarsBrushes;
        RefreshFloatingBarsShadows;
        if TDummyForm(MainForm).FormStyle = fsMDIForm then
          for I := 0 to dxBarManagerList.Count - 1 do
            if TDummyForm(dxBarManagerList[I].MainForm).FormStyle = fsMDIChild then
              dxBarManagerList[I].MainFormWndProc(MSg, wParam, lParam);
      end;

    WM_SYSCOMMAND:
      begin
        if (wParam = SC_CLOSE) and FDesigning and
          (ActiveBarControl <> nil) and (ActiveBarControl.BarManager = Self) then
          ActiveBarControl.HideAll;
        if (wParam = SC_MINIMIZE) or (wParam = SC_MAXIMIZE) or
          (wParam = SC_RESTORE) or (wParam = SC_CLOSE) then
        begin
          for I := 0 to Bars.Count - 1 do
            with Bars[I] do
              if Visible and (Control <> nil) and (DockingStyle = dsNone) then
                with Control do
                  if (wParam = SC_MINIMIZE) or (wParam = SC_CLOSE) then
                    ShowWindow(Handle, SW_HIDE)
                  else
                  begin
                    ShowWindow(Handle, SW_SHOWNOACTIVATE);
                    UpdateWindow(Handle);
                  end;
          //if IsWindowVisible(MainForm.Handle) then ProcessPaintMessages;
        end;
      end;

    WM_WINDOWPOSCHANGED:
      if FIsCustomizing and (dxBarCustomizingForm <> nil) then
      begin
        dxBarCustomizingForm.UpdateVisibility(PWindowPos(lParam)^);
        if dxBarSubMenuEditor <> nil then
          if PWindowPos(lParam)^.flags and SWP_SHOWWINDOW <> 0 then
            ShowWindow(dxBarSubMenuEditor.Handle, SW_SHOWNA)
          else
            if PWindowPos(lParam)^.flags and SWP_HIDEWINDOW <> 0 then
              ShowWindow(dxBarSubMenuEditor.Handle, SW_HIDE);
      end;

    WM_WINDOWPOSCHANGING:
      if PWindowPos(lParam)^.flags and SWP_HIDEWINDOW <> 0 then
        ActivateToolbars(False, True, 0);
  end;
end;

function TdxBarManager.LoadMainFormFromBin: TForm;
var
  HInstance: HINST;
  ResName, S: string;
  HResource: THandle;
  PrevCursor: TCursor;
  ResStream: TResourceStream;
  OutStream, BinStream: TMemoryStream;
  StrList, OutStrList: TStringList;
  I, J: Integer;
  TempBarManager: TdxBarManager;
begin
  Result := nil;

  HInstance := FindResourceHInstance(FindClassHInstance(MainForm.ClassType));
  ResName := MainForm.ClassName;
  HResource := FindResource(HInstance, PChar(ResName), RT_RCDATA);
  if HResource = 0 then Exit;

  PrevCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  ResStream := TResourceStream.Create(HInstance, ResName, RT_RCDATA);
  OutStream := TMemoryStream.Create;
  BinStream := TMemoryStream.Create;
  try
    ObjectBinaryToText(ResStream, OutStream);
    OutStream.Position := 0;
    StrList := TStringList.Create;
    try
      StrList.LoadFromStream(OutStream);

      OutStrList := TStringList.Create;
      try
        // add Width, Height, ClientWidth, ClientHeight values
        J := 0;
        for I := 1 to StrList.Count - 1 do
        begin
          S := StrList[I];
          if (Copy(S, 3, 7) = 'Width =') or
            (Copy(S, 3, 8) = 'Height =') or
            (Copy(S, 3, 13) = 'ClientWidth =') or
            (Copy(S, 3, 14) = 'ClientHeight =') then
          begin
            OutStrList.Add(StrList[I]);
            Inc(J);
            if J = 2 then Break;
          end;
        end;

        S := 'object ' + Name + ': ' + ClassName;
        for I := 5 to StrList.Count - 1 do
          if Trim(StrList[I]) = S then
          begin
            S := Copy(StrList[I], 1, Pos('o', StrList[I]) - 1) + 'end';
            for J := I to StrList.Count - 1 do
            begin
              if Copy(TrimLeft(StrList[J]), 1, 2) <> 'On' then
                OutStrList.Add(StrList[J]);
              if StrList[J] = S then Break;
            end;
            OutStrList.Insert(0, 'object TempForm: TdxBarTempForm');
            OutStrList.Add('end');

            OutStream.Clear;
            OutStrList.SaveToStream(OutStream);
            OutStream.Position := 0;
            ObjectTextToBinary(OutStream, BinStream);
            BinStream.Position := 0;
            Result := TForm.Create(nil);
            try
              RegisterClass(TPersistentClass(ClassType));
              InternalLoading := True;
              try
                BinStream.ReadComponent(Result);
              finally
                InternalLoading := False;
              end;
              UnregisterClass(TPersistentClass(ClassType));
            except
              Result.Free;
              Result := nil;
              raise;
            end;
            Break;
          end;
      finally
        OutStrList.Free;
      end;
    finally
      StrList.Free;
    end;
  finally
    BinStream.Free;
    OutStream.Free;
    ResStream.Free;
    Screen.Cursor := PrevCursor;
  end;
  if Result <> nil then
  begin
    TempBarManager := TdxBarManager(Result.FindComponent(Name));
    if TempBarManager <> nil then
    begin
      TempBarManager.StoreInIniFile := False;
      TempBarManager.StoreInRegistry := False;
    end;
  end;
end;

procedure TdxBarManager.CheckToolbarsVisibility;
var
  WorkArea, R: TRect;
  I: Integer;
begin
  with FMainForm do
    WorkArea := GetWorkArea(Point(Left + Width div 2, Top + Height div 2));
  for I := 0 to FBars.Count - 1 do
    with FBars[I] do
      if DockingStyle = dsNone then
      begin
        if Control = nil then
          R := Bounds(FloatLeft, FloatTop,
            BarNCSizeX(dsNone) + FloatClientWidth, BarNCSizeY(dsNone) + FloatClientHeight)
        else
          R := Control.BoundsRect;
        with WorkArea do
        begin
          if R.Bottom > Bottom then OffsetRect(R, 0, Bottom - R.Bottom);
          if R.Top < Top then OffsetRect(R, 0, Top - R.Top);
          if R.Right > Right then OffsetRect(R, Right - R.Right, 0);
          if R.Left < Left then OffsetRect(R, Left - R.Left, 0);
        end;
        if Control = nil then
        begin
          FloatLeft := R.Left;
          FloatTop := R.Top;
        end
        else
          Control.BoundsRect := R;
      end;
end;

var
  HintTimerABarManager: TdxBarManager;

procedure ShowHintTimerProc(Wnd: HWnd; Msg, TimerID, SysTime: Longint); stdcall;
begin
  if (HintTimerABarManager <> nil) and
    not HintTimerABarManager.IsDestroying then
    with HintTimerABarManager do
    begin
      KillHintTimer;
      DisplayHint;
    end;
end;

procedure HideHintTimerProc(Wnd: HWnd; Msg, TimerID, SysTime: Longint); stdcall;
begin
  if (HintTimerABarManager <> nil) and
    not HintTimerABarManager.IsDestroying then
    with HintTimerABarManager do
    begin
      KillHintTimer;
      HintActivate(False, '');
    end;
end;

procedure KillHiddenHintTimerProc(Wnd: HWnd; Msg, TimerID, SysTime: Longint); stdcall;
begin
  KillHiddenHintTimer;
end;

procedure TdxBarManager.DisplayHint;
var
  P: TPoint;
  S, S1: string;
{$IFDEF DELPHI4}
  Action: TBasicAction;
{$ENDIF}
begin
  if (SelectedItem <> nil) and (SelectedItem.Parent <> nil) and
    not SelectedItem.Parent.IsActive or (FCustomHint <> '') then
  begin
    GetCursorPos(P);
    if FCustomHint = '' then
      with SelectedItem.Parent do
        if ItemAtPos(ScreenToClient(P)) <> Self.SelectedItem then Exit;
    Inc(P.Y, HintOffset);
    if FCustomHint = '' then
    begin
      S := GetShortHint(SelectedItem.Hint);
    {$IFDEF DELPHI4}
      Action := SelectedItem.Item.Action;
      if Action is TCustomAction then
        if not TCustomAction(Action).DoHint(S) then
        begin
          HintActivate(False, '');
          Exit;
        end;
    {$ENDIF}
    end
    else S := FCustomHint;
    if (S <> '') and
      ((FCustomHint <> '') or (SelectedItem.Enabled or ShowHintForDisabledItems)) then
    begin
      if (FCustomHint = '') and
        (ShowShortCutInHint{$IFDEF DELPHI4} or Application.HintShortCuts{$ENDIF}) then
      begin
        S1 := ShortCutToText(SelectedItem.ShortCut);
        if S1 <> '' then S := S + ' (' + S1 + ')';
      end;
      FHintWindow.ActivateHint(P, S, Self);
      FHintWindowShowing := True;
      HintTimerABarManager := Self;
      FHintTimerID := SetTimer(0, 0, dxBarWaitForHideHintTime, @HideHintTimerProc);
    end
    else HintActivate(False, '');
  end;
end;

procedure TdxBarManager.HintActivate(AShow: Boolean; const CustomHint: string);
var
  PrevShow: Boolean;
begin
  if IsCustomizing or not FShowHint then Exit;
  FCustomHint := CustomHint;
  FHintWindowShowing := False;
  PrevShow := AShow;
  AShow := AShow and
    ((FSelectedItem <> nil) and not FSelectedItem.Parent.IsActive or (FCustomHint <> ''));
  if AShow then
  begin
    KillHintTimer;
    if not IsWindowVisible(FHintWindow.Handle) and not FLiveHiddenHint then
    begin
      HintTimerABarManager := Self;
      FHintTimerID := SetTimer(0, 0, dxBarWaitForShowHintTime, @ShowHintTimerProc);
    end
    else DisplayHint;
  end
  else
  begin
    KillHintTimer;
    if IsWindowVisible(FHintWindow.Handle) then
    begin
      ShowWindow(FHintWindow.Handle, SW_HIDE);
      if PrevShow then
      begin
        KillHiddenHintTimer;
        FLiveHiddenHint := True;
        FHiddenHintTimerID := SetTimer(0, 0, dxBarHiddedHintLifeTime, @KillHiddenHintTimerProc);
      end;
    end;  
  end;
end;

procedure TdxBarManager.DestroyItems;
var
  AItem: TdxBarItem;
begin
  while FItems.Count > 0 do
  begin
    AItem := TdxBarItem(FItems.Last);
    FItems.Remove(AItem);
    AItem.Free;
  end;
end;

procedure TdxBarManager.HelpButtonGlyphChanged(Sender: TObject);
begin
  UpdateHelpButton;
end;

procedure TdxBarManager.HotImageListChange(Sender: TObject);
begin
  HotImagesChanged;
end;

procedure TdxBarManager.ImageListChange(Sender: TObject);
begin
  if not IsLoading then ImagesChanged;
end;

procedure TdxBarManager.LargeImageListChange(Sender: TObject);
begin
  LargeImagesChanged;
end;

procedure TdxBarManager.ToolbarsPopupClick(Sender: TObject);
begin
  if TComponent(Sender).Tag = 1000 then Customizing(True)
  else
    with Bars[TComponent(Sender).Tag] do
      Visible := not Visible;
end;

procedure TdxBarManager.CalcMostRecentlyUsedUseCount;
var
  I: Integer;
begin
  if FMostRecentItemsPercents = 100 then FMostRecentlyUsedUseCount := 0
  else
    for I := 1 to MaxInt do
      if I * (100 - FMostRecentItemsPercents) div 100 > 0 then
      begin
        FMostRecentlyUsedUseCount := I;
        Break;
      end;
end;

function TdxBarManager.ShowRecentItemsFirst: Boolean;
begin
  Result := (Style <> bmsStandard) and MenusShowRecentItemsFirst;
end;

procedure TdxBarManager.AddDockControl(ADockControl: TdxDockControl);
begin
  FDockControls.Add(ADockControl);
  FreeNotification(ADockControl);
end;

procedure TdxBarManager.RemoveDockControl(ADockControl: TdxDockControl);
var
  I: Integer;
begin
  if FBars <> nil then
    for I := 0 to FBars.Count - 1 do
      with FBars[I] do
      begin
        if DockControl = ADockControl then DockControl := nil;
        if DockedDockControl = ADockControl then DockedDockControl := nil;
        if RealDockControl = ADockControl then Visible := False;
      end;
  if FDockControls <> nil then FDockControls.Remove(ADockControl);
  if ADockControl.Main and (FBars <> nil) then
    FBars.FDockControls[ADockControl.FDockingStyle] := nil;
  ADockControl.ParentColor := True;
end;

procedure TdxBarManager.AddGroup(AGroup: TdxBarGroup);
begin
  FGroups.Add(AGroup);
  AGroup.FBarManager := Self;
end;

procedure TdxBarManager.RemoveGroup(AGroup: TdxBarGroup);
begin
  FGroups.Remove(AGroup);
end;

function TdxBarManager.IsDockColorStored: Boolean;
begin
  Result := not FAutoDockColor;
end;

procedure TdxBarManager.ReadDockControlHeights(Reader: TReader);
begin
  with Reader, FBars do
  begin
    ReadListBegin;
    try
      FDockControls[dsLeft].Width := ReadInteger;
      FDockControls[dsRight].Width := ReadInteger;
      FDockControls[dsTop].Height := ReadInteger;
      FDockControls[dsBottom].Height := ReadInteger;
    finally
      ReadListEnd;
    end;  
  end;
end;

procedure TdxBarManager.WriteDockControlHeights(Writer: TWriter);
begin
  with Writer, FBars do
  begin
    WriteListBegin;
    try
      WriteInteger(FDockControls[dsLeft].Width);
      WriteInteger(FDockControls[dsRight].Width);
      WriteInteger(FDockControls[dsTop].Height);
      WriteInteger(FDockControls[dsBottom].Height);
    finally
      WriteListEnd;
    end;
  end;
end;

procedure TdxBarManager.CreateFlatToolbarsBrushes;
begin
  DestroyFlatToolbarsBrushes;
  FFlatToolbarsBorderBrush := CreateSolidBrush(FlatToolbarsBorderColor);
  FFlatToolbarsBrush := CreateSolidBrush(FlatToolbarsColor);
  FFlatToolbarsDownedBrush := CreateSolidBrush(FlatToolbarsDownedColor);
  FFlatToolbarsDownedSelBrush := CreateSolidBrush(FlatToolbarsDownedSelColor);
  FFlatToolbarsSelBrush := CreateSolidBrush(FlatToolbarsSelColor);
end;

procedure TdxBarManager.DestroyFlatToolbarsBrushes;
begin
  if FFlatToolbarsSelBrush <> 0 then DeleteObject(FFlatToolbarsSelBrush);
  if FFlatToolbarsDownedSelBrush <> 0 then DeleteObject(FFlatToolbarsDownedSelBrush);
  if FFlatToolbarsDownedBrush <> 0 then DeleteObject(FFlatToolbarsDownedBrush);
  if FFlatToolbarsBrush <> 0 then DeleteObject(FFlatToolbarsBrush);
  if FFlatToolbarsBorderBrush <> 0 then DeleteObject(FFlatToolbarsBorderBrush);
end;

procedure TdxBarManager.RefreshFloatingBarsShadows;
var
  I: Integer;
begin
  for I := 0 to Bars.Count - 1 do
    if (Bars[I].DockingStyle = dsNone) and (Bars[I].Control <> nil) then
      Bars[I].Control.RefreshShadow;
end;

procedure TdxBarManager.AssignFont;
var
  NonClientMetrics: TNonClientMetrics;
begin
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0);
  if FUseSystemFont then
  begin
    FInternalFontChange := True;
    try
      Font.Handle := CreateFontIndirect(NonClientMetrics.lfMenuFont);
    finally
      FInternalFontChange := False;
    end;
  end
  else
    if FScaled then
      Font.Height := NonClientMetrics.lfMenuFont.lfHeight;
end;

function TdxBarManager.CanReset: Boolean;
begin
  Result := (FReadStateCount = 1) and FAllowReset; 
end;

procedure TdxBarManager.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('DockControlHeights', ReadDockControlHeights, WriteDockControlHeights, True);
end;

procedure TdxBarManager.DesignerModified;

  function ImagesAreLoaded: Boolean;

    function ComponentIsLoaded(AComponent: TComponent): Boolean;
    begin
      Result := (AComponent = nil) or not (csLoading in AComponent.ComponentState);
    end;

  begin
    Result :=
      ComponentIsLoaded(HotImages) and ComponentIsLoaded(Images) and ComponentIsLoaded(LargeImages);
  end;

begin
  if not IsLoading and not IsDestroying then
  begin
    FModified := True;
    if Designing and
      not FFirstDocksUpdate and (FMainForm <> nil) and (FMainForm.Designer <> nil) and
      ImagesAreLoaded then
      FMainForm.Designer.Modified;
  end;
end;

procedure TdxBarManager.DoBarAfterReset(ABar: TdxBar);
begin
  if Assigned(FOnBarAfterReset) then FOnBarAfterReset(Self, ABar);
end;

procedure TdxBarManager.DoBarBeforeReset(ABar: TdxBar);
begin
  if Assigned(FOnBarBeforeReset) then FOnBarBeforeReset(Self, ABar);
end;

procedure TdxBarManager.DoBarClose(ABar: TdxBar);
begin
  if Assigned(FOnBarClose) then FOnBarClose(Self, ABar);
end;

procedure TdxBarManager.DoBarDockingStyleChanged(ABar: TdxBar);
begin
  if not FBars.FLoading then
  begin
    if Assigned(FOnBarDockingStyleChange) then
      FOnBarDockingStyleChange(Self, ABar);
    DesignerModified;
  end;
end;

procedure TdxBarManager.DoClickItem(AItem: TdxBarItem);
begin
  if Assigned(FOnClickItem) then FOnClickItem(Self, AItem);
end;

procedure TdxBarManager.DoCloseButtonClick;
begin
  if Assigned(FOnCloseButtonClick) then FOnCloseButtonClick(Self);
end;

function TdxBarManager.DoDocking(ABar: TdxBar; AStyle: TdxBarDockingStyle;
  ADockControl: TdxDockControl): Boolean;
begin
  Result :=
    not (AStyle in ABar.NotDocking) and
    (((ADockControl = nil) or ADockControl.Main) and not (AStyle in NotDocking) or
     (ADockControl <> nil) and not ADockControl.Main and ADockControl.CanDocking(ABar));
  if Assigned(FOnDocking) then FOnDocking(ABar, AStyle, ADockControl, Result);
end;

procedure TdxBarManager.DoHelpButtonClick;
begin
  if Assigned(FOnHelpButtonClick) then FOnHelpButtonClick(Self);
end;

procedure TdxBarManager.DoShowCustomizingPopup(PopupItemLinks: TdxBarItemLinks);
begin
  if Assigned(FOnShowCustomizingPopup) then FOnShowCustomizingPopup(Self, PopupItemLinks);
end;

procedure TdxBarManager.DoShowToolbarsPopup(PopupItemLinks: TdxBarItemLinks);
begin
  if Assigned(FOnShowToolbarsPopup) then FOnShowToolbarsPopup(Self, PopupItemLinks);
end;

procedure TdxBarManager.DragAndDrop(AItem: TdxBarItem; AItemLink: TdxBarItemLink);
var
  PrevCursor: TCursor;
  CaptureWnd, Wnd: HWND;
  WasDragging, EndDrag, DragOverCategories,
    FDragCopy, CopyModeChanged, FDragLineVisible,
    IsFirstPart, IsBeginGroup, IsVerticalDirection,
    FDragOverBeginGroup, FDragOverFirstPart, FDragOverVerticalDirection,
    FSetBeginGroup, NeedRepaintBar: Boolean;
  Msg: TMsg;
  P, DragDownPoint: TPoint;
  AControl: TWinControl;
  ABarControl: TCustomdxBarControl;
  R: TRect;
  I: Integer;
  ACursor: TCursor;
  FDragOverItemControl, AItemControl: TdxBarItemControl;
  AList: TList;
  AItemLinks: TdxBarItemLinks;

  function NeedDragLineVisible: Boolean;
  begin
    Result := FDragOverItemControl <> nil;
    if Result then
      with FDragOverItemControl, DraggingItemLink do
        Result := not
          ((DraggingItemLink <> nil) and (GetAsyncKeyState(VK_CONTROL) >= 0) and

           ((ItemLink = DraggingItemLink) and
            (not FDragOverBeginGroup or not FDragOverFirstPart) or

            (VisibleIndex > 0) and
            (ItemLink = Owner.VisibleItems[VisibleIndex - 1]) and
            (not BeginGroup and not FDragOverBeginGroup and not FDragOverFirstPart) or

            (VisibleIndex < Owner.VisibleItemCount - 1) and
            (ItemLink = Owner.VisibleItems[VisibleIndex + 1]) and
            ((FDragOverBeginGroup and FDragOverFirstPart) or
             (not ItemLink.BeginGroup and FDragOverFirstPart))));
  end;

  procedure DrawDraggingLine;
  begin
    if FDragOverItemControl <> nil then
    begin
      Self.DrawDraggingLine(FDragOverItemControl,
        FDragOverBeginGroup, FDragOverFirstPart, FDragOverVerticalDirection);
      FDragLineVisible := not FDragLineVisible;
    end;
  end;

begin
  FDraggingItem := AItem;
  FDraggingItemLink := AItemLink;
  FDragging := True;
  if FDraggingItemLink <> nil then
  begin
    GetCursorPos(DragDownPoint);
    ScreenToClient(FDraggingItemLink.BarControl.Handle, DragDownPoint);
    with FDraggingItemLink.ItemRect do
    begin
      Dec(DragDownPoint.X, Left);
      Dec(DragDownPoint.Y, Top);
    end;
  end;

  ABarControl := nil;
  FDragOverItemControl := nil;
  FDragOverBeginGroup := False;
  FDragOverFirstPart := False;
  FDragOverVerticalDirection := False;
  WasDragging := False;
  EndDrag := False;
  DragOverCategories := False;

  FDragCopy := GetAsyncKeyState(VK_CONTROL) < 0;
  CopyModeChanged := False;
  FDragLineVisible := False;

  PrevCursor := Screen.Cursor;
  CaptureWnd := GetWindowForMouseCapturing;
  SetCapture(CaptureWnd);
  try
    while GetCapture = CaptureWnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      with Msg do
        if ((message = WM_KEYDOWN) or (message = WM_KEYUP)) and
          (wParam = VK_CONTROL) then
        begin
          CopyModeChanged := FDragCopy <> (message = WM_KEYDOWN);
          FDragCopy := message = WM_KEYDOWN;
          message := WM_MOUSEMOVE;
        end;
      case Msg.message of
        WM_KEYDOWN, WM_KEYUP:
          if Msg.wParam = VK_ESCAPE then Break;
        WM_MOUSEMOVE:
          begin
            WasDragging := True;
            GetCursorPos(P);  // don't change this line
            ABarControl := nil;

            Wnd := WindowFromPointEx(P);
            AControl := FindControl(Wnd);

            if (AControl is TCustomdxBarControl) and
              (TCustomdxBarControl(AControl).BarManager <> Self) then
            begin
              Wnd := 0;
              AControl := nil;
            end;

            if (dxBarCustomizingForm <> nil) and (DraggingItemLink = nil) and FDesigning then
              with dxBarCustomizingForm.LCategories do
                if AControl = dxBarCustomizingForm.LCategories then
                begin
                  Windows.ScreenToClient(Handle, P);
                  I := ItemAtPos(P, True);
                  if (0 <= I) and (I <= Items.Count - 1) then
                  begin
                    ItemIndex := I;
                    ACursor := crdxBarDrag;
                    DragOverCategories := True;
                  end
                  else
                  begin
                    ItemIndex := DraggingItem.Category;
                    ACursor := crdxBarDragNoDrop;
                    DragOverCategories := False;
                  end;
                  SetCursor(Screen.Cursors[ACursor]);
                  Continue;
                end
                else
                begin
                  ItemIndex := DraggingItem.Category;
                  DragOverCategories := False;
                end;

            if (dxBarSubMenuEditor <> nil) and (dxBarSubMenuEditor.Handle = Wnd) then
              dxBarSubMenuEditor.Perform(CM_ACTIVATE, 0, 0)
            else
              if AControl is TCustomdxBarControl then
                ABarControl := TCustomdxBarControl(AControl)
              else
              begin
                if dxBarCustomizingForm <> nil then
                  GetWindowRect(dxBarCustomizingForm.Handle, R);
                if (dxBarCustomizingForm = nil) or not PtInRect(R, P) then
                  for I := 0 to Bars.Count - 1 do
                    if (Bars[I].Control <> nil) and Bars[I].Control.WantMouse then
                    begin
                      ABarControl := Bars[I].Control;
                      Break;
                    end;
              end;

            if (ABarControl <> nil) and not ABarControl.CanCustomizing then
              ABarControl := nil;

            if ABarControl <> nil then
            begin
              ScreenToClient(ABarControl.Handle, P);
              AItemControl :=
                ABarControl.ItemAtPosEx(P, IsBeginGroup, IsFirstPart, IsVerticalDirection);
            end
            else
              AItemControl := nil;

            if (ABarControl = nil) or
              (AItemControl = nil) and (ABarControl.ItemLinks.VisibleItemCount <> 0) then
              ACursor := crdxBarDragNoDrop
            else
              if (GetAsyncKeyState(VK_CONTROL) < 0) or (FDraggingItemLink = nil) then
                ACursor := crdxBarDragCopy
              else
                ACursor := crdxBarDrag;
            SetCursor(Screen.Cursors[ACursor]);

            if ABarControl = nil then
            begin
              if FDragLineVisible then DrawDraggingLine;
              FDragOverItemControl := nil;
            end
            else
            begin
              if (not (ABarControl is TdxBarSubMenuControl) or
                (TdxBarSubMenuControl(ABarControl).FScrollTimerID = 0)) and
                ((AItemControl <> FDragOverItemControl) or
                 (IsBeginGroup <> FDragOverBeginGroup) or
                 (IsFirstPart <> FDragOverFirstPart) or
                 (IsVerticalDirection <> FDragOverVerticalDirection) or
                 CopyModeChanged) then
              begin
                if not CopyModeChanged and NeedDragLineVisible or
                  CopyModeChanged and
                  ((FDragCopy and not FDragLineVisible) or
                   (not FDragCopy and FDragLineVisible and not NeedDragLineVisible)) then
                  DrawDraggingLine;
                if AItemControl <> FDragOverItemControl then
                begin
                  if AItemControl <> nil then
                    if (AItemControl is TdxBarSubItemControl) or
                      (AItemControl.Parent.SelectedItem is TdxBarSubItemControl) then
                      AItemControl.Parent.SetMouseSelectedItem(AItemControl)
                    else
                    begin  // for better painting
                      SelectedItem := AItemControl;
                      AItemControl.Parent.FSelectedItem := AItemControl;
                    end;
                  FDragOverItemControl := AItemControl;
                end;
                if (FDragOverItemControl <> nil) and not CopyModeChanged then
                begin
                  FDragOverBeginGroup := IsBeginGroup;
                  FDragOverFirstPart := IsFirstPart;
                  FDragOverVerticalDirection := IsVerticalDirection;
                  if NeedDragLineVisible then DrawDraggingLine;
                end;
                CopyModeChanged := False;
              end;
              if ABarControl is TdxBarSubMenuControl then
              begin
                SendMessage(ABarControl.Handle, WM_MOUSEMOVE, 0, MakeLParam(P.X, P.Y));
                if TdxBarSubMenuControl(ABarControl).FScrollTimerID > 0 then
                begin
                  if FDragLineVisible then DrawDraggingLine;
                  FDragOverItemControl := nil;
                end;
              end;
            end;
          end;
        WM_LBUTTONUP:
          begin
            EndDrag := True;
            Break;
          end;
      else
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if FDragLineVisible and (SelectedItem <> nil) and (SelectedItem = FDragOverItemControl) then
      DrawDraggingLine;
    if GetCapture = CaptureWnd then ReleaseCapture;
    SetCursor(Screen.Cursors[PrevCursor]);
    if FDraggingItemLinkParentHandle <> 0 then
    begin
      DestroyWindow(FDraggingItemLinkParentHandle);
      FDraggingItemLinkParentHandle := 0;
    end;
    FDragging := False;
    if EndDrag and WasDragging then
      if DragOverCategories then
        if (dxBarCustomizingForm <> nil) and
          (DraggingItem.Category <> dxBarCustomizingForm.LCategories.ItemIndex) then
          with dxBarCustomizingForm do  // move item to another category
          begin
            AList := TList.Create;
            GetAllItemsByCategory(LCategories.ItemIndex, AList);
            if AList.Count > 0 then
            begin
              I := TdxBarItem(AList[AList.Count - 1]).Index + 1;
              if I > ItemCount - 1 then Dec(I);
              MoveItem(DraggingItem.Index, I);
            end;
            AList.Free;
            DraggingItem.Category := LCategories.ItemIndex;
          end
        else
      else
        if ABarControl = nil then
        begin
          if (DraggingItemLink <> nil) and (GetAsyncKeyState(VK_CONTROL) >= 0) then
          begin  // delete dragging itemlink
            DraggingItemLink.Free;
            FDraggingItemLink := nil;
            DesignerModified;
          end;
          if FSelectedItem <> nil then
          begin
            ABarControl := FSelectedItem.Parent;
            FSelectedItem := nil;
            ABarControl.RepaintBar;
          end;
        end
        else
          if ABarControl <> nil then
            if (FDragOverItemControl <> nil) and (FDraggingItemLink <> nil) and
              ((FDragOverItemControl.ItemLink = FDraggingItemLink) or not NeedDragLineVisible) and
              (GetAsyncKeyState(VK_CONTROL) >= 0) and
              not (FDragOverBeginGroup and FDragOverFirstPart) then
            begin  // change BeginGroup only
              GetCursorPos(P);
              ScreenToClient(FDraggingItemLink.BarControl.Handle, P);
              with FDraggingItemLink.ItemRect do
              begin
                Dec(P.X, Left);
                Dec(P.Y, Top);
              end;
              if (ABarControl is TdxBarSubMenuControl) or IsRealVertical(ABarControl) then
                I := P.Y - DragDownPoint.Y
              else
                I := P.X - DragDownPoint.X;
              if Abs(I) >= MakeBeginGroupDragSize then
                with FDraggingItemLink do
                  if BeginGroup <> (I > 0) then
                  begin
                    BarControl.FSelectedItem := Control;
                    FSelectedItem := Control;
                    BeginGroup := I > 0;
                  end
                  else
                    BarControl.SetKeySelectedItem(Control);
            end
            else  // create new [and delete old] itemlink
              if (FDragOverItemControl <> nil) or
                PtInRect(ABarControl.ClientRect, P) and
                (ABarControl.ItemLinks.VisibleItemCount = 0) then
                with ABarControl.ItemLinks.Add do
                begin
                  InternalBringToTopInRecentList(True);
                  AItemLinks := ABarControl.ItemLinks;

                  Item := FDraggingItem;
                  if DraggingItemLink <> nil then
                  begin
                    Assign(DraggingItemLink);
                    FBeginGroup := False;
                  end;

                  if FDragOverItemControl <> nil then
                  begin
                    FSetBeginGroup := FDragOverBeginGroup and not FDragOverFirstPart or
                      not FDragOverBeginGroup and FDragOverFirstPart and
                      FDragOverItemControl.ItemLink.BeginGroup;
                    Index := FDragOverItemControl.ItemLink.Index +
                      Byte(not FDragOverBeginGroup and not FDragOverFirstPart);
                    if FSetBeginGroup then
                    begin
                      BeginGroup := True;
                      with FDragOverItemControl do
                      begin
                        Parent.FDestroyFlag := True;  // for RepaintBar
                        ItemLink.BeginGroup := False;
                        Parent.FDestroyFlag := False;
                      end;
                    end;
                  end;
                  CreateControl;
                  FSelectedItem := Control;
                  ABarControl.FSelectedItem := Control;

                  if (DraggingItemLink <> nil) and (GetAsyncKeyState(VK_CONTROL) >= 0) then
                  begin
                    NeedRepaintBar := DraggingItemLink.Owner <> AItemLinks;
                    DraggingItemLink.Free;
                    FDraggingItemLink := nil;
                  end
                  else NeedRepaintBar := True;

                  if NeedRepaintBar and (AItemLinks.BarControl <> nil) then
                    AItemLinks.BarControl.RepaintBar;
                  DesignerModified;

                  // activate barcontrol which contains new itemlink
                  if (ActiveBarControl <> nil) and (AItemLinks.BarControl is TdxBarControl) and
                    (ActiveBarControl <> AItemLinks.BarControl) then
                  begin
                    ActiveBarControl.HideAll;
                    if AItemLinks.BarControl <> nil then
                      TdxBarControl(AItemLinks.BarControl).BarGetFocus(Control);
                  end;
                end
              else
                if SelectedItem <> nil then SelectedItem := nil;
    FDraggingItem := nil;
    if FDraggingItemLink <> nil then
      if FDraggingItemLink.Control <> nil then
        with FDraggingItemLink.Control do
        begin
          FDraggingItemLink := nil;
          Repaint;
        end
      else FDraggingItemLink := nil;
  end;
end;

function TdxBarManager.FindDockControl(APath: string): TdxBarDockControl;
var
  ARootName: string;
  ARoot: TComponent;
begin
  ARootName := Copy(APath, 1, Pos('.', APath) - 1);
  if ARootName <> '' then
  begin
    ARoot := FindGlobalComponent(ARootName);
    Delete(APath, 1, Length(ARootName) + 1);
  end
  else
    ARoot := FMainForm;
{$IFDEF DELPHI5}
  Result := FindNestedComponent(ARoot, APath) as TdxBarDockControl;
{$ELSE}
  Result := ARoot.FindComponent(APath) as TdxBarDockControl;
{$ENDIF}
end;

function TdxBarManager.GetCategoryRealIndex(AIndex: Integer): Integer;
var
  I: Integer;
begin
  if FDesigning then Result := AIndex
  else
  begin
    Result := -1;
    for I := 0 to FCategories.Count - 1 do
      if CategoryVisible[I] then
      begin
        Inc(Result);
        if Result = AIndex then
        begin
          Result := I;
          Exit;
        end;
      end;
    Result := -1;
  end;
end;

procedure TdxBarManager.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to GroupCount - 1 do
    if Groups[I].Owner = Root then Proc(Groups[I]);
  for I := 0 to ItemCount - 1 do
    if (Items[I].Owner = Root) and (Items[I].Category > -1) then Proc(Items[I]);
end;

function TdxBarManager.GetWindowForMouseCapturing: HWND;
begin
  if FIsCustomizing and (dxBarCustomizingForm <> nil) then
    Result := dxBarCustomizingForm.Handle
  else
    if IsWindowVisible(Application.Handle) then
      Result := Application.Handle
    else
      Result := FMainForm.Handle;
end;

procedure TdxBarManager.HotImagesChanged;
var
  PrevLockUpdate: Boolean;
  I: Integer;
begin
  if not IsLoading and not IsDestroying then
  begin
    PrevLockUpdate := LockUpdate;
    LockUpdate := True;
    try
      for I := 0 to ItemCount - 1 do
        if Items[I].UseHotImages then Items[I].HotGlyphChanged;
    finally
      LockUpdate := PrevLockUpdate;
    end;
  end;
end;

procedure TdxBarManager.ImagesChanged;
var
  PrevLockUpdate: Boolean;
  I: Integer;
begin
  if not IsLoading and not IsDestroying then
  begin
    PrevLockUpdate := LockUpdate;
    LockUpdate := True;
    try
      for I := 0 to ItemCount - 1 do
        if Items[I].ImageIndex > -1 then Items[I].GlyphChanged;
    finally
      LockUpdate := PrevLockUpdate;
    end;
  end;
end;

procedure TdxBarManager.LargeImagesChanged;
var
  PrevLockUpdate: Boolean;
  I: Integer;
begin
  if not IsLoading and not IsDestroying then
  begin
    PrevLockUpdate := LockUpdate;
    LockUpdate := True;
    try
      for I := 0 to ItemCount - 1 do
        if Items[I].UseLargeImages then Items[I].LargeGlyphChanged;
    finally
      LockUpdate := PrevLockUpdate;
    end;
  end;  
end;

procedure TdxBarManager.Loaded;
var
  I: Integer;
begin
  inherited Loaded;
  if LockUpdate then Exit;

  FBars.FLoading := True;
  for I := 0 to ItemCount - 1 do
    with Items[I] do
    begin
      if Items[I] is TCustomdxBarSubItem then
        TCustomdxBarSubItem(Items[I]).ItemLinks.Loaded(True);
      Visible := FLoadedVisible;
    end;
  for I := 0 to FBars.Count - 1 do
    with FBars[I] do
    begin
      FIsPredefined := True;
      ItemLinks.Loaded(True);
      DockControl := FLoadedDockControl;
      if DockControl = nil then
        DockingStyle := FLoadedDockingStyle;
      Visible := FLoadedVisible;
    end;
  if not FDesigning and not InternalLoading then
  begin
    if FStoreInRegistry then LoadFromRegistry(FRegistryPath);
    if FStoreInIniFile then LoadFromIniFile(FIniFileName);
  end;
  FBars.FLoading := False;

  for I := 0 to FCategories.Count - 1 do
    if FCategories.Objects[I] <> nil then
      CategoryItemsVisible[I] := PdxBarCategoryData(FCategories.Objects[I])^.LoadedItemsVisible;

  FFirstDocksUpdate := True;
  for I := 0 to DockControlCount - 1 do
    DockControls[I].UpdateDock;
  FFirstDocksUpdate := False;
end;

procedure TdxBarManager.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = HotImages then HotImages := nil;
    if AComponent = Images then Images := nil;
    if AComponent = LargeImages then LargeImages := nil;
    if AComponent is TControl then
      for I := 0 to FPopupMenuLinks.Count - 1 do
        if FPopupMenuLinks[I].Control = AComponent then
          FPopupMenuLinks[I].Control := nil;
    if AComponent is TdxBarPopupMenu then
      for I := 0 to FPopupMenuLinks.Count - 1 do
        if FPopupMenuLinks[I].PopupMenu = AComponent then
          FPopupMenuLinks[I].PopupMenu := nil;
  end;
end;

procedure TdxBarManager.ReadState(Reader: TReader);
begin
  inherited;
  Inc(FReadStateCount);
end;

procedure TdxBarManager.SetName(const NewName: TComponentName);
var
  I: Integer;
  OldName, ItemName, NamePrefix: TComponentName;
  Item: TdxBarItem;
begin
  OldName := Name;
  inherited SetName(NewName);
  if FDesigning and (Name <> OldName) then
    for I := 0 to FItems.Count - 1 do
    begin
      Item := Items[I];
      if Item.Owner = Owner then
      begin
        ItemName := Item.Name;
        NamePrefix := ItemName;
        if Length(NamePrefix) > Length(OldName) then
        begin
          SetLength(NamePrefix, Length(OldName));
          if CompareText(OldName, NamePrefix) = 0 then
          begin
            System.Delete(ItemName, 1, Length(OldName));
            System.Insert(NewName, ItemName, 1);
            try
              Item.Name := ItemName;
            except
              on EComponentError do
            end;
          end;
        end;
      end;
    end;
end;

procedure TdxBarManager.ShowToolbars(Show, ForceHiding: Boolean; ActiveWindow: HWND);
var
  I: Integer;
  ProcessId1, ProcessId2: Longint;

  function CanHideToolbars: Boolean;
  begin
    Result := FHideFloatingBarsWhenInactive or ForceHiding;
  end;

  procedure InvalidateBarsCaptions;
  var
    I: Integer;
  begin
    for I := 0 to Bars.Count - 1 do
      if (Bars[I].Control <> nil) and (Bars[I].DockingStyle = dsNone) then
        Bars[I].Control.FrameChanged;
  end;

begin
  if FToolbarsVisibleChanging then Exit;
  FToolbarsVisibleChanging := True;
  try
    if not CanHideToolbars then InvalidateBarsCaptions;
    if not Show then
    begin
      if not CanHideToolbars then Exit;
      if (ActiveBarControl <> nil) and
        ((ActiveBarControl.BarManager = Self) or
         FIsCustomizing and (ActiveBarControl.BarManager.MainForm = dxBarCustomizingForm)) then
        ActiveBarControl.HideAll;
      GetWindowThreadProcessId(FMainForm.Handle, @ProcessId1);
      GetWindowThreadProcessId(ActiveWindow, @ProcessId2);
      if (ActiveWindow = 0) or
        (FindControl(ActiveWindow) is TCustomForm) and
        ((dxBarCustomizingForm = nil) or (ActiveWindow <> dxBarCustomizingForm.Handle) or
         not FIsCustomizing) or
        (ProcessId1 <> ProcessId2) or (ActiveWindow = Application.Handle) then
      begin
        for I := 0 to Bars.Count - 1 do
          if (Bars[I].Control <> nil) and (Bars[I].DockingStyle = dsNone) then
            SetWindowPos(Bars[I].Control.Handle, 0, 0, 0, 0, 0,
              SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_HIDEWINDOW or SWP_NOACTIVATE);
        SendMessage(FMainForm.Handle, WM_NCACTIVATE, 0, 0);
      end;
    end
    else
      if not IsIconic(FMainForm.Handle) then
      begin
        for I := 0 to Bars.Count - 1 do
          with Bars[I] do
            if (Control <> nil) and Visible and (DockingStyle = dsNone) then
              with Control do
              begin
                ShowWindow(Handle, SW_SHOWNOACTIVATE);
                //UpdateWindow(Handle);
              end;
        //if IsWindowVisible(FMainForm.Handle) then ProcessPaintMessages;
      end;
  finally
    FToolbarsVisibleChanging := False;
  end;
end;

procedure TdxBarManager.UpdateItems(Sender: TdxBarItem);
begin
  if (Sender.Category > -1) and IsCustomizing and Designing and
    not (IsLoading or IsDestroying) then
    UpdateCustomizingBarItems;
end;

function TdxBarManager.BorderSizeX: Integer;
begin
  {if Flat then
    Result := dxBarFlatBorderSize
  else}
    Result := GetSystemMetrics(SM_CXFRAME);
end;

function TdxBarManager.BorderSizeY: Integer;
begin
  {if Flat then
    Result := dxBarFlatBorderSize
  else}
    Result := GetSystemMetrics(SM_CYFRAME);
end;

function TdxBarManager.GetLightColor(ABtnFaceColorPart, AHighlightColorPart, AWindowColorPart: Integer): COLORREF;
var
  ABtnFaceColor, AHighlightColor, AWindowColor: COLORREF;

  function GetLightIndex(ABtnFaceValue, AHighlightValue, AWindowValue: Byte): Integer;
  begin
    Result :=
      MulDiv(ABtnFaceValue, ABtnFaceColorPart, 100) +
      MulDiv(AHighlightValue, AHighlightColorPart, 100) +
      MulDiv(AWindowValue, AWindowColorPart, 100);
    if Result < 0 then Result := 0;
    if Result > 255 then Result := 255;
  end;

begin
  ABtnFaceColor := GetSysColor(COLOR_BTNFACE);
  AHighlightColor := GetSysColor(COLOR_HIGHLIGHT);
  AWindowColor := GetSysColor(COLOR_WINDOW);
  if (ABtnFaceColor = 0) or (ABtnFaceColor = $FFFFFF) then
    Result := AHighlightColor
  else
    Result := RGB(
      GetLightIndex(GetRValue(ABtnFaceColor), GetRValue(AHighlightColor), GetRValue(AWindowColor)),
      GetLightIndex(GetGValue(ABtnFaceColor), GetGValue(AHighlightColor), GetGValue(AWindowColor)),
      GetLightIndex(GetBValue(ABtnFaceColor), GetBValue(AHighlightColor), GetBValue(AWindowColor)));
end;

function TdxBarManager.BarByCaption(const ACaption: string): TdxBar;
var
  I: Integer;
begin
  for I := 0 to FBars.Count - 1 do
  begin
    Result := FBars[I];
    if Result.Caption = ACaption then Exit;
  end;
  Result := nil;
end;

function TdxBarManager.BarByName(const AName: string): TdxBar;
var
  I: Integer;
begin
  for I := 0 to FBars.Count - 1 do
  begin
    Result := FBars[I];
    if Result.Name = AName then Exit;
  end;
  Result := nil;
end;

function TdxBarManager.GetAllItemsByCategory(ACategory: Integer; List: TList): Integer;
var
  I: Integer;
begin
  List.Clear;
  if (0 <= ACategory) and (ACategory < Categories.Count) then
    for I := 0 to ItemCount - 1 do
      if Items[I].Category = ACategory then List.Add(Items[I]);
  Result := List.Count;
end;

function TdxBarManager.GetCountByCategory(ACategory: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  if (0 <= ACategory) and (ACategory < Categories.Count) then
    for I := 0 to ItemCount - 1 do
      with Items[I] do
        if (Category = ACategory) and
          (Designing or ActuallyVisible and not Hidden) then
          Inc(Result);
end;

function TdxBarManager.GetItemByCategory(ACategory, AIndex: Integer): TdxBarItem;
var
  List: TList;
begin
  Result := nil;
  List := TList.Create;
  GetItemsByCategory(ACategory, List);
  if (0 <= AIndex) and (AIndex < List.Count) then Result := TdxBarItem(List[AIndex]);
  List.Free;
end;

function TdxBarManager.GetItemByName(const AName: string): TdxBarItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ItemCount - 1 do
    if CompareText(Items[I].Name, AName) = 0 then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TdxBarManager.GetItemsByCategory(ACategory: Integer; List: TList): Integer;
var
  I: Integer;
begin
  if FDesigning then
    Result := GetAllItemsByCategory(ACategory, List)
  else
  begin
    List.Clear;
    if (0 <= ACategory) and (ACategory < Categories.Count) then
      for I := 0 to ItemCount - 1 do
        with Items[I] do
          if (Category = ACategory) and ActuallyVisible and not Hidden then
            List.Add(Items[I]);
    Result := List.Count;
  end;
end;

procedure TdxBarManager.MoveItem(CurIndex, NewIndex: Integer);
begin
  FItems.Move(CurIndex, NewIndex);
  DesignerModified;
end;

procedure TdxBarManager.ExchangeItems(Index1, Index2: Integer);
begin
  FItems.Exchange(Index1, Index2);
  DesignerModified;
end;

procedure TdxBarManager.CreateToolbarsPopupList(ItemLinks: TdxBarItemLinks);
var
  I: Integer;
begin
  for I := 0 to FBars.Count - 1 do
    if FBars[I].CanClose and not FBars[I].Hidden then
    begin
      InternalItemList.Add(TdxBarButton.Create(nil));
      with TdxBarButton(InternalItemList.Last) do
      begin
        Caption := FBars[I].Caption;
        Tag := I;
        OnClick := ToolbarsPopupClick;
        ButtonStyle := bsChecked;
        Down := FBars[I].Visible;
      end;
      ItemLinks.Add.Item := TdxBarItem(InternalItemList.Last);
    end;
  DoShowToolbarsPopup(ItemLinks);
  AddCustomizeLink(ItemLinks, True, TdxBarButton);
end;

procedure TdxBarManager.Customizing(Show: Boolean);
var
  I: Integer;
begin
  if (FIsCustomizing <> Show) and (not Show or (dxBarCustomizingForm = nil)) then
  begin
    for I := 0 to Bars.Count - 1 do
      if Bars[I].Control <> nil then
        with Bars[I].Control do
        begin
          HideAll;
          DestroyControls;
        end;
    FIsCustomizing := Show;
    for I := 0 to Bars.Count - 1 do
      with Bars[I] do
      begin
        ItemLinks.RefreshVisibilityLists;
        if Control <> nil then Control.CreateControls;
      end;
    for I := 0 to ItemCount - 1 do
      if Items[I] is TCustomdxBarSubItem then
         TCustomdxBarSubItem(Items[I]).ItemLinks.RefreshVisibilityLists;
    for I := 0 to FPopupMenus.Count - 1 do
      TdxBarPopupMenu(FPopupMenus[I]).ItemLinks.RefreshVisibilityLists;
    dxBarCustomizing(Self, Show);
    for I := 0 to Bars.Count - 1 do
      with Bars[I] do
        if Control <> nil then
          with Control do
          begin
            UpdateControlState;
            RepaintBar;
          end;
  end;
end;

procedure TdxBarManager.HideAll;
begin
  if (ActiveBarControl <> nil) {and (ActiveBarControl.BarManager = Self) }then
    ActiveBarControl.HideAll;
end;

procedure TdxBarManager.ResetUsageData;
var
  PrevLockUpdate: Boolean;
  TempForm: TForm;
  TempBarManager: TdxBarManager;
  I: Integer;
  TempSubItem: TCustomdxBarSubItem;
  TempBar: TdxBar;
begin
  PrevLockUpdate := LockUpdate;
  LockUpdate := True;
  try
    TempForm := LoadMainFormFromBin;
    if TempForm <> nil then
      try
        TempBarManager := TdxBarManager(TempForm.FindComponent(Name));
        if TempBarManager <> nil then
        begin
          for I := 0 to ItemCount - 1 do
            with Items[I] do
              if Items[I] is TCustomdxBarSubItem then
              begin
                TempSubItem := TCustomdxBarSubItem(TempForm.FindComponent(Name));
                if TempSubItem <> nil then
                  TCustomdxBarSubItem(Items[I]).ItemLinks.AssignUsageData(TempSubItem.ItemLinks);
              end;
          for I := 0 to FBars.Count - 1 do
            if I < TempBarManager.Bars.Count then
            begin
              TempBar := TempBarManager.Bars[I];
              FBars[I].ItemLinks.AssignUsageData(TempBar.ItemLinks);
            end;
        end;
      finally
        TempForm.Free;
      end;
  finally
    LockUpdate := PrevLockUpdate;
  end;
end;

procedure TdxBarManager.ResetUsageDataWithConfirmation;
begin
  if Application.MessageBox(PChar(LoadStr(DXBAR_WANTTORESETUSAGEDATA)),
    PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = ID_YES then
    ResetUsageData;
end;
{
var
  WhatIsThisMode: Boolean;
  WndProcRetHook: HHOOK;

function WndProcRetHookProc(Code: Integer; wParam: WParam; lParam: LParam): LRESULT; stdcall;
begin
  with PCWPRetStruct(lParam)^ do
    if message = WM_SETCURSOR then
      SetCursor(Screen.Cursors[crHelp]);
  Result := CallNextHookEx(WndProcRetHook, Code, wParam, lParam);
end;

procedure TdxBarManager.WhatIsThis;
var
  Msg: TMsg;
  P: TPoint;
begin
  if WhatIsThisMode then Exit;
  WhatIsThisMode := True;
  WndProcRetHook :=
    SetWindowsHookEx(WH_CALLWNDPROCRET, WndProcRetHookProc, HInstance, GetCurrentThreadId);
  try
    repeat
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      case Msg.message of
        WM_KEYDOWN, WM_KEYUP:
          if Msg.wParam = VK_ESCAPE then Break;
        WM_NCLBUTTONDOWN, WM_LBUTTONDOWN:
          begin
            P := SmallPointToPoint(TSmallPoint(Msg.lParam));
            ClientToScreen(Msg.hwnd, P);
            Application.MessageBox('Help!', '', 0);
            Break;
          end;
      end;
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    until False;
  finally
    UnhookWindowsHookEx(WndProcRetHook);
    WhatIsThisMode := False;
    SetCursor(Screen.Cursors[Screen.Cursor]);
  end;
end;
}
function GetComponentPath(AComponent: TComponent): string;
begin
  Result := AComponent.Name;
  while (AComponent.Owner <> nil) and (AComponent.Owner.Name <> '') do
  begin
    AComponent := AComponent.Owner;
    Result := AComponent.Name + '.' + Result;
  end;
end;

procedure TdxBarManager.LoadFromRegistry(ARegistryPath: string);
var
  Stream: TMemoryStream;
  Registry: TRegistry;
  I: Integer;
  AKey: string;
  PrevBarManagerLockUpdate, PrevLockUpdate, PrevLoading: Boolean;

  procedure ReadItemLinks(const AKey: string; AItemLinks: TdxBarItemLinks);
  var
    I: Integer;
  begin
    AItemLinks.Clear;
    with Registry do
    begin
      if ValueExists('ItemLinkCount') then I := ReadInteger('ItemLinkCount')
      else I := 0;
      CloseKey;
      try
        for I := 0 to I - 1 do
          if OpenKey(AKey + '\ItemLink' + IntToStr(I), False) then
            with AItemLinks.Add do
              try
                try
                  Item := GetItemByName(ReadString('ItemName'));
                  if Item = nil then Free
                  else
                  begin
                    BeginGroup := ReadBool('BeginGroup');
                    ReadBinaryData('UserDefine', FUserDefine, SizeOf(UserDefine));
                    if udCaption in UserDefine then
                      UserCaption := ReadString('UserCaption');
                    if udGlyph in UserDefine then
                    begin
                      Stream.SetSize(GetDataSize('UserGlyph'));
                      ReadBinaryData('UserGlyph', Stream.Memory^, Stream.Size);
                      UserGlyph.LoadFromStream(Stream);
                      Stream.Clear;
                    end;
                    if udPaintStyle in UserDefine then
                      UserPaintStyle := TdxBarPaintStyle(ReadInteger('UserPaintStyle'));
                    if udWidth in UserDefine then
                      UserWidth := ReadInteger('UserWidth');
                    if (AItemLinks.Owner is TdxBar) and ValueExists('Visible') then
                      FLoadedVisible := ReadBool('Visible');
                    if (BarManager.Style <> bmsStandard) and AItemLinks.FUseRecentItems then
                    begin
                      if ValueExists('UseCount') then
                        FLoadedUseCount := ReadInteger('UseCount');
                      if ValueExists('RecentIndex') then
                        FLoadedRecentIndex := ReadInteger('RecentIndex');
                    end;
                  end;
                except
                end;
              finally
                CloseKey;
              end;
      finally
        AItemLinks.Loaded(True);
      end;
    end;
  end;

begin
  if ARegistryPath = '' then Exit;
  if ARegistryPath[1] <> '\' then ARegistryPath := '\' + ARegistryPath;
  if ARegistryPath[Length(ARegistryPath)] = '\' then
    Delete(ARegistryPath, Length(ARegistryPath), 1);
  Stream := TMemoryStream.Create;
  Registry := TRegistry.Create;
  try
    with Registry do
      if OpenKey(ARegistryPath, False) then
      begin
        PrevBarManagerLockUpdate := LockUpdate;
        LockUpdate := True;
        try
          // read options
          if Style <> bmsStandard then
          begin
            if ValueExists('MenusShowRecentItemsFirst') then
              MenusShowRecentItemsFirst := ReadBool('MenusShowRecentItemsFirst');
            if ValueExists('ShowFullMenusAfterDelay') then
              ShowFullMenusAfterDelay := ReadBool('ShowFullMenusAfterDelay');
          end;
          if ValueExists('LargeIcons') then LargeIcons := ReadBool('LargeIcons');
          if ValueExists('MenuAnimations') then
            MenuAnimations := TdxBarMenuAnimations(ReadInteger('MenuAnimations'));
          if ValueExists('ShowHint') then ShowHint := ReadBool('ShowHint');
          if ValueExists('ShowShortCutInHint') then
            ShowShortCutInHint := ReadBool('ShowShortCutInHint');

          // read (TdxBar)s
          if ValueExists('BarCount') then
          begin
            for I := 0 to Bars.Count - 1 do Bars[I].Visible := False;
            I := ReadInteger('BarCount');
            CloseKey;
            for I := 0 to I - 1 do
            begin
              AKey := ARegistryPath + '\Bar' + IntToStr(I);
              if OpenKey(AKey, False) then
              begin
                if I > Bars.Count - 1 then Bars.Add;
                with Bars[I] do
                begin
                  PrevLockUpdate := LockUpdate;
                  LockUpdate := True;
                  try
                    ReadItemLinks(AKey, ItemLinks);

                    OpenKey(AKey, False);
                    try
                      try
                        Caption := ReadString('Caption');

                        DockedDockControl := FindDockControl(ReadString('DockedDockControl'));
                        DockedDockingStyle := TdxBarDockingStyle(ReadInteger('DockedDockingStyle'));
                        DockedLeft := ReadInteger('DockedLeft');
                        DockedTop := ReadInteger('DockedTop');
                        OneOnRow := ReadBool('OneOnRow');
                        Row := ReadInteger('Row');

                        FloatLeft := ReadInteger('FloatLeft');
                        FloatTop := ReadInteger('FloatTop');
                        FloatClientWidth := ReadInteger('FloatClientWidth');
                        FloatClientHeight := ReadInteger('FloatClientHeight');

                        DockControl := FindDockControl(ReadString('DockControl'));
                        DockingStyle := TdxBarDockingStyle(ReadInteger('DockingStyle'));
                        PrevLoading := FBars.FLoading;
                        FBars.FLoading := True;
                        try
                          Visible := ReadBool('Visible');
                        finally
                          FBars.FLoading := PrevLoading;
                        end;
                      except
                        Visible := True;
                      end;
                    finally
                      CloseKey;
                    end;
                  finally
                    LockUpdate := PrevLockUpdate;
                  end;
                end;
              end;
            end;
          end;

          // read (TCustomdxBarSubItem)s
          for I := 0 to ItemCount - 1 do
            if Items[I] is TCustomdxBarSubItem then
              with TCustomdxBarSubItem(Items[I]) do
                if Name <> '' then
                begin
                  AKey := ARegistryPath + '\SubItem_' + Name;
                  if OpenKey(AKey, False) then ReadItemLinks(AKey, ItemLinks);
                end;
        finally
          LockUpdate := PrevBarManagerLockUpdate;
        end;
      end;
  finally
    Registry.Free;
    Stream.Free;
  end;
end;

procedure TdxBarManager.SaveToRegistry(ARegistryPath: string);
var
  Registry, SubRegistry: TRegistry;
  Keys, SubKeys: TStringList;
  I, J: Integer;
  Stream: TMemoryStream;
  AKey: string;

  procedure WriteItemLinks(const AKey: string; AItemLinks: TdxBarItemLinks);
  var
    I: Integer;
  begin
    with Registry do
    begin
      WriteInteger('ItemLinkCount', AItemLinks.Count);
      CloseKey;
      for I := 0 to AItemLinks.Count - 1 do
        if (AItemLinks[I].Item.Name <> '') and
          OpenKey(AKey + '\ItemLink' + IntToStr(I), True) then
          with AItemLinks[I] do
          begin
            WriteString('ItemName', Item.Name);
            WriteBool('BeginGroup', BeginGroup);
            WriteBinaryData('UserDefine', FUserDefine, SizeOf(UserDefine));
            if udCaption in UserDefine then
              WriteString('UserCaption', UserCaption);
            if udGlyph in UserDefine then
            begin
              UserGlyph.SaveToStream(Stream);
              WriteBinaryData('UserGlyph', Stream.Memory^, Stream.Size);
              Stream.Clear;
            end;
            if udPaintStyle in UserDefine then
              WriteInteger('UserPaintStyle', Ord(UserPaintStyle));
            if udWidth in UserDefine then
              WriteInteger('UserWidth', UserWidth);
            if AItemLinks.Owner is TdxBar then
              WriteBool('Visible', Visible);
            if (BarManager.Style <> bmsStandard) and AItemLinks.FUseRecentItems then
            begin
              WriteInteger('UseCount', FUseCount);
              WriteInteger('RecentIndex', RecentIndex);
            end;
            CloseKey;
          end;
    end;
  end;

begin
  if ARegistryPath = '' then Exit;
  if ARegistryPath[1] <> '\' then ARegistryPath := '\' + ARegistryPath;
  if ARegistryPath[Length(ARegistryPath)] = '\' then
    Delete(ARegistryPath, Length(ARegistryPath), 1);
  Stream := TMemoryStream.Create;
  Registry := TRegistry.Create;
  with Registry do
    if OpenKey(ARegistryPath, True) then
    begin
      // delete entire previous data from registry
      Keys := TStringList.Create;
      SubKeys := TStringList.Create;
      SubRegistry := TRegistry.Create;
      try
        GetKeyNames(Keys);
        for I := 0 to Keys.Count - 1 do
        begin
          with SubRegistry do
          begin
            OpenKey(ARegistryPath + '\' + Keys[I], False);
            SubRegistry.GetKeyNames(SubKeys);
            for J := 0 to SubKeys.Count - 1 do DeleteKey(SubKeys[J]);
            CloseKey;
          end;
          DeleteKey(Keys[I]);
        end;
      finally
        SubRegistry.Free;
        SubKeys.Free;
        Keys.Free;
      end;

      // write options
      if Style <> bmsStandard then
      begin
        WriteBool('MenusShowRecentItemsFirst', MenusShowRecentItemsFirst);
        WriteBool('ShowFullMenusAfterDelay', ShowFullMenusAfterDelay);
      end;
      WriteBool('LargeIcons', LargeIcons);
      WriteInteger('MenuAnimations', Ord(MenuAnimations));
      WriteBool('ShowHint', ShowHint);
      WriteBool('ShowShortCutInHint', ShowShortCutInHint);

      // write (TdxBar)s
      WriteInteger('BarCount', Bars.Count);
      CloseKey;
      for I := 0 to Bars.Count - 1 do
      begin
        AKey := ARegistryPath + '\Bar' + IntToStr(I);
        if OpenKey(AKey, True) then
          with Bars[I] do
          begin
            WriteString('Caption', Caption);

            if DockedDockControl <> nil then
              WriteString('DockedDockControl', GetComponentPath(DockedDockControl));
            WriteInteger('DockedDockingStyle', Ord(DockedDockingStyle));
            WriteInteger('DockedLeft', DockedLeft);
            WriteInteger('DockedTop', DockedTop);
            WriteBool('OneOnRow', OneOnRow);
            WriteInteger('Row', Row);

            WriteInteger('FloatLeft', FloatLeft);
            WriteInteger('FloatTop', FloatTop);
            WriteInteger('FloatClientWidth', FloatClientWidth);
            WriteInteger('FloatClientHeight', FloatClientHeight);

            if DockControl <> nil then
              WriteString('DockControl', GetComponentPath(DockControl));
            WriteInteger('DockingStyle', Ord(DockingStyle));
            WriteBool('Visible', Visible);

            WriteItemLinks(AKey, ItemLinks);
          end;
      end;

      // write (TCustomdxBarSubItem)s
      for I := 0 to ItemCount - 1 do
        if Items[I] is TCustomdxBarSubItem then
          with TCustomdxBarSubItem(Items[I]) do
            if Name <> '' then
            begin
              AKey := ARegistryPath + '\SubItem_' + Name;
              if OpenKey(AKey, True) then WriteItemLinks(AKey, ItemLinks);
            end;
    end;
  Registry.Free;
  Stream.Free;
end;

procedure TdxBarManager.LoadFromIniFile(AFileName: string);
var
  IniFile: TCurIniFile;
  BaseName, Section: string;
  I: Integer;
  PrevBarManagerLockUpdate, PrevLockUpdate, PrevLoading: Boolean;

  procedure ReadItemLinks(const ASection: string; AItemLinks: TdxBarItemLinks);
  var
    I: Integer;
    Section: string;
  begin
    AItemLinks.Clear;
    with IniFile do
    begin
      I := ReadInteger(ASection, 'ItemLinkCount', 0);
      try
        for I := 0 to I - 1 do
        begin
          Section := ASection + '.ItemLink' + IntToStr(I);
          if ReadString(Section, 'ItemName', '') <> '' then
            with AItemLinks.Add do
              try
                Item := GetItemByName(ReadString(Section, 'ItemName', ''));
                if Item = nil then Free
                else
                begin
                  BeginGroup := ReadBool(Section, 'BeginGroup', False);
                  FUserDefine := TdxBarUserDefines(Byte(ReadInteger(Section, 'UserDefine', 0)));
                  if udCaption in UserDefine then
                    UserCaption := ReadString(Section, 'UserCaption', '');
                  if udPaintStyle in UserDefine then
                    UserPaintStyle := TdxBarPaintStyle(ReadInteger(Section, 'UserPaintStyle', 0));
                  if udWidth in UserDefine then
                    UserWidth := ReadInteger(Section, 'UserWidth', 100);
                  // don't load UserGlyph
                  if AItemLinks.Owner is TdxBar then
                    FLoadedVisible := ReadBool(Section, 'Visible', True);
                  if (BarManager.Style <> bmsStandard) and AItemLinks.FUseRecentItems then
                  begin
                    FLoadedUseCount := ReadInteger(Section, 'UseCount', 0);
                    FLoadedRecentIndex := ReadInteger(Section, 'RecentIndex', -1);
                  end;
                end;
              except
              end;
        end;
      finally
        AItemLinks.Loaded(True);
      end;
    end;
  end;

begin
  if AFileName = '' then Exit;
  BaseName := MainForm.Name + '.' + Name + '.';
  IniFile := TCurIniFile.Create(AFileName);
  try
    with IniFile do
    begin
      PrevBarManagerLockUpdate := LockUpdate;
      LockUpdate := True;
      try
        // read options
        Section := BaseName + 'Main';
        if Style <> bmsStandard then
        begin
          MenusShowRecentItemsFirst :=
            ReadBool(Section, 'MenusShowRecentItemsFirst', MenusShowRecentItemsFirst);
          ShowFullMenusAfterDelay :=
            ReadBool(Section, 'ShowFullMenusAfterDelay', ShowFullMenusAfterDelay);
        end;
        LargeIcons := ReadBool(Section, 'LargeIcons', LargeIcons);
        MenuAnimations := TdxBarMenuAnimations(ReadInteger(Section, 'MenuAnimations', Byte(MenuAnimations)));
        ShowHint := ReadBool(Section, 'ShowHint', ShowHint);
        ShowShortCutInHint := ReadBool(Section, 'ShowShortCutInHint', ShowShortCutInHint);

        // read (TdxBar)s
        if ReadInteger(Section, 'BarCount', -1) > -1 then
        begin
          for I := 0 to Bars.Count - 1 do Bars[I].Visible := False;
          I := ReadInteger(Section, 'BarCount', 0);
          for I := 0 to I - 1 do
          begin
            Section := BaseName + 'Bar' + IntToStr(I);
            if ReadInteger(Section, 'Row', -1000) > -1000 then
            begin
              if I > Bars.Count - 1 then Bars.Add;
              with Bars[I] do
              begin
                PrevLockUpdate := LockUpdate;
                LockUpdate := True;
                try
                  ReadItemLinks(Section, ItemLinks);

                  try
                    Caption := ReadString(Section, 'Caption', Caption);

                    DockedDockControl := FindDockControl(ReadString(Section, 'DockedDockControl', ''));
                    DockedDockingStyle :=
                      TdxBarDockingStyle(ReadInteger(Section, 'DockedDockingStyle',
                        Integer(DockedDockingStyle)));
                    DockedLeft := ReadInteger(Section, 'DockedLeft', DockedLeft);
                    DockedTop := ReadInteger(Section, 'DockedTop', DockedTop);
                    OneOnRow := ReadBool(Section, 'OneOnRow', OneOnRow);
                    Row := ReadInteger(Section, 'Row', Row);

                    FloatLeft := ReadInteger(Section, 'FloatLeft', FloatLeft);
                    FloatTop := ReadInteger(Section, 'FloatTop', FloatTop);
                    FloatClientWidth := ReadInteger(Section, 'FloatClientWidth', FloatClientWidth);
                    FloatClientHeight := ReadInteger(Section, 'FloatClientHeight', FloatClientHeight);

                    DockControl := FindDockControl(ReadString(Section, 'DockControl', ''));;
                    DockingStyle :=
                      TdxBarDockingStyle(ReadInteger(Section, 'DockingStyle', Integer(DockingStyle)));
                    PrevLoading := FBars.FLoading;
                    FBars.FLoading := True;
                    try
                      Visible := ReadBool(Section, 'Visible', False);
                    finally
                      FBars.FLoading := PrevLoading;
                    end;
                  except
                    Visible := True;
                  end;
                finally
                  LockUpdate := PrevLockUpdate;
                end;  
              end;
            end;
          end;
        end;

        // read (TCustomdxBarSubItem)s
        for I := 0 to ItemCount - 1 do
          if Items[I] is TCustomdxBarSubItem then
            with TCustomdxBarSubItem(Items[I]) do
              if Name <> '' then
              begin
                Section := BaseName + 'SubItem_' + Name;
                if ReadInteger(Section, 'ItemLinkCount', -1) > -1 then
                  ReadItemLinks(Section, ItemLinks);
              end;
      finally
        LockUpdate := PrevBarManagerLockUpdate;
      end;
    end;
  finally
    IniFile.Free;
  end;
end;

procedure TdxBarManager.SaveToIniFile(AFileName: string);
var
  IniFile: TCurIniFile;
  Sections: TStringList;
  BaseName, Section: string;
  I: Integer;

  procedure WriteItemLinks(const ASection: string; AItemLinks: TdxBarItemLinks);
  var
    I: Integer;
    Section: string;
  begin
    with IniFile do
    begin
      WriteInteger(ASection, 'ItemLinkCount', AItemLinks.Count);
      for I := 0 to AItemLinks.Count - 1 do
        if AItemLinks[I].Item.Name <> '' then
          with AItemLinks[I] do
          begin
            Section := ASection + '.ItemLink' + IntToStr(I);
            WriteString(Section, 'ItemName', Item.Name);
            WriteBool(Section, 'BeginGroup', BeginGroup);
            WriteInteger(Section, 'UserDefine', Byte(FUserDefine));
            if udCaption in UserDefine then
              WriteString(Section, 'UserCaption', UserCaption);
            if udPaintStyle in UserDefine then
              WriteInteger(Section, 'UserPaintStyle', Ord(UserPaintStyle));
            if udWidth in UserDefine then
              WriteInteger(Section, 'UserWidth', UserWidth);
            // don't save UserGlyph
            if AItemLinks.Owner is TdxBar then
              WriteBool(Section, 'Visible', Visible);
            if (BarManager.Style <> bmsStandard) and AItemLinks.FUseRecentItems then
            begin
              WriteInteger(Section, 'UseCount', FUseCount);
              WriteInteger(Section, 'RecentIndex', RecentIndex);
            end;
          end;
    end;
  end;

begin
  if AFileName = '' then Exit;
  BaseName := MainForm.Name + '.' + Name + '.';
  IniFile := TCurIniFile.Create(AFileName);
  try
    with IniFile do
    begin
      // delete entire previous data from inifile
      Sections := TStringList.Create;
      ReadSections(Sections);
      for I := 0 to Sections.Count - 1 do
        if Copy(Sections[I], 1, Length(BaseName)) = BaseName then
          EraseSection(Sections[I]);
      Sections.Free;

      // write options
      Section := BaseName + 'Main';
      if Style <> bmsStandard then
      begin
        WriteBool(Section, 'MenusShowRecentItemsFirst', MenusShowRecentItemsFirst);
        WriteBool(Section, 'ShowFullMenusAfterDelay', ShowFullMenusAfterDelay);
      end;
      WriteBool(Section, 'LargeIcons', LargeIcons);
      WriteInteger(Section, 'MenuAnimations', Ord(MenuAnimations));
      WriteBool(Section, 'ShowHint', ShowHint);
      WriteBool(Section, 'ShowShortCutInHint', ShowShortCutInHint);

      // write (TdxBar)s
      WriteInteger(Section, 'BarCount', Bars.Count);
      for I := 0 to Bars.Count - 1 do
      begin
        Section := BaseName + 'Bar' + IntToStr(I);
        with Bars[I] do
        begin
          WriteString(Section, 'Caption', Caption);

          if DockedDockControl <> nil then
            WriteString(Section, 'DockedDockControl', GetComponentPath(DockedDockControl));
          WriteInteger(Section, 'DockedDockingStyle', Ord(DockedDockingStyle));
          WriteInteger(Section, 'DockedLeft', DockedLeft);
          WriteInteger(Section, 'DockedTop', DockedTop);
          WriteBool(Section, 'OneOnRow', OneOnRow);
          WriteInteger(Section, 'Row', Row);

          WriteInteger(Section, 'FloatLeft', FloatLeft);
          WriteInteger(Section, 'FloatTop', FloatTop);
          WriteInteger(Section, 'FloatClientWidth', FloatClientWidth);
          WriteInteger(Section, 'FloatClientHeight', FloatClientHeight);

          if DockControl <> nil then
            WriteString(Section, 'DockControl', GetComponentPath(DockControl));
          WriteInteger(Section, 'DockingStyle', Ord(DockingStyle));
          WriteBool(Section, 'Visible', Visible);

          WriteItemLinks(Section, ItemLinks);
        end;
      end;

      // write (TCustomdxBarSubItem)s
      for I := 0 to ItemCount - 1 do
        if Items[I] is TCustomdxBarSubItem then
          with TCustomdxBarSubItem(Items[I]) do
            if Name <> '' then
            begin
              Section := BaseName + 'SubItem_' + Name;
              WriteItemLinks(Section, ItemLinks);
            end;
    end;
  finally
  {$IFDEF DELPHI4}
    IniFile.UpdateFile;
  {$ENDIF}
    IniFile.Free;
  end;
end;

function TdxBarManager.CreateGroup: TdxBarGroup;
begin
  Result := TdxBarGroup.Create(FMainForm);
  AddGroup(Result);
end;

{ TdxBarManagerList }

constructor TdxBarManagerList.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TdxBarManagerList.Destroy;
begin
  while Count <> 0 do BarManagers[0].Free;
  FList.Free;
  inherited Destroy;
end;

function TdxBarManagerList.GetBarManager(Index: Integer): TdxBarManager;
begin
  Result := nil;
  if (Index > -1) and (Index < Count) then
    Result := TdxBarManager(FList[Index]);
end;

function TdxBarManagerList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TdxBarManagerList.GetCustomizingBarManager: TdxBarManager;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if BarManagers[I].IsCustomizing then
    begin
      Result := BarManagers[I];
      Break;
    end;
end;

{ TdxBar }

constructor TdxBar.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FAllowClose := True;
  FAllowCustomizing := True;
  FAllowQuickCustomizing := True;
  FAllowReset := True;
  FBorderStyle := bbsSingle;
  FBars := TdxBars(Collection);
  FDockedDockingStyle := dsTop;
  FFont := TFont.Create;
  FFont.Assign(BarManager.Font);
  FFont.OnChange := FontChanged;
  FFreeNotificationItems := TList.Create;
  FItemLinks := TdxBarItemLinks.Create(BarManager);
  FItemLinks.FOwner := Self;
  FItemLinks.OnChange := ItemLinksChanged;
  FRotateWhenVertical := True;
  FShowMark := True;
  FSizeGrip := True;
  FUseRecentItems := True;
  if not BarManager.IsLoading then
  begin
    if Assigned(BarManager.FOnBarAdd) then
      BarManager.FOnBarAdd(BarManager, Self);
    BarManager.DesignerModified;
  end;
end;

destructor TdxBar.Destroy;
begin
  if not BarManager.IsDestroying then
  begin
    BarManager.DesignerModified;
    if Assigned(BarManager.FOnBarDelete) then
      BarManager.FOnBarDelete(BarManager, Self);
  end;
  Visible := False;
  MakeFreeNotification;
  FFreeNotificationItems.Free;
  with BarManager do
    if MainMenuBar = Self then FMainMenuBar := nil;
  FItemLinks.Destroy;
  FFont.Free;
  if FEditFontHandle <> 0 then DeleteObject(FEditFontHandle);
  inherited Destroy;
end;

function TdxBar.GetBarManager: TdxBarManager;
begin
  Result := TdxBars(Collection).BarManager;
end;

function TdxBar.GetControl: TdxBarControl;
begin
  Result := TdxBarControl(ItemLinks.FBarControl);
end;

function TdxBar.GetDockedDockingStyle: TdxBarDockingStyle;
begin
  if FDockedDockControl = nil then
    Result := FDockedDockingStyle
  else
    Result := FDockedDockControl.DockingStyle;
end;

function TdxBar.GetDockingStyle: TdxBarDockingStyle;
begin
  if FDockControl = nil then
    Result := FDockingStyle
  else
    Result := FDockControl.DockingStyle;
end;

function TdxBar.GetRealDockControl: TdxDockControl;
begin
  if FDockControl = nil then
    Result := FBars.FDockControls[FDockingStyle]
  else
    Result := FDockControl;
end;

procedure TdxBar.SetAllowClose(Value: Boolean);
begin
  if FAllowClose <> Value then
  begin
    FAllowClose := Value;
    if (DockingStyle = dsNone) and (Control <> nil) then
      Control.RepaintBar;
    UpdateCustomizingBars(Self);
  end;
end;

procedure TdxBar.SetAllowQuickCustomizing(Value: Boolean);
begin
  if FAllowQuickCustomizing <> Value then
  begin
    FAllowQuickCustomizing := Value;
    if (BarManager.Style <> bmsStandard) and (Control <> nil) then
      Control.RepaintBar;
  end;
end;

procedure TdxBar.SetBorderStyle(Value: TdxBarBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    if Control <> nil then Control.RebuildBar;
  end;
end;

procedure TdxBar.SetCaption(Value: string);
begin
  if FCaption <> Value then
  begin
    if BarManager.BarByCaption(Value) <> nil then Exit;
    FCaption := Value;
    if Control <> nil then Control.CaptionChanged;
    if (FName = '') and not BarManager.IsLoading then
      if BarManager.BarByName(Value) = nil then
        FName := Value
      else
        FName := Bars.GetUniqueToolbarName(Value);
    UpdateCustomizingBars(Self);
    BarManager.DesignerModified;
  end;
end;

procedure TdxBar.SetDockControl(Value: TdxBarDockControl);
var
  PrevDockingStyle: TdxBarDockingStyle;
  NeedHiding: Boolean;
begin
  if (Value <> nil) and (Value.BarManager <> BarManager) then Exit;
  if FDockControl <> Value then
  begin
    if BarManager.IsLoading then
    begin
      FLoadedDockControl := Value;
      Exit;
    end;
    PrevDockingStyle := DockingStyle;
    NeedHiding := not FChangingDockingStyle and (Control <> nil);
    if NeedHiding then
      if Value = nil then
//        NeedHiding := (DockingStyle <> dsNone) and (Control.DockControl <> Value)
        NeedHiding :=
          (DockingStyle <> dsNone) and
          not ((Control.DockControl <> nil) and Control.DockControl.Main)
      else
        NeedHiding := Control.DockControl <> Value;
    if NeedHiding then Visible := False;
    FDockControl := Value;
    ItemLinks.RecentItemCount := -1;
    if not FChangingDockingStyle then
    begin
      FChangingDockingStyle := True;
      try
        if Value = nil then
          DockingStyle := PrevDockingStyle//dsNone
        else
          DockingStyle := Value.DockingStyle;
      finally
        FChangingDockingStyle := False;
      end;
    end;
    if NeedHiding then Visible := True;
    if Control <> nil then
      Control.DockControl := RealDockControl;
    if not FChangingDockingStyle then
      BarManager.DoBarDockingStyleChanged(Self);
  end;
end;

procedure TdxBar.SetDockedDockControl(Value: TdxBarDockControl);
begin
  if (Value <> nil) and (Value.BarManager <> BarManager) then Exit;
  if FDockedDockControl <> Value then
  begin
    FDockedDockControl := Value;
    BarManager.DesignerModified;
  end;
end;

procedure TdxBar.SetDockedValue(Index: Integer; Value: Integer);
var
  PrevValue: Integer;
begin
  if Value < 0 then Value := 0;
  PrevValue := 0;
  case Index of
    1: PrevValue := FDockedLeft;
    2: PrevValue := FDockedTop;
  end;
  if PrevValue <> Value then
  begin
    case Index of
      1: FDockedLeft := Value;
      2: FDockedTop := Value;
    end;
    BarManager.DesignerModified;
  end;
end;

procedure TdxBar.SetDockingStyle(Value: TdxBarDockingStyle);
var
  ControlExists: Boolean;
begin
  if FDockingStyle <> Value then
  begin
    if BarManager.IsLoading then
    begin
      FLoadedDockingStyle := Value;
      Exit;
    end;
    ControlExists :=
      not FChangingDockingStyle and
      (Control <> nil) and (Control.DockingStyle <> Value);
    if ControlExists then Visible := False;
    FDockingStyle := Value;
    if not FChangingDockingStyle then
    begin
      FChangingDockingStyle := True;
      try
        DockControl := nil;
      finally
        FChangingDockingStyle := False;
      end;
    end;
    ItemLinks.RecentItemCount := -1;
    if ControlExists then
    begin
      Visible := True;
      Control.DockingStyle := Value;
    end;
    if not FChangingDockingStyle then
      BarManager.DoBarDockingStyleChanged(Self);
  end;
end;

procedure TdxBar.SetFloatValue(Index: Integer; Value: Integer);
var
  PrevValue: Integer;
begin
  PrevValue := 0;
  case Index of
    1: PrevValue := FFloatLeft;
    2: PrevValue := FFloatTop;
    3: PrevValue := FFloatClientWidth;
    4: PrevValue := FFloatClientHeight;
  end;
  if PrevValue <> Value then
  begin
    case Index of
      1: FFloatLeft := Value;
      2: FFloatTop := Value;
      3: FFloatClientWidth := Value;
      4: FFloatClientHeight := Value;
    end;
    BarManager.DesignerModified;
  end;
end;

procedure TdxBar.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TdxBar.SetHidden(Value: Boolean);
begin
  if FHidden <> Value then
  begin
    FHidden := Value;
    BarManager.DesignerModified;
  end;
end;

procedure TdxBar.SetIsMainMenu(Value: Boolean);
var
  PrevLockUpdate: Boolean;
begin
  if FIsMainMenu <> Value then
  begin
    PrevLockUpdate := BarManager.LockUpdate;
    BarManager.LockUpdate := True;
    try
      if Value and (BarManager.MainMenuBar <> nil) then
        BarManager.MainMenuBar.IsMainMenu := False;
      FIsMainMenu := Value;
      if Value then
      begin
        BarManager.FMainMenuBar := Self;
        WholeRow := True;
        MultiLine := True;
      end
      else
      begin
        BarManager.FMainMenuBar := nil;
        MultiLine := False;
        WholeRow := False;
      end;
      if BarManager.IsLoading then Exit;
      if (Control <> nil) and (FDockingStyle <> dsNone) then
        Control.RepaintBar;
      UpdateCustomizingBars(Self);
    finally
      BarManager.LockUpdate := PrevLockUpdate;
    end;  
  end;
end;

procedure TdxBar.SetItemLinks(Value: TdxBarItemLinks);
begin
  FItemLinks.Assign(Value);
end;

procedure TdxBar.SetLockUpdate(Value: Boolean);
begin
  if FLockUpdate <> Value then
  begin
    FLockUpdate := Value;
    if not FLockUpdate and (Control <> nil) then Control.RepaintBar;
  end;
end;

procedure TdxBar.SetMultiLine(Value: Boolean);
begin
  if (FMultiLine <> Value) and (Value or not IsMainMenu) then
  begin
    FMultiLine := Value;
    if (Control <> nil) and (DockingStyle <> dsNone) then
      Control.RepaintBar;
  end;
end;

procedure TdxBar.SetRotateWhenVertical(Value: Boolean);
begin
  if FRotateWhenVertical <> Value then
  begin
    FRotateWhenVertical := Value;
    if Control <> nil then Control.Perform(CM_FONTCHANGED, 0, 0);
  end;
end;

procedure TdxBar.SetRow(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FRow := Value;
end;

procedure TdxBar.SetShowMark(Value: Boolean);
begin
  if FShowMark <> Value then
  begin
    FShowMark := Value;
    if Control <> nil then Control.RepaintBar;
  end;
end;

procedure TdxBar.SetSizeGrip(Value: Boolean);
begin
  if FSizeGrip <> Value then
  begin
    FSizeGrip := Value;
    if IsStatusBar and (Control <> nil) then
      Control.RebuildBar;
  end;
end;

procedure TdxBar.SetUseOwnFont(Value: Boolean);
begin
  if FUseOwnFont <> Value then
  begin
    FUseOwnFont := Value;
    FInternalFontChange := True;
    try
      if FUseOwnFont then
        FontChanged(nil)
      else
      begin
        Font := BarManager.Font;
        DeleteObject(FEditFontHandle);
        FEditFontHandle := 0;
      end;
    finally
      FInternalFontChange := False;
    end;
  end;
end;

procedure TdxBar.SetUseRecentItems(Value: Boolean);
begin
  if FUseRecentItems <> Value then
  begin
    FUseRecentItems := Value;
    FItemLinks.FUseRecentItems := FUseRecentItems;
    if Control <> nil then Control.RepaintBar;
  end;
end;

procedure TdxBar.SetUseRestSpace(Value: Boolean);
begin
  if FUseRestSpace <> Value then
  begin
    FUseRestSpace := Value;
    if Control <> nil then Control.RepaintBar;
  end;
end;

procedure TdxBar.SetVisible(Value: Boolean);
var
  P: TPoint;
begin
  if Value and BarManager.IsDestroying then Exit;
  if FVisible <> Value then
  begin
    FInternallyHidden := False;
    if BarManager.IsLoading then
    begin
      FLoadedVisible := Value;
      Exit;
    end;
    if not Value and (Control <> nil) then Control.SavePos;
    FVisible := Value;
    if FVisible then
    begin
      FItemLinks.CreateBarControl;
      if DockingStyle <> dsNone then
      begin
        Control.BeginInternal;
        try
          Control.ChangeStyleWinTo(DockingStyle, RealDockControl);
          P := Point(DockedLeft, DockedTop);
          Windows.ClientToScreen(RealDockControl.Handle, P);
          FBars.RegInDock(DockingStyle, RealDockControl, Control, P);
        finally
          Control.EndInternal;
        end;
        ShowWindow(Control.Handle, SW_SHOWNA);
      end
      else
      begin
        Control.BeginInternal;
        try
          Control.ChangeStyleWinTo(DockingStyle, nil);
        finally
          Control.EndInternal;
        end;
        P := Control.GetTrackSize(DockingStyle);
        Control.SetBounds(FloatLeft, FloatTop, P.X, P.Y);
        with BarManager do
          if IsWindowVisible(MainForm.Handle) and
            (not HideFloatingBarsWhenInactive or (MainForm.Handle = GetActiveWindow) or
             (TDummyForm(MainForm).FormStyle = fsMDIChild) and
             (Application.MainForm.Handle = GetActiveWindow) and
             (HWND(SendMessage(TDummyForm(Application.MainForm).ClientHandle,
              WM_MDIGETACTIVE, 0, 0)) = MainForm.Handle) or FIsCustomizing) then
            ShowWindow(Control.Handle, SW_SHOWNA);
      end;
    end
    else  // Visible = False
      if Control <> nil then Control.Free;

    if BarManager.FIsCustomizing and not BarManager.FChangingStyle then
      UpdateCustomizingBars(Self);

    if not BarManager.IsDestroying and
      Assigned(BarManager.FOnBarVisibleChange) then
      BarManager.FOnBarVisibleChange(BarManager, Self);
    if not Bars.FLoading then BarManager.DesignerModified;
  end;
end;

procedure TdxBar.SetWholeRow(Value: Boolean);
begin
  if FWholeRow <> Value then
  begin
    FWholeRow := Value;
    if (Control <> nil) and (DockingStyle <> dsNone) then
    begin
      Visible := False;
      Visible := True;
    end;
  end;
end;

procedure TdxBar.FontChanged(Sender: TObject);
begin
  if not FInternalFontChange then
    FUseOwnFont := True;
  if FUseOwnFont then
    CreateEditFontHandle(FFont, FEditFontHandle, False);
  if Control <> nil then
  begin
    Control.Font := FFont;
    Control.Perform(CM_FONTCHANGED, 0, 0);
  end;
end;

procedure TdxBar.ItemLinksChanged(Sender: TObject);
begin
  BarManager.DesignerModified;
end;

procedure TdxBar.ResetToolbarClick(Sender: TObject);
begin
  ResetWithConfirmation;
end;

function TdxBar.IsDockedDockingStyleStored: Boolean;
begin
  Result := FDockedDockControl = nil;
end;

function TdxBar.IsDockingStyleStored: Boolean;
begin
  Result := FDockControl = nil;
end;

procedure TdxBar.AddFreeNotification(AItem: TdxBarItem);
begin
  FFreeNotificationItems.Add(AItem);
end;

procedure TdxBar.RemoveFreeNotification(AItem: TdxBarItem);
begin
  FFreeNotificationItems.Remove(AItem);
end;

procedure TdxBar.MakeFreeNotification;
var
  I: Integer;
begin
  for I := FFreeNotificationItems.Count - 1 downto 0 do
    TdxBarItem(FFreeNotificationItems[I]).ObjectNotification(opRemove, Self);
end;

function TdxBar.BarNCSizeX(AStyle: TdxBarDockingStyle): Integer;
begin
  if AStyle = dsNone then
  begin
    Result := 2 * BarManager.BorderSizeX;
    if not BarManager.Flat then
      Inc(Result, 2 * dxBarHorSize);
  end
  else
    if FBorderStyle = bbsSingle then
    begin
      Result := 2 * 2;
      if AStyle in [dsTop, dsBottom] then
        Inc(Result, BarManager.FingersSize);
    end
    else
    begin
      Result := 0;
      if HasSizeGrip then
        Inc(Result, GetSystemMetrics(SM_CXHSCROLL));
    end;
end;

function TdxBar.BarNCSizeY(AStyle: TdxBarDockingStyle): Integer;
begin
  if AStyle = dsNone then
  begin
    Result := 2 * BarManager.BorderSizeY + SMCaptionY;
    if not BarManager.Flat then
      Inc(Result, dxBarTopSize + dxBarBottomSize);
  end
  else
    if FBorderStyle = bbsSingle then
    begin
      Result := 2 * 2;
      if AStyle in [dsLeft, dsRight] then
        Inc(Result, BarManager.FingersSize);
    end
    else
    begin
      Result := 0;
      if IsStatusBar then Inc(Result, 2);
    end;
end;

function TdxBar.CanClose: Boolean;
begin
  Result := FAllowClose and not FIsMainMenu and
    ((Control = nil) or Control.FHasCaption);
end;

function TdxBar.CanReset: Boolean;
begin
  Result := FIsPredefined and FAllowReset;
end;

function TdxBar.HasSizeGrip: Boolean;
var
  Parent: HWND;
  R, CR: TRect;

  function IsBottom(Control: HWND): Boolean;
  begin
    Parent := GetParent(Control);
    Result := Parent = 0;
    if not Result then
    begin
      GetWindowRect(Control, R);
      MapWindowPoints(0, Parent, R, 2);
      GetClientRect(Parent, CR);
      Result := (R.Bottom = CR.Bottom) and IsBottom(Parent);
    end;
  end;

begin
  Result :=
    IsStatusBar and FSizeGrip and
    not IsZoomed(BarManager.MainForm.Handle) and
    ((Control = nil) or IsBottom(Control.Handle));
end;

function TdxBar.IsShortCut(AShortCut: TShortCut): Boolean;
begin
  Result := FItemLinks.IsShortCut(AShortCut);
end;

function TdxBar.IsStatusBar: Boolean;
begin
  Result := (FBorderStyle = bbsNone) and (DockingStyle = dsBottom);
end;

procedure TdxBar.Assign(Source: TPersistent);
var
  Bar: TdxBar;
begin
  if Source is TdxBar then
  begin
    Bar := TdxBar(Source);

    AllowClose := Bar.AllowClose;
    AllowCustomizing := Bar.AllowCustomizing;
    AllowQuickCustomizing := Bar.AllowQuickCustomizing;
    AllowReset := Bar.AllowReset;
    Caption := Bar.Caption;
    DockedDockControl := Bar.DockedDockControl;
    DockedDockingStyle := Bar.DockedDockingStyle;
    DockedLeft := Bar.DockedLeft;
    DockedTop := Bar.DockedTop;
    FloatLeft := Bar.FloatLeft;
    FloatTop := Bar.FloatTop;
    FloatClientWidth := Bar.FloatClientWidth;
    FloatClientHeight := Bar.FloatClientHeight;
    Hidden := Bar.Hidden;
    IsMainMenu := Bar.IsMainMenu;
    ItemLinks := Bar.ItemLinks;
    NotDocking := Bar.NotDocking;
    OneOnRow := Bar.OneOnRow;
    RotateWhenVertical := Bar.RotateWhenVertical;
    Row := Bar.Row;
    WholeRow := Bar.WholeRow;
    ChangeDockingStyle(Bar.DockingStyle, Bar.DockControl);
    UseRecentItems := Bar.UseRecentItems;
    UseRestSpace := Bar.UseRestSpace;
    Font := Bar.Font;
    UseOwnFont := Bar.UseOwnFont;
    Visible := Bar.Visible;
  end
  else inherited Assign(Source);
end;

procedure TdxBar.ChangeDockingStyle(AStyle: TdxBarDockingStyle;
  ADockControl: TdxDockControl);
begin
  if (ADockControl <> nil) and ADockControl.Main then
    ADockControl := nil;
  if DockingStyle = AStyle then
    DockControl := TdxBarDockControl(ADockControl)
  else
    if DockControl = ADockControl then
      DockingStyle := AStyle
    else
      if ADockControl = nil then
        DockingStyle := AStyle
      else
        DockControl := TdxBarDockControl(ADockControl);
end;

procedure TdxBar.Reset;
var
  PrevLockUpdate, PrevVisible: Boolean;
  TempForm: TForm;
  TempBarManager: TdxBarManager;

  procedure CheckItemLinks(AItemLinks: TdxBarItemLinks);
  var
    I: Integer;
    Item: TCustomdxBarSubItem;
    TempItem: TdxBarItem;
  begin
    for I := 0 to AItemLinks.Count - 1 do
      if AItemLinks[I].Item is TCustomdxBarSubItem then
      begin
        Item := TCustomdxBarSubItem(AItemLinks[I].Item);
        TempItem := TempBarManager.GetItemByName(Item.Name);
        if TempItem is TCustomdxBarSubItem then
        begin
          Item.ItemLinks.Assign(TCustomdxBarSubItem(TempItem).ItemLinks);
          Item.ItemLinks.AssignUsageData(TCustomdxBarSubItem(TempItem).ItemLinks);
          CheckItemLinks(Item.ItemLinks);
        end;
      end;
  end;

begin
  TempForm := BarManager.LoadMainFormFromBin;
  if TempForm <> nil then
    try
      TempBarManager := TdxBarManager(TempForm.FindComponent(BarManager.Name));
      if (TempBarManager <> nil) and (Index < TempBarManager.Bars.Count) then
      begin
        BarManager.DoBarBeforeReset(Self);
        if BarManager.UseFullReset then
        begin
          PrevLockUpdate := BarManager.LockUpdate;
          BarManager.LockUpdate := True;
          PrevVisible := Visible;
          Visible := False;
          ResettingToolbar := True;
          try
            Assign(TempBarManager.Bars[Index]);
            ItemLinks.AssignUsageData(TempBarManager.Bars[Index].ItemLinks);
            CheckItemLinks(ItemLinks);
          finally
            ResettingToolbar := False;
            Visible := PrevVisible;
            BarManager.LockUpdate := PrevLockUpdate;
          end;
        end
        else
        begin
          PrevLockUpdate := LockUpdate;
          LockUpdate := True;
          ResettingToolbar := True;
          try
            ItemLinks.Assign(TempBarManager.Bars[Index].ItemLinks);
            ItemLinks.AssignUsageData(TempBarManager.Bars[Index].ItemLinks);
            CheckItemLinks(ItemLinks);
          finally
            ResettingToolbar := False;
            LockUpdate := PrevLockUpdate;
          end;
        end;
        BarManager.DoBarAfterReset(Self);
      end;
    finally
      TempForm.Free;
    end;
end;

procedure TdxBar.ResetWithConfirmation;
begin
  if Application.MessageBox(PChar(Format(LoadStr(DXBAR_WANTTORESETTOOLBAR), [Caption])),
    PChar(Application.Title), MB_OKCANCEL or MB_ICONEXCLAMATION) = ID_OK then
    Reset;
end;

{ TdxBars }

constructor TdxBars.Create(ABarManager: TdxBarManager);
var
  ADockingStyle: TdxBarDockingStyle;
begin
  inherited Create(TdxBar);
  FBarManager := ABarManager;
  FDockingZoneSize := MinToolbarSize;
  for ADockingStyle := dsLeft to dsBottom do
  begin
    FDockControls[ADockingStyle] :=
      TdxDockControl.CreateEx(nil, FBarManager, ADockingStyle);
    FDockControls[ADockingStyle].Parent := FBarManager.MainForm;
  end;
end;

destructor TdxBars.Destroy;
var
  I: TdxBarDockingStyle;
begin
  for I := dsLeft to dsBottom do
    if FDockControls[I] <> nil then FDockControls[I].Free;
  inherited;
end;

function TdxBars.GetDockControl(Index: TdxBarDockingStyle): TdxDockControl;
begin
  Result := FDockControls[Index];
end;

function TdxBars.GetItem(Index: Integer): TdxBar;
begin
  Result := TdxBar(inherited Items[Index]);
end;

procedure TdxBars.SetItem(Index: Integer; Value: TdxBar);
begin
  Items[Index].Assign(Value);
end;

function TdxBars.GetOwner: TPersistent;
begin
  Result := FBarManager;
end;

procedure TdxBars.RegInDock(AStyle: TdxBarDockingStyle; ADockControl: TdxDockControl; 
  ABarControl: TdxBarControl; APos: TPoint);
begin
  if ADockControl <> nil then
    ADockControl.AddBarControl(ABarControl, APos, True)
  else
    if (AStyle <> dsNone) and (FDockControls[AStyle] <> nil) then
      FDockControls[AStyle].AddBarControl(ABarControl, APos, True);
end;

procedure TdxBars.UnregFromDock(AStyle: TdxBarDockingStyle;
  ADockControl: TdxDockControl; ABarControl: TdxBarControl);
begin
  if ADockControl <> nil then
    ADockControl.DeleteBarControl(ABarControl, nil, True)
  else
    if (AStyle <> dsNone) and (FDockControls[AStyle] <> nil) then
      FDockControls[AStyle].DeleteBarControl(ABarControl, nil, True);
end;

procedure DockTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT; Time: DWORD); stdcall;
var
  P: TPoint;
begin
  KillTimer(0, FDockTimerID);
  FDockTimerID := 0;
  if FDockBarManager <> nil then
    with FDockBarManager.Bars do
    begin
      GetCursorPos(P);
      Inc(P.X, FMovingOffset.X);
      Inc(P.Y, FMovingOffset.Y);
      FDocking := True;
      ChangeBarControlPos(FMovingBarControl, P);
      FDocking := False;
      FDockBarManager := nil;
    end;
end;

procedure TdxBars.ChangeBarControlPos(ABarControl: TdxBarControl; APos: TPoint);
var
  AStyle: TdxBarDockingStyle;
  ADockControl: TdxDockControl;
  ASize: TPoint;
begin
  AStyle := GetDockingStyleAtPos(ABarControl.Bar, APos, ADockControl);
  if not FBarManager.DoDocking(ABarControl.Bar, AStyle, ADockControl) then Exit;

  if not FDocking and (ABarControl.DockingStyle = dsNone) and (AStyle <> dsNone) then
  begin
    if FDockTimerID > 0 then KillTimer(0, FDockTimerID);
    FDockBarManager := BarManager;
    FDockTimerID := SetTimer(0, 0, BarManager.WaitForDockingTime, @DockTimerProc);
    ADockControl := nil;
    AStyle := dsNone;
  end;

  if AStyle = dsNone then
  begin
    Dec(APos.X, FMovingOffset.X);
    Dec(APos.Y, FMovingOffset.Y);
  end;
  if (ABarControl.DockingStyle <> AStyle) or
    (ABarControl.DockControl <> ADockControl) then
  begin
    SetWindowPos(ABarControl.Handle, 0, 0, 0, 0, 0,
      SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_HIDEWINDOW or SWP_NOACTIVATE);
    if ABarControl.DockingStyle <> dsNone then
    begin
      UnregFromDock(ABarControl.DockingStyle, ABarControl.DockControl, ABarControl);
      ABarControl.ItemLinks.RecentItemCount := -1;
    end;
    if AStyle <> dsNone then
    begin
      with ABarControl do
      begin
        BeginInternal; //!!!
        try
          ChangeStyleWinTo(AStyle, ADockControl);
        finally
          EndInternal;
        end;
      end;
      RegInDock(AStyle, ADockControl, ABarControl, APos);
    end
    else
      with ABarControl do
      begin
        BeginInternal;  // for WMSize
        try
          ChangeStyleWinTo(AStyle, nil);
        finally
          EndInternal;
        end;
        ASize := GetTrackSize(AStyle);
        with GetDragPointOffset(AStyle) do
          SetWindowPos(Handle, 0, APos.X - X, APos.Y - Y, ASize.X, ASize.Y,
            SWP_NOZORDER or SWP_NOACTIVATE);
      end;
    Windows.ShowWindow(ABarControl.Handle, SW_SHOWNA);
  end
  else
    if ABarControl.DockingStyle <> dsNone then
      ADockControl.MoveBarControl(ABarControl, APos)
    else
      with ABarControl, GetDragPointOffset(AStyle) do
        SetWindowPos(Handle, 0, APos.X - X, APos.Y - Y, 0, 0,
          SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
end;

function TdxBars.GetDockingStyleAtPos(Bar: TdxBar; Pos: TPoint;
  var DockControl: TdxDockControl): TdxBarDockingStyle;
var
  ADockControl: TdxDockControl;

  function CheckDockZone(ADockingStyle: TdxBarDockingStyle): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to FBarManager.DockControlCount - 1 do
    begin
      ADockControl := FBarManager.DockControls[I];
      with ADockControl do
        if (DockingStyle = ADockingStyle) and CanFocus then
        begin
          Result :=
            FBarManager.DoDocking(Bar, ADockingStyle, ADockControl) and
            PtInRect(GetDockZoneBounds, Pos);
          if Result then Break;
        end;
    end;    
    if Result then
    begin
      DockControl := ADockControl;
      GetDockingStyleAtPos := ADockingStyle;
    end;
  end;

begin
  DockControl := nil;
  Result := dsNone;

  if FMoving and (GetAsyncKeyState(VK_CONTROL) < 0) then Exit;
  
  if CheckDockZone(dsLeft) then Exit;
  if CheckDockZone(dsRight) then Exit;
  if CheckDockZone(dsTop) then Exit;
  if CheckDockZone(dsBottom) then Exit;

  if FMoving then
  begin
    Dec(Pos.X, FMovingOffset.X);
    Dec(Pos.Y, FMovingOffset.Y);
  end;
  if CheckDockZone(dsLeft) then Exit;
  if CheckDockZone(dsRight) then Exit;
  if CheckDockZone(dsTop) then Exit;
  if CheckDockZone(dsBottom) then Exit;
end;

procedure TdxBars.Moving(AMovingBarControl: TdxBarControl);
var
  CaptureWnd: HWND;
  Msg: TMsg;
  PrevP, CalcP, P: TPoint;
begin
  if AMovingBarControl.Bar.NotDocking = [Low(TdxBarDockingStyle)..High(TdxBarDockingStyle)] then Exit;

  with AMovingBarControl, Bar do
    if DockingStyle <> dsNone then
      GetDockCol.FPos := Point(DockedLeft, DockedTop);

  FMoving := True;
  AMovingBarControl.Moving := True;

  GetCursorPos(PrevP);

  FMovingBarOriginalDockingStyle := FMovingBarControl.DockingStyle;
  FMovingOffset := Point(0, 0);
  FMovingStaticOffset := Point(0, 0);
  with FMovingBarControl, FBar do
    if DockingStyle <> dsNone then
    begin
      P := GetDockCol.Pos;
      Windows.ClientToScreen(RealDockControl.Handle, P);

      RealDockControl.DeleteBarControl(Control, nil, False);
      CalcP := PrevP;
      RealDockControl.GetPosForRow(Row, OneOnRow, CalcP);
      if Control.Vertical then
        FMovingOffset.X := CalcP.X - PrevP.X
      else
        FMovingOffset.Y := CalcP.Y - PrevP.Y;
      Control.BeginInternal;
      try
        RealDockControl.AddBarControl(Control, P, False);
      finally
        Control.EndInternal;
      end;

      FMovingStaticOffset := Point(Left, Top);
      Windows.ClientToScreen(RealDockControl.Handle, FMovingStaticOffset);
      with FMovingStaticOffset do
      begin
        X := PrevP.X - X;
        Y := PrevP.Y - Y;
      end;
    end;

  ProcessPaintMessages;

  CaptureWnd := BarManager.GetWindowForMouseCapturing;
  SetCapture(CaptureWnd);
  try
    while GetCapture = CaptureWnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      with Msg do
        if ((message = WM_KEYDOWN) or (message = WM_KEYUP)) and
          (wParam = VK_CONTROL) then
        begin
          message := WM_MOUSEMOVE;
          hwnd := 0;
          GetCursorPos(P);
          lParam := Windows.LPARAM(PointToSmallPoint(P));
          PrevP := Point(-1, -1);
        end;
      case Msg.message of
        WM_KEYDOWN, WM_KEYUP:
          if Msg.wParam = VK_ESCAPE then Break;
        WM_MOUSEMOVE:
          begin
            P := SmallPointToPoint(TSmallPoint(Msg.lParam));
            ClientToScreen(Msg.hwnd, P);
            if (P.X <> PrevP.X) or (P.Y <> PrevP.Y) then
            begin
              CalcP := P;
              Inc(CalcP.X, FMovingOffset.X);
              Inc(CalcP.Y, FMovingOffset.Y);
              ChangeBarControlPos(FMovingBarControl, CalcP);
              //ProcessPaintMessages;
              PrevP := P;
            end;
          end;
        WM_LBUTTONUP:
          Break;
      else
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if FDockTimerID > 0 then
    begin
      KillTimer(0, FDockTimerID);
      FDockTimerID := 0;
      FDockBarManager := nil;
    end;
    if GetCapture = CaptureWnd then ReleaseCapture;
    AMovingBarControl := FMovingBarControl;
    FMovingBarControl.Moving := False;
    if AMovingBarControl.DockingStyle <> dsNone then
      AMovingBarControl.DockControl.AssignPositions;
    FMoving := False;
  end;
end;

procedure TdxBars.Update(Item: TCollectionItem);
begin
//  BarManager.DesignerModified;  <-
end;

function TdxBars.Add: TdxBar;
begin
  Result := TdxBar(inherited Add);
end;

function TdxBars.GetUniqueToolbarName(const BaseName: string): string;
var
  I: Integer;
begin
  I := 0;
  repeat
    Inc(I);
    Result := BaseName + IntToStr(I);
  until BarManager.BarByName(Result) = nil;
end;

{ TdxBarItemLink }

constructor TdxBarItemLink.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FLoadedRecentIndex := -1;
  FUseCount := BarManager.FMostRecentlyUsedUseCount;
  FMostRecentlyUsed := True;
  FUserGlyph := TBitmap.Create;
  FVisible := True;
  FLoadedVisible := True;
  AddToRecentList;
  if not BarManager.IsLoading and Assigned(BarManager.FOnItemLinkAdd) then
    BarManager.FOnItemLinkAdd(BarManager, Self);
end;

destructor TdxBarItemLink.Destroy;
var
  AItemLinks: TdxBarItemLinks;
  ABarControl: TCustomdxBarControl;
  ItemLinkWithBeginGroup: TdxBarItemLink;
begin
  if not BarManager.IsDestroying and
    Assigned(BarManager.FOnItemLinkDelete) then
    BarManager.FOnItemLinkDelete(BarManager, Self);
  AItemLinks := Owner;
  ABarControl := BarControl;
  
  if (Item <> nil) and (Self = BarManager.DraggingItemLink) and
    not BarManager.IsDestroying and
    (CanVisibleIndex < AItemLinks.CanVisibleItemCount - 1) and
    ((CanVisibleIndex = 0) and AItemLinks.CanVisibleItems[CanVisibleIndex + 1].BeginGroup or
     BeginGroup and not AItemLinks.CanVisibleItems[CanVisibleIndex + 1].BeginGroup) then
    ItemLinkWithBeginGroup := AItemLinks.CanVisibleItems[CanVisibleIndex + 1]
  else
    ItemLinkWithBeginGroup := nil;
  if FControl <> nil then
  begin
    if (ABarControl <> nil) and not ABarControl.IsDestroying and
      (ABarControl.SelectedItem = FControl) then
    begin
      BarManager.FSelectedItem := nil;
      ABarControl.SelectedItem := nil;
    end;
    FControl.Free;
  end;
  if FItem <> nil then FItem.FLinks.Remove(Self);
  FUserGlyph.Free;

  RemoveFromRecentList;
  inherited Destroy;

  if ItemLinkWithBeginGroup <> nil then
    with ItemLinkWithBeginGroup do
      BeginGroup := not FBeginGroup;
  if (ABarControl <> nil) and ABarControl.HandleAllocated and
    not ABarControl.IsDestroying then
  begin
    ABarControl.RepaintBar;
    if Assigned(AItemLinks.FOnChange) then AItemLinks.FOnChange(AItemLinks);
  end;
end;

function TdxBarItemLink.GetAvailableIndex: Integer;
begin
  if Owner = nil then
    Result := -1
  else
    Result := Owner.AvailableIndexOf(Self);
end;

function TdxBarItemLink.GetBarControl: TCustomdxBarControl;
begin
  Result := Owner.FBarControl;
end;

function TdxBarItemLink.GetBarManager: TdxBarManager;
begin
  Result := Owner.BarManager;
end;

function TdxBarItemLink.GetBeginGroup: Boolean;
var
  AVisibleIndex: Integer;

  function HiddenBeginGroupExists: Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := Owner.VisibleItems[AVisibleIndex - 1].AvailableIndex + 1 to
      AvailableIndex - 1 do
      if Owner.AvailableItems[I].BeginGroup then Exit;
    Result := False;  
  end;

begin
  AVisibleIndex := VisibleIndex;
  Result := FBeginGroup and (AVisibleIndex <> 0) or
    (AVisibleIndex > 0) and HiddenBeginGroupExists;
end;

function TdxBarItemLink.GetCanVisibleIndex: Integer;
begin
  if Owner = nil then
    Result := -1
  else
    Result := Owner.CanVisibleIndexOf(Self);
end;

function TdxBarItemLink.GetCaption: string;
begin
  if not (udCaption in FUserDefine) and (FItem <> nil) then
    Result := FItem.Caption
  else
    Result := FUserCaption;
end;

function TdxBarItemLink.GetGlyph: TBitmap;
begin
  if not (udGlyph in FUserDefine) and (FItem <> nil) then
    Result := FItem.Glyph
  else
    Result := FUserGlyph;
end;

function TdxBarItemLink.GetOwnerValue: TdxBarItemLinks;
begin
  Result := TdxBarItemLinks(Collection);
end;

function TdxBarItemLink.GetPaintStyle: TdxBarPaintStyle;
begin
  if not (udPaintStyle in FUserDefine) and (FItem <> nil) then
    if FItem is TdxBarButton then
      Result := TdxBarButton(FItem).PaintStyle
    else
      Result := psStandard
  else
    Result := FUserPaintStyle;
end;

function TdxBarItemLink.GetVisibleIndex: Integer;
begin
  if Owner = nil then
    Result := -1
  else
    Result := Owner.VisibleIndexOf(Self);
end;

function TdxBarItemLink.GetWidth: Integer;
begin
  if udWidth in FUserDefine then
    Result := FUserWidth
  else
    if Item is TdxBarEdit then
      Result := TdxBarEdit(Item).Width
    else
      Result := 0
end;

procedure TdxBarItemLink.SetBeginGroup(Value: Boolean);
begin
  if FBeginGroup <> Value then
  begin
    FBeginGroup := Value;
    if Control <> nil then Control.BeginGroupChanged;
    ItemLinkChanged;
  end;
end;

procedure TdxBarItemLink.SetItem(Value: TdxBarItem);
begin
  if FItem <> Value then
  begin
    if FItem <> nil then FItem.FLinks.Remove(Self);
    FItem := Value;
    if FItem <> nil then
      try
        if (Owner.Owner is TCustomdxBarSubItem) and
          not TCustomdxBarSubItem(Owner.Owner).CanContainItem(FItem) then
        begin
          FItem := nil;
          raise Exception.Create(LoadStr(DXBAR_RECURSIVESUBITEMS));
        end
        else
        begin
          FItem.FLinks.Add(Self);
          Owner.RefreshVisibilityLists;
        end;

        if (Owner.Owner is TComponent) and
          not (csLoading in TComponent(Owner.Owner).ComponentState) then
          CheckMostRecentlyUsed;
      finally
        ItemLinkChanged;
      end
    else
      Free;
  end;
end;

procedure TdxBarItemLink.SetMostRecentlyUsed(Value: Boolean);
begin
  if FMostRecentlyUsed <> Value then
  begin
    FMostRecentlyUsed := Value;
    CheckMostRecentlyUsed;
    if BarControl <> nil then BarControl.RepaintBar;
    ItemLinkChanged;
  end;
end;

procedure TdxBarItemLink.SetUserCaption(Value: string);
begin
  if FUserCaption <> Value then
  begin
    FUserCaption := Value;
    FUserDefine := FUserDefine + [udCaption];
    if Control <> nil then Control.CaptionChanged;
    ItemLinkChanged;
  end;
end;

procedure TdxBarItemLink.SetUserDefine(Value: TdxBarUserDefines);
begin
  if FUserDefine <> Value then
  begin
    FUserDefine := Value;
    if not (udCaption in FUserDefine) then FUserCaption := '';
    if not (udGlyph in FUserDefine) then FUserGlyph.Assign(nil);
    if not (udPaintStyle in FUserDefine) then FUserPaintStyle := psStandard;
    if not (udWidth in FUserDefine) then FUserWidth := 0;
    if Control <> nil then
    begin
      Control.CaptionChanged;
      Control.GlyphChanged;
    end;
    ItemLinkChanged;
  end;
end;

procedure TdxBarItemLink.SetUserGlyph(Value: TBitmap);
begin
  FUserGlyph.Assign(Value);
  FUserDefine := FUserDefine + [udGlyph];
  if Control <> nil then Control.GlyphChanged;
  ItemLinkChanged;
end;

procedure TdxBarItemLink.SetUserPaintStyle(Value: TdxBarPaintStyle);
begin
  if PaintStyle <> Value then
  begin
    FUserPaintStyle := Value;
    FUserDefine := FUserDefine + [udPaintStyle];
    if Control is TdxBarButtonControl then
      TdxBarButtonControl(Control).PaintStyleChanged;
    ItemLinkChanged;
  end;
end;

procedure TdxBarItemLink.SetUserWidth(Value: Integer);
begin
  CheckEditWidth(Value);
  if Width <> Value then
  begin
    FUserWidth := Value;
    FUserDefine := FUserDefine + [udWidth];
    if Control is TdxBarEditControl then
      TdxBarEditControl(Control).WidthChanged;
    ItemLinkChanged;
  end;
end;

procedure TdxBarItemLink.SetVisible(Value: Boolean);
begin
  if BarManager.IsLoading or Owner.FAssigning then
  begin
    FLoadedVisible := Value;
    Exit;
  end;
  if FVisible <> Value then
  begin
    FVisible := Value;
    if not BarManager.Designing then
    begin
      Owner.RefreshVisibilityLists;
      if Value then
      begin
        BringToTopInRecentList(False);
        if BarControl <> nil then
        begin
          CreateControl;
          Control.VisibleChanged;
        end;  
      end
      else
      begin
        SendToBottomInRecentList;
        if Control <> nil then
        begin
          Control.VisibleChanged;
          DestroyControl;
        end;  
      end;
    end;
    ItemLinkChanged;
  end;
end;

procedure TdxBarItemLink.AddToRecentList;
begin
  Owner.FRecentItems.Add(Self);
end;

procedure TdxBarItemLink.RemoveFromRecentList;
begin
  with Owner do
    if FRecentItems <> nil then FRecentItems.Remove(Self);
end;

procedure TdxBarItemLink.RestoreRecentIndex;
begin
  RecentIndex := FPrevRecentIndex;
end;

procedure TdxBarItemLink.SaveRecentIndex;
begin
  FPrevRecentIndex := RecentIndex;
end;

procedure TdxBarItemLink.InternalBringToTopInRecentList(IncCount: Boolean);
begin
  RecentIndex := 0;
  if IncCount then Inc(FUseCount);
end;

procedure TdxBarItemLink.Synchronize(AItemLink: TdxBarItemLink);
begin
  FUseCount := AItemLink.FUseCount;
  RecentIndex := AItemLink.RecentIndex;
end;

procedure TdxBarItemLink.CheckMostRecentlyUsed;
begin
  if MostRecentlyUsed then
  begin
    FUseCount := BarManager.FMostRecentlyUsedUseCount;
    BringToTopInRecentList(False);
  end
  else
  begin
    FUseCount := 0;
    SendToBottomInRecentList;
  end
end;

function TdxBarItemLink.GetRecentIndex: Integer;
begin
  Result := Owner.FRecentItems.IndexOf(Self);
end;

procedure TdxBarItemLink.SetRecentIndex(Value: Integer);
begin
  if Owner = nil then
    FPrevRecentIndex := Value
  else
    with Owner, FRecentItems do
    begin
      if Value >= Count then Value := Count - 1;
      Move(IndexOf(Self), Value);
      RefreshVisibilityLists;
    end;
end;

function TdxBarItemLink.CanVisible: Boolean;
begin
  Result := Item.ActuallyVisible and Visible;
end;

function TdxBarItemLink.GetRealItemLink: TdxBarItemLink;
begin
  if FOriginalItemLink <> nil then
    Result := FOriginalItemLink
  else
    Result := Self
end;

function TdxBarItemLink.HasItem(AItem: TdxBarItem): Boolean;
begin
  Result := FItem = AItem;
  if not Result and (FItem is TCustomdxBarSubItem) then
    Result := TCustomdxBarSubItem(FItem).ItemLinks.HasItem(AItem);
end;

{$IFDEF DELPHI4}
procedure TdxBarItemLink.InitiateAction;
begin
  if (Item <> nil) and (Item.ActionLink <> nil) then Item.ActionLink.Update;
end;
{$ENDIF}

function TdxBarItemLink.IsAccel(Key: Word; Shift: TShiftState): Boolean;
var
  Accel: Char;
  VK: SHORT;
  AShift: TShiftState;

  function GetAccel(const S: string): Char;
  var
    P, I, L: Integer;
  begin
    P := 0;
    I := 1;
    L := Length(S);
    while I < L do
    begin
      if S[I] = '&' then
      begin
        Inc(I);
        if S[I] <> '&' then P := I;
      end;
      Inc(I);
    end;
    if P = 0 then Result := #0
    else
    begin
      Result := AnsiLowerCase(S[P])[1];
      if Result <> S[P] then Shift := Shift - [ssShift];
    end;
  end;

begin
  Accel := GetAccel(Caption);
  if Accel = #0 then
    Result := False
  else
    if (Accel in ['0'..'9']) and (Key = Ord(Accel)) and (Shift = []) then
      Result := True
    else
    begin
      VK := VkKeyScan(Accel);
      if Lo(VK) = Key then
      begin
        VK := Hi(VK);
        AShift := [];
        if VK and 1 = 1 then Include(AShift, ssShift);
        if VK and 2 = 2 then Include(AShift, ssCtrl);
        Result := AShift = Shift;
      end
      else
        Result := False;
    end;
end;

procedure TdxBarItemLink.ItemLinkChanged;
begin
  if (BarControl <> nil) and BarControl.IsCustomizing then
    with Owner do
      if Owner is TdxBarPopupMenu then
        TdxBarPopupMenu(Owner).OwnerDesignerModified
      else
        BarManager.DesignerModified;
  if not BarManager.IsLoading and Assigned(BarManager.FOnItemLinkChange) then
    BarManager.FOnItemLinkChange(BarManager, Self);
end;

procedure TdxBarItemLink.Assign(Source: TPersistent);
var
  Link: TdxBarItemLink;
begin
  if Source is TdxBarItemLink then
  begin
    Link := TdxBarItemLink(Source);
    Data := Link.Data; 
    FUserCaption := Link.FUserCaption;
    FUserGlyph.Assign(Link.FUserGlyph);
    FUserPaintStyle := Link.FUserPaintStyle;
    FUserWidth := Link.FUserWidth;
    if ResettingToolbar then
      Item := TdxBarItem(BarManager.MainForm.FindComponent(Link.Item.Name))
    else
      Item := Link.Item;
    UserDefine := Link.UserDefine;
    BeginGroup := Link.BeginGroup;
    Visible := Link.Visible;
    // do not assign MostRecentlyUsed property
  end
  else inherited Assign(Source);
end;

procedure TdxBarItemLink.BringToTopInRecentList(IncCount: Boolean);
var
  PrevVisibleIndex: Integer;
  AParentItem: TdxBarItem;
begin
  if not CanVisible then Exit;

  PrevVisibleIndex := VisibleIndex;
  InternalBringToTopInRecentList(IncCount);
  if CanVisibleIndex > -1 then
  begin
    if (BarControl is TdxBarControl) and (PrevVisibleIndex = -1) and
      (BarControl.DockingStyle <> dsNone) and
      (BarControl.BarManager.Style <> bmsStandard) then
      PostMessage(BarControl.Handle, WM_REPAINTBAR, 0, 0);

    AParentItem := nil;
    with Owner do
      if Owner is TCustomdxBarSubItem then
        AParentItem := TCustomdxBarSubItem(Owner)
      else
        if Owner is TdxBarPopupMenu then
          if (BarControl <> nil) and (TdxBarSubMenuControl(BarControl).FDropDownButton <> nil) then
            AParentItem := TdxBarSubMenuControl(BarControl).FDropDownButton.Item;
    if AParentItem <> nil then
      with AParentItem do
        if (CurItemLink <> nil) and (CurItemLink.RealItemLink <> nil) then
          CurItemLink.RealItemLink.BringToTopInRecentList(IncCount);
  end;
end;

procedure TdxBarItemLink.CreateControl;
var
  I: Integer;
begin
  if (BarControl <> nil) and (Item <> nil) then
    if (Item is TdxBarWindowItem) and IsVertical(BarControl) then
      FControl := TdxBarButtonControl.Create(Self)
    else
      with FRegItemList do
        for I := 0 to Count - 1 do
          with PRegItemRecord(Items[I])^ do
            if Item.ClassInfo = ItemClass.ClassInfo then
            begin
              FControl := ItemControlClass.Create(Self);
              Break;
            end;
end;

procedure TdxBarItemLink.DestroyControl;
begin
  if FControl <> nil then
  begin
    FControl.Free;
    FControl := nil;
  end;
end;

procedure TdxBarItemLink.SendToBottomInRecentList;
var
  PrevVisibleIndex: Integer;
begin
  PrevVisibleIndex := VisibleIndex;
  RecentIndex := Owner.FRecentItems.Count - 1;
  if (BarControl is TdxBarControl) and (PrevVisibleIndex > -1) and
    (BarControl.BarManager.Style <> bmsStandard) then
    PostMessage(BarControl.Handle, WM_REPAINTBAR, 0, 0);
end;

{ TdxBarItemLinks }

constructor TdxBarItemLinks.Create(ABarManager: TdxBarManager);
begin
  inherited Create(TdxBarItemLink);
  FBarManager := ABarManager;
  FAvailableItems := TList.Create;
  FCanVisibleItems := TList.Create;
  FVisibleItems := TList.Create;
  FRecentItems := TList.Create;
  FRecentItemCount := -1;
  FUseRecentItems := True;
end;

destructor TdxBarItemLinks.Destroy;
begin
  if (FBarControl <> nil) and not FBarControl.IsDestroying then
    FBarControl.Free;
  FRecentItems.Free;
  FRecentItems := nil;
  FVisibleItems.Free;
  FVisibleItems := nil;
  FCanVisibleItems.Free;
  FCanVisibleItems := nil;
  FAvailableItems.Free;
  FAvailableItems := nil;
  inherited;
end;

function TdxBarItemLinks.GetAvailableItem(Index: Integer): TdxBarItemLink;
begin
  Result := TdxBarItemLink(FAvailableItems[Index]);
end;

function TdxBarItemLinks.GetAvailableItemCount: Integer;
begin
  Result := FAvailableItems.Count;
end;

function TdxBarItemLinks.GetCanVisibleItem(Index: Integer): TdxBarItemLink;
begin
  Result := TdxBarItemLink(FCanVisibleItems[Index]);
end;

function TdxBarItemLinks.GetCanVisibleItemCount: Integer;
begin
  Result := FCanVisibleItems.Count;
end;

function TdxBarItemLinks.GetItem(Index: Integer): TdxBarItemLink;
begin
  Result := TdxBarItemLink(inherited Items[Index]);
end;

function TdxBarItemLinks.GetMostRecentItemCount: Integer;
var
  MinCount, MaxCount, I, Level: Integer;
begin
  if CanUseRecentItems then
  begin
    MinCount := MaxInt;
    MaxCount := 0;
    for I := 0 to CanVisibleItemCount - 1 do
      with CanVisibleItems[I] do
      begin
        if FUseCount < MinCount then MinCount := FUseCount;
        if FUseCount > MaxCount then MaxCount := FUseCount;
      end;
    Level := MinCount +
      MulDiv(MaxCount - MinCount, 100 - BarManager.MostRecentItemsPercents, 100);
    Result := 0;
    for I := CanVisibleItemCount - 1 downto 0 do
      with TdxBarItemLink(FRecentItems[I]) do
        if (FUseCount >= Level) and (Owner = Self) then
        begin
          Result := I + 1;
          Break;
        end;
    if Result = CanVisibleItemCount then Result := -1;
  end
  else
    Result := -1;
end;

function TdxBarItemLinks.GetRealVisibleItemCount: Integer;
var
  R, AItemRect, ResultR: TRect;
  I: Integer;
begin
  Result := VisibleItemCount;
  if Owner is TdxBar then
  begin
    R := BarControl.ClientRect;
    for I := 0 to Result - 1 do
    begin
      AItemRect := VisibleItems[I].ItemRect;
      IntersectRect(ResultR, R, AItemRect);
      if not EqualRect(AItemRect, ResultR) or IsRectEmpty(AItemRect) then
      begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TdxBarItemLinks.GetVisibleItem(Index: Integer): TdxBarItemLink;
begin
  Result := TdxBarItemLink(FVisibleItems[Index]);
end;

function TdxBarItemLinks.GetVisibleItemCount: Integer;
begin
  Result := FVisibleItems.Count;
end;

procedure TdxBarItemLinks.SetItem(Index: Integer; Value: TdxBarItemLink);
begin
  Items[Index].Assign(Value);
end;

procedure TdxBarItemLinks.SetRecentItemCount(Value: Integer);
begin
  FPrevRecentItemCount := FRecentItemCount;
  if not CanUseRecentItems then Value := -1;
  FRecentItemCount := Value;
  RefreshVisibilityLists;
end;

function VisibleItemsCompare(Item1, Item2: Pointer): Integer;
begin
  if TdxBarItemLink(Item1).CanVisibleIndex < TdxBarItemLink(Item2).CanVisibleIndex then
    Result := -1
  else
    if TdxBarItemLink(Item1).CanVisibleIndex > TdxBarItemLink(Item2).CanVisibleIndex then
      Result := 1
    else
      Result := 0;
end;

procedure TdxBarItemLinks.RefreshVisibilityLists;
var
  IsDesignTime: Boolean;
  I: Integer;
  ItemLink: TdxBarItemLink;
  Item: TdxBarItem;
begin
  if FAvailableItems = nil then Exit;
  FAvailableItems.Clear;
  FCanVisibleItems.Clear;
  FVisibleItems.Clear;
  IsDesignTime := BarManager.Designing;
  for I := 0 to Count - 1 do
  begin
    ItemLink := Items[I];
    Item := ItemLink.Item;
    if (Item <> nil) and
      ({Item.AlwaysVisible or }IsDesignTime or Item.ActuallyVisible) then
    begin
      FAvailableItems.Add(ItemLink);
      if {Item.AlwaysVisible or }IsDesignTime or ItemLink.Visible then
      begin
        FCanVisibleItems.Add(ItemLink);
        if {Item.AlwaysVisible or }IsDesignTime or (RecentItemCount = -1) then
          FVisibleItems.Add(ItemLink);
      end;
    end;
  end;
  if not IsDesignTime and (RecentItemCount > 0) then
  begin
    for I := 0 to FRecentItems.Count - 1 do
      if CanVisibleIndexOf(FRecentItems[I]) <> -1 then
      begin
        FVisibleItems.Add(FRecentItems[I]);
        if FVisibleItems.Count = RecentItemCount then Break;
      end;
    FVisibleItems.Sort(VisibleItemsCompare);
  end;
end;

procedure TdxBarItemLinks.RestoreRecentItemCount;
begin
  FRecentItemCount := FPrevRecentItemCount;
  RefreshVisibilityLists;
end;

procedure TdxBarItemLinks.EmptyItemRects;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    SetRectEmpty(Items[I].FItemRect);
end;

procedure TdxBarItemLinks.Loaded(CheckVisible: Boolean);
var
  J, I: Integer;
begin
  for J := Count - 1 downto 0 do
    with Items[J] do
      if Item = nil then
        //Free
      else
        CheckMostRecentlyUsed;
  if CheckVisible then
    for J := Count - 1 downto 0 do
      with Items[J] do
        Visible := FLoadedVisible;
  for I := 0 to Count - 1 do
    for J := 0 to Count - 1 do
      with Items[J] do
        if FLoadedRecentIndex = I then
        begin
          FUseCount := FLoadedUseCount;
          RecentIndex := FLoadedRecentIndex;
          FLoadedRecentIndex := -1;
        end;
end;

procedure TdxBarItemLinks.CheckVisibleIntegrity;
var
  I, J: Integer;
  ItemLink: TdxBarItemLink;
begin
  for I := 0 to FRecentItems.Count - 1 do
  begin
    ItemLink := TdxBarItemLink(FRecentItems[I]);
    if ItemLink.CanVisibleIndex = -1 then Break;
  end;
  for J := I + 1 to FRecentItems.Count - 1 do
  begin
    ItemLink := TdxBarItemLink(FRecentItems[J]);
    if ItemLink.CanVisibleIndex > -1 then
    begin
      ItemLink.RecentIndex := I;
      Inc(I);
    end;
  end;
end;

procedure TdxBarItemLinks.AssignUsageData(AItemLinks: TdxBarItemLinks);
var
  J: Integer;
begin
  for J := 0 to Count - 1 do
    if J < AItemLinks.Count then
      Items[J].FMostRecentlyUsed := AItemLinks[J].FMostRecentlyUsed;
  Loaded(False);
  CheckVisibleIntegrity;
end;

function TdxBarItemLinks.CanUseRecentItems: Boolean;
var
  AItemLinks: TdxBarItemLinks;
begin
  Result := BarManager.Style <> bmsStandard;
  if Result then
  begin
    AItemLinks := Self;
    repeat
      Result := AItemLinks.FUseRecentItems;
      if (AItemLinks.Owner is TdxBar) or
        (AItemLinks.Owner is TdxBarPopupMenu) or
        (AItemLinks.BarControl.ParentBar = nil) then
        Break;
      AItemLinks := AItemLinks.BarControl.ParentBar.ItemLinks;
    until False;
  end;
end;

{$IFDEF DELPHI4}
procedure TdxBarItemLinks.InitiateActions;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do Items[I].InitiateAction;
end;
{$ENDIF}

function TdxBarItemLinks.IsDesignTimeLinks: Boolean;
begin
  Result :=
    not (Owner is TdxBarToolbarsPopup) and not (Owner is TdxBarCustomizingPopup) and
    (not (Owner is TCustomdxBarSubItem) or TCustomdxBarSubItem(Owner).HasDesignTimeLinks);
end;

function TdxBarItemLinks.IsShortCut(AShortCut: TShortCut): Boolean;
var
  I: Integer;
  AItemLink: TdxBarItemLink;
begin
  Result := False;
  if AShortCut = 0 then Exit;
{$IFDEF DELPHI4}
  InitiateActions;
{$ENDIF}
  for I := 0 to AvailableItemCount - 1 do
  begin
    AItemLink := AvailableItems[I];
    if not AItemLink.Item.Enabled then Continue;
    if AItemLink.Item is TCustomdxBarSubItem then
      Result := TCustomdxBarSubItem(AItemLink.Item).IsShortCut(AShortCut)
    else
    begin
      if not AItemLink.Item.CanClicked then Continue;
      Result := (AItemLink.Item.ShortCut = AShortCut);
      if Result then
        AItemLink.Item.Click
      else
        if AItemLink.Item is TdxBarButton then
          with TdxBarButton(AItemLink.Item) do
            if (ButtonStyle = bsDropDown) and (DropDownMenu <> nil) then
              Result := DropDownMenu.IsShortCut(AShortCut);
    end;
    if Result then Break;
  end;
end;

function TdxBarItemLinks.FindItemWithAccel(Key: Word; Shift: TShiftState;
  Current: TdxBarItemLink): TdxBarItemLink;
begin
  Shift := Shift - [ssAlt];
  if BarControl is TdxBarControl then
  begin
    Result := Current;
    repeat
      Result := Next(Result);
      if Result = nil then Break;
      if Result.Item.HasAccel(Result) and Result.IsAccel(Key, Shift) then Exit;
      if Result = Current then Break;
      if Current = nil then Current := Result;
    until False;
    Result := nil;
  end
  else
  begin
    if CanVisibleItemCount = 0 then
    begin
      Result := nil;
      Exit;
    end;
    if Current = nil then Current := CanVisibleItems[0];
    Result := Current;
    repeat
      if Result = CanVisibleItems[CanVisibleItemCount - 1] then
        Result := CanVisibleItems[0]
      else
        Result := CanVisibleItems[Result.CanVisibleIndex + 1];
      if Result.Item.HasAccel(Result) and Result.IsAccel(Key, Shift) then Exit;
    until Result = Current;
    Result := nil;
  end;  
end;

function TdxBarItemLinks.First: TdxBarItemLink;
var
  I: Integer;
begin
  for I := 0 to RealVisibleItemCount - 1 do
  begin
    Result := VisibleItems[I];
    if Result.Control.CanSelect then Exit;
  end;
  Result := nil;
end;

function TdxBarItemLinks.Last: TdxBarItemLink;
var
  I: Integer;
begin
  for I := RealVisibleItemCount - 1 downto 0 do
  begin
    Result := VisibleItems[I];
    if Result.Control.CanSelect then Exit;
  end;
  Result := nil;
end;

function TdxBarItemLinks.Next(Current: TdxBarItemLink): TdxBarItemLink;
var
  CurrentIndex, I, ACount: Integer;
begin
  if Current = nil then Result := First
  else
  begin
    CurrentIndex := Current.VisibleIndex;
    I := CurrentIndex;
    ACount := RealVisibleItemCount;
    repeat
      Inc(I);
      if I > ACount - 1 then I := 0;
      Result := VisibleItems[I];
      if Result.Control.CanSelect then Exit;
    until I = CurrentIndex;
    Result := nil;
  end;
end;

function TdxBarItemLinks.Prev(Current: TdxBarItemLink): TdxBarItemLink;
var
  CurrentIndex, I: Integer;
begin
  if Current = nil then Result := Last
  else
  begin
    CurrentIndex := Current.VisibleIndex;
    I := CurrentIndex;
    repeat
      Dec(I);
      if I = -1 then I := RealVisibleItemCount - 1;
      Result := VisibleItems[I];
      if Result.Control.CanSelect then Exit;
    until I = CurrentIndex;
    Result := nil;
  end;
end;

procedure TdxBarItemLinks.Update(Item: TCollectionItem);
begin
  if IsDesignTimeLinks then
    if Owner is TdxBarPopupMenu then
      TdxBarPopupMenu(Owner).OwnerDesignerModified
    else
      BarManager.DesignerModified;
  inherited Update(Item);
  RefreshVisibilityLists;
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TdxBarItemLinks.Add: TdxBarItemLink;
begin
  Result := TdxBarItemLink(inherited Add);
end;

procedure TdxBarItemLinks.Assign(Source: TPersistent);
var
  ContainsMDISystemMenu: Boolean;
  SystemMenuSubItem: TSystemMenuSubItem;
  I: Integer;
begin
  ContainsMDISystemMenu :=
    (Count <> 0) and (Items[0].Item is TSystemMenuSubItem);
  if ContainsMDISystemMenu then
    SystemMenuSubItem := TSystemMenuSubItem(Items[0].Item)
  else
    SystemMenuSubItem := nil;
  FAssigning := True;
  try
    inherited;
  finally
    FAssigning := False;
    for I := 0 to Count - 1 do
      with Items[I] do
        Visible := FLoadedVisible;
    if ContainsMDISystemMenu then
      with Add do
      begin
        Item := SystemMenuSubItem;
        Index := 0;
      end;
  end;
end;

function TdxBarItemLinks.AvailableIndexOf(Value: TdxBarItemLink): Integer;
begin
  Result := FAvailableItems.IndexOf(Value);
end;

function TdxBarItemLinks.CanVisibleIndexOf(Value: TdxBarItemLink): Integer;
begin
  Result := FCanVisibleItems.IndexOf(Value);
end;

procedure TdxBarItemLinks.CreateBarControl;
begin
  if Owner is TdxBar then
    FBarControl := TdxBarControl.CreateEx(BarManager, TdxBar(Owner))
  else
    if (Owner is TCustomdxBarSubItem) and (TCustomdxBarSubItem(Owner).CurItemLink <> nil) then
      FBarControl := TdxBarSubMenuControl.Create(TCustomdxBarSubItem(Owner).CurItemLink.BarManager)
    else
      FBarControl := TdxBarSubMenuControl.Create(BarManager);
  FBarControl.FItemLinks := Self;
end;

procedure TdxBarItemLinks.FreeForeignItems(ForeignBarManager: TdxBarManager);
var
  PrevLockUpdate: Boolean;
  I: Integer;
begin
  if Owner is TdxBar then
  begin
    PrevLockUpdate := TdxBar(Owner).LockUpdate;
    TdxBar(Owner).LockUpdate := True;
  end
  else
    PrevLockUpdate := False;
  for I := 0 to Count - 1 do
    if (ForeignBarManager <> nil) and (Items[I].BarManager = ForeignBarManager) or
      (ForeignBarManager = nil) and (Items[I].BarManager <> BarManager) then
      Items[I].Free;
  if Owner is TdxBar then
    TdxBar(Owner).LockUpdate := PrevLockUpdate;
end;

function TdxBarItemLinks.HasItem(AItem: TdxBarItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if Items[I].HasItem(AItem) then
    begin
      Result := True;
      Break;
    end;
end;

function TdxBarItemLinks.IndexOf(Value: TdxBarItemLink): Integer;
begin
  Result := Value.Index;
end;

function TdxBarItemLinks.VisibleIndexOf(Value: TdxBarItemLink): Integer;
begin
  Result := FVisibleItems.IndexOf(Value);
end;

{ TdxBarPopupMenu }

constructor TdxBarPopupMenu.Create(AOwner: TComponent);
var
  AForm: TCustomForm;
begin
  inherited Create(AOwner);
  if dxBarManagerList.Count = 0 then
    raise Exception.Create(LoadStr(DXBAR_NOBARMANAGERS));
  if AOwner is TCustomForm then
    AForm := TCustomForm(AOwner)
  else
    AForm := nil;
  if AForm <> nil then BarManager := GetBarManagerByForm(AForm);
  if FBarManager = nil then
    BarManager := TdxBarManager(dxBarManagerList[0]);
  FFont := TFont.Create;
  FFont.Assign(BarManager.Font);
  FFont.OnChange := FontChanged;
  FItemLinks := TdxBarItemLinks.Create(FBarManager);
  FItemLinks.FOwner := Self;
  FItemLinks.FUseRecentItems := False;
  FShowAnimation := True;
end;

destructor TdxBarPopupMenu.Destroy;
begin
  Destroying;
  if FItemLinks <> nil then
  begin
    FItemLinks.Free;
    FItemLinks := nil;
  end;
  FFont.Free;
  if FEditFontHandle <> 0 then DeleteObject(FEditFontHandle);
  BarManager := nil;
  inherited Destroy;
end;

function TdxBarPopupMenu.GetSubMenuControl: TdxBarSubMenuControl;
begin
  Result := TdxBarSubMenuControl(FItemLinks.BarControl);
end;

procedure TdxBarPopupMenu.SetBarManager(Value: TdxBarManager);
begin
  if FBarManager <> Value then
  begin
    if (Value = nil) and not (csDestroying in ComponentState) then Exit;
    if FBarManager <> nil then FBarManager.FPopupMenus.Remove(Self);
    FBarManager := Value;
    if FItemLinks <> nil then FItemLinks.FBarManager := Value;
    if FBarManager <> nil then FBarManager.FPopupMenus.Add(Self);
  end;
end;

procedure TdxBarPopupMenu.SetBarSize(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FBarSize := Value;
end;

procedure TdxBarPopupMenu.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TdxBarPopupMenu.SetItemLinks(Value: TdxBarItemLinks);
begin
  FItemLinks.Assign(Value);
end;

procedure TdxBarPopupMenu.SetUseOwnFont(Value: Boolean);
begin
  if FUseOwnFont <> Value then
  begin
    FUseOwnFont := Value;
    FInternalFontChange := True;
    try
      if FUseOwnFont then
        FontChanged(nil)
      else
      begin
        Font := BarManager.Font;
        DeleteObject(FEditFontHandle);
        FEditFontHandle := 0;
      end;
    finally
      FInternalFontChange := False;
    end;
  end;
end;

procedure TdxBarPopupMenu.SetUseRecentItems(Value: Boolean);
begin
  if FUseRecentItems <> Value then
  begin
    FUseRecentItems := Value;
    FItemLinks.FUseRecentItems := Value;
  end;
end;

procedure TdxBarPopupMenu.FontChanged(Sender: TObject);
begin
  if not FInternalFontChange then
    FUseOwnFont := True;
  if FUseOwnFont then
    CreateEditFontHandle(FFont, FEditFontHandle, False);
end;

procedure TdxBarPopupMenu.SubMenuCloseUp(Sender: TObject);
begin
  FPopupMenuVisible := False;
  if Assigned(FOnCloseUp) then FOnCloseUp(Self);
end;

procedure TdxBarPopupMenu.SubMenuPopup(Sender: TObject);
begin
  FPopupMenuVisible := True;
  if Assigned(FOnPopup) then FOnPopup(Self);
end;

procedure TdxBarPopupMenu.OwnerDesignerModified;
begin
  if (csDesigning in ComponentState) and
    ([csLoading, csDestroying] * ComponentState = []) then
  begin
    BarManager.DesignerModified;
  {$IFDEF DELPHI5}
    if FindRootDesigner(Self) <> nil then
      FindRootDesigner(Self).Modified;
  {$ENDIF}    
  end;
end;

procedure TdxBarPopupMenu.DoPaintBar(Canvas: TCanvas; const R: TRect);
begin
  if Assigned(FOnPaintBar) then FOnPaintBar(Self, Canvas, R);
end;

function TdxBarPopupMenu.IsShortCut(AShortCut: TShortCut): Boolean;
begin
  Result := FItemLinks.IsShortCut(AShortCut);
end;

procedure TdxBarPopupMenu.Loaded;
begin
  inherited;
  FItemLinks.Loaded(True);
end;

procedure TdxBarPopupMenu.Popup(X, Y: Integer);
var
  Msg: TMsg;
begin
  if FItemLinks.BarControl <> nil then Exit;
  if Owner is TCustomForm then
    TCustomForm(Owner).SendCancelMode(nil)
  else
    BarManager.MainForm.SendCancelMode(nil);
  if GetCapture <> 0 then
  begin
    SendMessage(GetCapture, CM_CANCELMODE, 0, 0);
    ReleaseCapture;
  end;
  FItemLinks.CreateBarControl;
  FItemLinks.BarControl.Left := X;
  FItemLinks.BarControl.Top := Y;
  with TdxBarSubMenuControl(FItemLinks.BarControl) do
  begin
    if Self.FOwnerBounds <> nil then
      OwnerBounds := Self.FOwnerBounds^;
    OwnerWidth := Self.FOwnerWidth;
    OwnerHeight := Self.FOwnerHeight;
    if Self.Owner is TWinControl then
      ParentWnd := TWinControl(Self.Owner).Handle;
    OnCloseUp := SubMenuCloseUp;
    OnPopup := SubMenuPopup;
    FShowAnimation := Self.FShowAnimation;
    Show;

    if DontUseMessageLoop then Exit;

    repeat
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      if not FPopupMenuVisible then
        with Msg do
          PostMessage(hwnd, message, wParam, lParam)
      else
        if Msg.message = WM_COMMAND then  // do nothing
        else
        begin
          TranslateMessage(Msg);
          DispatchMessage(Msg);
        end;
    until not FPopupMenuVisible;
  end;
end;

procedure TdxBarPopupMenu.PopupEx(X, Y, AOwnerWidth, AOwnerHeight: Integer;
  AShowAnimation: Boolean; AOwnerBounds: PRect);
begin
  FOwnerWidth := AOwnerWidth;
  FOwnerHeight := AOwnerHeight;
  FShowAnimation := AShowAnimation;
  FOwnerBounds := AOwnerBounds;
  Popup(X, Y);
  FOwnerWidth := 0;
  FOwnerHeight := 0;
  FShowAnimation := True;
end;

procedure TdxBarPopupMenu.PopupFromCursorPos;
var
  P: TPoint;
begin
  GetCursorPos(P);
  Popup(P.X, P.Y);
end;

{ TdxDockControl }

constructor TdxDockControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentColor := True;
  FAllowDocking := True;
  FRowMarginSize := InsertZone;
  FRowList := TList.Create;
end;

constructor TdxDockControl.CreateEx(AOwner: TComponent;
  ABarManager: TdxBarManager; ADockStyle: TdxBarDockingStyle);
const
  Styles: array[dsLeft..dsBottom] of TAlign =
    (alLeft, alTop, alRight, alBottom);
begin
  Create(AOwner);
  Align := Styles[ADockStyle];
  ControlStyle := [csNoDesignVisible];
{$IFDEF DELPHI4}
  if ADockStyle = dsTop then
    ControlStyle := ControlStyle + [csActionClient];
{$ENDIF};
  FDockingStyle := ADockStyle;
  BarManager := ABarManager;
end;

destructor TdxDockControl.Destroy;
begin
  Destroying;
  BarManager := nil;
  while FRowList.Count <> 0 do
  begin
    while TdxDockRow(FRowList[0]).ColList.Count <> 0 do
    begin
      TdxDockCol(TdxDockRow(FRowList[0]).ColList[0]).Free;
      TdxDockRow(FRowList[0]).ColList.Delete(0);
    end;
    TdxDockRow(FRowList[0]).Free;
    FRowList.Delete(0);
  end;
  FRowList.Free;
  inherited Destroy;
end;

function TdxDockControl.GetBars: TdxBars;
begin
  if FBarManager = nil then
    Result := nil
  else
    Result := FBarManager.Bars;
end;

function TdxDockControl.GetDockingStyle: TdxBarDockingStyle;
const
  Styles: array[TAlign] of TdxBarDockingStyle =
    (dsTop, dsTop, dsBottom, dsLeft, dsRight, dsTop{$IFDEF DELPHI6}, dsTop{$ENDIF});
begin
  Result := Styles[Align];
end;

function TdxDockControl.GetHorizontal: Boolean;
begin
  Result := DockingStyle in [dsTop, dsBottom];
end;

function TdxDockControl.GetIsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TdxDockControl.GetIsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TdxDockControl.GetMain: Boolean;
begin
  Result := FDockingStyle <> dsNone;
end;

function TdxDockControl.GetRow(Index: Integer): TdxDockRow;
begin
  Result := FRowList[Index];
end;

function TdxDockControl.GetRowCount: Integer;
begin
  Result := FRowList.Count;
end;

function TdxDockControl.GetTopLeft: Boolean;
begin
  Result := DockingStyle in [dsLeft, dsTop];
end;

function TdxDockControl.GetVertical: Boolean;
begin
  Result := DockingStyle in [dsLeft, dsRight];
end;

procedure TdxDockControl.SetBarManager(Value: TdxBarManager);
begin
  if FBarManager <> Value then
  begin
    if FBarManager <> nil then
      FBarManager.RemoveDockControl(Self);
    FBarManager := Value;
    if FBarManager <> nil then
      FBarManager.AddDockControl(Self);
    BarManagerChanged;  
  end;
end;

procedure TdxDockControl.WMDestroy(var Message: TMessage);
begin
  if FBarManager <> nil then
    with FBarManager do
      if FTempBarsList = nil then FTempBarsList := TList.Create;
  inherited;
end;

procedure TdxDockControl.WMEraseBkgnd(var Message: TWMEraseBkgnd);
var
  ABrush: HBRUSH;
begin
  ABrush := CreateSolidBrush(ColorToRGB(Color));
  FillRect(Message.DC, ClientRect, ABrush);
  DeleteObject(ABrush);
  Message.Result := 1;
end;

procedure TdxDockControl.WMMouseActivate(var Message: TWMMouseActivate);
begin
  inherited;
  if (FBarManager <> nil) and not IsDesigning then
  begin
    Message.Result := MA_NOACTIVATE;
    SetWindowPos(FBarManager.MainForm.Handle, HWND_TOP, 0, 0, 0, 0,
      SWP_NOMOVE or SWP_NOSIZE);
  end;
end;

procedure TdxDockControl.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if SunkenBorder then
    InflateRect(Message.CalcSize_Params.rgrc[0], -1, -1);
end;

procedure TdxDockControl.WMNCPaint(var Message: TWMNCPaint);
var
  R: TRect;
  DC: HDC;
begin
  inherited;
  if SunkenBorder then
  begin
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    DC := GetWindowDC(Handle);
    DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
    ReleaseDC(Handle, DC);
  end;
end;

procedure TdxDockControl.WMRButtonDown(var Message: TWMRButtonDown);
var
  P: TPoint;
begin
  inherited;
  if FBarManager <> nil then
  begin
    if FBarManager.IsCustomizing then Exit;
    P.X := Message.XPos;
    P.Y := Message.YPos;
    P := ClientToScreen(P);
    ShowToolbarsPopup(Self, FBarManager, P);
  end;
end;

procedure TdxDockControl.WMWindowPosChanged(var Message: TWMWindowPosChanged);
var
  PrevLockUpdate: Boolean;
  I, J: Integer;
begin
  inherited;
  if (BarManager <> nil) and
    (Message.WindowPos^.flags and (SWP_NOMOVE or SWP_NOSIZE) <> SWP_NOMOVE or SWP_NOSIZE) then
  begin
    PrevLockUpdate := BarManager.FLockUpdate;
    BarManager.FLockUpdate := True;
    try
      if DockingStyle = dsBottom then
        for I := 0 to RowCount - 1 do
          for J := 0 to Rows[I].ColCount - 1 do
            with Rows[I].Cols[J].BarControl do
              if Bar.IsStatusBar then RebuildBar;
    finally
      BarManager.FLockUpdate := PrevLockUpdate;
    end;  
  end;
end;

procedure TdxDockControl.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  if IsWin95Or98 and Main and (DockingStyle = dsLeft) then
    BarManager.MainFormWndProc(WM_SYSCOLORCHANGE, 0, 0);
end;

procedure TdxDockControl.AlignControls(AControl: TControl; var Rect: TRect);
{$IFNDEF DELPHI4}
var
  R: TRect;
{$ENDIF}
begin
  if (FBarManager <> nil) and not FBarManager.IsLoading then
  begin
    UpdateDock;
  {$IFNDEF DELPHI4}
    with TDummyForm(Parent) do
    begin
      R := ClientRect;
      AlignControls(Self, R);
    end;
  {$ENDIF}
  end;
end;

procedure TdxDockControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_CHILD or WS_CLIPCHILDREN or WS_CLIPSIBLINGS;
    ExStyle := 0;
    WindowClass.Style := CS_DBLCLKS;
  end;
end;

procedure TdxDockControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = BarManager) then
    BarManager := nil;
end;

procedure TdxDockControl.RequestAlign;
begin
  if not (csDestroyingHandle in ControlState) then
    inherited;
end;

procedure TdxDockControl.WndProc(var Message: TMessage);
begin
  if (FBarManager <> nil) and
    (Message.Msg = WM_LBUTTONDBLCLK) and FBarManager.CanCustomize then
  begin
    FBarManager.Customizing(True);
    Exit;
  end;
  inherited;
end;

procedure TdxDockControl.AddBarControl(ABarControl: TdxBarControl; APos: TPoint;
  Update: Boolean);
var
  Ins: Boolean;
  ARow, ACol, I: Integer;
  DockRow: TdxDockRow;
  DockCol: TdxDockCol;
begin
  if FBarManager = nil then Exit;
  Ins := False;
  ARow := 0;
  if (ABarControl <> nil) and not ABarControl.InternallyLocked then
    ARow := GetRowAtPos(APos, Ins)
  else
    if ABarControl.FBar <> nil then
    begin
      ARow := ABarControl.FBar.Row;
      Ins := ABarControl.FBar.OneOnRow;
    end;

  if (ABarControl <> nil) and (ABarControl.Bar <> nil) and
    ABarControl.Bar.WholeRow then Ins := True;

  if ABarControl.InternallyLocked and Bars.FLoading and (ARow > FRowList.Count - 1) then
    for I := FRowList.Count to ARow do
      FRowList.Insert(I, TdxDockRow.Create(Self))
  else
  begin
    if ARow > FRowList.Count - 1 + Byte(Ins) then
    begin
      //Ins := True;
      ARow := FRowList.Count - Byte(not Ins){!};
    end;
    if ARow < 0 then ARow := 0;
  end;
  if ARow >= FRowList.Count then Ins := True;

  if not Ins then
    with TdxDockRow(FRowList[ARow]) do
      for I := 0 to ColList.Count - 1 do
        with TdxDockCol(ColList[I]) do
          if BarControl.Bar.WholeRow and (BarControl <> ABarControl) then
          begin
            Ins := True;
            Break;
          end;

  if Ins then
  begin
    if ABarControl.InternallyLocked and Bars.FLoading then
      DockRow := FRowList[ARow]
    else
    begin
      DockRow := TdxDockRow.Create(Self);
      FRowList.Insert(ARow, DockRow);
    end;
    DockCol := TdxDockCol.Create(DockRow, ABarControl);
    DockRow.ColList.Add(DockCol);
  end
  else
  begin
    DockCol := TdxDockCol.Create(TdxDockRow(FRowList[ARow]), ABarControl);
    ACol := GetColAtPos(ARow, APos);
    GetColAtPos(ARow, APos);
    TdxDockRow(FRowList[ARow]).ColList.Insert(ACol, DockCol);
  end;

  if not ABarControl.InternallyLocked then
  begin
    with Bars, FMovingOffset do
      if FMoving then
      begin
        Dec(APos.X, X);
        Dec(APos.Y, Y);
      end;
    with ABarControl, GetDragPointOffset(DockingStyle) do
    begin
      Dec(APos.X, X);
      Dec(APos.Y, Y);
    end;
  end;  

  Windows.ScreenToClient(Handle, APos);
  case Horizontal of
    True:
      if APos.X < 0 then APos.X := 0;
    False:
      if APos.Y < 0 then APos.Y := 0;
  end;

  DockCol.FPos := APos;

  if Update then
  begin
    if not {Bars.}ABarControl.FMoving then
      with ABarControl do
      begin
        Left := APos.X;
        Top := APos.Y;
      end;
    UpdateDock;
    if not BarManager.Bars.FLoading then
    begin                                 //!!!
      with ABarControl do APos := Point(Left, Top);
      DockCol.FPos := APos;
    end;
  end;
end;

procedure TdxDockControl.DeleteBarControl(ABarControl: TdxBarControl; ADockCol: Pointer;
  Update: Boolean);
var
  I, J: Integer;

  procedure DeleteCol;
  begin
    with TdxDockRow(FRowList[I]) do
    begin
      TdxDockCol(ColList[J]).Free;
      ColList.Delete(J);
      if ColList.Count = 0 then
      begin
        Free;
        FRowList.Delete(I);
      end;
    end;
    if Update then UpdateDock;
  end;

begin
  if FBarManager = nil then Exit;
  for I := 0 to FRowList.Count - 1 do
    with TdxDockRow(FRowList[I]) do
      if ADockCol <> nil then
      begin
        J := ColList.IndexOf(ADockCol);
        if J > -1 then
        begin
          DeleteCol;
          Exit;
        end;
      end
      else
        for J := 0 to ColList.Count - 1 do
          if TdxDockCol(ColList[J]).BarControl = ABarControl then
          begin
            DeleteCol;
            Exit;
          end;
end;

procedure TdxDockControl.MoveBarControl(ABarControl: TdxBarControl; APos: TPoint);
var
  DockCol: Pointer;
begin
  if FBarManager = nil then Exit;
  DockCol := TdxDockRow(FRowList[ABarControl.GetRow]).ColList[ABarControl.GetCol];
  DeleteBarControl(ABarControl, DockCol, False);
  AddBarControl(ABarControl, APos, True);
end;

procedure TdxDockControl.AssignPositions;
var
  I, J: Integer;
begin
  for I := 0 to RowCount - 1 do
    with Rows[I] do
      for J := 0 to ColCount - 1 do
        Cols[J].AssignPosition;
end;

procedure TdxDockControl.BarManagerChanged;
begin
end;

function TdxDockControl.CanDocking(Bar: TdxBar): Boolean;
begin
  Result := FAllowDocking;
end;

procedure TdxDockControl.ColorChanged;
begin
  if (FBarManager = nil) or FBarManager.AutoDockColor then
    ParentColor := True
  else
    Color := FBarManager.DockColor;
end;

function TdxDockControl.GetDockZoneBounds: TRect;
begin
  Result := BoundsRect;
  InflateRect(Result, Bars.DockingZoneSize, Byte(Horizontal) * Bars.DockingZoneSize);
  MapWindowPoints(GetParent(Handle), 0, Result, 2);
end;

procedure TdxDockControl.GetDockZoneMargins(Row, ZoneNumber: Integer; var M1, M2: Integer);
var
  IM1, IM2: Integer;
begin
  M1 := 0;
  M2 := 0;
  if Row = -1 then
    if TopLeft then
    begin
      M1 := -Bars.DockingZoneSize;
      M2 := 0;
    end
    else
    begin
      if DockingStyle = dsRight then
        M1 := ClientWidth
      else
        M1 := ClientHeight;
      M1 := M1 - GetClientSize - Bars.DockingZoneSize;
      M2 := M1 + Bars.DockingZoneSize;
    end
  else
    if Row = FRowList.Count then
      if TopLeft then
      begin
        M1 := GetClientSize;
        M2 := M1 + Bars.DockingZoneSize;
      end
      else
      begin
        if DockingStyle = dsRight then
          M1 := ClientWidth
        else
          M1 := ClientHeight;
        M2 := M1 + Bars.DockingZoneSize;
      end
    else
      with GetRectForRow(Row) do
        if Horizontal then
        begin
          M1 := Top;
          M2 := Bottom;
        end
        else
        begin
          M1 := Left;
          M2 := Right;
        end;
  case DockingStyle of
    dsLeft, dsTop:
      IM1 := M1 + (Bars.DockingZoneSize - InsertZone div 2) div 2;
    dsRight, dsBottom:
      IM1 := M2 - (Bars.DockingZoneSize - InsertZone div 2) div 2 - InsertZone div 2;
    else
      IM1 := 0;
  end;
  IM2 := IM1 + InsertZone div 2;

  case ZoneNumber of
    0: M2 := IM1;
    1: begin
         M1 := IM1;
         M2 := IM2;
       end;
    2: M1 := IM2;
  end;
end;

function TdxDockControl.GetRectForRow(ARow: Integer): TRect;
var
  I: Integer;
  Origin, Size: Integer;

  function GetRowHeight(ARow: Integer): Integer;
  var
    J: Integer;
  begin
    Result := 0;
    for J := 0 to TdxDockRow(FRowList[ARow]).ColList.Count - 1 do
      with TdxDockCol(TdxDockRow(FRowList[ARow]).ColList[J]).BarControl do
        case Self.DockingStyle of
          dsLeft, dsRight: if Result < Width then Result := Width;
          dsTop, dsBottom: if Result < Height then Result := Height;
        end;
  end;

begin
  SetRectEmpty(Result);
  if (ARow < 0) or (ARow > FRowList.Count - 1) then Exit;
  Size := 0;
  if not Bars.FMoving or (DockingStyle in [dsLeft, dsTop]) then
  begin
    Origin := 0;
    for I := 0 to ARow do
    begin
      Inc(Origin, Size);
      Size := GetRowHeight(I);
    end;
  end
  else
  begin
    if DockingStyle = dsRight then
      Origin := ClientWidth
    else
      Origin := ClientHeight;
    for I := FRowList.Count - 1 downto ARow do
    begin
      Size := GetRowHeight(I);
      Dec(Origin, Size);
    end;
  end;
  case DockingStyle of
    dsLeft, dsRight:
      Result := Bounds(Origin, 0, Size, ClientHeight);
    dsTop, dsBottom:
      Result := Bounds(0, Origin, ClientWidth, Size);
  end;
end;

function TdxDockControl.GetClientSize: Integer;
var
  I: Integer;
  R: TRect;
begin
  Result := 0;
  case DockingStyle of
    dsLeft, dsRight:
      for I := 0 to FRowList.Count - 1 do
      begin
        R := GetRectForRow(I);
        Inc(Result, R.Right - R.Left);
      end;
    dsTop, dsBottom:
      for I := 0 to FRowList.Count - 1 do
      begin
        R := GetRectForRow(I);
        Inc(Result, R.Bottom - R.Top);
      end;
  end;
end;

function TdxDockControl.GetSize: Integer;
begin
  Result := GetClientSize;
  if (Result > 0) and SunkenBorder then Inc(Result, 2);
end;

function TdxDockControl.GetRowAtPos(APos: TPoint; var Insert: Boolean): Integer;
var
  I, J, Z, M1, M2: Integer;
  Found: Boolean;
begin
  if FRowList.Count = 0 then
  begin
    Result := 0;
    Insert := True;
    Exit;
  end;
  
  Result := -1;
  Insert := False;
  Windows.ScreenToClient(Handle, APos);
  if Vertical then
    Z := APos.X
  else
    Z := APos.Y;
  Found := False;
  for I := -1 to FRowList.Count - 1 do
  begin
    for J := 0 to 2 do
    begin
      GetDockZoneMargins(I, J, M1, M2);
      if (M1 <= Z)  and (Z < M2) then
      begin
        Result := I + Byte(J > 0);
        Insert := J = 1;
        Found := True;
        Break;
      end;
    end;
    if Found then Break;
  end;

  if Result = -1 then
  begin
    Insert := True;
    if Z >= GetClientSize then
      Result := FRowList.Count
    else
      Result := 0;
  end
  else
    if Result >= FRowList.Count then Insert := True;
end;

function TdxDockControl.GetColAtPos(ARow: Integer; APos: TPoint): Integer;
var
  I: Integer;
begin
  Result := 0;
  if (FRowList[ARow] = nil) or
    (TdxDockRow(FRowList[ARow]).ColList.Count = 0) then Exit;
  Windows.ScreenToClient(Handle, APos);
  if Bars.FMoving and not Bars.FMovingBarControl.InternallyLocked then
    with Bars.FMovingBarControl.GetDragPointOffset(DockingStyle) do
      case DockingStyle of
        dsLeft, dsRight:
          Dec(APos.Y, Y);
        dsTop, dsBottom:
          Dec(APos.X, X);
      end;
  with TdxDockRow(FRowList[ARow]) do
  begin
    for I := 0 to ColList.Count - 1 do
      with TdxDockCol(ColList[I]), BarControl.Bar do
        case DockingStyle of
          dsLeft, dsRight:
            if APos.Y <= DockedTop then
            begin
              Result := I;
              Exit;
            end;
          dsTop, dsBottom:
            if APos.X <= DockedLeft then
            begin
              Result := I;
              Exit;
            end;
        end;
    Result := ColList.Count;
  end;
end;

procedure TdxDockControl.GetPosForRow(Row: Integer; OneOnRow: Boolean; var P: TPoint);
var
  M1, M2, Temp: Integer;
begin
  if OneOnRow and (Row = FRowList.Count) then OneOnRow := False;
  if OneOnRow then
    GetDockZoneMargins(Row - 1, 1, M1, M2)
  else
  begin
    GetDockZoneMargins(Row - 1, 2, M1, Temp);
    GetDockZoneMargins(Row, 0, Temp, M2);
    if Temp - M1 > M2 - Temp then M1 := Temp - (M2 - Temp);
  end;
  Temp := (M1 + M2) div 2;
  Windows.ScreenToClient(Handle, P);
  if Vertical then
    P.X := Temp
  else
    P.Y := Temp;
  Windows.ClientToScreen(Handle, P);
end;

function TdxDockControl.GetSunkenBorder: Boolean;
begin
  if BarManager = nil then
    Result := False
  else
    Result := BarManager.SunkenBorder;
end;

procedure TdxDockControl.NCChanged;
var
  I, J: Integer;
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0,
    SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_FRAMECHANGED);
  for I := 0 to RowCount - 1 do
    for J := 0 to Rows[I].ColCount - 1 do
      Rows[I].Cols[J].BarControl.FrameChanged{RebuildBar};
  UpdateDock;
end;

procedure TdxDockControl.PaintBarControls;
var
  AVertical: Boolean;
  Temp, I, J, K, MarkSize, ClientSize, LenMax,
    MinSize, MaxSize, MaxHeight, RowLen, RestSize, Margin, FixedSize, Size, APos: Integer;
  R: TRect;
  ASize: TPoint;

  function GetMinSize(ABarControl: TdxBarControl): Integer;
  begin
    if Vertical then
      Result := ABarControl.GetMinHeight(DockingStyle)
    else
      Result := ABarControl.GetMinWidth(DockingStyle);
  end;

  function GetMaxSizeX(ABarControl: TdxBarControl): Integer;
  begin
    if Vertical then
      Result := ABarControl.GetMaxHeight(DockingStyle)
    else
      Result := ABarControl.GetMaxWidth(DockingStyle);
  end;

  function GetMaxSizeY(ABarControl: TdxBarControl): Integer;
  begin
    if Vertical then
      Result := ABarControl.GetMaxWidth(DockingStyle)
    else
      Result := ABarControl.GetMaxHeight(DockingStyle);
  end;

  function NCSizeX(ABarControl: TdxBarControl): Integer;
  begin
    if Vertical then
      Result := ABarControl.Bar.BarNCSizeY(DockingStyle)
    else
      Result := ABarControl.Bar.BarNCSizeX(DockingStyle);
  end;

  function NCSizeY(ABarControl: TdxBarControl): Integer;
  begin
    if Vertical then
      Result := ABarControl.Bar.BarNCSizeX(DockingStyle)
    else
      Result := ABarControl.Bar.BarNCSizeY(DockingStyle);
  end;

  function GetFullSize(ABarControl: TdxBarControl; ASize: Integer): TPoint;
  begin
    Dec(ASize,
      NCSizeX(ABarControl) +
      Byte(ABarControl.FTruncated and (BarManager.Style = bmsStandard)) * MarkSize);
    if Vertical then
    begin
      Result := ABarControl.GetSizeForHeight(DockingStyle, ASize);
      with Result do
      begin
        Temp := X;
        X := Y;
        Y := Temp;
      end;
    end
    else
      Result := ABarControl.GetSizeForWidth(DockingStyle, ASize);
  end;

begin     
  if (FRowList = nil) or (FBarManager = nil) or
    (csDestroying in FBarManager.MainForm.ComponentState) or
    (Bars = nil) or Bars.FLoading then Exit;

  if not BarManager.Designing and HandleAllocated then
    SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0,
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);

  DisableAlign;

  AVertical := Vertical;
  MarkSize := MarkSizeX;
  if AVertical then
    ClientSize := ClientHeight
  else
    ClientSize := ClientWidth;

  for I := 0 to FRowList.Count - 1 do
    with TdxDockRow(FRowList[I]) do
      if ColList.Count > 0 then
      begin
        LenMax := 0;
        for J := 0 to ColList.Count - 1 do
          with TdxDockCol(ColList[J]), BarControl do
          begin
            FTruncated := False;
            ItemLinks.RecentItemCount := -1;
            FMinSize := GetMinSize(BarControl) + NCSizeX(BarControl);
            FMaxSize := GetMaxSizeX(BarControl) + NCSizeX(BarControl);
            if not MarkExists and (FMinSize <> FMaxSize) then
              Inc(FMinSize, MarkSize);
            Inc(LenMax, FMaxSize);
          end;

        R := GetRectForRow(I);
        if AVertical then
          with R do
          begin
            Temp := Left;
            Left := Top;
            Top := Temp;
          end;
        RowLen := ClientSize;
        MaxHeight := 0;

        if TdxDockCol(ColList[0]).BarControl.Bar.WholeRow then
          with TdxDockCol(ColList[0]), BarControl do
          begin
            NewLeft := R.Left;
            NewTop := R.Top;
            NewWidth := RowLen;
            if NewWidth < FMinSize then NewWidth := FMinSize;
            FTruncated := not MultiLine and (NewWidth < FMaxSize);
            NewHeight := GetFullSize(BarControl, NewWidth).Y + NCSizeY(BarControl);
            if NewHeight > MaxHeight then MaxHeight := NewHeight;
          end
        else
          if LenMax <= RowLen then
          begin
            Margin := RowLen;
            for J := ColList.Count - 1 downto 0 do
              with TdxDockCol(ColList[J]), BarControl do
              begin
                NewTop := R.Top;
                NewWidth := FMaxSize;
                if MultiLine then
                  NewHeight := GetFullSize(BarControl, NewWidth).Y
                else
                  NewHeight := GetMaxSizeY(BarControl);
                Inc(NewHeight, NCSizeY(BarControl));
                if NewHeight > MaxHeight then MaxHeight := NewHeight;
                if AVertical then
                  APos := Pos.Y
                else
                  APos := Pos.X;
                if APos + NewWidth <= Margin then
                  NewLeft := APos
                else
                  NewLeft := Margin - NewWidth;
                FixedSize := 0;
                for K := 0 to J - 1 do
                  Inc(FixedSize, TdxDockCol(ColList[K]).BarControl.FMaxSize);
                if NewLeft < FixedSize then NewLeft := FixedSize;
                Margin := NewLeft;
              end;
          end
          else
          begin
            Size := RowLen;
            for J := ColList.Count - 1 downto 0 do
              with TdxDockCol(ColList[J]), BarControl do
              begin
                if AVertical then
                  FixedSize := Pos.Y
                else
                  FixedSize := Pos.X;
                MinSize := 0;
                MaxSize := 0;
                for K := J - 1 downto 0 do
                  with TdxDockCol(ColList[K]).BarControl do
                  begin
                    Inc(MinSize, FMinSize);
                    Inc(MaxSize, FMaxSize);
                  end;
                if FixedSize < MinSize then FixedSize := MinSize;
                if FixedSize > MaxSize then FixedSize := MaxSize;
                if (J > 0) and (TdxDockCol(ColList[J - 1]).BarControl = Bars.FMovingBarControl) then
                begin
                  with TdxDockCol(ColList[J - 1]), BarControl, Bar do
                  begin
                    if AVertical then
                      K := Pos.Y
                    else
                      K := Pos.X;
                    if K < MinSize - FMinSize then K := MinSize - FMinSize;
                    Inc(K, FMaxSize);
                  end;
                  if K < FixedSize then
                  begin
                    if AVertical then
                      FPos.Y := K
                    else
                      FPos.X := K;
                    FixedSize := K;
                  end;
                end;
                RestSize := Size - FixedSize;

                if RestSize >= FMaxSize then
                begin
                  NewWidth := FMaxSize;
                  if MultiLine then
                    NewHeight := GetFullSize(BarControl, NewWidth).Y
                  else
                    NewHeight := GetMaxSizeY(BarControl);
                end
                else
                begin
                  FTruncated := not MultiLine and (FMinSize <> FMaxSize);
                  if RestSize <= FMinSize then
                    NewWidth := FMinSize
                  else
                    NewWidth := RestSize;
                  NewHeight := GetFullSize(BarControl, NewWidth).Y;
                end;

                if (J = 0) and (Size > NewWidth) then NewWidth := Size;
                NewLeft := Size - NewWidth;
                if NewLeft < MinSize then NewLeft := MinSize;
                if NewLeft > MaxSize then NewLeft := MaxSize;
                NewTop := R.Top;
                Inc(NewHeight, NCSizeY(BarControl));
                if NewHeight > MaxHeight then MaxHeight := NewHeight;
                
                Dec(Size, NewWidth);
              end;
          end;

        for J := 0 to ColList.Count - 1 do
          with TdxDockCol(ColList[J]).BarControl do
            if Bar.UseRestSpace then
            begin
              if J = 0 then
                NewLeft := 0
              else
                with TdxDockCol(ColList[J - 1]).BarControl do
                  TdxDockCol(ColList[J]).BarControl.NewLeft := NewLeft + NewWidth;
              if J = ColList.Count - 1 then
                NewWidth := ClientSize - NewLeft
              else
                NewWidth := TdxDockCol(ColList[J + 1]).BarControl.NewLeft - NewLeft;
              if NewWidth < FMinSize then NewWidth := FMinSize;
            end;

        for J := 0 to ColList.Count - 1 do
          with TdxDockCol(ColList[J]), BarControl do
          begin
            if FTruncated and (J = ColList.Count - 1) then
            begin
              NewWidth := ClientSize - NewLeft;
              if NewWidth < FMinSize then NewWidth := FMinSize;
            end;
            NewHeight := MaxHeight;
            // for the RecentItemCount calculating
            GetFullSize(BarControl, NewWidth);
            if AVertical then
            begin
              Temp := NewLeft;
              NewLeft := NewTop;
              NewTop := Temp;
              Temp := NewWidth;
              NewWidth := NewHeight;
              NewHeight := Temp;
            end;
            if (Left <> NewLeft) or (Top <> NewTop) or
              (Width <> NewWidth) or (Height <> NewHeight) then
              SetWindowPos(Handle, 0, NewLeft, NewTop, NewWidth, NewHeight,
                SWP_NOZORDER or SWP_NOACTIVATE);
            CalcControlsPositions;
          end;
      end;

  EnableAlign;

  Repaint;
end;

procedure TdxDockControl.SetSize;
var
  ASize, PrevSize: Integer;
begin
  ASize := GetSize;
  PrevSize := 0;
  case DockingStyle of
    dsLeft, dsRight:
      begin
        PrevSize := Width;
        if DockingStyle = dsRight then
        begin
          Parent.DisableAlign;
          Left := Left - (ASize - Width);
        end;
        Width := ASize;
        if DockingStyle = dsRight then Parent.EnableAlign;
      end;
    dsTop, dsBottom:
      begin
        PrevSize := Height;
        if DockingStyle = dsBottom then
        begin
          Parent.DisableAlign;
          Top := Top - (ASize - Height);
        end;
        Height := ASize;
        if DockingStyle = dsBottom then Parent.EnableAlign;
      end;
  end;
  if (ASize <> PrevSize) and (ActiveBarControl <> nil) and
    not (GetParentBarForBar(ActiveBarControl) is TdxBarQuickControl) and
    (ActiveBarControl.Handle <> GetCapture) then
    ActiveBarControl.HideAll;
end;

procedure TdxDockControl.UpdateDock;
begin
  if (FBarManager <> nil) and
    not (csDestroying in FBarManager.MainForm.ComponentState) and
    not FBarManager.LockUpdate then
  begin
    PaintBarControls;
    SetSize;
  end;
end;

{$IFDEF DELPHI4}
procedure TdxDockControl.InitiateAction;
var
  I: Integer;
begin
  if FBarManager <> nil then
    with FBarManager do
      for I := 0 to Bars.Count - 1 do
        with Bars[I] do
          if Visible then ItemLinks.InitiateActions;
end;
{$ENDIF}

{ TdxBarDockControl }

constructor TdxBarDockControl.Create(AOwner: TComponent);
begin
  inherited;
  Align := dalTop;
end;

function TdxBarDockControl.GetAlign: TdxBarDockAlign;
begin
  Result := TdxBarDockAlign(inherited Align);
end;

function TdxBarDockControl.GetColor: TColor;
begin
  Result := inherited Color;
end;

function TdxBarDockControl.GetIsLoading: Boolean;
begin
  Result := (csLoading in ComponentState) or
    (BarManager <> nil) and BarManager.Bars.IsLoading;
end;

function TdxBarDockControl.GetParentColor: Boolean;
begin
  Result := inherited ParentColor;
end;

procedure TdxBarDockControl.SetAlign(Value: TdxBarDockAlign);
const
  Styles: array[TdxBarDockAlign] of TdxBarDockingStyle =
    (dsTop, dsTop, dsBottom, dsLeft, dsRight);
var
  PrevLockUpdate: Boolean;
  I, J: Integer;
begin
  if Align <> Value then
  begin
    if BarManager <> nil then
    begin
      PrevLockUpdate := BarManager.LockUpdate;
      BarManager.LockUpdate := True;
    end
    else
      PrevLockUpdate := False;
    try
      for I := 0 to RowCount - 1 do
        for J := 0 to Rows[I].ColCount - 1 do
          Rows[I].Cols[J].BarControl.DockingStyle := Styles[Value];
      inherited Align := TAlign(Value);
    finally
      if BarManager <> nil then
      begin
        BarManager.LockUpdate := PrevLockUpdate;
        for I := 0 to RowCount - 1 do
          for J := 0 to Rows[I].ColCount - 1 do
            Rows[I].Cols[J].BarControl.RepaintBar;
        if Parent <> nil then Parent.Invalidate;
      end;
    end;
  end;
end;

procedure TdxBarDockControl.SetAllowZeroSizeInDesignTime(Value: Boolean);
begin
  if FAllowZeroSizeInDesignTime <> Value then
  begin
    FAllowZeroSizeInDesignTime := Value;
    Perform(WM_SIZE, 0, 0);
  end;
end;

procedure TdxBarDockControl.SetColor(Value: TColor);
begin
  if Color <> Value then
  begin
    inherited Color := Value;
    if not IsLoading then UseOwnColor := True;
  end;
end;

procedure TdxBarDockControl.SetParentColor(Value: Boolean);
begin
  if ParentColor <> Value then
  begin
    inherited ParentColor := Value;
    if not IsLoading then UseOwnColor := True;
  end;
end;

procedure TdxBarDockControl.SetSunkenBorder(Value: Boolean);
begin
  if SunkenBorder <> Value then
  begin
    FSunkenBorder := Value;
    FUseOwnSunkenBorder := True;
    NCChanged;
  end;
end;

procedure TdxBarDockControl.SetUseOwnColor(Value: Boolean);
begin
  if FUseOwnColor <> Value then
  begin
    FUseOwnColor := Value;
    if not Value then ColorChanged;
  end;
end;

procedure TdxBarDockControl.SetUseOwnSunkenBorder(Value: Boolean);
var
  PrevSunkenBorder: Boolean;
begin
  if FUseOwnSunkenBorder <> Value then
  begin
    PrevSunkenBorder := SunkenBorder;
    FUseOwnSunkenBorder := Value;
    if Value then
      FSunkenBorder := PrevSunkenBorder
    else
      if SunkenBorder <> PrevSunkenBorder then NCChanged;
  end;
end;

function TdxBarDockControl.IsColorStored: Boolean;
begin
  Result := FUseOwnColor and not ParentColor;
end;

procedure TdxBarDockControl.WMCreate(var Message: TWMCreate);
var
  I: Integer;
begin
  inherited;
  if (BarManager <> nil) and (BarManager.FTempBarsList <> nil) then
    with BarManager do
      for I := FTempBarsList.Count - 1 downto 0 do
        with TdxBar(FTempBarsList[I]) do
          if (DockedDockControl = Self) and (DockingStyle <> dsNone) then
          begin
            Visible := True;
            FTempBarsList.Delete(I);
          end;
end;

procedure TdxBarDockControl.WMSize(var Message: TWMSize);
begin
  inherited;
  if not IsLoading and (RowCount = 0) then
    if Horizontal then
      ClientHeight := GetMinSize
    else
      ClientWidth := GetMinSize;
end;

procedure TdxBarDockControl.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if IsDesigning then
    with Params do
      WindowClass.Style := WindowClass.Style or CS_HREDRAW or CS_VREDRAW;
end;

procedure TdxBarDockControl.Paint;
begin
  if IsDesigning then
    with Canvas do
    begin
      Brush := Self.Brush;
      Pen.Style := psDot;
      Rectangle(0, 0, ClientWidth, ClientHeight);
      Pen.Style := psSolid;
    end
  else
    inherited;
end;

procedure TdxBarDockControl.BarManagerChanged;
begin
  inherited;
  if not (csDestroying in ComponentState) then
  begin
    ColorChanged;
    NCChanged;
  end;
end;

function TdxBarDockControl.CanDocking(Bar: TdxBar): Boolean;
begin
  Result := inherited CanDocking(Bar) and
    ((Bar.Control = nil) or not HasAsParent(Handle, Bar.Control.Handle));
end;

procedure TdxBarDockControl.ColorChanged;
begin
  if not FUseOwnColor then
  begin
    inherited;
    FUseOwnColor := False;
  end;
end;

function TdxBarDockControl.GetClientSize: Integer;
begin
  if IsLoading then
    if Horizontal then
      Result := ClientHeight
    else
      Result := ClientWidth
  else
  begin
    Result := inherited GetClientSize;
    if Result = 0 then Result := GetMinSize;
  end;
end;

function TdxBarDockControl.GetMinSize: Integer;
begin
  if IsDesigning and not AllowZeroSizeInDesignTime then
    Result := MinDockSize
  else
    Result := 0;
end;

function TdxBarDockControl.GetSunkenBorder: Boolean;
begin
  if FUseOwnSunkenBorder then
    Result := FSunkenBorder
  else
    Result := inherited GetSunkenBorder;
end;

{ TdxBarShadowPart }

constructor TdxBarShadowPart.CreateEx(AOwner: TdxBarShadow;
  AKind: TdxBarShadowPartKind; ACorners: TdxBarShadowCorners);
begin
  Create(nil);
  FOwner := AOwner;
  FKind := AKind;
  FCorners := ACorners;
  FImage := TBitmap.Create;
end;

destructor TdxBarShadowPart.Destroy;
begin
  FImage.Free;
  inherited;
end;

function TdxBarShadowPart.GetControl: TWinControl;
begin
  Result := FOwner.Owner;
end;

function TdxBarShadowPart.GetShadowSize: Integer;
begin
  Result := FOwner.ShadowSize;
end;

function TdxBarShadowPart.GetTransparent: Boolean;
begin
  Result := FOwner.Transparent;
end;

procedure TdxBarShadowPart.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  Message.Result := HTTRANSPARENT;
end;

function TdxBarShadowPart.CanShow: Boolean;
begin
  Result := (FCorners = []) or (Width >= ShadowSize) and (Height >= ShadowSize);
end;

procedure TdxBarShadowPart.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := WS_POPUP;
    if Transparent then
      ExStyle := WS_EX_LAYERED
    else
      ExStyle := 0;
    if GetWindowLong(Control.Handle, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0 then
      ExStyle := ExStyle or WS_EX_TOPMOST;
    WndParent := Control.Handle;
    WindowClass.style := 0;
  end;
end;

procedure TdxBarShadowPart.Paint;
begin
  with Canvas do
  begin
    Brush.Color := clBtnShadow;
    FillRect(ClientRect);
  end;
end;

procedure TdxBarShadowPart.UpdateImage;
type
  PColors = ^TColors;
  TColors = array[0..MaxInt - 1] of Byte;
var
  BI: TBitmapInfo;
  Colors: PColors;

  function GetAlphaIndex(X, Y: Integer): Integer;
  begin
    Result := (Y * Width + X) * 4 + 3;
  end;

  function GetAlpha(X, Y: Integer): Byte;
  begin
    Result := Colors^[GetAlphaIndex(X, Y)];
  end;

  procedure SetAlpha(X, Y: Integer; Value: Byte);
  begin
    Colors^[GetAlphaIndex(X, Y)] := Value;
  end;

  procedure ProcessMainContent;
  const
    AlphaStep = 15;
  var
    X, Y: Integer;
  begin
    for X := 0 to Width - 1 do
      for Y := 0 to Height - 1 do
        if FKind = spHorizontal then
          SetAlpha(X, Y, (Height - Y) * AlphaStep)
        else
          SetAlpha(X, Y, (Width - X) * AlphaStep);
  end;

  procedure ProcessCorners;
  type
    TCornerKind = (ckLeft, ckRight, ckTop);

    procedure ProcessCorner(ACornerKind: TCornerKind);
    var
      I, J, X, Y: Integer;

      procedure ConvertCoordinates;
      begin
        case ACornerKind of
          ckLeft:
            begin
              X := I;
              Y := J;
            end;
          ckRight:
            begin
              X := Width - 1 - I;
              Y := J;
            end;
          ckTop:
            begin
              X := J;
              Y := I;
            end;
        end;
      end;

    begin
      for I := 0 to ShadowSize - 1 do
        for J := 0 to ShadowSize - 1 do
        begin
          ConvertCoordinates;
          SetAlpha(X, Y, MulDiv(GetAlpha(X, Y), 1 + I, 1 + ShadowSize));
        end;
    end;

  begin
    if FKind = spHorizontal then
    begin
      if scLeft in FCorners then
        ProcessCorner(ckLeft);
      if scRight in FCorners then
        ProcessCorner(ckRight);
    end
    else
      if scTop in FCorners then
        ProcessCorner(ckTop);
  end;

begin
  if not CanShow then Exit;
  FImage.PixelFormat := pf32bit;
  FImage.Width := Width;
  FImage.Height := Height;
  with BI.bmiHeader do
  begin
    biSize := SizeOf(BI.bmiHeader);
    biWidth := Width;
    biHeight := -Height;
    biPlanes := 1;
    biBitCount := 32;
    biCompression := BI_RGB;
  end;
  GetMem(Colors, 4 * Width * Height);
  try
    FillChar(Colors^, 4 * Width * Height, 0);
    ProcessMainContent;
    ProcessCorners;
    SetDIBits(FImage.Canvas.Handle, FImage.Handle, 0, Height, Colors, BI, DIB_RGB_COLORS);
  finally
    FreeMem(Colors);
  end;
end;

procedure TdxBarShadowPart.Hide;
begin
  ShowWindow(Handle, SW_HIDE);
  DestroyHandle;
end;

procedure TdxBarShadowPart.Show;

  procedure MakeAlphaBlended;
  var
    ASize: TSize;
    P: TPoint;
    ABlend: TBlendFunction;
  begin
    ASize := TSize(ClientRect.BottomRight);
    P := Point(0, 0);
    with ABlend do
    begin
      BlendOp := AC_SRC_OVER;
      BlendFlags := 0;
      SourceConstantAlpha := 255;
      AlphaFormat := AC_SRC_ALPHA;
    end;
    UpdateLayeredWindow(Handle, 0, nil, @ASize, FImage.Canvas.Handle, @P, 0,
      @ABlend, ULW_ALPHA);
  end;

begin
  if not CanShow then Exit;
  if Transparent then MakeAlphaBlended;
  SetWindowPos(Handle, Control.Handle, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE);
end;

procedure TdxBarShadowPart.UpdateBounds(const ABounds: TRect);
begin
  BoundsRect := ABounds;
  UpdateImage;
  if FOwner.Visible then Show;
end;

{ TdxBarShadow }

constructor TdxBarShadow.Create(AOwner: TWinControl);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TdxBarShadow.Destroy;
begin
  DestroyParts;
  inherited;
end;

function TdxBarShadow.GetShadowSize: Integer;
begin
  if Transparent then
    Result := dxBarTransparentShadowSize
  else
    Result := dxBarOpaqueShadowSize;
end;

function TdxBarShadow.GetTransparent: Boolean;
begin
  Result := (@UpdateLayeredWindow <> nil) and (BitsPerPixel > 8);
end;

procedure TdxBarShadow.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if FVisible then
      Show
    else
      Hide;
  end;
end;

procedure TdxBarShadow.CreateParts;
var
  APartCount: Integer;

  procedure CreatePart(AKind: TdxBarShadowPartKind; ACorners: TdxBarShadowCorners;
    const ABounds: TRect);
  begin
    FParts[APartCount] := TdxBarShadowPart.CreateEx(Self, AKind, ACorners);
    FParts[APartCount].UpdateBounds(ABounds);
    Inc(APartCount);
  end;

  procedure CreatePartsForHorizontalMode;
  begin
    if not IsRectEmpty(R1) then
      CreatePart(spVertical, [scTop],
        Rect(R1.Right, R1.Top + ShadowSize, R1.Right + ShadowSize, R1.Bottom));
    CreatePart(spHorizontal, [scLeft, scRight],
      Rect(R2.Left + ShadowSize, R2.Bottom, R2.Right + ShadowSize, R2.Bottom + ShadowSize));

    if not IsRectEmpty(R1) then
    begin
      if R1.Left + ShadowSize < R2.Left then
        CreatePart(spHorizontal, [scLeft],
          Rect(R1.Left + ShadowSize, R1.Bottom, R2.Left, R1.Bottom + ShadowSize));
      if R1.Right > R2.Right then
        CreatePart(spHorizontal, [scRight],
          Rect(R2.Right, R1.Bottom, R1.Right + ShadowSize, R1.Bottom + ShadowSize));
    end;

    if IsRectEmpty(R1) or (R1.Right < R2.Right) then
      CreatePart(spVertical, [scTop],
        Rect(R2.Right, R2.Top + ShadowSize, R2.Right + ShadowSize, R2.Bottom))
    else
      CreatePart(spVertical, [],
        Rect(R2.Right, R2.Top, R2.Right + ShadowSize, R2.Bottom));
  end;

  procedure CreatePartsForVerticalMode;
  begin
    CreatePart(spVertical, [scTop],
      Rect(R2.Right, R2.Top + ShadowSize, R2.Right + ShadowSize, R2.Bottom));

    if R1.Top + ShadowSize < R2.Top then
      CreatePart(spVertical, [scTop],
        Rect(R1.Right, R1.Top + ShadowSize, R1.Right + ShadowSize, R2.Top));

    if R1.Bottom > R2.Bottom then
    begin
      CreatePart(spHorizontal, [scLeft, scRight],
        Rect(R1.Left + ShadowSize, R1.Bottom, R1.Right + ShadowSize, R1.Bottom + ShadowSize));
      CreatePart(spVertical, [],
        Rect(R1.Right, R2.Bottom, R1.Right + ShadowSize, R1.Bottom));
    end
    else
      CreatePart(spHorizontal, [scLeft],
        Rect(R1.Left + ShadowSize, R1.Bottom, R1.Right, R1.Bottom + ShadowSize));

    if R1.Bottom >= R2.Bottom then
      CreatePart(spHorizontal, [scRight],
        Rect(R2.Left, R2.Bottom, R2.Right + ShadowSize, R2.Bottom + ShadowSize))
    else
      CreatePart(spHorizontal, [scLeft, scRight],
        Rect(R2.Left + ShadowSize, R2.Bottom, R2.Right + ShadowSize, R2.Bottom + ShadowSize));
  end;

begin
  APartCount := 0;
  if FHorizontal then
    CreatePartsForHorizontalMode
  else
    CreatePartsForVerticalMode;
end;

procedure TdxBarShadow.DestroyParts;
var
  I: Integer;
begin
  for I := Low(FParts) to High(FParts) do
  begin
    FParts[I].Free;
    FParts[I] := nil;
  end;
end;

procedure TdxBarShadow.Hide;
var
  I: Integer;
begin
  for I := Low(FParts) to High(FParts) do
    if FParts[I] <> nil then FParts[I].Hide;
end;

procedure TdxBarShadow.Show;
var
  I: Integer;
begin
  for I := Low(FParts) to High(FParts) do
    if FParts[I] <> nil then FParts[I].Show;
end;

procedure TdxBarShadow.Refresh;
begin
  DestroyParts;
  CreateParts;
end;

procedure TdxBarShadow.SetOwnerBounds(AR1, AR2: TRect);

  procedure SwapRects;
  var
    R: TRect;
  begin
    R := R1;
    R1 := R2;
    R2 := R;
  end;

begin
  R1 := AR1;
  R2 := AR2;
  FHorizontal := IsRectEmpty(R1) or (R1.Bottom = R2.Top) or (R1.Top = R2.Bottom);
  if FHorizontal and (R1.Top = R2.Bottom) or
    not FHorizontal and (R1.Left = R2.Right) then
    SwapRects;
  Refresh;
end;

{ TCustomdxBarControl }

constructor TCustomdxBarControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddBarControl(Self);
  ControlStyle := ControlStyle - [csCaptureMouse];
  UpdateControlStyle;
  Color := clBtnFace;
  FLastMousePos := Point(-1, -1);
  FShadow := TdxBarShadow.Create(Self);
  Visible := False;
  SetBounds(100, 100, 30, 50);
end;

destructor TCustomdxBarControl.Destroy;
begin
  if Self is TdxBarControl then
    TdxBarControl(Self).HideAll//BarLostFocus
  else
    IsActive := False;
  if (BarManager <> nil) and (BarManager.FSelectedItem <> nil) and
    (BarManager.FSelectedItem.Parent = Self) then
    BarManager.FSelectedItem := nil;
  if FItemLinks <> nil then FItemLinks.FBarControl := nil;
  if IsCustomizing and (Self is TdxBarSubMenuControl) then
  begin
    FSelectedItem := nil;
    with TdxBarSubMenuControl(Self) do
      if FSubItem <> nil then
        with FSubItem do
        begin
          BarManager.FSelectedItem := FSubItem;
          FIsActive := False;
          Repaint;
        end;
  end;
  RemoveBarControl(Self);
  FShadow.Free;
  inherited Destroy;
end;

function TCustomdxBarControl.GetBarControlOwnerBrush: HBRUSH;
begin
  Result := BarManager.FlatToolbarsBrush;
end;

function TCustomdxBarControl.GetBarManager: TdxBarManager;
begin
  Result := Owner as TdxBarManager;
end;

function TCustomdxBarControl.GetFlat: Boolean;
begin
  Result := BarManager.Flat;
end;

function TCustomdxBarControl.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TCustomdxBarControl.GetOwnerLinkBounds(AOwnerPart: Boolean): TRect;
var
  AOwnerBounds: TRect;
  AFirstCase: Boolean;

  procedure ConvertRects;

    procedure ConvertRect(var R: TRect);

      procedure ConvertPoint(var P: TPoint);
      var
        APrevX: Integer;
      begin
        with P do
        begin
          APrevX := X;
          X := Y;
          Y := APrevX;
        end;
      end;

    begin
      ConvertPoint(R.TopLeft);
      ConvertPoint(R.BottomRight);
    end;

  begin
    if not FShadow.Horizontal then
    begin
      ConvertRect(Result);
      ConvertRect(AOwnerBounds);
    end;
  end;

begin
  if IsRectEmpty(FOwnerBounds) or not IsLinkedToOwner then
    SetRectEmpty(Result)
  else
  begin
    GetWindowRect(Result);
    AOwnerBounds := FOwnerBounds;
    with Result do
    begin
      OffsetRect(AOwnerBounds, -Left, -Top);
      OffsetRect(Result, -Left, -Top);
      ConvertRects;

      AFirstCase := AOwnerBounds.Bottom = Top;
      if AFirstCase then
        Bottom := Top + 1
      else
        Top := Bottom - 1;
      if AOwnerPart then
        OffsetRect(Result, 0, -(2 * Ord(AFirstCase) - 1));

      if Left < AOwnerBounds.Left + 1 then
        Left := AOwnerBounds.Left + 1
      else
        Inc(Left);
      if Right > AOwnerBounds.Right - 1 then
        Right := AOwnerBounds.Right - 1
      else
        Dec(Right);

      ConvertRects;
    end;
    if AOwnerPart then
      OffsetRect(Result, Left, Top);
  end;
end;

procedure TCustomdxBarControl.WMCaptureChanged(var Message: TMessage);
begin
  inherited;
  if FDragDown then
  begin
    BarManager.FDraggingItem := nil;
    BarManager.FDraggingItemLink := nil;
    FDragDown := False;
  end;
  FClickedControl := nil;
end;

procedure TCustomdxBarControl.WMDestroy(var Message: TMessage);
begin
  FinishMouseTracking(Handle);
  MarkState := msNone;
  BeforeDestroyHandle;
  inherited;
end;

procedure TCustomdxBarControl.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if FItemLinks.CanVisibleItemCount = 0 then
    FillRect(Message.DC, ClientRect, ToolbarBrush);
  Message.Result := 1;
end;

procedure TCustomdxBarControl.WMKeyDown(var Message: TWMKeyDown);
var
  Key: Word;
  IsTabKey, Duplicate, Hidden: Boolean;
  AItemLink, DuplicateItemLink: TdxBarItemLink;
begin
  inherited;
  if ActiveBarControl = nil then Exit;

  Key := Message.CharCode;

  if IsRealVertical(Self) then
  begin
    case Key of
      VK_LEFT:
        Key := VK_UP;
      VK_RIGHT:
        Key := VK_DOWN;
      VK_UP:
        Key := VK_LEFT;
      VK_DOWN:
        Key := VK_RIGHT;
    end;
    Message.CharCode := Key;
  end;

  if Self is TdxBarSubMenuControl then
    case Key of
      VK_LEFT, VK_RIGHT:
        Key := 0;
      VK_UP:
        Key := VK_LEFT;
      VK_DOWN:
        Key := VK_RIGHT;
    end;
  IsTabKey := Key = VK_TAB;
  if IsTabKey then
    if GetKeyState(VK_SHIFT) < 0 then
      Key := VK_LEFT
    else
      Key := VK_RIGHT;

  case Key of
    VK_F10, VK_MENU:
      if (Key = VK_MENU) or BarManager.UseF10ForMenu then
      begin
        Message.CharCode := 0;
        HideAll;
      end;
    VK_LEFT:
      begin
        if FSelectedItem = nil then
          AItemLink := ItemLinks.First
        else
          AItemLink := ItemLinks.Prev(FSelectedItem.ItemLink);
        if AItemLink <> nil then SetKeySelectedItem(AItemLink.Control);
        if IsTabKey and (SelectedItem is TdxBarWinControl) then
          SelectedItem.Click(False);
      end;
    VK_RIGHT:
      begin
        if FSelectedItem = nil then
          AItemLink := ItemLinks.First
        else
          AItemLink := ItemLinks.Next(FSelectedItem.ItemLink);
        if AItemLink <> nil then SetKeySelectedItem(AItemLink.Control);
        if IsTabKey and (SelectedItem is TdxBarWinControl) then
          SelectedItem.Click(False);
      end;
    VK_HOME:
      begin
        AItemLink := ItemLinks.First;
        if AItemLink <> nil then SetKeySelectedItem(AItemLink.Control);
      end;
    VK_END:
      begin
        AItemLink := ItemLinks.Last;
        if AItemLink <> nil then SetKeySelectedItem(AItemLink.Control);
      end;
  else
    begin
      Key := MapVirtualKey(Key, 2);
      if ((Ord('A') <= Key) and (Key <= Ord('Z'))) or (Ord('0') <= Key) and (Key <= Ord('9')) then
        with ItemLinks do
        begin
          if SelectedItem = nil then AItemLink := nil
          else AItemLink := SelectedItem.ItemLink;
          AItemLink := FindItemWithAccel(Key, KeyDataToShiftState(Message.KeyData), AItemLink);
          if (AItemLink <> nil) and AItemLink.Item.Enabled then
          begin
            Duplicate := False;
            DuplicateItemLink := AItemLink;
            repeat
              Hidden := DuplicateItemLink.VisibleIndex = -1;
              DuplicateItemLink :=
                FindItemWithAccel(Key, KeyDataToShiftState(Message.KeyData), DuplicateItemLink);
              if DuplicateItemLink = AItemLink then Break;
              Duplicate := True;
            until Hidden;
            if (BarManager.Style <> bmsStandard) and (Self is TdxBarSubMenuControl) and
              (Duplicate and Hidden or
               not Duplicate and not AItemLink.Control.IsDestroyOnClick and Hidden) then
              MarkState := msPressed;
            SetKeySelectedItem(AItemLink.Control);
            if not Duplicate then SendMessage(Handle, WM_KEYDOWN, VK_RETURN, 0);
          end;
        end;
    end;    
  end;
end;

procedure TCustomdxBarControl.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  P: TPoint;
  Item: TdxBarItemControl;
begin
  inherited;
  if SelectedItem <> nil then
  begin
    P := SmallPointToPoint(Message.Pos);
    if PtInRect(ClientRect, P) then
    begin
      Item := ItemAtPos(P);
      if Item = SelectedItem then
      begin
        if Item.HasWindow and not PtInRect(TdxBarWinControl(Item).WindowRect, P) then
        begin
          MapWindowPoints(Handle, TdxBarWinControl(Item).Handle, P, 1);
          SendMessage(TdxBarWinControl(Item).Handle,
            WM_LBUTTONDBLCLK, Message.Keys, MakeLParam(P.X, P.Y));
        end;
        if Item.WantsDblClick then
          DblClickOnItem(Item)
        else
          with TMessage(Message) do
            Result := SendMessage(Handle, WM_LBUTTONDOWN, wParam, lParam);
      end;
    end;
  end;
end;

procedure TCustomdxBarControl.WMLButtonDown(var Message: TWMLButtonDown);
var
  P: TPoint;
  Item: TdxBarItemControl;
begin
  if FIgnoreMouseClick or (ItemLinks.VisibleItemCount = 0) then Exit;

  inherited;
  P.X := Message.XPos;
  P.Y := Message.YPos;
  Item := nil;
  if PtInRect(ClientRect, P) then
  begin
    Item := ItemAtPos(P);
    if (Item <> nil) and
      (not IsCustomizing and (not Item.Enabled or not Item.WantMouse)) then
      Item := nil;
  end;
  if IsCustomizing then
    if (Item = nil) or Item.CanCustomize then {1}
    begin
      if not ((Item = nil) and PtInRect(ClientRect, P)) then
      begin
        if (Item <> nil) and (Item = SelectedItem) then
        begin
          if Item.IsActive then
            Item.ControlInactivate(True)
          else
            Item.ControlActivate(True);
          BarManager.SelectedItem := Item;
          Item.Repaint;
        end;
        SetMouseSelectedItem(Item);
      end;

      if Item <> nil then
      begin
        FDragPoint := P;
        BarManager.FDraggingItem := Item.ItemLink.Item;
        BarManager.FDraggingItemLink := Item.ItemLink;
        FDragDown := True;
        SetCapture(Handle);
      end;
    end
    else
  else
    if (Item <> nil) and Item.Enabled then
    begin
      SetKeySelectedItem(Item);
      if FSelectedItem is TdxBarButtonControl then
        TdxBarButtonControl(FSelectedItem).FShowAnimation := True;
      if FSelectedItem is TdxBarSubItemControl then
        TdxBarSubItemControl(FSelectedItem).FShowAnimation := True;
      Item.ControlClick(True);
      if not ItemExists(Item) then Exit;
      if FSelectedItem is TdxBarButtonControl then
        TdxBarButtonControl(FSelectedItem).FShowAnimation := False;
      if (Self is TdxBarControl) and
        (FSelectedItem <> nil) and FSelectedItem.NeedCaptureMouse then
      begin
        FClickedControl := Item;
        FMouseOverClickedControl := True;
        SetCapture(Handle);
        Item.Repaint;
      end;
      if Item.HasWindow and not PtInRect(TdxBarWinControl(Item).WindowRect, P) then
      begin
        MapWindowPoints(Handle, TdxBarWinControl(Item).Handle, P, 1);
        SendMessage(TdxBarWinControl(Item).Handle,
          WM_LBUTTONDOWN, Message.Keys, MakeLParam(P.X, P.Y));
      end;
    end;
end;

procedure TCustomdxBarControl.WMLButtonUp(var Message: TWMLButtonUp);
var
  P: TPoint;
  Item, AClickedControl: TdxBarItemControl;
begin
  if FIgnoreMouseClick then
  begin
    FIgnoreMouseClick := False;
    Exit;
  end;

  inherited;
  if FDragDown then
    ReleaseCapture
  else
  begin
    P.X := Message.XPos;
    P.Y := Message.YPos;
    AClickedControl := FClickedControl;
    if AClickedControl <> nil then ReleaseCapture;
    if PtInRect(ClientRect, P) and IsActive then
    begin
      Item := ItemAtPos(P);
      if not IsCustomizing and (Item <> nil) and Item.WantMouse then
        if Item.Enabled and (Item = SelectedItem) then
        begin
          if Item.HasWindow then
          begin
            MapWindowPoints(Handle, TdxBarWinControl(Item).Handle, P, 1);
            SendMessage(TdxBarWinControl(Item).Handle,
              WM_LBUTTONUP, Message.Keys, MakeLParam(P.X, P.Y));
          end;
          Item.ControlUnclick(True);
        end
        else
          if not Item.Enabled and (Item <> SelectedItem) and (Self is TdxBarControl) and
            not ((SelectedItem is TdxBarButtonControl) and
                 TdxBarButtonControl(SelectedItem).DroppedDown) then
            TdxBarControl(Self).HideAll;//BarLostFocus;
    end;
    if (AClickedControl <> nil) and BarControlExists(Self) then
      HideAll;
  end;
end;

procedure TCustomdxBarControl.WMMouseActivate(var Message: TWMMouseActivate);
begin
  inherited;
  Message.Result := MA_NOACTIVATE;
end;

procedure TCustomdxBarControl.WMMouseLeave(var Message: TMessage);
begin
  if MarkState = msSelected then MarkState := msNone;
  inherited;
  if (ChildBar = nil) and not IsCustomizing and
    not ((SelectedItem is TdxBarButtonControl) and
     TdxBarButtonControl(SelectedItem).DroppedDown) then
    SetMouseSelectedItem(nil);
end;

procedure TCustomdxBarControl.WMMouseMove(var Message: TWMMouseMove);
const
  dXY = 2;
var
  P: TPoint;
  Item: TdxBarItemControl;
  PrevMouseOverClickedControl, FocusedControlExists: Boolean;

  function WantClientMouse: Boolean;
  begin
    Result := PtInRect(ClientRect, SmallPointToPoint(Message.Pos));
  end;

  function DragRect: TRect;
  begin
    Result := Bounds(0, 0, GetSystemMetrics(SM_CXDRAG), GetSystemMetrics(SM_CYDRAG));
    with Result, FDragPoint do
      OffsetRect(Result, X - Right div 2, Y - Bottom div 2);
  end;

begin
  if FDestroyFlag then Exit;

  with Message do P := Point(XPos, YPos);

  if FClickedControl <> nil then
  begin
    Item := ItemAtPos(P);
    PrevMouseOverClickedControl := FMouseOverClickedControl;
    FMouseOverClickedControl := Item = FClickedControl;
    if FMouseOverClickedControl <> PrevMouseOverClickedControl then
      FClickedControl.Repaint;
  end;

  if FDragDown and not PtInRect(DragRect, P) then
  begin
    FDragDown := False;
    ReleaseCapture;
    with BarManager do
    begin
      DraggingItemLink.Control.ControlInactivate(True);
      DragAndDrop(DraggingItem, DraggingItemLink);
    end;
    Exit;
  end;

  if WantClientMouse then
  begin
    inherited;
    if NotHandleMouseMove(P) then Exit;
    FLastMousePos := P;
    Windows.ClientToScreen(Handle, FLastMousePos);
    Item := ItemAtPos(P);

    FocusedControlExists := (BarManager.SelectedItem <> nil) and
      (BarManager.SelectedItem is TdxBarWinControl) and
      TdxBarWinControl(BarManager.SelectedItem).Focused;

    if (ActiveBarControl = nil) or (ActiveBarControl = Self) then
      if (Item <> nil) and (Item is TdxBarWinControl) and
        PtInRect(TdxBarWinControl(Item).WindowRect, P) and
        (not FocusedControlExists or (Item = BarManager.SelectedItem)) then
        Cursor := crIBeam
      else
        Cursor := crDefault;

    if FocusedControlExists then Exit;

    if not MouseTracking(Handle) then
    begin
      StartMouseTracking(Handle);
      if (Item <> nil) and (Item = SelectedItem) and (Item is TdxBarButtonControl) then
        Item.Repaint;
    end;

    if (Item <> nil) and not Item.CanMouseSelect then Item := nil;
    if (Self is TdxBarControl) and IsActive and (Item = nil) then Exit;
    if FClickedControl <> nil then Exit;

    if not ((Item = nil) and (SelectedItem <> nil) and
      (SelectedItem is TdxBarSubItemControl) and
      (TdxBarSubItemControl(SelectedItem).SubMenuControl <> nil)) then
      SetMouseSelectedItem(Item);
  end;
end;

procedure TCustomdxBarControl.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  if CanCallInheritedNCCalcSize then inherited;
end;

procedure TCustomdxBarControl.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if CanFinishMouseTracking(Message) then FinishMouseTracking(Handle);
end;

procedure TCustomdxBarControl.WMRButtonDown(var Message: TWMRButtonDown);
var
  P: TPoint;
  Item: TdxBarItemControl;
begin
  inherited;
  if not IsCustomizing then Exit;
  if SelectedItem <> nil then SelectedItem.ControlInactivate(True);
  P.X := Message.XPos;
  P.Y := Message.YPos;
  Item := nil;
  if PtInRect(ClientRect, P) then Item := ItemAtPos(P);
  if Item <> nil then
  begin
    if Item = SelectedItem then
    begin
      BarManager.SelectedItem := Item;
      Item.Repaint;
    end;
    SetKeySelectedItem(Item);
    P := ClientToScreen(P);
    CustomizedPopup := TdxBarCustomizingPopup.Create(BarManager);
    with CustomizedPopup do
    begin
      Left := P.X;
      Top := P.Y;
      ItemLink := Item.ItemLink;
      Show;
    end;
  end;
end;

procedure TCustomdxBarControl.WMRepaintBar(var Message: TMessage);
begin
  RepaintBar;
end;

procedure TCustomdxBarControl.WMSetCursor(var Message: TWMSetCursor);
begin
  with Message do
    if (HitTest = HTCLIENT) and (CursorWnd = Handle)  then
    begin
      Windows.SetCursor(Screen.Cursors[Cursor]);
      Result := 1;
    end
    else
      inherited;
end;

procedure TCustomdxBarControl.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  with Message.WindowPos^ do
    if (flags and SWP_NOSIZE = 0) or (flags and SWP_NOMOVE = 0) then
      ResizeShadow;
  FShadow.Visible := IsShadowVisible;
end;

{$IFDEF DELPHI4}
procedure TCustomdxBarControl.AdjustSize;
begin
  // do nothing
end;
{$ENDIF}

procedure TCustomdxBarControl.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  CreateControls;
end;

procedure TCustomdxBarControl.CreateWnd;
begin
  inherited;
  SetFont;
  CalcDrawingConsts;
end;

procedure TCustomdxBarControl.DestroyWindowHandle;
begin
  if WindowHandle <> 0 then BeforeDestroyHandle;
  DestroyControls;
  inherited;
end;

procedure TCustomdxBarControl.CreateControls;
var
  I: Integer;
begin
  if FItemLinks <> nil then
    for I := 0 to FItemLinks.CanVisibleItemCount - 1 do
      FItemLinks.CanVisibleItems[I].CreateControl;
end;

procedure TCustomdxBarControl.DestroyControls;
var
  I: Integer;
  PrevDestroyFlag: Boolean;
begin
  if FItemLinks <> nil then
  begin
    PrevDestroyFlag := FDestroyFlag;
    FDestroyFlag := True;
    for I := 0 to FItemLinks.CanVisibleItemCount - 1 do
      FItemLinks.CanVisibleItems[I].DestroyControl;
    FDestroyFlag := PrevDestroyFlag;
  end;
end;

procedure TCustomdxBarControl.WndProc(var Message: TMessage);

  function ProcessMouseMessage: Boolean;
  var
    AControl: TCustomdxBarControl;
  begin
    Result := True;
    AControl := ActiveBarControl;
    while AControl <> nil do
    begin
      if AControl = Self then Exit;
      AControl := AControl.ParentBar;
    end;  
    Result := False;
  end;

begin
  if Message.Msg = WM_CTLCOLOREDIT then
  begin
    SetTextColor(Message.wParam, GetSysColor(COLOR_WINDOWTEXT));
    SetBkColor(Message.wParam, GetSysColor(COLOR_WINDOW));
    Message.Result := GetSysColorBrush(COLOR_WINDOW);
    Exit;
  end;

  if (Message.Msg = WM_KILLFOCUS) and (Message.wParam = 0) then
  begin
    inherited;
    HideAll;
    Exit;
  end;

  if Message.Msg = WM_NCACTIVATE then
  begin
    if (Message.wParam = Longint(True)) and not BarManager.IsCustomizing then
      SendMessage(GetParent(Handle), WM_NCACTIVATE, Longint(True), 0);
    Message.wParam := Longint(True);
  end;

  if (Message.Msg = WM_SETFOCUS) and not (SelectedItem is TdxBarWinControl) then
  begin
    if IsCustomizing and (dxBarCustomizingForm <> nil) then
    begin
      SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0,
        SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
      Windows.SetFocus(dxBarCustomizingForm.Handle);
      SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0,
        SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
    end
    else             
      if IsWindowVisible(BarManager.MainForm.Handle) then
        Windows.SetFocus(BarManager.MainForm.Handle)
      else
        Windows.SetFocus(GetNextWindow(BarManager.MainForm.Handle, GW_HWNDNEXT));
    Exit;
  end;

  with Message do
    if ((Msg >= WM_MOUSEFIRST) and (Msg <= WM_MOUSELAST) or
        (Msg >= WM_NCMOUSEMOVE) and (Msg <= WM_NCMBUTTONDBLCLK)) and
      (ActiveBarControl <> nil) and not ProcessMouseMessage then
      Exit;

  inherited;
  with Message do
    case Msg of
      WM_COMMAND:
        if (Result = 0) and (HiWord(wParam) = EN_CHANGE) and (lParam <> 0) then
          Result := SendMessage(lParam, Msg, wParam, lParam);
    end;
end;

procedure TCustomdxBarControl.BeforeDestroyHandle;
var
  I: Integer;
begin
  for I := 0 to ItemLinks.CanVisibleItemCount - 1 do
    with ItemLinks.CanVisibleItems[I] do
      if Control <> nil then Control.BeforeDestroyParentHandle;
end;

procedure TCustomdxBarControl.CalcDrawingConsts;
var
  l_Size: TSize;
  DC: HDC;
  PrevFont: HFONT;
begin
  GetTextExtentPoint32(Canvas.Handle, '0', 1, l_Size);
  FTextSize := l_Size.cY + 6;

  FMenuArrowHeight := FTextSize div 5;
  if FMenuArrowHeight < 4 then FMenuArrowHeight := 4;

  DC := GetDC(0);
  PrevFont := SelectObject(DC, EditFontHandle);
  GetTextExtentPoint32(DC, '0', 1, l_Size);
  SelectObject(DC, PrevFont);
  ReleaseDC(0, DC);
  FEditTextSize := l_Size.cY + 6 + Byte(Flat);
  FComboBoxArrowWidth := 2 * l_Size.cX - 1;
end;

function TCustomdxBarControl.CanAlignControl(AControl: TdxBarItemControl): Boolean;
begin
  Result := False;
end;

function TCustomdxBarControl.CanCallInheritedNCCalcSize: Boolean;
begin
  Result := True;
end;

function TCustomdxBarControl.CanCustomizing: Boolean;
begin
  Result := BarManager.Designing;
end;

function TCustomdxBarControl.CanFinishMouseTracking(const Message: TWMNCHitTest): Boolean;
begin
  Result := Message.Result <> HTCLIENT;
end;

function TCustomdxBarControl.ChildrenHaveShadows: Boolean;
begin
  Result := Flat;
end;

procedure TCustomdxBarControl.DblClickOnItem(Item: TdxBarItemControl);
begin
  if BarManager.Designing then
    dxBarDesigner.ShowDefaultEventHandler(Item.Item)
  else
    if Item.IsExpandable then
      with TCustomdxBarSubItem(Item.Item).ItemLinks do
        if (BarControl <> nil) and BarControl.MarkExists then
          BarControl.MarkState := msPressed
        else
    else
      Item.DblClick;
end;

procedure TCustomdxBarControl.DrawBarControlOwner(DC: HDC; R: TRect;
  ABarControl: TCustomdxBarControl);
begin
  DrawBarControlOwnerBorder(DC, R, ABarControl);
  InflateRect(R, -1, -1);
  FillRect(DC, R, BarControlOwnerBrush);
end;

procedure TCustomdxBarControl.DrawBarControlOwnerBorder(DC: HDC; R: TRect;
  ABarControl: TCustomdxBarControl);
var
  AClipRgn: HRGN;
  AClipRgnExists: Boolean;

  procedure DrawBarControlOwnerLink;
  var
    ALinkR: TRect;
    AOrigin: TPoint;
  begin
    AClipRgn := 0;
    if not ABarControl.HandleAllocated then Exit;
    ALinkR := ABarControl.OwnerLinkBounds[True];
    GetDCOrgEx(DC, AOrigin);
    OffsetRect(ALinkR, -AOrigin.X, -AOrigin.Y);
    FillRect(DC, ALinkR, BarControlOwnerBrush);

    AClipRgn := CreateRectRgn(0, 0, 0, 0);
    AClipRgnExists := GetClipRgn(DC, AClipRgn) = 1;
    with ALinkR do
      ExcludeClipRect(DC, Left, Top, Right, Bottom);
  end;

begin
  DrawBarControlOwnerLink;
  FrameRect(DC, R, BarManager.FlatToolbarsBorderBrush);
  if AClipRgn <> 0 then
  begin
    if AClipRgnExists then
      SelectClipRgn(DC, AClipRgn)
    else
      SelectClipRgn(DC, 0);
    DeleteObject(AClipRgn);
  end;
end;

procedure TCustomdxBarControl.DrawOwnerLink(DC: HDC);
begin
  if not IsRectEmpty(OwnerLinkBounds[False]) then
    FillRect(DC, OwnerLinkBounds[False], BarControlOwnerBrush);
end;

procedure TCustomdxBarControl.DrawSelectedItem(AControl: TdxBarItemControl);
var
  R: TRect;
begin
  if IsCustomizing and
    (not BarManager.Dragging and (SelectedItem = AControl) and (BarManager.SelectedItem = AControl) or
     BarManager.Dragging and (AControl.ItemLink = BarManager.DraggingItemLink)) then
    with Canvas, R do
    begin
      R := AControl.ItemLink.ItemRect;
      if (AControl is TdxBarSubItemControl) and (Self is TdxBarSubMenuControl) then
      begin
        Dec(Right);
        Dec(Bottom);
        Pen.Mode := pmNot;
        Polyline([Point(Left, Top), Point(Right, Top), Point(Right, Bottom),
          Point(Left, Bottom),  Point(Left, Top)]);
        InflateRect(R, -1, -1);
        Polyline([Point(Left, Top), Point(Right, Top), Point(Right, Bottom),
          Point(Left, Bottom),  Point(Left, Top)]);
        Pen.Mode := pmCopy;
      end
      else
      begin
        Windows.FrameRect(Handle, R, GetSysColorBrush(COLOR_WINDOWTEXT));
        InflateRect(R, -1, -1);
        Windows.FrameRect(Handle, R, GetSysColorBrush(COLOR_WINDOWTEXT));
      end;
    end;
end;

function TCustomdxBarControl.GetEditFontHandle: HFONT;
begin
  Result := BarManager.FEditFontHandle;
end;

function TCustomdxBarControl.GetFullItemRect(Item: TdxBarItemControl): TRect;
begin
  Result := GetItemRect(Item);
end;

function TCustomdxBarControl.GetIsCustomizing;
begin
  Result := BarManager.IsCustomizing;
end;

function TCustomdxBarControl.GetIsShadowVisible: Boolean;
begin
  Result := HasShadow and IsWindowVisible(Handle);
end;

function TCustomdxBarControl.GetItemRect(Item: TdxBarItemControl): TRect;
begin
  if Item = nil then SetRectEmpty(Result)
  else
    Result := Item.ItemLink.ItemRect;
end;

function TCustomdxBarControl.GetItemRectEx(Item: TdxBarItemControl;
  IsBeginGroup: Boolean): TRect;
begin
  Result := GetItemRect(Item);
end;

function TCustomdxBarControl.GetItemRegion(Item: TdxBarItemControl): HRGN;
begin
  Result := CreateRectRgnIndirect(GetItemRectEx(Item, True));
end;

function TCustomdxBarControl.GetItemScreenRect(Item: TdxBarItemControl): TRect;
begin
  Result := GetItemRect(Item);
  MapWindowPoints(Handle, 0, Result, 2);
end;

function TCustomdxBarControl.GetToolbarBrush: HBRUSH;
begin
  if Flat then
    Result := BarManager.FlatToolbarsBrush
  else
    Result := GetSysColorBrush(COLOR_BTNFACE);
end;

function TCustomdxBarControl.GetToolbarDownedBrush: HBRUSH;
begin
  if Flat then
    Result := BarManager.FlatToolbarsDownedBrush
  else
    Result := PatternBrush;
end;

function TCustomdxBarControl.GetToolbarDownedSelBrush: HBRUSH;
begin
  if Flat then
    Result := BarManager.FlatToolbarsDownedSelBrush
  else
    Result := GetSysColorBrush(COLOR_BTNFACE);
end;

function TCustomdxBarControl.GetToolbarSelBrush: HBRUSH;
begin
  if Flat then
    Result := BarManager.FlatToolbarsSelBrush
  else
    Result := GetSysColorBrush(COLOR_HIGHLIGHT);
end;

procedure TCustomdxBarControl.GetWindowRect(var R: TRect);
begin
  Windows.GetWindowRect(Handle, R);
end;

function TCustomdxBarControl.HasShadow: Boolean;
begin
  Result := Flat and (DockingStyle = dsNone);
end;

function TCustomdxBarControl.HideOnClick: Boolean;
begin
  Result := False;
end;

function TCustomdxBarControl.IsChildBar(Value: TCustomdxBarControl): Boolean;
begin
  Result := False;
  while Value.ParentBar <> nil do
  begin
    Value := Value.ParentBar;
    if Self = Value then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TCustomdxBarControl.IsLinkedToOwner: Boolean;
var
  R1, R2: TRect;
begin
  R1 := FOwnerBounds;
  R2 := BoundsRect;
  Result :=
    ((R1.Bottom = R2.Top) or (R1.Top = R2.Bottom)) and
    (R1.Left < R2.Right) and (R1.Right > R2.Left) or
    ((R1.Right = R2.Left) or (R1.Left = R2.Right)) and
    (R1.Top < R2.Bottom) and (R1.Bottom > R2.Top);
end;

function TCustomdxBarControl.ItemAtPos(Pos: TPoint): TdxBarItemControl;
var
  I: Integer;
  ItemLink: TdxBarItemLink;
begin
  if IsCustomizing and not CanCustomizing then
    Result := nil
  else
  begin
    Result := nil;
    for I := 0 to ItemLinks.VisibleItemCount - 1 do
    begin
      ItemLink := ItemLinks.VisibleItems[I];
      if PtInRect(ItemLink.ItemRect, Pos) then
      begin
        //if ItemLink.Control.CanSelect then  {1}
          Result := ItemLink.Control;
        Break;
      end;
    end;
  end;
end;

function TCustomdxBarControl.ItemAtPosEx(Pos: TPoint;
  var IsBeginGroup, IsFirstPart, IsVerticalDirection: Boolean): TdxBarItemControl;
var
  CalcVerticalDirection: Boolean;
  I: Integer;
  Control: TdxBarItemControl;
  Rgn: HRGN;
  R: TRect;
begin
  Result := nil;
  IsVerticalDirection :=
    IsRealVertical(Self) or (Self is TdxBarSubMenuControl);
  CalcVerticalDirection := IsVerticalDirection;
  for I := 0 to FItemLinks.VisibleItemCount - 1 do
  begin
    Control := FItemLinks.VisibleItems[I].Control;
    if Control.CanCustomize then
    begin
      Rgn := GetItemRegion(Control);
      if PtInRegion(Rgn, Pos.X, Pos.Y) then
      begin
        Result := Control;
        R := GetFullItemRect(Result);
        IsBeginGroup := not PtInRect(R, Pos);
        if IsBeginGroup then
        begin
          if Pos.Y < R.Top then CalcVerticalDirection := True;
          R := Result.FBeginGroupRect;
        end;
        if CalcVerticalDirection then
          IsFirstPart := (Pos.Y - R.Top) < (R.Bottom - Pos.Y)
        else
          IsFirstPart := (Pos.X - R.Left) < (R.Right - Pos.X);
        DeleteObject(Rgn);
        Break;
      end;
      DeleteObject(Rgn);
    end;
  end;
end;

function TCustomdxBarControl.ItemExists(Item: TdxBarItemControl): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to ItemLinks.Count - 1 do
    if ItemLinks[I].Control = Item then Exit;
  Result := False;
end;

function TCustomdxBarControl.MarkExists: Boolean;
begin
  Result := False;
end;

function TCustomdxBarControl.NotHandleMouseMove(P: TPoint): Boolean;
begin
  Windows.ClientToScreen(Handle, P);
  Result := IsCustomizing or (FLastMousePos.X = P.X) and (FLastMousePos.Y = P.Y);
end;

procedure TCustomdxBarControl.PaintItem(AControl: TdxBarItemControl);
begin
  FBkBrush := ToolbarBrush;
end;

procedure TCustomdxBarControl.PaintSelectedItem(OldSelectedItem: TdxBarItemControl);
begin
  if FDestroyFlag then Exit;
  if (OldSelectedItem <> nil) and (OldSelectedItem.ItemLink.Item <> nil) and
    not OldSelectedItem.ItemLink.Item.IsDestroying then
    PaintItem(OldSelectedItem);
  if FSelectedItem <> nil then PaintItem(FSelectedItem);
end;

procedure TCustomdxBarControl.ResizeShadow;
var
  R: TRect;
begin
  if IsLinkedToOwner then
    R := FOwnerBounds
  else
    SetRectEmpty(R);
  FShadow.SetOwnerBounds(R, BoundsRect);
end;

procedure TCustomdxBarControl.SetIsActive(Value: Boolean);
begin
  BarManager.HintActivate(False, '');
  if FIsActive <> Value then
  begin
    FIsActive := Value;
    if FIsActive then
    begin
      if FActiveBarControl = nil then ShowFullMenus := IsCustomizing;
      FPrevActiveBarControl := FActiveBarControl;
      FActiveBarControl := Self;
    {$IFDEF DELPHI4}
      if not IsCustomizing then ItemLinks.InitiateActions;
    {$ENDIF}
    end
    else
    begin
      if IsCustomizing then
        FSelectedItem := nil
      else
        SetKeySelectedItem(nil);
      if FActiveBarControl = Self then
        FActiveBarControl := FPrevActiveBarControl;
      if (FActiveBarControl <> nil) and
        (not BarControlExists(FActiveBarControl) or not FActiveBarControl.IsActive) then
        FActiveBarControl := nil;
    end;
  end;
end;

function TCustomdxBarControl.SelectedItemWantsKey(Key: Word): Boolean;
begin
  Result := (SelectedItem <> nil) and SelectedItem.Enabled and
    SelectedItem.WantsKey(Key);
  if Result then SelectedItem.KeyDown(Key);
end;

procedure TCustomdxBarControl.SetCursorForMoving(AMoving: Boolean);
const
  Cursors: array[Boolean] of TCursor = (crDefault, crSizeAll);
begin
  Cursor := Cursors[AMoving];
end;

procedure TCustomdxBarControl.SetDockingStyle(Value: TdxBarDockingStyle);
begin
  if FDockingStyle <> Value then
  begin
    FDockingStyle := Value;
    Perform(CM_FONTCHANGED, 0, 0);
  end;
end;

procedure TCustomdxBarControl.SetKeySelectedItem(Value: TdxBarItemControl);
begin
  if FSelectedItem <> Value then
  begin
    if (FSelectedItem <> nil) and FSelectedItem.IsActive then
      FSelectedItem.ControlInactivate(True);
    if not BarControlExists(Self) then Exit; 
    if Value is TdxBarSubItemControl then
      TdxBarSubItemControl(Value).FShowAnimation := False;
    if Value <> nil then Value.FSelectedByMouse := False;
    SelectedItem := Value;
  end;
end;

procedure TCustomdxBarControl.SetMouseSelectedItem(Value: TdxBarItemControl);
begin
  if not HandleAllocated then Exit;
  if (FSelectedItem <> Value) and not ((FSelectedItem <> nil) and
    FSelectedItem.HasWindow and TdxBarWinControl(FSelectedItem).Focused) then
  begin
    if (FSelectedItem <> nil) and FSelectedItem.IsActive then
      FSelectedItem.ControlInactivate(False);
    if Value <> nil then Value.FSelectedByMouse := True;
    SelectedItem := Value;
    if not BarControlExists(Self) then Exit;
    if FSelectedItem <> nil then
    begin
      if FSelectedItem is TdxBarSubItemControl then
        with TCustomdxBarSubItem(FSelectedItem.ItemLink.Item) do
          if BarManager.Dragging and not CanContainItem(BarManager.DraggingItem) then
            Exit
          else
            TdxBarSubItemControl(FSelectedItem).FShowAnimation := True;
      FSelectedItem.ControlActivate(False);
    end;
  end;
end;

procedure TCustomdxBarControl.SetSelectedItem(Value: TdxBarItemControl);
var
  OldSelectedItem: TdxBarItemControl;
  AParentBar: TCustomdxBarControl;
begin
  if FSelectedItem <> Value then
  begin
    if (QuickCustBar <> nil) and not QuickCustBar.IsActive and
      (QuickCustBar <> Self) and (Value <> nil) then
      StartHideQuickCustBar;
    OldSelectedItem := FSelectedItem;
    FSelectedItem := Value;
    if IsCustomizing then
    begin
      BarManager.SelectedItem := Value;
      if not BarControlExists(Self) then Exit;
    end
    else
      if not BarManager.IsCustomizing then
        BarManager.FSelectedItem := Value;
    PaintSelectedItem(OldSelectedItem);
    GetCursorPos(FLastMousePos);
    if FSelectedItem = nil then Cursor := crDefault;
    if (FSelectedItem <> nil) or
      (Self is TdxBarSubMenuControl) or (TdxBarControl(Self).MarkState = msNone) then
      BarManager.HintActivate(True, '');
    // for Application.Hint:
    if (FSelectedItem <> nil) and
      (FSelectedItem.Enabled or BarManager.ShowHintForDisabledItems) then
      Hint := GetLongHint(FSelectedItem.Hint)
    else
      Hint := '';
    AParentBar := GetParentBarOrSubMenuForBar(Self);
    if (AParentBar is TdxBarSubMenuControl) and
      (AParentBar.ItemLinks.Owner is TdxBarPopupMenu) and
      not TdxBarPopupMenu(AParentBar.ItemLinks.Owner).DontUseMessageLoop then
      Application.Hint := Hint;
  end;
end;

procedure TCustomdxBarControl.UpdateControlStyle;
begin
  if (BarManager.Style = bmsStandard) and not IsCustomizing then
    ControlStyle := ControlStyle - [csDoubleClicks]
  else
    ControlStyle := ControlStyle + [csDoubleClicks];
end;

function TCustomdxBarControl.WantMouse: Boolean;
var
  P: TPoint;
begin
  GetCursorPos(P);
  Result := WindowFromPointEx(P) = Handle;  
end;

procedure TCustomdxBarControl.HideAll;
begin
  IsActive := False;
  if not BarControlExists(Self) then Exit; 
  if ParentBar <> nil then ParentBar.HideAll;
end;

procedure TCustomdxBarControl.RepaintBar;
begin
end;

{ TdxDockCol }

constructor TdxDockCol.Create(ADockRow: TdxDockRow; ABarControl: TdxBarControl);
begin
  inherited Create;
  FDockRow := ADockRow;
  FBarControl := ABarControl;
end;

procedure TdxDockCol.AssignPosition;
begin
  with FBarControl do
    FPos := Point(Left, Top);
end;

{ TdxDockRow }

constructor TdxDockRow.Create(ADockControl: TdxDockControl);
begin
  inherited Create;
  FDockControl := ADockControl;
  FColList := TList.Create;
end;

destructor TdxDockRow.Destroy;
var
  I: Integer;
begin
  for I := ColCount - 1 downto 0 do
    Cols[I].Free;
  FColList.Free;
  inherited;
end;

function TdxDockRow.GetCol(Index: Integer): TdxDockCol;
begin
  Result := FColList[Index];
end;

function TdxDockRow.GetColCount: Integer;
begin
  Result := FColList.Count;
end;

{ TdxBarControl }

constructor TdxBarControl.CreateEx(AOwner: TComponent; ABar: TdxBar);
begin
  inherited Create(AOwner);
  FBar := ABar;
  FHasCaption := True;
end;

destructor TdxBarControl.Destroy;
begin
  Destroying;
  if (FBar <> nil) and (FBar.FBars <> nil) and (DockingStyle <> dsNone) then
    FBar.FBars.UnregFromDock(FDockingStyle, FDockControl, Self);
  if WindowHandle = 0 then
    DestroyControls
  else
    DestroyHandle;
  inherited Destroy;
end;

function TdxBarControl.GetCaptionBkColor: Integer;
const
  CaptionBkColors: array[Boolean] of Integer =
    (COLOR_ACTIVECAPTION, COLOR_INACTIVECAPTION);
begin
  Result := CaptionBkColors[Flat or not BarManager.MainFormActive];
end;

function TdxBarControl.GetHorizontal: Boolean;
begin
  Result := DockingStyle in [dsTop, dsBottom];
end;

function TdxBarControl.GetInternallyLocked: Boolean;
begin
  Result := FInternalLockCount <> 0;
end;

function TdxBarControl.GetMultiLine: Boolean;
begin
  Result := (DockingStyle = dsNone) or FBar.MultiLine;
end;

function TdxBarControl.GetVertical: Boolean;
begin
  Result := DockingStyle in [dsLeft, dsRight];
end;

procedure TdxBarControl.SetCloseButtonState(Value: TdxBarMarkState);
var
  DC: HDC;
begin
  if FCloseButtonState <> Value then
  begin
    FCloseButtonState := Value;
    if HandleAllocated then
    begin
      DC := GetWindowDC(Handle);
      DrawCloseButton(DC);
      ReleaseDC(Handle, DC);
    end;  
  end;
end;

procedure TdxBarControl.SetMoving(Value: Boolean);
var
  I: Integer;
  KillingHandle: HWND;
begin
  if FMoving <> Value then
  begin
    FMovingChanging := True;
    try
      FMoving := Value;
      if Value then
        FBar.Bars.FMovingBarControl := Self
      else
        FBar.Bars.FMovingBarControl := nil;
      SetCursorForMoving(Value);
      for I := 0 to ItemLinks.CanVisibleItemCount - 1 do
        if ItemLinks.CanVisibleItems[I].Control.HasWindow then
          with TdxBarWinControl(ItemLinks.CanVisibleItems[I].Control) do
            if FMoving then
              DestroyWindowHandle
            else
              CreateWindowHandle;
      if FMoving then
      begin
        if FDockingStyle = dsNone then
        begin
          FFloatingHandle := Handle;
          FDockingStyle := dsLeft;
          FDockControl := FBar.FBars.FDockControls[dsLeft];
          DestroyControls;
          WindowHandle := 0;
          CreateHandle;
          FDockedHandle := Handle;
          WindowHandle := 0;
          FDockingStyle := Bar.DockingStyle;
          FDockControl := nil;
          BeginInternal;
          try
            CreateHandle;
          finally
            EndInternal;
          end;
          Windows.SetParent(FDockedHandle, 0);
        end
        else
        begin
          FDockedHandle := Handle;
          FDockingStyle := dsNone;
          DestroyControls;
          WindowHandle := 0;
          CreateHandle;
          FFloatingHandle := Handle;
          WindowHandle := 0;
          FDockingStyle := Bar.DockingStyle;
          BeginInternal;
          try
            CreateHandle;
          finally
            EndInternal;
          end;
        end;
        // this code creates problems with other relative popups
//        SetWindowPos(FFloatingHandle, HWND_TOPMOST, 0, 0, 0, 0,
//          SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
      end
      else
      begin
        // this code makes top-most windows normal
        //SetWindowPos(FFloatingHandle, HWND_NOTOPMOST, 0, 0, 0, 0,
        //  SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
        if FDockingStyle = dsNone then
          KillingHandle := FDockedHandle
        else
          KillingHandle := FFloatingHandle;
        SetWindowLong(KillingHandle, GWL_WNDPROC, Longint(DefWndProc));
        DestroyWindow(KillingHandle);
        SavePos;
      end;
      Perform(WM_SIZE, 0, 0);  // to store normal size
      RepaintBar;
    finally
      FMovingChanging := False;
    end;
  end;
end;

procedure TdxBarControl.CalcControlsPositions;
var
  I, FirstInRow, X, Y, ARowHeight, ABeginGroupSize, l_Size, VerSize, AWidth, AHeight: Integer;
  AMultiLine, AVertical, ItemControlAlignApplied: Boolean;
  AItemLink: TdxBarItemLink;

  procedure InitValues;
  begin
    ItemLinks.EmptyItemRects;
    X := 0;
    Y := 0;
    VerSize := 0;
    AItemLink := nil;
    AMultiLine := MultiLine;
    AVertical := Vertical;

    if AMultiLine then
    begin
      if AVertical then
      begin
        l_Size := ClientHeight;
        VerSize := ClientWidth;
      end
      else
        l_Size := ClientWidth;
      if MarkExists and (DockingStyle <> dsNone) then
       Dec(l_Size, MarkSizeX);
      ARowHeight := 0;
      FirstInRow := 0;
    end
    else
      if AVertical then
      begin
        l_Size := ClientHeight - Byte(MarkExists) * MarkSizeX -
          Byte(MDIButtonsOnBar) * GetMDIHeight;
        ARowHeight := ClientWidth;
      end
      else
      begin
        l_Size := ClientWidth - Byte(MarkExists) * MarkSizeX -
          Byte(MDIButtonsOnBar) * GetMDIWidth;
        ARowHeight := ClientHeight;
      end;
  end;

  procedure InitItemControlValues;
  begin
    with AItemLink.Control do
    begin
      FLastInRow := False;
      if AVertical then
      begin
        AWidth := Height;
        AHeight := Width;
      end
      else
      begin
        AWidth := Width;
        AHeight := Height;
      end;
    end;
    if AItemLink.BeginGroup and (X > 0) then
      ABeginGroupSize := BeginGroupSize
    else
      ABeginGroupSize := 0;
  end;

  function ItemControlBreaksRow: Boolean;
  begin
    Result :=
      (X > 0) and (X + ABeginGroupSize + AWidth > l_Size) or
      AMultiLine and AItemLink.Control.FBreakingRow;
  end;

  procedure ArrangeControlsOnRow(const LastInRow: Integer);
  var
    I: Integer;
  begin
    for I := FirstInRow to LastInRow do
      with ItemLinks.VisibleItems[I], ItemRect do
      begin
        if AVertical then
          OffsetRect(FItemRect, -(ARowHeight - (Right - Left)) div 2, 0)
        else
          OffsetRect(FItemRect, 0, (ARowHeight - (Bottom - Top)) div 2);
        RowHeight := ARowHeight;
      end;
    FirstInRow := LastInRow + 1;
  end;

  function GetItemControlRect: TRect;

    procedure ApplyAlign;

      procedure CheckSize;
      var
        AMDISize: Integer;
      begin
        if AMultiLine and (AItemLink.Control.Align <> iaLeft) and MDIButtonsOnBar then
        begin
          if AVertical then
            AMDISize := GetMDIHeight
          else
            AMDISize := GetMDIWidth;
          if Result.Right + AMDISize <= l_Size then
            Dec(l_Size, AMDISize);
        end;
      end;

    begin
      CheckSize;
      ItemControlAlignApplied := True;
      case AItemLink.Control.Align of
        iaLeft:
          ItemControlAlignApplied := False;
        iaCenter:
          if AVertical then
            OffsetRect(Result, 0, (l_Size - Result.Bottom) div 2)
          else
            OffsetRect(Result, (l_Size - Result.Right) div 2, 0);
        iaRight:
          if AVertical then
            OffsetRect(Result, 0, l_Size - Result.Bottom)
          else
            OffsetRect(Result, l_Size - Result.Right, 0);
        iaClient:
          with Result do
            if AVertical then
            begin
              Bottom := l_Size;
              if Bottom - Top < AItemLink.Control.MinWidth then
                Bottom := Top + AItemLink.Control.MinWidth;
            end
            else
            begin
              Right := l_Size;
              if Right - Left < AItemLink.Control.MinWidth then
                Right := Left + AItemLink.Control.MinWidth;
            end;
      end;
    end;

  begin
    if AMultiLine then
      if AVertical then
        Result := Bounds(VerSize - Y - AHeight, X + ABeginGroupSize, AHeight, AWidth)
      else
        Result := Bounds(X + ABeginGroupSize, Y, AWidth, AHeight)
    else
      case DockingStyle of
        dsTop, dsBottom:
          Result :=
            Bounds(X + ABeginGroupSize, (ARowHeight - AHeight) div 2, AWidth, AHeight);
        dsLeft, dsRight:
          Result :=
            Bounds((ARowHeight - AHeight) div 2, X + ABeginGroupSize, AHeight, AWidth);
      end;
    ApplyAlign;
  end;

  procedure CalcX;
  begin
    if ItemControlAlignApplied then
    begin
      X := l_Size;
      if I < ItemLinks.VisibleItemCount - 1 then
        FTruncated := True;
    end
    else
      Inc(X, ABeginGroupSize + AWidth);
  end;

begin
  InitValues;
  for I := 0 to ItemLinks.VisibleItemCount - 1 do
  begin
    AItemLink := ItemLinks.VisibleItems[I];
    if AItemLink.Control = nil then AItemLink.CreateControl;
    InitItemControlValues;
    if ItemControlBreaksRow then
      if AMultiLine then
      begin
        ItemLinks.VisibleItems[I - 1].Control.FLastInRow := True;
        ArrangeControlsOnRow(I - 1);
        Inc(Y, ARowHeight + ABeginGroupSize);
        X := 0;
        ABeginGroupSize := 0;
        ARowHeight := 0;
      end
      else
      begin
        AItemLink := ItemLinks.VisibleItems[I - 1];
        Break;
      end;
    AItemLink.ItemRect := GetItemControlRect;
    AItemLink.RowHeight := ARowHeight;
    CalcX;
    if ARowHeight < AHeight then ARowHeight := AHeight;
  end;
  if AItemLink <> nil then
    AItemLink.Control.FLastInRow := True;
  if AMultiLine then
    ArrangeControlsOnRow(ItemLinks.VisibleItemCount - 1);
end;

procedure TdxBarControl.ChangeStyleWinTo(AStyle: TdxBarDockingStyle;
  ADockControl: TdxDockControl);
begin
  if (FBar = nil) or (FBar.FBars = nil) or IsDestroying then Exit;
  if FMoving then
  begin
    DockControl := ADockControl;
    DockingStyle := AStyle;
    WindowHandle := 0;
    BeginInternal;
    try
      CreateHandle;
    finally
      EndInternal;
    end;
    if FDockingStyle = dsNone then
      Windows.SetParent(FDockedHandle, 0)
    else
      Windows.SetParent(Handle, FDockControl.Handle);
    RepaintBar;
  end
  else
  begin
    BeginInternal;
    try
      DestroyHandle;
    finally
      EndInternal;
    end;
    DockControl := ADockControl;
    DockingStyle := AStyle;
    CreateHandle;
    FrameChanged;
  end;
end;

procedure TdxBarControl.DrawEditSizingFrame(AWidth: Integer);
var
  DC: HDC;
  R: TRect;
begin
  Inc(AWidth, TdxBarEditControl(SelectedItem).CaptionWidth);
  R := SelectedItem.ItemLink.ItemRect;
  DC := GetDC(0);
  if FRightBorderSizing then
    R.Right := R.Left + AWidth
  else
    R.Left := R.Right - AWidth;
  MapWindowPoints(Handle, 0, R, 2);
  with R do
  begin
    BitBlt(DC, Left, Top, Right - Left, 2, 0, 0, 0, DSTINVERT);
    BitBlt(DC, Left, Bottom - 2, Right - Left, 2, 0, 0, 0, DSTINVERT);
    BitBlt(DC, Left, Top + 2, 2, Bottom - Top - 4, 0, 0, 0, DSTINVERT);
    BitBlt(DC, Right - 2, Top + 2, 2, Bottom - Top - 4, 0, 0, 0, DSTINVERT);
  end;
  ReleaseDC(0, DC);
end;

function TdxBarControl.GetDragPointOffset(Style: TdxBarDockingStyle): TPoint;
begin
  if (Style <> dsNone) and (Self = Bar.Bars.FMovingBarControl) and
    (Style = Bar.Bars.FMovingBarOriginalDockingStyle) then
    with Bar.Bars do
      if Vertical then
        Result := Point(-FMovingOffset.X, FMovingStaticOffset.Y)
      else
        Result := Point(FMovingStaticOffset.X, -FMovingOffset.Y)
  else
    with GetTrackSize(Style) do
    begin
      Result.X := MulDiv(X, RX.X, RX.Y);
      Result.Y := MulDiv(Y, RY.X, RY.Y);
    end;
end;

function TdxBarControl.GetCaptionNCRect: TRect;
var
  NonClientMetrics: TNonClientMetrics;
begin
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0);
  GetWindowRect(Result);
  with Result do
  begin
    OffsetRect(Result, -Left, -Top);
    InflateRect(Result, -BarManager.BorderSizeX, -BarManager.BorderSizeY);
    Bottom := Top + NonClientMetrics.iSmCaptionHeight;
  end;
end;

function TdxBarControl.GetCaptionRect: TRect;
var
  R: TRect;
begin
  Result := GetCaptionNCRect;
  GetWindowRect(R);
  with R do
    OffsetRect(Result, Left, Top);
  MapWindowPoints(0, Handle, Result, 2);
end;

procedure TdxBarControl.DrawCaptionElement(DC: HDC; R: TRect; AState: TdxBarMarkState);
var
  ABrush: HBRUSH;
begin
  if AState <> msNone then
  begin
    FrameFlatSelRect(DC, R);
    InflateRect(R, -1, -1);
    if AState = msSelected then
      ABrush := ToolbarSelBrush
    else
      ABrush := ToolbarDownedSelBrush;
  end
  else
    ABrush := GetSysColorBrush(CaptionBkColor);
  FillRect(DC, R, ABrush);
end;

procedure TdxBarControl.DrawCloseButton(DC: HDC);
var
  R: TRect;

  procedure Draw3DButton;
  const
    Pushes: array[Boolean] of Integer = (0, DFCS_PUSHED);
  begin
    FrameRect(DC, R, GetSysColorBrush(CaptionBkColor));
    InflateRect(R, -1, -1);
    DrawFrameControl(DC, R, DFC_CAPTION,
      DFCS_CAPTIONCLOSE or Pushes[CloseButtonState = msPressed]);
  end;

  procedure DrawFlatButton;

    procedure DrawCross(var R: TRect);
    const
      CrossColors: array[Boolean] of Integer = (COLOR_CAPTIONTEXT, COLOR_BTNTEXT);
    var
      APen: HPEN;
    begin
      InflateRect(R, -3, -4);
      with R do
      begin
        if Odd(Right - Left) then Dec(Right);
        Bottom := Top + (Right - Left - 1);
      end;
      with R do
      begin
        APen := SelectObject(DC, CreatePen(PS_SOLID, 1,
          GetSysColor(CrossColors[CloseButtonState = msSelected])));

        MoveToEx(DC, Left, Top, nil);
        LineTo(DC, Right - 1, Bottom);
        MoveToEx(DC, Left + 1, Top, nil);
        LineTo(DC, Right, Bottom);

        MoveToEx(DC, Left, Bottom - 1, nil);
        LineTo(DC, Right - 1, Top - 1);
        MoveToEx(DC, Left + 1, Bottom - 1, nil);
        LineTo(DC, Right, Top - 1);

        DeleteObject(SelectObject(DC, APen));
      end;
    end;

  begin
    DrawCaptionElement(DC, R, CloseButtonState);
    DrawCross(R);
  end;

begin
  R := CloseButtonRectNC;
  if Flat then
    DrawFlatButton
  else
    Draw3DButton;
end;

procedure TdxBarControl.DrawMark(DC: HDC);
var
  MarkR: TRect;

  procedure DrawBackground;
  var
    R: TRect;
  begin
    if Bar.CanClose then
    begin
      R := MarkR;
      with R do
      begin
        Left := Right;
        Right := Left + FloatToolbarMarkIndent;
      end;
      FillRect(DC, R, CaptionBkColor + 1);
    end;
    if MarkState = msPressed then
      DrawBarControlOwner(DC, MarkR, FQuickPopup)
    else
      DrawCaptionElement(DC, MarkR, MarkState);
  end;

  function GetArrowColor: Integer;
  begin
    if Flat and (MarkState <> msNone) then
      Result := COLOR_BTNTEXT
    else
      Result := COLOR_CAPTIONTEXT;
  end;

  procedure DrawArrow;
  var
    P: array[1..3] of TPoint;
    ABrush: HBRUSH;
    APen: HPEN;
  begin
    with MarkR, P[1] do
    begin
      P[1] :=
        Point((Left + Right - MarkSizeArrowX) div 2,
              (Top + Bottom - MarkSizeArrowY) div 2 + (Top + Bottom - MarkSizeArrowY) mod 2);
      P[2] := Point(X + MarkSizeArrowX - 1, Y);
      P[3] := Point(X + MarkSizeArrowX div 2, Y + MarkSizeArrowY - 1);
    end;
    APen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(GetArrowColor)));
    ABrush := SelectObject(DC, GetSysColorBrush(GetArrowColor));
    Polygon(DC, P, 3);
    SelectObject(DC, ABrush);
    DeleteObject(SelectObject(DC, APen));
  end;

begin
  MarkR := MarkNCRect;
  if Flat then DrawBackground;
  DrawArrow;
end;

procedure TdxBarControl.DrawMDIButton(AButton: TdxBarMDIButton; APressed: Boolean);
const
  Enables: array[Boolean] of Integer = (DFCS_INACTIVE, 0);
  Borders: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  AFlat, ClipRgnExists: Boolean;
  R: TRect;
  DC: HDC;
  Rgn1, Rgn2: HRGN;
begin
  AFlat :=
    Flat or
    (AButton = mdibClose) and BarManager.FlatCloseButton and
    MDIButtonsOnBar and not RealMDIButtonsOnBar;
  R := RectMDI(AButton);
  DC := Canvas.Handle;
  Rgn1 := 0;
  ClipRgnExists := False;
  if AFlat then
  begin
    Rgn1 := CreateRectRgn(0, 0, 0, 0);
    ClipRgnExists := GetClipRgn(DC, Rgn1) = 1;
    InflateRect(R, -1, -1);
    Rgn2 := CreateRectRgnIndirect(R);
    SelectClipRgn(DC, Rgn2);
    DeleteObject(Rgn2);
    InflateRect(R, 1, 1);
  end;

  DrawFrameControl(DC, R, DFC_CAPTION,
    MDIButtonStyles[AButton] or Byte(APressed and not Flat) * DFCS_PUSHED or
    Byte(AFlat) * DFCS_FLAT or Enables[MDIButtonEnabled(AButton, MF_GRAYED)]);

  if AFlat then
  begin
    if ClipRgnExists then
      SelectClipRgn(DC, Rgn1)
    else
      SelectClipRgn(DC, 0);
    DeleteObject(Rgn1);
    if Flat then
      FrameRect(DC, R, ToolbarBrush)
    else
      DrawEdge(DC, R, Borders[APressed], BF_RECT);
  end;
end;

function TdxBarControl.GetMDIWidth: Integer;
begin
  if RealMDIButtonsOnBar then
    if IsRealVertical(Self) then
      Result := MDIButtonWidth
    else
      Result := 3 * MDIButtonWidth + 2
  else
    Result := MDIButtonWidth;
end;

function TdxBarControl.GetMDIHeight: Integer;
begin
  if RealMDIButtonsOnBar then
    if IsRealVertical(Self) then
      Result := 3 * MDIButtonHeight + 2
    else
      Result := MDIButtonHeight
  else
    Result := MDIButtonHeight;
end;

function TdxBarControl.RectMDI(Button: TdxBarMDIButton): TRect;
var
  AVertical: Boolean;
  AWidth, AHeight, W, H, MDISize, Offset: Integer;

  function MDIButtonsHaveOwnRow: Boolean;
  var
    I, L: Integer;
  begin
    Result := False;
    L := ItemLinks.VisibleItemCount - 1;
    for I := L downto 0 do
      with ItemLinks.VisibleItems[I] do
      begin
        if Control.FLastInRow and (I <> L) then
        begin
          Result := True;
          Break;
        end;
        if AVertical then
          if ItemRect.Left < Offset then Break
          else
        else
          if ItemRect.Bottom > Offset then Break;
        if I = 0 then Result := True;
      end;
  end;

begin
  SetRectEmpty(Result);

  AVertical := Vertical;
  if AVertical then
  begin
    AWidth := ClientHeight;
    AHeight := ClientWidth;
    W := MDIButtonHeight;
    H := MDIButtonWidth;
    MDISize := GetMDIHeight;
  end
  else
  begin
    AWidth := ClientWidth;
    AHeight := ClientHeight;
    W := MDIButtonWidth;
    H := MDIButtonHeight;
    MDISize := GetMDIWidth;
  end;
  if (DockingStyle <> dsNone) and MarkExists then Dec(AWidth, MarkSizeX);

  if MultiLine then
  begin
    if AVertical then
      Offset := H
    else
      Offset := AHeight - H;
    if not MDIButtonsHaveOwnRow then
      if ItemLinks.VisibleItemCount = 0 then
        Offset := (AHeight - H) div 2
      else
        Offset := AHeight -
          (ItemLinks.VisibleItems[ItemLinks.VisibleItemCount - 1].RowHeight - H) div 2 - H
    else
      if AVertical then Offset := AHeight - Offset;
  end
  else
    Offset := (AHeight - H) div 2;

  if RealMDIButtonsOnBar then
  begin
    Result := Bounds(AWidth - MDISize + W * Ord(Button), Offset, W, H);
    if Button = mdibClose then OffsetRect(Result, 2, 0);
  end
  else
    Result := Bounds(AWidth - W, Offset, W, H);
  if AVertical then
    with Result do
    begin
      W := Left;
      Left := AHeight - Bottom;
      Bottom := Right;
      Right := AHeight - Top;
      Top := W;
    end;
end;

function TdxBarControl.RealMDIButtonsOnBar: Boolean;
begin
  Result := (FBar <> nil) and FBar.IsMainMenu and BarManager.IsMDIMaximized and
    (GetSystemMenu(BarManager.ActiveMDIChild, False) <> 0);
end;

function TdxBarControl.MDIButtonsOnBar: Boolean;
begin
  Result := RealMDIButtonsOnBar or
    (FBar <> nil) and FBar.IsMainMenu and BarManager.ShowCloseButton;
end;

function TdxBarControl.MDIButtonEnabled(AButton: TdxBarMDIButton; State: Integer): Boolean;
begin
  Result :=
    (AButton = mdibRestore) or
    (AButton = mdibClose) and not RealMDIButtonsOnBar and MDIButtonsOnBar or
    (GetMenuState(GetSystemMenu(BarManager.ActiveMDIChild, False),
     MDIButtonCommands[AButton], MF_BYCOMMAND) and State = 0);
end;

procedure MoreButtonsHintTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT; Time: DWORD); stdcall;
var
  BarControl: TdxBarControl;
  P: TPoint;
begin
  BarControl := TdxBarControl(FindControl(Wnd));
  GetCursorPos(P);
  ScreenToClient(Wnd, P);
  with BarControl do
    if not IsWindowVisible(Handle) or not PtInRect(MarkRect, P) then
      FinishMoreButtonsHintTimer;
end;

procedure TdxBarControl.StartMoreButtonsHintTimer;
begin
  FMoreButtonsHintTimer := SetTimer(Handle, 1, 50, @MoreButtonsHintTimerProc);
end;

procedure TdxBarControl.FinishMoreButtonsHintTimer;
begin
  if FMoreButtonsHintTimer <> 0 then
  begin
    KillTimer(0, FMoreButtonsHintTimer);
    FMoreButtonsHintTimer := 0;
    if MarkState = msSelected then MarkState := msNone;
  end;
end;

procedure TdxBarControl.CheckMarkState(const P: TPoint);
begin
  if (BarManager.Style <> bmsStandard) and MarkExists and PtInRect(MarkRect, P) then
    if MarkState = msPressed then
      MarkState := msSelected
    else
      MarkState := msPressed;
end;

procedure TdxBarControl.WMCaptureChanged(var Message: TMessage);
begin
  inherited;
  if FEditSizingCursor then
  begin
    FEditSizingCursor := False;
    if FSizingEditWidth > 0 then
    begin
      DrawEditSizingFrame(FSizingEditWidth);
      if SelectedItem <> nil then SelectedItem.Repaint;
    end;
    FSizingEditWidth := 0;
  end;
end;

procedure TdxBarControl.WMDestroy(var Message: TMessage);
begin
  FinishMoreButtonsHintTimer;
  inherited;
  if (FBar <> nil) and not InternallyLocked and
    not (csDestroying in BarManager.MainForm.ComponentState) then
  begin
    with BarManager do
      if (FTempBarsList <> nil) and (FTempBarsList.IndexOf(FBar) = -1) then
        FTempBarsList.Add(FBar);
    FBar.Visible := False;
  end;
end;

procedure TdxBarControl.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS or DLGC_WANTTAB;
end;

procedure TdxBarControl.WMGetMinMaxInfo(var Message: TWMGetMinmaxInfo);
begin
  inherited;
  with Message.MinMaxInfo^ do
  begin
    ptMinTrackSize := Point(10, 10);
    ptMaxTrackSize := Point(30000, 30000);  // because of Win95/98
    ptMaxSize := ptMaxTrackSize;
    ptMaxPosition := ptMaxSize;
  end;
end;

procedure TdxBarControl.WMKeyDown(var Message: TWMKeyDown);
begin
  inherited;
  if (ActiveBarControl = nil) or SelectedItemWantsKey(Message.CharCode) then
    Exit;
  with Message do
    case CharCode of
      VK_ESCAPE:
        begin
          CharCode := 0;
          HideAll;
        end;
      VK_RETURN, VK_UP, VK_DOWN:
        begin
          if not IsDowned and (SelectedItem is TdxBarSubItemControl) and
            SelectedItem.Enabled then IsDowned := True;
          if (SelectedItem is TdxBarSubItemControl) or (CharCode = VK_RETURN) then
            SelectedItem.Click(False);
        end;
    end;
end;

procedure TdxBarControl.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  CheckMarkState(Point(Message.XPos, Message.YPos));
  inherited;
end;

procedure TdxBarControl.WMLButtonDown(var Message: TWMLButtonDown);
var
  P: TPoint;
  AButton: TdxBarMDIButton;
  Item: TdxBarItemControl;
  R: TRect;

  function CheckMDIButton(AButton: TdxBarMDIButton): Boolean;
  begin
    Result := PtInRect(RectMDI(AButton), P);
    if Result then
    begin
      FIsMDIButtonPressed := True;
      FIsMouseOverMDIButton := True;
      FPressedMDIButton := AButton;
      DrawMDIButton(AButton, True);
      SetCapture(Handle);
    end
  end;

begin
  if FIgnoreMouseClick then Exit;

  if not BarManager.HideFloatingBarsWhenInactive then
    SetActiveWindow(BarManager.MainForm.Handle);

  P := Point(Message.XPos, Message.YPos);

  Item := ItemAtPos(P);
  if (Item <> nil) and
    (Item.Enabled and Item.WantMouse or BarManager.Designing) then
    if IsCustomizing then
      if not IsActive then BarGetFocus(Item)
      else
    else
    begin
      if IsActive and
        ((Item <> SelectedItem) or ((Item is TdxBarWinControl) and
         not TdxBarWinControl(Item).Focused)) then
      begin
        IsDowned := False;
        SetKeySelectedItem(Item);
      end
      else
        if IsActive and (SelectedItem is TdxBarWinControl) and
          TdxBarWinControl(SelectedItem).Focused then
          with TdxBarWinControl(SelectedItem) do
          begin
            P := SmallPointToPoint(Message.Pos);
            if not PtInRect(WindowRect, P) then
            begin
              MapWindowPoints(Parent.Handle, Handle, P, 1);
              Message.Result := SendMessage(Handle, WM_LBUTTONDOWN,
                Message.Keys, MakeLParam(P.X, P.Y));
            end;
            Exit;
          end
        else
          if not (IsActive and ((Item is TdxBarButtonControl) or not IsDowned)) then
            if not IsActive then BarGetFocus(Item)
            else BarLostFocus;
      if IsActive and not Item.HasWindow then IsDowned := True;
    end
  else
    IsActive := False;

  if FEditSizingCursor then
  begin
    SetCapture(Handle);
    Exit;
  end;

  inherited;
  if not BarControlExists(Self) then Exit;

  if MDIButtonsOnBar and not BarManager.IsCustomizing then
    if RealMDIButtonsOnBar then
      for AButton := Low(TdxBarMDIButton) to High(TdxBarMDIButton) do
        if MDIButtonEnabled(AButton, MF_DISABLED or MF_GRAYED) and
          CheckMDIButton(AButton) then Exit
        else
    else
      if CheckMDIButton(mdibClose) then Exit;

  if FHitTest = HTCAPTION then
  begin
    P := SmallPointToPoint(Message.Pos);
    Windows.ClientToScreen(Handle, P);
    GetWindowRect(R);
    RX.X := P.X - R.Left;
    RY.X := P.Y - R.Top;
{    P := GetTrackSize(DockingStyle);
    RX.Y := P.X;
    RY.Y := P.Y;}
    RX.Y := R.Right - R.Left;
    RY.Y := R.Bottom - R.Top;
    FBar.Bars.Moving(Self);
  end
  else
  begin
    CheckMarkState(P);
    if not IsCustomizing and not PtInRect(ClientRect, P) then
    begin
      Windows.ClientToScreen(Handle, P);
      SendMessage(Handle, WM_NCLBUTTONDOWN, FHitTest, LPARAM(PointToSmallPoint(P)));
    end;
  end;
end;

procedure TdxBarControl.WMLButtonUp(var Message: TWMLButtonUp);
var
  P: TPoint;
  AButton: TdxBarMDIButton;
begin
  if FIgnoreMouseClick then
  begin
    FIgnoreMouseClick := False;
    Exit;
  end;

  if FEditSizingCursor then
  begin
    if FSizingEditWidth > 0 then
    begin
      DrawEditSizingFrame(FSizingEditWidth);
      with TdxBarEditControl(SelectedItem).ItemLink do
       if Width <> FSizingEditWidth then
         UserWidth := FSizingEditWidth
       else
         SelectedItem.Repaint;
      FSizingEditWidth := 0;
    end;
    ReleaseCapture;
    Exit;
  end;

  P := Point(Message.XPos, Message.YPos);
  if MDIButtonsOnBar and FIsMDIButtonPressed then
  begin
    ReleaseCapture;
    FIsMDIButtonPressed := False;
    if not RealMDIButtonsOnBar then
      if PtInRect(RectMDI(mdibClose), P) then
      begin
        Repaint;
        BarManager.DoCloseButtonClick;
      end
      else
    else
      for AButton := Low(TdxBarMDIButton) to High(TdxBarMDIButton) do
        if PtInRect(RectMDI(AButton), P) then
        begin
          Repaint;
          if AButton = FPressedMDIButton then
            SendMessage(BarManager.ActiveMDIChild, WM_SYSCOMMAND, MDIButtonCommands[AButton], 0);
          Break;
        end;
  end;
  inherited;
end;

procedure TdxBarControl.WMMouseActivate(var Message: TWMMouseActivate);
begin
  inherited;
  if not IsActive and (DockingStyle = dsNone) then
    SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0,
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
  //ProcessPaintMessages;
end;

procedure TdxBarControl.WMMouseLeave(var Message: TMessage);
begin
  if not IsActive then
  begin
    inherited;
    CloseButtonState := msNone;
  end
  else
    if SelectedItem is TdxBarButtonControl then SelectedItem.Repaint;
end;

procedure TdxBarControl.WMMouseMove(var Message: TWMMouseMove);
var
  PrevIsMouseOverMDIButton: Boolean;
  P: TPoint;
  R: TRect;
  PrevSizingEditWidth: Integer;
  ChangeMark: Boolean;
begin
  if FIsMDIButtonPressed then
    with Message do
    begin
      PrevIsMouseOverMDIButton := FIsMouseOverMDIButton;
      FIsMouseOverMDIButton := PtInRect(RectMDI(FPressedMDIButton), Point(XPos, YPos));
      if FIsMouseOverMDIButton <> PrevIsMouseOverMDIButton then
        DrawMDIButton(FPressedMDIButton, FIsMouseOverMDIButton);
    end
  else
  begin
    P := SmallPointToPoint(Message.Pos);
    
    if IsCustomizing and FEditSizingCursor and (GetCapture = Handle) then
    begin
      R := SelectedItem.ItemLink.ItemRect;

      PrevSizingEditWidth := FSizingEditWidth;
      if FRightBorderSizing then
        FSizingEditWidth := P.X - R.Left
      else
        FSizingEditWidth := R.Right - P.X;
      Dec(FSizingEditWidth, TdxBarEditControl(SelectedItem).CaptionWidth);
      CheckEditWidth(FSizingEditWidth);

      if FSizingEditWidth <> PrevSizingEditWidth then
      begin
        if PrevSizingEditWidth > 0 then
          DrawEditSizingFrame(PrevSizingEditWidth)
        else
          SelectedItem.Paint(GetItemRect(SelectedItem), ptHorz);
        DrawEditSizingFrame(FSizingEditWidth);
      end;
    end;

    ChangeMark := False;
    if not NotHandleMouseMove(P) and (ActiveBarControl = nil) then
    begin
      if (BarManager.Style <> bmsStandard) and MarkExists and (MarkState <> msPressed) then
        if PtInRect(MarkRect, P) then
          MarkState := msSelected
        else
          ChangeMark := True;
      if (DockingStyle = dsNone) and Bar.CanClose and (BarManager.Style = bmsFlat) then
        if PtInRect(CloseButtonRect, P) then
          if CloseButtonState <> msSelected then
          begin
            if not MouseTracking(Handle) then
              StartMouseTracking(Handle);
            CloseButtonState := msSelected;
          end
          else
        else
          CloseButtonState := msNone;
    end;      
    inherited;
    if ChangeMark then MarkState := msNone;
  end;
end;

procedure TdxBarControl.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  FHasSizeGrip := FBar.HasSizeGrip;
  if DockingStyle = dsNone then
  begin
    with BarManager do
      if Flat then
        InflateRect(Message.CalcSize_Params^.rgrc[0], -BorderSizeX, -BorderSizeY)
      {else
        inherited};
    if FHasCaption then
      with Message.CalcSize_Params^.rgrc[0] do
      begin
        Inc(Top, SMCaptionY);
        if not Flat then
        begin
          Inc(Left, dxBarHorSize);
          Dec(Right, dxBarHorSize);
          Inc(Top, dxBarTopSize);
          Dec(Bottom, dxBarBottomSize);
        end;
      end;
  end
  else
    if FBar.BorderStyle = bbsSingle then
      with Message.CalcSize_Params^ do
      begin
        InflateRect(rgrc[0], -2, -2);
        if Horizontal then
          Inc(rgrc[0].Left, BarManager.FingersSize)
        else
          Inc(rgrc[0].Top, BarManager.FingersSize);
      end
    else
    begin
      //inherited;
      if FBar.IsStatusBar then
        with Message.CalcSize_Params^.rgrc[0] do
        begin
          Inc(Top, 2);
          if FHasSizeGrip then
            Dec(Right, GetSystemMetrics(SM_CXHSCROLL));
        end;
    end;
end;

procedure TdxBarControl.WMNCHitTest(var Message: TWMNCHitTest);
var
  R: TRect;
  P: TPoint;
  AControl: TdxBarItemControl;
  NoControl: Boolean; 

  function MouseAboveMDIButtons: Boolean;
  begin
    Result := MDIButtonsOnBar and
      (RealMDIButtonsOnBar and
       (PtInRect(RectMDI(mdibMinimize), P) or PtInRect(RectMDI(mdibRestore), P)) or
       PtInRect(RectMDI(mdibClose), P));
  end;

begin
  inherited;
  FHitTest := 0;
  GetWindowRect(R);
  P := SmallPointToPoint(Message.Pos);
  Windows.ScreenToClient(Handle, P);
  with Message do
    if DockingStyle = dsNone then
      case Result of
        HTTOPLEFT, HTTOPRIGHT:
          if YPos < R.Top + BarManager.BorderSizeY then
          begin
            FHitTest := HTTOP;
            Result := HTTOP;
          end
          else
            if Result = HTTOPLEFT then
            begin
              FHitTest := HTLEFT;
              Result := HTLEFT;
            end
            else
            begin
              FHitTest := HTRIGHT;
              Result := HTRIGHT;
            end;
        HTBOTTOMLEFT, HTBOTTOMRIGHT:
          if YPos > R.Bottom - BarManager.BorderSizeY then
          begin
            FHitTest := HTBOTTOM;
            Result := HTBOTTOM;
          end
          else
            if Result = HTBOTTOMLEFT then
            begin
              FHitTest := HTLEFT;
              Result := HTLEFT;
            end
            else
            begin
              FHitTest := HTRIGHT;
              Result := HTRIGHT;
            end;
        HTCLIENT:
          begin
            AControl := ItemAtPos(P);
            if ((AControl = nil) or not IsCustomizing and not AControl.WantMouse) and
              not MouseAboveMDIButtons then
            begin
              FHitTest := HTCAPTION;
              Result := HTCLIENT;
            end;
          end;
        HTNOWHERE:
          begin
            if not IsCustomizing and MarkExists and PtInRect(MarkRect, P) then
              FHitTest := HTCLIENT
            else
              if Bar.CanClose and PtInRect(CloseButtonRect, P) then
                if BarManager.Style = bmsFlat then
                  FHitTest := HTCLOSE
                else
                begin
                  FHitTest := HTCLIENT;
                  Result := HTCLOSE;
                  Exit;
                end
              else
                FHitTest := HTCAPTION;
            Result := HTCLIENT;
          end;
      else
        FHitTest := Result;
      end
    else  // DockingStyle <> dsNone
    begin
      if Result = HTCLIENT then
        AControl := ItemAtPos(P)
      else
        AControl := nil;
      NoControl := (AControl = nil) or not IsCustomizing and not AControl.WantMouse;
      if (Result = HTCLIENT) and NoControl or (Result = HTNOWHERE) then
        if not Vertical and (P.X < 0) or Vertical and (P.Y < 0) or
          NoControl and not MouseAboveMDIButtons and
          ((BarManager.Style = bmsStandard) or not MarkExists or not PtInRect(MarkRect, P)) then
          if FHasSizeGrip and PtInRect(SizeGripRect, P) then
          begin
            FHitTest := HTBOTTOMRIGHT;
            Result := HTBOTTOMRIGHT;
          end
          else
          begin
            FHitTest := HTCAPTION;
            Result := HTCLIENT;
          end
        else
      else
      begin
        FHitTest := Result;
        Result := HTCLIENT;
      end;
    end;
end;

procedure TdxBarControl.WMNCLButtonDown(var Message: TWMNCLButtonDown);
var
  SuccessfulDragging: Boolean;
  CaptureWnd: HWND;
  Msg: TMsg;
  P: TPoint;
  ABar: TdxBar;
begin
  HideAll;
  if not BarControlExists(Self) then Exit;
  if Message.HitTest = HTCLOSE then
  begin
    if not BarManager.HideFloatingBarsWhenInactive then
      SetActiveWindow(BarManager.MainForm.Handle);

    CloseButtonState := msPressed;
    SuccessfulDragging := False;

    CaptureWnd := Handle;
    SetCapture(CaptureWnd);
    try
      while GetCapture = CaptureWnd do
      begin
        case Integer(GetMessage(Msg, 0, 0, 0)) of
          -1: Break;
          0: begin
              PostQuitMessage(Msg.wParam);
              Break;
            end;
        end;
        with Msg do
          case message of
            WM_LBUTTONUP:
              begin
                SuccessfulDragging := CloseButtonState = msPressed;
                Break;
              end;
            WM_MOUSEMOVE:
              begin
                GetCursorPos(P);
                Windows.ScreenToClient(Handle, P);
                if PtInRect(CloseButtonRect, P) then
                  CloseButtonState := msPressed
                else
                  CloseButtonState := msSelected;
              end;
          else
            TranslateMessage(Msg);
            DispatchMessage(Msg);
          end;
      end;
    finally
      if GetCapture = CaptureWnd then ReleaseCapture;
      CloseButtonState := msNone;
      if SuccessfulDragging then
      begin
        ABar := FBar;
        Bar.Visible := False;
        ABar.BarManager.DoBarClose(ABar);
      end;
    end;
    Exit;
  end;
  inherited;
end;

procedure TdxBarControl.WMNCPaint(var Message: TMessage);
var
  WR, R, CR: TRect;
  Rgn, Rgn1: HRGN;
  DC: HDC;
  Brush, AToolbarBrush: HBRUSH;

  procedure DrawFinger;
  var
    I: Integer;
  begin
    with R do
      if Flat then
        if Horizontal then
          for I := Top to Bottom - 1 do
          begin
            if Odd(I - Top) then
              Brush := AToolbarBrush
            else
              Brush := COLOR_BTNSHADOW + 1;
            FillRect(DC, Rect(Left, I, Right, I + 1), Brush);
          end
        else
          for I := Left to Right - 1 do
          begin
            if Odd(I - Left) then
              Brush := AToolbarBrush
            else
              Brush := COLOR_BTNSHADOW + 1;
            FillRect(DC, Rect(I, Top, I + 1, Bottom), Brush);
          end
      else
      begin
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
        if BarManager.Style = bmsStandard then
          if Horizontal then
            SetPixel(DC, Left, Bottom - 1, GetSysColor(COLOR_BTNHIGHLIGHT))
          else
            SetPixel(DC, Right - 1, Top, GetSysColor(COLOR_BTNHIGHLIGHT));
        InflateRect(R, -1, -1);
        FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
        InflateRect(R, 1, 1);
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
      end;
  end;

  procedure DrawStatusBar;
  var
    R1: TRect;
  begin
    DC := GetWindowDC(Handle);

    R1 := R;
    R.Bottom := R.Top + 2;
    FillRect(DC, R, COLOR_BTNFACE + 1);

    if FHasSizeGrip then
    begin
      R1.Left := R1.Right - GetSystemMetrics(SM_CXHSCROLL);
      R1.Top := R1.Bottom - GetSystemMetrics(SM_CYHSCROLL);
      DrawFrameControl(DC, R1, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);

      R1.Bottom := R1.Top;
      R1.Top := R.Bottom;
      FillRect(DC, R1, AToolbarBrush);
    end;

    ReleaseDC(Handle, DC);
  end;

  procedure DrawDockedBarBorder;
  begin
    with R do
    begin
      if Flat then
      begin
        FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
        InflateRect(R, -1, -1);
        FillRect(DC, Rect(Left, Top, Left + 1, Top + 1), COLOR_BTNFACE + 1);
        FillRect(DC, Rect(Right - 1, Top, Right, Top + 1), COLOR_BTNFACE + 1);
        FillRect(DC, Rect(Left, Bottom - 1, Left + 1, Bottom), COLOR_BTNFACE + 1);
        FillRect(DC, Rect(Right - 1, Bottom - 1, Right, Bottom), COLOR_BTNFACE + 1);
        InflateRect(R, -1, -1);
      end
      else
      begin
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
        InflateRect(R, -2, -2);
      end;
      if Horizontal then
      begin
        Inc(Left, BarManager.BeforeFingersSize);
        Right := Left + dxBarFingerSize;
        case BarManager.Style of
          bmsEnhanced: InflateRect(R, 0, -1);
          bmsFlat: InflateRect(R, 0, -3);
        end;
      end
      else
      begin
        Inc(Top, BarManager.BeforeFingersSize);
        Bottom := Top + dxBarFingerSize;
        case BarManager.Style of
          bmsEnhanced: InflateRect(R, -1, 0);
          bmsFlat: InflateRect(R, -3, 0);
        end;
      end;
      DrawFinger;
      if BarManager.Style = bmsStandard then
      begin
        if Horizontal then
          OffsetRect(R, dxBarFingerSize, 0)
        else
          OffsetRect(R, 0, dxBarFingerSize);
        DrawFinger;
      end;
    end;
  end;

  procedure DrawFloatingBarBorder;
  {const
    BorderColor = COLOR_BTNSHADOW;}
  var
    I: Integer;
  begin
    DC := GetWindowDC(Handle);
    if Flat then
    begin
      FrameRect(DC, R, BarManager.FlatToolbarsBorderBrush);
      InflateRect(R, -1, -1);
      FrameRect(DC, R, GetSysColorBrush(COLOR_BTNHIGHLIGHT){AToolbarBrush});
      for I := R.Left + 1 to CR.Left - 1 do
      begin
        InflateRect(R, -1, -1);
        FrameRect(DC, R, AToolbarBrush);
      end;
{      FrameRect(DC, R, GetSysColorBrush(BorderColor));
      InflateRect(R, -1, -1);
      FrameRect(DC, R, GetSysColorBrush(BorderColor));
      InflateRect(R, -1, -1);
      FrameRect(DC, R, AToolbarBrush);
      with R do
      begin
        FillRect(DC, Rect(Left, Top, Left + 1, Top + 1), BorderColor + 1);
        FillRect(DC, Rect(Right - 1, Top, Right, Top + 1), BorderColor + 1);
        FillRect(DC, Rect(Left, Bottom - 1, Left + 1, Bottom), BorderColor + 1);
        FillRect(DC, Rect(Right - 1, Bottom - 1, Right, Bottom), BorderColor + 1);
      end;}
    end
    else
    begin
      DrawEdge(DC, R, EDGE_RAISED, BF_RECT);
      InflateRect(R, -2, -2);
      FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
      InflateRect(R, -1, -1);
      FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
    end;
    ReleaseDC(Handle, DC);
  end;

  procedure DrawFloatingBarCaption;
  var
    NonClientMetrics: TNonClientMetrics;
    R1: TRect;
    X: Integer;

    procedure DrawCaption;
    var
      S: string;
      AFont: HFONT;
      l_Size: TSize;
    begin
      if R.Right - R.Left <= 0 then Exit;
      S := Bar.Caption;
      if not BarManager.UseSystemFont then
        with NonClientMetrics.lfSmCaptionFont, Bar.Font do
        begin
          if lfHeight > -11 then lfHeight := -11;
          Move(Name[1], lfFaceName, Length(Name));
          lfFaceName[Length(Name)] := #0;
        end;
      AFont := SelectObject(DC, CreateFontIndirect(NonClientMetrics.lfSmCaptionFont));
      SetTextColor(DC, GetSysColor(COLOR_CAPTIONTEXT));
      SetBkColor(DC, GetSysColor(CaptionBkColor));
      GetTextExtentPoint32(DC, PChar(S), Length(S), l_Size);
      ExtTextOut(DC, X, (R.Top + R.Bottom - l_Size.cy) div 2, ETO_OPAQUE or ETO_CLIPPED,
        @R, PChar(S), Length(S), nil);
      DeleteObject(SelectObject(DC, AFont));
    end;

  begin
    if not FHasCaption then Exit;

    NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
    SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0);
    R := GetCaptionNCRect;
    CR := R;

    DC := GetWindowDC(Handle);

    R1 := R;
    R1.Top := R.Bottom;
    R1.Bottom := R1.Top + 1;
    FillRect(DC, R1, AToolbarBrush);

    if Bar.CanClose then
    begin
      Dec(R.Right, NonClientMetrics.iSmCaptionHeight);
      DrawCloseButton(DC);
    end;
    X := R.Left;
    if MarkExists then
      if Flat then
      begin
        Inc(X, 2);
        R.Right := MarkNCRect.Left;
      end
      else
        X := MarkNCRect.Right + 3 * FloatToolbarMarkIndent
    else
      Inc(X, 2);

    DrawCaption;
    if MarkExists then DrawMark(DC);

    ReleaseDC(Handle, DC);
  end;

begin
  inherited;
  GetWindowRect(WR);
  R := WR;
  Windows.GetClientRect(Handle, CR);
  with ClientToScreen(Point(0, 0)), WR do
    OffsetRect(CR, X - Left, Y - Top);
  OffsetRect(R, -R.Left, -R.Top);
  AToolbarBrush := ToolbarBrush;

  if (DockingStyle <> dsNone) and (FBar.BorderStyle = bbsNone) then
  begin
    if FBar.IsStatusBar then DrawStatusBar;
    Exit;
  end;

  with R do
    if DockingStyle = dsNone then
    begin
      DrawFloatingBarBorder;
      R := CR;
      if FHasCaption and not Flat then
      begin
        Dec(Left, dxBarHorSize);
        Inc(Right, dxBarHorSize);
        Dec(Top, dxBarTopSize);
        Inc(Bottom, dxBarBottomSize);
      end;
      Rgn := CreateRectRgn(Left, Top, Right, Bottom);
    end
    else
      Rgn := CreateRectRgn(Left + 1, Top + 1, Right - 1, Bottom - 1);
  with CR do
    Rgn1 := CreateRectRgn(Left, Top, Right, Bottom);
  CombineRgn(Rgn, Rgn1, Rgn, RGN_XOR);
  DeleteObject(Rgn1);

  DC := GetWindowDC(Handle);
  FillRgn(DC, Rgn, AToolbarBrush);
  DeleteObject(Rgn);
  if DockingStyle <> dsNone then DrawDockedBarBorder;
  ReleaseDC(Handle, DC);

  if DockingStyle = dsNone then DrawFloatingBarCaption;
end;

procedure TdxBarControl.WMRButtonDown(var Message: TWMRButtonDown);
var
  P: TPoint;
begin
  ReleaseCapture;
  if IsCustomizing then IsActive := False
  else {HideAll};//BarLostFocus;
  inherited;
  if BarManager.IsCustomizing then Exit;
  //SetMouseSelectedItem(nil);
  with Message do
    P := ClientToScreen(Point(XPos, YPos));
  ShowToolbarsPopup(Self, BarManager, P);
end;

procedure TdxBarControl.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
  R: TRect;
begin
  if GetCapture = 0 then
  begin
    GetCursorPos(P);
    Windows.ScreenToClient(Handle, P);
    FEditSizingCursor := False;
    if IsCustomizing and (SelectedItem is TdxBarEditControl) then
    begin
      R := SelectedItem.ItemLink.ItemRect;
      with R do
        if PtInRect(Rect(Left, Top, Left + EditSizingZoneSize, Bottom), P) then
        begin
          FEditSizingCursor := True;
          FRightBorderSizing := False;
        end
        else
          if PtInRect(Rect(Right - EditSizingZoneSize, Top, Right, Bottom), P) then
          begin
            FEditSizingCursor := True;
            FRightBorderSizing := True;
          end;
    end;
    if not Moving and not FEditSizingCursor then
      SetCursorForMoving(PtInRect(GetSizeAllCursorBounds, P));
  end;
  if FEditSizingCursor then
    SetCursor(Screen.Cursors[crdxBarEditSizing])
  else
    inherited;
end;

procedure TdxBarControl.WMSize(var Message: TWMSize);
begin
  if IsDestroying then Exit;
  inherited;
end;

procedure TdxBarControl.WMSizing(var Message: TMessage);
var
  l_Size: TPoint;
  NCSize: Integer;
begin
  inherited;
  if DockingStyle = dsNone then
    with Message, PRect(lParam)^ do
    begin
      case wParam of
        WMSZ_LEFT, WMSZ_RIGHT:
          begin
            NCSize := Bar.BarNCSizeX(dsNone);
            l_Size := GetSizeForWidth(DockingStyle, Right - Left - NCSize);
            if wParam = WMSZ_LEFT then
              Left := Right - l_Size.X - NCSize
            else
              Right := Left + l_Size.X + NCSize;
            Bottom := Top + l_Size.Y + Bar.BarNCSizeY(dsNone);
          end;
        WMSZ_TOP, WMSZ_BOTTOM:
          begin
            NCSize := Bar.BarNCSizeY(dsNone);
            l_Size := GetSizeForHeight(DockingStyle, Bottom - Top - NCSize);
            Right := Left + l_Size.X + Bar.BarNCSizeX(dsNone);
            if wParam = WMSZ_TOP then
              Top := Bottom - l_Size.Y - NCSize
            else
              Bottom := Top + l_Size.Y + NCSize;
          end;
      else
        PRect(lParam)^ := BoundsRect;
        Result := 1;
      end;
      // against windows' bug:
      if Top < -15 then OffsetRect(PRect(lParam)^, 0, -15 - Top);
      Result := 1;
    end;
end;

procedure TdxBarControl.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if (FBar = nil) or InternallyLocked or IsDestroying then Exit;
  FBar.ChangeDockingStyle(DockingStyle, DockControl);
  SavePos;
  with Message.WindowPos^ do
    if ((flags and SWP_NOSIZE = 0) or (flags and SWP_NOMOVE = 0)) and
      (FQuickPopup <> nil) then
    begin
      FQuickPopup.OwnerBounds := MarkScreenRect;
      FQuickPopup.ResizeShadow;
      SendMessage(FQuickPopup.Handle, WM_NCPAINT, 0, 0);
    end;
end;

procedure TdxBarControl.WMWindowPosChanging(var Message: TWMWindowPosChanging);
var
  L, T, W, H: Integer;
  P: TPoint;
  R: TRect;
begin
  inherited;
  if DockingStyle = dsNone then
    with Message.WindowPos^ do
      if (flags and SWP_NOMOVE = 0) or (flags and SWP_NOSIZE = 0) then
      begin
        if flags and SWP_NOMOVE = 0 then
        begin
          L := x;
          T := y;
        end
        else
        begin
          L := Left;
          T := Top;
        end;
        if flags and SWP_NOSIZE = 0 then
        begin
          W := cx;
          H := cy;
        end
        else
        begin
          W := Width;
          H := Height;
        end;
        GetCursorPos(P);
        R := GetWorkArea(P);
        with R do
        begin
          if L + W <= Left then
          begin
            x := Left;
            y := T;
            flags := flags and not SWP_NOMOVE;
          end;
          if T + H <= Top then
          begin
            x := L;
            y := Top;
            flags := flags and not SWP_NOMOVE;
          end;
          if L >= Right then
          begin
            x := Right - W;
            y := T;
            flags := flags and not SWP_NOMOVE;
          end;
          if T >= Bottom then
          begin
            x := L;
            y := Bottom - H;
            flags := flags and not SWP_NOMOVE;
          end;
        end;
      end;
end;

procedure TdxBarControl.CMFontChanged(var Message: TMessage);
var
  LogFont: TLogFont;
begin
  if IsVertical(Self) and not FSettingFont then
  begin
    FSettingFont := True;
    GetObject(Font.Handle, SizeOf(LogFont), @LogFont);
    with LogFont do
    begin
      lfEscapement := -900;
      lfOrientation := lfEscapement;
      lfOutPrecision := OUT_TT_ONLY_PRECIS;
    end;
    Canvas.Font.Handle := CreateFontIndirect(LogFont);
    FSettingFont := False;
  end
  else
    Canvas.Font := Font;
  CalcDrawingConsts;
  if not InternallyLocked then
  begin
    SetMouseSelectedItem(nil);
    RepaintBar;
  end;
  inherited;
end;

procedure TdxBarControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_CLIPCHILDREN or WS_CLIPSIBLINGS;
    WindowClass.Style := CS_DBLCLKS or CS_HREDRAW or CS_VREDRAW;
    ExStyle := 0;//WS_EX_TOOLWINDOW;
    if DockingStyle = dsNone then
    begin
      Style := Style or WS_POPUPWINDOW or WS_SIZEBOX;
      WndParent := BarManager.MainForm.Handle;
    end
    else
    begin
      Style := Style or WS_CHILD;
      WndParent := FDockControl.Handle;
    end;
  end;
end;

procedure TdxBarControl.CreateWnd;
begin
  if FMoving and InternallyLocked then
    if FDockingStyle = dsNone then
      WindowHandle := FFloatingHandle
    else
      WindowHandle := FDockedHandle
  else
    inherited;
  Text := Bar.Caption;
  SendMessage(Handle, WM_NCACTIVATE, Longint(True), 0);  // don't remove (AV in ntdll.dll)
end;

procedure TdxBarControl.Paint;
const
  MarkEdges: array[msSelected..msPressed] of UINT = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  DC: HDC;
  I, BeginGroupSideSize: Integer;
  AItemLink: TdxBarItemLink;
  ItemRect: TRect;
  Rgn: HRGN;
  AButton: TdxBarMDIButton;
  AToolbarBrush: HBRUSH;
  AVertical: Boolean;

  procedure ExcludeRect(var MainRgn: HRGN; const R: TRect);
  var
    TempRgn: HRGN;
  begin
    TempRgn := CreateRectRgnIndirect(R);
    CombineRgn(MainRgn, MainRgn, TempRgn, RGN_DIFF);
    DeleteObject(TempRgn);
  end;

  function IsBarSmall(const R: TRect): Boolean;
  begin
    with R do
      Result := Bottom - Top <= 1 + 3 + 5 + 3 + 3 + 1;
  end;

  procedure DrawMarkAtPos(Offset: Integer);
  var
    Pen: HPEN;
    X, Y: Integer;
  begin
    if BarManager.Style = bmsStandard then
      if Horizontal then
      begin
        Pen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNHIGHLIGHT)));
        X := Offset;
        MoveToEx(DC, X - 1, 1, nil);
        LineTo(DC, X + 2, 4);
        MoveToEx(DC, X + 3, 4, nil);
        LineTo(DC, X - 1, 8);
        DeleteObject(SelectObject(DC, Pen));

        Pen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNSHADOW)));
        MoveToEx(DC, X, 1, nil);
        LineTo(DC, X + 2, 3);
        LineTo(DC, X + 2, 4);
        LineTo(DC, X - 1, 7);
        DeleteObject(SelectObject(DC, Pen));
      end
      else
      begin
        Pen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNSHADOW)));
        X := ClientWidth - 8;
        MoveToEx(DC, X, Offset, nil);
        LineTo(DC, X + 4, Offset + 4);
        MoveToEx(DC, X + 4, Offset + 1, nil);
        LineTo(DC, X + 6, Offset - 1);
        DeleteObject(SelectObject(DC, Pen));

        Pen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNHIGHLIGHT)));
        MoveToEx(DC, X + 1, Offset, nil);
        LineTo(DC, X + 3, Offset + 2);
        LineTo(DC, X + 4, Offset + 2);
        LineTo(DC, X + 7, Offset - 1);
        DeleteObject(SelectObject(DC, Pen));
      end
    else
    begin
      Pen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNTEXT)));
      if Horizontal then
      begin
        X := Offset;
        Y := 4 - Byte(IsBarSmall(ItemRect));
        MoveToEx(DC, X, Y, nil);
        LineTo(DC, X + 2, Y + 2);
        LineTo(DC, X - 1, Y + 5);
        MoveToEx(DC, X + 1, Y, nil);
        LineTo(DC, X + 3, Y + 2);
        LineTo(DC, X, Y + 5);
      end
      else
      begin
        X := ClientWidth - 8;
        MoveToEx(DC, X, Offset, nil);
        LineTo(DC, X + 2, Offset + 2);
        LineTo(DC, X + 5, Offset - 1);
        MoveToEx(DC, X, Offset + 1, nil);
        LineTo(DC, X + 2, Offset + 3);
        LineTo(DC, X + 5, Offset);
      end;
      DeleteObject(SelectObject(DC, Pen));
    end;
  end;

  procedure DrawArrow(X, Y: Integer; Vertical: Boolean);
  var
    P: array[1..3] of TPoint;
    Pen: HPEN;
    Brush: HBRUSH;
  begin
    if Vertical then
    begin
      P[1] := Point(X, Y);
      P[2] := Point(X, Y + 4);
      P[3] := Point(X - 2, Y + 2);
    end
    else
    begin
      P[1] := Point(X, Y);
      P[2] := Point(X + 4, Y);
      P[3] := Point(X + 2, Y + 2);
    end;
    Pen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNTEXT)));
    Brush := SelectObject(DC, GetSysColorBrush(COLOR_BTNTEXT));
    Polygon(DC, P, 3);
    SelectObject(DC, Brush);
    DeleteObject(SelectObject(DC, Pen));
  end;

  function GetMarkBrush(AMarkState: TdxBarMarkState): HBRUSH;
  begin
    if Flat and (AMarkState = msSelected) then
      Result := ToolbarSelBrush
    else
      Result := AToolbarBrush;
  end;

  procedure DrawMarkBackground;
  begin
    if BarManager.Style = bmsStandard then
      FillRect(DC, ItemRect, AToolbarBrush)
    else
      if Flat and (MarkState = msPressed) then
        DrawBarControlOwner(DC, ItemRect, FQuickPopup)
      else
      begin
        if MarkState = msNone then
          FrameRect(DC, ItemRect, AToolbarBrush)
        else
          if Flat then
            FrameFlatSelRect(DC, ItemRect)
          else
            DrawEdge(DC, ItemRect, MarkEdges[MarkState], BF_RECT);
        InflateRect(ItemRect, -1, -1);
        FillRect(DC, ItemRect, GetMarkBrush(MarkState));
        InflateRect(ItemRect, 1, 1);
      end;
  end;

  procedure DrawMarkElements;
  begin
    with ItemRect do
    begin
      if BarManager.Style <> bmsStandard then
        if Horizontal then
          DrawArrow(Left + 3, Bottom - 7 + Byte(IsBarSmall(ItemRect)), False)
        else
          DrawArrow(Left + 5, Top + 3, True);
      if FTruncated then
        if Horizontal then
        begin
          DrawMarkAtPos(Left + 2);
          DrawMarkAtPos(Left + 6);
        end
        else
        begin
          DrawMarkAtPos(Bottom - MarkSizeY);
          DrawMarkAtPos(Bottom - MarkSizeY + 4);
        end;
    end;
  end;

begin
  inherited;
  if not IsWindowVisible(BarManager.MainForm.Handle) or FDestroyFlag then Exit;

  // recalc positions of items
  CalcControlsPositions;

  // hide invisible items that require that
  if not BarManager.Designing then
    for I := 0 to FItemLinks.CanVisibleItemCount - 1 do
    begin
      AItemLink := FItemLinks.CanVisibleItems[I];
      with AItemLink do
        if Item.NeedToBeHidden and (VisibleIndex = -1) then
          Item.HideControl(Control);
    end;

  if BarManager.Style <> bmsStandard then SendMessage(Handle, WM_NCPAINT, 0, 0);

  AToolbarBrush := ToolbarBrush;
  Rgn := CreateRectRgnIndirect(ClientRect);
  DC := Canvas.Handle;

  // paint items and "BeginGroups"
  BeginGroupSideSize := (BeginGroupSize - (1 + Byte(not Flat))) div 2;
  for I := 0 to FItemLinks.VisibleItemCount - 1 do
  begin
    AItemLink := FItemLinks.VisibleItems[I];
    ItemRect := GetItemRect(AItemLink.Control);
    PaintItem(AItemLink.Control);
    ExcludeRect(Rgn, ItemRect);

    if AItemLink.BeginGroup and not IsRectEmpty(ItemRect) then
    begin
      AVertical := Vertical;
      if not AVertical and (ItemRect.Left = 0) and (ItemRect.Top > 0) or
        AVertical and (ItemRect.Top > 0) then
      begin  // begin group in vertical direction
        with ItemRect do
        begin
          if AVertical then
            ItemRect := Bounds(
              Left - (AItemLink.FRowHeight - (Right - Left)) div 2,
              Top - BeginGroupSize,
              AItemLink.FRowHeight, BeginGroupSize)
          else
            ItemRect := Bounds(
              0,
              Top - (AItemLink.FRowHeight - (Bottom - Top)) div 2 - BeginGroupSize,
              ClientWidth - Byte((DockingStyle <> dsNone) and MarkExists) * MarkSizeX,
              BeginGroupSize);
          FillRect(DC,
            Rect(Left, Top, Right, Top + BeginGroupSideSize),
            BkBrush);
          FillRect(DC,
            Rect(Left, Bottom - BeginGroupSideSize, Right, Bottom),
            BkBrush);
        end;
        ExcludeRect(Rgn, ItemRect);
        AItemLink.Control.FBeginGroupRect := ItemRect;
        InflateRect(ItemRect, 0, -BeginGroupSideSize);
        if Flat then
          with ItemRect do
          begin
            FillRect(DC, Rect(Left, Top, Right, Top + 1), COLOR_BTNSHADOW + 1);
            FillRect(DC, Rect(Left, Top + 1, Right, Bottom), AToolbarBrush);
          end
        else
          DrawEdge(DC, ItemRect, EDGE_ETCHED, BF_TOP);
      end
      else
      begin  // begin group in horizontal direction
        with ItemRect do
        begin
          if AVertical then
            ItemRect := Bounds(
               Right + (AItemLink.FRowHeight - (Right - Left)) div 2, 0,
               BeginGroupSize,
               ClientHeight - Byte((DockingStyle <> dsNone) and MarkExists) * MarkSizeX)
          else
            ItemRect := Bounds(
               Left - BeginGroupSize,
               Top - (AItemLink.FRowHeight - (Bottom - Top)) div 2,
               BeginGroupSize, AItemLink.FRowHeight);
          FillRect(DC,
            Rect(Left, Top, Left + BeginGroupSideSize, Bottom),
            BkBrush);
          FillRect(DC,
            Rect(Right - BeginGroupSideSize, Top, Right, Bottom),
            BkBrush);
        end;
        ExcludeRect(Rgn, ItemRect);
        AItemLink.Control.FBeginGroupRect := ItemRect;
        InflateRect(ItemRect, -BeginGroupSideSize, 0);
        if Flat then
          with ItemRect do
          begin
            FillRect(DC, Rect(Left, Top, Left + 1, Bottom), COLOR_BTNSHADOW + 1);
            FillRect(DC, Rect(Left + 1, Top, Right, Bottom), AToolbarBrush);
          end
        else
          DrawEdge(DC, ItemRect, EDGE_ETCHED, BF_LEFT);
      end;
    end
    else
      SetRectEmpty(AItemLink.Control.FBeginGroupRect);
  end;

  // draw MDI buttons
  if MDIButtonsOnBar then
    if RealMDIButtonsOnBar then
      for AButton := Low(TdxBarMDIButton) to High(TdxBarMDIButton) do
      begin
        DrawMDIButton(AButton, False);
        ExcludeRect(Rgn, RectMDI(AButton));
      end
    else
      begin
        DrawMDIButton(mdibClose, False);
        ExcludeRect(Rgn, RectMDI(mdibClose));
      end;

  // draw mark(s)
  if (DockingStyle <> dsNone) and MarkExists then
  begin
    ItemRect := MarkRect;
    DrawMarkBackground;
    DrawMarkElements;
    ExcludeRect(Rgn, ItemRect);
  end;

  FillRgn(DC, Rgn, AToolbarBrush);
  DeleteObject(Rgn);
end;

procedure TdxBarControl.BeginInternal;
begin
  Inc(FInternalLockCount);
end;

procedure TdxBarControl.EndInternal;
begin
  if FInternalLockCount > 0 then
    Dec(FInternalLockCount);
end;

procedure TdxBarControl.CalcDrawingConsts;
begin
  inherited;
  FMDIButtonWidth := GetSystemMetrics(SM_CXMENUSIZE) - 2;
  FMDIButtonHeight := GetSystemMetrics(SM_CYMENUSIZE) - 2 * 2;
end;

function TdxBarControl.CanAlignControl(AControl: TdxBarItemControl): Boolean;
begin
  with AControl.ItemLink do
    Result := (CanVisibleIndex = Owner.CanVisibleItemCount - 1);
end;

function TdxBarControl.CanCallInheritedNCCalcSize: Boolean;
begin
  Result := (DockingStyle <> dsNone) or not Flat;
end;

function TdxBarControl.CanCustomizing: Boolean;
begin
  Result := inherited CanCustomizing or FBar.AllowCustomizing;
end;

function TdxBarControl.CanFinishMouseTracking(const Message: TWMNCHitTest): Boolean;
begin
  Result := inherited CanFinishMouseTracking(Message) and
    (CloseButtonState <> msSelected);
end;

function TdxBarControl.CloseButtonRect: TRect;
var
  NonClientMetrics: TNonClientMetrics;
begin
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0);
  Result := GetCaptionRect;
  with Result do
    Left := Right - NonClientMetrics.iSmCaptionHeight;
end;

function TdxBarControl.CloseButtonRectNC: TRect;
var
  WR: TRect;
begin
  Result := CloseButtonRect;
  MapWindowPoints(Handle, 0, Result, 2);
  GetWindowRect(WR);
  OffsetRect(Result, -WR.Left, -WR.Top);
end;

function TdxBarControl.GetBeginGroupSize: Integer;
begin
  Result := 2 + 1 + Byte(not Flat) + 2;
end;

function TdxBarControl.GetCol: Integer;
var
  I, J: Integer;
begin
  Result := 0;
  if (FBar = nil) or (FBar.FBars = nil) or (DockingStyle = dsNone) or
    (FDockControl = nil) then Exit;
  with FDockControl do
    for I := 0 to FRowList.Count - 1 do
      for J := 0 to TdxDockRow(FRowList[I]).ColList.Count - 1 do
        if TdxDockCol(TdxDockRow(FRowList[I]).ColList[J]).BarControl = Self then
        begin
          Result := J;
          Exit;
        end;
end;

procedure TdxBarControl.WndProc(var Message: TMessage);
var
  AStyle: TdxBarDockingStyle;
  ADockControl: TdxDockControl;
begin
  with Message do
  begin
    if Msg = WM_SETFOCUS then
    begin
      Exit;
    end;

    if FIsMDIButtonPressed and (Msg = WM_CANCELMODE) then
    begin
      ReleaseCapture;
      FIsMDIButtonPressed := False;
      RepaintBar;
    end;

    if (Msg = WM_LBUTTONDBLCLK) and (FHitTest = HTCAPTION) then
    begin
      if not BarManager.Designing then
        with Bar do
        begin
          ADockControl := nil;
          if DockingStyle = dsNone then
            if DockedDockingStyle <> dsNone then
            begin
              AStyle := DockedDockingStyle;
              ADockControl := DockedDockControl;
              if ADockControl = nil then
                ADockControl := FBars.FDockControls[AStyle];
            end
            else
            begin
              AStyle := dsTop;
              ADockControl := FBars.FDockControls[dsTop];
            end
          else
            AStyle := dsNone;
          if BarManager.DoDocking(Bar, AStyle, ADockControl) then
          begin
            Visible := False;
            if DockingStyle = dsNone then
            begin
              ChangeDockingStyle(AStyle, ADockControl);
              if DockedDockingStyle = dsNone then
              begin
                OneOnRow := True;
                Row := ADockControl.RowCount;
              end;
            end
            else
              DockingStyle := dsNone;
            Visible := True;
          end;
        end;
      Exit;
    end;
  end;
  inherited;
end;

function TdxBarControl.GetDockCol: TdxDockCol;
var
  I, J: Integer;
begin
  Result := nil;
  if (FBar = nil) or (FBar.FBars = nil) or (DockingStyle = dsNone) or
    (FDockControl = nil) then Exit;
  with FDockControl do
    for I := 0 to RowCount - 1 do
      for J := 0 to Rows[I].ColCount - 1 do
        if Rows[I].Cols[J].BarControl = Self then
        begin
          Result := Rows[I].Cols[J];
          Exit;
        end;
end;

function TdxBarControl.GetRow: Integer;
var
  I, J: Integer;
begin
  Result := 0;
  if (FBar = nil) or (FBar.FBars = nil) or (DockingStyle = dsNone) or
    (FDockControl = nil) then Exit;
  with FDockControl do
    for I := 0 to RowCount - 1 do
      for J := 0 to Rows[I].ColCount - 1 do
        if Rows[I].Cols[J].BarControl = Self then
        begin
          Result := I;
          Exit;
        end;
end;

function TdxBarControl.GetMinWidth(AStyle: TdxBarDockingStyle): Integer;
var
  I, AWidth: Integer;
begin
  if (AStyle in [dsLeft, dsRight]) or MultiLine then
  begin
    if ItemLinks.CanVisibleItemCount = 0 then
      Result := BarManager.ButtonWidth
    else
    begin
      Result := 0;
      for I := 0 to ItemLinks.CanVisibleItemCount - 1 do
      begin
        AWidth := ItemLinks.CanVisibleItems[I].Control.Width;
        if Result < AWidth then Result := AWidth;
      end;
    end;
    if MDIButtonsOnBar and (Result < GetMDIWidth) then
      Result := GetMDIWidth;
  end
  else
  begin
    if ItemLinks.CanVisibleItemCount = 0 then
      Result := BarManager.ButtonWidth
    else
    begin
      ItemLinks.RecentItemCount := 1;
      Result := ItemLinks.VisibleItems[0].Control.Width;
      ItemLinks.RestoreRecentItemCount;
    end;
    if MDIButtonsOnBar then Inc(Result, GetMDIWidth);
  end;
  if Horizontal and MarkExists then Inc(Result, MarkSizeX);
end;

function TdxBarControl.GetMinHeight(AStyle: TdxBarDockingStyle): Integer;
var
  I, AHeight: Integer;
begin
  if (AStyle in [dsTop, dsBottom]) or MultiLine then
  begin
    if ItemLinks.CanVisibleItemCount = 0 then
      Result := BarManager.ButtonHeight
    else
    begin
      Result := 0;
      for I := 0 to ItemLinks.CanVisibleItemCount - 1 do
      begin
        AHeight := ItemLinks.CanVisibleItems[I].Control.Height;
        if Result < AHeight then Result := AHeight;
      end;
    end;
    if MDIButtonsOnBar and (Result < GetMDIHeight) then
      Result := GetMDIHeight;
  end
  else
  begin
    if ItemLinks.CanVisibleItemCount = 0 then
      Result := BarManager.ButtonHeight
    else
    begin
      ItemLinks.RecentItemCount := 1;
      Result := ItemLinks.VisibleItems[0].Control.Height;
      ItemLinks.RestoreRecentItemCount;
    end;
    if MDIButtonsOnBar then Inc(Result, GetMDIHeight);
  end;
  if Vertical and MarkExists then Inc(Result, MarkSizeX);
end;

function TdxBarControl.GetMaxWidth(AStyle: TdxBarDockingStyle): Integer;
var
  AWidth, I: Integer;
  AItemLink: TdxBarItemLink;
begin
  Result := GetMinWidth(AStyle);
  AWidth := 0;
  if (AStyle in [dsTop, dsBottom]) or MultiLine then
  begin
    ItemLinks.RecentItemCount := -1;
    for I := 0 to ItemLinks.VisibleItemCount - 1 do
    begin
      AItemLink := ItemLinks.VisibleItems[I];
      if AItemLink.BeginGroup then Inc(AWidth, BeginGroupSize);
      Inc(AWidth, AItemLink.Control.Width);
    end;
    ItemLinks.RestoreRecentItemCount;
    if MDIButtonsOnBar then Inc(AWidth, GetMDIWidth);
    if Horizontal and MarkExists then Inc(AWidth, MarkSizeX);
  end
  else
  begin
    for I := 0 to ItemLinks.CanVisibleItemCount - 1 do
    begin
      AItemLink := ItemLinks.CanVisibleItems[I];
      if AWidth < AItemLink.Control.Width then
        AWidth := AItemLink.Control.Width;
    end;
    if MDIButtonsOnBar and (AWidth < GetMDIWidth) then AWidth := GetMDIWidth;
  end;
  if Result < AWidth then Result := AWidth;
end;

function TdxBarControl.GetMaxHeight(AStyle: TdxBarDockingStyle): Integer;
var
  AHeight, I: Integer;
  AItemLink: TdxBarItemLink;
begin
  Result := GetMinHeight(AStyle);
  AHeight := 0;
  if (AStyle in [dsLeft, dsRight]) or MultiLine then
  begin
    ItemLinks.RecentItemCount := -1;
    for I := 0 to ItemLinks.VisibleItemCount - 1 do
    begin
      AItemLink := ItemLinks.VisibleItems[I];
      if AItemLink.BeginGroup then Inc(AHeight, BeginGroupSize);
      Inc(AHeight, AItemLink.Control.Height);
    end;
    ItemLinks.RestoreRecentItemCount;
    if MDIButtonsOnBar then Inc(AHeight, GetMDIHeight);
    if Vertical and MarkExists then Inc(AHeight, MarkSizeX);
  end
  else
  begin
    for I := 0 to ItemLinks.CanVisibleItemCount - 1 do
    begin
      AItemLink := ItemLinks.CanVisibleItems[I];
      if AHeight < AItemLink.Control.Height then
        AHeight := AItemLink.Control.Height;
    end;
    if MDIButtonsOnBar and (AHeight < GetMDIHeight) then
      AHeight := GetMDIHeight;
  end;
  if Result < AHeight then Result := AHeight;
end;

procedure TdxBarControl.GetMultiLineBarSize(AStyle: TdxBarDockingStyle;
  ASize: Integer; var Result: TPoint);
var
  CurX, CurY, CurRowHeight, MaxSize, ACount, I, ABeginGroupSize, W, H,
    LastItemLinkWithBeginGroupCurX, LastItemLinkWithBeginGroupCurRowHeight: Integer;
  LastItemLinkWithBeginGroup, AItemLink: TdxBarItemLink;
  AVertical, BreakingRow, EntireRow: Boolean;
begin
  AVertical := Vertical;
  if AVertical then
    if ASize < Result.Y then ASize := Result.Y
    else
  else
    if ASize < Result.X then ASize := Result.X;
  if (AStyle <> dsNone) and MarkExists then Dec(ASize, MarkSizeX);
  CurX := 0;
  CurY := 0;
  CurRowHeight := 0;
  MaxSize := 0;
  LastItemLinkWithBeginGroup := nil;
  LastItemLinkWithBeginGroupCurX := 0;
  LastItemLinkWithBeginGroupCurRowHeight := 0;
  BreakingRow := False;
  EntireRow := True;

  ACount := ItemLinks.VisibleItemCount;
  I := 0;
  while I < ACount do
  begin
    AItemLink := ItemLinks.VisibleItems[I];
    if AItemLink.BeginGroup and (CurX > 0) then
    begin
      ABeginGroupSize := BeginGroupSize;
      LastItemLinkWithBeginGroup := AItemLink;
      LastItemLinkWithBeginGroupCurX := CurX;
      LastItemLinkWithBeginGroupCurRowHeight := CurRowHeight;
    end
    else
      ABeginGroupSize := 0;

    with AItemLink.Control do
      if AVertical then
      begin
        W := Height;
        H := Width;
      end
      else
      begin
        W := Width;
        H := Height;
      end;

    if (CurX > 0) and (CurX + ABeginGroupSize + W > ASize) or
      BreakingRow or (ABeginGroupSize > 0) and not EntireRow then
    begin
      EntireRow := True;
      AItemLink.Control.FBreakingRow := True;
      if LastItemLinkWithBeginGroup = nil then
        EntireRow := False
      else
        if BreakingRow then
        begin
          LastItemLinkWithBeginGroup := nil;
          BreakingRow := False;
        end
        else
        begin
          I := LastItemLinkWithBeginGroup.VisibleIndex;
          CurX := LastItemLinkWithBeginGroupCurX;
          CurRowHeight := LastItemLinkWithBeginGroupCurRowHeight;
          BreakingRow := True;
          Continue;
        end;
      Inc(CurY, ABeginGroupSize + CurRowHeight);
      CurRowHeight := 0;
      if MaxSize < CurX then MaxSize := CurX;
      CurX := W;
    end
    else
    begin
      AItemLink.Control.FBreakingRow := False;
      Inc(CurX, ABeginGroupSize + W);
    end;
    if CurRowHeight < H then CurRowHeight := H;
    Inc(I);
  end;
  if ItemLinks.VisibleItemCount > 0 then
    if AVertical then
      Result.X := CurY + CurRowHeight
    else
      Result.Y := CurY + CurRowHeight;
  if MDIButtonsOnBar then
  begin
    if AVertical then
      I := GetMDIHeight
    else
      I := GetMDIWidth;
    if CurX + I <= ASize then
      Inc(CurX, I)
    else
      if AVertical then
        Inc(Result.X, GetMDIWidth)
      else
        Inc(Result.Y, GetMDIHeight);
  end;
  if MaxSize < CurX then MaxSize := CurX;
  if AVertical then
    if Result.Y < MaxSize then Result.Y := MaxSize
    else
  else
    if Result.X < MaxSize then Result.X := MaxSize;
  CalcControlsPositions;  // because of a FBreakingRow
end;

function TdxBarControl.GetSizeAllCursorBounds: TRect;
begin
  if (DockingStyle = dsNone) or (Bar.BorderStyle = bbsNone) then
    SetRectEmpty(Result)
  else
    if Horizontal then
      Result := Rect(-100, -100, 0, 100)
    else
      Result := Rect(-100, -100, 100, 0);
end;

function TdxBarControl.GetSizeForWidth(AStyle: TdxBarDockingStyle;
  AWidth: Integer): TPoint;
var
  J, ABeginGroupSize: Integer;
  AItemLink: TdxBarItemLink;
  Found: Boolean;
  PrevSize, Size: TPoint;

  function CalcSize(var Size: TPoint): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    Size.X := 0;
    Size.Y := 0;
    for I := 0 to ItemLinks.VisibleItemCount - 1 do
    begin
      AItemLink := ItemLinks.VisibleItems[I];
      if AItemLink.BeginGroup then
        ABeginGroupSize := BeginGroupSize
      else
        ABeginGroupSize := 0;
      with AItemLink.Control do
      begin
        if (Size.X + ABeginGroupSize + Width > AWidth) and (I <> 0) then
        begin
          Result := True;
          Break;
        end;
        Inc(Size.X, ABeginGroupSize + Width);
        if Size.Y < Height then Size.Y := Height;
      end;
    end;
  end;

begin
  ItemLinks.RecentItemCount := -1;
  CalcControlsPositions;
  ItemLinks.RestoreRecentItemCount;

  if MultiLine then
    if Vertical then
    begin
      Size := GetSizeForHeight(AStyle, GetMaxHeight(AStyle));
      repeat
        if Size.X >= AWidth then Break;
        PrevSize := Size;
        Dec(Size.Y);
        Size := GetSizeForHeight(AStyle, Size.Y);
      until Size.Y = PrevSize.Y;
      Result := Size;
    end
    else
    begin
      Result := Point(GetMinWidth(AStyle), GetMinHeight(AStyle));
      GetMultiLineBarSize(AStyle, AWidth, Result);
    end
  else
    case AStyle of
      dsTop, dsBottom:
        begin
          Result := Point(GetMinWidth(AStyle), GetMinHeight(AStyle));
          if AWidth < Result.X then AWidth := Result.X;
          if MDIButtonsOnBar then Dec(AWidth, GetMDIWidth);
          ItemLinks.RecentItemCount := -1;
          if ItemLinks.CanVisibleItemCount > 0 then
          begin
            if MarkExists then Dec(AWidth, MarkSizeX);
            if ItemLinks.CanUseRecentItems and not BarManager.Designing then
            begin
              PrevSize := Result;
              if MarkExists then Dec(PrevSize.X, MarkSizeX);
              Found := False;
              for J := 1 to ItemLinks.CanVisibleItemCount do
              begin
                ItemLinks.RecentItemCount := J;
                Found := CalcSize(Size);
                if Found then
                begin
                  ItemLinks.RecentItemCount := J - 1;
                  Size := PrevSize;
                  Break;
                end;
                PrevSize := Size;
              end;
              if not Found then ItemLinks.RecentItemCount := -1;
            end
            else
              CalcSize(Size);
            if MarkExists then Inc(Size.X, MarkSizeX);
            
            if Result.X < Size.X then Result.X := Size.X;
            Result.Y := Size.Y;
            if MDIButtonsOnBar then
            begin
              Inc(Result.X, GetMDIWidth);
              if Result.Y < GetMDIHeight then Result.Y := GetMDIHeight;
            end;
          end;
        end;

      dsLeft, dsRight:
        Result := Point(GetMinWidth(AStyle), GetMaxHeight(AStyle));
    end;
end;

function TdxBarControl.GetSizeForHeight(AStyle: TdxBarDockingStyle;
  AHeight: Integer): TPoint;
var
  J, ABeginGroupSize: Integer;
  AItemLink: TdxBarItemLink;
  Found: Boolean;
  PrevSize, Size: TPoint;

  function CalcSize(var Size: TPoint): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    Size.X := 0;
    Size.Y := 0;
    for I := 0 to ItemLinks.VisibleItemCount - 1 do
    begin
      AItemLink := ItemLinks.VisibleItems[I];
      if AItemLink.BeginGroup then
        ABeginGroupSize := BeginGroupSize
      else
        ABeginGroupSize := 0;
      with AItemLink.Control do
      begin
        if (Size.Y + ABeginGroupSize + Height > AHeight) and (I <> 0) then
        begin
          Result := True;
          Break;
        end;
        Inc(Size.Y, ABeginGroupSize + Height);
        if Size.X < Width then Size.X := Width;
      end;
    end;
  end;

begin
  ItemLinks.RecentItemCount := -1;
  CalcControlsPositions;
  ItemLinks.RestoreRecentItemCount;

  if MultiLine then
    if Vertical then
    begin
      Result := Point(GetMinWidth(AStyle), GetMinHeight(AStyle));
      GetMultiLineBarSize(AStyle, AHeight, Result);
    end
    else
    begin
      Size := GetSizeForWidth(AStyle, GetMaxWidth(AStyle));
      repeat
        if Size.Y >= AHeight then Break;
        PrevSize := Size;
        Dec(Size.X);
        Size := GetSizeForWidth(AStyle, Size.X);
      until Size.X = PrevSize.X;
      Result := Size;
    end
  else
    case AStyle of
      dsTop, dsBottom:
        Result := Point(GetMaxWidth(AStyle), GetMinHeight(AStyle));

      dsLeft, dsRight:
        begin
          Result := Point(GetMinWidth(AStyle), GetMinHeight(AStyle));
          if AHeight < Result.Y then AHeight := Result.Y;
          if MDIButtonsOnBar then Dec(AHeight, GetMDIHeight);
          ItemLinks.RecentItemCount := -1;
          if ItemLinks.CanVisibleItemCount > 0 then
          begin
            if MarkExists then Dec(AHeight, MarkSizeX);
            if ItemLinks.CanUseRecentItems and not BarManager.Designing then
            begin
              PrevSize := Result;
              if MarkExists then Dec(PrevSize.Y, MarkSizeX);
              Found := False;
              for J := 1 to ItemLinks.CanVisibleItemCount do
              begin
                ItemLinks.RecentItemCount := J;
                Found := CalcSize(Size);
                if Found then
                begin
                  ItemLinks.RecentItemCount := J - 1;
                  Size := PrevSize;
                  Break;
                end;
                PrevSize := Size;
              end;
              if not Found then ItemLinks.RecentItemCount := -1;
            end
            else
              CalcSize(Size);
            if MarkExists then Inc(Size.Y, MarkSizeX);
            
            if Result.Y < Size.Y then Result.Y := Size.Y;
            Result.X := Size.X;
            if MDIButtonsOnBar then
            begin
              Inc(Result.Y, GetMDIHeight);
              if Result.X < GetMDIWidth then Result.X := GetMDIWidth;
            end;
          end;
        end;
    end;
end;

function TdxBarControl.GetTrackSize(AStyle: TdxBarDockingStyle): TPoint;
var
  PrevRecentItemCount: Integer;
begin
  Result.X := 0;
  Result.Y := 0;
  PrevRecentItemCount := ItemLinks.RecentItemCount;
  case AStyle of
    dsNone:
      begin
        Result := GetSizeForWidth(AStyle, Bar.FloatClientWidth);
        Inc(Result.X, Bar.BarNCSizeX(AStyle));
        Inc(Result.Y, Bar.BarNCSizeY(AStyle));
      end;
    dsTop, dsBottom:
      begin
        if (FBar <> nil) and FBar.WholeRow then
          Result.X := FDockControl.ClientWidth - FBar.BarNCSizeX(AStyle)
        else
          Result.X := GetMaxWidth(AStyle);
        Result := GetSizeForWidth(AStyle, Result.X);
        if (FBar <> nil) and FBar.WholeRow then
          Result.X := FDockControl.ClientWidth
        else
          Inc(Result.X, Bar.BarNCSizeX(AStyle));
        Inc(Result.Y, Bar.BarNCSizeY(AStyle));
      end;
    dsLeft, dsRight:
      begin
        if (FBar <> nil) and FBar.WholeRow then
          Result.Y := FDockControl.ClientHeight - FBar.BarNCSizeY(AStyle)
        else
          Result.Y := GetMaxHeight(AStyle);
        Result := GetSizeForHeight(AStyle, Result.Y);
        Inc(Result.X, Bar.BarNCSizeX(AStyle));
        if (FBar <> nil) and FBar.WholeRow then
          Result.Y := FDockControl.ClientHeight
        else
          Inc(Result.Y, Bar.BarNCSizeY(AStyle));
      end;
  end;
  ItemLinks.RecentItemCount := PrevRecentItemCount;
  CalcControlsPositions;
end;

procedure TdxBarControl.InvalidateMark;
var
  DC: HDC;
  R: TRect;
begin
  if DockingStyle = dsNone then
  begin
    DC := GetWindowDC(Handle);
    DrawMark(DC);
    ReleaseDC(Handle, DC);
  end
  else
  begin
    R := MarkRect;
    InvalidateRect(Handle, @R, False);
  end;
end;

function TdxBarControl.MarkExists: Boolean;
begin
  Result := Bar.ShowMark and
    (FTruncated or (BarManager.Style <> bmsStandard) and Bar.AllowQuickCustomizing);
end;

function TdxBarControl.MarkNCRect: TRect;
var
  WR: TRect;
begin
  Result := MarkScreenRect;
  GetWindowRect(WR);
  OffsetRect(Result, -WR.Left, -WR.Top);
end;

function TdxBarControl.MarkRect: TRect;
begin
  case DockingStyle of
    dsTop, dsBottom:
      with Result do
      begin
        Left := ClientWidth - MarkSizeX;
        Top := 0;
        Right := Left + MarkSizeX;
        if BarManager.Style = bmsStandard then
          Bottom := MarkSizeY
        else
          Bottom := ClientHeight;
        {if MDIButtonsOnBar then
          OffsetRect(Result, -GetMDIWidth, 0);}
      end;
    dsLeft, dsRight:
      with Result do
      begin
        if BarManager.Style = bmsStandard then
          Left := ClientWidth - MarkSizeY
        else
          Left := 0;
        Top := ClientHeight - MarkSizeX;
        Right := ClientWidth;
        Bottom := Top + MarkSizeX;
        {if MDIButtonsOnBar then
          OffsetRect(Result, 0, -GetMDIHeight);}
      end;
  else
    Result := GetCaptionRect;
    with Result do
      if Flat then
      begin
        Left := Right - (Bottom - Top);
        if Bar.CanClose then
          with CloseButtonRect do
            OffsetRect(Result, -(Right - Left + FloatToolbarMarkIndent), 0);
        with GetCaptionRect do
          if Result.Left < Left{ - 3} then
            Result.Left := Left{ - 3};
      end
      else
        Right := Left + 3 + 7 + 3;
  end;
end;

function TdxBarControl.MarkScreenRect: TRect;
begin
  Result := MarkRect;
  MapWindowPoints(Handle, 0, Result, 2);
end;

function TdxBarControl.SizeGripRect: TRect;
begin
  with Result do
  begin
    Left := ClientWidth;
    Right := Left + GetSystemMetrics(SM_CXHSCROLL);
    Bottom := ClientHeight;
    Top := Bottom - GetSystemMetrics(SM_CYHSCROLL);
  end;
end;

procedure TdxBarControl.BarManagerStyleChanged;
var
  ABar: TdxBar;
begin
  UpdateControlStyle;
  CalcDrawingConsts;
  if DockingStyle = dsNone then
  begin
    ABar := Bar;
    ABar.Visible := False;
    ABar.Visible := True;
  end
  else
    RebuildBar;
end;

procedure TdxBarControl.CaptionChanged;
begin
  Text := Bar.Caption;
  SendMessage(Handle, WM_NCPAINT, 0, 0);
end;

procedure TdxBarControl.FrameChanged;
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0,
    SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_FRAMECHANGED);
end;

function TdxBarControl.GetEditFontHandle: HFONT;
begin
  if FBar.UseOwnFont then
    Result := FBar.FEditFontHandle
  else
    Result := inherited GetEditFontHandle;
end;

function TdxBarControl.GetFullItemRect(Item: TdxBarItemControl): TRect;
begin
  Result := GetItemRect(Item);
  with Item.ItemLink, Result do
    if Vertical then
    begin
      Dec(Left, (RowHeight - (Right - Left)) div 2);
      Right := Left + RowHeight;
    end
    else
    begin
      Dec(Top, (RowHeight - (Bottom - Top)) div 2);
      Bottom := Top + RowHeight;
    end;
end;

function TdxBarControl.GetItemRegion(Item: TdxBarItemControl): HRGN;
var
  Rgn: HRGN;
begin
  Result := CreateRectRgnIndirect(GetFullItemRect(Item));
  if not IsRectEmpty(Item.FBeginGroupRect) then
  begin
    Rgn := CreateRectRgnIndirect(Item.FBeginGroupRect);
    CombineRgn(Result, Result, Rgn, RGN_OR);
    DeleteObject(Rgn);
  end;
end;

function TdxBarControl.GetToolbarBrush: HBRUSH;
begin
  if not Flat or not (Bar.IsMainMenu or Bar.IsStatusBar) then
    Result := inherited GetToolbarBrush
  else
    Result := GetSysColorBrush(COLOR_BTNFACE);
end;

function TdxBarControl.ItemAtPosEx(Pos: TPoint;
  var IsBeginGroup, IsFirstPart, IsVerticalDirection: Boolean): TdxBarItemControl;
var
  I: Integer;
  Control: TdxBarItemControl;
  R: TRect;
  AVertical: Boolean;
begin
  Result :=
    inherited ItemAtPosEx(Pos, IsBeginGroup, IsFirstPart, IsVerticalDirection);
  if (Result = nil) and PtInRect(ClientRect, Pos) then
  begin
    IsBeginGroup := False;
    IsFirstPart := False;
    for I := 0 to ItemLinks.VisibleItemCount - 1 do
    begin
      Control := ItemLinks.VisibleItems[I].Control;
      if Control.CanCustomize and Control.FLastInRow then
      begin
        R := GetItemRect(Control);
        AVertical := Vertical;
        if AVertical and (R.Left <= Pos.X) and (Pos.X < R.Right) or
          not AVertical and (R.Top <= Pos.Y) and (Pos.Y < R.Bottom) then
        begin
          if AVertical and (Pos.Y < R.Top) or
            not AVertical and (Pos.X < R.Left) then
          begin
            IsFirstPart := True;
            if Control.Align in [iaCenter, iaRight] then
              Result := Control
            else
              Result := ItemLinks.VisibleItems[1].Control;
          end
          else
            Result := Control;
          Break;
        end;
      end;
    end;
  end;
end;

function TdxBarControl.NotHandleMouseMove(P: TPoint): Boolean;

  function ControlContainerActive: Boolean;
  var
    Control: TWinControl;
  begin
    Control := FindControl(GetActiveWindow);
    Result := (Control is TCustomdxBarControl) and
      (TCustomdxBarControl(Control).BarManager = BarManager);
  end;

begin
  with TDummyForm(BarManager.MainForm) do
    Result := inherited NotHandleMouseMove(P) or
      (DockingStyle <> dsNone) and
      ((FormStyle = fsMDIForm) and not Application.Active or
       (FormStyle <> fsMDIForm) and not Active and not ControlContainerActive);
end;

procedure TdxBarControl.PaintItem(AControl: TdxBarItemControl);
var
  AItemRect: TRect;
  DC: HDC;
  PrevClipRgn, Rgn: HRGN;
  ClipRgnExists: Boolean;
begin
  inherited;
  if (AControl = nil) or (AControl.ItemLink = nil) or
    (Bar <> nil) and Bar.LockUpdate then Exit;
  AItemRect := GetItemRect(AControl);
  DC := Canvas.Handle;
  PrevClipRgn := CreateRectRgn(0, 0, 0, 0);
  ClipRgnExists := GetClipRgn(DC, PrevClipRgn) = 1;
  Rgn := CreateRectRgnIndirect(AItemRect);
  SelectClipRgn(DC, Rgn);
  DeleteObject(Rgn);
  try
    if IsVertical(Self) then
      AControl.Paint(AItemRect, ptVert)
    else
      AControl.Paint(AItemRect, ptHorz);
    DrawSelectedItem(AControl);
  finally
    if ClipRgnExists then
      SelectClipRgn(DC, PrevClipRgn)
    else
      SelectClipRgn(DC, 0);
    DeleteObject(PrevClipRgn);
  end;
end;

procedure TdxBarControl.RebuildBar;
begin
  FrameChanged;
  RepaintBar;
end;

procedure TdxBarControl.RefreshShadow;
begin
  FShadow.Refresh;
end;

procedure TdxBarControl.SavePos;
begin
  if FBar.Visible and not FMoving and not BarManager.IsDestroying then
    if DockingStyle = dsNone then
      with Bar do
      begin
        FloatLeft := Self.Left;
        FloatTop := Self.Top;
        FloatClientWidth := ClientWidth;
        FloatClientHeight := ClientHeight;
      end
    else
    begin
      FBar.DockedDockingStyle := DockingStyle;
      if FDockControl.Main then
        FBar.DockedDockControl := nil
      else
        FBar.DockedDockControl := TdxBarDockControl(FDockControl);
      FBar.Row := GetRow;
      if GetDockCol <> nil then
      begin
        FBar.OneOnRow := GetDockCol.DockRow.ColList.Count = 1;
        FBar.DockedLeft := Left;
        FBar.DockedTop := Top;
      end;
    end;
end;

procedure TdxBarControl.SetFont;
begin
  Font := Bar.Font;
end;

procedure TdxBarControl.SetIsActive(Value: Boolean);
begin
  if not Value then
  begin
    if IsCustomizing and (SelectedItem <> nil) then
      SetMouseSelectedItem(nil);
    if IsActive and (SelectedItem is TdxBarButtonControl) and
      TdxBarButtonControl(SelectedItem).DroppedDown then
      SelectedItem.ControlInactivate(True);
    if IsDowned then
    begin
      IsDowned := False;
      if not IsCustomizing then {HideAll;//}BarLostFocus;
    end;
  end;
  inherited SetIsActive(Value);
end;

procedure TdxBarControl.SetDockingStyle(Value: TdxBarDockingStyle);
begin
  if DockingStyle <> Value then FTruncated := False;
  inherited;
end;

procedure TdxBarControl.SetKeySelectedItem(Value: TdxBarItemControl);
var
  PrevSelectedItem: TdxBarItemControl;
begin
  PrevSelectedItem := FSelectedItem;
  inherited SetKeySelectedItem(Value);
  if (FSelectedItem <> PrevSelectedItem) and
    (SelectedItem <> nil) and not SelectedItem.IsActive and not IsCustomizing then
    if SelectedItem is TdxBarSubItemControl then
      SelectedItem.ControlClick(False)
    else
      SelectedItem.ControlActivate(True);
end;

procedure TdxBarControl.SetMarkState(Value: TdxBarMarkState);
var
  R: TRect;
begin
  if IsCustomizing then Exit;
  if FMarkState <> Value then
  begin
    FMarkState := Value;
    FinishMoreButtonsHintTimer;
    R := MarkRect;
    if FMarkState = msPressed then
    begin
      //PlaySound(psMenuPopup);
      MapWindowPoints(Handle, 0, R, 2);
      FQuickPopup := TdxBarQuickControl.CreateWithOwnerBar(BarManager, Self);
      TdxBarQuickControl(FQuickPopup).Popup(R);
      PlaySound(psMenuPopup);
    end
    else
    begin
      if FQuickPopup <> nil then
      begin
        FQuickPopup.Free;
        FQuickPopup := nil;
      end;
      if FMarkState = msSelected then
      begin
        if DockingStyle = dsNone then StartMoreButtonsHintTimer;
        BarManager.HintActivate(True, LoadStr(DXBAR_MOREBUTTONS));
      end
      else
        if SelectedItem = nil then
          BarManager.HintActivate(False, '');
    end;
    InvalidateMark;
  end;
end;

procedure TdxBarControl.BarGetFocus(ASelectedItem: TdxBarItemControl);
var
  P: TPoint;
  AControl: TWinControl;
  ItemLink: TdxBarItemLink;
begin
  //if (ItemLinks.First <> nil) and (ItemLinks.First.Control <> nil) then
  begin
    GetCursorPos(P);
    AControl := FindControl(WindowFromPointEx(P));
    if (AControl is TCustomdxBarControl) and (AControl <> Self) then
      FinishMouseTracking(AControl.Handle);

    BarManager.MainForm.SendCancelMode(nil);

    BeforeBarGetFocusFocusedWnd := GetFocus;
    if not IsCustomizing then
      SetWindowPos(BarManager.MainForm.Handle, HWND_TOP, 0, 0, 0, 0,
        SWP_NOMOVE or SWP_NOSIZE);

    if ASelectedItem = nil then
    begin
      ItemLink := nil;
      repeat
        ItemLink := ItemLinks.Next(ItemLink);
      until (ItemLink = nil) or (ItemLink.Control <> nil){ and ItemLink.Control.CanCustomize};
      if ItemLink <> nil then
        ASelectedItem := ItemLink.Control;
    end;
    SetKeySelectedItem(ASelectedItem);
    IsActive := True;
    BarManager.FFocusedBarControl := Self;
  end;
end;

procedure TdxBarControl.BarLostFocus;
var
  P: TPoint;
  AControl: TWinControl;
begin
  if BarManager.FocusedBarControl = Self then
  begin
    BarManager.FFocusedBarControl := nil;
    SetKeySelectedItem(nil);
    IsActive := False;

    GetCursorPos(P);
    AControl := FindControl(WindowFromPointEx(P));
    if AControl is TCustomdxBarControl then
      with TCustomdxBarControl(AControl) do
      begin
        Windows.ScreenToClient(Handle, P);
        FLastMousePos := Point(-1, -1);
        PostMessage(Handle, WM_MOUSEMOVE, 0, MakeLParam(P.X, P.Y));  
      end;

    if Application.Active and BarManager.MainForm.Active and  // -> bug with toolbars' hiding (without Application.Active)
      IsWindowVisible(BeforeBarGetFocusFocusedWnd) then
      Windows.SetFocus(BeforeBarGetFocusFocusedWnd);
  end;
end;

procedure TdxBarControl.HideAll;
begin
  BarLostFocus;
  inherited HideAll;
{  if not BarManager.IsDestroying then
    ProcessPaintMessages;}
end;

procedure TdxBarControl.Repaint;
begin
  if not ((Bar <> nil) and Bar.LockUpdate) then inherited;
end;

procedure TdxBarControl.RepaintBar;
var
  PrevSelectedItemLink: TdxBarItemLink;
  P: TPoint;
begin
  if FDestroyFlag or (Bar <> nil) and Bar.LockUpdate or not HandleAllocated then Exit;

  PrevSelectedItemLink := nil;
  if IsCustomizing then
  begin
    if (BarManager.SelectedItem <> nil) and
      (BarManager.SelectedItem.Parent = Self) then
    begin
      PrevSelectedItemLink := BarManager.SelectedItem.ItemLink;
      BarManager.FSelectedItem := nil;
    end;
    FSelectedItem := nil;
  end;
  DestroyControls;
  CreateControls;
  if IsCustomizing and (PrevSelectedItemLink <> nil) then
    SetKeySelectedItem(PrevSelectedItemLink.Control);

  if DockingStyle = dsNone then
    if HandleAllocated then
    begin
      P := GetSizeForWidth(DockingStyle, ClientWidth);
      ClientWidth  := P.X;
      ClientHeight := P.Y;
    end
    else
  else
    FDockControl.UpdateDock;
  //Repaint;
  CalcControlsPositions;
  Invalidate;
end;

{ TdxBarSubMenuControl }

type
  TAnimationInfo = record
    MenuAnimations: TdxBarMenuAnimations;
    LeftDirection, TopDirection: Boolean;
    RealLeft, RealTop, RealClientWidth, RealClientHeight,
      BorderWidth, BorderHeight, FirstValue, Delta, Step: Integer;
    OldClientRect: TRect;
  end;

var
  AnimationBitmap: HBITMAP;
  AnimationBitmapDC: HDC;
  AnimationInfo: TAnimationInfo;
  AnimationThread: THandle;
  KillingAnimation: Boolean;

procedure TerminateAnimation(ASubMenu: TdxBarSubMenuControl);
var
  Msg: TMsg;
begin
  if (AnimatingSubMenu = ASubMenu) and (AnimatingSubMenu <> nil) then
  begin
    KillingAnimation := True;
    while MsgWaitForMultipleObjects(1, AnimationThread, False,
      INFINITE, QS_SENDMESSAGE) = WAIT_OBJECT_0 + 1 do
    begin
      if AnimatingSubMenu <> nil then
        PeekMessage(Msg, AnimatingSubMenu.Handle, 0, 0, PM_REMOVE);
      if (AnimatingSubMenu <> nil) and not AnimatingSubMenu.FDestroyFlag then
        DispatchMessage(Msg);
    end;
    ProcessPaintMessages;
  end;
end;

constructor TdxBarSubMenuControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 0;
  XDirection := xdRight;
  YDirection := ydBottom;
end;

destructor TdxBarSubMenuControl.Destroy;
begin
  if ChildBar <> nil then ChildBar.Free;
  if ParentBar <> nil then ParentBar.ChildBar := nil;
  inherited Destroy;
end;

function TdxBarSubMenuControl.GetBarSize: Integer;
begin
  if ItemLinks.Owner is TdxBarPopupMenu then
    Result := TdxBarPopupMenu(ItemLinks.Owner).BarSize
  else
    if ItemLinks.Owner is TCustomdxBarSubItem then
      Result := TCustomdxBarSubItem(ItemLinks.Owner).BarSize
    else
      Result := 0;
end;

function TdxBarSubMenuControl.GetBorderSize: Integer;
begin
  if Flat then
    Result := 2
  else
    Result := 3;
end;

function TdxBarSubMenuControl.GetDetachCaptionSize: Integer;
begin
  Result := Canvas.TextHeight('Qq') div 2;
  if not Odd(Result) then Inc(Result);
end;

function TdxBarSubMenuControl.GetMaxVisibleCount: Integer;
var
  I: Integer;
begin
  for I := TopIndex to ItemLinks.VisibleItemCount - 1 do
    if ItemLinks.VisibleItems[I].ItemRect.Bottom = 0 then
    begin
      Result := I - TopIndex;
      Exit;
    end;
  Result := ItemLinks.VisibleItemCount - TopIndex;
end;

function TdxBarSubMenuControl.GetToolbarItemsBrush: HBRUSH;
begin
  if Flat then
    Result := COLOR_WINDOW + 1
  else
    Result := COLOR_BTNFACE + 1;
end;

procedure TdxBarSubMenuControl.SetDetachCaptionSelected(Value: Boolean);
begin
  if IsCustomizing or (GetCapture <> 0) then Exit;
  if FDetachCaptionSelected <> Value then
  begin
    if Value then FinishMouseTracking(Handle);
    FDetachCaptionSelected := Value;
    InvalidateDetachCaption;
    if Value then StartMouseTracking(Handle);
    SetCursorForMoving(Value);
    if Value then
      BarManager.HintActivate(True, LoadStr(DXBAR_DRAGTOMAKEMENUFLOAT))
    else
      if SelectedItem = nil then
        BarManager.HintActivate(False, '');
  end;
end;

procedure TdxBarSubMenuControl.SetTopIndex(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FTopIndex <> Value then
  begin
    FTopIndex := Value;
    Repaint;
  end;
end;

procedure TdxBarSubMenuControl.CalcControlsPositions(Size: PPoint);
var
  ARecentItemCount: Integer;
  AExtendedView: Boolean;
  R: TRect;
  I, AClientHeight, W: Integer;
  LastWasRecentItem: Boolean;
  AItemLink: TdxBarItemLink;
begin
  ItemLinks.EmptyItemRects;

  ARecentItemCount := ItemLinks.MostRecentItemCount;
  if ARecentItemCount = -1 then
    ARecentItemCount := ItemLinks.CanVisibleItemCount;
  AExtendedView := ExtendedView;

  if Flat then
    R := Rect(1 + BarSize, 1, ClientWidth - 1, 1)
  else
    R := Rect(
      2 + BarSize, 2 * Byte(not Detachable),
      ClientWidth - 2, 2 * Byte(not Detachable));
  if Size = nil then
    AClientHeight := ClientHeight - 1 - Byte(not Flat) - TextSize * Byte(MarkExists)
  else
  begin
    Size^.X := 0;
    AClientHeight := MaxInt;
  end;
             
  LastWasRecentItem := True;
  for I := TopIndex to ItemLinks.VisibleItemCount - 1 do
  begin
    AItemLink := ItemLinks.VisibleItems[I];
    
    AItemLink.Control.FNonRecent :=
      AExtendedView and (AItemLink.RecentIndex >= ARecentItemCount);
    AItemLink.Control.FChangeRecentGroup :=
      AExtendedView and ((I > TopIndex) or Detachable) and
      (AItemLink.Control.FNonRecent = LastWasRecentItem);
    if AItemLink.Control.FChangeRecentGroup and not Flat then Inc(R.Top);

    if AItemLink.BeginGroup and (I > TopIndex) and
      not (UpArrowExists and (I = TopIndex + 1)) then
      Inc(R.Top, BeginGroupSize);
    R.Bottom := R.Top + AItemLink.Control.Height;
    if R.Bottom > AClientHeight then Break;
    if Size <> nil then
    begin
      W := AItemLink.Control.Width;
      if W > Size^.X then Size^.X := W;
    end;

    LastWasRecentItem := not AItemLink.Control.FNonRecent;
                                 
    AItemLink.ItemRect := R;
    R.Top := R.Bottom;
  end;
  
  if Size <> nil then
  begin
    if Size^.X = 0 then
      Size^.X := 100
    else
      if Flat then
        Inc(Size^.X, 2 * 2 + BarSize)
      else
        Inc(Size^.X, 2 * 3 + BarSize);
    if (R.Top <= 2) or MarkExists then
      Inc(R.Top, TextSize);
    if Flat then
      Size^.Y := 1 + R.Top + 2
    else
      Size^.Y := 1 + R.Top + 3;
    if Detachable then
      Inc(Size^.Y, DetachCaptionAreaSize);
  end;
end;

procedure TdxBarSubMenuControl.CreateLightBrush;
var
  Color: COLORREF;
  R, G, B: Integer;
  DC: HDC;
  LogPalette: TLogPalette;
begin
  Color := GetSysColor(COLOR_BTNFACE);
  R := GetRValue(Color) + dxBarNonrecentlyUsedItemsColorDelta;
  if R > 255 then R := 255;
  G := GetGValue(Color) + dxBarNonrecentlyUsedItemsColorDelta;
  if G > 255 then G := 255;
  B := GetBValue(Color) + dxBarNonrecentlyUsedItemsColorDelta;
  if B > 255 then B := 255;

  DC := GetDC(0);
  if BarManager.ShowRecentItemsFirst and (GetDeviceCaps(DC, BITSPIXEL) <= 8) then
  begin
    with LogPalette do
    begin
      palVersion := $0300;
      palNumEntries := 1;
      with palPalEntry[0] do
      begin
        peRed := R;
        peGreen := G;
        peBlue := B;
        peFlags := 0;
      end;
    end;
    FLightPalette := CreatePalette(LogPalette);
    FLightBrush := CreateSolidBrush(PaletteIndex(0));
  end
  else
  begin
    Color := RGB(R, G, B);
    FLightBrush := CreateSolidBrush(Color);
  end;
  ReleaseDC(0, DC);
end;

procedure TdxBarSubMenuControl.DestroyLightBrush;
begin
  if FLightBrush <> 0 then
  begin
    DeleteObject(FLightBrush);
    FLightBrush := 0;
  end;
  if FLightPalette <> 0 then
  begin
    DeleteObject(FLightPalette);
    FLightPalette := 0;
  end;
end;

procedure TdxBarSubMenuControl.PreparePalette(DC: HDC);
begin
  if FLightPalette <> 0 then
  begin
    SelectPalette(DC, FLightPalette, True);
    RealizePalette(DC);
  end;
end;

procedure TdxBarSubMenuControl.UnpreparePalette(DC: HDC);
begin
  if FLightPalette <> 0 then
  begin
    SelectPalette(DC, GetStockObject(DEFAULT_PALETTE), True);
    RealizePalette(DC);
  end;  
end;

procedure TdxBarSubMenuControl.ExpandMenu;
begin
  if MarkExists then
  begin
    ShowFullMenus := True;
    FShowAnimation := True;
    FExpandingMenu := True;
    try
      DestroyWnd;
    finally
      FExpandingMenu := False;
    end;
    Left := FOnShowLeft;
    Top := FOnShowTop;
    Show;
  end;  
end;

function TdxBarSubMenuControl.ExtendedView: Boolean;
begin
  Result := BarManager.ShowRecentItemsFirst and ShowFullMenus;
end;

procedure TdxBarSubMenuControl.InvalidateDetachCaption;
const
  MarkSize = 33;
  FlatColors: array[Boolean] of COLORREF = (COLOR_BTNSHADOW, COLOR_BTNTEXT);
  Colors: array[Boolean] of COLORREF = (COLOR_INACTIVECAPTION, COLOR_ACTIVECAPTION);
var
  DC: HDC;
  R: TRect;
  Brush: HBRUSH;
  I: Integer;
begin
  DC := GetWindowDC(Handle);
  R := DetachCaptionRect;
  if Flat then
  begin
    if DetachCaptionSelected then
    begin
      FrameFlatSelRect(DC, R);
      InflateRect(R, -1, -1);
      Brush := ToolbarSelBrush;
    end
    else
      Brush := BarManager.FlatToolbarsBrush;
    FillRect(DC, R, Brush);
    Brush := FlatColors[DetachCaptionSelected] + 1;
    with R do
    begin
      InflateRect(R, -(Right - Left - MarkSize) div 2, -1);
      Right := Left + MarkSize;
      for I := Top to Bottom - 1 do
        if not Odd(I - Top) then
          FillRect(DC, Rect(Left, I, Right, I + 1), Brush);
    end;
  end
  else
    FillRect(DC, R, Colors[DetachCaptionSelected] + 1);
  ReleaseDC(Handle, DC);
end;

function TdxBarSubMenuControl.MouseOnUpArrow: Boolean;
var
  P: TPoint;
  R: TRect;
begin
  GetCursorPos(P);
  Windows.ScreenToClient(Handle, P);
  R := GetItemRect(ItemLinks.CanVisibleItems[TopIndex].Control);
  Result := PtInRect(R, P);
end;

function TdxBarSubMenuControl.MouseOnDownArrow: Boolean;
var
  P: TPoint;
  R: TRect;
begin
  GetCursorPos(P);
  Windows.ScreenToClient(Handle, P);
  R := GetItemRectEx(ItemLinks.VisibleItems[TopIndex + MaxVisibleCount - 1].Control, True);
  R.Bottom := ClientHeight - 2;
  if MarkExists then Dec(R.Bottom, TextSize);
  Result := PtInRect(R, P);
end;

function TdxBarSubMenuControl.MouseOnMark: Boolean;
var
  P: TPoint;
begin
  GetCursorPos(P);
  Windows.ScreenToClient(Handle, P);
  Result := PtInRect(MarkRect, P);
end;

procedure ExpandMenuTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT; Time: DWORD); stdcall;
begin
  with TdxBarSubMenuControl(FindControl(Wnd)) do
  begin
    KillExpandMenuTimer;
    if idEvent = 3 then
      MarkState := msPressed
    else
      if ChildBar = nil then
        MarkState := msSelected;
  end;
end;

procedure TdxBarSubMenuControl.SetExpandMenuTimer(Time: UINT; ExpandAfterDelay: Boolean);
begin
  FExpandMenuTimer := SetTimer(Handle, 2 + Byte(ExpandAfterDelay), Time, @ExpandMenuTimerProc);
end;

procedure TdxBarSubMenuControl.KillExpandMenuTimer;
begin
  if FExpandMenuTimer <> 0 then
  begin
    KillTimer(Handle, FExpandMenuTimer);
    FExpandMenuTimer := 0;
  end;
end;

procedure TdxBarSubMenuControl.WMGetDlgCode;
begin
  Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS or DLGC_WANTTAB;
end;

procedure TdxBarSubMenuControl.WMKeyDown(var Message: TWMKeyDown);
var
  Shift: TShiftState;
  ParentBarControl: TCustomdxBarControl;
begin
  TerminateAnimation(Self);

  Shift := KeyDataToShiftState(Message.KeyData);
  if (Message.CharCode in [VK_DOWN, VK_TAB]) and MarkExists then
    if (Message.CharCode = VK_DOWN) and (Shift = [ssCtrl]) then
    begin
      MarkState := msPressed;
      Exit;
    end
    else
      if (Shift = []) and (SelectedItem <> nil) then
        with SelectedItem.ItemLink do
          if VisibleIndex = Owner.VisibleItemCount - 1 then
          begin
            MarkState := msPressed;
            SendMessage(Handle, WM_KEYDOWN, Message.CharCode, 1);
            Exit;
          end;

  inherited;
  if (ActiveBarControl = nil) or SelectedItemWantsKey(Message.CharCode) then
    Exit;
  with Message do
  begin
    case CharCode of
      VK_ESCAPE:
        if (ParentBar <> nil) and (ParentBar.FSelectedItem <> nil) then
        begin
          ParentBar.FSelectedItem.ControlInactivate(True);
          if ParentBar is TdxBarControl then
            TdxBarControl(ParentBar).IsDowned := False;
        end
        else
          Hide;
      VK_LEFT:
        begin
          if ParentBar <> nil then
            ParentBarControl := ParentBar
          else
            if FDropDownButton <> nil then
              ParentBarControl := FDropDownButton.Parent
            else
              ParentBarControl := nil;
          if (ParentBarControl <> nil) and (ParentBarControl.SelectedItem <> nil) then
            if ParentBarControl is TdxBarSubMenuControl then
              ParentBarControl.SelectedItem.ControlInactivate(True)
            else
            begin
              ParentBarControl := GetParentBarForBar(Self);
              if ParentBarControl <> nil then
                if IsRealVertical(ParentBarControl) then
                  Message.Result := SendMessage(Handle, WM_KEYDOWN, VK_ESCAPE, 0)
                else
                  Message.Result := SendMessage(ParentBarControl.Handle,
                    WM_KEYDOWN, VK_LEFT, 0);
            end;
        end;
      VK_RIGHT:
        begin
          ParentBarControl := GetParentBarForBar(Self);
          if ParentBarControl <> nil then
            Message.Result := SendMessage(ParentBarControl.Handle,
              WM_KEYDOWN, VK_RIGHT, 0);
        end;
      VK_RETURN:
        if SelectedItem <> nil then SelectedItem.Click(False);
    end;
  end;
end;

procedure TdxBarSubMenuControl.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if FScrollTimerId <> 0 then Exit;
  inherited;
  if not BarControlExists(Self) then Exit;
  if FIgnoreMouseClick then Exit;
  TerminateAnimation(Self);
  if DetachCaptionSelected then
    DoDetachMenu
  else
    if MarkExists and MouseOnMark then
      if MarkState = msNone then
      begin
        SetKeySelectedItem(nil);
        MarkState := msSelected;
      end
      else
      begin
  //      FIgnoreMouseClick := True;
        MarkState := msPressed;
      end;
end;

procedure EndScrollingSubMenu(Wnd: HWND);
var
  P: TPoint;
begin
  with TdxBarSubMenuControl(FindControl(Wnd)) do
  begin
    KillTimer(Handle, FScrollTimerId);
    FScrollTimerId := 0;
    FLastMousePos := Point(-1, -1);
    GetCursorPos(P);
    if BarManager.Dragging then
    begin
      Windows.ScreenToClient(BarManager.MainForm.Handle, P);
      PostMessage(BarManager.MainForm.Handle, WM_MOUSEMOVE, 0, MakeLParam(P.X, P.Y));
    end
    else
    begin
      Windows.ScreenToClient(Handle, P);
      SendMessage(Handle, WM_MOUSEMOVE, 0, MakeLParam(P.X, P.Y));
    end;
  end;
end;

procedure UpArrowTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT; Time: DWORD); stdcall;
begin
  with TdxBarSubMenuControl(FindControl(Wnd)) do
    if UpArrowExists and MouseOnUpArrow then
      TopIndex := TopIndex - 1
    else
      EndScrollingSubMenu(Wnd);
end;

procedure DownArrowTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT; Time: DWORD); stdcall;
begin
  with TdxBarSubMenuControl(FindControl(Wnd)) do
    if DownArrowExists and MouseOnDownArrow then
      TopIndex := TopIndex + 1
    else
      EndScrollingSubMenu(Wnd);
end;

procedure TdxBarSubMenuControl.WMMouseLeave(var Message: TMessage);
begin
  DetachCaptionSelected := False;
  inherited;
end;

procedure TdxBarSubMenuControl.WMMouseMove(var Message: TWMMouseMove);
var
  P: TPoint;
begin
  P := SmallPointToPoint(Message.Pos);
  if not NotHandleMouseMove(P) then
  begin
    TerminateAnimation(Self);
    if not BarControlExists(Self) then Exit;
  end
  else
    if AnimatingSubMenu = Self then Exit;
  if WantMouse and (FSubItem <> nil) and (ParentBar <> nil) then
    ParentBar.SetMouseSelectedItem(FSubItem);
  if Detachable then
    DetachCaptionSelected := MouseOnDetachCaption;
  if MarkExists then
    if MouseOnMark then
      MarkState := msSelected
    else
      MarkState := msNone;
  Windows.ClientToScreen(Handle, P);  
  if UpArrowExists and MouseOnUpArrow then
    if (FScrollTimerId = 0) and ((FLastMousePos.X <> P.X) or (FLastMousePos.Y <> P.Y)) then
    begin
      if SelectedItem = BarManager.SelectedItem then
        BarManager.FSelectedItem := nil;  // otherwise BarManager will hide all
      SetKeySelectedItem(nil);
      FScrollTimerId := SetTimer(Handle, 1, dxBarScrollMenuTime, @UpArrowTimerProc);
    end
    else
  else
    if DownArrowExists and MouseOnDownArrow then
      if (FScrollTimerId = 0) and ((FLastMousePos.X <> P.X) or (FLastMousePos.Y <> P.Y)) then
      begin
        if SelectedItem = BarManager.SelectedItem then
          BarManager.FSelectedItem := nil;  // otherwise BarManager will hide all
        SetKeySelectedItem(nil);
        FScrollTimerId := SetTimer(Handle, 1, dxBarScrollMenuTime, @DownArrowTimerProc);
      end
      else
    else
    begin
      if FScrollTimerId > 0 then
      begin
        KillTimer(Handle, FScrollTimerId);
        FScrollTimerId := 0;
        FLastMousePos := Point(-1, -1);
      end;
      inherited;
    end;
end;

procedure TdxBarSubMenuControl.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  with Message.CalcSize_Params^ do
  begin
    InflateRect(rgrc[0], -1, -1);
    if Detachable then
      Inc(rgrc[0].Top, DetachCaptionAreaSize);
  end;
end;

procedure TdxBarSubMenuControl.WMNCHitTest(var Message: TWMNCHitTest);
var
  R: TRect;
begin
  if Detachable then
  begin
    R := DetachCaptionRect;
    OffsetRect(R, Left, Top);
    if PtInRect(R, SmallPointToPoint(Message.Pos)) then
      Message.Result := HTCLIENT
    else
      inherited;
  end
  else
    inherited;
end;

procedure TdxBarSubMenuControl.WMNCPaint(var Message: TWMNCPaint);
var
  R: TRect;
  DC: HDC;

  procedure DrawFlatBorder;
  begin
    FrameRect(DC, R, BarManager.FlatToolbarsBorderBrush);
    DrawOwnerLink(DC);
  end;

begin
  inherited;
  GetWindowRect(R);
  OffsetRect(R, -R.Left, -R.Top);
  DC := GetWindowDC(Handle);
  if Flat then
    with R do
    begin
      DrawFlatBorder;
      if Detachable then
      begin
        InflateRect(R, -1, -1);
        Bottom := Top + 1;
        FillRect(DC, R, COLOR_WINDOW + 1);
        Top := Bottom;
        Bottom := Top + DetachCaptionSize;
        FillRect(DC, Rect(Left, Top, Left + 1, Bottom), COLOR_WINDOW + 1);
        FillRect(DC, Rect(Right - 1, Top, Right, Bottom), COLOR_WINDOW + 1);
        InvalidateDetachCaption;
      end;
    end
  else
  begin
    with R do
    begin
      FillRect(DC, Rect(Left, Top, Left + 1, Bottom - 1), COLOR_BTNFACE + 1);
      FillRect(DC, Rect(Left + 1, Top, Right - 1, Top + 1), COLOR_BTNFACE + 1);
    end;
    DrawEdge(DC, R, BDR_RAISEDOUTER, BF_BOTTOMRIGHT);
    if Detachable then
    begin
      InflateRect(R, -1, -1);
      DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT - BF_BOTTOM);
      InflateRect(R, -1, -1);
      R.Bottom := R.Top + DetachCaptionAreaSize - 1;
      FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
      InvalidateDetachCaption;
    end;
  end;
  ReleaseDC(Handle, DC);
end;

procedure TdxBarSubMenuControl.WMRButtonDown(var Message: TWMRButtonUp);
begin
  inherited;
  if IsContextMenu then
    with TMessage(Message) do
      SendMessage(Handle, WM_LBUTTONDOWN, WParam, LParam);
end;

procedure TdxBarSubMenuControl.WMRButtonUp(var Message: TWMRButtonUp);
begin
  inherited;
  if IsContextMenu then
    with TMessage(Message) do
      SendMessage(Handle, WM_LBUTTONUP, WParam, LParam);
end;

procedure TdxBarSubMenuControl.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Canvas.Font := Font;
  CalcDrawingConsts;
end;

procedure TdxBarSubMenuControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_CLIPCHILDREN or WS_CLIPSIBLINGS or WS_POPUP;
    ExStyle := ExStyle or WS_EX_TOPMOST;
    WindowClass.Style :=
      CS_DBLCLKS or CS_HREDRAW or CS_VREDRAW or CS_OWNDC or CS_SAVEBITS;
    if ParentWnd > 0 then
      WndParent := ParentWnd
    else
      WndParent := BarManager.MainForm.Handle;
  end;
end;

function AnimationThreadProc(lpParameter: Pointer): DWORD; stdcall;
var
  I: Integer;
  FirstTime: DWORD;
  DC: HDC;

  procedure DoOneStepOfAnimation;
  var
    NewLeft, NewTop, NewClientWidth, NewClientHeight: Integer;
    R, R1, R2: TRect;
  begin
    with AnimatingSubMenu, AnimationInfo do
    begin
      if FirstValue >= 0 then
      begin
        NewClientWidth := Step * I;
        NewClientHeight := FirstValue + NewClientWidth;
        if MenuAnimations = maSlide then NewClientWidth := ClientWidth;
      end
      else
      begin
        NewClientHeight := Step * I;
        NewClientWidth := Abs(FirstValue) + NewClientHeight;
      end;
      if LeftDirection then
        NewLeft := Left - (NewClientWidth - ClientWidth)
      else
        NewLeft := Left;
      if TopDirection then
        NewTop := Top - (NewClientHeight - ClientHeight)
      else
        NewTop := Top;

      SetWindowPos(Handle, 0, NewLeft, NewTop,
        BorderWidth + NewClientWidth, BorderHeight + NewClientHeight,
        SWP_NOZORDER or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      DC := GetDC(Handle);
      PreparePalette(DC);

      R1 := OldClientRect;
      if TopDirection then
      begin
        R := Rect(0, 0, NewClientWidth, NewClientHeight);
        OffsetRect(R1, 0, NewClientHeight - R1.Bottom);
        with OldClientRect do
          BitBlt(DC, Left, Top, Right - Left, Bottom - Top,
            DC, R1.Left, R1.Top, SRCCOPY);
        R1 := OldClientRect;
        BitBlt(DC, 0, R1.Bottom, ClientWidth, ClientHeight - R1.Bottom,
          AnimationBitmapDC, R.Left, R.Top + R1.Bottom, SRCCOPY);
        BitBlt(DC, R1.Right, R1.Top, ClientWidth - R1.Right, R1.Bottom - R1.Top,
          AnimationBitmapDC, R.Left + R1.Right, R.Top, SRCCOPY);
      end
      else
        if LeftDirection then
        begin
          R := Rect(RealClientWidth - ClientWidth, RealClientHeight - ClientHeight,
            RealClientWidth, RealClientHeight);
          OffsetRect(R1, ClientWidth - R1.Right, 0);
          R2 := R1;
          OffsetRect(R2, 0, ClientHeight - R1.Bottom);
          with R2 do
            BitBlt(DC, Left, Top, Right - Left, Bottom - Top,
              DC, R1.Left, R1.Top, SRCCOPY);
          R1 := R2;
          BitBlt(DC, 0, 0, ClientWidth, R1.Top, AnimationBitmapDC, R.Left, R.Top, SRCCOPY);
          BitBlt(DC, 0, R1.Top, R1.Left, ClientHeight - R1.Top,
            AnimationBitmapDC, R.Left, R.Top + R1.Top, SRCCOPY);
        end
        else
        begin
          R := Rect(0, RealClientHeight - ClientHeight, ClientWidth, RealClientHeight);
          OffsetRect(R1, 0, ClientHeight - R1.Bottom);
          with R1 do
            BitBlt(DC, Left, Top, Right - Left, Bottom - Top,
              DC, OldClientRect.Left, OldClientRect.Top, SRCCOPY);
          BitBlt(DC, 0, 0, ClientWidth, R1.Top, AnimationBitmapDC, R.Left, R.Top, SRCCOPY);
          BitBlt(DC, R1.Right, R1.Top, ClientWidth - R1.Right, ClientHeight - R1.Top,
            AnimationBitmapDC, R.Left + R1.Right, R.Top + R1.Top, SRCCOPY);
        end;
      OldClientRect := ClientRect;

      UnpreparePalette(DC);
      UpdateColors(DC);
      ReleaseDC(Handle, DC);
    end;
  end;

begin
  Result := 0;
  with AnimationInfo do
    for I := 1 to Delta div Step do
    begin
      if KillingAnimation then Break;
      FirstTime := GetTickCount;
      DoOneStepOfAnimation;
      Sleep(1);
      while (GetTickCount - FirstTime < 1) and not KillingAnimation do;
    end;
    
  DeleteObject(SelectObject(AnimationBitmapDC, AnimationBitmap));
  DeleteDC(AnimationBitmapDC);

  with AnimatingSubMenu, AnimationInfo do
  begin
    FShowAnimation := False;
    if not FDestroyFlag then
      SetWindowPos(Handle, 0, RealLeft, RealTop,
        BorderWidth + RealClientWidth, BorderHeight + RealClientHeight,
        SWP_NOZORDER or SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_FRAMECHANGED {to enforce WM_WINDOWPOSCHANGED});
    if not FDestroyFlag then Repaint;
  end;

  AnimatingSubMenu := nil;
  AnimationThread := 0;
  KillingAnimation := False;
  CloseHandle(AnimationThread);
end;

procedure TdxBarSubMenuControl.CreateWnd;
var
  ChangeXDirection, ChangeYDirection: Boolean;
  AnimationThreadID: DWORD;
begin
  //ProcessPaintMessages; - destroys submenu because of PeekMessage
  CreateLightBrush;
  inherited CreateWnd;
  FOnShowLeft := Left;
  FOnShowTop := Top;
  IsActive := True;
  SetRecentItemCount;
  FTopIndex := -1;
  TopIndex := 0;
  SetSizeAndCheckBounds(ChangeXDirection, ChangeYDirection);
//  PlaySound(psMenuPopup);

  if FShowAnimation then
    with AnimationInfo do
    begin
      RealLeft := Left;
      RealTop := Top;
      RealClientWidth := ClientWidth;
      RealClientHeight := ClientHeight;
      BorderWidth := Width - ClientWidth;
      BorderHeight := Height - ClientHeight;
      LeftDirection := ((XDirection = xdLeft) and not ChangeXDirection) or
        ((XDirection = xdRight) and ChangeXDirection);
      TopDirection := ((YDirection = ydTop) and not ChangeYDirection) or
        ((YDirection = ydBottom) and ChangeYDirection);
      MenuAnimations := FMenuAnimations;
      if MenuAnimations = maRandom then
        if Random(100) < 50 then
          MenuAnimations := maUnfold
        else
          MenuAnimations := maSlide;
      if MenuAnimations = maUnfold then
      begin
        FirstValue := ClientHeight - ClientWidth;
        if FirstValue > 0 then
        begin
          OldClientRect := Rect(0, 0, 0, FirstValue);
          Delta := ClientWidth;
        end
        else
        begin
          OldClientRect := Rect(0, 0, -FirstValue, 0);
          Delta := ClientHeight;
        end;
        Step := 8;
      end
      else
      begin
        FirstValue := 0;
        OldClientRect := Rect(0, 0, ClientWidth, 0);
        Delta := ClientHeight;
        Step := 17;
      end;

      AnimationBitmap := CreateCompatibleBitmap(Canvas.Handle, RealClientWidth, RealClientHeight);
      AnimationBitmapDC := CreateCompatibleDC(Canvas.Handle);
      AnimationBitmap := SelectObject(AnimationBitmapDC, AnimationBitmap);
      FShowAnimation := False;
      PaintWindow(AnimationBitmapDC);
      FShowAnimation := True;
      DestroyLightBrush;
      CreateLightBrush;

      AnimatingSubMenu := Self;
      AnimationThread := CreateThread(nil, 0, @AnimationThreadProc, nil, 0, AnimationThreadID);
    end;
    
  PlaySound(psMenuPopup);
end;

procedure TdxBarSubMenuControl.DestroyWindowHandle;
begin
  if BarManager.Dragging and (BarManager.DraggingItemLink <> nil) and
    (ItemLinks.IndexOf(BarManager.DraggingItemLink) > -1) and
    (BarManager.FDraggingItemLinkParentHandle = 0) then
  begin
    BarManager.FDraggingItemLinkParentHandle := WindowHandle;
    Perform(WM_DESTROY, 0, 0);
    SetWindowLong(WindowHandle, GWL_WNDPROC, Longint(DefWndProc));
    ShowWindow(WindowHandle, SW_HIDE);
    DestroyControls;
    WindowHandle := 0;
  end
  else inherited;
end;

procedure TdxBarSubMenuControl.DestroyWnd;
begin
  TerminateAnimation(Self);
  if FScrollTimerId > 0 then
  begin
    KillTimer(Handle, FScrollTimerId);
    FScrollTimerId := 0;
  end;
  KillExpandMenuTimer;
  if (ChildBar <> nil) and ChildBar.HandleAllocated then ChildBar.DestroyWnd;
  if not FExpandingMenu then
  begin
    IsActive := False;
    if FDropDownButton <> nil then
      with FDropDownButton do
        if Parent.HandleAllocated then
        begin
          DoCloseUp;
          Repaint;
          if MousePressed then
          begin
            Parent.FIgnoreMouseClick := ArrowPressed;
            if Parent is TdxBarControl then Parent.HideAll;
          end
          else
            if (GetKeyState(VK_ESCAPE) >= 0) and
              (GetKeyState(VK_LEFT) >= 0) and (GetKeyState(VK_RIGHT) >= 0) then
              Parent.HideAll;
        end;
  end;
  inherited DestroyWnd;
  if Self = CustomizedPopup then CustomizedPopup := nil;
//  ProcessPaintMessages;
  DoCloseUp;
  DestroyLightBrush;
end;

procedure TdxBarSubMenuControl.DoCloseUp;
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self);
end;

procedure TdxBarSubMenuControl.DoPopup;
begin
  if Assigned(FOnPopup) then FOnPopup(Self);
end;

procedure TdxBarSubMenuControl.Paint;
const
  BrushColors: array[Boolean] of COLORREF = (COLOR_BTNHIGHLIGHT, COLOR_BTNSHADOW);
var
  R, BarRect: TRect;
  AMaxVisibleCount, I: Integer;
  DC: HDC;
  ABrush: HBRUSH;
  AControl: TdxBarItemControl;

  procedure DrawArrow(UpArrow: Boolean);
  var
    X, Y, Size: Integer;
    P: array[1..3] of TPoint;
    APen: HPEN;
    ABrush: HBRUSH;
    Rgn: HRGN;
  begin
    Size := TextSize div 3 - 1;
    X := (ClientWidth - BarSize) div 2;
    if UpArrow then
      Y := (TextSize - Size) div 2 + Size - 1
    else
      if MarkExists then
        Y := R.Bottom - (TextSize - Size) div 2 - Size
      else
        Y := ClientHeight - (TextSize - Size) div 2 - Size;
    P[1] := Point(X - (Size - 1), Y);
    P[2] := Point(X + (Size - 1), Y);
    P[3] := Point(X, Y - (2 * Byte(UpArrow) - 1) * (Size - 1));

    APen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNTEXT)));
    ABrush := SelectObject(DC, GetSysColorBrush(COLOR_BTNTEXT));
    Polygon(DC, P, 3);
    SelectObject(DC, ABrush);
    DeleteObject(SelectObject(DC, APen));

    if UpArrow then
    begin
      Dec(P[1].X);
      Inc(P[1].Y);
      Inc(P[2].X, 2);
      Inc(P[2].Y);
      Dec(P[3].Y);
    end
    else
    begin
      Inc(P[2].X);
      Inc(P[3].Y);
    end;
    Rgn := CreatePolygonRgn(P, 3, WINDING);
    ExtSelectClipRgn(DC, Rgn, RGN_DIFF);
    DeleteObject(Rgn);
  end;

  procedure DrawMark;
  var
    APen: HPEN;
    l_Size, X, Y, I: Integer;

    procedure DrawOneMark(const Y: Integer);
    begin
      MoveToEx(DC, X, Y, nil);
      LineTo(DC, X + l_Size div 2, Y + l_Size div 2);
      LineTo(DC, X + l_Size + 1, Y - 1);
    end;

  begin
    l_Size := MarkArrowSize;
    APen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNTEXT)));
    with R do
    begin
      X := (Left + Right - (l_Size + 1)) div 2;
      Y := Top + (MarkSize - 2 * l_Size) div 2;
      for I := Y to Y + l_Size - 1 do
        DrawOneMark(I + Byte(I >= Y + l_Size div 2) * l_Size div 2);
    end;
    DeleteObject(SelectObject(DC, APen));
  end;

begin
  if FShowAnimation or FDestroyFlag then Exit;
              
  DC := Canvas.Handle;
  ABrush := ToolbarBrush;

  R := ClientRect;
  if Flat then
  begin
    FrameRect(DC, R, GetSysColorBrush(ToolbarItemsBrush - 1));
    with R do
      FillRect(DC, Rect(Left, Top + 1, Left + 1, Bottom - 1), ABrush);
  end
  else
  begin
    if Detachable then Dec(R.Top, 2);
    DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
    InflateRect(R, -1, -1);
    FrameRect(DC, R, ABrush);
  end;  

  InflateRect(R, -1, -1);
  R.Right := R.Left + BarSize;
  BarRect := R;
  try
    if ItemLinks.CanVisibleItemCount = 0 then Exit;

    CalcControlsPositions(nil);
    AMaxVisibleCount := GetMaxVisibleCount;
    if AMaxVisibleCount = 0 then AMaxVisibleCount := 1;

    if UpArrowExists then
    begin
      R := ItemLinks.VisibleItems[TopIndex].ItemRect;
      DrawArrow(True);
      if Flat then Dec(R.Left);
      FillRect(DC, R, ToolbarItemsBrush);
      SelectClipRgn(DC, 0);
    end;
    AControl := ItemLinks.VisibleItems[TopIndex + AMaxVisibleCount - 1].Control;
    R := GetItemRectEx(AControl, True);
    if DownArrowExists then
    begin
      DrawArrow(False);
      if AControl.FChangeRecentGroup and not Flat then
      begin
        with R do
          FillRect(DC, Rect(Left - 1, Top, Right + 1, Top + 1),
            BrushColors[AControl.FNonRecent] + 1);
        Inc(R.Top);
      end;
      if Flat then Dec(R.Left);
      FillRect(DC, R, ToolbarItemsBrush);
    end
    else
      if Flat then Dec(R.Left);
    R.Top := R.Bottom;
    R.Bottom := ClientHeight - 1 - Byte(not Flat);
    if MarkExists then Dec(R.Bottom, TextSize);
    FillRect(DC, R, ToolbarItemsBrush);
    if DownArrowExists then SelectClipRgn(DC, 0);
    if MarkExists then
    begin
      R.Top := R.Bottom;
      R.Bottom := R.Top + TextSize;
      Dec(R.Bottom, MarkSize);
      FillRect(DC, R, ToolbarItemsBrush);
      R.Top := R.Bottom;
      Inc(R.Bottom, MarkSize);
      if Flat then
        with R do
        begin
          FillRect(DC, Rect(Left, Top, Left + 1, Bottom), ToolbarItemsBrush);
          Inc(Left);
        end;
      if MarkState = msSelected then
      begin
        if Flat then
        begin
          FrameFlatSelRect(DC, R);
          ABrush := ToolbarSelBrush;
        end
        else
        begin
          DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
          ABrush := FLightBrush;
        end;
        InflateRect(R, -1, -1);
        PreparePalette(DC);
        FillRect(DC, R, ABrush);
        UnpreparePalette(DC);
        InflateRect(R, 1, 1);
      end
      else
        FillRect(DC, R, ToolbarItemsBrush);
      DrawMark;
    end;

    for I := TopIndex + Byte(UpArrowExists) to TopIndex + AMaxVisibleCount - 1 - Byte(DownArrowExists) do
    begin
      AControl := ItemLinks.VisibleItems[I].Control;
      AControl.FLastInRow := False;
      PaintItem(AControl);
    end;

    if DownArrowExists and (TopIndex + AMaxVisibleCount - 2 >= 0) then
      ItemLinks.VisibleItems[TopIndex + AMaxVisibleCount - 2].Control.FLastInRow := True
    else
      ItemLinks.VisibleItems[ItemLinks.VisibleItemCount - 1].Control.FLastInRow := True;
  finally
    DrawBar(BarRect);
  end;
end;

procedure TdxBarSubMenuControl.CalcDrawingConsts;
var
  Size: Integer;
begin
  inherited;
  if Flat then Inc(FTextSize);
  FMenuArrowWidth := FTextSize div 4 * 3 + 1;

  FMarkSize := Canvas.TextHeight('0') + 1 - 2 * Ord(Flat);
  Size := MarkArrowSize;
  if Odd(Size) then FMarkSize := (Size - 1) * 2 + 2 * 3;
  FNormalItemHeight := 19 + Byte(Flat);
end;

function TdxBarSubMenuControl.CanCustomizing: Boolean;
begin
  Result := inherited CanCustomizing or
    (ItemLinks.Owner is TdxBarSubItem) and TdxBarSubItem(ItemLinks.Owner).AllowCustomizing or
    (ItemLinks.Owner is TdxBarPopupMenu);
end;

function TdxBarSubMenuControl.ChildrenHaveShadows: Boolean;
begin
  Result := False;
end;

procedure TdxBarSubMenuControl.CreateControls;
var
  FDoneItems: TList;
  I: Integer;
  AItemLink: TdxBarItemLink;
  FirstCall, HideWhenRun: Boolean;
begin
  if (FItemLinks <> nil) and not IsCustomizing and not FDestroyingControls then
  begin
    FDoneItems := TList.Create;
    try
      I := 0;
      while I <= FItemLinks.CanVisibleItemCount - 1 do
      begin
        AItemLink := FItemLinks.CanVisibleItems[I];
        if AItemLink.Item is TCustomdxBarContainerItem then
        begin
          if FSavedItemLinks = nil then
            FSavedItemLinks := TList.Create;
          FSavedItemLinks.Count := AItemLink.Index + 1;
          FSavedItemLinks[AItemLink.Index] := AItemLink;

          FirstCall := FDoneItems.IndexOf(AItemLink.Item) = -1;
          if FirstCall then FDoneItems.Add(AItemLink.Item);

          HideWhenRun := TCustomdxBarContainerItem(AItemLink.Item).HideWhenRun;
          if HideWhenRun then AItemLink.SaveRecentIndex;

          TCustomdxBarContainerItem(AItemLink.Item).AddListedItemLinks(FItemLinks,
            AItemLink.Index + 1, FirstCall, AItemLink);
          if HideWhenRun then
          begin
            AItemLink.SendToBottomInRecentList;
            AItemLink.Collection := nil;
            Dec(I);
          end;
        end;
        Inc(I);
      end;
    finally
      FDoneItems.Free;
    end;
  end;
  inherited;
end;

procedure TdxBarSubMenuControl.DestroyControls;
var
  I: Integer;
  HideWhenRun: Boolean;
begin
  inherited;
  if not IsCustomizing and (FSavedItemLinks <> nil) and not FDestroyingControls then
  begin
    FDestroyingControls := True;
    try
      for I := FSavedItemLinks.Count - 1 downto 0 do
        if FSavedItemLinks[I] <> nil then
          with TdxBarItemLink(FSavedItemLinks[I]) do
          begin
            HideWhenRun := TCustomdxBarContainerItem(Item).HideWhenRun;
            TCustomdxBarContainerItem(Item).DeleteListedItemLinks(FItemLinks, I + Byte(not HideWhenRun));
            if HideWhenRun then
            begin
              Collection := FItemLinks;
              Index := I;
              RestoreRecentIndex;
            end;
          end;

      for I := 0 to FSavedItemLinks.Count - 1 do
        if FSavedItemLinks[I] <> nil then
          TCustomdxBarContainerItem(TdxBarItemLink(FSavedItemLinks[I]).Item).NeedClearItemList;
    finally
      FSavedItemLinks.Free;
      FSavedItemLinks := nil;
      FDestroyingControls := False;
    end;
  end;
end;

procedure TdxBarSubMenuControl.DrawBar(const R: TRect);
begin
  if BarManager.Designing then
    DrawVerticalGradient(Canvas, R, 0, 0, 0, 0, 0, 255)
  else
    if ItemLinks.Owner is TdxBarPopupMenu then
      TdxBarPopupMenu(ItemLinks.Owner).DoPaintBar(Canvas, R)
    else
      if ItemLinks.Owner is TCustomdxBarSubItem then
        TCustomdxBarSubItem(ItemLinks.Owner).DoPaintBar(Canvas, R);
end;

function TdxBarSubMenuControl.GetBeginGroupSize: Integer;
begin
  if Flat then
    Result := 2 + 1 + 2
  else
    Result := 4 + 2 + 4;
end;

function TdxBarSubMenuControl.GetEditFontHandle: HFONT;
begin
  if ParentBar = nil then
    if (ItemLinks.Owner is TdxBarPopupMenu) and
      TdxBarPopupMenu(ItemLinks.Owner).UseOwnFont then
      Result := TdxBarPopupMenu(ItemLinks.Owner).FEditFontHandle
    else
      Result := inherited GetEditFontHandle
  else
    Result := ParentBar.GetEditFontHandle;
end;

function TdxBarSubMenuControl.GetIsContextMenu: Boolean;
begin
  Result :=
    (OwnerWidth = 0) and (OwnerHeight = 0) or
    (ParentBar is TdxBarSubMenuControl) and TdxBarSubMenuControl(ParentBar).IsContextMenu;
end;

function TdxBarSubMenuControl.GetIsShadowVisible: Boolean;
begin
  Result := inherited GetIsShadowVisible and not FShowAnimation;
end;

function TdxBarSubMenuControl.GetItemRectEx(Item: TdxBarItemControl;
  IsBeginGroup: Boolean): TRect;
var
  AIndex: Integer;
begin
  Result := inherited GetItemRectEx(Item, IsBeginGroup);
  if Item <> nil then
  begin
    if Item.FChangeRecentGroup and not Flat then Dec(Result.Top);
    if IsBeginGroup and Item.ItemLink.BeginGroup then
    begin
      AIndex := Item.ItemLink.VisibleIndex;
      if (AIndex > TopIndex) and not (UpArrowExists and (AIndex = TopIndex + 1)) then
        Dec(Result.Top, BeginGroupSize);
    end;
  end;  
end;

function TdxBarSubMenuControl.HideOnClick: Boolean;
begin
  Result := True;
end;

function TdxBarSubMenuControl.ItemAtPosEx(Pos: TPoint;
  var IsBeginGroup, IsFirstPart, IsVerticalDirection: Boolean): TdxBarItemControl;
begin
  if UpArrowExists and MouseOnUpArrow or DownArrowExists and MouseOnDownArrow or
    MarkExists and MouseOnMark then
    Result := nil
  else
    Result := inherited ItemAtPosEx(Pos, IsBeginGroup, IsFirstPart, IsVerticalDirection);
end;

procedure TdxBarSubMenuControl.PaintItem(AControl: TdxBarItemControl);
const
  BrushColors: array[Boolean] of COLORREF = (COLOR_BTNHIGHLIGHT, COLOR_BTNSHADOW);
var
  AIndex, LeftDelta: Integer;
  AItemRect, R: TRect;
  DC: HDC;

  procedure PaintBeginGroup;
  var
    R: TRect;
    ABrush: HBRUSH;
    LD, RD: Integer;
  begin
    if Flat then
    begin
      R := AItemRect;
      if AControl.FChangeRecentGroup and AControl.FNonRecent then
        ABrush := COLOR_WINDOW + 1
      else
        ABrush := BkBrush;
      with R do
      begin
        Bottom := Top;
        Dec(R.Top, BeginGroupSize);
        AControl.FBeginGroupRect := R;
        LD := Left + AControl.TextAreaOffset;
        FillRect(DC, Rect(Left, Top, LD, Bottom), BarManager.FlatToolbarsBrush);
        FillRect(DC, Rect(LD, Top, Right, Bottom), ABrush);
        RD := (Top + Bottom) div 2;
        FillRect(DC,
          Rect(LD + BarManager.SubMenuBeginGroupIndent, RD, Right + 1, RD + 1),
          COLOR_BTNSHADOW + 1);
      end;
    end
    else
    begin
      RD := Byte(AControl.FNonRecent);
      R := AItemRect;
      if AControl.FChangeRecentGroup and AControl.FNonRecent then
      begin
        Dec(R.Top);
        RD := 0;
        ABrush := ToolbarBrush;
      end
      else
        ABrush := BkBrush;
      LD := RD * LeftDelta;
      R.Bottom := R.Top;
      Dec(R.Top, BeginGroupSize);
      AControl.FBeginGroupRect := R;
      with R do
      begin
        FillRect(DC, Rect(Left - LD, Top, Right + 2 * RD, Top + 4), ABrush);
        FillRect(DC, Rect(Left - LD, Bottom - 4, Right + 2 * RD, Bottom), ABrush);
        FillRect(DC,
          Rect(Left - LD, Top + 4, Left + BarManager.SubMenuBeginGroupIndent, Bottom - 4),
          ABrush);
        FillRect(DC,
          Rect(Right - BarManager.SubMenuBeginGroupIndent, Top + 4, Right + 2 * RD, Bottom - 4),
          ABrush);
        InflateRect(R, -BarManager.SubMenuBeginGroupIndent, -4);
        DrawEdge(DC, R, EDGE_ETCHED, BF_TOP);
      end;
    end;  
  end;

begin
  if FDestroyFlag or (AControl.ItemLink.Control = nil) then Exit;
  inherited;
  AItemRect := GetItemRect(AControl);
  if IsRectEmpty(AItemRect) then
  begin
    SetRectEmpty(AControl.FBeginGroupRect);
    Exit;
  end;
  DC := Canvas.Handle;
  if AControl.FNonRecent then
  begin
    PreparePalette(DC);
    FBkBrush := FLightBrush;
  end
  else
    if Flat then
      FBkBrush := GetSysColorBrush(COLOR_WINDOW);
  AIndex := AControl.ItemLink.VisibleIndex;
  LeftDelta := Ord(BarSize = 0);

  if AControl.ItemLink.BeginGroup and (AIndex > TopIndex) and
    not (UpArrowExists and (AIndex = TopIndex + 1)) then
    PaintBeginGroup
  else
    SetRectEmpty(AControl.FBeginGroupRect);

  if not Flat then
  begin
    if AControl.FChangeRecentGroup then
    begin
      R := AItemRect;
      if not AControl.FNonRecent and not IsRectEmpty(AControl.FBeginGroupRect) then
        R.Top := AControl.FBeginGroupRect.Top;
      with R do
      begin
        Bottom := Top;
        Dec(Top);
        Dec(Left, LeftDelta);
        Inc(Right);
      end;
      FillRect(DC, R, BrushColors[AControl.FNonRecent] + 1);
    end;
    if AControl.FNonRecent then
      with AItemRect do
      begin
        if (AIndex = 0) and not Detachable then
        begin
          FillRect(DC, Rect(Left - LeftDelta, Top - 1, Right + 2, Top), BkBrush);
          SetPixel(DC, Right + 1, Top - 2, GetSysColor(COLOR_BTNHIGHLIGHT));
        end;
        FillRect(DC, Rect(Left - LeftDelta, Top, Left, Bottom), BkBrush);
        FillRect(DC, Rect(Right, Top, Right + 2, Bottom), BkBrush);
        if AIndex = AControl.ItemLink.Owner.VisibleItemCount - 1 then
        begin
          FillRect(DC, Rect(Left - LeftDelta, Bottom, Right + 2, ClientHeight), BkBrush);
          if LeftDelta <> 0 then
            SetPixel(DC, Left - 2, ClientHeight - 1, GetSysColor(COLOR_BTNHIGHLIGHT));
        end;
      end;
  end;

  AControl.Paint(AItemRect, ptMenu);
  DrawSelectedItem(AControl);

  if AControl.FNonRecent then UnpreparePalette(DC);
end;

procedure TdxBarSubMenuControl.SetFont;
begin
  if ParentBar = nil then
    if ItemLinks.Owner is TdxBarPopupMenu then
      Font := TdxBarPopupMenu(ItemLinks.Owner).Font
    else
      Font := BarManager.Font
  else
    Font := ParentBar.Font;
end;

procedure TdxBarSubMenuControl.SetIsActive(Value: Boolean);
var
  PrevIsActive: Boolean;
begin
  PrevIsActive := IsActive;
  inherited;
  if not BarControlExists(Self) then Exit;
  if IsActive and not PrevIsActive and
    BarManager.ShowRecentItemsFirst and not ShowFullMenus and
    BarManager.ShowFullMenusAfterDelay then
    SetExpandMenuTimer(dxBarSlowExpandMenuTime, True);
end;

procedure TdxBarSubMenuControl.SetMarkState(Value: TdxBarMarkState);
var
  R: TRect;
begin
  if IsCustomizing or not BarManager.ShowRecentItemsFirst then Exit;
  if (Value = msSelected) and (SelectedItem is TdxBarWinControl) and
    TdxBarWinControl(SelectedItem).Focused then Value := msNone;
  if FMarkState <> Value then
  begin
    FMarkState := Value;
    if Value = msPressed then ExpandMenu
    else
    begin
      R := MarkRect;
      InvalidateRect(Handle, @R, False);
    end;
    if BarManager.ShowFullMenusAfterDelay then
    begin
      KillExpandMenuTimer;
      if (FMarkState = msSelected) and MouseOnMark then
        SetExpandMenuTimer(dxBarWaitForShowHintTime, True);
    end
    else
      if FMarkState = msSelected then
        BarManager.HintActivate(True, LoadStr(DXBAR_EXPAND))
      else
        BarManager.HintActivate(False, '');
  end;
end;

procedure TdxBarSubMenuControl.SetRecentItemCount;
begin
  with ItemLinks do
    if BarManager.ShowRecentItemsFirst and not ShowFullMenus then
      RecentItemCount := MostRecentItemCount
    else
      RecentItemCount := -1;
end;

procedure TdxBarSubMenuControl.SetSelectedItem(Value: TdxBarItemControl);
var
  AIndex: Integer;
begin
  if MarkState = msNone then
  begin
    KillExpandMenuTimer;
    if IsActive and BarManager.ShowRecentItemsFirst and
      not ShowFullMenus and BarManager.ShowFullMenusAfterDelay then
      SetExpandMenuTimer(dxBarSlowExpandMenuTime, False);
  end;
  if Value <> nil then
  begin
    AIndex := Value.ItemLink.VisibleIndex;
    if UpArrowExists and (AIndex <= TopIndex) then
      TopIndex := AIndex - 1
    else
      if DownArrowExists and (AIndex >= TopIndex + MaxVisibleCount - 1) then
      begin
        repeat
          Inc(FTopIndex);
          CalcControlsPositions(nil);
        until AIndex <= TopIndex + MaxVisibleCount - 1 - Byte(DownArrowExists);
        Repaint;
      end;
  end;
  inherited SetSelectedItem(Value);
end;

procedure TdxBarSubMenuControl.SetSizeAndCheckBounds(var ChangeXDirection, ChangeYDirection: Boolean);
var
  Size: TPoint;
  R: TRect;
begin
  CalcControlsPositions(@Size);
  
  R := GetWorkArea(Point(Left, Top));
  ChangeXDirection := False;
  ChangeYDirection := False;

  if Left + Size.X > R.Right then
    if OwnerWidth = 0 then
      Left := R.Right - Size.X
    else
      if Left - OwnerWidth - R.Left > R.Right - Left then
      begin
        Left := Left - OwnerWidth - Size.X;
        ChangeXDirection := True;
      end;
  if Left < R.Left then
    if OwnerWidth = 0 then
      Left := R.Left
    else
      if (XDirection = xdLeft) and
        (R.Right - (Left + Size.X + OwnerWidth) > Left + Size.X - R.Left) then
      begin
        Left := Left + Size.X + OwnerWidth;
        ChangeXDirection := True;
      end;
  if Left + Size.X > R.Right then Left := R.Right - Size.X;
  if Left < R.Left then Left := R.Left;
  
  if Top + Size.Y > R.Bottom then
    if OwnerHeight = 0 then
      if (OwnerWidth = 0) and (Top - Size.Y >= R.Top) then  // for popupmenu
      begin
        Top := Top - Size.Y;
        ChangeYDirection := True;
      end
      else
        Top := R.Bottom - Size.Y
    else
      if Top - OwnerHeight - R.Top > R.Bottom - Top then
      begin
        Top := Top - OwnerHeight - Size.Y;
        ChangeYDirection := True;
      end
      else
        Size.Y := R.Bottom - Top;
  if Top < R.Top then
    if YDirection = ydBottom then
      if ChangeYDirection and (OwnerHeight <> 0) then
      begin
        Size.Y := Size.Y - (R.Top - Top);
        Top := R.Top;
      end
      else
      begin
        Top := R.Top;
        if Top + Size.Y > R.Bottom then
          Size.Y := R.Bottom - Top;
      end
    else
      if (OwnerHeight <> 0) and
        (R.Bottom - (Top + Size.Y + OwnerHeight) > Top + Size.Y - R.Top) then
      begin
        Top := Top + Size.Y + OwnerHeight;
        if Top + Size.Y > R.Bottom then Size.Y := R.Bottom - Top;
        ChangeYDirection := True;
      end;

  SetBounds(Left, Top, Size.X, Size.Y);
end;

function TdxBarSubMenuControl.CanDetach: Boolean;
begin
  Result := Detachable and
    (FSubItem.Item.GetDetachingBar <> nil) and
    (GetParentBarForBar(FSubItem.Parent) <> FSubItem.Item.GetDetachingBar.Control);
end;

function TdxBarSubMenuControl.Detachable: Boolean;
begin
  Result := (FSubItem <> nil) and FSubItem.Item.Detachable;
end;

function TdxBarSubMenuControl.DetachCaptionAreaSize: Integer;
begin
  if Flat then
    Result := DetachCaptionSize + 1
  else
    Result := 2 + DetachCaptionSize + 1;
end;

function TdxBarSubMenuControl.DetachCaptionRect: TRect;
begin
  GetWindowRect(Result);
  with Result do
    OffsetRect(Result, -Left, -Top);
  if Flat then
    InflateRect(Result, -2, -2)
  else
    InflateRect(Result, -3, -3);
  with Result do
    Bottom := Top + DetachCaptionSize;
end;

function TdxBarSubMenuControl.MouseOnDetachCaption: Boolean;
var
  P: TPoint;
begin
  GetCursorPos(P);
  with P do
  begin
    Dec(X, Left);
    Dec(Y, Top);
  end;
  Result := PtInRect(DetachCaptionRect, P);
end;

procedure TdxBarSubMenuControl.DoDetachMenu;
var
  ADetachingBar: TdxBar;
  ASubItem: TdxBarSubItemControl;
  NonDetachableArea: TRect;
  Success, Started: Boolean;
  PrevP, P: TPoint;
  CaptureWnd: HWND;
  Msg: TMsg;
begin
  FSubItem.Item.DoDetaching;
  if not CanDetach then Exit;
  ADetachingBar := FSubItem.Item.GetDetachingBar;
  ASubItem := FSubItem;

  NonDetachableArea := DetachCaptionRect;
  OffsetRect(NonDetachableArea, Left, Top);
  InflateRect(NonDetachableArea, DetachAreaDelta, DetachAreaDelta);

  Success := False;
  Started := False;
  GetCursorPos(PrevP);

  BarManager.FDetachingSubMenu := True;
  CaptureWnd := ParentBar.Handle;
  SetCapture(CaptureWnd);
  try
    while GetCapture = CaptureWnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      case Msg.message of
        WM_KEYDOWN, WM_KEYUP:
          if Msg.wParam = VK_ESCAPE then
          begin
            ASubItem.ControlActivate(True);
            Break;
          end;
        WM_MOUSEMOVE:
          begin
            P := SmallPointToPoint(TSmallPoint(Msg.lParam));
            Windows.ClientToScreen(Msg.hwnd, P);
            if (P.X <> PrevP.X) or (P.Y <> PrevP.Y) then
            begin
              if not Started and not PtInRect(NonDetachableArea, P) then
              begin
                ASubItem.ControlInactivate(True);
                if ADetachingBar.DockingStyle <> dsNone then
                begin
                  ADetachingBar.Visible := False;
                  ADetachingBar.DockingStyle := dsNone;
                end;
                if not ADetachingBar.Visible then
                begin
                  ADetachingBar.FloatLeft := P.X - 100;
                  ADetachingBar.FloatTop := P.Y - SMCaptionY div 2;
                  ADetachingBar.Visible := True;
                end;
                Started := True;
              end;
              if Started then
                if PtInRect(NonDetachableArea, P) then
                begin
                  ADetachingBar.Visible := False;
                  ASubItem.ControlActivate(True);
                  Break;
                end
                else
                  with ADetachingBar.Control do
                    SetWindowPos(Handle,
                      0, P.X - Width div 2, P.Y - SMCaptionY div 2, 0, 0,
                      SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
              PrevP := P;
            end;
          end;
        WM_LBUTTONUP:
          begin
            Success := True;
            Break;
          end;
      else
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if GetCapture = CaptureWnd then ReleaseCapture;
    if Started then
      if Success then
        ADetachingBar.BarManager.HideAll
      else
        ADetachingBar.Visible := False;
    ADetachingBar.BarManager.FDetachingSubMenu := False;
  end;
end;

function TdxBarSubMenuControl.MarkArrowSize: Integer;
begin
  Result := (FMarkSize - 2 * (2 + Ord(not Flat))) div 2;
end;

function TdxBarSubMenuControl.MarkExists: Boolean;
begin
  Result := BarManager.ShowRecentItemsFirst and
    (ItemLinks.VisibleItemCount < ItemLinks.CanVisibleItemCount);
end;

function TdxBarSubMenuControl.MarkRect: TRect;
var
  AOffset: Integer;
begin
  Result := ClientRect;
  AOffset := 1 + Ord(not Flat);
  with Result do
  begin
    Inc(Left, AOffset + BarSize);
    Dec(Right, AOffset);
    Dec(Bottom, AOffset);
    Top := Bottom - MarkSize;
  end;
end;

function TdxBarSubMenuControl.DownArrowExists: Boolean;
begin
  Result := ItemLinks.VisibleItemCount - TopIndex > MaxVisibleCount;
end;

function TdxBarSubMenuControl.UpArrowExists: Boolean;
begin
  Result := TopIndex > 0;
end;

function TdxBarSubMenuControl.VisibleCount: Integer;
begin
  Result := MaxVisibleCount - Byte(UpArrowExists) - Byte(DownArrowExists);
end;

procedure TdxBarSubMenuControl.Hide;
begin
  if not FDestroyFlag then
  begin
    FDestroyFlag := True;
    if HandleAllocated then DestroyWnd;
    Free;
  end;
end;

procedure TdxBarSubMenuControl.HideAll;
begin
  if ParentBar = nil then
  begin
    Hide;
    ProcessPaintMessages;
  end
  else
    inherited;
end;

procedure TdxBarSubMenuControl.RepaintBar;
var
  PrevSelectedItemLink: TdxBarItemLink;
  WasVisible, ChangeXDirection, ChangeYDirection, NeedRepaint: Boolean;
  PrevTopIndex: Integer;
begin
  if FDestroyFlag or FDestroyingControls or not HandleAllocated then Exit;
  WasVisible := IsWindowVisible(Handle);
  PrevSelectedItemLink := nil;
  if IsCustomizing then
  begin
    if (BarManager.SelectedItem <> nil) and
      (BarManager.SelectedItem.Parent = Self) then
    begin
      PrevSelectedItemLink := BarManager.SelectedItem.ItemLink;
      BarManager.FSelectedItem := nil;
    end;
    FSelectedItem := nil;
  end;
  DestroyControls;
  CreateControls;
  SetRecentItemCount;
  if (Left <> FOnShowLeft) or (Top <> FOnShowTop) then
  begin
    ShowWindow(Handle, SW_HIDE);
    Left := FOnShowLeft;
    Top := FOnShowTop;
    NeedRepaint := False;
  end
  else
    NeedRepaint := True;
  SetSizeAndCheckBounds(ChangeXDirection, ChangeYDirection);
  CalcControlsPositions(nil);

  if UpArrowExists and not DownArrowExists then
  begin
    PrevTopIndex := FTopIndex;
    repeat
      Dec(FTopIndex);
      CalcControlsPositions(nil);
    until DownArrowExists or (FTopIndex = 0);
    if DownArrowExists then Inc(FTopIndex);
    NeedRepaint := NeedRepaint or (FTopIndex <> PrevTopIndex);
  end;

  if WasVisible then Show;
  if NeedRepaint then
  begin
    CalcControlsPositions(nil);
    Invalidate;
  end;
  if IsCustomizing and (PrevSelectedItemLink <> nil) then
    SetKeySelectedItem(PrevSelectedItemLink.Control);
end;

procedure TdxBarSubMenuControl.Show;
const
  Shows: array[Boolean] of Integer = (0, SWP_SHOWWINDOW);
var
  AParentBar: TCustomdxBarControl;
begin
  DoPopup;
  AParentBar := GetParentBarForBar(Self);
  if AParentBar <> nil then
    FMenuAnimations := AParentBar.BarManager.MenuAnimations
  else
    FMenuAnimations := BarManager.MenuAnimations;
  FShowAnimation := FShowAnimation and (FMenuAnimations <> maNone) and
    not ((ItemLinks.CanVisibleItemCount = 0) or BarManager.IsCustomizing);
  SetWindowPos(Handle, 0, 0, 0, 0, 0,
    SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or
    Shows[not FShowAnimation]);
  ProcessPaintMessages;
end;

{$IFDEF DELPHI4}

{ TdxBarItemActionLink }

procedure TdxBarItemActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TdxBarItem;
end;

function TdxBarItemActionLink.IsCaptionLinked: Boolean;
begin
  Result := inherited IsCaptionLinked and
    (FClient.Caption = (Action as TCustomAction).Caption);
end;

function TdxBarItemActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked and (FClient is TdxBarButton) and
    (TdxBarButton(FClient).Down = (Action as TCustomAction).Checked);
end;

function TdxBarItemActionLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
    (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

function TdxBarItemActionLink.IsHelpContextLinked: Boolean;
begin
  Result := inherited IsHelpContextLinked and
    (FClient.HelpContext = (Action as TCustomAction).HelpContext);
end;

function TdxBarItemActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
    (FClient.Hint = (Action as TCustomAction).Hint);
end;

function TdxBarItemActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FClient.ImageIndex = (Action as TCustomAction).ImageIndex);
end;

function TdxBarItemActionLink.IsShortCutLinked: Boolean;
begin
  Result := inherited IsShortCutLinked and
    (FClient.ShortCut = (Action as TCustomAction).ShortCut);
end;

function TdxBarItemActionLink.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked and
    (FClient.Visible = VisibleTodxBarVisible((Action as TCustomAction).Visible));
end;

function TdxBarItemActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := inherited IsOnExecuteLinked and
    (@FClient.OnClick = @Action.OnExecute);
end;

procedure TdxBarItemActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

procedure TdxBarItemActionLink.SetChecked(Value: Boolean);
begin
  if IsCheckedLinked and (FClient is TdxBarButton) then
    TdxBarButton(FClient).Down := Value;
end;

procedure TdxBarItemActionLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TdxBarItemActionLink.SetHelpContext(Value: THelpContext);
begin
  if IsHelpContextLinked then FClient.HelpContext := Value;
end;

procedure TdxBarItemActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

procedure TdxBarItemActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then FClient.ImageIndex := Value;
end;

procedure TdxBarItemActionLink.SetShortCut(Value: TShortCut);
begin
  if IsShortCutLinked then FClient.ShortCut := Value;
end;

procedure TdxBarItemActionLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := VisibleTodxBarVisible(Value);
end;

procedure TdxBarItemActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then FClient.OnClick := Value;
end;

{$ENDIF}

{ TdxBarItem }

constructor TdxBarItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner is TCustomForm then
    FBarManager := GetBarManagerByForm(TCustomForm(AOwner));
  if (FBarManager = nil) and (dxBarManagerList.Count > 0) then
    FBarManager := TdxBarManager(dxBarManagerList[0]);
  if BarManager <> nil then BarManager.FItems.Add(Self);
  FLinks := TList.Create;
  FEnabled := True;
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := OnGlyphChanged;
  FImageIndex := -1;
  FCategory := -1;
  FVisible := ivAlways;
  FLoadedVisible := ivAlways;
end;

destructor TdxBarItem.Destroy;
begin
  Destroying;
  if Assigned(FOnDestroy) then FOnDestroy(Self);
  with InternalItemList do
    if IndexOf(Self) >= 0 then Remove(Self);
  DestroyLinks;
  if BarManager <> nil then
  begin
    BarManager.FItems.Remove(Self);
    if BarManager.FIsCustomizing and (Category > -1) then FullUpdateCustomizingBarItems;
  end;
  FLinks.Free;
{$IFDEF DELPHI4}
  if FActionLink <> nil then
  begin
    FActionLink.Free;
    FActionLink := nil;
  end;
{$ENDIF}  
  FGlyph.Free;
  inherited Destroy;
end;

{$IFDEF DELPHI4}
function TdxBarItem.GetAction: TBasicAction;
begin
  if FActionLink = nil then Result := nil
  else Result := FActionLink.Action;
end;
{$ENDIF}

function TdxBarItem.GetActuallyVisible: Boolean;
begin
  Result := (Visible = ivAlways) or (Visible = ivInCustomizing) and BarManager.IsCustomizing;
end;

function TdxBarItem.GetCurItemLink: TdxBarItemLink;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to LinkCount - 1 do
    if (Links[I].Control <> nil) and Links[I].Control.IsActive then
    begin
      Result := Links[I];
      Break;
    end;
end;

function TdxBarItem.GetEnabled: Boolean;
begin
  if not BarManager.Designing and BarManager.IsCustomizing and (Category > -1) then
    Result := True
  else
    Result := FEnabled;
end;

function TdxBarItem.GetFlat: Boolean;
begin
  Result := BarManager.Flat;
end;

function TdxBarItem.GetIndex: Integer;
begin
  Result := BarManager.FItems.IndexOf(Self);
end;

function TdxBarItem.GetIsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TdxBarItem.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TdxBarItem.GetIsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TdxBarItem.GetLinkCount: Integer;
begin
  Result := FLinks.Count;
end;

function TdxBarItem.GetLinks(Index: Integer): TdxBarItemLink;
begin
  Result := nil;
  if (Index > -1) and (Index < LinkCount) then
    Result := TdxBarItemLink(FLinks[Index]);
end;

function TdxBarItem.GetVisibleForUser: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to LinkCount - 1 do
    if Links[I].CanVisibleIndex <> -1 then Exit;
  Result := False;
end;

{$IFDEF DELPHI4}
procedure TdxBarItem.SetAction(Value: TBasicAction);
begin
  if Value = nil then
  begin
    FActionLink.Free;
    FActionLink := nil;
  end
  else
  begin
    if FActionLink = nil then
      FActionLink := GetActionLinkClass.Create(Self);
    FActionLink.Action := Value;
    FActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
    Value.FreeNotification(Self);
  end;
end;
{$ENDIF}

procedure TdxBarItem.SetAlign(Value: TdxBarItemAlign);
begin
  if FAlign <> Value then
  begin
    FAlign := Value;
    AlignChanged;
  end;
end;

procedure TdxBarItem.SetCaption(Value: string);
var
  MakeHint: Boolean;
  S: string;
begin
  if FCaption <> Value then
  begin
    MakeHint := not (Self is TCustomdxBarSubItem) and
      ((Hint = '') or (GetShortHint(Hint) = GetHintFromCaption));
    FCaption := Value;
    if not IsLoading then
    begin
      if MakeHint then
      begin
        S := GetHintFromCaption;
        if Pos('|', Hint) = 0 then
          Hint := S
        else
          Hint := S + '|' + GetLongHint(Hint);
      end;
      CaptionChanged;
    end;  
  end;
end;

procedure TdxBarItem.SetCategory(Value: Integer);
begin
  if IsLoading then
    FCategory := Value
  else
    if (BarManager <> nil) and (Value > -1) and
      (Value < BarManager.Categories.Count) then
    begin
      FCategory := Value;
      if BarManager.IsCustomizing and
        IsDesigning and not (IsLoading or IsDestroying) then
        UpdateCustomizingBarItemsEx(Self, True);
      BarManager.DesignerModified;  
    end;
end;

procedure TdxBarItem.SetDescription(Value: string);
begin
  if FDescription <> Value then
  begin
    FDescription := Value;
    BarManager.UpdateItems(Self);
  end;
end;

procedure TdxBarItem.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if not IsLoading then EnabledChanged;
  end;
end;

procedure TdxBarItem.SetGlyph(Value: TBitmap);
begin
  FGlyph.Assign(Value);
end;

procedure TdxBarItem.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    GlyphChanged;
  end;
end;

procedure TdxBarItem.SetShortCut(Value: TShortCut);
begin
  if FShortCut <> Value then
  begin
    FShortCut := Value;
    if not IsLoading then ShortCutChanged;
  end;
end;

procedure TdxBarItem.SetVisible(Value: TdxBarItemVisible);
begin
  if IsLoading then
    FLoadedVisible := Value
  else
    if FVisible <> Value then
    begin
      FVisible := Value;
      VisibleChanged;
    end;
end;

procedure TdxBarItem.DestroyLinks;
var
  Item: TdxBarItemLink;
begin
  while LinkCount > 0 do
  begin
    Item := TdxBarItemLink(FLinks.Last);
    FLinks.Remove(Item);
    if Item <> nil then Item.Free;           
  end;
end;  

{$IFDEF DELPHI4}
procedure TdxBarItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

function TdxBarItem.IsCaptionStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsCaptionLinked;
end;

function TdxBarItem.IsEnabledStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsEnabledLinked;
end;

function TdxBarItem.IsHelpContextStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHelpContextLinked;
end;

function TdxBarItem.IsHintStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsHintLinked;
end;

function TdxBarItem.IsImageIndexStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsImageIndexLinked;
end;

function TdxBarItem.IsShortCutStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsShortCutLinked;
end;

function TdxBarItem.IsVisibleStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsVisibleLinked;
end;

function TdxBarItem.IsOnClickStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsOnExecuteLinked;
end;
{$ENDIF}

function TdxBarItem.GetHintFromCaption: string;
var
  P: Integer;
begin
  Result := Caption;
  P := Pos('&', Result);
  if P > 0 then Delete(Result, P, 1);
  P := Pos('...', Result);
  if P > 0 then Delete(Result, P, 3);
end;

procedure TdxBarItem.OnGlyphChanged(Sender: TObject);
begin
  GlyphChanged;
end;

{$IFDEF DELPHI4}
procedure TdxBarItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TCustomAction then
    with TCustomAction(Dest) do
    begin
      Caption := Self.Caption;
      if Self is TdxBarButton then
        Checked := TdxBarButton(Self).Down;
      Enabled := Self.Enabled;
      HelpContext := Self.HelpContext;
      Hint := Self.Hint;
      ImageIndex := Self.ImageIndex;
      ShortCut := Self.ShortCut;
      case Self.Visible of
        ivNever: Visible := False;
        ivAlways: Visible := True;
      end;
      OnExecute := Self.OnClick;
    end
  else inherited AssignTo(Dest);
end;
{$ENDIF}

procedure TdxBarItem.Loaded;
begin
  inherited;
{$IFDEF DELPHI4}
  if Action <> nil then ActionChange(Action, True);
{$ENDIF}
  if Assigned(FOnCreate) then FOnCreate(Self);
end;

{$IFDEF DELPHI4}
procedure TdxBarItem.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Action) then Action := nil;
end;
{$ENDIF}

procedure TdxBarItem.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TdxBarManager then
  begin
    FBarManager := TdxBarManager(Reader.Parent);
    BarManagerChanged;
  end;
end;

procedure TdxBarItem.SetName(const NewName: TComponentName);
begin
  inherited;
  UpdateCustomizingAllCommands;
  UpdateGroupItems;
end;

procedure TdxBarItem.SetParentComponent(AParent: TComponent);
begin
  if not IsLoading then
  begin
    FBarManager := AParent as TdxBarManager;
    BarManagerChanged;
  end;
end;

{$IFDEF DELPHI4}
procedure TdxBarItem.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  if Action is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Caption = '') then
        Self.Caption := Caption;
      if (Self is TdxBarButton) and
        (not CheckDefaults or (TdxBarButton(Self).Down = False)) then
        TdxBarButton(Self).Down := Checked;
      if not CheckDefaults or (Self.Enabled = True) then
        Self.Enabled := Enabled;
      if not CheckDefaults or (Self.HelpContext = 0) then
        Self.HelpContext := HelpContext;
      if not CheckDefaults or (Self.Hint = '') then
        Self.Hint := Hint;
      if not CheckDefaults or (Self.ImageIndex = -1) then
        Self.ImageIndex := ImageIndex;
      if not CheckDefaults or (Self.ShortCut = scNone) then
        Self.ShortCut := ShortCut;
      if not CheckDefaults or (Self.Visible = ivAlways) then
        Self.Visible := VisibleTodxBarVisible(Visible);
      if not CheckDefaults or not Assigned(Self.OnClick) then
        Self.OnClick := OnExecute;
    end;
end;
{$ENDIF}

procedure TdxBarItem.AlignChanged;
var
  I: Integer;
begin
  if IsLoading then Exit;
  for I := 0 to LinkCount - 1 do
    with Links[I] do
      if Control <> nil then Control.AlignChanged;
end;

procedure TdxBarItem.BarManagerChanged;
begin
end;

function TdxBarItem.CanClicked: Boolean;
begin
  Result := True;
end;

procedure TdxBarItem.CaptionChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if not (udCaption in Links[I].UserDefine) and (Links[I].Control <> nil) then
      Links[I].Control.CaptionChanged;
  BarManager.UpdateItems(Self);
end;

procedure TdxBarItem.EnabledChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      Links[I].Control.EnabledChanged;
end;

{$IFDEF DELPHI4}
function TdxBarItem.GetActionLinkClass: TdxBarItemActionLinkClass;
begin
  Result := TdxBarItemActionLink;
end;
{$ENDIF}

function TdxBarItem.GetHidden: Boolean;
begin
  Result := False;
end;

procedure TdxBarItem.GlyphChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if not (udGlyph in Links[I].UserDefine) and (Links[I].Control <> nil) then
      Links[I].Control.GlyphChanged;
  BarManager.UpdateItems(Self);
end;

function TdxBarItem.HasAccel(AItemLink: TdxBarItemLink): Boolean;
begin
  Result := Enabled;//True
end;

function TdxBarItem.HasControls: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then Exit;
  Result := False;
end;

procedure TdxBarItem.HideControl(AControl: TdxBarItemControl);
begin
end;

procedure TdxBarItem.HotGlyphChanged;
begin
end;

function TdxBarItem.ImageIndexLinked: Boolean;
begin
  with BarManager do
    Result := (Images <> nil) and
      (0 <= ImageIndex) and (ImageIndex < Images.Count);
end;

procedure TdxBarItem.LargeGlyphChanged;
begin
end;

function TdxBarItem.NeedToBeHidden: Boolean;
begin
  Result := False;
end;

procedure TdxBarItem.ObjectNotification(AOperation: TOperation; AObject: TObject);
begin
end;

procedure TdxBarItem.ShortCutChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      Links[I].Control.ShortCutChanged;
  BarManager.UpdateItems(Self);
end;

procedure TdxBarItem.Update;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      with Links[I].Control do
        if not IsSelected or not Parent.IsActive then Repaint;
end;

procedure TdxBarItem.UpdateEx;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      with Links[I].Control do
        if not IsSelected or not Parent.IsActive then Parent.RepaintBar;
end;

function TdxBarItem.UseHotImages: Boolean;
begin
  Result := False;
end;

function TdxBarItem.UseLargeImages: Boolean;
begin
  Result := False;
end;

procedure TdxBarItem.VisibleChanged;
var
  I: Integer;
  PrevLockUpdate: Boolean;
begin
  if IsDesigning then Exit;
  PrevLockUpdate := BarManager.LockUpdate;
  BarManager.LockUpdate := True;
  try
    for I := 0 to LinkCount - 1 do
    begin
      Links[I].Owner.RefreshVisibilityLists;
      if ActuallyVisible then
      begin
        Links[I].BringToTopInRecentList(False);
        if Links[I].Control = nil then Links[I].CreateControl;
        if Links[I].Control <> nil then
          Links[I].Control.VisibleChanged;
      end
      else
      begin
        Links[I].SendToBottomInRecentList;
        if Links[I].Control <> nil then
        begin
          Links[I].Control.VisibleChanged;
          Links[I].DestroyControl;
        end;
      end;
    end;
  finally
    BarManager.LockUpdate := PrevLockUpdate;
    BarManager.UpdateItems(Self);
  end;
end;

procedure TdxBarItem.Click;
begin
  if CanClicked then DirectClick;
end;

procedure TdxBarItem.DirectClick;
begin
  if Enabled then
    try
      BarManager.DoClickItem(Self);
      DoClick;
    except
      Application.HandleException(Self);
    end;
end;

procedure TdxBarItem.DoClick;
begin
{$IFDEF DELPHI4}
  if Assigned(FOnClick) and ((Action = nil) or (@FOnClick <> @Action.OnExecute)) then
    FOnClick(Self)
  else
    if not IsDesigning and (FActionLink <> nil) then
      FActionLink.Execute{$IFDEF DELPHI6}(Self){$ENDIF};
{$ELSE}
  if Assigned(FOnClick) then FOnClick(Self);
{$ENDIF}
end;

function TdxBarItem.GetParentComponent: TComponent;
begin
  if HasParent then Result := FBarManager
  else Result := nil;
end;

function TdxBarItem.HasParent: Boolean;
begin
  Result := FCategory > -1; 
end;

{ TdxBarWindowItem }

function TdxBarWindowItem.GetCurText: string;
begin
  if CurItemLink = nil then Result := Text
  else
    if CurItemLink.Control is TdxBarWinControl then
      Result := TdxBarWinControl(CurItemLink.Control).Text;
end;

function TdxBarWindowItem.GetFocusedItemLink: TdxBarItemLink;
begin
  if (CurItemLink <> nil) and (CurItemLink.Control is TdxBarWinControl) and
    TdxBarWinControl(CurItemLink.Control).Focused then
    Result := CurItemLink
  else
    Result := nil;
end;

procedure TdxBarWindowItem.SetCurText(Value: string);
begin
  if CurItemLink = nil then Text := Value
  else
    if CurItemLink.Control is TdxBarWinControl then
      TdxBarWinControl(CurItemLink.Control).Text := Value;
end;

function TdxBarWindowItem.CanClicked: Boolean;
begin
  Result := False;
end;

procedure TdxBarWindowItem.Change;
begin
  if not IsLoading and Assigned(FOnChange) then FOnChange(Self);
end;

procedure TdxBarWindowItem.CurChange;
begin
  if Assigned(FOnCurChange) then FOnCurChange(Self);
end;

procedure TdxBarWindowItem.DoEnter;
begin
  if Assigned(FOnEnter) then FOnEnter(Self);
end;

procedure TdxBarWindowItem.DoExit;
begin
  if Assigned(FOnExit) then FOnExit(Self);
end;

procedure TdxBarWindowItem.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Assigned(FOnKeyDown) then FOnKeyDown(Self, Key, Shift);
end;

procedure TdxBarWindowItem.KeyPress(var Key: Char);
begin
  if Assigned(FOnKeyPress) then FOnKeyPress(Self, Key);
end;

procedure TdxBarWindowItem.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Assigned(FOnKeyUp) then FOnKeyUp(Self, Key, Shift);
end;

procedure TdxBarWindowItem.SetText(Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
{    if (CurItemLink <> nil) and (CurItemLink.Control is TdxBarWinControl) then
      TdxBarWinControl(CurItemLink.Control).Text := FText;}
    Update;
    Change;
    Update;
  end;
end;

procedure TdxBarWindowItem.SetFocus;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    with Links[I] do
      if Control is TdxBarWinControl then
      begin
        (BarControl as TdxBarControl).BarGetFocus(Control);
        Control.Click(False);
        Break;
      end;
end;

{ TdxBarButton }

constructor TdxBarButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCloseSubMenuOnClick := True;
  FDropDownEnabled := True;
  FUnclickAfterDoing := True;
end;

procedure TdxBarButton.SetAllowAllUp(Value: Boolean);
var
  I: Integer;
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    if GroupIndex <> 0 then
      with BarManager do
        for I := 0 to ItemCount - 1 do
          if (Items[I] is TdxBarButton) and (TdxBarButton(Items[I]).GroupIndex = GroupIndex) then
            TdxBarButton(Items[I]).FAllowAllUp := FAllowAllUp;
  end;
end;

procedure TdxBarButton.SetButtonStyle;
begin
  if FButtonStyle <> Value then
  begin
    FButtonStyle := Value;
    Down := False;
    if not IsLoading then ButtonStyleChanged;
    BarManager.UpdateItems(Self);
  end;
end;

procedure TdxBarButton.SetDown;
var
  DownedButton: TdxBarButton;

  function GetDownedButton: TdxBarButton;
  var
    I: Integer;
  begin
    with BarManager do
      for I := 0 to ItemCount - 1 do
        if Items[I] is TdxBarButton then
        begin
          Result := TdxBarButton(Items[I]);
          with Result do
            if (ButtonStyle = bsChecked) and
              (GroupIndex = Self.GroupIndex) and Down then Exit;
        end;
    Result := nil;
  end;

  function AnotherDownedButtonExists: Boolean;
  var
    I: Integer;
  begin
    Result := True;
    with BarManager do
      for I := 0 to ItemCount - 1 do
        if (Items[I] <> Self) and (Items[I] is TdxBarButton) then
          with TdxBarButton(Items[I]) do
            if (ButtonStyle = bsChecked) and
              (GroupIndex = Self.GroupIndex) and Down then Exit;
    Result := False;
  end;

begin
  if (FDown <> Value) and ((ButtonStyle = bsChecked) or not Value) then
  begin
    if not IsLoading and (ButtonStyle = bsChecked) and (GroupIndex <> 0) then
      if Value then
        DownedButton := GetDownedButton
      else
        if not AllowAllUp and not AnotherDownedButtonExists then
          Exit
        else
          DownedButton := nil
    else
      DownedButton := nil;
    FDown := Value;
    if not IsLoading then
    begin
      DownChanged;
      if DownedButton <> nil then DownedButton.Down := False;
    end;
  end;
end;

procedure TdxBarButton.SetDropDownEnabled(Value: Boolean);
begin
  if FDropDownEnabled <> Value then
  begin
    FDropDownEnabled := Value;
    if not IsLoading then DropDownEnabledChanged;
  end;
end;

procedure TdxBarButton.SetDropDownMenu(Value: TdxBarPopupMenu);
begin
  FDropDownMenu := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TdxBarButton.SetGroupIndex;
begin
  if FGroupIndex <> Value then
  begin
    if ButtonStyle <> bsChecked then Value := 0;
    FGroupIndex := Value;
    Down := False;
  end;
end;

procedure TdxBarButton.SetLowered(Value: Boolean);
begin
  if FLowered <> Value then
  begin
    FLowered := Value;
    if not IsLoading then UpdateEx;
  end;
end;

procedure TdxBarButton.SetPaintStyle(Value: TdxBarPaintStyle);
begin
  if FPaintStyle <> Value then
  begin
    FPaintStyle := Value;
    if not IsLoading then PaintStyleChanged;
  end;
end;

{$IFDEF DELPHI4}
function TdxBarButton.IsDownStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsCheckedLinked;
end;
{$ENDIF}

procedure TdxBarButton.ButtonStyleChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      TdxBarButtonControl(Links[I].Control).ButtonStyleChanged;
end;

function TdxBarButton.CanChangePaintStyle: Boolean;
begin
  Result := True;
end;

procedure TdxBarButton.DownChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      TdxBarButtonControl(Links[I].Control).DownChanged;
end;

procedure TdxBarButton.DoDropDown(AControl: TdxBarButtonControl; X, Y: Integer;
  ByMouse: Boolean);
var
  R: TRect;
begin
  If Assigned(FOnDropDown) then {V}
   FOnDropDown(AControl, X, Y, ByMouse)
  else
  if FDropDownMenu <> nil then
  begin
    if AControl.HasShadow then
      R := AControl.Parent.GetItemScreenRect(AControl)
    else
      R := Rect(0, 0, 0, 0);
    FDropDownMenu.DontUseMessageLoop := True;
    with AControl, ItemLink.ItemRect do
      if Parent is TdxBarSubMenuControl or IsRealVertical(Parent) then
        FDropDownMenu.PopupEx(X, Y, Right - Left, 0, FShowAnimation, @R)
      else
        FDropDownMenu.PopupEx(X, Y, 0, Bottom - Top, FShowAnimation, @R);
    FDropDownMenu.DontUseMessageLoop := False;
    with FDropDownMenu.SubMenuControl do
    begin
      FDropDownButton := AControl;
      if not ByMouse and (ItemLinks.First <> nil) then
        SetKeySelectedItem(ItemLinks.First.Control);
    end;
  end;
end;

procedure TdxBarButton.DropDownEnabledChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      TdxBarButtonControl(Links[I].Control).DropDownEnabledChanged;
end;

function TdxBarButton.HasAccel(AItemLink: TdxBarItemLink): Boolean;
begin
  Result := inherited HasAccel(AItemLink) and
    (not (AItemLink.Owner.Owner is TdxBar) or
     (AItemLink.PaintStyle in [psCaption, psCaptionGlyph]) or
     (AItemLink.Control <> nil) and
       (TdxBarButtonControl(AItemLink.Control).PaintStyle in [psCaption, psCaptionGlyph]));
end;

procedure TdxBarButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = DropDownMenu) then
    DropDownMenu := nil;
end;

procedure TdxBarButton.PaintStyleChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if not (udPaintStyle in Links[I].UserDefine) and (Links[I].Control <> nil) then
      TdxBarButtonControl(Links[I].Control).PaintStyleChanged;
end;

procedure TdxBarButton.Click;
begin
  if Enabled and (ButtonStyle = bsChecked) then Down := not Down;
  inherited;
end;

{ TdxBarEdit }

constructor TdxBarEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWidth := 100;
end;

procedure TdxBarEdit.SetMaxLength(Value: Integer);
begin
  FMaxLength := Value;
  if FMaxLength <= 0 then FMaxLength := 0;
end;

procedure TdxBarEdit.SetShowCaption(Value: Boolean);
begin
  if FShowCaption <> Value then
  begin
    FShowCaption := Value;
    if not IsLoading then UpdateEx;
  end;
end;

procedure TdxBarEdit.SetWidth(Value: Integer);
begin
  CheckEditWidth(Value);
  if FWidth <> Value then
  begin
    FWidth := Value;
    if not IsLoading then WidthChanged;
  end;
end;

procedure TdxBarEdit.DrawInterior(ACanvas: TCanvas; R: TRect; ItemLink: TdxBarItemLink);
var
  DC: HDC;
  S: string;
begin
  DC := ACanvas.Handle;
  FillRect(DC, R, ACanvas.Brush.Handle);
  Inc(R.Left, 2);
  Dec(R.Right, 2);
  if Flat then Inc(R.Top, 2);
  if FocusedItemLink = ItemLink then
    S := CurText
  else
    S := Text;
  SetBkMode(DC, TRANSPARENT);
  DrawText(DC, PChar(S), Length(S), R, DT_NOPREFIX);
  SetBkMode(DC, OPAQUE);
end;

function TdxBarEdit.HasAccel(AItemLink: TdxBarItemLink): Boolean;
begin
  Result := inherited HasAccel(AItemLink) and
    (FShowCaption or not (AItemLink.Owner.Owner is TdxBar));
end;

procedure TdxBarEdit.WidthChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if not (udWidth in Links[I].UserDefine) and
      (Links[I].Control is TdxBarEditControl) then
      TdxBarEditControl(Links[I].Control).WidthChanged;
end;

{ TCustomdxBarCombo }

function TCustomdxBarCombo.GetDroppedDown: Boolean;
begin
  if CurItemLink = nil then
    Result := False
  else
    if CurItemLink.Control is TCustomdxBarComboControl then
      Result := TCustomdxBarComboControl(CurItemLink.Control).DroppedDown
    else
      Result := False;
end;

function TCustomdxBarCombo.GetShowEditor: Boolean;
begin
  Result := not EmptyWindow;
end;

procedure TCustomdxBarCombo.SetDroppedDown(Value: Boolean);
begin
  if (CurItemLink <> nil) and (CurItemLink.Control is TCustomdxBarComboControl) then
    TCustomdxBarComboControl(CurItemLink.Control).DroppedDown := Value;
end;

procedure TCustomdxBarCombo.SetShowEditor(Value: Boolean);
begin
  EmptyWindow := not Value;
end;

procedure TCustomdxBarCombo.AfterDropDown;
begin
end;

procedure TCustomdxBarCombo.CheckDropDownPoint(var X, Y: Integer);
var
  R: TRect;
  ControlWidth, ControlHeight, DropDownWindowWidth, DropDownWindowHeight: Integer;
begin
  if DropDownWindow > 0 then
    with R do
    begin
      with CurItemLink.ItemRect do
      begin
        ControlWidth := Right - Left;
        ControlHeight := Bottom - Top;
      end;
      GetWindowRect(DropDownWindow, R);
      DropDownWindowWidth := Right - Left;
      DropDownWindowHeight := Bottom - Top;
      R := GetWorkArea(Point(X, Y));
      if (CurItemLink.BarControl is TdxBarSubMenuControl) or
        IsRealVertical(CurItemLink.BarControl) then
      begin
        if (X + DropDownWindowWidth > Right) and
          (X - ControlWidth - Left > Right - X) then
          Dec(X, ControlWidth + DropDownWindowWidth);
        if Y + DropDownWindowHeight > Bottom then
          Y := Bottom - DropDownWindowHeight;
      end
      else
      begin
        if X + DropDownWindowWidth > Right then
          X := Right - DropDownWindowWidth;
        if (Y + DropDownWindowHeight > Bottom) and
          (Y - ControlHeight - Top > Bottom - Y) then
          Dec(Y, ControlHeight + DropDownWindowHeight);
      end;
      if X < Left then X := Left;
      if Y < Top then Y := Top;
    end;
end;

function TCustomdxBarCombo.CheckKeyForDropDownWindow(Key: Word;
  Shift: TShiftState): Boolean;
begin
  Result := (Key <> VK_ESCAPE) and (Key <> VK_RETURN) and (Key <> VK_TAB);
  if Assigned(FOnCheckKeyForDropDownWindow) then
    FOnCheckKeyForDropDownWindow(Self, Key, Shift, Result);
end;

procedure TCustomdxBarCombo.CloseUp;
begin
  if DropDownWindow <> 0 then ShowWindow(DropDownWindow, SW_HIDE);
  if Assigned(FOnCloseUp) then FOnCloseUp(Self);
end;

procedure TCustomdxBarCombo.DropDown(X, Y: Integer);
begin
  if Assigned(FOnDropDown) then FOnDropDown(Self);
  if DropDownWindow <> 0 then
  begin
    InitDropDownWindow;
    CheckDropDownPoint(X, Y);
    SetWindowPos(DropDownWindow, 0, X, Y, 0, 0,
      SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
    SetWindowPos(DropDownWindow, HWND_TOP, 0, 0, 0, 0,
      SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_FRAMECHANGED);
    AfterDropDown;
  end;
end;

function TCustomdxBarCombo.GetDropDownWindow: HWND;
begin
  Result := 0;
  if Assigned(FOnGetDropDownWindow) then FOnGetDropDownWindow(Self, Result);
end;

procedure TCustomdxBarCombo.InitDropDownWindow;
begin
end;

{ TdxBarCustomCombo }

constructor TdxBarCustomCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDropDownCount := 8;
  FItemIndex := -1;
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := ItemsChanged;
  FListBox := TdxBarDropDownListBox.Create(Self);
  with TdxBarDropDownListBox(FListBox) do
  begin
    FCombo := Self;
    OnDrawItem := ListBoxDrawItem;
    OnMeasureItem := ListBoxMeasureItem;
  end;
end;

destructor TdxBarCustomCombo.Destroy;
begin
  FListBox.Free;
  FItems.Free;
  inherited Destroy;
end;

function TdxBarCustomCombo.GetCurItemIndex: Integer;
begin
  if FocusedItemLink = nil then
    Result := ItemIndex
  else
    Result := TdxBarComboControl(FocusedItemLink.Control).LocalItemIndex;
end;

function TdxBarCustomCombo.GetItemsHeight(Index: Integer): Integer;
begin
  MeasureItem(Index, Result);
end;

procedure TdxBarCustomCombo.SetCurItemIndex(Value: Integer);
begin
  if FocusedItemLink = nil then
    ItemIndex := Value
  else
    TdxBarComboControl(FocusedItemLink.Control).LocalItemIndex := Value;
end;

procedure TdxBarCustomCombo.SetItemIndex(Value: Integer);
var
  AText: string;
begin
  if FItemIndex <> Value then
  begin
    FItemIndex := Value;
    if (FItemIndex < 0) or (FItemIndex > Items.Count - 1) then
      FItemIndex := -1;
    if FItemIndex = -1 then AText := ''
    else AText := Items[FItemIndex];
    if Text = AText then
    begin
      Update;
      Change;
      Update;
    end
    else
      Text := AText;
  end;
end;

procedure TdxBarCustomCombo.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TdxBarCustomCombo.SetSorted(Value: Boolean);
begin
  if FSorted <> Value then
  begin
    FSorted := Value;
    TStringList(FItems).Sorted := FSorted;
    FItemIndex := FItems.IndexOf(Text);
  end;
end;

procedure TdxBarCustomCombo.CheckLocalPos;
var
  AText: string;
  AItemIndex: Integer;
begin
  if CurItemLink.Control is TdxBarComboControl then
  begin
    AText := TdxBarComboControl(CurItemLink.Control).Text;
    AItemIndex := TdxBarComboControl(CurItemLink.Control).LocalItemIndex;
    if not ((AItemIndex > -1) and (Items.Count > 0) and (Items[AItemIndex] = AText)) then
      AItemIndex := GetNearestItemIndex(AText);
    TdxBarComboControl(CurItemLink.Control).FLocalItemIndex := AItemIndex;
    if DroppedDown then
      if (AItemIndex > -1) and (AnsiCompareText(AText, Items[AItemIndex]) = 0) then
        ListBox.ItemIndex := AItemIndex
      else
      begin
        ListBox.ItemIndex := -1;
        ListBox.TopIndex := AItemIndex;
      end;
  end;
end;

procedure TdxBarCustomCombo.ItemsChanged(Sender: TObject);
begin
  if ItemIndex > Items.Count - 1 then ItemIndex := -1
  else Update;
end;

procedure TdxBarCustomCombo.ListBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  DrawItem(Index, Rect, State);
end;

procedure TdxBarCustomCombo.ListBoxMeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
  MeasureItem(Index, Height);
end;

procedure TdxBarCustomCombo.AfterDropDown;
begin
  with TdxBarDropDownListBox(ListBox) do
    if LeftButtonPressed then
    begin
      SetCapture(Handle);
      WaitForCapture := True;
    end
    else
      WaitForCapture := False;
end;

function TdxBarCustomCombo.CheckKeyForDropDownWindow(Key: Word;
  Shift: TShiftState): Boolean;
begin
  Result := (Shift = []) and
    ((Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_PRIOR) or (Key = VK_NEXT));
end;

procedure TdxBarCustomCombo.CloseUp;
begin
  inherited;
  FListBox.Parent := nil;
end;

procedure TdxBarCustomCombo.CurChange;
begin
  inherited;
  CheckLocalPos;
end;

procedure TdxBarCustomCombo.DrawInterior(ACanvas: TCanvas; R: TRect; ItemLink: TdxBarItemLink);
var
  AIndex: Integer;
begin
  FCanvas := ACanvas;
  try
    if FocusedItemLink = ItemLink then
      AIndex := TdxBarComboControl(CurItemLink.Control).LocalItemIndex
    else
      AIndex := ItemIndex;
    FInteriorIsDrawing := True;
    try
      DrawItem(AIndex, R, []);
    finally
      FInteriorIsDrawing := False;
    end;
  finally
    FCanvas := nil;
  end;  
end;

procedure TdxBarCustomCombo.DrawItem(AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
var
  S: string;
begin
  if Assigned(FOnDrawItem) then
    FOnDrawItem(Self, AIndex, ARect, AState)
  else
    with Canvas, ARect do
    begin
      if AIndex = -1 then
        S := Text
      else
        S := Items[AIndex];
      FillRect(ARect);
      TextOut(Left + 2, Top + Byte(FInteriorIsDrawing and Flat) * 2, S);
    end;
  if odFocused in AState then DrawFocusRect(Canvas.Handle, ARect); // for hiding focus rect
end;

procedure TdxBarCustomCombo.DropDown(X, Y: Integer);
begin
  FListBox.Parent := BarManager.MainForm;
  inherited;
  CheckLocalPos;
end;

function TdxBarCustomCombo.GetCanvas: TCanvas;
begin
  if FCanvas <> nil then
    Result := FCanvas
  else
    Result := FListBox.Canvas;
end;

function TdxBarCustomCombo.GetDropDownWidth: Integer;
var
  I, ItemWidth: Integer;
begin
  Result := DropDownWidth;
  if Result <= 0 then
  begin
    if CurItemLink <> nil then
      with CurItemLink.ItemRect do
        Result := Right - Left -
          TdxBarComboControl(CurItemLink.Control).CaptionWidth - 2 * 2;
    if DropDownCount < Items.Count then
      Dec(Result, GetSystemMetrics(SM_CXVSCROLL));
    for I := 0 to Items.Count - 1 do
    begin
      MeasureItemWidth(I, ItemWidth);
      if ItemWidth > Result then Result := ItemWidth;
    end;
  end;
  Inc(Result, 2 + 2);
  if DropDownCount < Items.Count then
    Inc(Result, GetSystemMetrics(SM_CXVSCROLL));
end;

function TdxBarCustomCombo.GetDropDownWindow: HWND;
begin
  Result := inherited GetDropDownWindow;
  if Result = 0 then Result := FListBox.Handle;
end;

function TdxBarCustomCombo.GetNearestItemIndex(AText: string): Integer;
var
  AItem: string;
  FoundChars, I, J: Integer;
begin
  AText := AnsiUpperCase(AText);
  FoundChars := 0;
  Result := -1;
  for I := 0 to Items.Count - 1 do
  begin
    AItem := AnsiUpperCase(Items[I]);
    if Copy(AItem, 1, FoundChars) = Copy(AText, 1, FoundChars) then
      for J := FoundChars + 1 to Length(AText) do
        if (J <= Length(AItem)) and (AItem[J] = AText[J]) then
        begin
          FoundChars := J;
          Result := I;
          if J = Length(AText) then Exit;
        end
        else Break;
  end;
end;

procedure TdxBarCustomCombo.InitDropDownWindow;
var
  AWidth, AHeight, I: Integer;
begin
  FListBox.Items.Assign(Items);
  
  AWidth := GetDropDownWidth;
  if DropDownCount > Items.Count then
    I := Items.Count
  else
    I := DropDownCount;
  AHeight := 2 * 2;
  for I := 0 to I - 1 do Inc(AHeight, ItemsHeight[I]);
  
  SetWindowPos(FListBox.Handle, 0, 0, 0, AWidth, AHeight,
    SWP_NOZORDER or SWP_NOMOVE or SWP_NOACTIVATE);
end;

procedure TdxBarCustomCombo.MeasureItem(AIndex: Integer; var AHeight: Integer);
begin
  if ItemHeight <= 0 then AHeight := Canvas.TextHeight('Qq')
  else AHeight := ItemHeight;
  if Assigned(FOnMeasureItem) then FOnMeasureItem(Self, AIndex, AHeight);
end;

procedure TdxBarCustomCombo.MeasureItemWidth(AIndex: Integer; var AWidth: Integer);
begin
  AWidth := 1 + Canvas.TextWidth(Items[AIndex]) + 1;
end;

procedure TdxBarCustomCombo.SetText(Value: string);
begin
  if (FItemIndex = -1) or (Items[FItemIndex] <> Value) then
    FItemIndex := Items.IndexOf(Value);
  inherited;
end;

{ TCustomdxBarSubItem }

constructor TCustomdxBarSubItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItemLinks := TdxBarItemLinks.Create(BarManager);
  FItemLinks.FOwner := Self;
  FShowCaption := True;
end;

destructor TCustomdxBarSubItem.Destroy;
begin
  DetachingBar := -1;
  FItemLinks.Free;
  FItemLinks := nil;
  inherited Destroy;
end;

function TCustomdxBarSubItem.GetDetachingBarIndex: Integer;
begin
  if FDetachingBar = nil then
    Result := -1
  else
    Result := FDetachingBar.Index;
end;

procedure TCustomdxBarSubItem.SetBarSize(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FBarSize := Value;
end;

procedure TCustomdxBarSubItem.SetDetachingBar(Value: Integer);
begin
  if (BarManager.Bars = nil) or
    (Value < -1) or (Value > BarManager.Bars.Count - 1) then Value := -1;
  if DetachingBar <> Value then
  begin
    if FDetachingBar <> nil then
      FDetachingBar.RemoveFreeNotification(Self);
    if Value = -1 then
      FDetachingBar := nil
    else
      FDetachingBar := BarManager.Bars[Value];
    if FDetachingBar <> nil then
      FDetachingBar.AddFreeNotification(Self);
  end;
end;

procedure TCustomdxBarSubItem.SetItemLinks(Value: TdxBarItemLinks);
begin
  FItemLinks.Assign(Value);
end;

procedure TCustomdxBarSubItem.SetShowCaption(Value: Boolean);
begin
  if FShowCaption <> Value then
  begin
    FShowCaption := Value;
    if not IsLoading then UpdateEx;
  end;
end;

procedure TCustomdxBarSubItem.BarManagerChanged;
begin
  if FItemLinks <> nil then
    FItemLinks.FBarManager := BarManager;
end;

function TCustomdxBarSubItem.CanClicked: Boolean;
begin
  Result := False;
end;

procedure TCustomdxBarSubItem.DoCloseUp;
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self);
end;

procedure TCustomdxBarSubItem.DoDetaching;
begin
  if Assigned(FOnDetaching) then FOnDetaching(Self);
end;

procedure TCustomdxBarSubItem.DoPaintBar(Canvas: TCanvas; const R: TRect);
begin
  if Assigned(FOnPaintBar) then FOnPaintBar(Self, Canvas, R);
end;

procedure TCustomdxBarSubItem.DoPopup;
begin
  if Assigned(FOnPopup) then FOnPopup(Self);
end;

function TCustomdxBarSubItem.HasDesignTimeLinks: Boolean;
begin
  Result := True;
end;

function TCustomdxBarSubItem.IsShortCut(AShortCut: TShortCut): Boolean;
begin
  Result := FItemLinks.IsShortCut(AShortCut);
end;

procedure TCustomdxBarSubItem.ObjectNotification(AOperation: TOperation;
  AObject: TObject);
begin
  inherited;
  if (AOperation = opRemove) and (AObject = FDetachingBar) then
    DetachingBar := -1;
end;

function TCustomdxBarSubItem.CanContainItem(AItem: TdxBarItem): Boolean;
begin
  Result := not
    ((AItem is TCustomdxBarSubItem) and
     ((Self = AItem) or TCustomdxBarSubItem(AItem).ItemLinks.HasItem(Self)) or
     (AItem is TdxBarButton) and
     (TdxBarButton(AItem).DropDownMenu <> nil) and
     TdxBarButton(AItem).DropDownMenu.ItemLinks.HasItem(Self));
end;

function TCustomdxBarSubItem.GetDetachingBar: TdxBar;
begin
  Result := FDetachingBar;
end;

{ TdxBarSubItem }

constructor TdxBarSubItem.Create(AOwner: TComponent);
begin
  inherited;
  FAllowCustomizing := True;
end;

{ TCustomdxBarContainerItem }

destructor TCustomdxBarContainerItem.Destroy;
begin
  if FNeedClearItemList then ClearItemList;
  inherited;
end;

procedure TCustomdxBarContainerItem.AddListedItemLinks(AItemLinks: TdxBarItemLinks;
  AIndex: Integer; FirstCall: Boolean; CallingItemLink: TdxBarItemLink);
begin
  if FNeedClearItemList then ClearItemList;
  if FirstCall and Assigned(FOnGetData) then FOnGetData(Self);
end;

procedure TCustomdxBarContainerItem.DeleteListedItemLinks(AItemLinks: TdxBarItemLinks;
  AIndex: Integer);
begin
end;

procedure TCustomdxBarContainerItem.ClearItemList;
begin
  FNeedClearItemList := False;
end;

function TCustomdxBarContainerItem.HideWhenRun: Boolean;
begin
  Result := True;
end;

procedure TCustomdxBarContainerItem.NeedClearItemList;
begin
  FNeedClearItemList := True;
end;

{ TdxBarListItem }

constructor TdxBarListItem.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TStringList.Create;
  FItemIndex := -1;
  FItemList := TList.Create;
  FShowNumbers := True;
end;

destructor TdxBarListItem.Destroy;
begin
  FItemList.Free;
  FItems.Free;
  inherited;
end;

function TdxBarListItem.GetDataIndex: Integer;
var
  I: Integer;
begin
  Result := -1;
  if (0 <= FItemIndex) and (FItemIndex < Items.Count) then
    for I := 0 to FItemIndex do
      if Items[I] <> ListItemSeparator then Inc(Result);
end;

procedure TdxBarListItem.SetDataIndex(Value: Integer);
var
  J, I: Integer;
begin
  if Items.Count = 0 then
    I := -1
  else
  begin
    J := -1;
    for I := 0 to Items.Count - 1 do
    begin
      if Items[I] <> ListItemSeparator then Inc(J);
      if J = Value then Break;
    end;
  end;  
  ItemIndex := I;
end;

procedure TdxBarListItem.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TdxBarListItem.ClickItem(Sender: TObject);
begin
  FItemIndex := TComponent(Sender).Tag;
  DirectClick;
end;

procedure TdxBarListItem.AddListedItemLinks(AItemLinks: TdxBarItemLinks;
  AIndex: Integer; FirstCall: Boolean; CallingItemLink: TdxBarItemLink);
var
  I, CurIndex: Integer;
  IsBeginGroup, ItemListExists: Boolean;
begin
  inherited;
  IsBeginGroup := False;
  ItemListExists := FItemList.Count > 0;
  CurIndex := 0;
  for I := 0 to Items.Count - 1 do
    if Items[I] = ListItemSeparator then
      IsBeginGroup := True
    else
    begin
      if not ItemListExists then
      begin
        FItemList.Add(TdxBarButton.Create(BarManager.MainForm));
        with TdxBarButton(FItemList[CurIndex]) do
        begin
          if ShowCheck and (I{CurIndex} = FItemIndex) then
          begin
            ButtonStyle := bsChecked;
            Down := True;
          end;
          if FShowNumbers then
          begin
            if CurIndex < 9 then
              FCaption := IntToStr(CurIndex + 1)
            else
              FCaption := Chr(Ord('A') + CurIndex - 9);
            FCaption := '&' + FCaption + ' ';
          end
          else
            FCaption := '';
          FCaption := FCaption + GetDisplayText(Items[I]);
          Tag := I;  //CurIndex;
          OnClick := ClickItem;
          Enabled := Self.Enabled;
        end;
      end;
      with AItemLinks.Add do
      begin
        FOriginalItemLink := CallingItemLink;
        Index := AIndex + CurIndex;
        Item := TdxBarItem(FItemList[CurIndex]);
        if (CurIndex = 0) or IsBeginGroup then BeginGroup := True;
        Synchronize(CallingItemLink);
      end;
      IsBeginGroup := False;
      Inc(CurIndex);
    end;
end;

procedure TdxBarListItem.ClearItemList;
begin
  if (FItemList.Count > 0) and (TdxBarItem(FItemList.First).LinkCount = 0) then
    while FItemList.Count > 0 do
    begin
      TdxBarItem(FItemList.Last).Free;
      FItemList.Delete(FItemList.Count - 1);
    end;
  inherited;
end;

procedure TdxBarListItem.DeleteListedItemLinks(AItemLinks: TdxBarItemLinks;
  AIndex: Integer);
var
  I: Integer;
begin
  inherited;
  for I := 0 to Items.Count - 1 do
    if Items[I] <> ListItemSeparator then AItemLinks[AIndex].Free;
end;

function TdxBarListItem.GetDisplayText(const AText: string): string;
begin
  Result := AText;
end;

procedure TdxBarListItem.DirectClick;
begin
  if CurItemLink = nil then inherited;
end;

{ TdxBarContainerItem }

procedure TdxBarContainerItem.AddListedItemLinks(AItemLinks: TdxBarItemLinks;
  AIndex: Integer; FirstCall: Boolean; CallingItemLink: TdxBarItemLink);
var
  I: Integer;
begin
  inherited;
  if AItemLinks = ItemLinks then Exit;
  for I := 0 to FItemLinks.CanVisibleItemCount - 1 do
    with AItemLinks.Add do
    begin
      FOriginalItemLink := CallingItemLink;
      Assign(FItemLinks.CanVisibleItems[I]);
      Index := AIndex + I;
      if (I = 0) and HideWhenRun then BeginGroup := True;
      Synchronize(FOriginalItemLink);
    end;
end;

procedure TdxBarContainerItem.DeleteListedItemLinks(AItemLinks: TdxBarItemLinks;
  AIndex: Integer);
var
  I: Integer;
begin
  inherited;
  if AItemLinks = ItemLinks then Exit;
  for I := 0 to FItemLinks.CanVisibleItemCount - 1 do AItemLinks[AIndex].Free;
end;

{ TdxBarItemControl }

constructor TdxBarItemControl.Create(AItemLink: TdxBarItemLink);
begin
  inherited Create;
  FItemLink := AItemLink;
  FParent := AItemLink.BarControl;
end;

destructor TdxBarItemControl.Destroy;
begin
  if (BarManager <> nil) and (BarManager.FSelectedItem = Self) then
    BarManager.FSelectedItem := nil;
  if FItemLink <> nil then FItemLink.FControl := nil;
  if (FParent <> nil) and not BarManager.IsDestroying and
    (FParent.SelectedItem = Self) and not BarManager.IsCustomizing then
    if (FItemLink <> nil) and (FItemLink.VisibleIndex <> -1) then
      FParent.SetMouseSelectedItem(nil)
    else
      FParent.FSelectedItem := nil;
  inherited Destroy;
end;

function TdxBarItemControl.GetAlign: TdxBarItemAlign;
begin
  Result := Item.Align;
  if (Result <> iaLeft) and not Parent.CanAlignControl(Self) then
    Result := iaLeft;
end;

function TdxBarItemControl.GetBarManager: TdxBarManager;
begin
  if FItemLink <> nil then
    Result := FItemLink.BarManager
  else
    Result := nil;
end;

function TdxBarItemControl.GetFlat: Boolean;
begin
  Result := Parent.Flat;
end;

function TdxBarItemControl.GetIsSelected: Boolean;
begin
  Result := (FParent <> nil) and (FParent.FSelectedItem = Self) and
    (Enabled or not FSelectedByMouse);
end;

function TdxBarItemControl.GetItem: TdxBarItem;
begin
  Result := FItemLink.Item;
end;

function TdxBarItemControl.GetNormalItemHeightInSubMenu: Integer;
begin
  Result := TdxBarSubMenuControl(Parent).NormalItemHeight;
end;

function TdxBarItemControl.GetRealHeight: Integer;
begin
  Result := GetHeight;
  if (Align = iaClient) and TdxBarControl(Parent).Vertical then
    if IsVertical(Parent) then
      Result := MinWidth
    else
      Result := MinHeight;
end;

function TdxBarItemControl.GetRealWidth: Integer;
begin
  Result := GetWidth;
  if (Align = iaClient) and not TdxBarControl(Parent).Vertical then
    Result := MinWidth;
end;

function TdxBarItemControl.GetUnclickAfterDoing: Boolean;
begin
  if Item is TdxBarButton then
    Result := Item.UnclickAfterDoing
  else
    Result := True;
end;

procedure TdxBarItemControl.SetPressed(Value: Boolean);
begin
  if FPressed <> Value then
  begin
    FPressed := Value;
    PressedChanged;
  end;
end;

procedure TdxBarItemControl.AlignChanged;
begin
  FParent.RepaintBar;
end;

procedure TdxBarItemControl.BeforeDestroyParentHandle;
begin
end;

procedure TdxBarItemControl.BeginGroupChanged;
begin
  FParent.RepaintBar;
end;

procedure TdxBarItemControl.CaptionChanged;
begin
  FParent.RepaintBar;
end;

procedure TdxBarItemControl.EnabledChanged;
begin
  if not Enabled and (Parent.FSelectedItem = Self) then
    Parent.FSelectedItem := nil;
  Repaint;
end;

procedure TdxBarItemControl.GlyphChanged;
begin
  Repaint;
end;

procedure TdxBarItemControl.PressedChanged;
begin
  if not FPressed then Repaint;
end;

procedure TdxBarItemControl.ShortCutChanged;
begin
  if (Parent <> nil) and (Parent is TdxBarSubMenuControl) then
    FParent.RepaintBar;
end;

procedure TdxBarItemControl.VisibleChanged;
begin
  FParent.RepaintBar;
end;

function TdxBarItemControl.CanClicked: Boolean;
begin
  Result := True;
end;

function TdxBarItemControl.CanCustomize: Boolean;
begin
  Result :=
    (BarManager = Item.BarManager) or
    (csAncestor in BarManager.ComponentState);
end;

function TdxBarItemControl.CanMouseSelect: Boolean;
begin
  Result := CanSelect;
end;

function TdxBarItemControl.CanSelect: Boolean;
begin
  Result :=
    not (Parent.IsCustomizing and (BarManager <> Item.BarManager) and
      not (csAncestor in BarManager.ComponentState));
end;

function TdxBarItemControl.CanVisuallyPressed: Boolean;
begin
  Result := not Parent.HideOnClick;
end;

procedure TdxBarItemControl.Click(ByMouse: Boolean);
var
  AParent: TCustomdxBarControl;
begin
  if Enabled then
  begin
    AParent := Parent;
    ControlClick(ByMouse);
    if BarControlExists(AParent) and AParent.ItemExists(Self) then
      ControlUnclick(ByMouse);
  end;
end;

procedure TdxBarItemControl.ControlActivate(Immediately: Boolean);
begin
  FIsActive := True;
end;

procedure TdxBarItemControl.ControlInactivate(Immediately: Boolean);
begin
  FIsActive := False;
end;

procedure TdxBarItemControl.ControlClick(ByMouse: Boolean);
begin
end;

procedure TdxBarItemControl.ControlUnclick(ByMouse: Boolean);
var
  AItem: TdxBarItem;
  AItemLink: TdxBarItemLink;
  AllowClick, AIsDestroyOnClick, AllowPressed: Boolean;
  AParent: TCustomdxBarControl;
begin
  if (Self is TdxBarButtonControl) and (Parent is TdxBarSubMenuControl) then
    PlaySound(psMenuCommand);
  AItemLink := FItemLink.RealItemLink;
  AItem := FItemLink.Item;
  AllowClick := CanClicked;
  AIsDestroyOnClick := IsDestroyOnClick;
  AParent := Parent;
  try
    if AIsDestroyOnClick then
    begin
      AItemLink.BringToTopInRecentList(True);
      // for TCustomdxBarContainerItem:
      if AItemLink <> FItemLink then FItemLink.BringToTopInRecentList(True);
    end;
  except
  end;
  AllowPressed :=
    UnclickAfterDoing and (not AIsDestroyOnClick or CanVisuallyPressed);
  if AllowPressed then Pressed := True;
  try
    if AIsDestroyOnClick then Parent.HideAll
    else
      if AItemLink = nil then AItemLink := FItemLink;
    if AllowClick then
    begin
      AItem.FClickItemLink := AItemLink;
      try
        AItem.DirectClick;
      finally
        AItem.FClickItemLink := nil;
      end;
    end;
  finally
    try
      if AllowPressed and BarControlExists(AParent) then
        Pressed := False;
    except
    end;
  end;
end;

procedure TdxBarItemControl.DblClick;
begin
end;

function TdxBarItemControl.DrawSelected: Boolean;
begin
  Result := IsSelected;
end;

function TdxBarItemControl.WantsDblClick: Boolean;
begin
  Result := BarManager.Designing or IsExpandable;
end;

procedure TdxBarItemControl.KeyDown(Key: Word);
begin
end;

function TdxBarItemControl.WantsKey(Key: Word): Boolean;
begin
  Result := False;
end;

procedure TdxBarItemControl.DrawLowered(DC: HDC; var R: TRect);
begin
  if Flat then
    FrameRect(DC, R, GetSysColorBrush(COLOR_BTNSHADOW))
  else
    DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
  InflateRect(R, -1, -1);
end;

procedure TdxBarItemControl.DrawGlyph(R: TRect; FullBounds: PRect;
  PaintType: TdxBarPaintType;
  IsGlyphEmpty, Selected, Down, DrawDowned, Center, ForceUseBkBrush,
  BarControlOwner: Boolean);
var
  AWidth, AHeight, AImageWidth, AImageHeight: Integer;
  GlyphRect: TRect;

  procedure GetDimensions(var AWidth, AHeight: Integer);
  begin
    with R do
    begin
      AWidth := Right - Left;
      AHeight := Bottom - Top;
      if not Center then
        case PaintType of
          ptHorz:
            AWidth := BarManager.ButtonWidth;
          ptVert:
            AHeight := BarManager.ButtonHeight;
        end;
    end;
  end;

  procedure GetImageDimensions(var AWidth, AHeight: Integer);
  begin
    if (Glyph = nil) or Glyph.Empty then
      with Images do
      begin
        AWidth := Width;
        AHeight := Height;
      end
    else
      with Glyph do
      begin
        AWidth := Width;
        AHeight := Height;
      end;
  end;

  procedure GetRealImageDimensions(var AImageWidth, AImageHeight: Integer);
  var
    Multiplier: Integer;
  begin
    if PaintType = ptMenu then
      if BarManager.StretchGlyphs then
      begin
        if Center then
          AImageWidth := MulDiv(AImageWidth, AHeight, NormalItemHeightInSubMenu)
        else
          AImageWidth := MulDiv(AImageWidth, AWidth, NormalItemHeightInSubMenu);
        AImageHeight := MulDiv(AImageHeight, AHeight, NormalItemHeightInSubMenu);
      end
      else
    else
    begin
      Multiplier := 1 + Byte(BarManager.LargeIcons);
      AImageWidth := Multiplier * AImageWidth;
      AImageHeight := Multiplier * AImageHeight;
    end;
  end;

  function GetImageBounds: TRect;
  begin
    Result := Bounds(
      R.Left + (AWidth - AImageWidth) div 2,
      R.Top + (AHeight - AImageHeight) div 2,
      AImageWidth, AImageHeight);
    if not Flat then
    begin
      if Down then OffsetRect(Result, 1, 1);
      if DrawDowned then OffsetRect(Result, 1, 1);
    end;
  end;

begin
  GlyphRect := R;
  GetDimensions(AWidth, AHeight);

  IsGlyphEmpty := IsGlyphEmpty or not ImageExists;
  if not IsGlyphEmpty then
  begin
    GetImageDimensions(AImageWidth, AImageHeight);
    GetRealImageDimensions(AImageWidth, AImageHeight);
    GlyphRect := GetImageBounds;
  end;

  if FullBounds <> nil then
    R := FullBounds^;
  DrawGlyphAndBkgnd(R, GlyphRect, PaintType, Glyph, Images, ImageIndex,
    IsGlyphEmpty or not ImageExists, Selected, Down, DrawDowned,
    ForceUseBkBrush, False, BarControlOwner);
end;

procedure TdxBarItemControl.DrawGlyphAndBkgnd(R: TRect; const GlyphRect: TRect;
  PaintType: TdxBarPaintType;
  AGlyph: TBitmap; AImages: TCurImageList; AImageIndex: Integer;
  IsGlyphEmpty, Selected, Down, DrawDowned, ForceUseBkBrush, GrayScale,
  BarControlOwner: Boolean);
const
  Borders: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  DC: HDC;
  ABrush: HBRUSH;
  AWidth, AHeight, AImageWidth, AImageHeight: Integer;
  NeedBorder: Boolean;

  procedure GetDimensions(var AWidth, AHeight: Integer);
  begin
    with R do
    begin
      AWidth := Right - Left;
      AHeight := Bottom - Top;
    end;
  end;

  function GetBrush: HBRUSH;

    function GetFlatBrush: HBRUSH;
    begin
      if Selected then
        if Down or DrawDowned then
          if Down and BarControlOwner then
            Result := Parent.BarControlOwnerBrush
          else
            Result := Parent.ToolbarDownedSelBrush
        else
          Result := Parent.ToolbarSelBrush
      else
        if Down then
          Result := Parent.ToolbarDownedBrush
        else
          if (PaintType = ptMenu) and not ForceUseBkBrush then
            Result := BarManager.FlatToolbarsBrush
          else
            Result := Parent.BkBrush;
    end;

    function GetNonFlatBrush: HBRUSH;
    begin
      if Down and Enabled then
        if Selected then
          Result := Parent.ToolbarDownedSelBrush
        else
          Result := Parent.ToolbarDownedBrush
      else
        if Selected and (PaintType = ptMenu) and IsGlyphEmpty and not Down then
          Result := Parent.ToolbarSelBrush
        else
          Result := Parent.BkBrush;
    end;

  begin
    if Flat then
      Result := GetFlatBrush
    else
      Result := GetNonFlatBrush;
  end;

  procedure DrawEmptyImage;
  var
    DoubleSize: Integer;

    procedure DrawCheckMark(X, Y: Integer);
    const
      Colors: array[Boolean] of TColor = (clBlack, clWhite);
    var
      OffsetY, I: Integer;

      procedure DrawOneMark;
      begin
        with Parent.Canvas do
        begin
          MoveTo(X + DoubleSize * 1, Y + OffsetY + DoubleSize * 2);
          LineTo(X + DoubleSize * 3, Y + OffsetY + DoubleSize * 4);
          LineTo(X + DoubleSize * 8, Y + OffsetY - DoubleSize * 1);
        end;
        Inc(OffsetY);
      end;

    begin
      with Parent.Canvas do
        if Enabled then
        begin
          OffsetY := 0;
          if not Flat then
          begin
            Pen.Color := clSilver;
            for I := 1 to DoubleSize do DrawOneMark;
          end;
          Pen.Color := Colors[GetSysColor(COLOR_BTNFACE) = 0];
          for I := 1 to 2 * DoubleSize do DrawOneMark;
          if not Flat then
          begin
            Pen.Color := Colors[GetSysColor(COLOR_BTNFACE) <> 0];
            for I := 1 to DoubleSize do DrawOneMark;
            MoveTo(X + DoubleSize - 1, Y + DoubleSize * 3 - (DoubleSize - 1));
            LineTo(X + DoubleSize - 1, Y + DoubleSize * 5 + (DoubleSize - 1));
            MoveTo(X + DoubleSize * 8, Y - DoubleSize * 1 + 2);
            LineTo(X + DoubleSize * 8, Y + DoubleSize * 3);
          end;
        end
        else
        begin
          OffsetY := 1;
          Pen.Color := GetSysColor(COLOR_BTNSHADOW);
          for I := 1 to 2 * DoubleSize do DrawOneMark;
          if not Flat then
          begin
            Pen.Color := GetSysColor(COLOR_BTNHIGHLIGHT);
            for I := 0 to DoubleSize - 1 do
            begin
              MoveTo(X + DoubleSize * 4 - (DoubleSize - 1),
                Y + DoubleSize * 6 + (DoubleSize - 1 - I));
              LineTo(X + DoubleSize * 9, Y + DoubleSize * 1 - I);
              MoveTo(X + DoubleSize * 4, Y + DoubleSize * 7 - I);
              LineTo(X + DoubleSize * 9, Y + DoubleSize * 2 - I);
            end;
          end;
        end;
    end;

  begin
    if NeedBorder then InflateRect(R, -1, -1);
    FillRect(DC, R, ABrush);
    if NeedBorder then InflateRect(R, 1, 1);
    if (PaintType = ptMenu) and Down then
      with R do
      begin
        DoubleSize := 1 + Byte(Parent.Canvas.Font.Size >= 16);
        DrawCheckMark(
          (Left + Right - DoubleSize * 9) div 2,
          (Top + Bottom - DoubleSize * 7) div 2);
      end;
  end;

  procedure GetImageDimensions(var AWidth, AHeight: Integer);
  begin
    with GlyphRect do
    begin
      AWidth := Right - Left;
      AHeight := Bottom - Top;
    end;
  end;

  procedure DrawImage;
  begin
    if NeedBorder then InflateRect(R, -1, -1);
    TransparentDraw(DC, ABrush, R, GlyphRect,
      AGlyph, AImages, AImageIndex,
      Enabled, GrayScale, Flat, Selected, Down, DrawDowned,
      Item.BarManager.ImageListBkColor);
    if NeedBorder then InflateRect(R, 1, 1);
  end;

  procedure DrawBorder;
  begin
    if Down or (Selected and ((PaintType <> ptMenu) or not IsGlyphEmpty and not Flat)) then
      if Flat then
        if Down and BarControlOwner then
          Parent.DrawBarControlOwnerBorder(DC, R, OwnedBarControl)
        else
          FrameFlatSelRect(DC, R)
      else
        DrawEdge(DC, R, Borders[Down or DrawDowned], BF_RECT)
    else
      if NeedBorder then FrameRect(DC, R, ABrush);
  end;

begin
  DC := Parent.Canvas.Handle;
  GetDimensions(AWidth, AHeight);
  ABrush := GetBrush;
  if IsGlyphEmpty then
  begin
    NeedBorder :=
      (BarManager.GlyphSize + 2 <= AWidth) and (BarManager.GlyphSize + 2 <= AHeight);
    DrawEmptyImage;
  end
  else
  begin
    GetImageDimensions(AImageWidth, AImageHeight);
    NeedBorder :=
      (AImageWidth + 2 <= AWidth) and (AImageHeight + 2 <= AHeight);
    DrawImage;
  end;
  DrawBorder;
end;
  
procedure TdxBarItemControl.DrawGlyphAndTextInSubMenu(DC: HDC; var R: TRect;
  Selected, ShowGlyph, Down: Boolean);
var
  I: Integer;
  IconRect: TRect;
  IsGlyphEmpty: Boolean;
  Brush: HBRUSH;
begin
  with R do
  begin
    if Flat then
    begin
      if Selected then
        FrameFlatSelRect(DC, R)
      else
      begin
        I := Left + Bottom - Top + 1;

        FillRect(DC, Rect(Left, Top, I, Top + 1), BarManager.FlatToolbarsBrush);
        FillRect(DC, Rect(Left, Bottom - 1, I, Bottom), BarManager.FlatToolbarsBrush);
        FillRect(DC, Rect(Left, Top + 1, Left + 1, Bottom - 1), BarManager.FlatToolbarsBrush);

        FillRect(DC, Rect(I, Top, Right, Top + 1), Parent.BkBrush);
        FillRect(DC, Rect(I, Bottom - 1, Right, Bottom), Parent.BkBrush);
        FillRect(DC, Rect(Right - 1, Top + 1, Right, Bottom - 1), Parent.BkBrush);
      end;
      InflateRect(R, -1, -1);
    end;
    IconRect := R;
    IconRect.Right := IconRect.Left + Bottom - Top;
    IsGlyphEmpty := not ImageExists or not ShowGlyph;

    DrawGlyph(IconRect, nil, ptMenu, IsGlyphEmpty, Selected, Down, False, False, False, False);
    if Selected and (Flat or IsGlyphEmpty and not Down) then
      Brush := Parent.ToolbarSelBrush
    else
      if Flat then
        Brush := BarManager.FlatToolbarsBrush
      else
        Brush := Parent.BkBrush;
    Left := IconRect.Right + 1 + Byte(Flat);
    with IconRect do
      FillRect(DC, Rect(Right, Top, R.Left, Bottom), Brush);
        
    if Selected then
      Brush := Parent.ToolbarSelBrush
    else
      Brush := Parent.BkBrush;
    FillRect(DC, R, Brush);
    if Flat then
      Inc(Left, 8)
    else
      Inc(Left, 2);
    DrawItemText(DC, Caption, R, DT_LEFT, Enabled, Selected, False, False, Flat);
  end;  
end;

procedure TdxBarItemControl.DrawItemText(DC: HDC; S: string; PaintRect: TRect;
  Alignment: UINT; Enabled, Selected, Rotated, Clipped, Flat: Boolean);
var
  R: TRect;
  Format: UINT;
  ClipRgn: HRGN;
  TM: TTextMetric;
  AccelPos, OffsetY: Integer;
  l_Size, Size1: TSize;

  function GetAccelPos(S: string): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    I := 1;
    while I < Length(S) do
    begin
      if S[I] = '&' then
      begin
        Delete(S, I, 1);
        if S[I] <> '&' then Result := I;
      end;
      Inc(I);
    end;
  end;

  procedure UnderlineAccel;
  var
    X, Y: Integer;
    Pen, PrevPen: HPEN;
  begin
    if AccelPos > 0 then
    begin
      Pen := CreatePen(PS_SOLID, 1, GetTextColor(DC));
      PrevPen := SelectObject(DC, Pen);
      with R do
      begin
        X := (Left + Right - l_Size.cy) div 2 + TM.tmDescent - 2;
        Y := Top + OffsetY;
        MoveToEx(DC, X, Y, nil);
        LineTo(DC, X, Y + Size1.cx);
      end;
      SelectObject(DC, PrevPen);
      DeleteObject(Pen);
    end;
  end;

begin
  R := PaintRect;
  SetBkMode(DC, TRANSPARENT);
  Format := DT_SINGLELINE;
  ClipRgn := 0;
  if not Clipped then
    Format := Format or DT_NOCLIP
  else
    if Rotated then
    begin
      Format := Format or DT_NOCLIP;
      ClipRgn := CreateRectRgn(0, 0, 0, 0);
      GetClipRgn(DC, ClipRgn);
      with PaintRect do
        IntersectClipRect(DC, Left, Top, Right, Bottom);
    end;
  if Rotated then
  begin
    GetTextMetrics(DC, TM);
    AccelPos := GetAccelPos(S);
    if AccelPos > 0 then
    begin
      S := GetTextOf(S);
      Format := Format or DT_NOPREFIX;
    end;  
    with PaintRect do
    begin
      GetTextExtentPoint32(DC, PChar(S), Length(S), l_Size);
      case Alignment of
        DT_CENTER:
          OffsetY := (Bottom - Top - l_Size.cx) div 2;
        DT_LEFT:
          OffsetY := 0;
        DT_RIGHT:
          OffsetY := Bottom - Top - l_Size.cx;
      end;
      OffsetRect(PaintRect, (Right - Left + l_Size.cy) div 2, OffsetY);
      if AccelPos > 0 then
      begin
        GetTextExtentPoint32(DC, PChar(Copy(S, 1, AccelPos - 1)), AccelPos - 1, Size1);
        Inc(OffsetY, Size1.cx);
        GetTextExtentPoint32(DC, PChar(string(S[AccelPos])), 1, Size1);
      end;
    end;
  end
  else
    Format := Format or Alignment or DT_VCENTER;
  if Enabled then
    if Selected and not Flat then
      SetTextColor(DC, GetSysColor(COLOR_HIGHLIGHTTEXT))
    else
      SetTextColor(DC, GetSysColor(COLOR_BTNTEXT))
  else
    if Selected or Flat then
      SetTextColor(DC, GetSysColor(COLOR_GRAYTEXT))
    else
    begin
      OffsetRect(PaintRect, 1, 1);
      SetTextColor(DC, GetSysColor(COLOR_BTNHIGHLIGHT));
      DrawText(DC, PChar(S), Length(S), PaintRect, Format);
      if Rotated then
      begin
        OffsetRect(R, 1, 1);
        UnderlineAccel;
        OffsetRect(R, -1, -1);
      end;
      OffsetRect(PaintRect, -1, -1);
      SetTextColor(DC, GetSysColor(COLOR_BTNSHADOW));
    end;
  DrawText(DC, PChar(S), Length(S), PaintRect, Format);
  if Rotated then UnderlineAccel;
  if ClipRgn <> 0 then
  begin
    GetRgnBox(ClipRgn, R);
    if IsRectEmpty(R) then
      SelectClipRgn(DC, 0)
    else
      SelectClipRgn(DC, ClipRgn);
    DeleteObject(ClipRgn);
  end;
  SetBkMode(DC, OPAQUE);
end;

procedure TdxBarItemControl.FrameAndFillRect(DC: HDC; var R: TRect;
  Selected, Pressed: Boolean);
const
  Borders: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  Brush: HBRUSH;
begin
  Brush := Parent.BkBrush;
  if Selected then
    if Flat then
    begin
      FrameFlatSelRect(DC, R);
      Brush := Parent.ToolbarSelBrush;
    end
    else
      DrawEdge(DC, R, Borders[Pressed], BF_RECT)
  else
    FrameRect(DC, R, Parent.BkBrush);
  InflateRect(R, -1, -1);
  FillRect(DC, R, Brush);
end;

procedure TdxBarItemControl.GetArrowParams(APaintType: TdxBarPaintType;
  ASelected, ADroppedDown: Boolean; var ABrush: HBRUSH; var AArrowColor: COLORREF);
begin
  AArrowColor := COLOR_BTNTEXT;
  if ASelected and Flat then
    if ADroppedDown then
    begin
      ABrush := Parent.ToolbarDownedSelBrush;
      AArrowColor := COLOR_HIGHLIGHTTEXT;
    end
    else
      ABrush := Parent.ToolbarSelBrush
  else
    ABrush := Parent.BkBrush
end;

function TdxBarItemControl.GetCaption: string;
begin
  if FItemLink <> nil then
    Result := FItemLink.Caption
  else
    Result := '';
end;

function TdxBarItemControl.GetEnabled: Boolean;
begin
  if FItemLink <> nil then
    Result := FItemLink.Item.Enabled
  else
    Result := False;
end;

function TdxBarItemControl.GetGlyph: TBitmap;
begin
  if FItemLink <> nil then
    Result := FItemLink.Glyph
  else
    Result := nil;
end;

function TdxBarItemControl.GetImageIndex: Integer;
begin
  Result := FItemLink.Item.ImageIndex;
end;

function TdxBarItemControl.GetImages: TCurImageList;
begin
  Result := FItemLink.Item.BarManager.Images;
end;

function TdxBarItemControl.GetHint;
begin
  if (FItemLink <> nil) and (FItemLink.Item <> nil) then
    Result := FItemLink.Item.Hint
  else
    Result := '';
end;

function TdxBarItemControl.GetHotImages: TCurImageList;
begin
  Result := FItemLink.Item.BarManager.HotImages;
end;

function TdxBarItemControl.GetLargeImages: TCurImageList;
begin
  Result := FItemLink.Item.BarManager.LargeImages;
end;

function TdxBarItemControl.GetShortCut;
begin
  if FItemLink <> nil then
    Result := FItemLink.Item.ShortCut
  else
    Result := 0;
end;

function TdxBarItemControl.GetTextAreaOffset: Integer;
begin
  if Parent is TdxBarSubMenuControl then
    if Flat then
      Result := 1 + Parent.TextSize + 2
    else
      Result := Parent.TextSize + 1
  else
    Result := 0;
end;

function TdxBarItemControl.GetHeight: Integer;
begin
  Result := 0;
end;

function TdxBarItemControl.GetMinHeight: Integer;
begin
  Result := 1;
end;

function TdxBarItemControl.GetMinWidth: Integer;
begin
  Result := 1;
end;

function TdxBarItemControl.GetOwnedBarControl: TCustomdxBarControl;
begin
  Result := nil;
end;

function TdxBarItemControl.GetWidth: Integer;
begin
  Result := 0;
end;

function TdxBarItemControl.HasHint: Boolean;
begin
  Result := (Hint <> '') and (Parent is TdxBarControl);
end;

function TdxBarItemControl.HasShadow: Boolean;
begin
  Result := FParent.ChildrenHaveShadows;
end;

function TdxBarItemControl.ImageExists: Boolean;
begin
  Result := not Glyph.Empty or ImageIndexLinked;
end;

function TdxBarItemControl.ImageIndexLinked: Boolean;
begin
  Result := (Images <> nil) and
    (0 <= ImageIndex) and (ImageIndex < Images.Count);
end;

function TdxBarItemControl.IsDestroyOnClick: Boolean;
begin
  Result := True;
end;

function TdxBarItemControl.IsExpandable: Boolean;
begin
  Result := False;
end;

function TdxBarItemControl.MousePressed: Boolean;
var
  R: TRect;
  P: TPoint;
begin
  R := Parent.GetItemRect(Self);
  GetCursorPos(P);
  ScreenToClient(Parent.Handle, P);
  Result := Enabled and PtInRect(R, P);
  if Result then
    if InMouseHook then
      Result := LeftButtonPressed
    else
      Result := GetKeyState(VK_LBUTTON) < 0;
end;

function TdxBarItemControl.NeedCaptureMouse: Boolean;
begin
  Result := False;
end;

procedure TdxBarItemControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
begin
end;

function TdxBarItemControl.ParentIsQuickCustControl: Boolean;
begin
  Result := Parent is TdxBarQuickControl;
end;

function TdxBarItemControl.WantMouse: Boolean;
begin
  Result := CanSelect or CanClicked;
end;

procedure TdxBarItemControl.Repaint;
begin
  if not Parent.IsDestroying then Parent.PaintItem(Self);
end;

{ TdxBarWinControl }

constructor TdxBarWinControl.Create(AItemLink: TdxBarItemLink);
begin
  inherited Create(AItemLink);
  FHasWindow := True;
  if not (Parent is TdxBarControl and TdxBarControl(Parent).Moving) then
    CreateWindowHandle;
end;

destructor TdxBarWinControl.Destroy;
begin
  if not (Parent is TdxBarControl and TdxBarControl(Parent).Moving) then
    DestroyWindowHandle;
  inherited Destroy;
end;

function TdxBarWinControl.GetItem: TdxBarWindowItem;
begin
  Result := TdxBarWindowItem(ItemLink.Item);
end;

function TdxBarWinControl.GetWindowRect: TRect;
begin
  if Enabled then
  begin
    Result := FWindowRect;
    if Item.EmptyWindow then
      with Result do Right := Left;
  end
  else
    SetRectEmpty(Result);  
end;

function TdxBarWinControl.CanClicked: Boolean;
begin
  Result := IsVertical(FParent);
end;

procedure TdxBarWinControl.ControlInactivate(Immediately: Boolean);
begin
  inherited;
  Focused := False;
end;

procedure TdxBarWinControl.ControlClick(ByMouse: Boolean);
begin
  Focused := True;
  inherited;
end;

procedure TdxBarWinControl.CreateWindowHandle;
begin
  FDefWndProc := MakeObjectInstance(WndProc);
  FPrevDefWndProc := Pointer(GetWindowLong(FHandle, GWL_WNDPROC));
  SetWindowLong(FHandle, GWL_WNDPROC, Longint(FDefWndProc));
end;

procedure TdxBarWinControl.DestroyWindowHandle;
begin
  if FHandle <> 0 then
  begin
    Focused := False;
    SetWindowLong(FHandle, GWL_WNDPROC, Longint(FPrevDefWndProc));
    FreeObjectInstance(FDefWndProc);
    FDefWndProc := nil;
    DestroyWindow(FHandle);
    FHandle := 0;
  end;
end;

function TdxBarWinControl.DoKeyDown(var Message: TWMKey): Boolean;
begin
  with Message do
    TdxBarWindowItem(ItemLink.Item).KeyDown(CharCode,
      KeyDataToShiftState(KeyData));
  Result := (Message.CharCode = 0);
end;

function TdxBarWinControl.DoKeyPress(var Message: TWMKey): Boolean;
var
  Ch: Char;
begin
  with Message do
  begin
    Ch := Char(CharCode);
    TdxBarWindowItem(ItemLink.Item).KeyPress(Ch);
    CharCode := Word(Ch);
  end;
  Result := (Char(Message.CharCode) = #0);
end;

function TdxBarWinControl.DoKeyUp(var Message: TWMKey): Boolean;
begin
  with Message do
    TdxBarWindowItem(ItemLink.Item).KeyUp(CharCode,
      KeyDataToShiftState(KeyData));
  Result := (Message.CharCode = 0);
end;

function TdxBarWinControl.GetText: string;
var
  S: PChar;
  Len: Integer;
begin
  if Handle <> 0 then
  begin
    S := StrAlloc(256);
    Len := SendMessage(Handle, WM_GETTEXT, 255, Longint(S));
    if Len = 0 then Result := ''
    else Result := S;
    StrDispose(S);
  end;
end;

function TdxBarWinControl.IsDestroyOnClick: Boolean;
begin
  Result := False;
end;

procedure TdxBarWinControl.SetFocused(Value: Boolean);
var
  IsDesignForm: Boolean;
  R: TRect;

  procedure SetTopMosts(AShow: Boolean);
  const
    TopMosts: array[Boolean] of HWND = (HWND_NOTOPMOST, HWND_TOPMOST);
  var
    PrevBarControl, ABarControl: TCustomdxBarControl;
  begin
    if dxBarCustomizingPopup <> nil then
      if AShow then
      begin
        SetWindowPos(dxBarCustomizingPopup.Handle, TopMosts[AShow],
          0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
        PrevBarControl := dxBarCustomizingPopup;
        ABarControl := dxBarCustomizingPopupItemLink.Control.Parent;
        repeat
          SetWindowPos(ABarControl.Handle, PrevBarControl.Handle,
            0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
          PrevBarControl := ABarControl;
          ABarControl := ABarControl.ParentBar;
        until ABarControl = nil;
      end
      else
      begin
        ABarControl := dxBarCustomizingPopupItemLink.Control.Parent;
        while ABarControl.ParentBar <> nil do
          ABarControl := ABarControl.ParentBar;
        repeat
          SetWindowPos(ABarControl.Handle, TopMosts[AShow],
            0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
          ABarControl := ABarControl.ChildBar;
        until ABarControl = nil;
        SetWindowPos(dxBarCustomizingPopup.Handle, TopMosts[AShow],
          0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
      end;
  end;

begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if FFocused then
    begin
      FPrevFocusedControl := Windows.GetFocus;
      if not IsWindowVisible(FPrevFocusedControl) then
        FPrevFocusedControl := BarManager.MainForm.Handle;
      SendMessage(Handle, WM_SETFONT, Parent.EditFontHandle, 0);
      if (Self is TdxBarEditControl) and not Flat then
        SendMessage(Handle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, MakeLParam(2, 2));
      if not IsActive then ControlActivate(True);
      with WindowRect do
        SetWindowPos(Handle, 0, Left, Top,
          Right - Left, Bottom - Top, SWP_SHOWWINDOW);
      if (Self is TdxBarEditControl) and Flat then
      begin
        R := WindowRect;
        with R do
        begin
          OffsetRect(R, -Left, -Top);
          InflateRect(R, -2, -2);
        end;
        SendMessage(Handle, EM_SETRECTNP, 0, LPARAM(@R));
      end;
      FFocusing := True;
      try
        Text := TdxBarWindowItem(FItemLink.Item).Text;
      finally
        FFocusing := False;
      end;
      SetFocus(Handle);
    end
    else
    begin
{      if FHandle <> 0 then
        SetWindowPos(Handle, 0, 0, 0, 0, 0,
          SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_HIDEWINDOW or SWP_NOACTIVATE);}
      if FHandle <> 0 then ShowWindow(Handle, SW_HIDE);
      if not BarManager.FToolbarsVisibleChanging then
      begin
        IsDesignForm := (dxBarCustomizingForm <> nil) and
          (GetParentForm(FindControl(FPrevFocusedControl)) = dxBarCustomizingForm);
        if IsDesignForm then SetTopMosts(True);
        if (FPrevFocusedControl > 0) and IsWindowVisible(FPrevFocusedControl) then
          SetFocus(FPrevFocusedControl)
        else
          if IsWindowVisible(BarManager.MainForm.Handle) then
            Windows.SetFocus(BarManager.MainForm.Handle)
          else
            Windows.SetFocus(GetNextWindow(BarManager.MainForm.Handle, GW_HWNDNEXT));
        if IsDesignForm then SetTopMosts(False);
        FPrevFocusedControl := 0;
      end;
      if BarManager.AlwaysSaveText and
        ((GetAsyncKeyState(VK_ESCAPE) >= 0) or
         (GetAsyncKeyState(VK_CONTROL) < 0) or (GetAsyncKeyState(VK_MENU) < 0)) then
        TdxBarWindowItem(FItemLink.Item).Text := Text;
    end;
  end;
end;

procedure TdxBarWinControl.SetText(Value: string);
begin
  SetWindowText(Handle, PChar(Value));
  if Item.EmptyWindow then Repaint;
end;

procedure TdxBarWinControl.WndProc(var Message: TMessage);
var
  AMsg: TMsg;
  P: TPoint;
  FocusedParent: HWND;

  procedure KillBeep;
  begin
    while PeekMessage(AMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE) do;
  end;

  procedure DefaultHandler;
  begin
    with Message do
      Result := CallWindowProc(FPrevDefWndProc, FHandle, Msg, wParam, lParam);
  end;

begin
  with Message do
  begin
    case Msg of
      WM_SETFOCUS:
        Item.DoEnter;
      WM_KILLFOCUS:
        try
          if Focused then
          begin
            DefaultHandler;
            //KillBeep;
            Parent.HideAll;
            Exit;
          end;
          if Parent is TdxBarControl then
          begin
            if GetFocus = Parent.Handle then
              FocusedParent := Parent.Handle
            else
              FocusedParent := GetParent(GetFocus);
            if not (FindControl(FocusedParent) is TdxBarControl) then
              FocusedParent := GetParent(FocusedParent);
            if FocusedParent <> Parent.Handle then
            begin
              DefaultHandler;
              KillBeep;
              Parent.HideAll;
              Exit;
            end;
          end;
        finally
          Item.DoExit;
        end;
      WM_RBUTTONDOWN:
        begin
          P := SmallPointToPoint(TSmallPoint(lParam));
          MapWindowPoints(Handle, Parent.Handle, P, 1);
          Result := SendMessage(Parent.Handle, Msg, wParam, MakeLParam(P.X, P.Y));
          Exit;
        end;
      WM_CHAR: if DoKeyPress(TWMKey(Message)) then Exit;
      WM_KEYDOWN: if DoKeyDown(TWMKey(Message)) then Exit;
      WM_KEYUP: if DoKeyUp(TWMKey(Message)) then Exit;
      WM_SYSKEYDOWN, WM_SYSKEYUP:
      begin
        if Msg = WM_SYSKEYDOWN then
          Inc(FKeyPressedInside)
        else
          if FKeyPressedInside <> 0 then
            Dec(FKeyPressedInside)
          else
            Exit;
        if (wParam <> VK_MENU) or (Msg = WM_SYSKEYUP) then
        begin
          FKeyPressedInside := 0;
          Parent.HideAll;
          if (wParam = VK_F10) and (GetAsyncKeyState(VK_SHIFT) < 0) then Exit;
          if wParam = VK_MENU then WaitForMenu := True;
          DontCallNextKeybHook := True;
          try
            if dxBarKeyboardHook(0, wParam, lParam) = 1 then Exit;
          finally
            DontCallNextKeybHook := False;
          end;
        end;
      end;
    end;
    if Msg = WM_KEYDOWN then
      case wParam of
        VK_ESCAPE, VK_RETURN:
          begin
            Parent.SetKeySelectedItem(nil);
            KillBeep;
            if wParam = VK_ESCAPE then
              Parent.SelectedItem := Self
            else
              Parent.HideAll;
          end;
        VK_TAB:
          begin
            KillBeep;
            Result := SendMessage(Parent.Handle, Msg, wParam, lParam);
          end;
        else
          DefaultHandler;
      end
    else
    begin
      if (WM_MOUSEFIRST <= Msg) and (Msg <= WM_MOUSELAST) then
      begin
        P := SmallPointToPoint(TSmallPoint(lParam));
        MapWindowPoints(Handle, Parent.Handle, P, 1);
        if not PtInRect(WindowRect, P) and PtInRect(Parent.GetItemRect(Self), P) then Exit;
      end;
      if Msg = WM_DESTROY then Focused := False;
      DefaultHandler;
      if Msg = WM_DESTROY then
      begin
        SetWindowLong(FHandle, GWL_WNDPROC, Longint(FPrevDefWndProc));
        FreeObjectInstance(FDefWndProc);
        FDefWndProc := nil;
        FHandle := 0;
      end;
    end;
  end;
end;

{ TdxBarButtonControl }

function TdxBarButtonControl.ArrowPressed: Boolean;
begin
  Result := MousePressed and MouseOverArrow;
end;

function TdxBarButtonControl.GetButtonStyle: TdxBarButtonStyle;
begin
  Result := Item.ButtonStyle;
end;

function TdxBarButtonControl.GetDown: Boolean;
begin
  if ItemLink.Item is TdxBarButton then
    Result := Item.Down
  else
    Result := False;
end;

function TdxBarButtonControl.GetDropDownEnabled: Boolean;
begin
  Result := Item.DropDownEnabled;
end;

function TdxBarButtonControl.GetDropDownMenuControl: TdxBarSubMenuControl;
begin
  if Item.DropDownMenu <> nil then
    Result := TdxBarSubMenuControl(Item.DropDownMenu.ItemLinks.BarControl)
  else
    Result := nil;
end;

function TdxBarButtonControl.GetDroppedDownFlat: Boolean;
begin
  Result := Flat and FDroppedDown and (DropDownMenuControl <> nil);
end;

function TdxBarButtonControl.GetGroupIndex: Integer;
begin
  Result := Item.GroupIndex;
end;

function TdxBarButtonControl.GetItem: TdxBarButton;
begin
  Result := TdxBarButton(FItemLink.Item);
end;

function TdxBarButtonControl.GetLowered: Boolean;
begin
  Result := Item.Lowered;
end;

function TdxBarButtonControl.GetPaintStyle: TdxBarPaintStyle;
begin
  if FItemLink <> nil then
    Result := FItemLink.PaintStyle
  else
    Result := psStandard;
  if (Parent is TdxBarControl) and (Result = psStandard) and not ImageExists then
    Result := psCaption;
end;

function TdxBarButtonControl.MouseOverArrow: Boolean;
var
  R: TRect;
  P: TPoint;
begin
  if ButtonStyle = bsDropDown then
  begin
    GetCursorPos(P);
    ScreenToClient(Parent.Handle, P);
    R := Parent.GetItemRect(Self);
    R.Left := R.Right - ArrowWidth;
    Result := PtInRect(R, P);
  end
  else Result := False;
end;

function TdxBarButtonControl.ArrowWidth: Integer;
begin
  if Parent is TdxBarSubMenuControl then
    Result := Parent.MenuArrowWidth
  else
    Result := BarManager.RealButtonArrowWidth;
end;

procedure TdxBarButtonControl.ButtonStyleChanged;
begin
  Parent.RepaintBar;
end;

procedure TdxBarButtonControl.ControlInactivate(Immediately: Boolean);
begin
  inherited;
  if (Item.ButtonStyle = bsDropDown) and DroppedDown and (DropDownMenuControl <> nil) then
    DropDownMenuControl.Hide;
end;

procedure TdxBarButtonControl.ControlClick(ByMouse: Boolean);
begin
  inherited;
  if (ButtonStyle = bsDropDown) and ArrowPressed then
    DoDropDown(True)
  else
    if (Parent is TdxBarControl) or (ButtonStyle = bsDropDown) then Repaint;
end;

procedure TdxBarButtonControl.ControlUnclick(ByMouse: Boolean);
begin
  if not DroppedDown then
  begin
    with Item do
      if ButtonStyle = bsChecked then Down := not Down;
    ControlInactivate(True);
    inherited;
  end;
end;

procedure TdxBarButtonControl.DoCloseUp;
begin
  if FDroppedDown then
  begin
    FDroppedDown := False;
    if (Parent is TdxBarControl) then TdxBarControl(Parent).IsDowned := False;
  end;  
end;

procedure TdxBarButtonControl.DoDropDown(ByMouse: Boolean);
var
  Rect: TRect;
  P: TPoint;
  PTmp: Pointer;
begin
  If (Item.DropDownMenu = nil) then
  begin
   if (FItemLink <> nil) and (Assigned(TdxBarButton(Item).FOnDropDown)) then {V}
   begin
    FDroppedDown := True;
    if not IsActive then ControlActivate(True);
    Repaint;
    TdxBarButton(Item).FOnDropDown(Self, Mouse.CursorPos.X, Mouse.CursorPos.Y, ByMouse);
    FDroppedDown := False;
    if Flat then Repaint;
   end
   else
    if Assigned(FOnDropDown) then
    begin
     FDroppedDown := True;
     if not IsActive then ControlActivate(True);
     Repaint;
     FOnDropDown(Self, Mouse.CursorPos.X, Mouse.CursorPos.Y, ByMouse);
     FDroppedDown := False;
     if Flat then Repaint;
    end;
  end
  else
   if not FDroppedDown and Enabled and DropDownEnabled and (Item.DropDownMenu <> nil) then
   begin
     FDroppedDown := True;
     if not IsActive then ControlActivate(True);
     Repaint;
     Rect := Parent.GetItemRect(Self);
     with Rect do
       if Parent is TdxBarSubMenuControl or IsRealVertical(Parent) then
       begin
         P := Point(Right, Top);
         if not Flat or (Parent is TdxBarSubMenuControl) then
           Dec(P.Y, TdxBarSubMenuControl(Parent).BorderSize);
       end
       else
         P := Point(Left, Bottom);
     P := Parent.ClientToScreen(P);
     Item.DoDropDown(Self, P.X, P.Y, ByMouse);
     if Flat then Repaint;
   end;
end;

procedure TdxBarButtonControl.DownChanged;
begin
  Repaint;
end;

procedure TdxBarButtonControl.DrawArrow(const ARect: TRect; Selected: Boolean;
  PaintType: TdxBarPaintType);
const
  Borders: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  Enables: array[Boolean] of Integer = (DFCS_INACTIVE, 0);
var
  DC: HDC;
  R1, R: TRect;
  Brush: HBRUSH;
  ArrowColor: COLORREF;
begin
  DC := Parent.Canvas.Handle;
  R1 := ARect;
  R1.Left := R1.Right - ArrowWidth;
  GetArrowParams(PaintType, Selected, DroppedDown, Brush, ArrowColor);
  if Flat then
  begin
    if PaintType <> ptMenu then Dec(R1.Left);
    if (PaintType = ptMenu) or not DroppedDownFlat then
    begin
      if (PaintType = ptMenu) or Selected then
        if Selected then
          FrameFlatSelRect(DC, R1)
        else
          FrameRect(DC, R1, GetSysColorBrush(COLOR_BTNSHADOW))
      else
        FrameRect(DC, R1, Parent.BkBrush);
      InflateRect(R1, -1, -1);
      FillRect(DC, R1, Brush);
      InflateRect(R1, 1, 1);
    end;
  end
  else
  begin
    FillRect(DC, R1, Brush);
    if Selected then
      DrawEdge(DC, R1, Borders[DroppedDown], BF_RECT)
    else
      if PaintType = ptMenu then
      begin
        R := R1;
        Dec(R.Left);
        R.Right := R.Left + 2;
        DrawEdge(DC, R, EDGE_ETCHED, BF_LEFT or BF_RIGHT);
      end;
  end;
  if PaintType = ptMenu then
  begin
    if DroppedDown and not Flat then OffsetRect(R1, 1, 1);
    DrawLargeItemArrow(DC, R1, atRight, Parent.MenuArrowHeight,
      Flat and DroppedDown, Enabled and DropDownEnabled, Flat);
  end
  else
  begin
    if DroppedDown and not Flat and (R1.Right - R1.Left > 9) then
      OffsetRect(R1, 1, 1);
    DrawItemArrow(DC, R1, atDown, Enabled and DropDownEnabled, False, Flat);
  end;
end;

function TdxBarButtonControl.DrawSelected: Boolean;
begin
  Result := inherited DrawSelected and not FParent.IsCustomizing or Pressed;
end;

procedure TdxBarButtonControl.DropDownEnabledChanged;
begin
  Repaint;
end;

procedure TdxBarButtonControl.GlyphChanged;
begin
  if FItemLink.PaintStyle = psStandard then
    Parent.RepaintBar
  else
    inherited;
end;

function TdxBarButtonControl.GetDefaultHeight: Integer;
begin
  Result := Parent.TextSize;
  if Parent is TdxBarControl then
    if PaintStyle in [psStandard, psCaptionInMenu] then
      Result := BarManager.ButtonHeight
    else
      if not IsVertical(Parent) then
        if Result < BarManager.ButtonHeight then
          Result := BarManager.ButtonHeight
        else
      else
        if Result < BarManager.ButtonWidth then
          Result := BarManager.ButtonWidth
        else
  else
    if Flat then Inc(Result, 2);
  if Lowered then Inc(Result, 2);
end;

function TdxBarButtonControl.GetDefaultWidth: Integer;
begin
  with Parent.Canvas do
    if Parent is TdxBarSubMenuControl then
    begin
      Result := 2 * Parent.TextSize + 3 + TextWidth(GetTextOf(Caption)) + 3;
      if ShortCut <> 0 then
        Inc(Result, Parent.TextSize - 6 + TextWidth(ShortCutToText(ShortCut)));
      if Flat then Inc(Result, 2 + 1 + 6);
    end
    else
      with BarManager, Parent.Canvas do
        if PaintStyle in [psStandard, psCaptionInMenu] then
          Result := ButtonWidth
        else
        begin
          Result := TextWidth(GetTextOf(Caption));
          if PaintStyle = psCaption then
            Inc(Result, Font.Size)
          else
            if not IsVertical(Parent) then
              Inc(Result, ButtonWidth + 4)
            else
              Inc(Result, ButtonHeight + 4);
        end;
  if Lowered then Inc(Result, 2);
end;

function TdxBarButtonControl.GetHeight: Integer;
begin
  if IsVertical(Parent) and (PaintStyle in [psCaption, psCaptionGlyph]) then
    Result := GetDefaultWidth
  else
    Result := GetDefaultHeight;
end;

function TdxBarButtonControl.GetOwnedBarControl: TCustomdxBarControl;
begin
  Result := DropDownMenuControl;
end;

function TdxBarButtonControl.GetWidth: Integer;
begin
  if IsVertical(Parent) and (PaintStyle in [psCaption, psCaptionGlyph]) then
    Result := GetDefaultHeight
  else
    Result := GetDefaultWidth;
  if (Parent is TdxBarControl) and (ButtonStyle = bsDropDown) then
    Inc(Result, ArrowWidth);
end;

function TdxBarButtonControl.IsDestroyOnClick: Boolean;
begin
  Result := Parent is TdxBarControl or Item.CloseSubMenuOnClick;
end;

function TdxBarButtonControl.IsFlatTextSelected(APressed: Boolean): Boolean;
begin
  Result := Flat and (APressed or Down and DrawSelected);
end;

procedure TdxBarButtonControl.KeyDown(Key: Word);
begin
  inherited;
  case Key of
    VK_UP, VK_DOWN, VK_RIGHT: DoDropDown(False);
  end;
end;

function TdxBarButtonControl.NeedCaptureMouse: Boolean;
begin
  Result := not DroppedDown;
end;

procedure TdxBarButtonControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
var
  DC: HDC;
  R: TRect;
  Selected, APressed: Boolean;

  function GetFullBounds: PRect;
  begin
    if DroppedDownFlat then
      Result := @ARect
    else
      Result := nil;
  end;

  procedure PrepareCaptionBounds;
  begin
    with R do
      if PaintStyle = psCaption then
        if PaintType = ptHorz then
          Inc(Left, Parent.Canvas.Font.Size div 2)
        else
          Inc(Top, Parent.Canvas.Font.Size div 2)
      else
        if PaintType = ptHorz then
          Inc(Left, BarManager.ButtonWidth)
        else
          Inc(Top, BarManager.ButtonHeight);
    if not Flat then
    begin
      if Down then OffsetRect(R, 1, 1);
      if APressed then OffsetRect(R, 1, 1);
    end;
  end;

begin
  if ARect.Left = ARect.Right then Exit;
  DC := Parent.Canvas.Handle;
  if Lowered then DrawLowered(DC, ARect);
  R := ARect;
  Selected := DrawSelected;
  with R do
    if PaintType = ptMenu then
    begin
      DrawGlyphAndTextInSubMenu(DC, R, Selected,
        not (PaintStyle in [psCaption, psCaptionInMenu]), Down);
      if ShortCut <> 0 then
      begin
        Dec(Right, 5 + Bottom - Top);
        DrawItemText(DC, ShortCutToText(ShortCut), R, DT_RIGHT,
          Enabled, Selected, False, False, Flat);
      end;
    end
    else
    begin
      if ButtonStyle = bsDropDown then Dec(Right, ArrowWidth);
      APressed := Selected and Parent.IsActive and
        MousePressed and not ArrowPressed and not DroppedDown or
        Pressed and (ButtonStyle <> bsChecked);

      DrawGlyph(R, GetFullBounds, PaintType, PaintStyle = psCaption, Selected,
        Down or DroppedDownFlat, APressed, False, False, ButtonStyle = bsDropDown);

      if PaintStyle in [psCaption, psCaptionGlyph] then
      begin
        PrepareCaptionBounds;
        DrawItemText(DC, Caption, R, DT_LEFT, Enabled, IsFlatTextSelected(APressed),
          PaintType = ptVert, False, Flat and not IsFlatTextSelected(APressed));
      end;
    end;
  if ButtonStyle = bsDropDown then DrawArrow(ARect, Selected, PaintType);
end;

procedure TdxBarButtonControl.PaintStyleChanged;
begin
  Parent.RepaintBar;
end;

function TdxBarButtonControl.WantsKey(Key: Word): Boolean;
begin
  Result :=
    inherited WantsKey(Key) or
    (ButtonStyle = bsDropDown) and
    ((Parent is TdxBarControl) and ((Key = VK_UP) or (Key = VK_DOWN)) or
     (Parent is TdxBarSubMenuControl) and (Key = VK_RIGHT));
end;

function TdxBarButtonControl.GetOnDropDown: TOnDropDownEvent;
begin
 if (FItemLink <> nil) and (not Assigned(FOnDropDown)) then
    Result := TdxBarButton(FItemLink).FOnDropDown
  else
    Result := FOnDropDown;
end;

{ TdxBarEditControl }

function TdxBarEditControl.GetCaptionWidth: Integer;
begin
  if ShowCaption then
  begin
    Result := Parent.Canvas.TextWidth(GetTextOf(Caption));
    if Flat then
      Result := 1 + 5 + Result + 5
    else
      Result := 2 + Result + 4
  end
  else
    Result := 0;
end;

function TdxBarEditControl.GetItem: TdxBarEdit;
begin
  Result := TdxBarEdit(ItemLink.Item);
end;

function TdxBarEditControl.GetMaxLength: Integer;
begin
  Result := Item.MaxLength;
end;

function TdxBarEditControl.GetReadOnly: Boolean;
begin
  Result := Item.ReadOnly;
end;

function TdxBarEditControl.GetShowCaption: Boolean;
begin
  Result := (Parent is TdxBarSubMenuControl) or Item.ShowCaption;
end;

procedure TdxBarEditControl.ControlClick(ByMouse: Boolean);
begin
  inherited;
  if Focused then SendMessage(FHandle, EM_SETSEL, 0, -1);
end;

procedure TdxBarEditControl.CreateWindowHandle;
begin
  FHandle := CreateWindowEx(0, 'EDIT', '',
    WS_CHILD or ES_AUTOHSCROLL or Byte(Flat) * ES_MULTILINE,
    0, 0, 100, 100, Parent.Handle, 0, HInstance, nil);

  Text := Item.Text;
  SendMessage(FHandle, EM_SETLIMITTEXT, MaxLength, 0);

  inherited CreateWindowHandle;
end;

procedure TdxBarEditControl.DrawBorder(DC: HDC; var ARect: TRect;
  PaintType: TdxBarPaintType; Selected: Boolean);
var
  Brush: HBRUSH;
begin
  if Selected then
    if Flat then
      FrameFlatSelRect(DC, ARect)
    else
      DrawEdge(DC, ARect, BDR_SUNKENOUTER, BF_RECT)
  else
    if Flat and ((PaintType = ptMenu) or not Enabled) then
      if PaintType = ptMenu then
        FrameRect(DC, ARect, Parent.ToolbarBrush)
      else
        FrameRect(DC, ARect, GetSysColorBrush(COLOR_BTNSHADOW))
    else
      FrameRect(DC, ARect, Parent.BkBrush);
  InflateRect(ARect, -1, -1);
  if not Flat then
  begin
    if Enabled then
      Brush := Parent.BkBrush
    else
      Brush := GetSysColorBrush(COLOR_BTNHIGHLIGHT);
    FrameRect(DC, ARect, Brush);
    InflateRect(ARect, -1, -1);
  end;
end;

procedure TdxBarEditControl.DrawCaption(DC: HDC; var ARect: TRect;
  PaintType: TdxBarPaintType; Selected: Boolean);
var
  S: string;
  l_Size: TSize;
  R: TRect;
  Brush: HBRUSH;
begin
  if not ShowCaption then Exit;
  S := GetTextOf(Caption);
  GetTextExtentPoint32(DC, PChar(S), Length(S), l_Size);
  R := ARect;
  if Flat then
  begin
    R.Right := R.Left + 1 + 5 + l_Size.cX + 5;
    ARect.Left := R.Right;
    if Selected and (PaintType = ptMenu) then
    begin
      Inc(R.Right);
      FrameFlatSelRect(DC, R);
      InflateRect(R, -1, -1);
    end;
  end
  else
  begin
    R.Right := R.Left + 2 + l_Size.cX;
    ARect.Left := R.Right + 4;
  end;
  if Selected and (PaintType = ptMenu) then
    Brush := Parent.ToolbarSelBrush
  else
    Brush := Parent.BkBrush;
  FillRect(DC, R, Brush);
  if Flat then Dec(R.Right, 5);
  DrawItemText(DC, Caption, R, DT_RIGHT, Enabled,
    Selected and (PaintType = ptMenu), False, False, Flat);
  if not Flat then
  begin
    R.Left := R.Right;
    R.Right := ARect.Left;
    FillRect(DC, R, Parent.BkBrush);
  end;
end;

function TdxBarEditControl.DrawSelected: Boolean;
begin
  Result := inherited DrawSelected and not FParent.IsCustomizing;
end;

procedure TdxBarEditControl.DrawTextField(DC: HDC; const ARect: TRect);
var
  ATextColor, ABkColor: COLORREF;
  LogBrush: TLogBrush;
  PrevClipRgn: HRGN;
  ClipRgnExists: Boolean;
  PrevFont: HFONT;
begin
  if Enabled or Flat then
  begin
    if Enabled then
    begin
      ATextColor := GetSysColor(COLOR_WINDOWTEXT);
      ABkColor := GetSysColor(COLOR_WINDOW);
    end
    else
    begin
      ATextColor := GetSysColor(COLOR_GRAYTEXT);
      GetObject(Parent.BkBrush, SizeOf(LogBrush), @LogBrush);
      ABkColor := LogBrush.lbColor;
    end;
      
    SetTextColor(DC, ATextColor);
    PrevClipRgn := CreateRectRgn(0, 0, 0, 0);
    ClipRgnExists := GetClipRgn(DC, PrevClipRgn) = 1;
    with ARect do
      IntersectClipRect(DC, Left, Top, Right, Bottom);
    try
      with Parent.Canvas do
      begin
        Font.Color := ATextColor;
        Brush.Color := ABkColor;
        Handle;  // RequiredState(csAllValid)
      end;
      PrevFont := SelectObject(DC, Parent.EditFontHandle);
      try
        Item.DrawInterior(Parent.Canvas, ARect, ItemLink);
      finally
        if GetObjectType(PrevFont) = OBJ_FONT then
          SelectObject(DC, PrevFont);
      end;
    finally
      if ClipRgnExists then
        SelectClipRgn(DC, PrevClipRgn)
      else
        SelectClipRgn(DC, 0);
      DeleteObject(PrevClipRgn);
    end;
  end
  else
    FillRect(DC, ARect, Parent.BkBrush);
end;

function TdxBarEditControl.GetHeight: Integer;
begin
  Result := Parent.EditTextSize;
  if ShowCaption and (Result < Parent.TextSize) then
    Result := Parent.TextSize;
end;

function TdxBarEditControl.GetMinWidth: Integer;
begin
  Result := CaptionWidth + MinEditWidth;
end;

function TdxBarEditControl.GetWidth: Integer;
begin
  Result := CaptionWidth + ItemLink.Width;
end;

procedure TdxBarEditControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
var
  Selected: Boolean;
  R: TRect;
  DC: HDC;
begin
  if ARect.Left = ARect.Right then Exit;
  Selected := DrawSelected;
  R := ARect;
  DC := Parent.Canvas.Handle;
  DrawCaption(DC, R, PaintType, Selected);
  DrawBorder(DC, R, PaintType, Selected);
  if Enabled then WindowRect := R;
  if not Focused or not Enabled then
    DrawTextField(DC, R);
end;

procedure TdxBarEditControl.SetFocused(Value: Boolean);
begin
  if Value{Focused} then
    SendMessage(Handle, EM_SETREADONLY, WPARAM(ReadOnly or Item.EmptyWindow), 0);
  inherited;
end;

procedure TdxBarEditControl.SetText(Value: string);
begin
  inherited;
  if Flat then
    SendMessage(Handle, WM_COMMAND, MAKEWPARAM(0, EN_CHANGE), Handle);
  SendMessage(Handle, EM_SETSEL, 0, -1);
end;

procedure TdxBarEditControl.WidthChanged;
begin
  FParent.RepaintBar;
end;

procedure TdxBarEditControl.WndProc(var Message: TMessage);
var
  AHandle: HWND;
  RealItemLink: TdxBarItemLink;
begin
  with Message do
  begin
    if (Msg = WM_KEYDOWN) and ((wParam = VK_RETURN) or (wParam = VK_TAB)) then
    begin
      AHandle := Handle;
      RealItemLink := ItemLink.RealItemLink;
      if (RealItemLink <> nil) and (wParam = VK_RETURN) then
        RealItemLink.BringToTopInRecentList(True);
      Item.Text := Text;
      if not IsWindowVisible(AHandle) then Exit;
    end;
    if (Msg = WM_COMMAND) and (HiWord(wParam) = EN_CHANGE) and not FFocusing then
      Item.CurChange;
  end;
  inherited WndProc(Message);
end;

{ TCustomdxBarComboControl }

function TCustomdxBarComboControl.GetDropDownWindow: HWND;
begin
  Result := Item.DropDownWindow;
end;

function TCustomdxBarComboControl.GetItem: TCustomdxBarCombo;
begin
  Result := TCustomdxBarCombo(ItemLink.Item);
end;

procedure TCustomdxBarComboControl.ControlInactivate(Immediately: Boolean);
begin
  DroppedDown := False;
  inherited;
end;

procedure TCustomdxBarComboControl.GetArrowParams(APaintType: TdxBarPaintType;
  ASelected, ADroppedDown: Boolean; var ABrush: HBRUSH; var AArrowColor: COLORREF);
begin
  inherited;
  if Flat and (APaintType = ptMenu) and not ASelected then
    ABrush := Parent.ToolbarBrush;
end;

procedure TCustomdxBarComboControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
const
  Borders: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  Selected: Boolean;
  R, R1: TRect;
  DC: HDC;

  procedure DrawArrow(ARect: TRect);
  var
    Brush, SpaceBrush: HBRUSH;
    ArrowColor: COLORREF;
    X, Y, l_Size: Integer;
    P: array[1..3] of TPoint;
    Pen: HPEN;

    procedure DrawOneArrow(X, Y: Integer; Color: COLORREF);
    begin
      P[1] := Point(X, Y);
      P[2] := Point(X + l_Size - 1, Y);
      P[3] := Point(X + l_Size div 2, Y + l_Size div 2);
      Pen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(Color)));
      Brush := SelectObject(DC, GetSysColorBrush(Color));
      Polygon(DC, P, 3);
      SelectObject(DC, Brush);
      DeleteObject(SelectObject(DC, Pen));
    end;

  begin
    with ARect do
    begin
      Left := Right - Parent.ComboBoxArrowWidth;
      FDropDownButtonRect := ARect;

      GetArrowParams(PaintType, Selected, DroppedDown, Brush, ArrowColor);

      if Selected and Flat then
      begin
        InflateRect(ARect, 1, 1);
        FrameFlatSelRect(DC, ARect);
        InflateRect(ARect, -1, -1);
        FillRect(DC, ARect, Brush);
      end
      else
      begin
        if Selected and Enabled then
        begin
          DrawEdge(DC, ARect, Borders[DroppedDown], BF_RECT);
          SpaceBrush := Parent.BkBrush;
        end
        else
        begin
          if Enabled then
            SpaceBrush := GetSysColorBrush(COLOR_BTNHIGHLIGHT)
          else
            SpaceBrush := Parent.BkBrush;
          FrameRect(DC, ARect, SpaceBrush);
        end;
        FillRect(DC, Rect(Left - 1, Top, Left, Bottom), SpaceBrush);
        InflateRect(ARect, -1, -1);
        FillRect(DC, ARect, Brush);
        if DroppedDown then OffsetRect(ARect, 1, 1);
      end;

      with ARect do
      begin
        l_Size := (Right - Left) div 2;
        if not Odd(l_Size) then
         Inc(l_Size);
        X := (Left + Right - l_Size) div 2;
        Y := (Top + Bottom - l_Size div 2) div 2;
        if Enabled then
          DrawOneArrow(X, Y, ArrowColor)
        else
        begin
          if not Flat then
            DrawOneArrow(X + 1, Y + 1, COLOR_BTNHIGHLIGHT);
          DrawOneArrow(X, Y, COLOR_BTNSHADOW);
        end;
      end;
    end;
  end;

begin
  if ARect.Left = ARect.Right then Exit;
  Selected := DrawSelected;
  R := ARect;
  DC := Parent.Canvas.Handle;
  DrawCaption(DC, R, PaintType, Selected);
  DrawBorder(DC, R, PaintType, Selected);
  R1 := R;
  Dec(R1.Right, 1 + Parent.ComboBoxArrowWidth);
  if Enabled then WindowRect := R1;
  if not Enabled or not Focused or Item.EmptyWindow then
    DrawTextField(DC, R1);
  DrawArrow(R);
end;

procedure TCustomdxBarComboControl.SetDroppedDown(Value: Boolean);
var
  P: TPoint;
begin
  if (FDroppedDown <> Value) and not Item.ReadOnly then
  begin
    FDroppedDown := Value;
    Repaint;
    if FDroppedDown then
    begin
      with Parent.GetItemRect(Self), P do
        if Parent is TdxBarSubMenuControl or IsRealVertical(Parent) then
        begin
          X := Right;
          Y := Top;
        end
        else
        begin
          X := Left + CaptionWidth;
          Y := Bottom;
        end;
      ClientToScreen(Parent.Handle, P);
      Item.DropDown(P.X, P.Y);
    end
    else
      Item.CloseUp;
  end;
end;

procedure TCustomdxBarComboControl.WndProc(var Message: TMessage);
var
  Shift: TShiftState;
  AHandle: HWND;
  R: TRect;

  function LButtonDowned: Boolean;
  begin
    with Message do
      LButtonDowned := (Msg = WM_LBUTTONDOWN) or (Msg = WM_LBUTTONDBLCLK);
  end;

begin
  with Message do
    case Msg of
      WM_KEYDOWN, WM_KEYUP, WM_CHAR:
        begin
          Shift := KeyDataToShiftState(lParam);
          if (Msg = WM_KEYDOWN) and (wParam = VK_F4) then
          begin
            DroppedDown := not DroppedDown;
            Exit;
          end
          else
            if DroppedDown and (DropDownWindow <> 0) and
              Item.CheckKeyForDropDownWindow(wParam, Shift) then
            begin
              Result := SendMessage(DropDownWindow, Msg, wParam, lParam);
              Exit;
            end;
        end;
      WM_SYSKEYDOWN, WM_SYSKEYUP:
        begin
          Shift := KeyDataToShiftState(lParam);
          if ((wParam = VK_UP) or (wParam = VK_DOWN)) and (ssAlt in Shift) then
          begin
            if Msg = WM_SYSKEYDOWN then DroppedDown := not DroppedDown;
            Message.wParam := 0;
            Exit;
          end
        end;
    end;
  AHandle := Handle;
  inherited;
  if not IsWindowVisible(AHandle) then Exit;
  if LButtonDowned then FOnPressDroppedDown := DroppedDown;
  if not FOnPressDroppedDown and LButtonDowned or
    FOnPressDroppedDown and (Message.Msg = WM_LBUTTONUP) then
  begin
    R := DropDownButtonRect;
    if not Item.ShowEditor then R.Left := WindowRect.Left;
    MapWindowPoints(Parent.Handle, Handle, R, 2);
    if PtInRect(R, SmallPointToPoint(TSmallPoint(Message.lParam))) then
      DroppedDown := not DroppedDown;
  end;
end;

{ TdxBarComboControl }

function TdxBarComboControl.GetItem: TdxBarCustomCombo;
begin
  Result := TdxBarCustomCombo(ItemLink.Item);
end;

function TdxBarComboControl.GetItemIndex: Integer;
begin
  Result := Item.ItemIndex;
end;

function TdxBarComboControl.GetItems: TStrings;
begin
  Result := Item.Items;
end;

function TdxBarComboControl.GetSorted: Boolean;
begin
  Result := Item.Sorted;
end;

procedure TdxBarComboControl.SetLocalItemIndex(Value: Integer);
begin
  FLocalItemIndex := Value;
  if (0 <= FLocalItemIndex) and (FLocalItemIndex <= Items.Count - 1) then
    Text := Items[FLocalItemIndex]
  else
    Text := Item.Text;  
  if Item.EmptyWindow then Repaint;  
end;

procedure TdxBarComboControl.SetFocused(Value: Boolean);
begin
  FFocusing := True;
  try
    if Value then LocalItemIndex := ItemIndex;
  finally
    FFocusing := False;
  end;
  inherited;
end;

procedure TdxBarComboControl.WndProc(var Message: TMessage);
var
  Shift: TShiftState;
begin
  with Message do
    if Msg = WM_KEYDOWN then
      if (wParam = VK_RETURN) or (wParam = VK_TAB) then
        if (LocalItemIndex <> -1) and (Item.Items[LocalItemIndex] = Text) then
        begin
          Item.ItemIndex := LocalItemIndex;
          if not IsWindowVisible(Handle) then Exit;
        end
        else
      else
      begin
        Shift := KeyDataToShiftState(lParam);
        if not DroppedDown and ((wParam = VK_UP) or (wParam = VK_DOWN)) and (Shift = []) then
        begin
          if (wParam = VK_UP) and (LocalItemIndex > 0) then
            LocalItemIndex := LocalItemIndex - 1
          else
            if (wParam = VK_DOWN) and (LocalItemIndex < Items.Count - 1) then
              LocalItemIndex := LocalItemIndex + 1;
          Exit;
        end;
      end;
  inherited WndProc(Message);
end;

{ TdxBarSubItemControl }


var
  ABarSubItemTimer: TdxBarSubItemControl;
  ABarSubMenuTimerID: Integer;

procedure ActivateSubMenuTimerProc(Wnd: HWnd; Msg, TimerID, SysTime: Longint); stdcall;
begin
  try
    try
      if ABarSubItemTimer <> nil then
        ABarSubItemTimer.ControlActivate(True);
    finally
      KillTimer(0, ABarSubMenuTimerID);
      ABarSubItemTimer := nil;
    end;
  except
  end;
end;

procedure DeActivateSubMenuTimerProc(Wnd: HWnd; Msg, TimerID, SysTime: Longint); stdcall;
begin
  try
    try
      if ABarSubItemTimer <> nil then
        ABarSubItemTimer.ControlInActivate(True);
    finally
      KillTimer(0, ABarSubMenuTimerID);
      ABarSubItemTimer := nil;
    end;
  except
  end;
end;

destructor TdxBarSubItemControl.Destroy;
begin
  if ABarSubItemTimer = Self then
  begin
    ABarSubItemTimer := nil;
    KillTimer(0, ABarSubMenuTimerID);
  end;
  if (SubMenuControl <> nil) and not ItemLink.Item.IsDestroying then
    SubMenuControl.Hide;
  FIsActive := False;
  inherited Destroy;
end;

function TdxBarSubItemControl.GetCaptionOffset: Integer;
begin
  if Flat and (Parent as TdxBarControl).Bar.IsMainMenu then
    Result := 8
  else
    Result := -Parent.Canvas.Font.Height div 2;
end;

function TdxBarSubItemControl.GetItem: TCustomdxBarSubItem;
begin
  Result := TCustomdxBarSubItem(ItemLink.Item);
end;

procedure TdxBarSubItemControl.GlyphChanged;
begin
  Parent.RepaintBar;
end;

function TdxBarSubItemControl.GetSubMenuControl: TdxBarSubMenuControl;
begin
  if Item.ItemLinks = nil then
    Result := nil
  else
    Result := TdxBarSubMenuControl(Item.ItemLinks.BarControl);
end;

function TdxBarSubItemControl.CanClicked: Boolean;
begin
  Result := False;
end;

procedure TdxBarSubItemControl.ControlActivate(Immediately: Boolean);
var
  R: TRect;
  P: TPoint;
begin
//  if AnimatingSubMenu <> nil then Exit;
  if not HasSubMenu then Exit;

  if SubMenuControl <> nil then
    if (ItemLink.Item.CurItemLink = nil) or (Self = ItemLink.Item.CurItemLink.Control) then
    begin
      if ABarSubItemTimer = Self then
      begin
        ABarSubItemTimer := nil;
        KillTimer(0, ABarSubMenuTimerID);
      end;
      Exit;
    end
    else
      ItemLink.Item.CurItemLink.Control.ControlInActivate(True);

  inherited;
  if not Enabled and not BarManager.Designing then Exit;
  if Parent is TdxBarControl then
    if Parent.IsCustomizing or TdxBarControl(Parent).IsDowned then
      Immediately := True
    else
      Exit;
  if not Immediately and not BarManager.IsCustomizing then
  begin
    if ABarSubItemTimer <> nil then
    begin
      KillTimer(0, ABarSubMenuTimerID);
      try
        if ABarSubItemTimer.Parent <> Parent.ParentBar then
          ABarSubItemTimer.ControlInActivate(True);
      except
      end;
    end;
    ABarSubItemTimer := Self;
    ABarSubMenuTimerID := SetTimer(0, 0, dxBarWaitForSubMenuTime, @ActivateSubMenuTimerProc);
    Exit;
  end;
  Item.DoPopup;
  Item.DirectClick;
  DoCreateSubMenuControl;
  if SubMenuControl <> nil then
  begin
    R := FParent.GetItemRect(Self);
    if Parent is TdxBarSubMenuControl then
    begin
      P := Point(R.Right, R.Top - TdxBarSubMenuControl(Parent).BorderSize);
      SubMenuControl.OwnerWidth := R.Right - R.Left;
    end
    else
      if IsRealVertical(Parent) then
      begin
        P := Point(R.Right, R.Top);
        SubMenuControl.OwnerWidth := R.Right - R.Left;
      end
      else
      begin
        P := Point(R.Left, R.Bottom);
        SubMenuControl.OwnerHeight := R.Bottom - R.Top;
      end;
    SubMenuControl.FSubItem := Self;
    P := FParent.ClientToScreen(P);
    SubMenuControl.Left := P.X;
    SubMenuControl.Top := P.Y;
    Parent.ChildBar := SubMenuControl;
    SubMenuControl.ParentBar := Parent;
    if not (Parent is TdxBarSubMenuControl) then Repaint;
    SubMenuControl.FShowAnimation := FShowAnimation;
    FShowAnimation := False;
    SubMenuControl.Show;
    if Flat then Repaint;
  end;
end;

procedure TdxBarSubItemControl.ControlInactivate(Immediately: Boolean);
begin
//  if AnimatingSubMenu <> nil then Exit;
  if not HasSubMenu then Exit;

  if Parent is TdxBarControl then Immediately := True;

  if not Immediately and (ABarSubItemTimer = nil) and (Parent <> nil) and
    not Parent.IsDestroying and not BarManager.IsCustomizing then
  begin
    ABarSubItemTimer := Self;
    ABarSubMenuTimerID := SetTimer(0, 0, dxBarWaitForSubMenuTime, @DeActivateSubMenuTimerProc);
    Exit;
  end;
  if SubMenuControl <> nil then SubMenuControl.FSubItem := nil;
  inherited;
  if ABarSubItemTimer = Self then
  begin
    ABarSubItemTimer := nil;
    KillTimer(0, ABarSubMenuTimerID);
  end;
  if SubMenuControl <> nil then SubMenuControl.Hide;
  if not (Parent is TdxBarSubMenuControl) then Repaint;
  Item.DoCloseUp;
end;

procedure TdxBarSubItemControl.ControlClick(ByMouse: Boolean);
begin
  if SubMenuControl = nil then
  begin
    ControlActivate(True);
    if not ByMouse and (SubMenuControl <> nil) then
      with SubMenuControl do
        if ItemLinks.First <> nil then
          SetKeySelectedItem(ItemLinks.First.Control);
  end
  else
    if Parent.IsCustomizing or (BarManager.Style = bmsStandard) then
      ControlInactivate(True);
end;

procedure TdxBarSubItemControl.CreateSubMenuControl;
begin
  Item.ItemLinks.CreateBarControl;
end;

procedure TdxBarSubItemControl.DoCreateSubMenuControl;
begin
  CreateSubMenuControl;
  if HasShadow and (SubMenuControl <> nil) then
    SubMenuControl.OwnerBounds := Parent.GetItemScreenRect(Self);
end;

function TdxBarSubItemControl.GetDefaultHeight: Integer;
begin
  if Parent is TdxBarControl then
  begin
    if ImageExists or not Item.ShowCaption then
      if not IsVertical(Parent) then
        Result := BarManager.ButtonHeight
      else
        Result := BarManager.ButtonWidth
    else
      Result := 0;
    if (Result = 0) or Item.ShowCaption and (Result < Parent.TextSize) then
      Result := Parent.TextSize;
  end
  else
    Result := Parent.TextSize + Byte(Flat) * 2;
end;

function TdxBarSubItemControl.GetDefaultWidth: Integer;
begin
  with Parent.Canvas do
    if Parent is TdxBarSubMenuControl then
    begin
      Result := 2 * Parent.TextSize + 3 + TextWidth(GetTextOf(Caption));
      if Flat then Inc(Result, 2 + 1 + 6);
    end
    else
    begin
      if Item.ShowCaption then
        Result := TextWidth(GetTextOf(Caption))
      else
        Result := 0;
      if ImageExists or not Item.ShowCaption then
      begin
        if not IsVertical(Parent) then
          Inc(Result, BarManager.ButtonWidth)
        else
          Inc(Result, BarManager.ButtonHeight);
        if Item.ShowCaption then Inc(Result, 4);
      end
      else
        Inc(Result, 2 * CaptionOffset);
      if not TdxBarControl(Parent).Bar.IsMainMenu then
        Inc(Result, Parent.TextSize div 2);
    end;
end;

function TdxBarSubItemControl.GetHeight: Integer;
begin
  if IsVertical(Parent) then
    Result := GetDefaultWidth
  else
    Result := GetDefaultHeight;
end;

function TdxBarSubItemControl.GetOwnedBarControl: TCustomdxBarControl;
begin
  Result := SubMenuControl;
end;

function TdxBarSubItemControl.GetWidth: Integer;
begin
  if IsVertical(Parent) then
    Result := GetDefaultHeight
  else
    Result := GetDefaultWidth;
end;

function TdxBarSubItemControl.HasSubMenu: Boolean;
begin
  Result := True;
end;

function TdxBarSubItemControl.IsDestroyOnClick: Boolean;
begin
  Result := False;
end;

function TdxBarSubItemControl.IsExpandable: Boolean;
begin
  Result := True;
end;

procedure TdxBarSubItemControl.KeyDown(Key: Word);
begin
  inherited;
  case Key of
    VK_RIGHT: Click(False);
  end;
end;

procedure TdxBarSubItemControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
const
  Borders: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  R: TRect;
  Selected, Down: Boolean;
  DC: HDC;

  procedure DrawArrow;
  var
    l_Size: Integer;
  begin
    if PaintType = ptMenu then
      l_Size := Parent.MenuArrowHeight
    else
      l_Size := Parent.MenuArrowHeight - 1;
    with R do
      case PaintType of
        ptMenu:
          begin
            Left := Right - Parent.TextSize + l_Size;
            DrawLargeItemArrow(DC, R, atRight, l_Size, Selected and not Flat,
              Enabled, Flat);
          end;
        ptHorz:
          begin
            Left := Right - Parent.TextSize div 2 + Parent.Canvas.Font.Height div 2;
            DrawLargeItemArrow(DC, R, atDown, l_Size, False, Enabled, Flat);
          end;
        ptVert:
          begin
            Top := Bottom - Parent.TextSize div 2 + Parent.Canvas.Font.Height div 2;
            DrawLargeItemArrow(DC, R, atRight, l_Size, False, Enabled, Flat);
          end;
      end;
  end;

begin
  if ARect.Left = ARect.Right then Exit;
  R := ARect;
  Selected := DrawSelected;
  Down := IsActive and (SubMenuControl <> nil);
  DC := Parent.Canvas.Handle;
  with R do
    if PaintType = ptMenu then
    begin
      DrawGlyphAndTextInSubMenu(DC, R, Selected, True, False);
      DrawArrow;
    end
    else
    begin
      DrawGlyph(R, nil, PaintType, False, Selected, Down, False, False, False, True);

      if ImageExists or not Item.ShowCaption then
        if PaintType = ptHorz then
          Inc(Left, BarManager.ButtonWidth)
        else
          Inc(Top, BarManager.ButtonHeight)
      else
        if PaintType = ptHorz then
          Inc(Left, CaptionOffset)
        else
          Inc(Top, CaptionOffset);
      if Down and not Flat then OffsetRect(R, 1, 1);

      if Item.ShowCaption then
        DrawItemText(DC, Caption, R, DT_LEFT, Enabled, False,
          PaintType = ptVert, False, Flat);
      if not TdxBarControl(Parent).Bar.IsMainMenu then DrawArrow;
    end;
end;

function TdxBarSubItemControl.WantsDblClick: Boolean;
begin
  Result := inherited WantsDblClick and not BarManager.Designing;
end;

function TdxBarSubItemControl.WantsKey(Key: Word): Boolean;
begin
  Result := inherited WantsKey(Key) or
    (Parent is TdxBarSubMenuControl) and (Key = VK_RIGHT);
end;

{ TContainerItemSubMenuControl }

type
  TContainerItemSubMenuControl = class(TdxBarSubMenuControl)
  private
    FContainerItem: TCustomdxBarContainerItem;
  protected
    procedure DoCloseUp; override;
    function GetIsCustomizing: Boolean; override;
  public
    destructor Destroy; override;
  end;

destructor TContainerItemSubMenuControl.Destroy;
var
  AContainerItem: TCustomdxBarContainerItem;
begin
  AContainerItem := FContainerItem;
  inherited;
  AContainerItem.NeedClearItemList;
end;

procedure TContainerItemSubMenuControl.DoCloseUp;
begin
  with FContainerItem do
    DeleteListedItemLinks(ItemLinks, 0);
  inherited;
end;

function TContainerItemSubMenuControl.GetIsCustomizing: Boolean;
begin
  Result := False;
end;

{ TdxBarContainerItemControl }

function TdxBarContainerItemControl.GetItem: TCustomdxBarContainerItem;
begin
  Result := TCustomdxBarContainerItem(ItemLink.Item);
end;

procedure TdxBarContainerItemControl.CreateSubMenuControl;
begin
  if BarManager.IsCustomizing then Exit;
  Item.ItemLinks.FBarControl := TContainerItemSubMenuControl.Create(BarManager);
  SubMenuControl.FItemLinks := Item.ItemLinks;
  TContainerItemSubMenuControl(SubMenuControl).FContainerItem := Item;
  with Item do AddListedItemLinks(ItemLinks, 0, True, ItemLink);
end;

function TdxBarContainerItemControl.GetCaption: string;
begin
  Result := inherited GetCaption;
  if not ShowRealCaption then
    Result := '(' + Result + ')';
end;

function TdxBarContainerItemControl.IsExpandable: Boolean;
begin
  Result := not BarManager.IsCustomizing;
end;

procedure TdxBarContainerItemControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
var
  DC: HDC;
begin
  if PaintType = ptMenu then
  begin
    if ARect.Left = ARect.Right then Exit;
    DC := Parent.Canvas.Handle;
    DrawGlyphAndTextInSubMenu(DC, ARect, False, True, False);
  end
  else
    inherited;
end;

function TdxBarContainerItemControl.ShowRealCaption: Boolean;
begin
  Result := (Parent is TdxBarControl) or not Item.HideWhenRun;
end;

procedure RetrieveWindowsVersion;
var
  Info: TOSVersionInfo;
begin
  Info.dwOSVersionInfoSize := SizeOf(Info);
  GetVersionEx(Info);
  IsWin95Or98 := Info.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS;
  IsWin95 := IsWin95Or98 and (Info.dwMinorVersion = 0);
  IsWin98Or2000 :=
    (Info.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS) and (Info.dwMinorVersion <> 0) or
    (Info.dwPlatformId = VER_PLATFORM_WIN32_NT) and (Info.dwMajorVersion = 5);
end;

{DEFINE TRIAL}
{$IFDEF TRIAL}
var
  PeriodHasExpired: Boolean;
{$ENDIF}

initialization
  RetrieveWindowsVersion;
  FUser32DLL := LoadLibrary('USER32');
  if FUser32DLL > 32 then
  begin
    @TrackMouseEvent := GetProcAddress(FUser32DLL, 'TrackMouseEvent');
    @UpdateLayeredWindow := GetProcAddress(FUser32DLL, 'UpdateLayeredWindow');
  end;
  GetMem(AClassName, 256);
  dxBarManagerList := TdxBarManagerList.Create;
  InternalItemList := TList.Create;
  RefreshDeviceConsts;
  CreatePatternBrush;
  RegisterClass(TdxBarGroup);

  FRegItemList := TList.Create;
  FBarControls := TList.Create;

  dxBarRegisterItem(TdxBarButton, TdxBarButtonControl, True);
  dxBarRegisterItem(TdxBarEdit, TdxBarEditControl, True);
  dxBarRegisterItem(TCustomdxBarCombo, TCustomdxBarComboControl, True);
  dxBarRegisterItem(TdxBarCombo, TdxBarComboControl, True);
  dxBarRegisterItem(TdxBarSubItem, TdxBarSubItemControl, True);
  dxBarRegisterItem(TdxBarListItem, TdxBarContainerItemControl, True);
  dxBarRegisterItem(TdxBarContainerItem, TdxBarContainerItemControl, True);

  dxBarRegisterItem(TdxBarQuickCustExtButton, TdxBarQuickCustExtButtonControl, False);
  dxBarRegisterItem(TdxBarQuickCustItem, TdxBarQuickCustItemControl, False);

  dxBarRegisterItem(TSystemMenuSubItem, TSystemMenuSubItemControl, False);

  Screen.Cursors[crdxBarDrag] := LoadCursor(HInstance, 'DXBARDRAGCURSOR');
  Screen.Cursors[crdxBarDragCopy] := LoadCursor(HInstance, 'DXBARDRAGCOPYCURSOR');
  Screen.Cursors[crdxBarDragNoDrop] := LoadCursor(HInstance, 'DXBARDRAGNODROPCURSOR');
  Screen.Cursors[crdxBarEditSizing] := LoadCursor(HInstance, 'DXBAREDITSIZINGCURSOR');

{$IFDEF TRIAL}
  if FindWindow('TAppBuilder', nil) = 0 then Halt;
  PeriodHasExpired := False;
  with TRegistry.Create do
  try
    if OpenKey('\Software\Microsoft\Windows\CurrentVersion\Shell Extensions', True) then
      try
        if ValueExists('XB') then
          if Abs(Now - ReadDateTime('XB')) > 20 then
            PeriodHasExpired := True
          else
        else WriteDateTime('XB', Now);
      finally
        CloseKey;
      end
    else PeriodHasExpired := True;
  finally
    Free;
  end;
  if PeriodHasExpired then
  begin
    Application.MessageBox('Please visit www.devexpress.com to purchase your ' +
      'copy of the ExpressQuantumPack.', 'Information', MB_ICONEXCLAMATION);
    if Application.MainForm = nil then Halt;
  end;
{$ENDIF}

finalization
  dxBarUnregisterItem(TSystemMenuSubItem);

  dxBarUnregisterItem(TdxBarQuickCustItem);
  dxBarUnregisterItem(TdxBarQuickCustExtButton);

  dxBarUnregisterItem(TdxBarContainerItem);
  dxBarUnregisterItem(TdxBarListItem);
  dxBarUnregisterItem(TdxBarSubItem);
  dxBarUnregisterItem(TdxBarCombo);
  dxBarUnregisterItem(TCustomdxBarCombo);
  dxBarUnregisterItem(TdxBarEdit);
  dxBarUnregisterItem(TdxBarButton);

  FBarControls.Free;
  with FRegItemList do
  begin
    while Count > 0 do
    begin
      Dispose(PRegItemRecord(Last));
      Remove(Last);
    end;
    Free;
  end;

  DeleteObject(PatternBrush);
  InternalItemList.Free;
  dxBarManagerList.Free;
  dxBarManagerList := nil;
  FreeMem(AClassName, 256);
  if FUser32DLL > 32 then FreeLibrary(FUser32DLL);
end.

